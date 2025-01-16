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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: game; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.game (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: game_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.game_id_seq OWNED BY public.game.id;


--
-- Name: game_platform; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.game_platform (
    id integer NOT NULL,
    "gameId" integer NOT NULL,
    "platformId" integer NOT NULL
);


--
-- Name: game_platform_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.game_platform_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: game_platform_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.game_platform_id_seq OWNED BY public.game_platform.id;


--
-- Name: platform; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.platform (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: platform_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.platform_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: platform_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.platform_id_seq OWNED BY public.platform.id;


--
-- Name: post; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "gameId" integer NOT NULL,
    description text NOT NULL,
    "createdAt" timestamp with time zone
);


--
-- Name: post_acceptance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post_acceptance (
    id integer NOT NULL,
    "postId" integer NOT NULL,
    "userId" integer NOT NULL,
    description text DEFAULT 'No description provided'::text
);


--
-- Name: post_acceptance_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.post_acceptance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_acceptance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.post_acceptance_id_seq OWNED BY public.post_acceptance.id;


--
-- Name: post_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.post_id_seq OWNED BY public.post.id;


--
-- Name: post_platform; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post_platform (
    id integer NOT NULL,
    "postId" integer NOT NULL,
    "platformId" integer NOT NULL
);


--
-- Name: post_platform_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.post_platform_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_platform_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.post_platform_id_seq OWNED BY public.post_platform.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL
);


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: user_platform; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_platform (
    id integer NOT NULL,
    user_id integer NOT NULL,
    platform_id integer NOT NULL,
    platform_username character varying(255) NOT NULL
);


--
-- Name: user_platform_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_platform_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_platform_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_platform_id_seq OWNED BY public.user_platform.id;


--
-- Name: game id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game ALTER COLUMN id SET DEFAULT nextval('public.game_id_seq'::regclass);


--
-- Name: game_platform id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_platform ALTER COLUMN id SET DEFAULT nextval('public.game_platform_id_seq'::regclass);


--
-- Name: platform id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform ALTER COLUMN id SET DEFAULT nextval('public.platform_id_seq'::regclass);


--
-- Name: post id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post ALTER COLUMN id SET DEFAULT nextval('public.post_id_seq'::regclass);


--
-- Name: post_acceptance id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_acceptance ALTER COLUMN id SET DEFAULT nextval('public.post_acceptance_id_seq'::regclass);


