set search_path=public,tiger;
set client_min_messages=error;
DROP TABLE IF EXISTS zip_lookup cascade;
CREATE TABLE zip_lookup (
    zip      VARCHAR(5),
    statefp  VARCHAR(2),
    state    VARCHAR(2),
    countyfp VARCHAR(3),
    county   VARCHAR(90),
    cousubfp VARCHAR(5),
    cousub   VARCHAR(90),
    placefp  VARCHAR(5),
    place    VARCHAR(90),
    cnt      INTEGER,
    PRIMARY KEY (zip)
);

INSERT INTO zip_lookup
  SELECT
    DISTINCT ON (zip)
    zip,
    statefp,
    state,
    countyfp,
    county,
    cousubfp,
    cousub,
    placefp,
    place,
    cnt
  FROM zip_lookup_all
  ORDER BY zip,cnt desc;
