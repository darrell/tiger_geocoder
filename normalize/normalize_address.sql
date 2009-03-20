-- normalize_address(addressString)
-- This takes an address string and parses it into address (internal/street)
-- street name, type, direction prefix and suffix, location, state and
-- zip code, depending on what can be found in the string.
--
-- The US postal address standard is used:
-- <Street Number> <Direction Prefix> <Street Name> <Street Type>
-- <Direction Suffix> <Internal Address> <Location> <State> <Zip Code>
--
-- State is assumed to be included in the string, and MUST be matchable to
-- something in the state_lookup table.  Fuzzy matching is used if no direct
-- match is found.
--
-- Two formats of zip code are acceptable: five digit, and five + 4.
--
-- The internal addressing indicators are looked up from the
-- secondary_unit_lookup table.  A following identifier is accepted
-- but it must start with a digit.
--
-- The location is parsed from the string using other indicators, such
-- as street type, direction suffix or internal address, if available.
-- If these are not, the location is extracted using comparisons against
-- the places_lookup table, then the countysub_lookup table to determine
-- what, in the original string, is intended to be the location.  In both
-- cases, an exact match is first pursued, then a word-by-word fuzzy match.
-- The result is not the name of the location from the tables, but the
-- section of the given string that corresponds to the name from the tables.
--
-- Zip codes and street names are not validated.
--
-- Direction indicators are extracted by comparison with the direction_lookup
-- table.
--
-- Street addresses are assumed to be a single word, starting with a number.
-- Address is manditory; if no address is given, and the street is numbered,
-- the resulting address will be the street name, and the street name
-- will be an empty string.
--
-- In some cases, the street type is part of the street name.
-- eg State Hwy 22a.  As long as the word following the type starts with a
-- number (this is usually the case) this will be caught.  Some street names
-- include a type name, and have a street type that differs.  This will be
-- handled properly, so long as both are given.  If the street type is
-- omitted, the street names included type will be parsed as the street type.
--
-- The output is currently a colon seperated list of values:
-- InternalAddress:StreetAddress:DirectionPrefix:StreetName:StreetType:
-- DirectionSuffix:Location:State:ZipCode
-- This returns each element as entered.  It's mainly meant for debugging.
-- There is also another option that returns:
-- StreetAddress:DirectionPrefixAbbreviation:StreetName:StreetTypeAbbreviation:
-- DirectionSuffixAbbreviation:Location:StateAbbreviation:ZipCode
-- This is more standardized and better for use with a geocoder.
CREATE OR REPLACE FUNCTION normalize_address(
    in_rawInput VARCHAR
) RETURNS norm_addy
AS $_$
DECLARE
  debug_flag boolean := false;
  result norm_addy;
  addressString VARCHAR;
  zipString VARCHAR;
  preDir VARCHAR;
  postDir VARCHAR;
  reducedStreet VARCHAR;
  streetType VARCHAR;
  stateString VARCHAR;
  tempString VARCHAR;
  tempString2 VARCHAR;
  tempInt INTEGER;
  rec RECORD;
  locationString TEXT;
  ws VARCHAR;
  rawInput VARCHAR;
  addrArray TEXT[];
  addrMatches TEXT[];
  streetElements TEXT[];
  addrArrayLen integer;
  stmt VARCHAR;
  stateExists boolean:= false;
  matchedSuffix boolean;
  matchedInternal boolean := false;