--
-- Name: post_platform id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_platform ALTER COLUMN id SET DEFAULT nextval('public.post_platform_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: user_platform id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_platform ALTER COLUMN id SET DEFAULT nextval('public.user_platform_id_seq'::regclass);


--
-- Name: game game_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key UNIQUE (name);


--
-- Name: game game_name_key1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key1 UNIQUE (name);


--
-- Name: game game_name_key10; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key10 UNIQUE (name);


--
-- Name: game game_name_key100; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key100 UNIQUE (name);


--
-- Name: game game_name_key101; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key101 UNIQUE (name);


--
-- Name: game game_name_key102; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key102 UNIQUE (name);


--
-- Name: game game_name_key103; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key103 UNIQUE (name);


--
-- Name: game game_name_key104; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key104 UNIQUE (name);


--
-- Name: game game_name_key105; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key105 UNIQUE (name);


--
-- Name: game game_name_key106; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key106 UNIQUE (name);


--
-- Name: game game_name_key107; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key107 UNIQUE (name);


--
-- Name: game game_name_key108; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key108 UNIQUE (name);


--
-- Name: game game_name_key109; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key109 UNIQUE (name);


--
-- Name: game game_name_key11; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key11 UNIQUE (name);


--
-- Name: game game_name_key110; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key110 UNIQUE (name);


--
-- Name: game game_name_key111; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key111 UNIQUE (name);


--
-- Name: game game_name_key112; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key112 UNIQUE (name);


--
-- Name: game game_name_key113; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key113 UNIQUE (name);


--
-- Name: game game_name_key114; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key114 UNIQUE (name);


--
-- Name: game game_name_key115; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key115 UNIQUE (name);


--
-- Name: game game_name_key116; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key116 UNIQUE (name);


--
-- Name: game game_name_key117; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key117 UNIQUE (name);


--
-- Name: game game_name_key118; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key118 UNIQUE (name);


--
-- Name: game game_name_key119; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key119 UNIQUE (name);


--
-- Name: game game_name_key12; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key12 UNIQUE (name);


--
-- Name: game game_name_key120; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key120 UNIQUE (name);


--
-- Name: game game_name_key121; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key121 UNIQUE (name);


--
-- Name: game game_name_key122; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key122 UNIQUE (name);


--
-- Name: game game_name_key123; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key123 UNIQUE (name);


--
-- Name: game game_name_key124; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key124 UNIQUE (name);


--
-- Name: game game_name_key125; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key125 UNIQUE (name);


--
-- Name: game game_name_key126; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key126 UNIQUE (name);


--
-- Name: game game_name_key127; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key127 UNIQUE (name);


--
-- Name: game game_name_key128; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key128 UNIQUE (name);


--
-- Name: game game_name_key129; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key129 UNIQUE (name);


--
-- Name: game game_name_key13; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key13 UNIQUE (name);


--
-- Name: game game_name_key130; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key130 UNIQUE (name);


--
-- Name: game game_name_key131; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key131 UNIQUE (name);


--
-- Name: game game_name_key132; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key132 UNIQUE (name);


--
-- Name: game game_name_key133; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key133 UNIQUE (name);


--
-- Name: game game_name_key134; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key134 UNIQUE (name);


--
-- Name: game game_name_key135; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key135 UNIQUE (name);


--
-- Name: game game_name_key136; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key136 UNIQUE (name);


--
-- Name: game game_name_key137; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key137 UNIQUE (name);


--
-- Name: game game_name_key138; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key138 UNIQUE (name);


--
-- Name: game game_name_key139; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key139 UNIQUE (name);


--
-- Name: game game_name_key14; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key14 UNIQUE (name);


--
-- Name: game game_name_key140; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key140 UNIQUE (name);


--
-- Name: game game_name_key141; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key141 UNIQUE (name);


--
-- Name: game game_name_key142; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key142 UNIQUE (name);


--
-- Name: game game_name_key143; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key143 UNIQUE (name);


--
-- Name: game game_name_key144; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key144 UNIQUE (name);


--
-- Name: game game_name_key145; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key145 UNIQUE (name);


--
-- Name: game game_name_key146; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key146 UNIQUE (name);


--
-- Name: game game_name_key147; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key147 UNIQUE (name);


--
-- Name: game game_name_key148; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key148 UNIQUE (name);


--
-- Name: game game_name_key149; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key149 UNIQUE (name);


--
-- Name: game game_name_key15; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key15 UNIQUE (name);


--
-- Name: game game_name_key150; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key150 UNIQUE (name);


--
-- Name: game game_name_key151; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key151 UNIQUE (name);


--
-- Name: game game_name_key152; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key152 UNIQUE (name);


--
-- Name: game game_name_key153; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key153 UNIQUE (name);


--
-- Name: game game_name_key154; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key154 UNIQUE (name);


--
-- Name: game game_name_key155; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key155 UNIQUE (name);


--
-- Name: game game_name_key156; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key156 UNIQUE (name);


--
-- Name: game game_name_key157; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key157 UNIQUE (name);


--
-- Name: game game_name_key158; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key158 UNIQUE (name);


--
-- Name: game game_name_key159; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key159 UNIQUE (name);


--
-- Name: game game_name_key16; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key16 UNIQUE (name);


--
-- Name: game game_name_key160; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key160 UNIQUE (name);


--
-- Name: game game_name_key161; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key161 UNIQUE (name);


--
-- Name: game game_name_key162; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key162 UNIQUE (name);


--
-- Name: game game_name_key163; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key163 UNIQUE (name);


--
-- Name: game game_name_key164; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key164 UNIQUE (name);


--
-- Name: game game_name_key165; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key165 UNIQUE (name);


--
-- Name: game game_name_key166; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key166 UNIQUE (name);


--
-- Name: game game_name_key167; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key167 UNIQUE (name);


--
-- Name: game game_name_key168; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key168 UNIQUE (name);


--
-- Name: game game_name_key169; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key169 UNIQUE (name);


--
-- Name: game game_name_key17; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key17 UNIQUE (name);


--
-- Name: game game_name_key170; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key170 UNIQUE (name);


--
-- Name: game game_name_key171; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key171 UNIQUE (name);


--
-- Name: game game_name_key172; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key172 UNIQUE (name);


--
-- Name: game game_name_key173; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key173 UNIQUE (name);


--
-- Name: game game_name_key174; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key174 UNIQUE (name);


--
-- Name: game game_name_key175; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key175 UNIQUE (name);


--
-- Name: game game_name_key176; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key176 UNIQUE (name);


--
-- Name: game game_name_key177; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key177 UNIQUE (name);


--
-- Name: game game_name_key178; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key178 UNIQUE (name);


--
-- Name: game game_name_key179; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key179 UNIQUE (name);


--
-- Name: game game_name_key18; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key18 UNIQUE (name);


--
-- Name: game game_name_key180; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key180 UNIQUE (name);


--
-- Name: game game_name_key181; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key181 UNIQUE (name);


--
-- Name: game game_name_key182; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key182 UNIQUE (name);


--
-- Name: game game_name_key183; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key183 UNIQUE (name);


--
-- Name: game game_name_key184; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key184 UNIQUE (name);


--
-- Name: game game_name_key185; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key185 UNIQUE (name);


--
-- Name: game game_name_key186; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key186 UNIQUE (name);


--
-- Name: game game_name_key187; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key187 UNIQUE (name);


--
-- Name: game game_name_key188; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key188 UNIQUE (name);


--
-- Name: game game_name_key189; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key189 UNIQUE (name);


--
-- Name: game game_name_key19; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key19 UNIQUE (name);


--
-- Name: game game_name_key190; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key190 UNIQUE (name);


--
-- Name: game game_name_key191; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key191 UNIQUE (name);


--
-- Name: game game_name_key192; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key192 UNIQUE (name);


--
-- Name: game game_name_key193; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key193 UNIQUE (name);


--
-- Name: game game_name_key194; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key194 UNIQUE (name);


--
-- Name: game game_name_key195; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key195 UNIQUE (name);


--
-- Name: game game_name_key196; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key196 UNIQUE (name);


--
-- Name: game game_name_key197; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key197 UNIQUE (name);


--
-- Name: game game_name_key198; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key198 UNIQUE (name);


--
-- Name: game game_name_key199; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key199 UNIQUE (name);


--
-- Name: game game_name_key2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key2 UNIQUE (name);


--
-- Name: game game_name_key20; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key20 UNIQUE (name);


--
-- Name: game game_name_key200; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key200 UNIQUE (name);


--
-- Name: game game_name_key201; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key201 UNIQUE (name);


--
-- Name: game game_name_key202; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key202 UNIQUE (name);


--
-- Name: game game_name_key203; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key203 UNIQUE (name);


--
-- Name: game game_name_key204; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key204 UNIQUE (name);


--
-- Name: game game_name_key205; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key205 UNIQUE (name);


--
-- Name: game game_name_key206; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key206 UNIQUE (name);


--
-- Name: game game_name_key207; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key207 UNIQUE (name);


--
-- Name: game game_name_key208; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key208 UNIQUE (name);


--
-- Name: game game_name_key209; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key209 UNIQUE (name);


--
-- Name: game game_name_key21; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key21 UNIQUE (name);


--
-- Name: game game_name_key210; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key210 UNIQUE (name);


--
-- Name: game game_name_key211; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key211 UNIQUE (name);


--
-- Name: game game_name_key212; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key212 UNIQUE (name);


--
-- Name: game game_name_key213; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key213 UNIQUE (name);


--
-- Name: game game_name_key214; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key214 UNIQUE (name);


--
-- Name: game game_name_key215; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key215 UNIQUE (name);


--
-- Name: game game_name_key216; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key216 UNIQUE (name);


--
-- Name: game game_name_key217; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key217 UNIQUE (name);


--
-- Name: game game_name_key218; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key218 UNIQUE (name);


--
-- Name: game game_name_key219; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key219 UNIQUE (name);


--
-- Name: game game_name_key22; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key22 UNIQUE (name);


--
-- Name: game game_name_key220; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key220 UNIQUE (name);


--
-- Name: game game_name_key221; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key221 UNIQUE (name);


--
-- Name: game game_name_key222; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key222 UNIQUE (name);


--
-- Name: game game_name_key223; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key223 UNIQUE (name);


--
-- Name: game game_name_key224; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key224 UNIQUE (name);


--
-- Name: game game_name_key225; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key225 UNIQUE (name);


--
-- Name: game game_name_key226; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key226 UNIQUE (name);


--
-- Name: game game_name_key227; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key227 UNIQUE (name);


--
-- Name: game game_name_key228; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key228 UNIQUE (name);


--
-- Name: game game_name_key229; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key229 UNIQUE (name);


--
-- Name: game game_name_key23; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key23 UNIQUE (name);


--
-- Name: game game_name_key230; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key230 UNIQUE (name);


--
-- Name: game game_name_key231; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key231 UNIQUE (name);


--
-- Name: game game_name_key232; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key232 UNIQUE (name);


--
-- Name: game game_name_key233; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key233 UNIQUE (name);


--
-- Name: game game_name_key234; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key234 UNIQUE (name);


--
-- Name: game game_name_key235; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key235 UNIQUE (name);


--
-- Name: game game_name_key236; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key236 UNIQUE (name);


--
-- Name: game game_name_key237; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key237 UNIQUE (name);


--
-- Name: game game_name_key238; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key238 UNIQUE (name);


--
-- Name: game game_name_key239; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key239 UNIQUE (name);


--
-- Name: game game_name_key24; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key24 UNIQUE (name);


--
-- Name: game game_name_key240; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key240 UNIQUE (name);


--
-- Name: game game_name_key241; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key241 UNIQUE (name);


--
-- Name: game game_name_key242; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key242 UNIQUE (name);


--
-- Name: game game_name_key243; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key243 UNIQUE (name);


--
-- Name: game game_name_key244; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key244 UNIQUE (name);


--
-- Name: game game_name_key245; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key245 UNIQUE (name);


--
-- Name: game game_name_key246; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key246 UNIQUE (name);


--
-- Name: game game_name_key247; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key247 UNIQUE (name);


--
-- Name: game game_name_key248; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key248 UNIQUE (name);


--
-- Name: game game_name_key249; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key249 UNIQUE (name);


--
-- Name: game game_name_key25; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key25 UNIQUE (name);


--
-- Name: game game_name_key250; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key250 UNIQUE (name);


--
-- Name: game game_name_key251; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key251 UNIQUE (name);


--
-- Name: game game_name_key252; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key252 UNIQUE (name);


--
-- Name: game game_name_key253; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key253 UNIQUE (name);


--
-- Name: game game_name_key254; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key254 UNIQUE (name);


--
-- Name: game game_name_key255; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key255 UNIQUE (name);


--
-- Name: game game_name_key256; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key256 UNIQUE (name);


--
-- Name: game game_name_key257; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key257 UNIQUE (name);


--
-- Name: game game_name_key258; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key258 UNIQUE (name);


--
-- Name: game game_name_key259; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key259 UNIQUE (name);


--
-- Name: game game_name_key26; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key26 UNIQUE (name);


--
-- Name: game game_name_key260; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key260 UNIQUE (name);


--
-- Name: game game_name_key261; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key261 UNIQUE (name);


--
-- Name: game game_name_key262; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key262 UNIQUE (name);


--
-- Name: game game_name_key263; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key263 UNIQUE (name);


--
-- Name: game game_name_key264; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key264 UNIQUE (name);


--
-- Name: game game_name_key265; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key265 UNIQUE (name);


--
-- Name: game game_name_key266; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key266 UNIQUE (name);


--
-- Name: game game_name_key267; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key267 UNIQUE (name);


--
-- Name: game game_name_key268; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key268 UNIQUE (name);


--
-- Name: game game_name_key269; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key269 UNIQUE (name);


--
-- Name: game game_name_key27; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key27 UNIQUE (name);


--
-- Name: game game_name_key270; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key270 UNIQUE (name);


--
-- Name: game game_name_key271; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key271 UNIQUE (name);


--
-- Name: game game_name_key272; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key272 UNIQUE (name);


--
-- Name: game game_name_key273; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key273 UNIQUE (name);


--
-- Name: game game_name_key274; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key274 UNIQUE (name);


--
-- Name: game game_name_key275; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key275 UNIQUE (name);


--
-- Name: game game_name_key276; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key276 UNIQUE (name);


--
-- Name: game game_name_key277; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key277 UNIQUE (name);


--
-- Name: game game_name_key278; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key278 UNIQUE (name);


--
-- Name: game game_name_key279; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key279 UNIQUE (name);


--
-- Name: game game_name_key28; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key28 UNIQUE (name);


--
-- Name: game game_name_key29; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key29 UNIQUE (name);


--
-- Name: game game_name_key3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key3 UNIQUE (name);


--
-- Name: game game_name_key30; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key30 UNIQUE (name);


--
-- Name: game game_name_key31; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key31 UNIQUE (name);


--
-- Name: game game_name_key32; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key32 UNIQUE (name);


--
-- Name: game game_name_key33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key33 UNIQUE (name);


--
-- Name: game game_name_key34; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key34 UNIQUE (name);


--
-- Name: game game_name_key35; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key35 UNIQUE (name);


--
-- Name: game game_name_key36; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key36 UNIQUE (name);


--
-- Name: game game_name_key37; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key37 UNIQUE (name);


--
-- Name: game game_name_key38; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key38 UNIQUE (name);


--
-- Name: game game_name_key39; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key39 UNIQUE (name);


--
-- Name: game game_name_key4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key4 UNIQUE (name);


--
-- Name: game game_name_key40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key40 UNIQUE (name);


--
-- Name: game game_name_key41; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key41 UNIQUE (name);


--
-- Name: game game_name_key42; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key42 UNIQUE (name);


--
-- Name: game game_name_key43; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key43 UNIQUE (name);


--
-- Name: game game_name_key44; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key44 UNIQUE (name);


--
-- Name: game game_name_key45; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key45 UNIQUE (name);


--
-- Name: game game_name_key46; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key46 UNIQUE (name);


--
-- Name: game game_name_key47; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key47 UNIQUE (name);


--
-- Name: game game_name_key48; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key48 UNIQUE (name);


--
-- Name: game game_name_key49; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key49 UNIQUE (name);


--
-- Name: game game_name_key5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key5 UNIQUE (name);


--
-- Name: game game_name_key50; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key50 UNIQUE (name);


--
-- Name: game game_name_key51; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key51 UNIQUE (name);


--
-- Name: game game_name_key52; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key52 UNIQUE (name);


--
-- Name: game game_name_key53; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key53 UNIQUE (name);


--
-- Name: game game_name_key54; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key54 UNIQUE (name);


--
-- Name: game game_name_key55; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key55 UNIQUE (name);


--
-- Name: game game_name_key56; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key56 UNIQUE (name);


--
-- Name: game game_name_key57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key57 UNIQUE (name);


--
-- Name: game game_name_key58; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key58 UNIQUE (name);


--
-- Name: game game_name_key59; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key59 UNIQUE (name);


--
-- Name: game game_name_key6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key6 UNIQUE (name);


--
-- Name: game game_name_key60; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key60 UNIQUE (name);


--
-- Name: game game_name_key61; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key61 UNIQUE (name);


--
-- Name: game game_name_key62; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key62 UNIQUE (name);


--
-- Name: game game_name_key63; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key63 UNIQUE (name);


--
-- Name: game game_name_key64; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key64 UNIQUE (name);


--
-- Name: game game_name_key65; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key65 UNIQUE (name);


--
-- Name: game game_name_key66; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key66 UNIQUE (name);


--
-- Name: game game_name_key67; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key67 UNIQUE (name);


--
-- Name: game game_name_key68; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key68 UNIQUE (name);


--
-- Name: game game_name_key69; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key69 UNIQUE (name);


--
-- Name: game game_name_key7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key7 UNIQUE (name);


--
-- Name: game game_name_key70; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key70 UNIQUE (name);


--
-- Name: game game_name_key71; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key71 UNIQUE (name);


--
-- Name: game game_name_key72; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key72 UNIQUE (name);


--
-- Name: game game_name_key73; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key73 UNIQUE (name);


--
-- Name: game game_name_key74; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key74 UNIQUE (name);


--
-- Name: game game_name_key75; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key75 UNIQUE (name);


--
-- Name: game game_name_key76; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key76 UNIQUE (name);


--
-- Name: game game_name_key77; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key77 UNIQUE (name);


--
-- Name: game game_name_key78; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key78 UNIQUE (name);


--
-- Name: game game_name_key79; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key79 UNIQUE (name);


--
-- Name: game game_name_key8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key8 UNIQUE (name);


--
-- Name: game game_name_key80; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key80 UNIQUE (name);


--
-- Name: game game_name_key81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key81 UNIQUE (name);


--
-- Name: game game_name_key82; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key82 UNIQUE (name);


--
-- Name: game game_name_key83; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key83 UNIQUE (name);


--
-- Name: game game_name_key84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key84 UNIQUE (name);


--
-- Name: game game_name_key85; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key85 UNIQUE (name);


--
-- Name: game game_name_key86; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key86 UNIQUE (name);


--
-- Name: game game_name_key87; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key87 UNIQUE (name);


--
-- Name: game game_name_key88; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key88 UNIQUE (name);


--
-- Name: game game_name_key89; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key89 UNIQUE (name);


--
-- Name: game game_name_key9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key9 UNIQUE (name);


--
-- Name: game game_name_key90; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key90 UNIQUE (name);


--
-- Name: game game_name_key91; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key91 UNIQUE (name);


--
-- Name: game game_name_key92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key92 UNIQUE (name);


--
-- Name: game game_name_key93; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key93 UNIQUE (name);


--
-- Name: game game_name_key94; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key94 UNIQUE (name);


--
-- Name: game game_name_key95; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key95 UNIQUE (name);


--
-- Name: game game_name_key96; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key96 UNIQUE (name);


--
-- Name: game game_name_key97; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key97 UNIQUE (name);


--
-- Name: game game_name_key98; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key98 UNIQUE (name);


--
-- Name: game game_name_key99; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key99 UNIQUE (name);


--
-- Name: game game_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_pkey PRIMARY KEY (id);


--
-- Name: game_platform game_platform_gameId_platformId_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_platform
    ADD CONSTRAINT "game_platform_gameId_platformId_key" UNIQUE ("gameId", "platformId");


--
-- Name: game_platform game_platform_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_platform
    ADD CONSTRAINT game_platform_pkey PRIMARY KEY (id);


--
-- Name: platform platform_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key UNIQUE (name);


--
-- Name: platform platform_name_key1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key1 UNIQUE (name);


--
-- Name: platform platform_name_key10; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key10 UNIQUE (name);


--
-- Name: platform platform_name_key100; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key100 UNIQUE (name);


--
-- Name: platform platform_name_key101; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key101 UNIQUE (name);


--
-- Name: platform platform_name_key102; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key102 UNIQUE (name);


--
-- Name: platform platform_name_key103; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key103 UNIQUE (name);


--
-- Name: platform platform_name_key104; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key104 UNIQUE (name);


--
-- Name: platform platform_name_key105; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key105 UNIQUE (name);


--
-- Name: platform platform_name_key106; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key106 UNIQUE (name);


--
-- Name: platform platform_name_key107; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key107 UNIQUE (name);


--
-- Name: platform platform_name_key108; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key108 UNIQUE (name);


--
-- Name: platform platform_name_key109; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key109 UNIQUE (name);


--
-- Name: platform platform_name_key11; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key11 UNIQUE (name);


--
-- Name: platform platform_name_key110; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key110 UNIQUE (name);


--
-- Name: platform platform_name_key111; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key111 UNIQUE (name);


--
-- Name: platform platform_name_key112; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key112 UNIQUE (name);


--
-- Name: platform platform_name_key113; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key113 UNIQUE (name);


--
-- Name: platform platform_name_key114; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key114 UNIQUE (name);


--
-- Name: platform platform_name_key115; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key115 UNIQUE (name);


--
-- Name: platform platform_name_key116; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key116 UNIQUE (name);


--
-- Name: platform platform_name_key117; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key117 UNIQUE (name);


--
-- Name: platform platform_name_key118; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key118 UNIQUE (name);


--
-- Name: platform platform_name_key119; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key119 UNIQUE (name);


--
-- Name: platform platform_name_key12; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key12 UNIQUE (name);


--
-- Name: platform platform_name_key120; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key120 UNIQUE (name);


--
-- Name: platform platform_name_key121; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key121 UNIQUE (name);


--
-- Name: platform platform_name_key122; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key122 UNIQUE (name);


--
-- Name: platform platform_name_key123; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key123 UNIQUE (name);


--
-- Name: platform platform_name_key124; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key124 UNIQUE (name);


--
-- Name: platform platform_name_key125; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key125 UNIQUE (name);


--
-- Name: platform platform_name_key126; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key126 UNIQUE (name);


--
-- Name: platform platform_name_key127; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key127 UNIQUE (name);


--
-- Name: platform platform_name_key128; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key128 UNIQUE (name);


--
-- Name: platform platform_name_key129; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key129 UNIQUE (name);


--
-- Name: platform platform_name_key13; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key13 UNIQUE (name);


--
-- Name: platform platform_name_key130; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key130 UNIQUE (name);


--
-- Name: platform platform_name_key131; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key131 UNIQUE (name);


--
-- Name: platform platform_name_key132; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key132 UNIQUE (name);


--
-- Name: platform platform_name_key133; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key133 UNIQUE (name);


--
-- Name: platform platform_name_key134; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key134 UNIQUE (name);


--
-- Name: platform platform_name_key135; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key135 UNIQUE (name);


--
-- Name: platform platform_name_key136; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key136 UNIQUE (name);


--
-- Name: platform platform_name_key137; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key137 UNIQUE (name);


--
-- Name: platform platform_name_key138; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key138 UNIQUE (name);


--
-- Name: platform platform_name_key139; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key139 UNIQUE (name);


--
-- Name: platform platform_name_key14; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key14 UNIQUE (name);


--
-- Name: platform platform_name_key140; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key140 UNIQUE (name);


--
-- Name: platform platform_name_key141; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key141 UNIQUE (name);


--
-- Name: platform platform_name_key142; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key142 UNIQUE (name);


--
-- Name: platform platform_name_key143; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key143 UNIQUE (name);


--
-- Name: platform platform_name_key144; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key144 UNIQUE (name);


--
-- Name: platform platform_name_key145; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key145 UNIQUE (name);


--
-- Name: platform platform_name_key146; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key146 UNIQUE (name);


--
-- Name: platform platform_name_key147; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key147 UNIQUE (name);


--
-- Name: platform platform_name_key148; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key148 UNIQUE (name);


--
-- Name: platform platform_name_key149; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key149 UNIQUE (name);


--
-- Name: platform platform_name_key15; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key15 UNIQUE (name);


--
-- Name: platform platform_name_key150; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key150 UNIQUE (name);


--
-- Name: platform platform_name_key151; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key151 UNIQUE (name);


--
-- Name: platform platform_name_key152; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key152 UNIQUE (name);


--
-- Name: platform platform_name_key153; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key153 UNIQUE (name);


--
-- Name: platform platform_name_key154; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key154 UNIQUE (name);


--
-- Name: platform platform_name_key155; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key155 UNIQUE (name);


--
-- Name: platform platform_name_key156; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key156 UNIQUE (name);


--
-- Name: platform platform_name_key157; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key157 UNIQUE (name);


--
-- Name: platform platform_name_key158; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key158 UNIQUE (name);


--
-- Name: platform platform_name_key159; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key159 UNIQUE (name);


--
-- Name: platform platform_name_key16; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key16 UNIQUE (name);


--
-- Name: platform platform_name_key160; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key160 UNIQUE (name);


--
-- Name: platform platform_name_key161; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key161 UNIQUE (name);


--
-- Name: platform platform_name_key162; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key162 UNIQUE (name);


--
-- Name: platform platform_name_key163; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key163 UNIQUE (name);


--
-- Name: platform platform_name_key164; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key164 UNIQUE (name);


--
-- Name: platform platform_name_key165; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key165 UNIQUE (name);


--
-- Name: platform platform_name_key166; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key166 UNIQUE (name);


--
-- Name: platform platform_name_key167; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key167 UNIQUE (name);


--
-- Name: platform platform_name_key168; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key168 UNIQUE (name);


--
-- Name: platform platform_name_key169; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key169 UNIQUE (name);


--
-- Name: platform platform_name_key17; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key17 UNIQUE (name);


--
-- Name: platform platform_name_key170; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key170 UNIQUE (name);


--
-- Name: platform platform_name_key171; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key171 UNIQUE (name);


--
-- Name: platform platform_name_key172; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key172 UNIQUE (name);


--
-- Name: platform platform_name_key173; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key173 UNIQUE (name);


--
-- Name: platform platform_name_key174; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key174 UNIQUE (name);


--
-- Name: platform platform_name_key175; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key175 UNIQUE (name);


--
-- Name: platform platform_name_key176; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key176 UNIQUE (name);


--
-- Name: platform platform_name_key177; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key177 UNIQUE (name);


--
-- Name: platform platform_name_key178; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key178 UNIQUE (name);


--
-- Name: platform platform_name_key179; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key179 UNIQUE (name);


--
-- Name: platform platform_name_key18; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key18 UNIQUE (name);


--
-- Name: platform platform_name_key180; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key180 UNIQUE (name);


--
-- Name: platform platform_name_key181; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key181 UNIQUE (name);


--
-- Name: platform platform_name_key182; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key182 UNIQUE (name);


--
-- Name: platform platform_name_key183; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key183 UNIQUE (name);


--
-- Name: platform platform_name_key184; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key184 UNIQUE (name);


--
-- Name: platform platform_name_key185; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key185 UNIQUE (name);


--
-- Name: platform platform_name_key186; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key186 UNIQUE (name);


--
-- Name: platform platform_name_key187; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key187 UNIQUE (name);


--
-- Name: platform platform_name_key188; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key188 UNIQUE (name);


--
-- Name: platform platform_name_key189; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key189 UNIQUE (name);


--
-- Name: platform platform_name_key19; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key19 UNIQUE (name);


--
-- Name: platform platform_name_key190; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key190 UNIQUE (name);


--
-- Name: platform platform_name_key191; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key191 UNIQUE (name);


--
-- Name: platform platform_name_key192; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key192 UNIQUE (name);


--
-- Name: platform platform_name_key193; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key193 UNIQUE (name);


--
-- Name: platform platform_name_key194; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key194 UNIQUE (name);


--
-- Name: platform platform_name_key195; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key195 UNIQUE (name);


--
-- Name: platform platform_name_key196; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key196 UNIQUE (name);


--
-- Name: platform platform_name_key197; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key197 UNIQUE (name);


--
-- Name: platform platform_name_key198; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key198 UNIQUE (name);


--
-- Name: platform platform_name_key199; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key199 UNIQUE (name);


--
-- Name: platform platform_name_key2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key2 UNIQUE (name);


--
-- Name: platform platform_name_key20; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key20 UNIQUE (name);


--
-- Name: platform platform_name_key200; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key200 UNIQUE (name);


--
-- Name: platform platform_name_key201; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key201 UNIQUE (name);


--
-- Name: platform platform_name_key202; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key202 UNIQUE (name);


--
-- Name: platform platform_name_key203; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key203 UNIQUE (name);


--
-- Name: platform platform_name_key204; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key204 UNIQUE (name);


--
-- Name: platform platform_name_key205; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key205 UNIQUE (name);


--
-- Name: platform platform_name_key206; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key206 UNIQUE (name);


--
-- Name: platform platform_name_key207; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key207 UNIQUE (name);


--
-- Name: platform platform_name_key208; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key208 UNIQUE (name);


--
-- Name: platform platform_name_key209; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key209 UNIQUE (name);


--
-- Name: platform platform_name_key21; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key21 UNIQUE (name);


--
-- Name: platform platform_name_key210; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key210 UNIQUE (name);


--
-- Name: platform platform_name_key211; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key211 UNIQUE (name);


--
-- Name: platform platform_name_key212; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key212 UNIQUE (name);


--
-- Name: platform platform_name_key213; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key213 UNIQUE (name);


--
-- Name: platform platform_name_key214; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key214 UNIQUE (name);


--
-- Name: platform platform_name_key215; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key215 UNIQUE (name);


--
-- Name: platform platform_name_key216; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key216 UNIQUE (name);


--
-- Name: platform platform_name_key217; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key217 UNIQUE (name);


--
-- Name: platform platform_name_key218; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key218 UNIQUE (name);


--
-- Name: platform platform_name_key219; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key219 UNIQUE (name);


--
-- Name: platform platform_name_key22; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key22 UNIQUE (name);


--
-- Name: platform platform_name_key220; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key220 UNIQUE (name);


--
-- Name: platform platform_name_key221; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key221 UNIQUE (name);


--
-- Name: platform platform_name_key222; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key222 UNIQUE (name);


--
-- Name: platform platform_name_key223; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key223 UNIQUE (name);


--
-- Name: platform platform_name_key224; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key224 UNIQUE (name);


--
-- Name: platform platform_name_key225; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key225 UNIQUE (name);


--
-- Name: platform platform_name_key226; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key226 UNIQUE (name);


--
-- Name: platform platform_name_key227; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key227 UNIQUE (name);


--
-- Name: platform platform_name_key228; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key228 UNIQUE (name);


--
-- Name: platform platform_name_key229; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key229 UNIQUE (name);


--
-- Name: platform platform_name_key23; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key23 UNIQUE (name);


--
-- Name: platform platform_name_key230; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key230 UNIQUE (name);


--
-- Name: platform platform_name_key231; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key231 UNIQUE (name);


--
-- Name: platform platform_name_key232; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key232 UNIQUE (name);


--
-- Name: platform platform_name_key233; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key233 UNIQUE (name);


--
-- Name: platform platform_name_key234; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key234 UNIQUE (name);


--
-- Name: platform platform_name_key235; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key235 UNIQUE (name);


--
-- Name: platform platform_name_key236; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key236 UNIQUE (name);


--
-- Name: platform platform_name_key237; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key237 UNIQUE (name);


--
-- Name: platform platform_name_key238; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key238 UNIQUE (name);


--
-- Name: platform platform_name_key239; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key239 UNIQUE (name);


--
-- Name: platform platform_name_key24; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key24 UNIQUE (name);


--
-- Name: platform platform_name_key240; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key240 UNIQUE (name);


--
-- Name: platform platform_name_key241; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key241 UNIQUE (name);


--
-- Name: platform platform_name_key242; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key242 UNIQUE (name);


--
-- Name: platform platform_name_key243; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key243 UNIQUE (name);


--
-- Name: platform platform_name_key244; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key244 UNIQUE (name);


--
-- Name: platform platform_name_key245; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key245 UNIQUE (name);


--
-- Name: platform platform_name_key246; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key246 UNIQUE (name);


--
-- Name: platform platform_name_key247; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key247 UNIQUE (name);


--
-- Name: platform platform_name_key248; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key248 UNIQUE (name);


--
-- Name: platform platform_name_key249; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key249 UNIQUE (name);


--
-- Name: platform platform_name_key25; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key25 UNIQUE (name);


--
-- Name: platform platform_name_key250; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key250 UNIQUE (name);


--
-- Name: platform platform_name_key251; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key251 UNIQUE (name);


--
-- Name: platform platform_name_key252; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key252 UNIQUE (name);


--
-- Name: platform platform_name_key253; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key253 UNIQUE (name);


--
-- Name: platform platform_name_key254; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key254 UNIQUE (name);


--
-- Name: platform platform_name_key255; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key255 UNIQUE (name);


--
-- Name: platform platform_name_key256; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key256 UNIQUE (name);


--
-- Name: platform platform_name_key257; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key257 UNIQUE (name);


--
-- Name: platform platform_name_key258; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key258 UNIQUE (name);


--
-- Name: platform platform_name_key259; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key259 UNIQUE (name);


--
-- Name: platform platform_name_key26; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key26 UNIQUE (name);


--
-- Name: platform platform_name_key260; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key260 UNIQUE (name);


--
-- Name: platform platform_name_key261; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key261 UNIQUE (name);


--
-- Name: platform platform_name_key262; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key262 UNIQUE (name);


--
-- Name: platform platform_name_key263; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key263 UNIQUE (name);


--
-- Name: platform platform_name_key264; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key264 UNIQUE (name);


--
-- Name: platform platform_name_key265; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key265 UNIQUE (name);


--
-- Name: platform platform_name_key266; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key266 UNIQUE (name);


--
-- Name: platform platform_name_key267; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key267 UNIQUE (name);


--
-- Name: platform platform_name_key268; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key268 UNIQUE (name);


--
-- Name: platform platform_name_key269; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key269 UNIQUE (name);


--
-- Name: platform platform_name_key27; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key27 UNIQUE (name);


--
-- Name: platform platform_name_key270; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key270 UNIQUE (name);


--
-- Name: platform platform_name_key271; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key271 UNIQUE (name);


--
-- Name: platform platform_name_key272; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key272 UNIQUE (name);


--
-- Name: platform platform_name_key273; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key273 UNIQUE (name);


--
-- Name: platform platform_name_key274; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key274 UNIQUE (name);


--
-- Name: platform platform_name_key275; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key275 UNIQUE (name);


--
-- Name: platform platform_name_key28; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key28 UNIQUE (name);


--
-- Name: platform platform_name_key29; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key29 UNIQUE (name);


--
-- Name: platform platform_name_key3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key3 UNIQUE (name);


--
-- Name: platform platform_name_key30; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key30 UNIQUE (name);


--
-- Name: platform platform_name_key31; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key31 UNIQUE (name);


--
-- Name: platform platform_name_key32; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key32 UNIQUE (name);


--
-- Name: platform platform_name_key33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key33 UNIQUE (name);


--
-- Name: platform platform_name_key34; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key34 UNIQUE (name);


--
-- Name: platform platform_name_key35; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key35 UNIQUE (name);


--
-- Name: platform platform_name_key36; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key36 UNIQUE (name);


--
-- Name: platform platform_name_key37; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key37 UNIQUE (name);


--
-- Name: platform platform_name_key38; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key38 UNIQUE (name);


--
-- Name: platform platform_name_key39; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key39 UNIQUE (name);


--
-- Name: platform platform_name_key4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key4 UNIQUE (name);


--
-- Name: platform platform_name_key40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key40 UNIQUE (name);


--
-- Name: platform platform_name_key41; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key41 UNIQUE (name);


--
-- Name: platform platform_name_key42; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key42 UNIQUE (name);


--
-- Name: platform platform_name_key43; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key43 UNIQUE (name);


--
-- Name: platform platform_name_key44; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key44 UNIQUE (name);


--
-- Name: platform platform_name_key45; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key45 UNIQUE (name);


--
-- Name: platform platform_name_key46; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key46 UNIQUE (name);


--
-- Name: platform platform_name_key47; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key47 UNIQUE (name);


--
-- Name: platform platform_name_key48; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key48 UNIQUE (name);


--
-- Name: platform platform_name_key49; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key49 UNIQUE (name);


--
-- Name: platform platform_name_key5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key5 UNIQUE (name);


--
-- Name: platform platform_name_key50; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key50 UNIQUE (name);


--
-- Name: platform platform_name_key51; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key51 UNIQUE (name);


--
-- Name: platform platform_name_key52; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key52 UNIQUE (name);


--
-- Name: platform platform_name_key53; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key53 UNIQUE (name);


--
-- Name: platform platform_name_key54; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key54 UNIQUE (name);


--
-- Name: platform platform_name_key55; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key55 UNIQUE (name);


--
-- Name: platform platform_name_key56; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key56 UNIQUE (name);


--
-- Name: platform platform_name_key57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key57 UNIQUE (name);


--
-- Name: platform platform_name_key58; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key58 UNIQUE (name);


--
-- Name: platform platform_name_key59; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key59 UNIQUE (name);


--
-- Name: platform platform_name_key6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key6 UNIQUE (name);


--
-- Name: platform platform_name_key60; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key60 UNIQUE (name);


--
-- Name: platform platform_name_key61; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key61 UNIQUE (name);


--
-- Name: platform platform_name_key62; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key62 UNIQUE (name);


--
-- Name: platform platform_name_key63; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key63 UNIQUE (name);


--
-- Name: platform platform_name_key64; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key64 UNIQUE (name);


--
-- Name: platform platform_name_key65; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key65 UNIQUE (name);


--
-- Name: platform platform_name_key66; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key66 UNIQUE (name);


--
-- Name: platform platform_name_key67; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key67 UNIQUE (name);


--
-- Name: platform platform_name_key68; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key68 UNIQUE (name);


--
-- Name: platform platform_name_key69; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key69 UNIQUE (name);


--
-- Name: platform platform_name_key7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key7 UNIQUE (name);


--
-- Name: platform platform_name_key70; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key70 UNIQUE (name);


--
-- Name: platform platform_name_key71; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key71 UNIQUE (name);


--
-- Name: platform platform_name_key72; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key72 UNIQUE (name);


--
-- Name: platform platform_name_key73; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key73 UNIQUE (name);


--
-- Name: platform platform_name_key74; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key74 UNIQUE (name);


--
-- Name: platform platform_name_key75; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key75 UNIQUE (name);


--
-- Name: platform platform_name_key76; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key76 UNIQUE (name);


--
-- Name: platform platform_name_key77; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key77 UNIQUE (name);


--
-- Name: platform platform_name_key78; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key78 UNIQUE (name);


--
-- Name: platform platform_name_key79; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key79 UNIQUE (name);


--
-- Name: platform platform_name_key8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key8 UNIQUE (name);


--
-- Name: platform platform_name_key80; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key80 UNIQUE (name);


--
-- Name: platform platform_name_key81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key81 UNIQUE (name);


--
-- Name: platform platform_name_key82; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key82 UNIQUE (name);


--
-- Name: platform platform_name_key83; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key83 UNIQUE (name);


--
-- Name: platform platform_name_key84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key84 UNIQUE (name);


--
-- Name: platform platform_name_key85; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key85 UNIQUE (name);


--
-- Name: platform platform_name_key86; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key86 UNIQUE (name);


--
-- Name: platform platform_name_key87; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key87 UNIQUE (name);


--
-- Name: platform platform_name_key88; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key88 UNIQUE (name);


--
-- Name: platform platform_name_key89; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key89 UNIQUE (name);


--
-- Name: platform platform_name_key9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key9 UNIQUE (name);


--
-- Name: platform platform_name_key90; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key90 UNIQUE (name);


--
-- Name: platform platform_name_key91; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key91 UNIQUE (name);


--
-- Name: platform platform_name_key92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key92 UNIQUE (name);


--
-- Name: platform platform_name_key93; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key93 UNIQUE (name);


--
-- Name: platform platform_name_key94; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key94 UNIQUE (name);


--
-- Name: platform platform_name_key95; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key95 UNIQUE (name);


--
-- Name: platform platform_name_key96; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key96 UNIQUE (name);


--
-- Name: platform platform_name_key97; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key97 UNIQUE (name);


--
-- Name: platform platform_name_key98; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key98 UNIQUE (name);


--
-- Name: platform platform_name_key99; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_name_key99 UNIQUE (name);


--
-- Name: platform platform_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_pkey PRIMARY KEY (id);


--
-- Name: post_acceptance post_acceptance_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_acceptance
    ADD CONSTRAINT post_acceptance_pkey PRIMARY KEY (id);


--
-- Name: post_acceptance post_acceptance_post_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_acceptance
    ADD CONSTRAINT post_acceptance_post_id_user_id_key UNIQUE ("postId", "userId");


--
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- Name: post_platform post_platform_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_platform
    ADD CONSTRAINT post_platform_pkey PRIMARY KEY (id);


--
-- Name: post_platform post_platform_postId_platformId_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_platform
    ADD CONSTRAINT "post_platform_postId_platformId_key" UNIQUE ("postId", "platformId");


--
-- Name: post unique_user_post; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT unique_user_post UNIQUE ("userId");


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_email_key1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key1 UNIQUE (email);


--
-- Name: user user_email_key10; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key10 UNIQUE (email);


--
-- Name: user user_email_key100; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key100 UNIQUE (email);


--
-- Name: user user_email_key101; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key101 UNIQUE (email);


--
-- Name: user user_email_key102; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key102 UNIQUE (email);


--
-- Name: user user_email_key103; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key103 UNIQUE (email);


--
-- Name: user user_email_key104; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key104 UNIQUE (email);


--
-- Name: user user_email_key105; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key105 UNIQUE (email);


--
-- Name: user user_email_key106; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key106 UNIQUE (email);


--
-- Name: user user_email_key107; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key107 UNIQUE (email);


--
-- Name: user user_email_key108; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key108 UNIQUE (email);


--
-- Name: user user_email_key109; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key109 UNIQUE (email);


--
-- Name: user user_email_key11; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key11 UNIQUE (email);


--
-- Name: user user_email_key110; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key110 UNIQUE (email);


--
-- Name: user user_email_key111; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key111 UNIQUE (email);


--
-- Name: user user_email_key112; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key112 UNIQUE (email);


--
-- Name: user user_email_key113; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key113 UNIQUE (email);


--
-- Name: user user_email_key114; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key114 UNIQUE (email);


--
-- Name: user user_email_key115; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key115 UNIQUE (email);


--
-- Name: user user_email_key116; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key116 UNIQUE (email);


--
-- Name: user user_email_key117; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key117 UNIQUE (email);


--
-- Name: user user_email_key118; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key118 UNIQUE (email);


--
-- Name: user user_email_key119; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key119 UNIQUE (email);


--
-- Name: user user_email_key12; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key12 UNIQUE (email);


--
-- Name: user user_email_key120; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key120 UNIQUE (email);


--
-- Name: user user_email_key121; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key121 UNIQUE (email);


--
-- Name: user user_email_key122; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key122 UNIQUE (email);


--
-- Name: user user_email_key123; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key123 UNIQUE (email);


--
-- Name: user user_email_key124; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key124 UNIQUE (email);


--
-- Name: user user_email_key125; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key125 UNIQUE (email);


--
-- Name: user user_email_key126; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key126 UNIQUE (email);


--
-- Name: user user_email_key127; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key127 UNIQUE (email);


--
-- Name: user user_email_key128; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key128 UNIQUE (email);


--
-- Name: user user_email_key129; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key129 UNIQUE (email);


--
-- Name: user user_email_key13; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key13 UNIQUE (email);


--
-- Name: user user_email_key130; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key130 UNIQUE (email);


--
-- Name: user user_email_key131; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key131 UNIQUE (email);


--
-- Name: user user_email_key132; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key132 UNIQUE (email);


--
-- Name: user user_email_key133; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key133 UNIQUE (email);


--
-- Name: user user_email_key134; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key134 UNIQUE (email);


--
-- Name: user user_email_key135; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key135 UNIQUE (email);


--
-- Name: user user_email_key136; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key136 UNIQUE (email);


--
-- Name: user user_email_key137; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key137 UNIQUE (email);


--
-- Name: user user_email_key138; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key138 UNIQUE (email);


--
-- Name: user user_email_key139; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key139 UNIQUE (email);


--
-- Name: user user_email_key14; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key14 UNIQUE (email);


--
-- Name: user user_email_key140; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key140 UNIQUE (email);


--
-- Name: user user_email_key141; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key141 UNIQUE (email);


--
-- Name: user user_email_key142; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key142 UNIQUE (email);


--
-- Name: user user_email_key143; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key143 UNIQUE (email);


--
-- Name: user user_email_key144; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key144 UNIQUE (email);


--
-- Name: user user_email_key145; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key145 UNIQUE (email);


--
-- Name: user user_email_key146; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key146 UNIQUE (email);


--
-- Name: user user_email_key147; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key147 UNIQUE (email);


--
-- Name: user user_email_key148; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key148 UNIQUE (email);


--
-- Name: user user_email_key149; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key149 UNIQUE (email);


--
-- Name: user user_email_key15; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key15 UNIQUE (email);


--
-- Name: user user_email_key150; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key150 UNIQUE (email);


--
-- Name: user user_email_key151; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key151 UNIQUE (email);


--
-- Name: user user_email_key152; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key152 UNIQUE (email);


--
-- Name: user user_email_key153; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key153 UNIQUE (email);


--
-- Name: user user_email_key154; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key154 UNIQUE (email);


--
-- Name: user user_email_key155; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key155 UNIQUE (email);


--
-- Name: user user_email_key156; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key156 UNIQUE (email);


--
-- Name: user user_email_key157; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key157 UNIQUE (email);


--
-- Name: user user_email_key158; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key158 UNIQUE (email);


--
-- Name: user user_email_key159; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key159 UNIQUE (email);


--
-- Name: user user_email_key16; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key16 UNIQUE (email);


--
-- Name: user user_email_key160; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key160 UNIQUE (email);


--
-- Name: user user_email_key161; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key161 UNIQUE (email);


--
-- Name: user user_email_key162; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key162 UNIQUE (email);


--
-- Name: user user_email_key163; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key163 UNIQUE (email);


--
-- Name: user user_email_key164; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key164 UNIQUE (email);


--
-- Name: user user_email_key165; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key165 UNIQUE (email);


--
-- Name: user user_email_key166; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key166 UNIQUE (email);


--
-- Name: user user_email_key167; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key167 UNIQUE (email);


--
-- Name: user user_email_key168; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key168 UNIQUE (email);


--
-- Name: user user_email_key169; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key169 UNIQUE (email);


--
-- Name: user user_email_key17; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key17 UNIQUE (email);


--
-- Name: user user_email_key170; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key170 UNIQUE (email);


--
-- Name: user user_email_key171; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key171 UNIQUE (email);


--
-- Name: user user_email_key172; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key172 UNIQUE (email);


--
-- Name: user user_email_key173; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key173 UNIQUE (email);


--
-- Name: user user_email_key174; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key174 UNIQUE (email);


--
-- Name: user user_email_key175; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key175 UNIQUE (email);


--
-- Name: user user_email_key176; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key176 UNIQUE (email);


--
-- Name: user user_email_key177; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key177 UNIQUE (email);


--
-- Name: user user_email_key178; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key178 UNIQUE (email);


--
-- Name: user user_email_key179; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key179 UNIQUE (email);


--
-- Name: user user_email_key18; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key18 UNIQUE (email);


--
-- Name: user user_email_key180; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key180 UNIQUE (email);


--
-- Name: user user_email_key181; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key181 UNIQUE (email);


--
-- Name: user user_email_key182; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key182 UNIQUE (email);


--
-- Name: user user_email_key183; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key183 UNIQUE (email);


--
-- Name: user user_email_key184; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key184 UNIQUE (email);


--
-- Name: user user_email_key185; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key185 UNIQUE (email);


--
-- Name: user user_email_key186; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key186 UNIQUE (email);


--
-- Name: user user_email_key187; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key187 UNIQUE (email);


--
-- Name: user user_email_key188; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key188 UNIQUE (email);


--
-- Name: user user_email_key189; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key189 UNIQUE (email);


--
-- Name: user user_email_key19; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key19 UNIQUE (email);


--
-- Name: user user_email_key190; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key190 UNIQUE (email);


--
-- Name: user user_email_key191; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key191 UNIQUE (email);


--
-- Name: user user_email_key192; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key192 UNIQUE (email);


--
-- Name: user user_email_key193; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key193 UNIQUE (email);


--
-- Name: user user_email_key194; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key194 UNIQUE (email);


--
-- Name: user user_email_key195; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key195 UNIQUE (email);


--
-- Name: user user_email_key196; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key196 UNIQUE (email);


--
-- Name: user user_email_key197; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key197 UNIQUE (email);


--
-- Name: user user_email_key198; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key198 UNIQUE (email);


--
-- Name: user user_email_key199; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key199 UNIQUE (email);


--
-- Name: user user_email_key2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key2 UNIQUE (email);


--
-- Name: user user_email_key20; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key20 UNIQUE (email);


--
-- Name: user user_email_key200; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key200 UNIQUE (email);


--
-- Name: user user_email_key201; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key201 UNIQUE (email);


--
-- Name: user user_email_key202; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key202 UNIQUE (email);


--
-- Name: user user_email_key203; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key203 UNIQUE (email);


--
-- Name: user user_email_key204; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key204 UNIQUE (email);


--
-- Name: user user_email_key205; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key205 UNIQUE (email);


--
-- Name: user user_email_key206; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key206 UNIQUE (email);


--
-- Name: user user_email_key207; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key207 UNIQUE (email);


--
-- Name: user user_email_key208; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key208 UNIQUE (email);


--
-- Name: user user_email_key209; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key209 UNIQUE (email);


--
-- Name: user user_email_key21; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key21 UNIQUE (email);


--
-- Name: user user_email_key210; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key210 UNIQUE (email);


--
-- Name: user user_email_key211; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key211 UNIQUE (email);


--
-- Name: user user_email_key212; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key212 UNIQUE (email);


--
-- Name: user user_email_key213; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key213 UNIQUE (email);


--
-- Name: user user_email_key214; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key214 UNIQUE (email);


--
-- Name: user user_email_key215; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key215 UNIQUE (email);


--
-- Name: user user_email_key216; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key216 UNIQUE (email);


--
-- Name: user user_email_key217; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key217 UNIQUE (email);


--
-- Name: user user_email_key218; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key218 UNIQUE (email);


--
-- Name: user user_email_key219; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key219 UNIQUE (email);


--
-- Name: user user_email_key22; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key22 UNIQUE (email);


--
-- Name: user user_email_key220; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key220 UNIQUE (email);


--
-- Name: user user_email_key221; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key221 UNIQUE (email);


--
-- Name: user user_email_key222; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key222 UNIQUE (email);


--
-- Name: user user_email_key223; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key223 UNIQUE (email);


--
-- Name: user user_email_key224; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key224 UNIQUE (email);


--
-- Name: user user_email_key225; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key225 UNIQUE (email);


--
-- Name: user user_email_key226; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key226 UNIQUE (email);


--
-- Name: user user_email_key227; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key227 UNIQUE (email);


--
-- Name: user user_email_key228; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key228 UNIQUE (email);


--
-- Name: user user_email_key229; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key229 UNIQUE (email);


--
-- Name: user user_email_key23; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key23 UNIQUE (email);


--
-- Name: user user_email_key230; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key230 UNIQUE (email);


--
-- Name: user user_email_key231; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key231 UNIQUE (email);


--
-- Name: user user_email_key232; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key232 UNIQUE (email);


--
-- Name: user user_email_key233; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key233 UNIQUE (email);


--
-- Name: user user_email_key234; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key234 UNIQUE (email);


--
-- Name: user user_email_key235; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key235 UNIQUE (email);


--
-- Name: user user_email_key236; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key236 UNIQUE (email);


--
-- Name: user user_email_key237; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key237 UNIQUE (email);


--
-- Name: user user_email_key238; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key238 UNIQUE (email);


--
-- Name: user user_email_key239; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key239 UNIQUE (email);


--
-- Name: user user_email_key24; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key24 UNIQUE (email);


--
-- Name: user user_email_key240; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key240 UNIQUE (email);


--
-- Name: user user_email_key241; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key241 UNIQUE (email);


--
-- Name: user user_email_key242; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key242 UNIQUE (email);


--
-- Name: user user_email_key243; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key243 UNIQUE (email);


--
-- Name: user user_email_key244; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key244 UNIQUE (email);


--
-- Name: user user_email_key245; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key245 UNIQUE (email);


--
-- Name: user user_email_key246; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key246 UNIQUE (email);


--
-- Name: user user_email_key247; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key247 UNIQUE (email);


--
-- Name: user user_email_key248; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key248 UNIQUE (email);


--
-- Name: user user_email_key249; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key249 UNIQUE (email);


--
-- Name: user user_email_key25; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key25 UNIQUE (email);


--
-- Name: user user_email_key250; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key250 UNIQUE (email);


--
-- Name: user user_email_key251; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key251 UNIQUE (email);


--
-- Name: user user_email_key252; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key252 UNIQUE (email);


--
-- Name: user user_email_key253; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key253 UNIQUE (email);


--
-- Name: user user_email_key254; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key254 UNIQUE (email);


--
-- Name: user user_email_key255; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key255 UNIQUE (email);


--
-- Name: user user_email_key256; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key256 UNIQUE (email);


--
-- Name: user user_email_key257; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key257 UNIQUE (email);


--
-- Name: user user_email_key258; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key258 UNIQUE (email);


--
-- Name: user user_email_key259; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key259 UNIQUE (email);


--
-- Name: user user_email_key26; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key26 UNIQUE (email);


--
-- Name: user user_email_key260; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key260 UNIQUE (email);


--
-- Name: user user_email_key261; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key261 UNIQUE (email);


--
-- Name: user user_email_key262; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key262 UNIQUE (email);


--
-- Name: user user_email_key263; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key263 UNIQUE (email);


--
-- Name: user user_email_key264; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key264 UNIQUE (email);


--
-- Name: user user_email_key265; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key265 UNIQUE (email);


--
-- Name: user user_email_key266; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key266 UNIQUE (email);


--
-- Name: user user_email_key267; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key267 UNIQUE (email);


--
-- Name: user user_email_key268; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key268 UNIQUE (email);


--
-- Name: user user_email_key269; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key269 UNIQUE (email);


--
-- Name: user user_email_key27; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key27 UNIQUE (email);


--
-- Name: user user_email_key270; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key270 UNIQUE (email);


--
-- Name: user user_email_key271; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key271 UNIQUE (email);


--
-- Name: user user_email_key272; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key272 UNIQUE (email);


--
-- Name: user user_email_key273; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key273 UNIQUE (email);


--
-- Name: user user_email_key274; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key274 UNIQUE (email);


--
-- Name: user user_email_key275; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key275 UNIQUE (email);


--
-- Name: user user_email_key276; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key276 UNIQUE (email);


--
-- Name: user user_email_key277; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key277 UNIQUE (email);


--
-- Name: user user_email_key278; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key278 UNIQUE (email);


--
-- Name: user user_email_key279; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key279 UNIQUE (email);


--
-- Name: user user_email_key28; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key28 UNIQUE (email);


--
-- Name: user user_email_key280; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key280 UNIQUE (email);


--
-- Name: user user_email_key281; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key281 UNIQUE (email);


--
-- Name: user user_email_key282; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key282 UNIQUE (email);


--
-- Name: user user_email_key29; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key29 UNIQUE (email);


--
-- Name: user user_email_key3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key3 UNIQUE (email);


--
-- Name: user user_email_key30; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key30 UNIQUE (email);


--
-- Name: user user_email_key31; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key31 UNIQUE (email);


--
-- Name: user user_email_key32; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key32 UNIQUE (email);


--
-- Name: user user_email_key33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key33 UNIQUE (email);


--
-- Name: user user_email_key34; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key34 UNIQUE (email);


--
-- Name: user user_email_key35; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key35 UNIQUE (email);


--
-- Name: user user_email_key36; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key36 UNIQUE (email);


--
-- Name: user user_email_key37; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key37 UNIQUE (email);


--
-- Name: user user_email_key38; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key38 UNIQUE (email);


--
-- Name: user user_email_key39; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key39 UNIQUE (email);


--
-- Name: user user_email_key4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key4 UNIQUE (email);


--
-- Name: user user_email_key40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key40 UNIQUE (email);


--
-- Name: user user_email_key41; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key41 UNIQUE (email);


--
-- Name: user user_email_key42; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key42 UNIQUE (email);


--
-- Name: user user_email_key43; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key43 UNIQUE (email);


--
-- Name: user user_email_key44; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key44 UNIQUE (email);


--
-- Name: user user_email_key45; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key45 UNIQUE (email);


--
-- Name: user user_email_key46; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key46 UNIQUE (email);


--
-- Name: user user_email_key47; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key47 UNIQUE (email);


--
-- Name: user user_email_key48; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key48 UNIQUE (email);


--
-- Name: user user_email_key49; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key49 UNIQUE (email);


--
-- Name: user user_email_key5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key5 UNIQUE (email);


--
-- Name: user user_email_key50; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key50 UNIQUE (email);


--
-- Name: user user_email_key51; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key51 UNIQUE (email);


--
-- Name: user user_email_key52; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key52 UNIQUE (email);


--
-- Name: user user_email_key53; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key53 UNIQUE (email);


--
-- Name: user user_email_key54; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key54 UNIQUE (email);


--
-- Name: user user_email_key55; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key55 UNIQUE (email);


--
-- Name: user user_email_key56; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key56 UNIQUE (email);


--
-- Name: user user_email_key57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key57 UNIQUE (email);


--
-- Name: user user_email_key58; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key58 UNIQUE (email);


--
-- Name: user user_email_key59; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key59 UNIQUE (email);


--
-- Name: user user_email_key6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key6 UNIQUE (email);


--
-- Name: user user_email_key60; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key60 UNIQUE (email);


--
-- Name: user user_email_key61; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key61 UNIQUE (email);


--
-- Name: user user_email_key62; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key62 UNIQUE (email);


--
-- Name: user user_email_key63; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key63 UNIQUE (email);


--
-- Name: user user_email_key64; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key64 UNIQUE (email);


--
-- Name: user user_email_key65; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key65 UNIQUE (email);


--
-- Name: user user_email_key66; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key66 UNIQUE (email);


--
-- Name: user user_email_key67; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key67 UNIQUE (email);


--
-- Name: user user_email_key68; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key68 UNIQUE (email);


--
-- Name: user user_email_key69; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key69 UNIQUE (email);


--
-- Name: user user_email_key7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key7 UNIQUE (email);


--
-- Name: user user_email_key70; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key70 UNIQUE (email);


--
-- Name: user user_email_key71; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key71 UNIQUE (email);


--
-- Name: user user_email_key72; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key72 UNIQUE (email);


--
-- Name: user user_email_key73; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key73 UNIQUE (email);


--
-- Name: user user_email_key74; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key74 UNIQUE (email);


--
-- Name: user user_email_key75; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key75 UNIQUE (email);


--
-- Name: user user_email_key76; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key76 UNIQUE (email);


--
-- Name: user user_email_key77; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key77 UNIQUE (email);


--
-- Name: user user_email_key78; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key78 UNIQUE (email);


--
-- Name: user user_email_key79; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key79 UNIQUE (email);


--
-- Name: user user_email_key8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key8 UNIQUE (email);


--
-- Name: user user_email_key80; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key80 UNIQUE (email);


--
-- Name: user user_email_key81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key81 UNIQUE (email);


--
-- Name: user user_email_key82; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key82 UNIQUE (email);


--
-- Name: user user_email_key83; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key83 UNIQUE (email);


--
-- Name: user user_email_key84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key84 UNIQUE (email);


--
-- Name: user user_email_key85; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key85 UNIQUE (email);


--
-- Name: user user_email_key86; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key86 UNIQUE (email);


--
-- Name: user user_email_key87; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key87 UNIQUE (email);


--
-- Name: user user_email_key88; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key88 UNIQUE (email);


--
-- Name: user user_email_key89; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key89 UNIQUE (email);


--
-- Name: user user_email_key9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key9 UNIQUE (email);


--
-- Name: user user_email_key90; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key90 UNIQUE (email);


--
-- Name: user user_email_key91; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key91 UNIQUE (email);


--
-- Name: user user_email_key92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key92 UNIQUE (email);


--
-- Name: user user_email_key93; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key93 UNIQUE (email);


--
-- Name: user user_email_key94; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key94 UNIQUE (email);


--
-- Name: user user_email_key95; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key95 UNIQUE (email);


--
-- Name: user user_email_key96; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key96 UNIQUE (email);


--
-- Name: user user_email_key97; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key97 UNIQUE (email);


--
-- Name: user user_email_key98; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key98 UNIQUE (email);


--
-- Name: user user_email_key99; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key99 UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_platform user_platform_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_platform
    ADD CONSTRAINT user_platform_pkey PRIMARY KEY (id);


--
-- Name: user_platform user_platform_user_id_platform_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_platform
    ADD CONSTRAINT user_platform_user_id_platform_id_key UNIQUE (user_id, platform_id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: user user_username_key1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key1 UNIQUE (username);


--
-- Name: user user_username_key10; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key10 UNIQUE (username);


--
-- Name: user user_username_key100; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key100 UNIQUE (username);


--
-- Name: user user_username_key101; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key101 UNIQUE (username);


--
-- Name: user user_username_key102; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key102 UNIQUE (username);


--
-- Name: user user_username_key103; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key103 UNIQUE (username);


--
-- Name: user user_username_key104; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key104 UNIQUE (username);


--
-- Name: user user_username_key105; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key105 UNIQUE (username);


--
-- Name: user user_username_key106; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key106 UNIQUE (username);


--
-- Name: user user_username_key107; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key107 UNIQUE (username);


--
-- Name: user user_username_key108; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key108 UNIQUE (username);


--
-- Name: user user_username_key109; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key109 UNIQUE (username);


--
-- Name: user user_username_key11; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key11 UNIQUE (username);


--
-- Name: user user_username_key110; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key110 UNIQUE (username);


--
-- Name: user user_username_key111; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key111 UNIQUE (username);


--
-- Name: user user_username_key112; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key112 UNIQUE (username);


--
-- Name: user user_username_key113; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key113 UNIQUE (username);


--
-- Name: user user_username_key114; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key114 UNIQUE (username);


--
-- Name: user user_username_key115; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key115 UNIQUE (username);


--
-- Name: user user_username_key116; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key116 UNIQUE (username);


--
-- Name: user user_username_key117; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key117 UNIQUE (username);


--
-- Name: user user_username_key118; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key118 UNIQUE (username);


--
-- Name: user user_username_key119; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key119 UNIQUE (username);


--
-- Name: user user_username_key12; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key12 UNIQUE (username);


--
-- Name: user user_username_key120; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key120 UNIQUE (username);


--
-- Name: user user_username_key121; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key121 UNIQUE (username);


--
-- Name: user user_username_key122; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key122 UNIQUE (username);


--
-- Name: user user_username_key123; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key123 UNIQUE (username);


--
-- Name: user user_username_key124; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key124 UNIQUE (username);


--
-- Name: user user_username_key125; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key125 UNIQUE (username);


--
-- Name: user user_username_key126; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key126 UNIQUE (username);


--
-- Name: user user_username_key127; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key127 UNIQUE (username);


--
-- Name: user user_username_key128; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key128 UNIQUE (username);


--
-- Name: user user_username_key129; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key129 UNIQUE (username);


--
-- Name: user user_username_key13; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key13 UNIQUE (username);


--
-- Name: user user_username_key130; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key130 UNIQUE (username);


--
-- Name: user user_username_key131; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key131 UNIQUE (username);


--
-- Name: user user_username_key132; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key132 UNIQUE (username);


--
-- Name: user user_username_key133; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key133 UNIQUE (username);


--
-- Name: user user_username_key134; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key134 UNIQUE (username);


--
-- Name: user user_username_key135; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key135 UNIQUE (username);


--
-- Name: user user_username_key136; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key136 UNIQUE (username);


--
-- Name: user user_username_key137; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key137 UNIQUE (username);


--
-- Name: user user_username_key138; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key138 UNIQUE (username);


--
-- Name: user user_username_key139; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key139 UNIQUE (username);


--
-- Name: user user_username_key14; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key14 UNIQUE (username);


--
-- Name: user user_username_key140; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key140 UNIQUE (username);


--
-- Name: user user_username_key141; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key141 UNIQUE (username);


--
-- Name: user user_username_key142; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key142 UNIQUE (username);


--
-- Name: user user_username_key143; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key143 UNIQUE (username);


--
-- Name: user user_username_key144; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key144 UNIQUE (username);


--
-- Name: user user_username_key145; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key145 UNIQUE (username);


--
-- Name: user user_username_key146; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key146 UNIQUE (username);


--
-- Name: user user_username_key147; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key147 UNIQUE (username);


--
-- Name: user user_username_key148; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key148 UNIQUE (username);


--
-- Name: user user_username_key149; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key149 UNIQUE (username);


--
-- Name: user user_username_key15; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key15 UNIQUE (username);


--
-- Name: user user_username_key150; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key150 UNIQUE (username);


--
-- Name: user user_username_key151; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key151 UNIQUE (username);


--
-- Name: user user_username_key152; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key152 UNIQUE (username);


--
-- Name: user user_username_key153; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key153 UNIQUE (username);


--
-- Name: user user_username_key154; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key154 UNIQUE (username);


--
-- Name: user user_username_key155; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key155 UNIQUE (username);


--
-- Name: user user_username_key156; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key156 UNIQUE (username);


--
-- Name: user user_username_key157; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key157 UNIQUE (username);


--
-- Name: user user_username_key158; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key158 UNIQUE (username);


--
-- Name: user user_username_key159; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key159 UNIQUE (username);


--
-- Name: user user_username_key16; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key16 UNIQUE (username);


--
-- Name: user user_username_key160; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key160 UNIQUE (username);


--
-- Name: user user_username_key161; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key161 UNIQUE (username);


--
-- Name: user user_username_key162; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key162 UNIQUE (username);


--
-- Name: user user_username_key163; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key163 UNIQUE (username);


--
-- Name: user user_username_key164; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key164 UNIQUE (username);


--
-- Name: user user_username_key165; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key165 UNIQUE (username);


--
-- Name: user user_username_key166; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key166 UNIQUE (username);


--
-- Name: user user_username_key167; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key167 UNIQUE (username);


--
-- Name: user user_username_key168; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key168 UNIQUE (username);


--
-- Name: user user_username_key169; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key169 UNIQUE (username);


--
-- Name: user user_username_key17; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key17 UNIQUE (username);


--
-- Name: user user_username_key170; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key170 UNIQUE (username);


--
-- Name: user user_username_key171; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key171 UNIQUE (username);


--
-- Name: user user_username_key172; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key172 UNIQUE (username);


--
-- Name: user user_username_key173; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key173 UNIQUE (username);


--
-- Name: user user_username_key174; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key174 UNIQUE (username);


--
-- Name: user user_username_key175; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key175 UNIQUE (username);


--
-- Name: user user_username_key176; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key176 UNIQUE (username);


--
-- Name: user user_username_key177; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key177 UNIQUE (username);


--
-- Name: user user_username_key178; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key178 UNIQUE (username);


--
-- Name: user user_username_key179; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key179 UNIQUE (username);


--
-- Name: user user_username_key18; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key18 UNIQUE (username);


--
-- Name: user user_username_key180; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key180 UNIQUE (username);


--
-- Name: user user_username_key181; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key181 UNIQUE (username);


--
-- Name: user user_username_key182; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key182 UNIQUE (username);


--
-- Name: user user_username_key183; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key183 UNIQUE (username);


--
-- Name: user user_username_key184; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key184 UNIQUE (username);


--
-- Name: user user_username_key185; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key185 UNIQUE (username);


--
-- Name: user user_username_key186; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key186 UNIQUE (username);


--
-- Name: user user_username_key187; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key187 UNIQUE (username);


--
-- Name: user user_username_key188; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key188 UNIQUE (username);


--
-- Name: user user_username_key189; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key189 UNIQUE (username);


--
-- Name: user user_username_key19; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key19 UNIQUE (username);


--
-- Name: user user_username_key190; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key190 UNIQUE (username);


--
-- Name: user user_username_key191; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key191 UNIQUE (username);


--
-- Name: user user_username_key192; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key192 UNIQUE (username);


--
-- Name: user user_username_key193; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key193 UNIQUE (username);


--
-- Name: user user_username_key194; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key194 UNIQUE (username);


--
-- Name: user user_username_key195; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key195 UNIQUE (username);


--
-- Name: user user_username_key196; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key196 UNIQUE (username);


--
-- Name: user user_username_key197; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key197 UNIQUE (username);


--
-- Name: user user_username_key198; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key198 UNIQUE (username);


--
-- Name: user user_username_key199; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key199 UNIQUE (username);


--
-- Name: user user_username_key2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key2 UNIQUE (username);


--
-- Name: user user_username_key20; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key20 UNIQUE (username);


--
-- Name: user user_username_key200; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key200 UNIQUE (username);


--
-- Name: user user_username_key201; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key201 UNIQUE (username);


--
-- Name: user user_username_key202; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key202 UNIQUE (username);


--
-- Name: user user_username_key203; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key203 UNIQUE (username);


--
-- Name: user user_username_key204; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key204 UNIQUE (username);


--
-- Name: user user_username_key205; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key205 UNIQUE (username);


--
-- Name: user user_username_key206; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key206 UNIQUE (username);


--
-- Name: user user_username_key207; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key207 UNIQUE (username);


--
-- Name: user user_username_key208; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key208 UNIQUE (username);


--
-- Name: user user_username_key209; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key209 UNIQUE (username);


--
-- Name: user user_username_key21; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key21 UNIQUE (username);


--
-- Name: user user_username_key210; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key210 UNIQUE (username);


--
-- Name: user user_username_key211; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key211 UNIQUE (username);


--
-- Name: user user_username_key212; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key212 UNIQUE (username);


--
-- Name: user user_username_key213; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key213 UNIQUE (username);


--
-- Name: user user_username_key214; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key214 UNIQUE (username);


--
-- Name: user user_username_key215; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key215 UNIQUE (username);


--
-- Name: user user_username_key216; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key216 UNIQUE (username);


--
-- Name: user user_username_key217; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key217 UNIQUE (username);


--
-- Name: user user_username_key218; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key218 UNIQUE (username);


--
-- Name: user user_username_key219; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key219 UNIQUE (username);


--
-- Name: user user_username_key22; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key22 UNIQUE (username);


--
-- Name: user user_username_key220; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key220 UNIQUE (username);


--
-- Name: user user_username_key221; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key221 UNIQUE (username);


--
-- Name: user user_username_key222; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key222 UNIQUE (username);


--
-- Name: user user_username_key223; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key223 UNIQUE (username);


--
-- Name: user user_username_key224; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key224 UNIQUE (username);


--
-- Name: user user_username_key225; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key225 UNIQUE (username);


--
-- Name: user user_username_key226; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key226 UNIQUE (username);


--
-- Name: user user_username_key227; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key227 UNIQUE (username);


--
-- Name: user user_username_key228; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key228 UNIQUE (username);


--
-- Name: user user_username_key229; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key229 UNIQUE (username);


--
-- Name: user user_username_key23; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key23 UNIQUE (username);


--
-- Name: user user_username_key230; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key230 UNIQUE (username);


--
-- Name: user user_username_key231; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key231 UNIQUE (username);


--
-- Name: user user_username_key232; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key232 UNIQUE (username);


--
-- Name: user user_username_key233; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key233 UNIQUE (username);


--
-- Name: user user_username_key234; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key234 UNIQUE (username);


--
-- Name: user user_username_key235; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key235 UNIQUE (username);


--
-- Name: user user_username_key236; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key236 UNIQUE (username);


--
-- Name: user user_username_key237; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key237 UNIQUE (username);


--
-- Name: user user_username_key238; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key238 UNIQUE (username);


--
-- Name: user user_username_key239; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key239 UNIQUE (username);


--
-- Name: user user_username_key24; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key24 UNIQUE (username);


--
-- Name: user user_username_key240; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key240 UNIQUE (username);


--
-- Name: user user_username_key241; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key241 UNIQUE (username);


--
-- Name: user user_username_key242; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key242 UNIQUE (username);


--
-- Name: user user_username_key243; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key243 UNIQUE (username);


--
-- Name: user user_username_key244; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key244 UNIQUE (username);


--
-- Name: user user_username_key245; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key245 UNIQUE (username);


--
-- Name: user user_username_key246; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key246 UNIQUE (username);


--
-- Name: user user_username_key247; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key247 UNIQUE (username);


--
-- Name: user user_username_key248; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key248 UNIQUE (username);


--
-- Name: user user_username_key249; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key249 UNIQUE (username);


--
-- Name: user user_username_key25; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key25 UNIQUE (username);


--
-- Name: user user_username_key250; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key250 UNIQUE (username);


--
-- Name: user user_username_key251; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key251 UNIQUE (username);


--
-- Name: user user_username_key252; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key252 UNIQUE (username);


--
-- Name: user user_username_key253; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key253 UNIQUE (username);


--
-- Name: user user_username_key254; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key254 UNIQUE (username);


--
-- Name: user user_username_key255; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key255 UNIQUE (username);


--
-- Name: user user_username_key256; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key256 UNIQUE (username);


--
-- Name: user user_username_key257; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key257 UNIQUE (username);


--
-- Name: user user_username_key258; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key258 UNIQUE (username);


--
-- Name: user user_username_key259; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key259 UNIQUE (username);


--
-- Name: user user_username_key26; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key26 UNIQUE (username);


--
-- Name: user user_username_key260; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key260 UNIQUE (username);


--
-- Name: user user_username_key261; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key261 UNIQUE (username);


--
-- Name: user user_username_key262; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key262 UNIQUE (username);


--
-- Name: user user_username_key263; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key263 UNIQUE (username);


--
-- Name: user user_username_key264; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key264 UNIQUE (username);


--
-- Name: user user_username_key265; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key265 UNIQUE (username);


--
-- Name: user user_username_key266; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key266 UNIQUE (username);


--
-- Name: user user_username_key267; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key267 UNIQUE (username);


--
-- Name: user user_username_key268; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key268 UNIQUE (username);


--
-- Name: user user_username_key269; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key269 UNIQUE (username);


--
-- Name: user user_username_key27; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key27 UNIQUE (username);


--
-- Name: user user_username_key270; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key270 UNIQUE (username);


--
-- Name: user user_username_key271; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key271 UNIQUE (username);


--
-- Name: user user_username_key272; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key272 UNIQUE (username);


--
-- Name: user user_username_key273; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key273 UNIQUE (username);


--
-- Name: user user_username_key274; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key274 UNIQUE (username);


--
-- Name: user user_username_key275; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key275 UNIQUE (username);


--
-- Name: user user_username_key276; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key276 UNIQUE (username);


--
-- Name: user user_username_key277; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key277 UNIQUE (username);


--
-- Name: user user_username_key278; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key278 UNIQUE (username);


--
-- Name: user user_username_key279; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key279 UNIQUE (username);


--
-- Name: user user_username_key28; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key28 UNIQUE (username);


--
-- Name: user user_username_key280; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key280 UNIQUE (username);


--
-- Name: user user_username_key281; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key281 UNIQUE (username);


--
-- Name: user user_username_key282; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key282 UNIQUE (username);


--
-- Name: user user_username_key283; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key283 UNIQUE (username);


--
-- Name: user user_username_key284; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key284 UNIQUE (username);


--
-- Name: user user_username_key29; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key29 UNIQUE (username);


--
-- Name: user user_username_key3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key3 UNIQUE (username);


--
-- Name: user user_username_key30; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key30 UNIQUE (username);


--
-- Name: user user_username_key31; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key31 UNIQUE (username);


--
-- Name: user user_username_key32; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key32 UNIQUE (username);


--
-- Name: user user_username_key33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key33 UNIQUE (username);


--
-- Name: user user_username_key34; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key34 UNIQUE (username);


--
-- Name: user user_username_key35; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key35 UNIQUE (username);


--
-- Name: user user_username_key36; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key36 UNIQUE (username);


--
-- Name: user user_username_key37; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key37 UNIQUE (username);


--
-- Name: user user_username_key38; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key38 UNIQUE (username);


--
-- Name: user user_username_key39; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key39 UNIQUE (username);


--
-- Name: user user_username_key4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key4 UNIQUE (username);


--
-- Name: user user_username_key40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key40 UNIQUE (username);


--
-- Name: user user_username_key41; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key41 UNIQUE (username);


--
-- Name: user user_username_key42; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key42 UNIQUE (username);


--
-- Name: user user_username_key43; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key43 UNIQUE (username);


--
-- Name: user user_username_key44; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key44 UNIQUE (username);


--
-- Name: user user_username_key45; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key45 UNIQUE (username);


--
-- Name: user user_username_key46; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key46 UNIQUE (username);


--
-- Name: user user_username_key47; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key47 UNIQUE (username);


--
-- Name: user user_username_key48; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key48 UNIQUE (username);


--
-- Name: user user_username_key49; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key49 UNIQUE (username);


--
-- Name: user user_username_key5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key5 UNIQUE (username);


--
-- Name: user user_username_key50; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key50 UNIQUE (username);


--
-- Name: user user_username_key51; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key51 UNIQUE (username);


--
-- Name: user user_username_key52; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key52 UNIQUE (username);


--
-- Name: user user_username_key53; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key53 UNIQUE (username);


--
-- Name: user user_username_key54; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key54 UNIQUE (username);


--
-- Name: user user_username_key55; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key55 UNIQUE (username);


--
-- Name: user user_username_key56; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key56 UNIQUE (username);


--
-- Name: user user_username_key57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key57 UNIQUE (username);


--
-- Name: user user_username_key58; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key58 UNIQUE (username);


--
-- Name: user user_username_key59; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key59 UNIQUE (username);


--
-- Name: user user_username_key6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key6 UNIQUE (username);


--
-- Name: user user_username_key60; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key60 UNIQUE (username);


--
-- Name: user user_username_key61; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key61 UNIQUE (username);


--
-- Name: user user_username_key62; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key62 UNIQUE (username);


--
-- Name: user user_username_key63; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key63 UNIQUE (username);


--
-- Name: user user_username_key64; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key64 UNIQUE (username);


--
-- Name: user user_username_key65; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key65 UNIQUE (username);


--
-- Name: user user_username_key66; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key66 UNIQUE (username);


--
-- Name: user user_username_key67; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key67 UNIQUE (username);


--
-- Name: user user_username_key68; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key68 UNIQUE (username);


--
-- Name: user user_username_key69; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key69 UNIQUE (username);


--
-- Name: user user_username_key7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key7 UNIQUE (username);


--
-- Name: user user_username_key70; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key70 UNIQUE (username);


--
-- Name: user user_username_key71; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key71 UNIQUE (username);


--
-- Name: user user_username_key72; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key72 UNIQUE (username);


--
-- Name: user user_username_key73; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key73 UNIQUE (username);


--
-- Name: user user_username_key74; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key74 UNIQUE (username);


--
-- Name: user user_username_key75; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key75 UNIQUE (username);


--
-- Name: user user_username_key76; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key76 UNIQUE (username);


--
-- Name: user user_username_key77; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key77 UNIQUE (username);


--
-- Name: user user_username_key78; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key78 UNIQUE (username);


--
-- Name: user user_username_key79; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key79 UNIQUE (username);


--
-- Name: user user_username_key8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key8 UNIQUE (username);


--
-- Name: user user_username_key80; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key80 UNIQUE (username);


--
-- Name: user user_username_key81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key81 UNIQUE (username);


--
-- Name: user user_username_key82; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key82 UNIQUE (username);


--
-- Name: user user_username_key83; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key83 UNIQUE (username);


--
-- Name: user user_username_key84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key84 UNIQUE (username);


--
-- Name: user user_username_key85; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key85 UNIQUE (username);


--
-- Name: user user_username_key86; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key86 UNIQUE (username);


--
-- Name: user user_username_key87; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key87 UNIQUE (username);


--
-- Name: user user_username_key88; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key88 UNIQUE (username);


--
-- Name: user user_username_key89; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key89 UNIQUE (username);


--
-- Name: user user_username_key9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key9 UNIQUE (username);


--
-- Name: user user_username_key90; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key90 UNIQUE (username);


--
-- Name: user user_username_key91; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key91 UNIQUE (username);


--
-- Name: user user_username_key92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key92 UNIQUE (username);


--
-- Name: user user_username_key93; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key93 UNIQUE (username);


--
-- Name: user user_username_key94; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key94 UNIQUE (username);


--
-- Name: user user_username_key95; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key95 UNIQUE (username);


--
-- Name: user user_username_key96; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key96 UNIQUE (username);


--
-- Name: user user_username_key97; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key97 UNIQUE (username);


--
-- Name: user user_username_key98; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key98 UNIQUE (username);


--
-- Name: user user_username_key99; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key99 UNIQUE (username);


--
-- Name: game_platform_game_id_platform_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX game_platform_game_id_platform_id ON public.game_platform USING btree ("gameId", "platformId");


--
-- Name: post_platform_post_id_platform_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX post_platform_post_id_platform_id ON public.post_platform USING btree ("postId", "platformId");


--
-- Name: game_platform game_platform_gameId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_platform
    ADD CONSTRAINT "game_platform_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES public.game(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_platform game_platform_platformId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_platform
    ADD CONSTRAINT "game_platform_platformId_fkey" FOREIGN KEY ("platformId") REFERENCES public.platform(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: post post_gameId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT "post_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES public.game(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: post_platform post_platform_platformId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_platform
    ADD CONSTRAINT "post_platform_platformId_fkey" FOREIGN KEY ("platformId") REFERENCES public.platform(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: post_platform post_platform_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_platform
    ADD CONSTRAINT "post_platform_postId_fkey" FOREIGN KEY ("postId") REFERENCES public.post(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: post post_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT "post_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_platform user_platform_platform_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_platform
    ADD CONSTRAINT user_platform_platform_id_fkey FOREIGN KEY (platform_id) REFERENCES public.platform(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

