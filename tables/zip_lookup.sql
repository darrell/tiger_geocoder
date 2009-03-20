      set search_path=tiger,public;
      set client_min_messages = error;
     DROP TABLE IF EXISTS zip_lookup cascade;
   CREATE TABLE zip_lookup  AS
   SELECT DISTINCT
       ON (zip) zip
        , statefp
        , state
        , countyfp
        , county
        , countyfull
        , cousubfp
        , countysub
        , placefp
        , place
        , cnt
     FROM zip_lookup_all
    ORDER BY zip
        , cnt desc;
