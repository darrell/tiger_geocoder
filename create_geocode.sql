-- Tiger is where we're going to create the functions, but we need
-- the PostGIS functions/types which are in public.
SET search_path TO tiger,public;
set client_min_messages=error;

create schema tiger;

\set ON_ERROR_STOP true
begin;

--DROP schema if exists tiger cascade;

-- Type used to pass around a normalized address between functions
-- Note census defines a street name as: 
-- "Concatenation of expanded text for prefix qualifier, prefix 
-- direction, prefix type, base name, suffix type, suffix 
-- direction, and suffix qualifier with a space between each 
-- expanded text field "

DROP TYPE IF EXISTS norm_addy CASCADE;
CREATE TYPE norm_addy AS (
    address INTEGER,
    preDirAbbrev VARCHAR,
    preTypeAbbrev VARCHAR,
    preQualAbbrev VARCHAR,
    streetName VARCHAR,
    streetTypeAbbrev VARCHAR,
    streetDirAbbrev VARCHAR,
    streetQualAbbrev VARCHAR,
    internal VARCHAR,
    location VARCHAR,
    stateAbbrev VARCHAR,
    zip CHAR(5),
    zip4 CHAR(4),
    parsed BOOLEAN);

-- System/General helper functions
\cd ./utility
\i array_helpers.sql
\i utmzone.sql
\i cull_null.sql
\i nullable_levenshtein.sql
\i levenshtein_ignore_case.sql

-- Lookup Tables
\cd ../tables
\i lookup_tables.sql 

---- Address normalizer
-- General helpers
\cd ../normalize
\i normalizer.sql
---- Geocoder functions
-- General helpers
\cd ../geocode
\i geocoder.sql

commit;
