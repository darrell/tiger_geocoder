   set search_path       = tiger, public;
  DROP TABLE IF EXISTS predirabrv_lookup;
CREATE TABLE predirabrv_lookup as (
		SELECT DISTINCT predirabrv, abbrev as state
		  from featnames, state_lookup
		 where featnames.statefp = state_lookup.statefp
		   and predirabrv is not null
		 order by abbrev, predirabrv
       );
  DROP TABLE IF EXISTS prequalabr_lookup;
CREATE TABLE prequalabr_lookup as (
		SELECT DISTINCT prequalabr, abbrev as state
		  from featnames, state_lookup
		 where featnames.statefp = state_lookup.statefp
		   and prequalabr is not null
		 order by abbrev, prequalabr
       );
  DROP TABLE IF EXISTS pretypabrv_lookup;
CREATE TABLE pretypabrv_lookup as (
		SELECT DISTINCT pretypabrv, abbrev as state
		  from featnames, state_lookup
		 where featnames.statefp = state_lookup.statefp
		   and pretypabrv is not null
		 order by abbrev, pretypabrv
       );
  DROP TABLE IF EXISTS sufdirabrv_lookup;
CREATE TABLE sufdirabrv_lookup as (
		SELECT DISTINCT sufdirabrv, abbrev as state
		  from featnames, state_lookup
		 where featnames.statefp = state_lookup.statefp
		   and sufdirabrv is not null
		 order by abbrev, sufdirabrv
       );
  DROP TABLE IF EXISTS sufqualabr_lookup;
CREATE TABLE sufqualabr_lookup as (
		SELECT DISTINCT sufqualabr, abbrev as state
		  from featnames, state_lookup
		 where featnames.statefp = state_lookup.statefp
		   and sufqualabr is not null
		 order by abbrev, sufqualabr
       );
  DROP TABLE IF EXISTS suftypabrv_lookup;
CREATE TABLE suftypabrv_lookup as (
		SELECT DISTINCT suftypabrv, abbrev as state
		  from featnames, state_lookup
		 where featnames.statefp = state_lookup.statefp
		   and suftypabrv is not null
		 order by abbrev, suftypabrv
       );
