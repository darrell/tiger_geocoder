set search_path=tiger,public;
\i rate_attributes.sql
\i includes_address.sql
\i interpolate_from_address.sql
-- Actual lookups/geocoder helpers
\i geocode_address.sql
\i geocode_location.sql
-- Geocode API, called by user
\i geocode.sql
