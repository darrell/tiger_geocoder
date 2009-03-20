CREATE OR REPLACE FUNCTION pprint_addy(
    input NORM_ADDY
) RETURNS VARCHAR
AS $_$
DECLARE
  result VARCHAR;
BEGIN
  IF NOT input.parsed THEN
    RETURN NULL;
  END IF;

  result := cull_null(input.address::text)
         || CASE WHEN input.preDirAbbrev IS NOT NULL THEN ' ' ELSE '' END
         || cull_null(upper(input.preDirAbbrev))
         || CASE WHEN input.preTypeAbbrev IS NOT NULL THEN ' ' ELSE '' END
         || cull_null(initcap(input.preTypeAbbrev))
         || CASE WHEN input.preQualAbbrev IS NOT NULL THEN ' ' ELSE '' END
         || cull_null(initcap(input.preQualAbbrev))
         || CASE WHEN input.streetName IS NOT NULL THEN ' ' ELSE '' END
         || cull_null(initcap(input.streetName))
         || CASE WHEN input.streetTypeAbbrev IS NOT NULL THEN ' ' ELSE '' END
         || cull_null(initcap(input.streetTypeAbbrev))
         || CASE WHEN input.streetDirAbbrev IS NOT NULL THEN ' ' ELSE '' END
         || cull_null(upper(input.streetDirAbbrev))
         || CASE WHEN input.streetQualAbbrev IS NOT NULL THEN ' ' ELSE '' END
         || cull_null(initcap(input.streetQualAbbrev))
         || CASE WHEN
              input.address IS NOT NULL OR
              input.streetName IS NOT NULL
              THEN ', ' ELSE '' END
         || cull_null(initcap(input.internal))
         || CASE WHEN input.internal IS NOT NULL THEN ', ' ELSE '' END
         || cull_null(initcap(input.location))
         || CASE WHEN input.location IS NOT NULL THEN ', ' ELSE '' END
         || cull_null(upper(input.stateAbbrev))
         || CASE WHEN input.stateAbbrev IS NOT NULL THEN ' ' ELSE '' END
         || cull_null(input.zip);

  RETURN trim(result);

END;
$_$ LANGUAGE plpgsql IMMUTABLE STRICT;
