   set search_path=tiger,public;
   set client_min_messages = error;
  DROP TABLE IF EXISTS countysub_lookup cascade;
CREATE TABLE countysub_lookup AS
SELECT cs.statefp as statefp
     , sl.abbrev as state
     , cs.countyfp as countyfp
     , cl.name as county
     , cs.cousubfp as cousubfp
     , cs.name as name
  FROM cousub cs
  JOIN state_lookup sl
    ON (cs.statefp         = sl.statefp)
  JOIN county_lookup cl
    ON (
							 cs.statefp          = cl.statefp
					 AND cs.countyfp         = cl.countyfp
       )
 GROUP BY cs.statefp
     , sl.abbrev
     , cs.countyfp
     , cl.name
     , cs.cousubfp
     , cs.name;
CREATE INDEX countysub_lookup_name_idx
    ON countysub_lookup (soundex(name));
CREATE INDEX countysub_lookup_state_idx
    ON countysub_lookup (state);
CREATE INDEX countysub_lookup_statefp_idx
    ON countysub_lookup (statefp);
CREATE INDEX countysub_lookup_countyfp_idx
    ON countysub_lookup (countyfp);
CREATE INDEX countysub_lookup_cousubfp_idx
    ON countysub_lookup (cousubfp);
