set search_path=public,tiger;
\i end_dmetaphone.sql
\i count_words.sql
\i state_extract.sql
\i get_last_words.sql
\i location_extract.sql
-- Normalization API, called by geocode mainly.
\i normalize_address.sql
\i pprint_addy.sql
\i address_variants.sql
