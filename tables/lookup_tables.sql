set search_path=tiger,public;
set client_min_messages = error; 

\i secondary_unit_lookup.sql 
\i state_lookup.sql 
\i county_lookup.sql 
\i countysub_lookup.sql 
\i roads_local.sql 
\i direction_lookup.sql 
\i street_type_lookup.sql 

\i place_lookup.sql 

\i zip_lookup_all.sql
\i zip_lookup_base.sql 
\i zip_lookup.sql 
\i zip_state.sql

\i address_part_lookups.sql
\i suffixes_lookup.sql
\i street_type_lookup.sql
