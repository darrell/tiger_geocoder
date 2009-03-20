-- Runs the dmetaphone function on the last word in the string provided.
-- Words are allowed to be seperated by space, comma, period, new-line
-- tab or form feed.
CREATE OR REPLACE FUNCTION end_dmetaphone(VARCHAR) RETURNS VARCHAR
AS $_$
DECLARE
  tempString VARCHAR;
BEGIN
  tempString := substring($1, E'[ ,.\n\t\f]([a-zA-Z0-9]*)$');
  IF tempString IS NOT NULL THEN
    tempString := dmetaphone(tempString);
  ELSE
    tempString := dmetaphone($1);
  END IF;
  return tempString;
END;
$_$ LANGUAGE plpgsql;
