-- Tiger is where we're going to create the functions, but we need
-- the PostGIS functions/types which are in public.
SET search_path TO tiger,public;
set client_min_messages=error;

DROP schema if exists tiger cascade;
create schema tiger;

-- Type used to pass around a normalized address between functions
DROP TYPE IF EXISTS norm_addy CASCADE;
CREATE TYPE norm_addy AS (
    address INTEGER,
    preDirAbbrev VARCHAR,
    streetName VARCHAR,
    streetTypeAbbrev VARCHAR,
    postDirAbbrev VARCHAR,
    internal VARCHAR,
    location VARCHAR,
    stateAbbrev VARCHAR,
    zip VARCHAR,
    parsed BOOLEAN);
-- Lookup Tables
\cd tables
\i lookup_tables.sql 
-- System/General helper functions
\cd ../utility
\i utmzone.sql
\i cull_null.sql
\i nullable_levenshtein.sql
\i levenshtein_ignore_case.sql

---- Address normalizer
-- General helpers
\cd ../normalize
\i normalizer.sql
---- Geocoder functions
-- General helpers
\cd ../geocode
\i geocoder.sql
