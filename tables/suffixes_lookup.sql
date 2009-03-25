set search_path=tiger,public;
CREATE OR REPLACE VIEW suffixes_lookup(name,abbrev) as 
  SELECT DISTINCT name,abbrev FROM direction_lookup 
  UNION ALL
  SELECT DISTINCT name,abbrev FROM street_type_lookup
  UNION ALL
  SELECT DISTINCT sufqualabr,sufqualabr FROM sufqualabr_lookup;

