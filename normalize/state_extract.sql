-- state_extract(addressStringLessZipCode)
-- Extracts the state from end of the given string.
--
-- This function uses the state_lookup table to determine which state
-- the input string is indicating.  First, an exact match is pursued,
-- and in the event of failure, a word-by-word fuzzy match is attempted.
--
-- The result is the state as given in the input string, and the approved
-- state abbreviation, seperated by a colon.
CREATE OR REPLACE FUNCTION state_extract(rawInput VARCHAR, OUT state text, OUT stateAbbrev text) 
RETURNS record
AS $_$
DECLARE
  tempInt INTEGER;
  tempString VARCHAR;
  tempRec record;
  result VARCHAR;
  rec RECORD;
  test BOOLEAN;
  ws VARCHAR;
BEGIN
  ws := E'[ ,.\t\n\f\r]';

  -- Separate out the last word of the state, and use it to compare to
  -- the state lookup table to determine the entire name, as well as the
  -- abbreviation associated with it.  The zip code may or may not have
  -- been found, so strip off things that are not the state
  --tempString := rtrim(rawInput, E' ,\t\n\f\r0123456789-');
  --tempString := substring(tempString from E'[^ ,\t\n\f\r0123456789-]*?$');
  
  tempString := rawInput;
  -- first look for exact match
  raise DEBUG 'state_lookup: tempString: %', tempString;
  SELECT INTO tempRec abbrev,name,count(*) FROM state_lookup
    WHERE tempString ilike abbrev
       OR tempString ilike gpoabbrev
       OR tempString ilike altabbrev
       GROUP BY abbrev,name;
  IF tempRec.count = 1 THEN
    raise debug 'state_lookup: found exact match on tempString: %', tempString;
    stateAbbrev := upper(tempRec.abbrev);
    -- preserve the string we were passed.
    state:=tempString;
  END IF;

  -- no exact match. this is a rather complicated way to
  -- match on possible multi-word state names(?)
  IF stateAbbrev IS NULL THEN
    SELECT INTO tempInt count(*) 
       FROM state_lookup 
      WHERE name ilike '%' || tempString;
    IF tempInt >= 1 THEN
      FOR rec IN SELECT name,abbrev
                 FROM state_lookup
                 WHERE name ilike '%' || tempString LOOP
        SELECT INTO test rawInput ~* name 
           FROM  state_lookup
          WHERE  rec.name = name;
        raise debug 'state_lookup: test: %,rec.name: %', test,rec.name;
        IF test THEN
          stateAbbrev=rec.abbrev;
          -- save the returned string so we can strip it from
          -- our input back in normalize_address
          state := substring(rawInput, '(?i)' || rec.name);
          EXIT;
        END IF;
      END LOOP;
    END IF;
  END IF;

  -- No direct match for state name, so perform fuzzy match.
  IF stateAbbrev IS NULL THEN
      SELECT INTO tempInt count(*) FROM state_lookup
          WHERE soundex(tempString) = end_soundex(name);
      IF tempInt >= 1 THEN
        FOR rec IN SELECT name, abbrev FROM state_lookup
            WHERE soundex(tempString) = end_soundex(name) LOOP
          tempInt := count_words(rec.name);
          tempString := get_last_words(rawInput, tempInt);
          test := TRUE;
          FOR i IN 1..tempInt LOOP
            IF soundex(split_part(tempString, ' ', i)) !=
               soundex(split_part(rec.name, ' ', i)) THEN
              test := FALSE;
            END IF;
          END LOOP;
          IF test THEN
            state := tempString;
            stateAbbrev := rec.abbrev;
            EXIT;
          END IF;
        END LOOP;
    END IF;
  END IF;

  RAISE DEBUG 'state_lookup returning state: %, stateAbbrev: %', state,stateAbbrev;
  RETURN;
END;
$_$ LANGUAGE plpgsql;
