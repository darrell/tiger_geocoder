   set search_path=tiger,public;
   set client_min_messages = error;
  DROP TABLE IF EXISTS street_type_lookup cascade;
CREATE TABLE street_type_lookup (name VARCHAR(20) PRIMARY KEY, abbrev VARCHAR(4));
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ALLEE', 'Aly');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ALLEY', 'Aly');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ALLY', 'Aly');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ALY', 'Aly');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ANEX', 'Anx');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ANNEX', 'Anx');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ANNX', 'Anx');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ANX', 'Anx');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ARC', 'Arc');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ARCADE', 'Arc');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('AV', 'Ave');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('AVE', 'Ave');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('AVEN', 'Ave');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('AVENU', 'Ave');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('AVENUE', 'Ave');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('AVN', 'Ave');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('AVNUE', 'Ave');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BAYOO', 'Byu');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BAYOU', 'Byu');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BCH', 'Bch');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BEACH', 'Bch');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BEND', 'Bnd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BND', 'Bnd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BLF', 'Blf');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BLUF', 'Blf');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BLUFF', 'Blf');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BLUFFS', 'Blfs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BOT', 'Btm');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BOTTM', 'Btm');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BOTTOM', 'Btm');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BTM', 'Btm');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BLVD', 'Blvd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BOUL', 'Blvd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BOULEVARD', 'Blvd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BOULV', 'Blvd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BR', 'Br');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BRANCH', 'Br');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BRNCH', 'Br');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BRDGE', 'Brg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BRG', 'Brg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BRIDGE', 'Brg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BRK', 'Brk');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BROOK', 'Brk');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BROOKS', 'Brks');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BURG', 'Bg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BURGS', 'Bgs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BYP', 'Byp');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BYPA', 'Byp');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BYPAS', 'Byp');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BYPASS', 'ByP');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BYPS', 'Byp');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CAMP', 'Cp');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CMP', 'Cp');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CP', 'Cp');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CANYN', 'Cyn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CANYON', 'Cyn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CNYN', 'Cyn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CYN', 'Cyn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CAPE', 'Cpe');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CPE', 'Cpe');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CAUSEWAY', 'Cswy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CAUSWAY', 'Cswy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CSWY', 'Cswy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CEN', 'Ctr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CENT', 'Ctr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CENTER', 'Ctr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CENTR', 'Ctr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CENTRE', 'Ctr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CNTER', 'Ctr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CNTR', 'Ctr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CTR', 'Ctr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CENTERS', 'Ctrs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CIR', 'Cir');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CIRC', 'Cir');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CIRCL', 'Cir');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CIRCLE', 'Cir');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRCL', 'Cir');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRCLE', 'Cir');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CIRCLES', 'Cirs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CLF', 'Clf');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CLIFF', 'Clf');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CLFS', 'Clfs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CLIFFS', 'Clfs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CLB', 'Clb');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CLUB', 'Clb');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('COMMON', 'Cmn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('COR', 'Cor');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CORNER', 'Cor');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CORNERS', 'Cors');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CORS', 'Cors');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('COURSE', 'Crse');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRSE', 'Crse');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('COURT', 'Ct');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRT', 'Ct');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CT', 'Ct');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('COURTS', 'Cts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('COVE', 'Cv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CV', 'Cv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('COVES', 'Cvs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CK', 'Crk');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CR', 'Crk');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CREEK', 'Crk');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRK', 'Crk');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRECENT', 'Cres');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRES', 'Cres');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRESCENT', 'Cres');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRESENT', 'Cres');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRSCNT', 'Cres');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRSENT', 'Cres');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRSNT', 'Cres');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CREST', 'Crst');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CROSSING', 'Xing');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRSSING', 'Xing');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRSSNG', 'Xing');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('XING', 'Xing');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CROSSROAD', 'Xrd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CURVE', 'Curv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DALE', 'Dl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DL', 'Dl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DAM', 'Dm');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DM', 'Dm');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DIV', 'Dv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DIVIDE', 'Dv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DV', 'Dv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DVD', 'Dv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DR', 'Dr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DRIV', 'Dr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DRIVE', 'Dr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DRV', 'Dr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DRIVES', 'Drs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EST', 'Est');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ESTATE', 'Est');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ESTATES', 'Ests');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ESTS', 'Ests');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EXP', 'Expy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EXPR', 'Expy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EXPRESS', 'Expy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EXPRESSWAY', 'Expy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EXPW', 'Expy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EXPY', 'Expy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EXT', 'Ext');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EXTENSION', 'Ext');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EXTN', 'Ext');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EXTNSN', 'Ext');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EXTENSIONS', 'Exts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('EXTS', 'Exts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FALL', 'Fall');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FALLS', 'Fls');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FLS', 'Fls');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FERRY', 'Fry');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FRRY', 'Fry');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FRY', 'Fry');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FIELD', 'Fld');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FLD', 'Fld');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FIELDS', 'Flds');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FLDS', 'Flds');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FLAT', 'Flt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FLT', 'Flt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FLATS', 'Flts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FLTS', 'Flts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FORD', 'Frd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FRD', 'Frd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FORDS', 'Frds');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FOREST', 'Frst');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FORESTS', 'Frst');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FRST', 'Frst');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FORG', 'Frg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FORGE', 'Frg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FRG', 'Frg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FORGES', 'Frgs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FORK', 'Frk');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FRK', 'Frk');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FORKS', 'Frks');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FRKS', 'Frks');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FORT', 'Ft');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FRT', 'Ft');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FT', 'Ft');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FREEWAY', 'Fwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FREEWY', 'Fwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FRWAY', 'Fwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FRWY', 'Fwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FWY', 'Fwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GARDEN', 'Gdn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GARDN', 'Gdn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GDN', 'Gdn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GRDEN', 'Gdn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GRDN', 'Gdn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GARDENS', 'Gdns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GDNS', 'Gdns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GRDNS', 'Gdns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GATEWAY', 'Gtwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GATEWY', 'Gtwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GATWAY', 'Gtwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GTWAY', 'Gtwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GTWY', 'Gtwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GLEN', 'Gln');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GLN', 'Gln');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GLENS', 'Glns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GREEN', 'Grn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GRN', 'Grn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GREENS', 'Grns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GROV', 'Grv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GROVE', 'Grv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GRV', 'Grv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GROVES', 'Grvs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HARB', 'Hbr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HARBOR', 'Hbr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HARBR', 'Hbr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HBR', 'Hbr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HRBOR', 'Hbr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HARBORS', 'Hbrs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HAVEN', 'Hvn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HAVN', 'Hvn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HVN', 'Hvn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HEIGHT', 'Hts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HEIGHTS', 'Hts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HGTS', 'Hts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HT', 'Hts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HTS', 'Hts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HIGHWAY', 'Hwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HIGHWY', 'Hwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HIWAY', 'Hwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HIWY', 'Hwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HWAY', 'Hwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HWY', 'Hwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HILL', 'Hl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HL', 'Hl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HILLS', 'Hls');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HLS', 'Hls');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HLLW', 'Holw');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HOLLOW', 'Holw');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HOLLOWS', 'Holw');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HOLW', 'Holw');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HOLWS', 'Holw');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('INLET', 'Inlt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('INLT', 'Inlt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('IS', 'Is');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ISLAND', 'Is');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ISLND', 'Is');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ISLANDS', 'Iss');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ISLNDS', 'Iss');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ISS', 'Iss');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ISLE', 'Isle');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ISLES', 'Isle');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('JCT', 'Jct');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('JCTION', 'Jct');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('JCTN', 'Jct');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('JUNCTION', 'Jct');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('JUNCTN', 'Jct');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('JUNCTON', 'Jct');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('JCTNS', 'Jcts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('JCTS', 'Jcts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('JUNCTIONS', 'Jcts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('KEY', 'Ky');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('KY', 'Ky');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('KEYS', 'Kys');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('KYS', 'Kys');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('KNL', 'Knl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('KNOL', 'Knl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('KNOLL', 'Knl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('KNLS', 'Knls');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('KNOLLS', 'Knls');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LAKE', 'Lk');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LK', 'Lk');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LAKES', 'Lks');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LKS', 'Lks');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LAND', 'Land');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LANDING', 'Lndg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LNDG', 'Lndg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LNDNG', 'Lndg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LA', 'Ln');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LANE', 'Ln');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LANES', 'Ln');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LN', 'Ln');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LGT', 'Lgt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LIGHT', 'Lgt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LIGHTS', 'Lgts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LF', 'Lf');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LOAF', 'Lf');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LCK', 'Lck');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LOCK', 'Lck');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LCKS', 'Lcks');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LOCKS', 'Lcks');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LDG', 'Ldg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LDGE', 'Ldg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LODG', 'Ldg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LODGE', 'Ldg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LOOP', 'Loop');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LOOPS', 'Loop');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MALL', 'Mall');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MANOR', 'Mnr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MNR', 'Mnr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MANORS', 'Mnrs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MNRS', 'Mnrs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MDW', 'Mdw');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MEADOW', 'Mdw');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MDWS', 'Mdws');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MEADOWS', 'Mdws');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MEDOWS', 'Mdws');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MEWS', 'Mews');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MILL', 'Ml');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ML', 'Ml');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MILLS', 'Mls');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MLS', 'Mls');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MISSION', 'Msn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MISSN', 'Msn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MSN', 'Msn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MSSN', 'Msn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MOTORWAY', 'Mtwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MNT', 'Mt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MOUNT', 'Mt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MT', 'Mt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MNTAIN', 'Mtn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MNTN', 'Mtn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MOUNTAIN', 'Mtn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MOUNTIN', 'Mtn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MTIN', 'Mtn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MTN', 'Mtn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MNTNS', 'Mtns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MOUNTAINS', 'Mtns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('NCK', 'Nck');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('NECK', 'Nck');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ORCH', 'Orch');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ORCHARD', 'Orch');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ORCHRD', 'Orch');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('OVAL', 'Oval');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('OVL', 'Oval');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('OVERPASS', 'Opas');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PARK', 'Park');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PK', 'Park');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PRK', 'Park');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PARKS', 'Park');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PARKWAY', 'Pkwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PARKWY', 'Pkwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PKWAY', 'Pkwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PKWY', 'Pkwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PKY', 'Pkwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PARKWAYS', 'Pkwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PKWYS', 'Pkwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PASS', 'Pass');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PASSAGE', 'Psge');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PATH', 'Path');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PATHS', 'Path');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PIKE', 'Pike');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PIKES', 'Pike');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PINE', 'Pne');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PINES', 'Pnes');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PNES', 'Pnes');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PL', 'Pl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PLACE', 'Pl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PLAIN', 'Pln');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PLN', 'Pln');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PLAINES', 'Plns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PLAINS', 'Plns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PLNS', 'Plns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PLAZA', 'Plz');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PLZ', 'Plz');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PLZA', 'Plz');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('POINT', 'Pt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PT', 'Pt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('POINTS', 'Pts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PTS', 'Pts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PORT', 'Prt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PRT', 'Prt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PORTS', 'Prts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PRTS', 'Prts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PR', 'Pr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PRAIRIE', 'Pr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PRARIE', 'Pr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PRR', 'Pr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RAD', 'Radl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RADIAL', 'Radl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RADIEL', 'Radl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RADL', 'Radl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RAMP', 'Ramp');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RANCH', 'Rnch');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RANCHES', 'Rnch');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RNCH', 'Rnch');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RNCHS', 'Rnch');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RAPID', 'Rpd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RPD', 'Rpd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RAPIDS', 'Rpds');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RPDS', 'Rpds');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('REST', 'Rst');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RST', 'Rst');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RDG', 'Rdg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RDGE', 'Rdg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RIDGE', 'Rdg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RDGS', 'Rdgs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RIDGES', 'Rdgs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RIV', 'Riv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RIVER', 'Riv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RIVR', 'Riv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RVR', 'Riv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RD', 'Rd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ROAD', 'Rd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RDS', 'Rds');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ROADS', 'Rds');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ROUTE', 'Rte');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ROW', 'Row');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RUE', 'Rue');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RUN', 'Run');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SHL', 'Shl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SHOAL', 'Shl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SHLS', 'Shls');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SHOALS', 'Shls');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SHOAR', 'Shr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SHORE', 'Shr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SHR', 'Shr');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SHOARS', 'Shrs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SHORES', 'Shrs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SHRS', 'Shrs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SKYWAY', 'Skwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SPG', 'Spg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SPNG', 'Spg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SPRING', 'Spg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SPRNG', 'Spg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SPGS', 'Spgs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SPNGS', 'Spgs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SPRINGS', 'Spgs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SPRNGS', 'Spgs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SPUR', 'Spur');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SPURS', 'Spur');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SQ', 'Sq');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SQR', 'Sq');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SQRE', 'Sq');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SQU', 'Sq');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SQUARE', 'Sq');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SQRS', 'Sqs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SQUARES', 'Sqs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STA', 'Sta');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STATION', 'Sta');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STATN', 'Sta');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STN', 'Sta');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STRA', 'Stra');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STRAV', 'Stra');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STRAVE', 'Stra');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STRAVEN', 'Stra');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STRAVENUE', 'Stra');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STRAVN', 'Stra');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STRVN', 'Stra');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STRVNUE', 'Stra');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STREAM', 'Strm');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STREME', 'Strm');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STRM', 'Strm');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('ST', 'St');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STR', 'St');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STREET', 'St');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STRT', 'St');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STREETS', 'Sts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SMT', 'Smt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SUMIT', 'Smt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SUMITT', 'Smt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SUMMIT', 'Smt');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TER', 'Ter');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TERR', 'Ter');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TERRACE', 'Ter');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('THROUGHWAY', 'Trwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRACE', 'Trce');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRACES', 'Trce');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRCE', 'Trce');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRACK', 'Trak');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRACKS', 'Trak');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRAK', 'Trak');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRK', 'Trak');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRKS', 'Trak');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRAFFICWAY', 'Trfy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRFY', 'Trfy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TR', 'Trl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRAIL', 'Trl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRAILS', 'Trl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRL', 'Trl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRLS', 'Trl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TUNEL', 'Tunl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TUNL', 'Tunl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TUNLS', 'Tunl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TUNNEL', 'Tunl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TUNNELS', 'Tunl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TUNNL', 'Tunl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TPK', 'Tpke');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TPKE', 'Tpke');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRNPK', 'Tpke');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRPK', 'Tpke');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TURNPIKE', 'Tpke');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TURNPK', 'Tpke');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('UNDERPASS', 'Upas');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('UN', 'Un');
INSERT INTO street_type_lookup (name, abbrev)
VALUES (
							 '
				 UNION '
						 , 'Un'
       );
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('UNIONS', 'Uns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VALLEY', 'Vly');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VALLY', 'Vly');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VLLY', 'Vly');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VLY', 'Vly');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VALLEYS', 'Vlys');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VLYS', 'Vlys');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VDCT', 'Via');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VIA', 'Via');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VIADCT', 'Via');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VIADUCT', 'Via');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VIEW', 'Vw');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VW', 'Vw');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VIEWS', 'Vws');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VWS', 'Vws');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VILL', 'Vlg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VILLAG', 'Vlg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VILLAGE', 'Vlg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VILLG', 'Vlg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VILLIAGE', 'Vlg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VLG', 'Vlg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VILLAGES', 'Vlgs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VLGS', 'Vlgs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VILLE', 'Vl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VL', 'Vl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VIS', 'Vis');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VIST', 'Vis');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VISTA', 'Vis');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VST', 'Vis');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('VSTA', 'Vis');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('WALK', 'Walk');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('WALKS', 'Walk');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('WALL', 'Wall');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('WAY', 'Way');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('WY', 'Way');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('WAYS', 'Ways');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('WELL', 'Wl');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('WELLS', 'Wls');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('WLS', 'Wls');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BYU', 'Byu');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BLFS', 'Blfs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BRKS', 'Brks');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BG', 'Bg');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('BGS', 'Bgs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CTRS', 'Ctrs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CIRS', 'Cirs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CMN', 'Cmn');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CTS', 'Cts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CVS', 'Cvs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CRST', 'Crst');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('XRD', 'Xrd');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('CURV', 'Curv');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('DRS', 'Drs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FRDS', 'Frds');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('FRGS', 'Frgs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GLNS', 'Glns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GRNS', 'Grns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('GRVS', 'Grvs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('HBRS', 'Hbrs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('LGTS', 'Lgts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MTWY', 'Mtwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('MTNS', 'Mtns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('OPAS', 'Opas');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PSGE', 'Psge');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('PNE', 'Pne');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('RTE', 'Rte');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SKWY', 'Skwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('SQS', 'Sqs');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('STS', 'Sts');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('TRWY', 'Trwy');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('UPAS', 'Upas');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('UNS', 'Uns');
INSERT INTO street_type_lookup (name, abbrev)
VALUES ('WL', 'Wl');
CREATE INDEX street_type_lookup_abbrev_idx
    ON street_type_lookup (abbrev);
