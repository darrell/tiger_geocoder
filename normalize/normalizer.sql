set search_path=public,tiger;
\i end_soundex.sql
\i count_words.sql
\i state_extract.sql
\i get_last_words.sql
-- Location extraction/normalization helpers
\i location_extract_countysub_exact.sql
\i location_extract_countysub_fuzzy.sql
\i location_extract_place_exact.sql
\i location_extract_place_fuzzy.sql
\i location_extract.sql
-- Normalization API, called by geocode mainly.
\i normalize_address.sql
\i pprint_addy.sql
