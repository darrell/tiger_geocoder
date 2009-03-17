   set search_path=tiger,public;
   set client_min_messages = error;
  DROP TABLE IF EXISTS state_lookup cascade;
CREATE TABLE state_lookup (statefp varchar(2) PRIMARY KEY, name VARCHAR(40) UNIQUE, abbrev VARCHAR(3) UNIQUE);
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Alabama', 'AL', '01');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Alaska', 'AK', '02');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('American Samoa', 'AS', -1);
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Arizona', 'AZ', '04');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Arkansas', 'AR', '05');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('California', 'CA', '06');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Colorado', 'CO', '08');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Connecticut', 'CT', '09');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Delaware', 'DE', '10');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('District of Columbia', 'DC', '11');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Federated States of Micronesia', 'FM', -2);
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Florida', 'FL', '12');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Georgia', 'GA', '13');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Guam', 'GU', -7);
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Hawaii', 'HI', '15');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Idaho', 'ID', '16');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Illinois', 'IL', '17');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Indiana', 'IN', '18');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Iowa', 'IA', '19');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Kansas', 'KS', '20');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Kentucky', 'KY', '21');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Louisiana', 'LA', '22');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Maine', 'ME', '23');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Marshall Islands', 'MH', -3);
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Maryland', 'MD', '24');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Massachusetts', 'MA', '25');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Michigan', 'MI', '26');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Minnesota', 'MN', '27');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Mississippi', 'MS', '28');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Missouri', 'MO', '29');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Montana', 'MT', '30');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Nebraska', 'NE', '31');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Nevada', 'NV', '32');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('New Hampshire', 'NH', '33');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('New Jersey', 'NJ', '34');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('New Mexico', 'NM', '35');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('New York', 'NY', '36');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('North Carolina', 'NC', '37');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('North Dakota', 'ND', '38');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Northern Mariana Islands', 'MP', -4);
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Ohio', 'OH', '39');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Oklahoma', 'OK', '40');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES (
							 'Oregon', '
						OR '
						 , '41'
       );
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Palau', 'PW', -5);
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Pennsylvania', 'PA', '42');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Puerto Rico', 'PR', '72');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Rhode Island', 'RI', '44');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('South Carolina', 'SC', '45');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('South Dakota', 'SD', '46');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Tennessee', 'TN', '47');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Texas', 'TX', '48');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Utah', 'UT', '49');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Vermont', 'VT', '50');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Virgin Islands', 'VI', -6);
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Virginia', 'VA', '51');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Washington', 'WA', '53');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('West Virginia', 'WV', '54');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Wisconsin', 'WI', '55');
INSERT INTO state_lookup (name, abbrev, statefp)
VALUES ('Wyoming', 'WY', '56');