BEGIN
  result.parsed := FALSE;
  debug_flag := true;
  rawInput := trim(in_rawInput);

  IF rawInput IS NULL THEN
    RETURN result;
  END IF;

  ws := E'[ ,\t\n\f\r^]';

  IF debug_flag THEN
    raise notice 'input: %', rawInput;
  END IF;


  addrArray:=array_compact(regexp_split_to_array(rawInput,ws||'+'));
  addrArrayLen:=array_upper(addrArray,1);
  
  raise DEBUG 'split gives: %',addrArray ;

  -- Assume that the house number begins with a digit, and extract it from
  -- the first element. This does break some rurual addresses, which
  -- may not start with a digit.
  IF addrArray[1] ~ E'^\\d' THEN
    addressString := addrArray[1];
    addrArray:=addrArray[2:addrArrayLen];
    addrArrayLen:=addrArrayLen-1;
    raise DEBUG 'addrArray after address is now: %',addrArray ;
  END IF;
  raise DEBUG 'addressString: %', addressString;

  -- There are two formats for zip code, the normal 5 digit, and
  -- the nine digit zip-4.  It may also not exist.
  zipString := substring(addrArray[addrArrayLen] from E'(\\d{5}(|[-+]\\d{4}))$');
  --zipString := substring(rawInput from ws || E'(\\d{5}(|[-+]\\d{4}))$');
  IF zipString IS NOT NULL THEN
    result.zip:=substring(zipString, 1,5);
    IF length(zipString) > 5 THEN
      result.zip4:=substring(zipString, 7,4);
    END IF;
    result.parsed=true;
    raise DEBUG 'zipString: "%",zip: "%", zip4: "%"', zipString, result.zip,result.zip4;
    addrArrayLen:=addrArrayLen-1;
    addrArray:=addrArray[1:addrArrayLen];
    raise DEBUG 'addrArray after zip is now: %',addrArray ;
  END IF;

  -- iterate over the next three elements looking for the state
  -- (these are the longest)
  -- if  we don't find one, then we'll try to take it from the zipcode
  FOR anInt in REVERSE addrArrayLen..addrArrayLen-2 LOOP
    EXIT WHEN stateString IS NOT NULL;
    tempString :=array_to_string(addrArray[anInt:addrArrayLen], ' ');
    raise DEBUG 'anInt: %, tempString: %', anInt, tempString;
    rec := state_extract(tempString);
    raise DEBUG 'rec: %', rec;
    IF rec.stateAbbrev IS NOT NULL THEN
      stateString := rec.state;
      result.stateAbbrev := rec.stateAbbrev;
      addrArrayLen:=anInt-1;
      addrArray:=addrArray[1:addrArrayLen];
      raise DEBUG 'addrArray after state is now: %',addrArray ;
    END IF;
  END LOOP;
  -- remove state element
  
  IF rec.stateAbbrev IS NULL AND result.zip IS NOT NULL THEN
    -- get the state from the zipcodes, if we can
    tempInt := count(*) 
              FROM zip_lookup
              WHERE zip=result.zip;
    raise debug 'trying to get state from zip "%", tempInt: %', result.zip,tempInt;
    IF tempInt = 1 THEN
      result.stateAbbrev := "state" FROM zip_lookup WHERE "zip"="result"."zip";
    END IF;
  END IF;
  IF result.stateAbbrev IS NOT NULL THEN
    stateExists:=place.statefp IS NOT NULL 
                       FROM place,state 
                       WHERE state.stusps=result.stateAbbrev
                       AND place.statefp=state.statefp
                       LIMIT 1;
  END IF;
  raise DEBUG 'stateExists: %', stateExists;
  raise DEBUG 'result.stateAbbrev: %', result.stateAbbrev;
  raise DEBUG 'stateString: %', stateString;
  raise DEBUG 'addrArray after state and zip is now: %',addrArray ;
  
  -- now find the city (is 4 words a reasonable assumption here?)
  IF addrArray[1] IS NOT NULL THEN
    tempInt:=NULL;
  
    FOR anInt in REVERSE addrArrayLen..addrArrayLen-(least(3,addrArrayLen)) LOOP
      EXIT WHEN addrArray[anInt] ~* E'^\\d$'; -- short cut since no city should be numeric
      tempString :=array_to_string(addrArray[anInt:addrArrayLen], ' ');
      locationString:=location_extract(tempString, result.stateAbbrev);
      IF locationString IS NOT NULL THEN
        addrMatches[anInt]:=locationString;
        tempInt:=anInt; -- store the largest # of elements matched
        RAISE DEBUG 'tempInt: % with % is now bigger', tempInt,locationString;
      END IF;
      raise DEBUG 'tempString: %, locationString: %', tempString,locationString;
    END LOOP;
    -- take the longest match
    -- hopefully this will catch things like:
    -- 123 somestreet East San Gabriel as being in "East San Gabriel"
    -- not on street 123 somestreet east. *because* the East is likely
    -- to be full spelled out, and we haven't tried to adjust for that yet
    -- if searches for is on 123 somestreet, E San Gabriel, we're probably
    -- screwed.
    IF tempInt IS NOT NULL THEN
      result.location:=addrMatches[tempInt];
      addrArrayLen := tempInt-1;
      addrArray := addrArray[1:addrArrayLen];
    ELSE
      result.location:=NULL;
    END IF;
    raise DEBUG 'addrArray after location is now: %',addrArray ;
  END IF;
  -- FIXME: in the case where we have just
  -- a street and zip (e.g. 123 Something, 12345), and
  -- there happens to be a place named 'Something' in that state,
  -- we will not match the street because we think it's a place. 
  -- I'm not sure a good way to work
  -- around this.
  -- if we can't find a city, then we'll work from the front of the remaining
  -- elements to match a street. Whatever is left should be the location.
  
  -- move forward now with each element
  -- first is the predir, which can be a variant found in
  -- the direction table.
  -- predir can be two words (i.e. 1234 south west somestreet)
  IF addrArray[1] IS NOT NULL THEN
    tempInt:=0; -- used to determine if we used both words
    stmt:=$$ SELECT abbrev FROM 
                    direction_lookup as dl,predirabrv_lookup as pd
                    WHERE dl.abbrev ilike pd.predirabrv
                    AND dl.name ilike $$ || quote_literal(addrArray[1]);
  
    IF stateExists THEN
      stmt:= stmt || ' AND pd.state='||quote_literal(result.stateAbbrev);
    END IF;
    stmt:=stmt || ' LIMIT 1';
    --raise debug 'stmt is: %', stmt;
  
    EXECUTE stmt INTO tempString;
    -- try two words
    IF length(tempString)=1 THEN -- maybe there's a second part
     stmt:=$$ SELECT abbrev FROM 
                      direction_lookup as dl,predirabrv_lookup as pd
                      WHERE dl.abbrev ilike pd.predirabrv
                      AND dl.name ilike $$ || quote_literal(addrArray[2]);

      IF stateExists THEN
        stmt:= stmt || ' AND pd.state='||quote_literal(result.stateAbbrev);
      END IF;
      stmt:=stmt || ' LIMIT 1';
      --raise debug 'stmt is: %', stmt;
      EXECUTE stmt INTO tempString2;
      IF length(tempString2)=1  THEN -- we can only append one letter
        tempInt:=1;
        tempString:=tempString||tempString2;
      END IF;
    END IF; 

    raise debug 'predir is: %', tempString;
    IF tempString IS NOT NULL THEN
      result.predirabbrev:=tempString;
      addrArray := addrArray[2+tempInt:addrArrayLen];
      addrArrayLen:=array_upper(addrArray,1);
      raise DEBUG 'addrArray after predir is now: %',addrArray ;
    END IF;
  END IF;
  -- next we look for the pretype
  -- some types are two word, but seems to only
  -- be a few. If we find one of these, then just append and remove it.
  -- Note, there is also 'I-' which is for interstates,
  -- and with which we do not cope.
  IF addrArray[1] IS NOT NULL THEN
    IF UPPER(addrArray[2]) IN ('HWY','RD','RTE') THEN
      addrArray[2]:=addrArray[1]|| ' ' || addrArray[2];
      addrArray:=addrArray[2:addrArrayLen];
      addrArrayLen:=addrArrayLen-1;
      raise DEBUG 'addrArray after pretype1 is now: %',addrArray ;
    END IF;

    stmt:=$$ SELECT abbrev FROM 
                    street_type_lookup as st,pretypabrv_lookup as pt
                    WHERE st.abbrev ilike pt.pretypabrv
                    AND st.name ILIKE $$ || quote_literal(addrArray[1]);
  
    IF stateExists THEN
      stmt:= stmt || ' AND pt.state='||quote_literal(result.stateAbbrev);
    END IF;
    stmt:=stmt || ' LIMIT 1';
    --raise debug 'stmt is: %', stmt;
  
    EXECUTE stmt INTO tempString;
    raise debug 'pretyp is: %', tempString;
    IF tempString IS NOT NULL THEN
      result.pretypeabbrev:=tempString;
      addrArray := addrArray[2:addrArrayLen];
      addrArrayLen:=addrArrayLen-1;
      raise DEBUG 'addrArray after pretype2 is now: %',addrArray ;
    END IF;
  END IF;
  raise DEBUG 'addrArray after pretype is now: %',addrArray ;
  
  -- do prequal. these don't to anything, but are just
  -- taken from the list of possible matches.
  IF addrArray[1] IS NOT NULL THEN
    stmt:=$$ SELECT prequalabr FROM 
                    prequalabr_lookup as pq
                    WHERE pq.prequalabr ILIKE $$  || quote_literal(addrArray[1]);
  
    IF stateExists IS NOT NULL THEN
      stmt:= stmt || ' AND pq.state='||quote_literal(result.stateAbbrev);
    END IF;
    stmt:=stmt || ' LIMIT 1';
    --raise debug 'stmt is: %', stmt;
  
    EXECUTE stmt INTO tempString;
    raise debug 'prequalabrv is: %', tempString;
    IF tempString IS NOT NULL THEN
      result.prequalabbrev:=tempString;
      addrArray := addrArray[2:addrArrayLen];
      addrArrayLen:=array_upper(addrArray,1);
    END IF;
  END IF;
  RAISE DEBUG 'addrArray after prequal is now: %',addrArray ;


  IF addrArray[1] IS NOT NULL THEN
    -- now add things to street until we match one of
    -- suf*
    -- if we have multiple matches, use the last one
    -- XXX this would be a good place to not be discarding
    -- the comma information if at all possible, so
    -- we can match street names that actually end in
    -- a word that could be a suffix.
    FOR element IN reverse addrArrayLen..1 LOOP
      tempInt:=element;
      matchedSuffix:=true;
      EXIT WHEN addrArray[element] ILIKE ANY (SELECT name from suffixes_lookup );
      -- thus, matchedSuffix will be false if we get to the end
      -- of the loop and have never matched.
      matchedSuffix:=false;
      --addrMatches:=array_append(streetElements,addrArray[element]);
      --raise DEBUG 'streetElements is now: %',streetElements;
      --raise DEBUG 'addrArray: %',addrArray;
    END LOOP;
    RAISE DEBUG 'tempInt for street is %', tempInt;
    
    IF matchedSuffix THEN
      result.streetName:=array_to_string(addrArray[1:tempInt-1], ' ');
      raise DEBUG 'streetName is: %', result.streetName;
      addrArray := addrArray[tempInt:addrArrayLen];
      addrArrayLen:=array_upper(addrArray,1);
    ELSE
      -- do we match something that's like an internal part?
      -- and do we have a location? if yes, then we can
      -- assume that our address is everything up to
      -- the internal part (handled below)
      -- if we have a location and no internal part,
      -- then we just everything and assume it's the street name
      matchedInternal:=addrArray && array_accum(upper(name))::text[] from secondary_unit_lookup;
      IF result.location  IS NOT NULL AND matchedInternal THEN
      result.streetName:='';
        FOR anInt IN 1..addrArrayLen LOOP
          -- this is always 1 because we're shrinking the array as we go
          EXIT WHEN name IS NOT NULL FROM secondary_unit_lookup WHERE addrArray[1] ILIKE name;
          result.streetName:=result.streetName|| ' '||addrArray[1];
          addrArray:=addrArray[2:addrArrayLen];
        END LOOP;
        result.streetName:=trim(result.streetName);
      ELSIF result.location IS NOT NULL THEN
        result.streetName=array_to_string(addrArray, ' ');
        addrArray:='{}'::text[]; -- is there a better way to do this?
        addrArrayLen:=0;
        RAISE DEBUG 'assuming street is all remaining';
      ELSE
        raise WARNING 'no match for a street name??';
      END IF;
    END IF;
      
  END IF;
  addrArrayLen:=array_upper(addrArray,1);
  raise DEBUG 'addrArray after streetName is now: %',addrArray ;
  --
  -- now we look for the final elements, note that the order 
  -- is slightly different than for the pre* elements.

  IF matchedSuffix THEN -- slight optimization
     -- suftyp
     -- we don't have the same of two word issue (except for "Landing Strp")
     -- that we did with the pretyp
     IF addrArray[1] IS NOT NULL THEN
       stmt:=$$ SELECT abbrev FROM 
                       street_type_lookup as st,suftypabrv_lookup as pt
                       WHERE st.abbrev ilike pt.suftypabrv
                       AND st.name ILIKE $$ || quote_literal(addrArray[1]);

       IF stateExists THEN
         stmt:= stmt || ' AND pt.state='||quote_literal(result.stateAbbrev);
       END IF;
       stmt:=stmt || ' LIMIT 1';
       raise debug 'stmt is: %', stmt;

       EXECUTE stmt INTO tempString;
       raise debug 'suftyp is: %', tempString;
       IF tempString IS NOT NULL THEN
         result.streettypeabbrev:=tempString;
         addrArray := addrArray[2:addrArrayLen];
         addrArrayLen:=addrArrayLen-1;
         raise DEBUG 'addrArray after suftyp is now: %',addrArray ;
       END IF;
      END IF;
      IF addrArray[1] IS NOT NULL THEN
       -- sufdir as predir above
        stmt:=$$ SELECT abbrev FROM 
                        direction_lookup as dl,sufdirabrv_lookup as sd
                        WHERE dl.abbrev ilike sd.sufdirabrv
                        AND dl.name ilike $$ || quote_literal(addrArray[1]);

        IF stateExists THEN
          stmt:= stmt || ' AND sd.state='||quote_literal(result.stateAbbrev);
        END IF;
        stmt:=stmt || ' LIMIT 1';
        --raise debug 'stmt is: %', stmt;

        EXECUTE stmt INTO tempString;
        raise debug 'sufdir is: %', tempString;
        IF tempString IS NOT NULL THEN
          result.streetdirabbrev:=tempString;
          addrArray := addrArray[2:addrArrayLen];
          addrArrayLen:=addrArrayLen-1;
        END IF;
      END IF;
      raise DEBUG 'addrArray after sufdir is now: %',addrArray ;

     -- FIXME: we should have a lookup table like
     -- direction and street_types appropriate to the suffixes
     -- sufqual as prequal above.
     IF addrArray[1] IS NOT NULL THEN
       stmt:=$$ SELECT sufqualabr FROM 
                       sufqualabr_lookup as pq
                       WHERE pq.sufqualabr ILIKE $$  || quote_literal(addrArray[1]);

       IF stateExists THEN
         stmt:= stmt || ' AND pq.state='||quote_literal(result.stateAbbrev);
       END IF;
       stmt:=stmt || ' LIMIT 1';
       --raise debug 'stmt is: %', stmt;

       EXECUTE stmt INTO tempString;
       raise debug 'sufqualabrv is: %', tempString;
       IF tempString IS NOT NULL THEN
         result.streetqualabbrev:=tempString;
         addrArray := addrArray[2:addrArrayLen];
         addrArrayLen:=addrArrayLen-1;
       END IF;
     END IF;
     raise DEBUG 'addrArray after sufqual is now: %',addrArray ;
  END IF; -- matchedSuffix

  
  -- remove apt, suite, etc...
  -- anything left is our location, if we didn't match
  -- otherwise, raise a notice
  IF addrArray[1] IS NOT NULL THEN
    tempInt:=count(*) FROM secondary_unit_lookup as s WHERE
      addrArray[1] ILIKE s.name;
    IF tempInt=1 THEN
    -- we found an internal part, if we have a location,
    -- then the entire remaining fields should be our
    -- internal part. If we don't have a location, then
    -- assume that only the next field is part of the
    -- internal
      IF result.location IS NOT NULL THEN
        result.internal:=array_to_string(addrArray, ' ');
        addrArray:='{}'::text[];
      ELSE
        result.internal:=array_to_string(addrArray[1:2], ' ');
        addrArray := addrArray[3:addrArrayLen];
        addrArrayLen:=array_upper(addrArray,1);
      END IF;
      RAISE DEBUG 'result.internal: %', result.internal;
    END IF;
  END IF;
  RAISE DEBUG 'addrArray after internal is now: %',addrArray ;
  
  -- finally, if we have no street or location,
  -- then append whatever is left, and if that
  -- doesn't work, try pulling it from the zip if we
  -- have one.
  IF addrArray<>'{}'::text[] THEN
    tempString:=array_to_string(addrArray, ' ');
    IF result.streetname IS NULL THEN
      result.streetname:=tempString;
      addrArray:='{}'::text[];
    ELSIF result.location IS NULL  THEN
      result.location:=array_to_string(addrArray, ' ');
      addrArray:='{}'::text[];
    ELSE
      RAISE WARNING 'normalize_address: These components were not parsed: %', addrArray;
    END IF;
    RAISE DEBUG 'addrArray after last ditch matching is now: %',addrArray ;
  END IF;

  IF result.location IS NULL AND result.zip is NOT NULL THEN
    result.location:= coalesce(place,countysub,countyfull) 
      FROM zip_lookup WHERE result.zip ilike zip_lookup.zip;
  END IF;

  -- i'm not sure this is the right thing to do... they may not all be numeric
  result.address := to_number(addressString, '99999999999');
  result.parsed := TRUE;
  RETURN result;
END
$_$ LANGUAGE plpgsql STABLE strict;
