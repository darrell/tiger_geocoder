set search_path=tiger;
set client_encoding = 'latin1';
\! ./prep_appendix.sh

DROP TABLE IF EXISTS feat_dirs;
CREATE TABLE feat_dirs (dir_code integer not null, name text not null, abbrev text not null, spanish boolean, translation text);
\copy feat_dirs from directional.txt
ALTER TABLE feat_dirs ADD PRIMARY KEY (dir_code);

ANALYZE feat_dirs;

DROP TABLE IF EXISTS directional_lookup;
CREATE TABLE directional_lookup (name text not null, abbrev text not null);

-- lower-case everything, so that when we use our regexp matches we have
-- a chance to use the text_pattern_ops indexes
INSERT INTO directional_lookup SELECT lower(name), abbrev from feat_dirs;

INSERT INTO directional_lookup SELECT DISTINCT lower(abbrev), abbrev from feat_dirs;

-- Add in some possible variations
INSERT INTO directional_lookup
  SELECT
    lower(a.name) || q.column1 || lower(b.name),
    a.abbrev || b.abbrev
  FROM
    feat_dirs a
    JOIN feat_dirs b on true
    JOIN (VALUES (' '),('-'),('_')) as q on true
  WHERE
    ((a.spanish IS NULL AND b.spanish IS NULL) OR (a.spanish AND b.spanish))
    AND (a.abbrev || b.abbrev) IN (select abbrev from feat_dirs);

ALTER TABLE directional_lookup ADD PRIMARY KEY (name);
CREATE INDEX directional_lookup_name_text_ops_idx ON directional_lookup USING btree (name text_pattern_ops);
CREATE INDEX directional_lookup_abbrev_idx ON directional_lookup USING btree (abbrev);
CREATE INDEX directional_lookup_abbrev_text_ops_idx ON directional_lookup USING btree (abbrev text_pattern_ops);

ANALYZE directional_lookup;

DROP TABLE IF EXISTS feat_quals;
CREATE TABLE feat_quals (qual_code integer not null, name text not null, abbrev text not null, prequal boolean not null, sufqual boolean not null);
\copy feat_quals from quals.txt
ALTER TABLE feat_quals ADD PRIMARY KEY (qual_code);

DROP TABLE IF EXISTS qualabrv_lookup;
CREATE TABLE qualabrv_lookup (name text not null, abbrev text not null, prequal boolean not null, sufqual boolean not null);

-- lower-case everything, so that when we use our regexp matches we have
-- a chance to use the text_pattern_ops indexes
INSERT INTO qualabrv_lookup
  SELECT lower(name), abbrev, prequal, sufqual FROM feat_quals
  UNION
  SELECT lower(abbrev), abbrev, prequal, sufqual FROM feat_quals;

ALTER TABLE qualabrv_lookup ADD PRIMARY KEY (name);
CREATE INDEX qualabrv_lookup_name_text_ops_idx ON qualabrv_lookup USING btree (name text_pattern_ops);
CREATE INDEX qualabrv_lookup_abbrev_idx ON qualabrv_lookup USING btree (abbrev);
CREATE INDEX qualabrv_lookup_abbrev_text_ops_idx ON qualabrv_lookup USING btree (abbrev text_pattern_ops);

ANALYZE qualabrv_lookup;

DROP TABLE IF EXISTS feat_types;
CREATE TABLE feat_types (type_code integer not null, name text not null, abbrev text not null, spanish boolean, translation text, pretype boolean not null, suftype boolean not null);
\copy feat_types from types.txt
ALTER TABLE feat_types ADD PRIMARY KEY (type_code);

DROP TABLE IF EXISTS street_type_lookup;
CREATE TABLE street_type_lookup (name text not null, abbrev text not null, pretype boolean not null, suftype boolean not null);
INSERT INTO street_type_lookup
  SELECT
    name,
    abbrev,
    CASE WHEN sum(CASE WHEN pretype THEN 1 ELSE 0 END) > 0 THEN true ELSE false END,
    CASE WHEN sum(CASE WHEN suftype THEN 1 ELSE 0 END) > 0 THEN true ELSE false END
   FROM
  (
  SELECT lower(name) as name, abbrev, pretype, suftype FROM feat_types
  UNION
  SELECT lower(abbrev) as name, abbrev, pretype, suftype FROM feat_types
  UNION
  SELECT lower('I') as name, 'I-', true, false
  ) as a
  GROUP BY name, abbrev
;

ALTER TABLE street_type_lookup ADD PRIMARY KEY (name);
CREATE INDEX street_type_lookup_name_text_ops_idx ON street_type_lookup USING btree (name text_pattern_ops);
CREATE INDEX street_type_lookup_abbrev_idx ON street_type_lookup USING btree (abbrev);
CREATE INDEX street_type_lookup_abbrev_text_ops_idx ON street_type_lookup USING btree (abbrev text_pattern_ops);

ANALYZE street_type_lookup;

