   set search_path=tiger,public;
   set client_min_messages = error;
  DROP TABLE IF EXISTS direction_lookup cascade;
CREATE TABLE direction_lookup (name VARCHAR(20) PRIMARY KEY, abbrev VARCHAR(3));
INSERT INTO direction_lookup (name, abbrev)
VALUES ('WEST', 'W');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('W', 'W');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('SW', 'SW');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('SOUTH-WEST', 'SW');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('SOUTHWEST', 'SW');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('SOUTH-EAST', 'SE');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('SOUTHEAST', 'SE');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('SOUTH_WEST', 'SW');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('SOUTH_EAST', 'SE');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('SOUTH', 'S');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('SOUTH WEST', 'SW');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('SOUTH EAST', 'SE');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('SE', 'SE');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('S', 'S');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('NW', 'NW');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('NORTH-WEST', 'NW');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('NORTHWEST', 'NW');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('NORTH-EAST', 'NE');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('NORTHEAST', 'NE');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('NORTH_WEST', 'NW');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('NORTH_EAST', 'NE');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('NORTH', 'N');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('NORTH WEST', 'NW');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('NORTH EAST', 'NE');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('NE', 'NE');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('N', 'N');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('EAST', 'E');
INSERT INTO direction_lookup (name, abbrev)
VALUES ('E', 'E');
CREATE INDEX direction_lookup_abbrev_idx
    ON direction_lookup (abbrev);
