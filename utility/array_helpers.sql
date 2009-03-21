set search_path=tiger,public;
DROP AGGREGATE IF EXISTS array_accum(anyelement) CASCADE;
CREATE AGGREGATE array_accum (anyelement)
(
    sfunc = array_append,
    stype = anyarray,
    initcond = '{}'
);

CREATE OR REPLACE FUNCTION array_sort (ANYARRAY)
RETURNS ANYARRAY
LANGUAGE SQL
AS $$
SELECT ARRAY(
    SELECT DISTINCT $1[s.i] AS "foo"
    FROM
        generate_series(array_lower($1,1), array_upper($1,1)) AS s(i)
    WHERE $1[s.i] IS NOT NULL
    ORDER BY foo DESC
);
$$ IMMUTABLE;


CREATE OR REPLACE FUNCTION array_compact(text[])
RETURNS text[]
LANGUAGE SQL
AS $$
SELECT ARRAY(
    SELECT $1[s.i] AS "foo"
    FROM
        generate_series(array_lower($1,1), array_upper($1,1)) AS s(i)
    WHERE $1[s.i] IS NOT NULL AND $1[s.i]<>''
    );
$$ IMMUTABLE;

