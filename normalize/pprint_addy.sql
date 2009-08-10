CREATE OR REPLACE FUNCTION pprint_addy(a norm_addy, show_internal boolean) RETURNS text AS $$
  DECLARE
   ret text;
  BEGIN
   IF NOT a.parsed THEN
     RETURN NULL;
   END IF;
   ret:=array_to_string(ARRAY[a.address::text,upper(a.preDirAbbrev),initcap(a.preTypeAbbrev),initcap(a.preQualAbbrev),a.streetName,initcap(a.streetTypeAbbrev),upper(a.streetDirAbbrev),initcap(a.streetQualAbbrev)], ' '); 
   IF show_internal AND a.internal IS NOT NULL THEN
     ret := ret || ', ' || a.internal;
   END IF;
   IF  a.location IS NOT NULL THEN
    ret := ret || ', ' || a.location;
   END IF;
   IF a.stateAbbrev IS NOT NULL THEN
    ret := ret || ', ' || a.stateAbbrev;
   END IF;
   IF a.zip IS NOT NULL THEN
     IF a.zip4 IS NOT NULL THEN
      ret := ret || ' ' || a.zip || '-' || a.zip4;
     ELSE
      ret := ret || ' ' || a.zip;
     END IF;
   END IF;
  RETURN ret;
END;
$$ LANGUAGE plpgsql immutable strict;
CREATE OR REPLACE FUNCTION pprint_addy(a norm_addy) RETURNS text AS $$
  BEGIN
  RETURN pprint_addy(a, true);
  END;
$$ LANGUAGE plpgsql immutable strict;

DROP CAST(norm_addy as text) IF EXISTS;
CREATE CAST(norm_addy as text)  WITH FUNCTION pprint_addy(norm_addy);

COMMENT ON FUNCTION pprint_addy(a norm_addy) IS $$
returns a formatted version of the parsed address. 
Optional boolean as second argument tells whether or not
to include the 'internal' portion of the address (default true).
$$;
COMMENT ON FUNCTION pprint_addy(norm_addy, boolean) IS $$
returns a formatted version of the parsed address. 
Optional boolean as second argument tells whether or not
to include the 'internal' portion of the address (default true).
$$;

