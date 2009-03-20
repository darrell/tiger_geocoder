   set search_path=tiger,public;
   set client_min_messages = error;
  DROP TABLE IF EXISTS place_lookup cascade;
CREATE TABLE
       place_lookup AS
SELECT pl.statefp as statefp
     , sl.abbrev as state
     , pl.placefp as placefp
     , pl.name as name
  FROM place pl
  JOIN state_lookup sl
    ON (pl.statefp         = sl.statefp)
 GROUP BY pl.statefp
     , sl.abbrev
     , pl.placefp
     , pl.name;
CREATE INDEX place_lookup_metaphonename_idx
    ON place_lookup using btree(metaphone(name,6));
CREATE INDEX place_lookup_name_idx
    ON place_lookup using btree(name);
CREATE INDEX place_lookup_state_idx
    ON place_lookup using btree(state);
