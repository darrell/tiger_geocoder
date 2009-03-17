   set search_path=tiger,public;
   set client_min_messages = error;
  DROP TABLE IF EXISTS place_lookup cascade;
CREATE TABLE
       place_lookup (
							 statefp VARCHAR(2), state VARCHAR(2), placefp VARCHAR(5), name VARCHAR(90), PRIMARY
							 KEY (statefp, placefp)
       );
INSERT INTO place_lookup
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
CREATE INDEX place_lookup_name_idx
    ON place_lookup (soundex(name));
CREATE INDEX place_lookup_state_idx
    ON place_lookup (state);
