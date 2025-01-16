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
-- Data for Name: game; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.game (id, name) FROM stdin;
1	Call of Duty
2	Minecraft
3	Roblox
4	Fortnite
6	Call of Duty 2
\.


--
-- Data for Name: platform; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.platform (id, name) FROM stdin;
1	Xbox
2	Playstation
3	PC
4	Switch
\.


--
-- Data for Name: game_platform; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.game_platform (id, "gameId", "platformId") FROM stdin;
8	1	1
9	1	2
10	1	3
11	2	1
12	2	2
13	2	3
14	2	4
15	3	3
16	4	1
17	4	2
18	4	3
19	4	4
20	6	1
21	6	2
22	6	3
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."user" (id, username, email, password) FROM stdin;
11	test3	test@test3.com	$2b$10$UO/aiuP3Vr/y0FffIS9ZKe9nGAtl3v91qO4CPVaCS6wu/LHL6uZja
12	test	testing@gmail.com	$2b$10$YkI2.4s68P6gtgq3ufUl3.vXnd9Mfp1Wc5mNUTpX.abW2PTkc5qyS
13	test2	testing2@gmail.com	$2b$10$/JuLkj6mOb7ZGjnWGSrZ7en9c2ch.ri0seR7TiYz4cyY3o8x.925G
15	test4	testing4@gmail.com	$2b$10$8Lclz8CZBsVNgC95rEYiv.gZtv5chDNsltaOXGkE5iGhdzlffZx2W
\.


--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.post (id, "userId", "gameId", description, "createdAt") FROM stdin;
45	12	2	test	2025-01-15 12:30:22.253053-06
\.


--
-- Data for Name: post_acceptance; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.post_acceptance (id, "postId", "userId", description) FROM stdin;
2	25	2	test
4	26	13	i want to join
5	32	13	test 2 accepts
6	32	15	test4 accepted post
7	33	13	test2 accepts
8	33	15	test4 accepts
9	45	13	I would love to join
\.


--
-- Data for Name: post_platform; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.post_platform (id, "postId", "platformId") FROM stdin;
52	45	1
\.


--
-- Data for Name: user_platform; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_platform (id, user_id, platform_id, platform_username) FROM stdin;
1	1	1	toejam
2	2	2	Earl
3	3	3	wildwilly
\.


--
-- Name: game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.game_id_seq', 6, true);


--
-- Name: game_platform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.game_platform_id_seq', 23, true);


--
-- Name: platform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.platform_id_seq', 4, true);


--
-- Name: post_acceptance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.post_acceptance_id_seq', 9, true);


--
-- Name: post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.post_id_seq', 45, true);


--
-- Name: post_platform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.post_platform_id_seq', 52, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_id_seq', 15, true);


--
-- Name: user_platform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_platform_id_seq', 3, true);


--
-- PostgreSQL database dump complete
--

