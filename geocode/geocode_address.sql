set search_path=tiger,public;
-- geocode(cursor, address, directionPrefix, streetName,
-- streetTypeAbbreviation, directionSuffix, location, stateAbbreviation,
-- zipCode)
CREATE OR REPLACE FUNCTION geocode_address(
    parsed NORM_ADDY,
    OUT ADDY NORM_ADDY,
    OUT GEOMOUT GEOMETRY,
    OUT RATING INTEGER
) RETURNS SETOF RECORD
AS $_$
DECLARE
  results RECORD;
  zip_info RECORD;
  stmt VARCHAR;
  in_statefp VARCHAR;
  exact_street boolean := false;
BEGIN
  IF parsed.streetName IS NULL THEN
    -- A street name must be given.  Think about it.
    RETURN;
  END IF;

  ADDY.internal := parsed.internal;

  in_statefp := statefp FROM state_lookup as state WHERE state.abbrev = parsed.stateAbbrev;

  -- There are a couple of different things to try, from the highest preference and falling back
  -- to lower-preference options.
  -- We start out with zip-code matching, where the zip code could possibly be in more than one
  -- state.  We loop through each state its in.
  -- Next, we try to find the location in our side-table, which is based off of the 'place' data
  -- Next, we look up the location/city and use the zip code which is returned from that
  -- Finally, if we didn't get a zip code or a city match, we fall back to just a location/street
  -- lookup to try and find *something* useful.
  -- In the end, we *have* to find a statefp, one way or another.
  FOR zip_info IN
    SELECT statefp,location,zip,column1 as exact,min(pref) FROM
    (SELECT zip_state.statefp as statefp,parsed.location as location,ARRAY[zip_state.zip] as zip,1 as pref
        FROM zip_state WHERE zip_state.zip = parsed.zip AND (in_statefp IS NULL OR zip_state.statefp = in_statefp)
      UNION SELECT zip_state.statefp,parsed.location,array_accum(zip_state.zip),2
              FROM zip_state
             WHERE zip_state.statefp = in_statefp
                   AND soundex(parsed.location) = soundex(zip_state.place)
             GROUP BY zip_state.statefp,parsed.location
      UNION SELECT zip_lookup_base.statefp,parsed.location,array_accum(zip_lookup_base.zip),3
              FROM zip_lookup_base
             WHERE zip_lookup_base.statefp = in_statefp
                         AND (soundex(parsed.location) = soundex(zip_lookup_base.city) OR soundex(parsed.location) = soundex(zip_lookup_base.county))
             GROUP BY zip_lookup_base.statefp,parsed.location
      UNION SELECT in_statefp,parsed.location,NULL,4) as a
      JOIN (VALUES (true),(false)) as b on TRUE
      WHERE statefp IS NOT NULL
      GROUP BY statefp,location,zip,column1 ORDER BY 4 desc, 5, 3
  LOOP

    stmt := 'SELECT DISTINCT ON (sub.predirabrv,sub.name,sub.suftypabrv,sub.sufdirabrv,coalesce(p.name,zip.city,cs.name,co.name),s.abbrev,sub.zip)'
         || '    sub.predirabrv   as fedirp,'
         || '    sub.name         as fename,'
         || '    sub.suftypabrv   as fetype,'
         || '    sub.sufdirabrv   as fedirs,'
         || '    coalesce(p.name,zip.city,cs.name,co.name)::varchar as place,'
         || '    s.abbrev as state,'
         || '    sub.zip as zip,'
         || '    interpolate_from_address(' || coalesce(quote_literal(parsed.address),'NULL') || ', to_number(sub.fromhn,''99999999'')::integer,'
         || '        to_number(sub.tohn,''99999999'')::integer, e.the_geom) as address_geom,'
         || coalesce('    sub.sub_rating + coalesce(levenshtein_ignore_case(' || quote_literal(zip_info.zip[1]) || ', sub.zip),0)',
                     '    sub.sub_rating + coalesce(levenshtein_ignore_case(' || quote_literal(parsed.location) || ', coalesce(p.name,zip.city,cs.name,co.name)),0)',
                     'sub.sub_rating')
         || '    as sub_rating,'
         || '    sub.exact_address as exact_address'
         || ' FROM ('
         || '  SELECT tlid, predirabrv, name, suftypabrv, sufdirabrv, fromhn, tohn, side, statefp, zip, rate_attributes(' || coalesce(quote_literal(parsed.preDirAbbrev),'NULL') || ', a.predirabrv,'
         || '    ' || coalesce(quote_literal(parsed.streetName),'NULL') || ', a.name, ' || coalesce(quote_literal(parsed.streetTypeAbbrev),'NULL') || ','
         || '    a.suftypabrv, ' || coalesce(quote_literal(parsed.streetDirAbbrev),'NULL') || ','
         || '    a.sufdirabrv) + '
         || '    CASE '
         || '        WHEN ' || coalesce(quote_literal(parsed.address),'NULL') || ' IS NULL OR b.fromhn IS NULL THEN 20'
         || '        WHEN ' || coalesce(quote_literal(parsed.address),'NULL') || ' >= least(to_number(b.fromhn,''99999999''),to_number(b.tohn,''99999999''))'
         || '            AND ' || coalesce(quote_literal(parsed.address),'NULL') || ' <= greatest(to_number(b.fromhn,''99999999''),to_number(b.tohn,''99999999''))'
         || '            AND (' || coalesce(quote_literal(parsed.address),'NULL') || ' % 2) = (to_number(b.fromhn,''99999999'') % 2)'
         || '            THEN 0'
         || '        WHEN ' || coalesce(quote_literal(parsed.address),'NULL') || ' >= least(to_number(b.fromhn,''99999999''),to_number(b.tohn,''99999999''))'
         || '            AND ' || coalesce(quote_literal(parsed.address),'NULL') || ' <= greatest(to_number(b.fromhn,''99999999''),to_number(b.tohn,''99999999''))'
         || '            THEN 2'
         || '        ELSE'
         || '            ((1.0 - '
         ||              '(least(' || coalesce(quote_literal(parsed.address || '.0'),'NULL') || ',to_number(b.fromhn,''99999999''),to_number(b.tohn,''99999999'')) /'
         ||              ' greatest(' || coalesce(quote_literal(parsed.address || '.0'),'NULL') || ',to_number(b.fromhn,''99999999''),to_number(b.tohn,''99999999'')))'
         ||              ') * 5)::integer + 5'
         || '        END'
         || '    as sub_rating,'
         ||       coalesce(quote_literal(parsed.address),'NULL') || ' >= least(to_number(b.fromhn,''99999999''),to_number(b.tohn,''99999999''))'
         || '            AND ' || coalesce(quote_literal(parsed.address),'NULL') || ' <= greatest(to_number(b.fromhn,''99999999''),to_number(b.tohn,''99999999''))'
         || '            AND (' || coalesce(quote_literal(parsed.address),'NULL') || ' % 2) = (to_number(b.fromhn,''99999999'') % 2)'
         || '    as exact_address'
         || '  FROM featnames a join addr b using (tlid,statefp)'
         || '  WHERE'
         || '        statefp = ' || quote_literal(zip_info.statefp) || ''
         || coalesce('    AND b.zip IN (''' || array_to_string(zip_info.zip,''',''') || ''') ','')
         || CASE WHEN zip_info.exact
                 THEN '    AND lower(' || coalesce(quote_literal(parsed.streetName),'NULL') || ') = lower(a.name)'
                 ELSE '    AND soundex(' || coalesce(quote_literal(parsed.streetName),'NULL') || ') = soundex(a.name)'
            END
         || '  ORDER BY 11'
         || '  LIMIT 20'
         || '    ) AS sub'
         || '  JOIN edges e ON (' || quote_literal(zip_info.statefp) || ' = e.statefp AND sub.tlid = e.tlid)'
         || '  JOIN state_lookup s ON (' || quote_literal(zip_info.statefp) || ' = s.statefp)'
         || '  JOIN faces f ON (' || quote_literal(zip_info.statefp) || ' = f.statefp AND (e.tfidl = f.tfid OR e.tfidr = f.tfid))'
         || '  LEFT JOIN zip_lookup_base zip ON (sub.zip = zip.zip)'
         || '  LEFT JOIN place p ON (' || quote_literal(zip_info.statefp) || ' = p.statefp AND f.placefp = p.placefp)'
         || '  LEFT JOIN county co ON (' || quote_literal(zip_info.statefp) || ' = co.statefp AND f.countyfp = co.countyfp)'
         || '  LEFT JOIN cousub cs ON (' || quote_literal(zip_info.statefp) || ' = cs.statefp AND cs.cosbidfp = sub.statefp || co.countyfp || f.cousubfp)'
         || ' WHERE'
         || '  (sub.side = ''L'' and e.tfidl = f.tfid) OR (sub.side = ''R'' and e.tfidr = f.tfid)'
         || ' ORDER BY 1,2,3,4,5,6,7,9'
         || ' LIMIT 10'
         ;
    -- If we got an exact street match then when we hit the non-exact
    -- set of tests, just drop out.
    IF NOT zip_info.exact AND exact_street THEN
        RETURN;
    END IF;

    FOR results IN EXECUTE stmt LOOP

       RAISE DEBUG 'stmt: %', stmt;

      -- If we found a match with an exact street, then don't bother
      -- trying to do non-exact matches
      IF zip_info.exact THEN
        exact_street := true;
      END IF;

      IF results.exact_address THEN
        ADDY.address := parsed.address;
      ELSE
        ADDY.address := NULL;
      END IF;

      ADDY.preDirAbbrev     := results.fedirp;
      ADDY.streetName       := results.fename;
      ADDY.streetTypeAbbrev := results.fetype;
      ADDY.streetDirAbbrev    := results.fedirs;
      ADDY.location         := results.place;
      ADDY.stateAbbrev      := results.state;
      ADDY.zip              := results.zip;
      ADDY.parsed := TRUE;

      GEOMOUT := results.address_geom;
      RATING := results.sub_rating;

      RETURN NEXT;

      -- If we get an exact match, then just return that
      IF RATING = 0 THEN
        RETURN;
      END IF;

    END LOOP;

  END LOOP;

  RETURN;
END;
$_$ LANGUAGE plpgsql STABLE STRICT;
