   set search_path=tiger,public;
   set client_min_messages = error;
  DROP TABLE IF EXISTS state_lookup cascade;
CREATE TABLE state_lookup (
  statefp varchar(2) PRIMARY KEY,
  name VARCHAR(40) UNIQUE,
  abbrev VARCHAR(3) UNIQUE,
  gpoabbrev varchar(10) UNIQUE,
  altabbrev varchar(10) UNIQUE);

COPY state_lookup FROM STDIN;
01	Alabama	AL	Ala.	Ala.
02	Alaska	AK	Alaska	Alaska
04	Arizona	AZ	Ariz.	Ariz.
05	Arkansas	AR	Ark.	Ark.
06	California	CA	Calif.	Calif.
08	Colorado	CO	Colo.	Colo.
09	Connecticut	CT	Conn.	Conn.
10	Delaware	DE	Del.	Del.
11	District of Columbia	DC	D.C.	D.C.
12	Florida	FL	Fla.	Fla.
13	Georgia	GA	Ga.	Ga.
15	Hawaii	HI	Hawaii	Hawaii
16	Idaho	ID	Idaho	Idaho
17	Illinois	IL	Ill.	Ill.
18	Indiana	IN	Ind.	Ind.
19	Iowa	IA	Iowa	Iowa
20	Kansas	KS	Kans.	Kan.
21	Kentucky	KY	Ky.	Ky.
22	Louisiana	LA	La.	La.
23	Maine	ME	Maine	Maine
24	Maryland	MD	Md.	Md.
25	Massachusetts	MA	Mass.	Mass.
26	Michigan	MI	Mich.	Mich.
27	Minnesota	MN	Minn.	Minn.
28	Mississippi	MS	Miss.	Miss.
29	Missouri	MO	Mo.	Mo.
30	Montana	MT	Mont.	Mont.
31	Nebraska	NE	Nebr.	Neb.
32	Nevada	NV	Nev.	Nev.
33	New Hampshire	NH	N.H.	N.H.
34	New Jersey	NJ	N.J.	N.J.
35	New Mexico	NM	N. Mex.	N.M.
36	New York	NY	N.Y.	N.Y.
37	North Carolina	NC	N.C.	N.C.
38	North Dakota	ND	N. Dak.	N.D.
39	Ohio	OH	Ohio	Ohio
40	Oklahoma	OK	Okla.	Okla.
41	Oregon	OR	Oreg.	Ore.
42	Pennsylvania	PA	Pa.	Pa.
44	Rhode Island	RI	R.I.	R.I.
45	South Carolina	SC	S.C.	S.C.
46	South Dakota	SD	S. Dak.	S.D.
47	Tennessee	TN	Tenn.	Tenn.
48	Texas	TX	Tex.	Texas
49	Utah	UT	Utah	Utah
50	Vermont	VT	Vt.	Vt.
51	Virginia	VA	Va.	Va.
53	Washington	WA	Wash.	Wash.
54	West Virginia	WV	W. Va.	W.Va.
55	Wisconsin	WI	Wis.	Wis.
56	Wyoming	WY	Wyo.	Wyo.
60	American Samoa	AS	A.S.	\N
64	Micronesia	FM	\N	\N
66	Guam	GU	Guam	\N
68	Marshall Islands	MH	\N	\N
69	Northern Mariana Islands	MP	M.P.	\N
70	Palau	PW	\N	\N
72	Puerto Rico	PR	P.R.	\N
78	Virgin Islands	VI	V.I.	\N
\.

