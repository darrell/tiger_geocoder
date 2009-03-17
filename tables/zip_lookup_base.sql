   set search_path=tiger,public;
   set client_min_messages = error;
  DROP TABLE IF EXISTS zip_lookup_base cascade;
CREATE TABLE zip_lookup_base ( zip VARCHAR(5), statefp VARCHAR(40), county VARCHAR(90), city VARCHAR(90), PRIMARY KEY (zip));
