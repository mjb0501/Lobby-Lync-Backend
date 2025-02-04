--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: game; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game (id, name) FROM stdin;
2	Minecraft
3	Roblox
4	Fortnite
7	Call of Duty: Modern Warfare 3
8	Call of Duty: Black Ops 6
9	Call of Duty: Warzone
10	Battlefield 2042
11	Destiny 2
12	Overwatch 2
13	Counter-Strike 2
14	Rainbow Six Siege
15	Halo Infinite
16	Apex Legends
17	PUBG: Battlegrounds
18	World of Warcraft
19	Final Fantasy XIV
20	Elder Scrolls Online
21	League of Legends
22	Dota 2
23	Smite
24	EA Sports FC 25
25	NBA 2k25
26	Rocket League
27	Forza Horizon 5
28	Gran Turismo 7
29	NHL 25
30	Madden 25
31	College Football 25
32	F1 24
33	UFC 5
34	Valheim
35	ARK: Surivival Evolved
36	Super Smash Bros. Ultimate
37	Mortal Kombat 1
38	Street Fighter 6
39	Among Us
40	Fall Guys
41	It Takes Two
42	Mario Kart 8 Deluxe
43	Naraka: Bladepoint
44	Guild Wars 2
45	Black Desert Online
46	Lost Ark
47	Pokemon Unite
48	WWE 2K24
49	Rust
50	Don't Starve Together
51	DayZ
52	Terraria
53	Tekken 8
54	Guilty Gear -Strive-
55	Super Mario Party
56	Jackbox Party Pack (1-10)
57	Overcooked! All You Can Eat
58	Monster Hunter: World
59	Monster Hunter: Rise
60	Diablo IV
61	Borderlands 3
62	Remnant 2
63	Warthunder
64	World of Tanks
65	World of Warships
66	Dead by Daylight
67	Phasmophobia
68	The Outlast Trials
69	Project Winter
70	Deceit 2
71	GTA V
72	Red Dead Redemption 2
73	Sea of Thieves
74	Deep Rock Galactic
75	No Man's Sky
\.


--
-- Data for Name: platform; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.platform (id, name) FROM stdin;
1	Xbox
2	Playstation
4	Switch
3	Steam
\.


--
-- Data for Name: game_platform; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_platform (id, "gameId", "platformId") FROM stdin;
11	2	1
12	2	2
13	2	3
14	2	4
15	3	3
16	4	1
17	4	2
18	4	3
19	4	4
24	7	1
25	7	2
26	7	3
27	8	1
28	8	2
29	8	3
30	9	1
31	9	2
32	9	3
33	10	1
34	10	2
35	10	3
36	11	1
37	11	2
38	11	3
39	12	1
40	12	2
41	12	3
42	12	4
43	13	3
44	14	1
45	14	2
46	14	3
47	15	1
48	15	3
49	16	1
50	16	2
51	16	3
52	16	4
53	17	1
54	17	2
55	17	3
56	18	3
57	19	2
58	19	3
59	20	1
60	20	2
61	20	3
62	21	3
63	22	3
64	23	1
65	23	2
66	23	3
67	23	4
68	24	1
69	24	2
70	24	3
71	24	4
72	25	1
73	25	2
74	25	3
75	25	4
76	26	1
77	26	2
78	26	3
79	26	4
80	27	1
81	27	3
82	28	2
83	29	1
84	29	2
85	30	1
86	30	2
87	30	3
88	31	1
89	31	2
90	32	1
91	32	2
92	32	3
93	33	1
94	33	2
95	34	1
96	34	3
97	35	1
98	35	2
99	35	3
100	35	4
101	36	4
102	37	1
103	37	2
104	37	3
105	37	4
106	38	1
107	38	2
108	38	3
109	39	1
110	39	2
111	39	3
112	39	4
113	40	1
114	40	2
115	40	3
116	40	4
117	41	1
118	41	2
119	41	3
120	41	4
121	42	4
122	43	1
123	43	2
124	43	3
125	44	3
126	45	1
127	45	2
128	45	3
129	46	3
130	47	4
131	48	1
132	48	2
133	48	3
134	49	1
135	49	2
136	49	3
137	50	1
138	50	2
139	50	3
140	50	4
141	51	1
142	51	2
143	51	3
144	52	1
145	52	2
146	52	3
147	52	4
148	53	1
149	53	2
150	53	3
151	54	1
152	54	2
153	54	3
154	55	4
155	56	1
156	56	2
157	56	3
158	56	4
159	57	1
160	57	2
161	57	3
162	57	4
163	58	1
164	58	2
165	58	3
166	59	1
167	59	2
168	59	3
169	59	4
170	60	1
171	60	2
172	60	3
173	61	1
174	61	2
175	61	3
176	62	1
177	62	2
178	62	3
179	63	1
180	63	2
181	63	3
182	64	1
183	64	2
184	64	3
185	65	1
186	65	2
187	65	3
188	66	1
189	66	2
190	66	3
191	66	4
192	67	1
193	67	2
194	67	3
195	68	1
196	68	2
197	68	3
198	69	1
199	69	2
200	69	3
201	69	4
202	70	1
203	70	2
204	70	3
205	71	1
206	71	2
207	71	3
208	72	1
209	72	2
210	72	3
211	73	1
212	73	3
213	74	1
214	74	2
215	74	3
216	75	1
217	75	2
218	75	3
219	75	4
220	3	1
221	3	2
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, username, email, password) FROM stdin;
12	test	testing@gmail.com	$2b$10$YkI2.4s68P6gtgq3ufUl3.vXnd9Mfp1Wc5mNUTpX.abW2PTkc5qyS
13	test2	testing2@gmail.com	$2b$10$/JuLkj6mOb7ZGjnWGSrZ7en9c2ch.ri0seR7TiYz4cyY3o8x.925G
\.


--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post (id, "userId", "gameId", description, "createdAt") FROM stdin;
\.


--
-- Data for Name: post_acceptance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_acceptance (id, "postId", "userId", description, platform, "platformUsername") FROM stdin;
\.


--
-- Data for Name: post_platform; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_platform (id, "postId", "platformId") FROM stdin;
\.


--
-- Data for Name: user_platform; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_platform (id, "userId", "platformId", "platformUsername") FROM stdin;
1	1	1	toejam
2	2	2	Earl
3	3	3	wildwilly
44	12	1	xboxTest2
20	12	2	playstationTest2
73	12	3	steamTest2
67	12	4	switchTest
37	16	1	gaminggrandpa242
\.


--
-- Name: game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_id_seq', 75, true);


--
-- Name: game_platform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_platform_id_seq', 221, true);


--
-- Name: platform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.platform_id_seq', 4, true);


--
-- Name: post_acceptance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_acceptance_id_seq', 23, true);


--
-- Name: post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_id_seq', 76, true);


--
-- Name: post_platform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_platform_id_seq', 151, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 23, true);


--
-- Name: user_platform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_platform_id_seq', 78, true);


--
-- PostgreSQL database dump complete
--

