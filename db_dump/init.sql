--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

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
-- Name: loginlog; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE public.loginlog (
    id integer NOT NULL,
    user_id integer,
    login_time timestamp without time zone,
    user_agent character varying NOT NULL
);


ALTER TABLE public.loginlog OWNER TO demo;

--
-- Name: loginlog_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE public.loginlog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.loginlog_id_seq OWNER TO demo;

--
-- Name: loginlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE public.loginlog_id_seq OWNED BY public.loginlog.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE public.users (
    username character varying NOT NULL,
    id integer NOT NULL,
    password character varying NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.users OWNER TO demo;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO demo;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: loginlog id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY public.loginlog ALTER COLUMN id SET DEFAULT nextval('public.loginlog_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: loginlog; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY public.loginlog (id, user_id, login_time, user_agent) FROM stdin;
1	\N	2025-05-14 13:34:04.075038	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36
2	1	2025-05-14 13:40:29.837082	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36
3	1	2025-05-14 13:45:37.454162	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36
4	2	2025-05-14 13:47:48.436307	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36
5	1	2025-05-14 14:17:40.751596	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36
6	2	2025-05-14 14:18:50.955411	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36
7	1	2025-05-14 14:27:43.19934	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY public.users (username, id, password, name) FROM stdin;
admin	1	8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918	Administrator
user	2	04f8996da763b7a969b1028ee3007569eaf3a635486ddab211d512c85b9df8fb	User
\.


--
-- Name: loginlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

SELECT pg_catalog.setval('public.loginlog_id_seq', 7, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: loginlog loginlog_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY public.loginlog
    ADD CONSTRAINT loginlog_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: ix_loginlog_id; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX ix_loginlog_id ON public.loginlog USING btree (id);


--
-- Name: ix_loginlog_login_time; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX ix_loginlog_login_time ON public.loginlog USING btree (login_time);


--
-- Name: ix_loginlog_user_agent; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX ix_loginlog_user_agent ON public.loginlog USING btree (user_agent);


--
-- Name: ix_loginlog_user_id; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX ix_loginlog_user_id ON public.loginlog USING btree (user_id);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: ix_users_name; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX ix_users_name ON public.users USING btree (name);


--
-- Name: ix_users_password; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX ix_users_password ON public.users USING btree (password);


--
-- Name: loginlog loginlog_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY public.loginlog
    ADD CONSTRAINT loginlog_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

