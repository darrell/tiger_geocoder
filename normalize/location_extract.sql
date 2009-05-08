-- location_extract(streetAddressString, stateAbbreviation)
-- This function extracts a location name from the end of the given string.
-- The first attempt is to find an exact match against the place
-- table.  If this fails, a word-by-word dmetaphone match is tryed against the
-- same table.  If multiple candidates are found, the one with the smallest
-- levenshtein distance from the given string is assumed the correct one.
-- If no match is found against the place table, the same tests are
-- run against the cousub table.
--
-- The section of the given string corresponding to the location found is
-- returned, rather than the string found from the tables.  All the searching
-- is done largely to determine the length (words) of the location, to allow
-- the intended street name to be correctly identified.
CREATE OR REPLACE FUNCTION location_extract(street_array TEXT[], stateAbbrev TEXT, exact BOOLEAN) RETURNS TEXT
AS $_$
DECLARE
  statefp VARCHAR;
  stmt VARCHAR;
  rec RECORD;
  tempString VARCHAR;
BEGIN
  raise DEBUG 'entering location_extract, street_array: %, stateAbbrev: %', street_array, stateAbbrev;

  IF array_upper(street_array,1) IS NULL THEN
    RETURN NULL;
  END IF;

  IF stateAbbrev IS NOT NULL THEN
    SELECT quote_literal(state.statefp) INTO statefp FROM state WHERE state.stusps = stateAbbrev;
  END IF;

  tempString := quote_literal(lower(array_to_string(street_array,' ')));

  stmt := ' SELECT'
       || '   1,'
       || '   name,'
       || '   levenshtein_ignore_case(' || tempString || ',name) as rating,'
       || '   length(name) as len'
       || ' FROM place'
       || ' WHERE ' || coalesce('statefp = ' || statefp || ' AND ','')
       || CASE WHEN NOT exact THEN
          '   metaphone(' || tempString || ', 6) = metaphone(name,6)'
       || '   AND levenshtein_ignore_case(' || tempString || ',name) <= 2 '
          ELSE tempString || ' = lower(name)' END
       || ' UNION ALL SELECT'
       || '   2,'
       || '   name,'
       || '   levenshtein_ignore_case(' || tempString || ',name) as rating,'
       || '   length(name) as len'
       || ' FROM cousub'
       || ' WHERE ' || coalesce('statefp = ' || statefp || ' AND ','')
       || CASE WHEN NOT exact THEN
          '   metaphone(' || tempString || ',6) = metaphone(name,6)'
       || '   AND levenshtein_ignore_case(' || tempString || ',name) <= 2 '
          ELSE tempString || ' = lower(name)' END
       || ' ORDER BY '
       || '   3 ASC, 1 ASC, 4 DESC'
       || ' LIMIT 1;'
       ;

  EXECUTE stmt INTO rec;

  raise DEBUG 'location_extract: result: %', rec;

  RETURN rec.name;
END;
$_$ LANGUAGE plpgsql STABLE STRICT;
