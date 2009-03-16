set search_path=public,tiger;
set client_min_messages=error;
DROP TABLE IF EXISTS countysub_lookup cascade;
CREATE TABLE countysub_lookup (
    statefp VARCHAR(2),
    state   VARCHAR(2),
    countyfp VARCHAR(3),
    county  VARCHAR(100),
    cousubfp VARCHAR(5),
    name    VARCHAR(100),
    PRIMARY KEY (statefp, countyfp, cousubfp)
);

INSERT INTO countysub_lookup
  SELECT
    cs.statefp           as statefp,
    sl.abbrev            as state,
    cs.countyfp          as countyfp,
    cl.name              as county,
    cs.cousubfp          as cousubfp,
    cs.name              as name
  FROM
    cousub cs
    JOIN state_lookup sl ON (cs.statefp = sl.statefp)
    JOIN county_lookup cl ON (cs.statefp = cl.statefp AND cs.countyfp = cl.countyfp)
  GROUP BY cs.statefp, sl.abbrev, cs.countyfp, cl.name, cs.cousubfp, cs.name;

CREATE INDEX countysub_lookup_name_idx ON countysub_lookup (soundex(name));
CREATE INDEX countysub_lookup_state_idx ON countysub_lookup (state);

