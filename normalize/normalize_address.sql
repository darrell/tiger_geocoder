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
-- Direction indicators are extracted by comparison with the directional_lookup
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
set search_path=tiger,public;
CREATE OR REPLACE FUNCTION normalize_address(
    in_rawInput TEXT
) RETURNS norm_addy
AS $_$
DECLARE
  expand_non_dirs BOOLEAN := false;
  result norm_addy;
  addressString TEXT;
  zipString TEXT;
  stateString TEXT;
  tempString TEXT;
  foundInt INTEGER;
  locationString TEXT;
  ws TEXT;
  rawInput TEXT;
  addrArray TEXT[];
  addrArrayLen INTEGER;
  lookupRec RECORD;
BEGIN
  result.parsed := FALSE;
  rawInput := trim(in_rawInput);

  IF rawInput IS NULL THEN
    RETURN result;
  END IF;

  ws := E'[ ,\t\n\f\r^]';

  raise debug 'input: %', rawInput;

  addrArray := array_compact(regexp_split_to_array(rawInput,ws||'+'));
  addrArrayLen := array_upper(addrArray,1);

  raise DEBUG 'split gives: %', addrArray;

  IF addrArrayLen IS NULL THEN
    RETURN result;
  END IF;

  -- strip off funny stuff (periods).  We dont want to split on them really tho.
  FOR anInt IN 1..addrArrayLen LOOP
    IF addrArray[anInt] ~ E'(^\.)|(\.$)' THEN
        addrArray[anInt] := trim(addrArray[anInt],'.');
    END IF;
  END LOOP;

  -- Assume that the house number begins with a digit, and extract it from
  -- the first element. This does break some rurual addresses, which
  -- may not start with a digit.
  IF addrArrayLen > 1 AND addrArray[1] ~ E'^[A-Z]*[-]*\\d' THEN
    addressString := addrArray[1];
    addrArray := addrArray[2:addrArrayLen];
    addrArrayLen := addrArrayLen-1;

    raise DEBUG 'addrArray after address is now: %', addrArray ;
  END IF;

  raise DEBUG 'addressString: %', addressString;

  -- There are two formats for zip code, the normal 5 digit, and
  -- the nine digit zip-4.  It may also not exist.
  zipString := substring(addrArray[addrArrayLen] from E'(\\d{5}(|[-+]\\d{4}))$');
  IF zipString IS NOT NULL THEN
    result.zip := substring(zipString,1,5);

    IF length(zipString) > 5 THEN
      result.zip4 := substring(zipString, 7,4);
    END IF;

    raise DEBUG 'zipString: "%",zip: "%", zip4: "%"', zipString, result.zip,result.zip4;

    addrArrayLen := addrArrayLen-1;
    addrArray := addrArray[1:addrArrayLen];

    raise DEBUG 'addrArray after zip is now: %',addrArray ;
  END IF;

  raise DEBUG 'addrArray: %, addrArrayLen: %', addrArray, addrarraylen;

  -- drop out if we're done
  IF addressString IS NULL AND addrArrayLen = 0 THEN
    result.parsed := TRUE;
    RETURN result;
  END IF;

  -- Look for the state abbrev, how many people type out a state name?
  -- if they do, we try to grab it below
  FOR anInt IN REVERSE addrArrayLen..1 LOOP
    EXIT WHEN stateString IS NOT NULL;
    raise DEBUG 'looking for state in "%"', addrArray[anInt];
    -- SELECT stusps INTO tempString
    --                FROM state
    --                WHERE stusps=addrArray[anInt];
    SELECT abbrev INTO tempString
                   FROM state_lookup
                    WHERE addrArray[anInt] ILIKE replace(abbrev,'.','')
                      OR addrArray[anInt] ILIKE replace(gpoabbrev,'.','')
                      OR addrArray[anInt] ILIKE replace(altabbrev,'.','');
    raise DEBUG 'tempString is "%", len %',tempString, length(tempString);

    IF length(tempString) > 0 THEN
      stateString := tempString;
      result.stateAbbrev := stateString;
      addrArrayLen := anInt-1;
      addrArray := addrArray[1:addrArrayLen];
    END IF;
  END LOOP;
  raise DEBUG 'addrArray after state1 is now: %',addrArray ;
  --
  --   -- drop out if we're done
  IF addressString IS NULL AND addrArrayLen = 0 THEN
    result.parsed := TRUE;
    RETURN result;
  END IF;

  IF result.stateAbbrev IS NULL AND result.zip IS NOT NULL THEN
    -- get the state from the zipcodes, if we can
    SELECT state INTO tempString
              FROM zip_lookup WHERE zip = result.zip;

    IF FOUND THEN
      result.stateAbbrev := tempString;
    END IF;
  END IF;

  IF result.stateAbbrev IS NULL THEN
    -- SEEMS TO GIVE TOO MANY FALSE POSITIVES
    --
    -- Alright, try the hard(er) ways to figure out the state, if we can..
    -- FOR anInt IN 1..addrArrayLen LOOP
    --   EXIT WHEN result.stateAbbrev IS NOT NULL;
    --   SELECT abbrev, array_upper(regexp_split_to_array(name,' '),1) AS len INTO lookupRec
    --                FROM state_lookup
    --                WHERE name ~ lower('(' || array_to_string(addrArray[anInt:addrArrayLen],')(| ') || ')$')
    --                ORDER BY length(name) DESC
    --                LIMIT 1;
    --
    --   raise DEBUG 'anInt: %, tempString: %', anInt, tempString;
    --
    --   IF FOUND THEN
    --     raise DEBUG 'matched state on %',lower('(' || array_to_string(addrArray[anInt:addrArrayLen],')(| ') || ')$');
    --     stateString := lookupRec.abbrev;
    --     result.stateAbbrev := stateString;
    --     addrArrayLen := anInt-1;
    --     addrArray := addrArray[1:addrArrayLen];
    --
    --     raise DEBUG 'addrArray after state2 is now: %',addrArray ;
    --   END IF;
    -- END LOOP;

    IF result.stateAbbrev IS NULL THEN
      FOR anInt IN 1..addrArrayLen LOOP
        EXIT WHEN result.stateAbbrev IS NOT NULL;

        SELECT abbrev, array_upper(regexp_split_to_array(name,' '),1) as len INTO lookupRec
                     FROM state_lookup
                     WHERE dmetaphone(name) = dmetaphone(array_to_string(addrArray[anInt:addrArrayLen],' '))
                     ORDER BY levenshtein_ignore_case(name,array_to_string(addrArray[anInt:addrArrayLen],' ')), length(name) DESC
                     LIMIT 1;

        raise DEBUG 'anInt: %, tempString: %', anInt, tempString;

        IF FOUND THEN
          stateString := lookupRec.abbrev;
          result.stateAbbrev := stateString;
          addrArrayLen := anInt-1;
          addrArray := addrArray[1:addrArrayLen];

          raise DEBUG 'addrArray after state3 is now: %',addrArray ;
        END IF;
      END LOOP;
    END IF;
  END IF;

  -- drop out if we're done
  IF addressString IS NULL AND addrArrayLen = 0 THEN
    result.parsed := TRUE;
    RETURN result;
  END IF;

  raise DEBUG 'result.stateAbbrev: %', result.stateAbbrev;
  raise DEBUG 'stateString: %', stateString;
  raise DEBUG 'addrArray after state and zip is now: %',addrArray ;

  -- now find the city
  -- take the longest match
  -- hopefully this will catch things like:
  -- 123 somestreet East San Gabriel as being in "East San Gabriel"
  -- not on street 123 somestreet east. *because* the East is likely
  -- to be full spelled out, and we haven't tried to adjust for that yet
  -- if searches for is on 123 somestreet, E San Gabriel, we're probably
  -- screwed.
  FOR anInt in 1..addrArrayLen LOOP
    EXIT WHEN result.location IS NOT NULL;

    locationString := location_extract(addrArray[anInt:addrArrayLen], result.stateAbbrev, true);

    IF locationString IS NOT NULL THEN
      result.location := locationString;
      addrArrayLen := anInt-1;
      addrArray := addrArray[1:addrArrayLen];
    END IF;

    raise DEBUG 'tempString: %, locationString: %', tempString,locationString;
  END LOOP;

  raise DEBUG 'addrArray after location extract: %, len: %', addrArray, addrArrayLen;

  -- drop out if we're done
  IF addressString IS NULL AND addrArrayLen = 0 THEN
    result.parsed := TRUE;
    RETURN result;
  END IF;

  -- Look for internal address components that we don't want
  -- this is simple currently since we don't have any multi-word secondary units
  FOR anInt in REVERSE addrArrayLen..1 LOOP
    EXIT WHEN result.internal IS NOT NULL;
    SELECT abbrev INTO tempString FROM secondary_unit_lookup
                  WHERE name ilike addrArray[anInt];

    -- If we found one, then dump everything from it to the end into internal
    IF FOUND THEN
        result.internal := array_to_string(addrArray[anInt:addrArrayLen],' ');
        raise DEBUG 'found internal of "%"', result.internal;
        addrArrayLen := anInt-1;
        addrArray := addrArray[1:addrArrayLen];
    END IF;
  END LOOP;

  -- FIXME: in the case where we have just
  -- a street and zip (e.g. 123 Something, 12345), and
  -- there happens to be a place named 'Something' in that state,
  -- we will not match the street because we think it's a place.
  -- I'm not sure a good way to work around this.
  -- if we can't find a city, then we'll work from the front of the remaining
  -- elements to match a street. Whatever is left should be the location.

  -- move forward now with each element
  -- first is the predir, which can be a variant found in
  -- the direction table.
  -- predir can be two words (i.e. 1234 south west somestreet)

  -- this must be anchored to the front..
  SELECT abbrev, array_upper(regexp_split_to_array(name,' '),1) as len INTO lookupRec
                FROM directional_lookup
                WHERE name ~ lower('^(' || array_to_string(addrArray,')(| ') || ')$')
                ORDER BY length(name) DESC
                LIMIT 1;

  IF FOUND THEN
    -- we need to check for an oddball special case.
    -- if we have two directionals back-to-back at this
    -- point which don't correspond to an actual legit
    -- directional, then chances are neither one are!
    -- I could go either way on this.. :/
    IF expand_non_dirs
       AND lookupRec.len = 1
       AND addrArray[lookupRec.len+1] IS NOT NULL
       AND lower(addrArray[lookupRec.len+1]) IN (SELECT name FROM directional_lookup) THEN
      SELECT name INTO tempString
               FROM feat_dirs WHERE abbrev = lookupRec.abbrev and spanish IS NULL;
      addrArray[lookupRec.len] := tempString;
    ELSE
      result.predirabbrev := lookupRec.abbrev;
      addrArray := addrArray[lookupRec.len+1:addrArrayLen];
      addrArrayLen := addrArrayLen-lookupRec.len;
    END IF;
  END IF;

  raise DEBUG 'addrArray after predir is now: %, len: %', addrArray, addrArrayLen;

  -- next we look for the pretype
  -- some types are two word, but seems to only
  -- be a few. If we find one of these, then just append and remove it.
  -- There is also 'I-' which is for interstates,
  -- which are handled elsewhere using special cases.

  SELECT abbrev, array_upper(regexp_split_to_array(name,' '),1) as len INTO lookupRec
                FROM street_type_lookup
                WHERE name ~ lower('^(' || array_to_string(addrArray,')(| ') || ')$')
                  AND pretype
                ORDER BY length(name) DESC
                LIMIT 1;

  IF FOUND THEN
    result.pretypeabbrev := lookupRec.abbrev;
    addrArray := addrArray[lookupRec.len+1:addrArrayLen];
    addrArrayLen := addrArrayLen-lookupRec.len;
  END IF;

  raise DEBUG 'addrArray after pretype is now: %, len: %', addrArray, addrArrayLen;

  -- do prequal. these don't to anything, but are just
  -- taken from the list of possible matches.

  SELECT abbrev, array_upper(regexp_split_to_array(name,' '),1) as len INTO lookupRec
                FROM qualabrv_lookup
                WHERE name ~ lower('^(' || array_to_string(addrArray,')(| ') || ')$')
                  AND prequal
                ORDER BY length(name) DESC
                LIMIT 1;

  IF FOUND THEN
    result.prequalabbrev := lookupRec.abbrev;
    addrArray := addrArray[lookupRec.len+1:addrArrayLen];
    addrArrayLen := addrArrayLen-lookupRec.len;
  END IF;

  raise DEBUG 'addrArray after prequal is now: %, len: %', addrArray, addrArrayLen;

  -- find the street, hopefully using the suffix
  -- but streets can sometimes include things which look like suffixes
  -- so we keep looking for suffixes in case there are some later.  We already
  -- removed any internal items, and a suffix doesn't look like a directional
  -- so hopefully we won't get screwed.
  FOR anInt IN 1..addrArrayLen LOOP

    SELECT abbrev, array_upper(regexp_split_to_array(name,' '),1) as len INTO lookupRec
                 FROM street_type_lookup
                 WHERE name ~ lower('^(' || array_to_string(addrArray[anInt:addrArrayLen],')(| ') || ')$')
                   AND suftype
                 ORDER BY length(name) DESC
                 LIMIT 1;

    IF FOUND THEN
      result.streettypeabbrev := lookupRec.abbrev;
      foundInt := anInt;
    END IF;
  END LOOP;

  IF result.streettypeabbrev IS NOT NULL THEN
    -- Grab the street, if there is something there...
    IF foundInt > 1 THEN
      result.streetName := array_to_string(addrArray[1:foundInt-1],' ');
    ELSE
      -- If we found a suffix, but are missing a street, we need to steal one
      IF result.prequalabbrev IS NOT NULL THEN
        result.streetName := result.prequalabbrev;
        result.prequalabbrev := NULL;
      ELSIF result.pretypeabbrev IS NOT NULL THEN
        result.streetName := result.pretypeabbrev;
        result.pretypeabbrev := NULL;
      ELSIF result.predirabbrev IS NOT NULL THEN
        result.streetName := result.predirabbrev;
        result.predirabbrev := NULL;
      END IF;
    END IF;
    addrArray := addrArray[foundInt+1:addrArrayLen];
    addrArrayLen := addrArrayLen-foundInt;
  END IF;

  raise DEBUG 'addrArray after street/suffix is now: %, len: %',addrArray, addrArrayLen;

  -- find the street if necessary, and any suffix directional bits
  FOR anInt IN 1..addrArrayLen LOOP
    EXIT WHEN result.streetdirabbrev IS NOT NULL;

    SELECT abbrev, array_upper(regexp_split_to_array(name,' '),1) as len INTO lookupRec
                 FROM directional_lookup
                 WHERE name ~ lower('^(' || array_to_string(addrArray[anInt:addrArrayLen],')(| ') || ')$')
                 ORDER BY length(name) DESC
                 LIMIT 1;
    IF FOUND THEN
      -- If we didn't find the street before, this should be it now
      IF result.streetName IS NULL THEN
        result.streetName := array_to_string(addrArray[1:anInt-1],' ');
      END IF;

      result.streetdirabbrev := lookupRec.abbrev;
      addrArray := addrArray[anInt+1:addrArrayLen];
      addrArrayLen := addrArrayLen-anInt;
    END IF;
  END LOOP;

  raise DEBUG 'addrArray after sufdir is now: %, len: %', addrArray, addrArrayLen;

  -- find the street if necessary, and any suffix qualifier bits
  FOR anInt IN 1..addrArrayLen LOOP
    EXIT WHEN result.streetqualabbrev IS NOT NULL;

    SELECT abbrev, array_upper(regexp_split_to_array(name,' '),1) as len INTO lookupRec
                 FROM qualabrv_lookup
                 WHERE name ~ lower('^(' || array_to_string(addrArray[anInt:addrArrayLen],')(| ') || ')$')
                   AND sufqual
                 ORDER BY length(name) DESC
                 LIMIT 1;

    IF FOUND THEN
      -- If we didn't find the street before, this should be it now
      IF result.streetName IS NULL THEN
        result.streetName := array_to_string(addrArray[1:anInt-1],' ');
      END IF;

      result.streetqualabbrev := lookupRec.abbrev;
      addrArray := addrArray[anInt+1:addrArrayLen];
      addrArrayLen := addrArrayLen-anInt;
    END IF;
  END LOOP;

  raise DEBUG 'addrArray after sufqual is now: %, len: %', addrArray, addrArrayLen;

  raise DEBUG 'result so far: %', result;

  -- try for an in-exact match on location now
  FOR anInt in 1..addrArrayLen LOOP
    EXIT WHEN result.location IS NOT NULL;

    locationString := location_extract(addrArray[anInt:addrArrayLen], result.stateAbbrev, false);

    IF locationString IS NOT NULL THEN
      result.location := locationString;
      addrArrayLen := anInt-1;
      addrArray := addrArray[1:addrArrayLen];
    END IF;

    raise DEBUG 'tempString: %, locationString: %', tempString,locationString;
  END LOOP;

  -- streets can look like other things.  If we found something that we thought
  -- wasn't a street at some point, but we never found an actual *street*, then swap
  -- whatever was most likely to be a street into the street
  -- we really need a street...
  IF result.streetName IS NULL THEN
    -- Special case for interstates
    IF addressString ~ E'^I-[0-9]\+$' THEN
        result.pretypeabbrev := 'I-';
        result.streetName := substring(addressString,3);
        addressString := NULL;
    ELSIF addrArray[1] ~ E'^I-[0-9]\+$' THEN
        result.pretypeabbrev := 'I-';
        result.streetName := substring(addrArray[1],3);
        addrArrayLen := 0;
        addrArray := '{}';
    -- If we found a suffix, but are missing a street, we need to steal one
    ELSIF result.prequalabbrev IS NOT NULL THEN
      result.streetName := result.prequalabbrev;
      result.prequalabbrev := NULL;
    ELSIF result.pretypeabbrev IS NOT NULL THEN
      result.streetName := result.pretypeabbrev;
      result.pretypeabbrev := NULL;
    ELSIF result.predirabbrev IS NOT NULL THEN
      result.streetName := result.predirabbrev;
      result.predirabbrev := NULL;
    ELSIF result.streettypeabbrev IS NOT NULL THEN
      result.streetName := result.streettypeabbrev;
      result.streettypeabbrev := NULL;
    ELSIF result.streetdirabbrev IS NOT NULL THEN
      result.streetName := result.streetdirabbrev;
      result.streetdirabbrev := NULL;
    ELSIF result.streetqualabbrev IS NOT NULL THEN
      result.streetName := result.streetqualabbrev;
      result.streetqualabbrev := NULL;
    END IF;
  END IF;

  -- handle interstates
  IF result.streetName ~ E'^I-[0-9]\+$' THEN
    result.pretypeabbrev := 'I-';
    result.streetName := substring(result.streetName,3);
  END IF;

  IF result.location IS NULL AND result.zip is NOT NULL THEN
    SELECT coalesce(place,countysub,countyfull) INTO result.location
                       FROM zip_lookup
                      WHERE result.zip = zip_lookup.zip;
  END IF;

  -- everything else goes into internal
  result.internal := array_to_string(addrArray, ' ');
  -- might want to change to text
  result.address := to_number(addressString, '99999999999');

  result.parsed := TRUE;

  RETURN result;
END
$_$ LANGUAGE plpgsql STABLE strict;
