set search_path=public,tiger;
set client_min_messages=error;

DROP TABLE IF EXISTS zip_state cascade;
CREATE TABLE zip_state 
( "zip" varchar(5), 
  "statefp" varchar(2),
  "place" varchar(28));
create index zip_state_zip_idx on zip_state using btree(zip);
create index zip_state_statefp_idx on zip_state using btree(statefp);

insert into zip_state SELECT zip,statefp,place from zip_lookup;
