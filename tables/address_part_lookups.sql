   set search_path       = tiger, public;
  DROP TABLE IF EXISTS predirabrv_lookup;
CREATE TABLE predirabrv_lookup as (
		SELECT DISTINCT predirabrv, stusps as state
		  from featnames, state
		 where featnames.statefp = state.statefp
		   and predirabrv is not null
		 order by stusps, predirabrv
       );
  DROP TABLE IF EXISTS prequalabr_lookup;
CREATE TABLE prequalabr_lookup as (
		SELECT DISTINCT prequalabr, stusps as state
		  from featnames, state
		 where featnames.statefp = state.statefp
		   and prequalabr is not null
		 order by stusps, prequalabr
       );
  DROP TABLE IF EXISTS pretypabrv_lookup;
CREATE TABLE pretypabrv_lookup as (
		SELECT DISTINCT pretypabrv, stusps as state
		  from featnames, state
		 where featnames.statefp = state.statefp
		   and pretypabrv is not null
		 order by stusps, pretypabrv
       );
  DROP TABLE IF EXISTS sufdirabrv_lookup;
CREATE TABLE sufdirabrv_lookup as (
		SELECT DISTINCT sufdirabrv, stusps as state
		  from featnames, state
		 where featnames.statefp = state.statefp
		   and sufdirabrv is not null
		 order by stusps, sufdirabrv
       );
  DROP TABLE IF EXISTS sufqualabr_lookup;
CREATE TABLE sufqualabr_lookup as (
		SELECT DISTINCT sufqualabr, stusps as state
		  from featnames, state
		 where featnames.statefp = state.statefp
		   and sufqualabr is not null
		 order by stusps, sufqualabr
       );
  DROP TABLE IF EXISTS suftypabrv_lookup;
CREATE TABLE suftypabrv_lookup as (
		SELECT DISTINCT suftypabrv, stusps as state
		  from featnames, state
		 where featnames.statefp = state.statefp
		   and suftypabrv is not null
		 order by stusps, suftypabrv
       );
