-- This function take two arguements.  The first is the "given string" and
-- must not be null.  The second arguement is the "compare string" and may
-- or may not be null.  If the second string is null, the value returned is
-- 3, otherwise it is the levenshtein difference between the two.
CREATE OR REPLACE FUNCTION nullable_levenshtein(VARCHAR, VARCHAR) RETURNS INTEGER
AS $_$
DECLARE
  given_string VARCHAR;
  result INTEGER := 3;
  verbose BOOLEAN := FALSE;
BEGIN
  IF $1 IS NULL THEN
    IF verbose THEN
      RAISE NOTICE 'nullable_levenshtein - given string is NULL!';
    END IF;
    RETURN NULL;
  ELSE
    given_string := $1;
  END IF;

  IF $2 IS NOT NULL AND $2 != '' THEN
    result := levenshtein_ignore_case(given_string, $2);
  END IF;

  RETURN result;
END
$_$ LANGUAGE plpgsql IMMUTABLE;
