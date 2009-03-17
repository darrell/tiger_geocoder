   set search_path=tiger,public;
   set client_min_messages = error;
  DROP TABLE IF EXISTS secondary_unit_lookup cascade;
CREATE TABLE secondary_unit_lookup (name VARCHAR(20) PRIMARY KEY, abbrev VARCHAR(5));
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('APARTMENT', 'APT');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('APT', 'APT');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('BASEMENT', 'BSMT');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('BSMT', 'BSMT');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('BUILDING', 'BLDG');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('BLDG', 'BLDG');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('DEPARTMENT', 'DEPT');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('DEPT', 'DEPT');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('FLOOR', 'FL');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('FL', 'FL');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('FRONT', 'FRNT');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('FRNT', 'FRNT');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('HANGAR', 'HNGR');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('HNGR', 'HNGR');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('LOBBY', 'LBBY');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('LBBY', 'LBBY');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('LOT', 'LOT');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('LOWER', 'LOWR');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('LOWR', 'LOWR');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('OFFICE', 'OFC');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('OFC', 'OFC');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('PENTHOUSE', 'PH');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('PH', 'PH');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('PIER', 'PIER');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('REAR', 'REAR');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('ROOM', 'RM');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('RM', 'RM');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('SIDE', 'SIDE');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('SLIP', 'SLIP');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('SPACE', 'SPC');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('SPC', 'SPC');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('STOP', 'STOP');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('SUITE', 'STE');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('STE', 'STE');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('TRAILER', 'TRLR');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('TRLR', 'TRLR');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('UNIT', 'UNIT');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('UPPER', 'UPPR');
INSERT INTO secondary_unit_lookup (name, abbrev)
VALUES ('UPPR', 'UPPR');
CREATE INDEX secondary_unit_lookup_abbrev_idx
    ON secondary_unit_lookup (abbrev);
