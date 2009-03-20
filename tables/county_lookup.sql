      set search_path=tiger,public;
      set client_min_messages = error;
     DROP TABLE IF EXISTS county_lookup cascade;
   CREATE TABLE
          county_lookup AS
   SELECT co.statefp as statefp
        , sl.abbrev as state
        , co.countyfp as countyfp
        , co.name as name
        , co.namelsad as namelsad
     FROM county co
     JOIN state_lookup sl
       ON (co.statefp         = sl.statefp)
    GROUP BY co.statefp
        , sl.abbrev
        , co.countyfp
        , co.name
        , co.namelsad; 
   CREATE INDEX county_lookup_name_idx
       ON county_lookup (soundex(name));
   CREATE INDEX county_lookup_state_idx
       ON county_lookup (state);
