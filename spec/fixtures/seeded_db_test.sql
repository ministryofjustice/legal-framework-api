--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 12.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.proceeding_type_scope_limitations DROP CONSTRAINT IF EXISTS fk_rails_f3012603ed;
ALTER TABLE IF EXISTS ONLY public.threshold_waivers DROP CONSTRAINT IF EXISTS fk_rails_dce3a6252f;
ALTER TABLE IF EXISTS ONLY public.default_cost_limitations DROP CONSTRAINT IF EXISTS fk_rails_c42d332697;
ALTER TABLE IF EXISTS ONLY public.proceeding_type_service_levels DROP CONSTRAINT IF EXISTS fk_rails_79fb889b85;
ALTER TABLE IF EXISTS ONLY public.proceeding_type_scope_limitations DROP CONSTRAINT IF EXISTS fk_rails_53a706d311;
ALTER TABLE IF EXISTS ONLY public.proceeding_type_service_levels DROP CONSTRAINT IF EXISTS fk_rails_37fa388bf2;
ALTER TABLE IF EXISTS ONLY public.threshold_waivers DROP CONSTRAINT IF EXISTS fk_rails_1b8d6e0a4f;
DROP INDEX IF EXISTS public.textsearch_idx;
DROP INDEX IF EXISTS public.pt_sl_cit_df_idx;
DROP INDEX IF EXISTS public.index_threshold_waivers_on_matter_type_id;
DROP INDEX IF EXISTS public.index_threshold_waivers_on_client_involvement_type_id;
DROP INDEX IF EXISTS public.index_threshold_waivers_on_client_involvement_and_matter_types;
DROP INDEX IF EXISTS public.index_service_levels_unique_on_level;
DROP INDEX IF EXISTS public.index_scope_user_inputs_on_input_name;
DROP INDEX IF EXISTS public.index_scope_limitations_on_code;
DROP INDEX IF EXISTS public.index_scope_limitation_user_inputs_on_scope_user_input_id;
DROP INDEX IF EXISTS public.index_scope_limitation_user_inputs_on_scope_limitation_id;
DROP INDEX IF EXISTS public.index_proceedings_service_levels_unique_on_ids;
DROP INDEX IF EXISTS public.index_proceedings_service_levels_unique_default;
DROP INDEX IF EXISTS public.index_proceedings_scopes_unique_substantive_default;
DROP INDEX IF EXISTS public.index_proceedings_scopes_unique_on_ids;
DROP INDEX IF EXISTS public.index_proceedings_scopes_unique_delegated_default;
DROP INDEX IF EXISTS public.index_proceeding_type_service_levels_on_service_level_id;
DROP INDEX IF EXISTS public.index_proceeding_type_service_levels_on_proceeding_type_id;
DROP INDEX IF EXISTS public.index_proceeding_type_scope_limitations_on_scope_limitation_id;
DROP INDEX IF EXISTS public.index_proceeding_type_scope_limitations_on_proceeding_type_id;
DROP INDEX IF EXISTS public.index_proceeding_type_merits_tasks_on_proceeding_type_id;
DROP INDEX IF EXISTS public.index_matter_types_on_name;
DROP INDEX IF EXISTS public.index_default_cost_limitations_unique_on_cost_date_and_type;
DROP INDEX IF EXISTS public.index_default_cost_limitations_on_proceeding_type_id;
ALTER TABLE IF EXISTS ONLY public.threshold_waivers DROP CONSTRAINT IF EXISTS threshold_waivers_pkey;
ALTER TABLE IF EXISTS ONLY public.task_dependencies DROP CONSTRAINT IF EXISTS task_dependencies_pkey;
ALTER TABLE IF EXISTS ONLY public.service_levels DROP CONSTRAINT IF EXISTS service_levels_pkey;
ALTER TABLE IF EXISTS ONLY public.scope_user_inputs DROP CONSTRAINT IF EXISTS scope_user_inputs_pkey;
ALTER TABLE IF EXISTS ONLY public.scope_limitations DROP CONSTRAINT IF EXISTS scope_limitations_pkey;
ALTER TABLE IF EXISTS ONLY public.scope_limitation_user_inputs DROP CONSTRAINT IF EXISTS scope_limitation_user_inputs_pkey;
ALTER TABLE IF EXISTS ONLY public.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.request_histories DROP CONSTRAINT IF EXISTS request_histories_pkey;
ALTER TABLE IF EXISTS ONLY public.proceeding_types DROP CONSTRAINT IF EXISTS proceeding_types_pkey;
ALTER TABLE IF EXISTS ONLY public.proceeding_type_service_levels DROP CONSTRAINT IF EXISTS proceeding_type_service_levels_pkey;
ALTER TABLE IF EXISTS ONLY public.proceeding_type_scopes DROP CONSTRAINT IF EXISTS proceeding_type_scopes_pkey;
ALTER TABLE IF EXISTS ONLY public.proceeding_type_scope_limitations DROP CONSTRAINT IF EXISTS proceeding_type_scope_limitations_pkey;
ALTER TABLE IF EXISTS ONLY public.proceeding_type_merits_tasks DROP CONSTRAINT IF EXISTS proceeding_type_merits_tasks_pkey;
ALTER TABLE IF EXISTS ONLY public.merits_tasks DROP CONSTRAINT IF EXISTS merits_tasks_pkey;
ALTER TABLE IF EXISTS ONLY public.matter_types DROP CONSTRAINT IF EXISTS matter_types_pkey;
ALTER TABLE IF EXISTS ONLY public.default_cost_limitations DROP CONSTRAINT IF EXISTS default_cost_limitations_pkey;
ALTER TABLE IF EXISTS ONLY public.client_involvement_types DROP CONSTRAINT IF EXISTS client_involvement_types_pkey;
ALTER TABLE IF EXISTS ONLY public.ar_internal_metadata DROP CONSTRAINT IF EXISTS ar_internal_metadata_pkey;
ALTER TABLE IF EXISTS public.threshold_waivers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.task_dependencies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.scope_limitation_user_inputs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.request_histories ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.threshold_waivers_id_seq;
DROP TABLE IF EXISTS public.threshold_waivers;
DROP SEQUENCE IF EXISTS public.task_dependencies_id_seq;
DROP TABLE IF EXISTS public.task_dependencies;
DROP TABLE IF EXISTS public.service_levels;
DROP TABLE IF EXISTS public.scope_user_inputs;
DROP TABLE IF EXISTS public.scope_limitations;
DROP SEQUENCE IF EXISTS public.scope_limitation_user_inputs_id_seq;
DROP TABLE IF EXISTS public.scope_limitation_user_inputs;
DROP TABLE IF EXISTS public.schema_migrations;
DROP SEQUENCE IF EXISTS public.request_histories_id_seq;
DROP TABLE IF EXISTS public.request_histories;
DROP TABLE IF EXISTS public.proceeding_types;
DROP TABLE IF EXISTS public.proceeding_type_service_levels;
DROP TABLE IF EXISTS public.proceeding_type_scopes;
DROP TABLE IF EXISTS public.proceeding_type_scope_limitations;
DROP TABLE IF EXISTS public.proceeding_type_merits_tasks;
DROP TABLE IF EXISTS public.merits_tasks;
DROP TABLE IF EXISTS public.matter_types;
DROP TABLE IF EXISTS public.default_cost_limitations;
DROP TABLE IF EXISTS public.client_involvement_types;
DROP TABLE IF EXISTS public.ar_internal_metadata;
DROP EXTENSION IF EXISTS pgcrypto;
--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO stephenrichards;

--
-- Name: client_involvement_types; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.client_involvement_types (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    ccms_code character varying NOT NULL,
    description character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    ordering integer
);


ALTER TABLE public.client_involvement_types OWNER TO stephenrichards;

--
-- Name: default_cost_limitations; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.default_cost_limitations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    proceeding_type_id uuid NOT NULL,
    start_date date NOT NULL,
    cost_type character varying NOT NULL,
    value numeric NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.default_cost_limitations OWNER TO stephenrichards;

--
-- Name: matter_types; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.matter_types (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    category_of_law character varying,
    code character varying,
    category_of_law_code character varying
);


ALTER TABLE public.matter_types OWNER TO stephenrichards;

--
-- Name: merits_tasks; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.merits_tasks (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    type character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.merits_tasks OWNER TO stephenrichards;

--
-- Name: proceeding_type_merits_tasks; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.proceeding_type_merits_tasks (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    proceeding_type_id uuid NOT NULL,
    merits_task_id uuid NOT NULL,
    sequence integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.proceeding_type_merits_tasks OWNER TO stephenrichards;

--
-- Name: proceeding_type_scope_limitations; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.proceeding_type_scope_limitations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    proceeding_type_id uuid,
    scope_limitation_id uuid,
    substantive_default boolean,
    delegated_functions_default boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.proceeding_type_scope_limitations OWNER TO stephenrichards;

--
-- Name: proceeding_type_scopes; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.proceeding_type_scopes (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    proceeding_type_ccms_code character varying NOT NULL,
    service_level integer NOT NULL,
    client_involvement_type_code character varying NOT NULL,
    df_used boolean NOT NULL,
    scope_limitation_code character varying NOT NULL,
    "default" boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.proceeding_type_scopes OWNER TO stephenrichards;

--
-- Name: proceeding_type_service_levels; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.proceeding_type_service_levels (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    proceeding_type_id uuid,
    service_level_id uuid,
    proceeding_default boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.proceeding_type_service_levels OWNER TO stephenrichards;

--
-- Name: proceeding_types; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.proceeding_types (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    ccms_code character varying NOT NULL,
    meaning character varying NOT NULL,
    description character varying NOT NULL,
    matter_type_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    additional_search_terms character varying,
    textsearchable tsvector,
    name character varying DEFAULT 'default_name'::character varying NOT NULL,
    full_s8_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.proceeding_types OWNER TO stephenrichards;

--
-- Name: request_histories; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.request_histories (
    id bigint NOT NULL,
    request_method character varying,
    request_id character varying,
    endpoint character varying,
    remote_ip inet,
    request_payload character varying,
    response_status integer,
    response_payload character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.request_histories OWNER TO stephenrichards;

--
-- Name: request_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: stephenrichards
--

CREATE SEQUENCE public.request_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.request_histories_id_seq OWNER TO stephenrichards;

--
-- Name: request_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stephenrichards
--

ALTER SEQUENCE public.request_histories_id_seq OWNED BY public.request_histories.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO stephenrichards;

--
-- Name: scope_limitation_user_inputs; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.scope_limitation_user_inputs (
    id bigint NOT NULL,
    scope_limitation_id uuid,
    scope_user_input_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.scope_limitation_user_inputs OWNER TO stephenrichards;

--
-- Name: scope_limitation_user_inputs_id_seq; Type: SEQUENCE; Schema: public; Owner: stephenrichards
--

CREATE SEQUENCE public.scope_limitation_user_inputs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scope_limitation_user_inputs_id_seq OWNER TO stephenrichards;

--
-- Name: scope_limitation_user_inputs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stephenrichards
--

ALTER SEQUENCE public.scope_limitation_user_inputs_id_seq OWNED BY public.scope_limitation_user_inputs.id;


--
-- Name: scope_limitations; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.scope_limitations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    code character varying NOT NULL,
    meaning character varying NOT NULL,
    description character varying NOT NULL,
    substantive boolean DEFAULT false NOT NULL,
    delegated_functions boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.scope_limitations OWNER TO stephenrichards;

--
-- Name: scope_user_inputs; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.scope_user_inputs (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    input_name text NOT NULL,
    input_type text NOT NULL,
    mandatory boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.scope_user_inputs OWNER TO stephenrichards;

--
-- Name: service_levels; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.service_levels (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    level integer NOT NULL,
    name character varying NOT NULL,
    stage integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.service_levels OWNER TO stephenrichards;

--
-- Name: task_dependencies; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.task_dependencies (
    id bigint NOT NULL,
    merits_task_id uuid,
    dependency_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.task_dependencies OWNER TO stephenrichards;

--
-- Name: task_dependencies_id_seq; Type: SEQUENCE; Schema: public; Owner: stephenrichards
--

CREATE SEQUENCE public.task_dependencies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_dependencies_id_seq OWNER TO stephenrichards;

--
-- Name: task_dependencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stephenrichards
--

ALTER SEQUENCE public.task_dependencies_id_seq OWNED BY public.task_dependencies.id;


--
-- Name: threshold_waivers; Type: TABLE; Schema: public; Owner: stephenrichards
--

CREATE TABLE public.threshold_waivers (
    id bigint NOT NULL,
    client_involvement_type_id uuid NOT NULL,
    matter_type_id uuid NOT NULL,
    gross_income_upper boolean,
    disposable_income_upper boolean,
    capital_upper boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.threshold_waivers OWNER TO stephenrichards;

--
-- Name: threshold_waivers_id_seq; Type: SEQUENCE; Schema: public; Owner: stephenrichards
--

CREATE SEQUENCE public.threshold_waivers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.threshold_waivers_id_seq OWNER TO stephenrichards;

--
-- Name: threshold_waivers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stephenrichards
--

ALTER SEQUENCE public.threshold_waivers_id_seq OWNED BY public.threshold_waivers.id;


--
-- Name: request_histories id; Type: DEFAULT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.request_histories ALTER COLUMN id SET DEFAULT nextval('public.request_histories_id_seq'::regclass);


--
-- Name: scope_limitation_user_inputs id; Type: DEFAULT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.scope_limitation_user_inputs ALTER COLUMN id SET DEFAULT nextval('public.scope_limitation_user_inputs_id_seq'::regclass);


--
-- Name: task_dependencies id; Type: DEFAULT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.task_dependencies ALTER COLUMN id SET DEFAULT nextval('public.task_dependencies_id_seq'::regclass);


--
-- Name: threshold_waivers id; Type: DEFAULT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.threshold_waivers ALTER COLUMN id SET DEFAULT nextval('public.threshold_waivers_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	test	2022-08-09 14:57:58.17689	2022-08-09 14:57:58.183914
schema_sha1	9d2ee80e6b4371924ca96fcacbfc88a90dda27f6	2022-08-09 14:57:58.190898	2022-08-09 14:57:58.190898
\.


--
-- Data for Name: client_involvement_types; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.client_involvement_types (id, ccms_code, description, created_at, updated_at, ordering) FROM stdin;
3a5a1cf6-00fe-4b81-b271-440998421d92	A	Applicant/claimant/petitioner	2022-08-09 15:00:34.646702	2022-08-09 15:00:34.646702	1
becc9b9c-7976-4e20-b5b6-24b7bc9195ad	D	Defendant/respondent	2022-08-09 15:00:34.693322	2022-08-09 15:00:34.693322	2
5cc6460f-1c2d-4f26-ab30-106993bc0176	W	Subject of proceedings (child)	2022-08-09 15:00:34.739732	2022-08-09 15:00:34.739732	3
dc3385b1-ac30-43e4-b044-e73b6f963e95	Z	Joined party	2022-08-09 15:00:34.745017	2022-08-09 15:00:34.745017	5
1f75a628-1d56-4e90-b8c6-a6648aee1eb6	I	Intervenor	2022-08-09 15:00:34.749165	2022-08-09 15:00:34.749165	4
\.


--
-- Data for Name: default_cost_limitations; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.default_cost_limitations (id, proceeding_type_id, start_date, cost_type, value, created_at, updated_at) FROM stdin;
cfdb1d51-0722-49de-bf36-da4c530c58d2	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.292196	2022-08-09 15:00:31.292196
2427ec38-167c-4fa2-bdbe-6b1e68f1edea	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.297679	2022-08-09 15:00:31.297679
73efbae3-447e-4885-b5f2-a6e237f696c3	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.301927	2022-08-09 15:00:31.301927
3cf6238c-b2a0-4f1d-9f05-dad3bb9d8cc3	891f647c-4c41-43aa-9869-a339422c263b	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.306094	2022-08-09 15:00:31.306094
ac74d30b-b3d9-4da8-a1f3-39f5f3289e41	891f647c-4c41-43aa-9869-a339422c263b	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.310092	2022-08-09 15:00:31.310092
eecc3c23-7742-48de-99df-3db78eada1d5	891f647c-4c41-43aa-9869-a339422c263b	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.314128	2022-08-09 15:00:31.314128
ce0dfdf9-4d68-455a-8c5e-df6a88ed03a1	284b2853-a988-4962-8b0f-bf3ba47a8737	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.317992	2022-08-09 15:00:31.317992
ce0bf275-625b-4730-9892-61531b063ef9	284b2853-a988-4962-8b0f-bf3ba47a8737	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.321895	2022-08-09 15:00:31.321895
e8abe37d-023c-4e44-9652-48de5b38cd4d	284b2853-a988-4962-8b0f-bf3ba47a8737	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.325648	2022-08-09 15:00:31.325648
0135465c-c1e9-450f-ba73-97dc4aa264f1	09976e47-459c-4028-9ba4-bec984b54519	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.329395	2022-08-09 15:00:31.329395
c16ae5d9-2856-4604-baf7-e4f1caefa1c6	09976e47-459c-4028-9ba4-bec984b54519	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.333269	2022-08-09 15:00:31.333269
cbca7ac5-dbb6-4322-a65a-b34c93b88db5	09976e47-459c-4028-9ba4-bec984b54519	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.336893	2022-08-09 15:00:31.336893
3d7c467b-0ed8-486f-b090-5a74d255b458	11fb5a94-45e4-4688-9fad-d4db494df0eb	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.340513	2022-08-09 15:00:31.340513
06ef508a-8b6c-4027-8dd3-b9a4fb1bf60c	11fb5a94-45e4-4688-9fad-d4db494df0eb	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.3442	2022-08-09 15:00:31.3442
86a90097-c470-4479-b4a5-a3ff3cc94b65	11fb5a94-45e4-4688-9fad-d4db494df0eb	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.347887	2022-08-09 15:00:31.347887
f715dd68-64bc-40c9-9e10-ed840f5bc3cc	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.351652	2022-08-09 15:00:31.351652
483b0d47-3c2a-4848-bd69-efadc910652b	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.371694	2022-08-09 15:00:31.371694
d9df6517-1050-4a38-a8d7-8d9740c5a771	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.376401	2022-08-09 15:00:31.376401
c0349601-e70b-4a61-8bcb-aaad28390bfc	3a437cd4-778f-4325-98dd-f79638a3907a	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.381321	2022-08-09 15:00:31.381321
b41ff754-e2be-4e5c-a168-df9e268c0159	3a437cd4-778f-4325-98dd-f79638a3907a	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.385971	2022-08-09 15:00:31.385971
78aeee28-ff30-42ac-a88b-fab0abf6999d	3a437cd4-778f-4325-98dd-f79638a3907a	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.390373	2022-08-09 15:00:31.390373
ac11d318-aa39-462a-bb51-72f91a86d554	c7f19bf7-a918-440b-bdd9-abd0ed19b692	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.394479	2022-08-09 15:00:31.394479
b2ef5038-8c33-4239-b7a6-a6fdfb2ac823	c7f19bf7-a918-440b-bdd9-abd0ed19b692	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.398395	2022-08-09 15:00:31.398395
2d1b447f-33a1-4761-892e-3bdf839987b2	c7f19bf7-a918-440b-bdd9-abd0ed19b692	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.40252	2022-08-09 15:00:31.40252
5937548d-c076-4579-85d0-09aefbd05c8e	98f3b2c9-0a72-48ba-be77-11c93b9818ad	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.406437	2022-08-09 15:00:31.406437
aeb04b91-3b75-4ddb-8d0b-03bf9c38c85a	98f3b2c9-0a72-48ba-be77-11c93b9818ad	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.410571	2022-08-09 15:00:31.410571
1986e92b-23a2-482c-8a4a-ebf6f18990c6	98f3b2c9-0a72-48ba-be77-11c93b9818ad	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.41422	2022-08-09 15:00:31.41422
7002ea22-1a4a-4611-93fe-9908d7af21a2	e6566f52-365d-44be-9b20-0043885ea857	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.417936	2022-08-09 15:00:31.417936
dbcf2d39-5ad0-471d-bee4-72ba8ef5a01b	e6566f52-365d-44be-9b20-0043885ea857	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.421901	2022-08-09 15:00:31.421901
081ff037-b432-4907-a5b1-7b756a422f49	e6566f52-365d-44be-9b20-0043885ea857	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.425726	2022-08-09 15:00:31.425726
e5674ae6-2c83-490e-a6e1-83c0279fee98	1b89d9f4-164a-4bce-9556-2d55b98f3394	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.429548	2022-08-09 15:00:31.429548
b4be3491-eac2-42c1-bfb1-164174edf166	1b89d9f4-164a-4bce-9556-2d55b98f3394	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.432996	2022-08-09 15:00:31.432996
116514c1-f996-40b6-84cb-6fc951501fe0	1b89d9f4-164a-4bce-9556-2d55b98f3394	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.4367	2022-08-09 15:00:31.4367
a2636cef-70ef-47b7-842b-90218ab167a2	a0d435d2-2c7f-4812-9492-7593835180f6	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.440487	2022-08-09 15:00:31.440487
30e31eea-18ef-4072-b6cf-0cd3dcf3ce14	a0d435d2-2c7f-4812-9492-7593835180f6	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.4445	2022-08-09 15:00:31.4445
d3649348-face-4f14-8191-18793b00f95b	a0d435d2-2c7f-4812-9492-7593835180f6	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.448253	2022-08-09 15:00:31.448253
c1d241f5-ba77-4ff6-a0aa-0bc51f70f45f	93b8a259-e8f4-4cbf-8b02-db1b124acb9b	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.452065	2022-08-09 15:00:31.452065
46081c25-1a61-4f49-aced-bcd03b578206	93b8a259-e8f4-4cbf-8b02-db1b124acb9b	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.456776	2022-08-09 15:00:31.456776
441880b7-600a-4871-b012-9e5db587f7fd	93b8a259-e8f4-4cbf-8b02-db1b124acb9b	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.461859	2022-08-09 15:00:31.461859
697211d0-3462-406b-a308-d9a13515d7f4	242c777d-484e-4185-b0a5-d34a4d01e631	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.465553	2022-08-09 15:00:31.465553
9ab26f3a-ac1d-4e30-a105-40bcd713f313	242c777d-484e-4185-b0a5-d34a4d01e631	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.469403	2022-08-09 15:00:31.469403
0f85c58f-72fa-4dad-98fe-255bf43e205f	242c777d-484e-4185-b0a5-d34a4d01e631	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.47451	2022-08-09 15:00:31.47451
8101815c-482d-4c21-9152-4b6506c7d66d	3003821e-6c36-4bae-a030-28977e3ceec7	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.478805	2022-08-09 15:00:31.478805
7b00001e-8455-4d40-896d-df147fe5d505	3003821e-6c36-4bae-a030-28977e3ceec7	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.482749	2022-08-09 15:00:31.482749
f0e0f92b-f6de-46cc-90c2-c6f6be1dfde7	3003821e-6c36-4bae-a030-28977e3ceec7	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.486599	2022-08-09 15:00:31.486599
9a23cac2-36d6-4f06-9a31-3f04748f7e4d	4ba11b67-7501-4878-b1f5-e8ac9740e276	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.490696	2022-08-09 15:00:31.490696
2b4ab08c-b796-43aa-b48d-5ef979188f8d	4ba11b67-7501-4878-b1f5-e8ac9740e276	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.494801	2022-08-09 15:00:31.494801
67aea847-0cb1-43b1-9e3e-44af95d09d63	4ba11b67-7501-4878-b1f5-e8ac9740e276	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.498532	2022-08-09 15:00:31.498532
d47cc982-3429-4d7c-8a3a-3269e2ffcead	7b16ca9d-c51e-40f2-ac01-aa88584a0cef	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.502214	2022-08-09 15:00:31.502214
c4a42be5-7d2d-460f-9764-093fedda1cb3	7b16ca9d-c51e-40f2-ac01-aa88584a0cef	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.505895	2022-08-09 15:00:31.505895
32c236d4-83b3-4901-a90c-ba3ff21d01c6	7b16ca9d-c51e-40f2-ac01-aa88584a0cef	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.509519	2022-08-09 15:00:31.509519
95c21a59-6e33-4e3f-b802-ed460b500727	1c260b2e-7c4d-4d98-8807-ccd0851e49e2	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.512766	2022-08-09 15:00:31.512766
4d18c39c-98ed-4aac-a4f2-31d2e8d56996	1c260b2e-7c4d-4d98-8807-ccd0851e49e2	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.516382	2022-08-09 15:00:31.516382
07b55e54-79ee-4c7e-8719-839a1346027e	1c260b2e-7c4d-4d98-8807-ccd0851e49e2	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.520398	2022-08-09 15:00:31.520398
a6155406-b8f6-4caf-9bc9-0e9c3fd53e0d	9f349ce4-aa9f-4773-a243-caaa9d3f6530	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.524755	2022-08-09 15:00:31.524755
988f0571-9924-486c-b0b3-d72724b6cfcd	9f349ce4-aa9f-4773-a243-caaa9d3f6530	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.528698	2022-08-09 15:00:31.528698
4570e329-51df-417a-8421-8624220a6f06	9f349ce4-aa9f-4773-a243-caaa9d3f6530	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.532417	2022-08-09 15:00:31.532417
e5bfaa20-4b2f-4d3f-9fc3-b1fd84f489e9	1aafdaa0-1547-4c30-824f-7a5b3e0af6d6	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.535676	2022-08-09 15:00:31.535676
3bde1b5b-a58c-473a-8b0e-1400cddcdd29	1aafdaa0-1547-4c30-824f-7a5b3e0af6d6	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.539251	2022-08-09 15:00:31.539251
491445ff-5201-4a08-9cb4-e000292c2eaf	1aafdaa0-1547-4c30-824f-7a5b3e0af6d6	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.542846	2022-08-09 15:00:31.542846
77ed485d-e281-43a5-bd38-a282b61b1ffd	e136ecbb-ec9d-42df-804f-2a363bb13e96	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.546593	2022-08-09 15:00:31.546593
3c4d5e1f-7b2f-420e-8cc5-dd586cca7ff0	e136ecbb-ec9d-42df-804f-2a363bb13e96	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.55015	2022-08-09 15:00:31.55015
f705b4f3-0e71-4a75-90de-5702d07d0954	e136ecbb-ec9d-42df-804f-2a363bb13e96	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.553714	2022-08-09 15:00:31.553714
f2df1bea-89ed-41b4-8b06-9e00131cc0f8	bc3a4e66-235e-4dd4-81fd-1f820b0d556f	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.55691	2022-08-09 15:00:31.55691
5025e5d6-1259-4c30-866b-38bf6cbe1568	bc3a4e66-235e-4dd4-81fd-1f820b0d556f	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.560606	2022-08-09 15:00:31.560606
f4ec2879-111d-4789-8e5d-fc60820383c3	bc3a4e66-235e-4dd4-81fd-1f820b0d556f	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.564209	2022-08-09 15:00:31.564209
14644598-dd1a-4857-90f9-35c818236f66	6ea70541-495b-4007-9cb3-f53881163378	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.567973	2022-08-09 15:00:31.567973
ab2620c6-fde6-4018-84b6-5ea9bc3627e7	6ea70541-495b-4007-9cb3-f53881163378	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.571772	2022-08-09 15:00:31.571772
9fcc70fd-f5b0-4bbd-ba5f-7c122c10a0a1	6ea70541-495b-4007-9cb3-f53881163378	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.575395	2022-08-09 15:00:31.575395
a4615a1a-1e84-48c5-b9f4-c54cdb103dd3	fec79071-885c-40e2-aad0-d98d5591aad5	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.578893	2022-08-09 15:00:31.578893
52719cc9-e103-45c3-8bbf-fa0f7d0d4a9c	fec79071-885c-40e2-aad0-d98d5591aad5	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.582391	2022-08-09 15:00:31.582391
37bb296d-fadf-4d46-9977-ddd2f8669f24	fec79071-885c-40e2-aad0-d98d5591aad5	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.62995	2022-08-09 15:00:31.62995
c2e632d7-201f-4867-9ccb-4badd3687823	642ea1ca-dde9-4b14-b21b-c5559b732c5d	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.635263	2022-08-09 15:00:31.635263
2698575f-74bb-45f0-906f-285df6502a4c	642ea1ca-dde9-4b14-b21b-c5559b732c5d	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.63944	2022-08-09 15:00:31.63944
6652dd82-fd02-435f-935e-8b8022e1cb77	642ea1ca-dde9-4b14-b21b-c5559b732c5d	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.643116	2022-08-09 15:00:31.643116
00eda552-e34b-42cc-84d5-3f270645854d	b9f9d637-e8fd-4279-a3f3-edb9e42435cf	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.646982	2022-08-09 15:00:31.646982
a169446a-79fe-47e6-a1bc-4a8429e2bb38	b9f9d637-e8fd-4279-a3f3-edb9e42435cf	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.650439	2022-08-09 15:00:31.650439
d52abb12-339b-4720-83ab-2f7b4796aedb	b9f9d637-e8fd-4279-a3f3-edb9e42435cf	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.653994	2022-08-09 15:00:31.653994
faec70c4-6895-46c0-86b2-f009970501a2	62c7df02-ad44-4947-bb4c-d1c2cc330cbf	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.658099	2022-08-09 15:00:31.658099
0ebcc935-2b81-4b4a-aec8-597faac8a7dc	62c7df02-ad44-4947-bb4c-d1c2cc330cbf	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.661766	2022-08-09 15:00:31.661766
406be732-0d2a-423a-8eaf-453d56e0e8fb	62c7df02-ad44-4947-bb4c-d1c2cc330cbf	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.665487	2022-08-09 15:00:31.665487
b5d5d180-554a-447f-aca7-407b1cf92cb1	f23bc8d5-ff27-4b1d-8761-de7b24b00638	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.669342	2022-08-09 15:00:31.669342
4025fb30-0463-4eb7-a81e-04d35477b976	f23bc8d5-ff27-4b1d-8761-de7b24b00638	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.672635	2022-08-09 15:00:31.672635
c2de0cd3-0b5d-4ba7-8d30-4f3e0eefdf3c	f23bc8d5-ff27-4b1d-8761-de7b24b00638	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.676307	2022-08-09 15:00:31.676307
c120beaa-abd0-4ba5-a4ca-2ae8e8497579	13150d8f-3d86-4fb7-85e9-d4656d5f0b43	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.679796	2022-08-09 15:00:31.679796
335080fe-5bdc-4b63-b639-8b77de38fa39	13150d8f-3d86-4fb7-85e9-d4656d5f0b43	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.683262	2022-08-09 15:00:31.683262
2815a9ab-002c-4711-a462-3103ecc58c26	13150d8f-3d86-4fb7-85e9-d4656d5f0b43	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.68704	2022-08-09 15:00:31.68704
46a34a32-4d8c-4d67-9606-097047a2b5b8	82d4b5a2-6eda-4ab1-bd7a-fbb9abe59252	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.69288	2022-08-09 15:00:31.69288
ac96a94d-df53-44c1-b87e-a638e6fe0e9a	82d4b5a2-6eda-4ab1-bd7a-fbb9abe59252	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.696673	2022-08-09 15:00:31.696673
b8097d89-6b10-496a-9d05-ac26069265c4	82d4b5a2-6eda-4ab1-bd7a-fbb9abe59252	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.700247	2022-08-09 15:00:31.700247
d87ef45d-37dc-49f2-beaf-b3aab5d59f6e	9d34fbd4-f65a-4280-942d-ed78ec9eef91	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.703576	2022-08-09 15:00:31.703576
d2898067-8b44-46fe-adc7-ffd16ff60929	9d34fbd4-f65a-4280-942d-ed78ec9eef91	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.707721	2022-08-09 15:00:31.707721
02816b6f-aeb5-4e81-a885-b576d0f0386a	9d34fbd4-f65a-4280-942d-ed78ec9eef91	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.711352	2022-08-09 15:00:31.711352
57c026e8-ce6a-4663-95e2-4f392995a667	932cd99c-6c7f-48c6-adde-8708426a94d1	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.714986	2022-08-09 15:00:31.714986
9f57f709-8639-4119-afec-451d01314ca7	932cd99c-6c7f-48c6-adde-8708426a94d1	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.718646	2022-08-09 15:00:31.718646
e8ce22ed-810e-4896-ae85-bac45e280e78	932cd99c-6c7f-48c6-adde-8708426a94d1	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.722531	2022-08-09 15:00:31.722531
8bed2dd7-274a-45b0-8e8a-b3b4faf6f0d1	c3fca1ab-78a2-47e6-9319-b714a8aab8d1	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.725963	2022-08-09 15:00:31.725963
80fe0feb-f273-4973-8e9b-5a3df8baf301	c3fca1ab-78a2-47e6-9319-b714a8aab8d1	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.729664	2022-08-09 15:00:31.729664
2eb39302-178c-47ca-87ed-101169aebdce	c3fca1ab-78a2-47e6-9319-b714a8aab8d1	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.735498	2022-08-09 15:00:31.735498
46d7c8ac-8464-4c5a-9ca7-740fb8f86c1c	2cf3f771-83a3-4ed1-ade8-4fc70e062e56	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.742842	2022-08-09 15:00:31.742842
eef8ed38-f298-4d3c-89aa-28ab1094920c	2cf3f771-83a3-4ed1-ade8-4fc70e062e56	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.751389	2022-08-09 15:00:31.751389
6ceaf815-7633-49ba-81d7-7c6439b22b4a	2cf3f771-83a3-4ed1-ade8-4fc70e062e56	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.760866	2022-08-09 15:00:31.760866
cc6153bd-9fb4-434a-a72e-cead536c4073	d7101381-a15b-4b07-82bf-acf551c1a183	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.767523	2022-08-09 15:00:31.767523
d9f0886a-34fc-4bc5-a788-744fc11539b3	d7101381-a15b-4b07-82bf-acf551c1a183	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.776251	2022-08-09 15:00:31.776251
26547458-b367-48b1-8014-4ad4a8995a66	d7101381-a15b-4b07-82bf-acf551c1a183	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.785152	2022-08-09 15:00:31.785152
fe5d36fa-10b5-4c34-b867-72f7a5c8355f	d9da15fd-8f19-4be2-b724-457411ef5383	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.819642	2022-08-09 15:00:31.819642
cfa5666f-dcc8-44f0-acf4-1baef7681837	d9da15fd-8f19-4be2-b724-457411ef5383	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.829968	2022-08-09 15:00:31.829968
e749ba95-8ccd-4914-9945-3cee554708a4	d9da15fd-8f19-4be2-b724-457411ef5383	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.839962	2022-08-09 15:00:31.839962
e4136ac8-80ae-43af-8be1-802e57cf3109	8b76526c-5407-422e-8b37-41f5ea18adab	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.84784	2022-08-09 15:00:31.84784
0f6acd14-7f8c-4998-8287-85ad183ea7a2	8b76526c-5407-422e-8b37-41f5ea18adab	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.858242	2022-08-09 15:00:31.858242
9cd48ae4-24c1-4288-b880-8a60c8ef399c	8b76526c-5407-422e-8b37-41f5ea18adab	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.899473	2022-08-09 15:00:31.899473
1bb2bf3d-901b-493a-a65c-fd226564c652	ce3eea37-0292-4432-ab88-26664e2f9426	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.903803	2022-08-09 15:00:31.903803
db7c9eef-13d4-471f-8ac9-651844557637	ce3eea37-0292-4432-ab88-26664e2f9426	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.907916	2022-08-09 15:00:31.907916
367df203-d80d-4a24-9a39-82c8867fa472	ce3eea37-0292-4432-ab88-26664e2f9426	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.911975	2022-08-09 15:00:31.911975
6914ba4b-a394-4e86-a4a1-2039aeba0c7d	0f28c43e-446e-431e-ba16-88263409c389	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.915625	2022-08-09 15:00:31.915625
4d5e87bc-cfb6-402b-b8dc-410b269686ca	0f28c43e-446e-431e-ba16-88263409c389	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.919321	2022-08-09 15:00:31.919321
6e9bba89-b780-4f7c-be4f-6fe450f7cf22	0f28c43e-446e-431e-ba16-88263409c389	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.922996	2022-08-09 15:00:31.922996
a6318084-32e4-4130-a97d-c6ebbccbad63	0c173901-79f4-4077-a277-aff0352b05e2	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.926717	2022-08-09 15:00:31.926717
c2ef9195-72c4-43f0-81b0-1f75cbecf7f7	0c173901-79f4-4077-a277-aff0352b05e2	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.930478	2022-08-09 15:00:31.930478
3e6cb655-d231-4c50-91b4-217ea95527b5	0c173901-79f4-4077-a277-aff0352b05e2	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.934333	2022-08-09 15:00:31.934333
bbc65181-8429-42b4-94e6-8b40fdec7049	5d1656b5-a45d-4746-b986-6633cefa543f	1970-01-01	substantive	25000.0	2022-08-09 15:00:31.938102	2022-08-09 15:00:31.938102
dd26fee5-e55c-460f-a3fe-50418895273b	5d1656b5-a45d-4746-b986-6633cefa543f	1970-01-01	delegated_functions	1350.0	2022-08-09 15:00:31.941947	2022-08-09 15:00:31.941947
c4d25670-7f02-405e-9bc2-2c76c618a7e8	5d1656b5-a45d-4746-b986-6633cefa543f	2021-09-13	delegated_functions	2250.0	2022-08-09 15:00:31.945639	2022-08-09 15:00:31.945639
\.


--
-- Data for Name: matter_types; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.matter_types (id, name, created_at, updated_at, category_of_law, code, category_of_law_code) FROM stdin;
2a8e4621-8d2c-4d74-815c-89f5879a5038	Domestic abuse	2022-08-09 15:00:30.884946	2022-08-09 15:00:30.884946	Family	MINJN	MAT
c4155d62-ece9-4cbe-ab10-51905253ddb5	Children - section 8	2022-08-09 15:00:30.93492	2022-08-09 15:00:30.93492	Family	KSEC8	MAT
\.


--
-- Data for Name: merits_tasks; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.merits_tasks (id, name, type, created_at, updated_at) FROM stdin;
166d9319-565a-442f-a72a-b2f2aa59b9db	latest_incident_details	ApplicationTask	2022-08-09 15:00:32.048785	2022-08-09 15:00:32.048785
f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	opponent_details	ApplicationTask	2022-08-09 15:00:32.05381	2022-08-09 15:00:32.05381
35f7f31e-655b-4ed7-8dc2-fa4d9a1a5e72	children_application	ApplicationTask	2022-08-09 15:00:32.057552	2022-08-09 15:00:32.057552
27725f0f-604c-4c84-821d-e05c0899888b	statement_of_case	ApplicationTask	2022-08-09 15:00:32.061271	2022-08-09 15:00:32.061271
12ce8ff4-23af-44ae-8f0f-c2142987e19e	chances_of_success	ProceedingTask	2022-08-09 15:00:32.068398	2022-08-09 15:00:32.068398
812d924b-d17a-4c0b-bcb9-e1e62accb335	children_proceeding	ProceedingTask	2022-08-09 15:00:32.11474	2022-08-09 15:00:32.11474
44aac365-b508-4cfa-9918-8d58c083f1a8	attempts_to_settle	ProceedingTask	2022-08-09 15:00:32.119611	2022-08-09 15:00:32.119611
\.


--
-- Data for Name: proceeding_type_merits_tasks; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.proceeding_type_merits_tasks (id, proceeding_type_id, merits_task_id, sequence, created_at, updated_at) FROM stdin;
219a8210-74bf-431d-a4fb-fcd7c726a80b	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	166d9319-565a-442f-a72a-b2f2aa59b9db	10	2022-08-09 15:00:32.182663	2022-08-09 15:00:32.182663
64220408-af19-481c-b3ac-a2aa37143564	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	20	2022-08-09 15:00:32.234721	2022-08-09 15:00:32.234721
4c7b7083-2183-45fd-9e2a-a1afe0deafe1	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	27725f0f-604c-4c84-821d-e05c0899888b	30	2022-08-09 15:00:32.242645	2022-08-09 15:00:32.242645
1c178115-d583-47fa-9695-7a783d1fca12	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	12ce8ff4-23af-44ae-8f0f-c2142987e19e	40	2022-08-09 15:00:32.250076	2022-08-09 15:00:32.250076
ad2fdda9-6ede-4bb6-a6b3-d4d6af846e7c	891f647c-4c41-43aa-9869-a339422c263b	166d9319-565a-442f-a72a-b2f2aa59b9db	10	2022-08-09 15:00:32.257985	2022-08-09 15:00:32.257985
6502e1d3-ecfd-4dd8-92bc-6921e943b5e6	891f647c-4c41-43aa-9869-a339422c263b	f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	20	2022-08-09 15:00:32.265294	2022-08-09 15:00:32.265294
af29eb33-e920-411f-b015-e95eda177f4b	891f647c-4c41-43aa-9869-a339422c263b	27725f0f-604c-4c84-821d-e05c0899888b	30	2022-08-09 15:00:32.272192	2022-08-09 15:00:32.272192
44a5f44f-114f-48e5-8858-0d05640b0f46	891f647c-4c41-43aa-9869-a339422c263b	12ce8ff4-23af-44ae-8f0f-c2142987e19e	40	2022-08-09 15:00:32.278946	2022-08-09 15:00:32.278946
0de6c5fb-f9d3-4b1d-98e1-ab7c46c3a7bb	284b2853-a988-4962-8b0f-bf3ba47a8737	166d9319-565a-442f-a72a-b2f2aa59b9db	10	2022-08-09 15:00:32.286452	2022-08-09 15:00:32.286452
3a49e851-8748-438b-a8ce-1903a0fc7e67	284b2853-a988-4962-8b0f-bf3ba47a8737	f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	20	2022-08-09 15:00:32.292825	2022-08-09 15:00:32.292825
1a71e962-8db3-4251-bd43-0385004cddcc	284b2853-a988-4962-8b0f-bf3ba47a8737	27725f0f-604c-4c84-821d-e05c0899888b	30	2022-08-09 15:00:32.299695	2022-08-09 15:00:32.299695
4bcbeaa0-f47f-4bba-ae85-c418dbe29f4d	284b2853-a988-4962-8b0f-bf3ba47a8737	12ce8ff4-23af-44ae-8f0f-c2142987e19e	40	2022-08-09 15:00:32.306919	2022-08-09 15:00:32.306919
b9eebabc-fbba-4588-9f43-65532e914fc5	09976e47-459c-4028-9ba4-bec984b54519	166d9319-565a-442f-a72a-b2f2aa59b9db	10	2022-08-09 15:00:32.31436	2022-08-09 15:00:32.31436
6a3e48cb-48ed-4e39-b534-0f38836e5690	09976e47-459c-4028-9ba4-bec984b54519	f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	20	2022-08-09 15:00:32.320759	2022-08-09 15:00:32.320759
b1861847-b8bb-419d-ac8f-0061d7c74c71	09976e47-459c-4028-9ba4-bec984b54519	27725f0f-604c-4c84-821d-e05c0899888b	30	2022-08-09 15:00:32.327431	2022-08-09 15:00:32.327431
2fb282ee-fd88-4482-98bb-4c607c46b195	09976e47-459c-4028-9ba4-bec984b54519	12ce8ff4-23af-44ae-8f0f-c2142987e19e	40	2022-08-09 15:00:32.334478	2022-08-09 15:00:32.334478
1466fdcb-dbee-42b9-a87a-69d94078a977	11fb5a94-45e4-4688-9fad-d4db494df0eb	166d9319-565a-442f-a72a-b2f2aa59b9db	10	2022-08-09 15:00:32.34235	2022-08-09 15:00:32.34235
820aac2d-bac7-477f-833f-9658a54ab4bf	11fb5a94-45e4-4688-9fad-d4db494df0eb	f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	20	2022-08-09 15:00:32.349025	2022-08-09 15:00:32.349025
b085f5f8-efc2-4ac1-b08f-f4dde085432d	11fb5a94-45e4-4688-9fad-d4db494df0eb	27725f0f-604c-4c84-821d-e05c0899888b	30	2022-08-09 15:00:32.355478	2022-08-09 15:00:32.355478
de36b1f7-1ea6-4ca6-b5fb-f2a39b220456	11fb5a94-45e4-4688-9fad-d4db494df0eb	12ce8ff4-23af-44ae-8f0f-c2142987e19e	40	2022-08-09 15:00:32.362667	2022-08-09 15:00:32.362667
7dfef464-9fc5-44e6-8dbd-3dc4d99d0658	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	166d9319-565a-442f-a72a-b2f2aa59b9db	10	2022-08-09 15:00:32.370214	2022-08-09 15:00:32.370214
00bf9cae-9f69-42c5-bafd-6a0f2e103a01	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	20	2022-08-09 15:00:32.377057	2022-08-09 15:00:32.377057
385eb1c7-0007-4051-8b9e-157501bbb783	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	27725f0f-604c-4c84-821d-e05c0899888b	30	2022-08-09 15:00:32.383386	2022-08-09 15:00:32.383386
d017a3d2-26c8-4390-bf61-89989718a5dd	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	12ce8ff4-23af-44ae-8f0f-c2142987e19e	40	2022-08-09 15:00:32.390468	2022-08-09 15:00:32.390468
63455434-3db0-4211-bee5-e7ab9d4ce3fa	3a437cd4-778f-4325-98dd-f79638a3907a	166d9319-565a-442f-a72a-b2f2aa59b9db	10	2022-08-09 15:00:32.397985	2022-08-09 15:00:32.397985
707d5dde-6531-4f4a-b550-fe0e5d76c1f5	3a437cd4-778f-4325-98dd-f79638a3907a	f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	20	2022-08-09 15:00:32.40479	2022-08-09 15:00:32.40479
254d543a-2217-41a7-83da-6ce28bf49ee9	3a437cd4-778f-4325-98dd-f79638a3907a	27725f0f-604c-4c84-821d-e05c0899888b	30	2022-08-09 15:00:32.411398	2022-08-09 15:00:32.411398
559c891d-66a6-4549-ab93-fb06d11898d1	3a437cd4-778f-4325-98dd-f79638a3907a	12ce8ff4-23af-44ae-8f0f-c2142987e19e	40	2022-08-09 15:00:32.417874	2022-08-09 15:00:32.417874
989fba22-0a5a-4958-9f3c-eda58eeb1f85	c7f19bf7-a918-440b-bdd9-abd0ed19b692	166d9319-565a-442f-a72a-b2f2aa59b9db	10	2022-08-09 15:00:32.425193	2022-08-09 15:00:32.425193
fb8e1778-ec8d-4c91-920e-e7a7b1b9508b	c7f19bf7-a918-440b-bdd9-abd0ed19b692	f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	20	2022-08-09 15:00:32.431839	2022-08-09 15:00:32.431839
3af17f09-ceb1-4b7c-a754-13692a3906c8	c7f19bf7-a918-440b-bdd9-abd0ed19b692	27725f0f-604c-4c84-821d-e05c0899888b	30	2022-08-09 15:00:32.438767	2022-08-09 15:00:32.438767
6c8a6575-d73f-4d92-964d-28e464eb3bc7	c7f19bf7-a918-440b-bdd9-abd0ed19b692	12ce8ff4-23af-44ae-8f0f-c2142987e19e	40	2022-08-09 15:00:32.445701	2022-08-09 15:00:32.445701
57933237-b2b5-4b38-b564-cf42a1493213	98f3b2c9-0a72-48ba-be77-11c93b9818ad	166d9319-565a-442f-a72a-b2f2aa59b9db	10	2022-08-09 15:00:32.458975	2022-08-09 15:00:32.458975
a669ad4d-dede-4ecd-86ad-42bc4994d0aa	98f3b2c9-0a72-48ba-be77-11c93b9818ad	f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	20	2022-08-09 15:00:32.467163	2022-08-09 15:00:32.467163
6f9e62d1-f92f-4410-ab8b-dd2be6342fcb	98f3b2c9-0a72-48ba-be77-11c93b9818ad	27725f0f-604c-4c84-821d-e05c0899888b	30	2022-08-09 15:00:32.475915	2022-08-09 15:00:32.475915
821b4e89-3029-452e-b0df-65b3e33592c6	98f3b2c9-0a72-48ba-be77-11c93b9818ad	12ce8ff4-23af-44ae-8f0f-c2142987e19e	40	2022-08-09 15:00:32.483537	2022-08-09 15:00:32.483537
c8408def-fffb-4a63-9d86-c183561ce23f	98f3b2c9-0a72-48ba-be77-11c93b9818ad	35f7f31e-655b-4ed7-8dc2-fa4d9a1a5e72	50	2022-08-09 15:00:32.49099	2022-08-09 15:00:32.49099
1e4a7e26-dd78-42d2-8667-c05cfadb03e5	98f3b2c9-0a72-48ba-be77-11c93b9818ad	812d924b-d17a-4c0b-bcb9-e1e62accb335	60	2022-08-09 15:00:32.499599	2022-08-09 15:00:32.499599
5e8d15dc-6acc-43f4-80ab-120eb19f40bf	98f3b2c9-0a72-48ba-be77-11c93b9818ad	44aac365-b508-4cfa-9918-8d58c083f1a8	70	2022-08-09 15:00:32.508834	2022-08-09 15:00:32.508834
1d894dcd-c7c3-4293-a2c3-77b829b66bf9	a0d435d2-2c7f-4812-9492-7593835180f6	166d9319-565a-442f-a72a-b2f2aa59b9db	10	2022-08-09 15:00:32.558348	2022-08-09 15:00:32.558348
b46399a8-eec8-432d-b1e9-7f3ba7a4e8f1	a0d435d2-2c7f-4812-9492-7593835180f6	f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	20	2022-08-09 15:00:32.565943	2022-08-09 15:00:32.565943
8f47d9b1-e9f1-41c9-993a-16e86a2ff8cc	a0d435d2-2c7f-4812-9492-7593835180f6	27725f0f-604c-4c84-821d-e05c0899888b	30	2022-08-09 15:00:32.573807	2022-08-09 15:00:32.573807
3328ed44-5580-4866-8dbe-d8111ee1bc39	a0d435d2-2c7f-4812-9492-7593835180f6	12ce8ff4-23af-44ae-8f0f-c2142987e19e	40	2022-08-09 15:00:32.582604	2022-08-09 15:00:32.582604
d98ed463-004f-4064-9e61-5c8e97895be2	a0d435d2-2c7f-4812-9492-7593835180f6	35f7f31e-655b-4ed7-8dc2-fa4d9a1a5e72	50	2022-08-09 15:00:32.631204	2022-08-09 15:00:32.631204
2a86be38-376e-4183-961c-2e46185acdc5	a0d435d2-2c7f-4812-9492-7593835180f6	812d924b-d17a-4c0b-bcb9-e1e62accb335	60	2022-08-09 15:00:32.71198	2022-08-09 15:00:32.71198
13cc76ad-531c-497b-970b-cd6aae94b452	a0d435d2-2c7f-4812-9492-7593835180f6	44aac365-b508-4cfa-9918-8d58c083f1a8	70	2022-08-09 15:00:32.720249	2022-08-09 15:00:32.720249
937f028c-f073-4724-b62d-a3bbd9ada806	e136ecbb-ec9d-42df-804f-2a363bb13e96	166d9319-565a-442f-a72a-b2f2aa59b9db	10	2022-08-09 15:00:32.753306	2022-08-09 15:00:32.753306
3fb6f85b-e4f7-49fa-a146-e232afe9281d	e136ecbb-ec9d-42df-804f-2a363bb13e96	f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	20	2022-08-09 15:00:32.802365	2022-08-09 15:00:32.802365
c7363fdc-ef0c-43e2-a4a6-b7c09f44b2c9	e136ecbb-ec9d-42df-804f-2a363bb13e96	27725f0f-604c-4c84-821d-e05c0899888b	30	2022-08-09 15:00:32.883556	2022-08-09 15:00:32.883556
2731eb13-1f28-484a-b919-4611f5793f5a	e136ecbb-ec9d-42df-804f-2a363bb13e96	12ce8ff4-23af-44ae-8f0f-c2142987e19e	40	2022-08-09 15:00:33.004064	2022-08-09 15:00:33.004064
1948b710-964f-4116-ae65-76df3f352331	e136ecbb-ec9d-42df-804f-2a363bb13e96	35f7f31e-655b-4ed7-8dc2-fa4d9a1a5e72	50	2022-08-09 15:00:33.207348	2022-08-09 15:00:33.207348
760428aa-e2a5-45d3-b806-5495a47cf8b3	e136ecbb-ec9d-42df-804f-2a363bb13e96	812d924b-d17a-4c0b-bcb9-e1e62accb335	60	2022-08-09 15:00:33.290154	2022-08-09 15:00:33.290154
3316d0f0-1586-4344-b37a-a5df92bdb032	e136ecbb-ec9d-42df-804f-2a363bb13e96	44aac365-b508-4cfa-9918-8d58c083f1a8	70	2022-08-09 15:00:33.298329	2022-08-09 15:00:33.298329
0bca4de4-415b-460f-aca8-6068dc6d1c20	fec79071-885c-40e2-aad0-d98d5591aad5	166d9319-565a-442f-a72a-b2f2aa59b9db	10	2022-08-09 15:00:33.346868	2022-08-09 15:00:33.346868
1aadfc89-aff7-476c-951d-6e417d43efc1	fec79071-885c-40e2-aad0-d98d5591aad5	f4d9a7d7-1f9e-4079-a11b-c8089e8ca2b6	20	2022-08-09 15:00:33.355297	2022-08-09 15:00:33.355297
51f07206-2607-4f86-b838-205c655d08cd	fec79071-885c-40e2-aad0-d98d5591aad5	27725f0f-604c-4c84-821d-e05c0899888b	30	2022-08-09 15:00:33.364185	2022-08-09 15:00:33.364185
2dab7d87-0c43-4865-ad41-f69b68bf2461	fec79071-885c-40e2-aad0-d98d5591aad5	12ce8ff4-23af-44ae-8f0f-c2142987e19e	40	2022-08-09 15:00:33.371195	2022-08-09 15:00:33.371195
c5843018-636e-4f59-8511-8dbfd6745451	fec79071-885c-40e2-aad0-d98d5591aad5	35f7f31e-655b-4ed7-8dc2-fa4d9a1a5e72	50	2022-08-09 15:00:33.377913	2022-08-09 15:00:33.377913
075ddb11-d433-47f6-a7ff-b94f0fe9874e	fec79071-885c-40e2-aad0-d98d5591aad5	812d924b-d17a-4c0b-bcb9-e1e62accb335	60	2022-08-09 15:00:33.384774	2022-08-09 15:00:33.384774
54db746b-7583-49f7-870a-fabc45e0829a	fec79071-885c-40e2-aad0-d98d5591aad5	44aac365-b508-4cfa-9918-8d58c083f1a8	70	2022-08-09 15:00:33.391493	2022-08-09 15:00:33.391493
\.


--
-- Data for Name: proceeding_type_scope_limitations; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.proceeding_type_scope_limitations (id, proceeding_type_id, scope_limitation_id, substantive_default, delegated_functions_default, created_at, updated_at) FROM stdin;
669a64c9-aa54-43d6-a56e-56a16b7c96c1	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	ef06b4f0-e516-4c75-8936-95bf178237c3	f	f	2022-08-09 15:00:33.800922	2022-08-09 15:00:33.800922
58721a1b-31c2-41b7-beee-74cdb84b842c	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	0e03e1af-7497-4f06-b79d-49bd8e24d3b8	f	f	2022-08-09 15:00:33.850489	2022-08-09 15:00:33.850489
814aa252-c0f9-446b-86bf-952f44bef32f	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	731b0c53-1e5c-4216-afcb-838c3794116e	f	f	2022-08-09 15:00:33.858877	2022-08-09 15:00:33.858877
d5aa0c6a-8c54-4a0b-abef-80ba2a445542	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	b3faa52b-79d0-4005-9457-d0b5b2ca2d26	f	f	2022-08-09 15:00:33.866865	2022-08-09 15:00:33.866865
078fc861-f072-4198-86a6-eb0d510b2c7a	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	fd4283df-ae72-484b-9fac-d07f63fd7cb8	f	t	2022-08-09 15:00:33.873682	2022-08-09 15:00:33.873682
7b24b653-e5bf-4ce8-bda1-a0a7eaf2d32d	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	170781bb-e733-43d6-9a20-37f9a19994ef	f	f	2022-08-09 15:00:33.881237	2022-08-09 15:00:33.881237
937ff1c3-5e2c-4e77-8ce8-2a9bd218148f	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	06afe393-62fc-43ca-8b82-5b25d01da00b	f	f	2022-08-09 15:00:33.888201	2022-08-09 15:00:33.888201
46574461-90f5-47c1-a801-4a8c0f9f4ea4	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	fa374848-082d-456e-beb0-96c7679e17fa	f	f	2022-08-09 15:00:33.894369	2022-08-09 15:00:33.894369
7af784c7-9b8b-4dc6-8eb6-e0dac1446f17	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	9161a7f7-e44f-49af-9eeb-e77954903d40	t	f	2022-08-09 15:00:33.900833	2022-08-09 15:00:33.900833
b6c513ce-f075-43f2-a38e-303d97f23fd9	891f647c-4c41-43aa-9869-a339422c263b	ef06b4f0-e516-4c75-8936-95bf178237c3	f	f	2022-08-09 15:00:33.907205	2022-08-09 15:00:33.907205
6019a855-6f9b-4890-9ae1-c1ec4d545e42	891f647c-4c41-43aa-9869-a339422c263b	0e03e1af-7497-4f06-b79d-49bd8e24d3b8	t	f	2022-08-09 15:00:33.913881	2022-08-09 15:00:33.913881
3a9a614c-dd20-4449-b361-66d0bd9043a1	891f647c-4c41-43aa-9869-a339422c263b	731b0c53-1e5c-4216-afcb-838c3794116e	f	f	2022-08-09 15:00:33.920469	2022-08-09 15:00:33.920469
39937077-be03-4cd0-a3c0-32973caa56ee	891f647c-4c41-43aa-9869-a339422c263b	b3faa52b-79d0-4005-9457-d0b5b2ca2d26	f	f	2022-08-09 15:00:33.926683	2022-08-09 15:00:33.926683
fc22cee6-f67b-4db9-b173-5b2d08b62229	891f647c-4c41-43aa-9869-a339422c263b	fd4283df-ae72-484b-9fac-d07f63fd7cb8	f	t	2022-08-09 15:00:33.933261	2022-08-09 15:00:33.933261
7d968acb-69fd-4fb2-8c88-4dbbc03a1522	891f647c-4c41-43aa-9869-a339422c263b	170781bb-e733-43d6-9a20-37f9a19994ef	f	f	2022-08-09 15:00:33.939372	2022-08-09 15:00:33.939372
8467a9d9-98ae-4a22-b04d-4dba46e80e76	891f647c-4c41-43aa-9869-a339422c263b	06afe393-62fc-43ca-8b82-5b25d01da00b	f	f	2022-08-09 15:00:33.945837	2022-08-09 15:00:33.945837
38644989-8300-49f1-adc0-ca4486695cf2	891f647c-4c41-43aa-9869-a339422c263b	fa374848-082d-456e-beb0-96c7679e17fa	f	f	2022-08-09 15:00:33.952084	2022-08-09 15:00:33.952084
ec70831c-d569-4064-8572-718a71737e9c	891f647c-4c41-43aa-9869-a339422c263b	a074289e-1327-4f68-9a12-276d4ae3c685	f	f	2022-08-09 15:00:33.958454	2022-08-09 15:00:33.958454
21561f3a-e0fa-47c0-b508-6cd1755e8812	284b2853-a988-4962-8b0f-bf3ba47a8737	ef06b4f0-e516-4c75-8936-95bf178237c3	f	f	2022-08-09 15:00:33.964811	2022-08-09 15:00:33.964811
c1957459-8694-48c9-9954-ee0fa12b901e	284b2853-a988-4962-8b0f-bf3ba47a8737	0e03e1af-7497-4f06-b79d-49bd8e24d3b8	t	f	2022-08-09 15:00:33.971127	2022-08-09 15:00:33.971127
3a11f59b-441e-4d5a-814f-3591747c0f54	284b2853-a988-4962-8b0f-bf3ba47a8737	731b0c53-1e5c-4216-afcb-838c3794116e	f	f	2022-08-09 15:00:33.977399	2022-08-09 15:00:33.977399
09bf034f-73cb-4db9-be7e-f2204e2c7354	284b2853-a988-4962-8b0f-bf3ba47a8737	b3faa52b-79d0-4005-9457-d0b5b2ca2d26	f	f	2022-08-09 15:00:33.983464	2022-08-09 15:00:33.983464
86ee06f2-b362-4b4f-8b58-3eed4f24b872	284b2853-a988-4962-8b0f-bf3ba47a8737	fd4283df-ae72-484b-9fac-d07f63fd7cb8	f	t	2022-08-09 15:00:33.989977	2022-08-09 15:00:33.989977
c021b76c-acb6-492b-b0cf-d66b886f9f0d	284b2853-a988-4962-8b0f-bf3ba47a8737	170781bb-e733-43d6-9a20-37f9a19994ef	f	f	2022-08-09 15:00:33.996394	2022-08-09 15:00:33.996394
0952300d-a0fb-4434-9dab-b69eac485f4c	284b2853-a988-4962-8b0f-bf3ba47a8737	06afe393-62fc-43ca-8b82-5b25d01da00b	f	f	2022-08-09 15:00:34.002525	2022-08-09 15:00:34.002525
c5420adb-446a-4ed7-8726-a759397b51c9	284b2853-a988-4962-8b0f-bf3ba47a8737	fa374848-082d-456e-beb0-96c7679e17fa	f	f	2022-08-09 15:00:34.008841	2022-08-09 15:00:34.008841
f3844824-7732-4836-9752-31c86cccc094	284b2853-a988-4962-8b0f-bf3ba47a8737	a074289e-1327-4f68-9a12-276d4ae3c685	f	f	2022-08-09 15:00:34.015241	2022-08-09 15:00:34.015241
a9aab0de-deba-4393-a3f8-73855ab9107d	284b2853-a988-4962-8b0f-bf3ba47a8737	9161a7f7-e44f-49af-9eeb-e77954903d40	f	f	2022-08-09 15:00:34.021407	2022-08-09 15:00:34.021407
f673522d-bb2f-4095-b82a-8196e2632ea5	09976e47-459c-4028-9ba4-bec984b54519	ef06b4f0-e516-4c75-8936-95bf178237c3	f	f	2022-08-09 15:00:34.028012	2022-08-09 15:00:34.028012
58dd6ae2-0d03-4663-a5c5-8c09bfe16ea5	09976e47-459c-4028-9ba4-bec984b54519	0e03e1af-7497-4f06-b79d-49bd8e24d3b8	t	f	2022-08-09 15:00:34.034196	2022-08-09 15:00:34.034196
1d296e52-fc9b-4c63-8e6c-59382a872ef3	09976e47-459c-4028-9ba4-bec984b54519	731b0c53-1e5c-4216-afcb-838c3794116e	f	f	2022-08-09 15:00:34.040556	2022-08-09 15:00:34.040556
fa71035a-fa3a-458a-b3df-dbeda30e74c1	09976e47-459c-4028-9ba4-bec984b54519	b3faa52b-79d0-4005-9457-d0b5b2ca2d26	f	f	2022-08-09 15:00:34.047128	2022-08-09 15:00:34.047128
e54c7103-917a-46b9-aced-c59a16c90095	09976e47-459c-4028-9ba4-bec984b54519	fd4283df-ae72-484b-9fac-d07f63fd7cb8	f	t	2022-08-09 15:00:34.058302	2022-08-09 15:00:34.058302
bda41125-cd40-4387-904e-6317af31f221	09976e47-459c-4028-9ba4-bec984b54519	170781bb-e733-43d6-9a20-37f9a19994ef	f	f	2022-08-09 15:00:34.065371	2022-08-09 15:00:34.065371
43f9b497-5c00-4f35-bac5-f267a15ab137	09976e47-459c-4028-9ba4-bec984b54519	06afe393-62fc-43ca-8b82-5b25d01da00b	f	f	2022-08-09 15:00:34.07209	2022-08-09 15:00:34.07209
bcc44522-b42a-44ab-b920-7bb3bba92e4c	09976e47-459c-4028-9ba4-bec984b54519	fa374848-082d-456e-beb0-96c7679e17fa	f	f	2022-08-09 15:00:34.078769	2022-08-09 15:00:34.078769
04b073e6-1fce-4e52-95ae-585704335347	09976e47-459c-4028-9ba4-bec984b54519	a074289e-1327-4f68-9a12-276d4ae3c685	f	f	2022-08-09 15:00:34.085343	2022-08-09 15:00:34.085343
32aa7a72-7208-48d6-a005-783fdb8085c8	11fb5a94-45e4-4688-9fad-d4db494df0eb	ef06b4f0-e516-4c75-8936-95bf178237c3	f	f	2022-08-09 15:00:34.091942	2022-08-09 15:00:34.091942
27c8c252-2f7c-47f1-b320-6498c2aa8665	11fb5a94-45e4-4688-9fad-d4db494df0eb	0e03e1af-7497-4f06-b79d-49bd8e24d3b8	t	f	2022-08-09 15:00:34.098284	2022-08-09 15:00:34.098284
3ecbe76f-4710-43d6-a57a-5f5612ff7f54	11fb5a94-45e4-4688-9fad-d4db494df0eb	731b0c53-1e5c-4216-afcb-838c3794116e	f	f	2022-08-09 15:00:34.104887	2022-08-09 15:00:34.104887
aacfff40-681b-4deb-abfa-481c148e0bf3	11fb5a94-45e4-4688-9fad-d4db494df0eb	b3faa52b-79d0-4005-9457-d0b5b2ca2d26	f	f	2022-08-09 15:00:34.111128	2022-08-09 15:00:34.111128
dde1a9f7-de31-4c40-92ec-683e54a52f55	11fb5a94-45e4-4688-9fad-d4db494df0eb	fd4283df-ae72-484b-9fac-d07f63fd7cb8	f	t	2022-08-09 15:00:34.117458	2022-08-09 15:00:34.117458
f64ebd8c-0574-4c44-bed4-fa85c8516476	11fb5a94-45e4-4688-9fad-d4db494df0eb	170781bb-e733-43d6-9a20-37f9a19994ef	f	f	2022-08-09 15:00:34.124007	2022-08-09 15:00:34.124007
aaae271a-fc30-4497-bc60-8e8a6e445be4	11fb5a94-45e4-4688-9fad-d4db494df0eb	06afe393-62fc-43ca-8b82-5b25d01da00b	f	f	2022-08-09 15:00:34.130504	2022-08-09 15:00:34.130504
7fd1c6bf-5e40-42bb-9816-60919f4cc9c0	11fb5a94-45e4-4688-9fad-d4db494df0eb	fa374848-082d-456e-beb0-96c7679e17fa	f	f	2022-08-09 15:00:34.136587	2022-08-09 15:00:34.136587
7a469c41-3323-44b8-805d-0af132c90ded	11fb5a94-45e4-4688-9fad-d4db494df0eb	a074289e-1327-4f68-9a12-276d4ae3c685	f	f	2022-08-09 15:00:34.143014	2022-08-09 15:00:34.143014
3ac30e26-0556-41ad-8d43-dc8ade2198cb	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	ef06b4f0-e516-4c75-8936-95bf178237c3	f	f	2022-08-09 15:00:34.149545	2022-08-09 15:00:34.149545
70efd28c-62a5-4744-b49a-903f7845d6d7	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	0e03e1af-7497-4f06-b79d-49bd8e24d3b8	t	f	2022-08-09 15:00:34.156049	2022-08-09 15:00:34.156049
d4fd6833-9800-44c6-8e45-28704804a7d6	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	731b0c53-1e5c-4216-afcb-838c3794116e	f	f	2022-08-09 15:00:34.162727	2022-08-09 15:00:34.162727
f958a2ac-fc69-4d71-a5f0-1e1d504625fb	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	b3faa52b-79d0-4005-9457-d0b5b2ca2d26	f	f	2022-08-09 15:00:34.169225	2022-08-09 15:00:34.169225
8123a73d-463a-491a-94dc-044c28796027	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	fd4283df-ae72-484b-9fac-d07f63fd7cb8	f	t	2022-08-09 15:00:34.175654	2022-08-09 15:00:34.175654
a4aa2b9e-3d10-4da9-b4cf-5d6f471a5609	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	170781bb-e733-43d6-9a20-37f9a19994ef	f	f	2022-08-09 15:00:34.182419	2022-08-09 15:00:34.182419
89474c0b-6742-4b71-95ad-902f777fb80c	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	06afe393-62fc-43ca-8b82-5b25d01da00b	f	f	2022-08-09 15:00:34.191394	2022-08-09 15:00:34.191394
99148d6d-2110-4304-ac86-ee29134f2ac5	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	fa374848-082d-456e-beb0-96c7679e17fa	f	f	2022-08-09 15:00:34.198379	2022-08-09 15:00:34.198379
3ace69e0-c63d-4a00-8a39-16a323645c83	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	a074289e-1327-4f68-9a12-276d4ae3c685	f	f	2022-08-09 15:00:34.204889	2022-08-09 15:00:34.204889
0916ec77-18c4-4daf-85c8-42c9c740b955	3a437cd4-778f-4325-98dd-f79638a3907a	ef06b4f0-e516-4c75-8936-95bf178237c3	f	f	2022-08-09 15:00:34.211969	2022-08-09 15:00:34.211969
ba5856d5-0048-45ef-9507-4cd574b258e1	3a437cd4-778f-4325-98dd-f79638a3907a	0e03e1af-7497-4f06-b79d-49bd8e24d3b8	t	f	2022-08-09 15:00:34.218237	2022-08-09 15:00:34.218237
ca107527-1866-4482-b573-e2cc57b9dbb2	3a437cd4-778f-4325-98dd-f79638a3907a	731b0c53-1e5c-4216-afcb-838c3794116e	f	f	2022-08-09 15:00:34.224702	2022-08-09 15:00:34.224702
780e7284-7051-4113-965a-ba25868647e3	3a437cd4-778f-4325-98dd-f79638a3907a	b3faa52b-79d0-4005-9457-d0b5b2ca2d26	f	f	2022-08-09 15:00:34.231106	2022-08-09 15:00:34.231106
c1bdf639-c2c7-485d-a08e-fb00587afb11	3a437cd4-778f-4325-98dd-f79638a3907a	fd4283df-ae72-484b-9fac-d07f63fd7cb8	f	t	2022-08-09 15:00:34.237581	2022-08-09 15:00:34.237581
9df0a29a-5f34-4716-b13b-3a4112d599ea	3a437cd4-778f-4325-98dd-f79638a3907a	170781bb-e733-43d6-9a20-37f9a19994ef	f	f	2022-08-09 15:00:34.243987	2022-08-09 15:00:34.243987
ee41947c-4c70-460b-9426-c74d44fb0dba	3a437cd4-778f-4325-98dd-f79638a3907a	06afe393-62fc-43ca-8b82-5b25d01da00b	f	f	2022-08-09 15:00:34.250291	2022-08-09 15:00:34.250291
98e02429-5fdc-4a4d-93eb-fab863b5f5e7	3a437cd4-778f-4325-98dd-f79638a3907a	fa374848-082d-456e-beb0-96c7679e17fa	f	f	2022-08-09 15:00:34.256742	2022-08-09 15:00:34.256742
539679e8-82a1-4da4-ad95-2077cd904b67	3a437cd4-778f-4325-98dd-f79638a3907a	a074289e-1327-4f68-9a12-276d4ae3c685	f	f	2022-08-09 15:00:34.263352	2022-08-09 15:00:34.263352
a2a19f0a-7846-4dcf-b12a-4414bb9da1f7	c7f19bf7-a918-440b-bdd9-abd0ed19b692	ef06b4f0-e516-4c75-8936-95bf178237c3	f	f	2022-08-09 15:00:34.269868	2022-08-09 15:00:34.269868
838e820c-b840-4d37-a2b0-7a04ec348ca6	c7f19bf7-a918-440b-bdd9-abd0ed19b692	0e03e1af-7497-4f06-b79d-49bd8e24d3b8	f	f	2022-08-09 15:00:34.276045	2022-08-09 15:00:34.276045
db4ba922-5e43-49ef-a5bf-cb25439c598b	c7f19bf7-a918-440b-bdd9-abd0ed19b692	731b0c53-1e5c-4216-afcb-838c3794116e	f	f	2022-08-09 15:00:34.282494	2022-08-09 15:00:34.282494
652cca94-ef4a-4e0f-bb83-f14f0a49f55a	c7f19bf7-a918-440b-bdd9-abd0ed19b692	b3faa52b-79d0-4005-9457-d0b5b2ca2d26	f	f	2022-08-09 15:00:34.288773	2022-08-09 15:00:34.288773
5fc1ba16-1038-487d-b287-15d98e5ef5d6	c7f19bf7-a918-440b-bdd9-abd0ed19b692	fd4283df-ae72-484b-9fac-d07f63fd7cb8	f	t	2022-08-09 15:00:34.295299	2022-08-09 15:00:34.295299
ca91c6cd-2d2a-4c8b-bff1-c7edddffbf02	c7f19bf7-a918-440b-bdd9-abd0ed19b692	170781bb-e733-43d6-9a20-37f9a19994ef	f	f	2022-08-09 15:00:34.301795	2022-08-09 15:00:34.301795
c5dd966f-9f4d-4cee-a6e0-64e748ce0e67	c7f19bf7-a918-440b-bdd9-abd0ed19b692	06afe393-62fc-43ca-8b82-5b25d01da00b	f	f	2022-08-09 15:00:34.308454	2022-08-09 15:00:34.308454
d18fa264-ba13-4f1d-bd7d-6ec3ba0f8ab9	c7f19bf7-a918-440b-bdd9-abd0ed19b692	c00576f7-f269-42dd-9801-d9f6ff62e588	f	f	2022-08-09 15:00:34.314768	2022-08-09 15:00:34.314768
8a668679-9384-4e1c-8965-b6aac954ff2b	c7f19bf7-a918-440b-bdd9-abd0ed19b692	805e622b-de1e-4837-8d44-976f39612e82	f	f	2022-08-09 15:00:34.321281	2022-08-09 15:00:34.321281
59f3b2fd-0b1f-4d08-b62d-a4dff255958b	c7f19bf7-a918-440b-bdd9-abd0ed19b692	df5677c5-6d28-45f0-ba7a-737fcdd652ef	t	f	2022-08-09 15:00:34.327335	2022-08-09 15:00:34.327335
7df15097-7a4e-4f90-8570-bbba7e04d23e	c7f19bf7-a918-440b-bdd9-abd0ed19b692	f90f58dc-2766-4fcf-899c-bd6cc01e0c7b	f	f	2022-08-09 15:00:34.333798	2022-08-09 15:00:34.333798
bc904221-6e56-4b50-9764-d80d8f3f2f59	c7f19bf7-a918-440b-bdd9-abd0ed19b692	2849a47a-5f47-489f-b255-d7fa0b7587cf	f	f	2022-08-09 15:00:34.340179	2022-08-09 15:00:34.340179
5d2369eb-b21f-49f7-85d2-db26cc5bbfe5	c7f19bf7-a918-440b-bdd9-abd0ed19b692	a074289e-1327-4f68-9a12-276d4ae3c685	f	f	2022-08-09 15:00:34.346529	2022-08-09 15:00:34.346529
a2eed098-f16c-414a-b70a-08922ce9b569	98f3b2c9-0a72-48ba-be77-11c93b9818ad	fd4283df-ae72-484b-9fac-d07f63fd7cb8	f	t	2022-08-09 15:00:34.352881	2022-08-09 15:00:34.352881
2e2ec11a-719c-4fac-b9a4-1d7a1347176a	98f3b2c9-0a72-48ba-be77-11c93b9818ad	2a4e032b-5b1c-4835-8897-8a49f0eb4f0e	t	f	2022-08-09 15:00:34.361018	2022-08-09 15:00:34.361018
b081bf6b-564b-4a4f-802f-1e6e8ee0cf3d	a0d435d2-2c7f-4812-9492-7593835180f6	fd4283df-ae72-484b-9fac-d07f63fd7cb8	f	t	2022-08-09 15:00:34.367962	2022-08-09 15:00:34.367962
e94e32e1-b267-4fb6-8385-fbb7e5891bea	a0d435d2-2c7f-4812-9492-7593835180f6	2a4e032b-5b1c-4835-8897-8a49f0eb4f0e	t	f	2022-08-09 15:00:34.37459	2022-08-09 15:00:34.37459
35126f6a-362a-45ab-9a64-5f1b467cc157	e136ecbb-ec9d-42df-804f-2a363bb13e96	fd4283df-ae72-484b-9fac-d07f63fd7cb8	f	t	2022-08-09 15:00:34.381376	2022-08-09 15:00:34.381376
1671f88d-ba67-4d87-b94c-2d8255791693	e136ecbb-ec9d-42df-804f-2a363bb13e96	2a4e032b-5b1c-4835-8897-8a49f0eb4f0e	t	f	2022-08-09 15:00:34.388547	2022-08-09 15:00:34.388547
1d924ea2-889c-4bcd-bf63-62fe4e33a578	fec79071-885c-40e2-aad0-d98d5591aad5	fd4283df-ae72-484b-9fac-d07f63fd7cb8	f	t	2022-08-09 15:00:34.395323	2022-08-09 15:00:34.395323
77535748-c619-424c-bbe4-3532d799a799	fec79071-885c-40e2-aad0-d98d5591aad5	2a4e032b-5b1c-4835-8897-8a49f0eb4f0e	t	f	2022-08-09 15:00:34.401898	2022-08-09 15:00:34.401898
\.


--
-- Data for Name: proceeding_type_scopes; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.proceeding_type_scopes (id, proceeding_type_ccms_code, service_level, client_involvement_type_code, df_used, scope_limitation_code, "default", created_at, updated_at) FROM stdin;
87f06a00-79a9-49bd-ae82-8ff260ea9faa	SE003	1	A	t	CV027	f	2022-08-09 15:20:33.390866	2022-08-09 15:20:33.390866
87315a83-e339-40e3-9417-587496df38d9	SE003	1	D	t	CV027	f	2022-08-09 15:20:33.399208	2022-08-09 15:20:33.399208
9c2d2ccc-a6b6-46bb-814b-b8961831ada5	SE003	1	I	t	CV027	f	2022-08-09 15:20:33.404722	2022-08-09 15:20:33.404722
4500a5d6-5591-40ba-9deb-f40bec0b1aa2	SE003	1	W	t	CV027	f	2022-08-09 15:20:33.411608	2022-08-09 15:20:33.411608
8b7c2314-f5b6-491e-a6a5-bb81b741de03	SE003	1	Z	t	CV027	f	2022-08-09 15:20:33.418179	2022-08-09 15:20:33.418179
b411a852-2b29-4442-a7b5-55382816ecf1	SE003	1	A	f	CV027	f	2022-08-09 15:20:33.424734	2022-08-09 15:20:33.424734
39141b85-d444-49a7-aaf4-bca15ac9c28a	SE003	1	D	f	CV027	f	2022-08-09 15:20:33.43163	2022-08-09 15:20:33.43163
f3670e1b-fc50-43fa-bcfd-040a79a63c9e	SE003	1	I	f	CV027	f	2022-08-09 15:20:33.438349	2022-08-09 15:20:33.438349
ca605aab-e5ea-4deb-8b79-0ed12517ab1f	SE003	1	W	f	CV027	f	2022-08-09 15:20:33.444845	2022-08-09 15:20:33.444845
4641c693-145f-4d73-9f63-051e79ea3db7	SE003	1	Z	f	CV027	f	2022-08-09 15:20:33.451819	2022-08-09 15:20:33.451819
4cde7673-b688-421e-9680-05196f3625c5	SE003	1	A	t	CV079	f	2022-08-09 15:20:33.457513	2022-08-09 15:20:33.457513
42d746a9-33be-40b4-b6fa-a307d1bab6fe	SE003	1	D	t	CV079	f	2022-08-09 15:20:33.463449	2022-08-09 15:20:33.463449
631a5622-a738-4b3d-a041-53a58e5955be	SE003	1	I	t	CV079	f	2022-08-09 15:20:33.470085	2022-08-09 15:20:33.470085
f9c52196-b788-459b-b768-0bcae269eb42	SE003	1	W	t	CV079	f	2022-08-09 15:20:33.476729	2022-08-09 15:20:33.476729
92e280dd-c800-42aa-a24d-285cb375e177	SE003	1	Z	t	CV079	f	2022-08-09 15:20:33.482773	2022-08-09 15:20:33.482773
12aaab7e-1ac8-472d-ac1b-de20cb84d22e	SE003	1	A	f	CV079	f	2022-08-09 15:20:33.488252	2022-08-09 15:20:33.488252
d8782029-7821-484a-a098-38ad9777803c	SE003	1	D	f	CV079	f	2022-08-09 15:20:33.494737	2022-08-09 15:20:33.494737
b3cfd41d-c57b-4b36-98b0-459d73e1bf46	SE003	1	I	f	CV079	f	2022-08-09 15:20:33.501601	2022-08-09 15:20:33.501601
7b2434f5-fbd6-4b91-8ada-b45eca28b80c	SE003	1	W	f	CV079	f	2022-08-09 15:20:33.507178	2022-08-09 15:20:33.507178
eed1362d-a41c-4a80-aa0a-61444a150f87	SE003	1	Z	f	CV079	f	2022-08-09 15:20:33.513324	2022-08-09 15:20:33.513324
82959bf7-cef8-4297-90ad-367029c73386	SE003	1	D	t	CV117	f	2022-08-09 15:20:33.527304	2022-08-09 15:20:33.527304
824c3bdc-62a1-44b1-97e2-737512b97a52	SE003	1	I	t	CV117	f	2022-08-09 15:20:33.534076	2022-08-09 15:20:33.534076
1a3b1f01-71a2-4717-87c0-3ca950db0b2b	SE003	1	W	t	CV117	f	2022-08-09 15:20:33.539833	2022-08-09 15:20:33.539833
5fdb70c9-45c4-42ae-bdd7-fec1b397b9c7	SE003	1	Z	t	CV117	f	2022-08-09 15:20:33.545512	2022-08-09 15:20:33.545512
8d2acb22-fdbf-4a99-8d2e-ab36e1ccddbc	SE003	1	A	f	CV117	f	2022-08-09 15:20:33.564319	2022-08-09 15:20:33.564319
71e8a00d-3bdd-46c9-858e-25174f848a7b	SE003	1	D	f	CV117	f	2022-08-09 15:20:33.571227	2022-08-09 15:20:33.571227
d2d34948-8aa6-40be-a237-52a0e757c632	SE003	1	I	f	CV117	f	2022-08-09 15:20:33.578445	2022-08-09 15:20:33.578445
3cc1e48c-082b-421a-b485-8856001ef674	SE003	1	W	f	CV117	f	2022-08-09 15:20:33.586153	2022-08-09 15:20:33.586153
5f2c382b-ad2c-416d-a7e0-c580de87aa82	SE003	1	Z	f	CV117	f	2022-08-09 15:20:33.5919	2022-08-09 15:20:33.5919
65a437e4-c33f-49bf-850b-83eb43fc5bcf	SE003	1	A	t	CV118	f	2022-08-09 15:20:33.597711	2022-08-09 15:20:33.597711
068a24dc-ca63-4b40-954c-f0bc9d73330f	SE003	1	A	f	CV118	f	2022-08-09 15:20:33.627361	2022-08-09 15:20:33.627361
d42b2475-52c6-403a-b7e4-364628b69f9c	SE003	1	D	f	CV118	f	2022-08-09 15:20:33.702173	2022-08-09 15:20:33.702173
a870f5d7-b232-448a-bfe1-fb69cbca6af9	SE003	1	I	f	CV118	f	2022-08-09 15:20:33.710067	2022-08-09 15:20:33.710067
cc613ed4-66c0-4a49-924f-66f294cd0934	SE003	1	W	f	CV118	f	2022-08-09 15:20:33.717758	2022-08-09 15:20:33.717758
4b8c0fc0-8a5d-4d90-aaed-69dec656cbd1	SE003	1	Z	f	CV118	f	2022-08-09 15:20:33.723891	2022-08-09 15:20:33.723891
9bdd6fa7-7aa0-4ef9-a73d-4d2314531b4c	SE003	1	A	t	FM004	f	2022-08-09 15:20:33.730229	2022-08-09 15:20:33.730229
46a99151-1992-4d46-8867-17f0a111739a	SE003	1	D	t	FM004	f	2022-08-09 15:20:33.739912	2022-08-09 15:20:33.739912
65ad976d-dbdb-486b-8137-3f5fde9b8248	SE003	1	I	t	FM004	f	2022-08-09 15:20:33.746862	2022-08-09 15:20:33.746862
58f19a2a-68df-42ad-be8e-79abfb8a8ff1	SE003	1	W	t	FM004	f	2022-08-09 15:20:33.75296	2022-08-09 15:20:33.75296
23db8acd-7837-48ca-97c9-5a765fbf677e	SE003	1	Z	t	FM004	f	2022-08-09 15:20:33.759247	2022-08-09 15:20:33.759247
e6ef92a7-7c5f-453c-ad4c-946cae72bc83	SE003	1	A	f	FM004	f	2022-08-09 15:20:33.765177	2022-08-09 15:20:33.765177
ade16652-36a0-43c8-bebb-1d8626f0aefc	SE003	1	D	f	FM004	f	2022-08-09 15:20:33.7714	2022-08-09 15:20:33.7714
22dca768-db71-43b4-a3c7-9eb6118f54dc	SE003	1	I	f	FM004	f	2022-08-09 15:20:33.778319	2022-08-09 15:20:33.778319
9a55e5e0-4602-4ab7-9bb5-d0fa290401e1	SE003	1	W	f	FM004	f	2022-08-09 15:20:33.783955	2022-08-09 15:20:33.783955
c5a10e28-a680-4c94-affa-d7c7376097f2	SE003	1	Z	f	FM004	f	2022-08-09 15:20:33.789926	2022-08-09 15:20:33.789926
d0ce69dc-1f16-48b4-be20-06b3694928e5	SE003	1	A	t	FM007	f	2022-08-09 15:20:33.795843	2022-08-09 15:20:33.795843
f1d95c3a-fc92-46af-9beb-6b1822d24c40	SE003	1	D	t	FM007	f	2022-08-09 15:20:33.801886	2022-08-09 15:20:33.801886
8a552e7c-ac93-488d-a31a-4b0a63a48df5	SE003	1	I	t	FM007	f	2022-08-09 15:20:33.807324	2022-08-09 15:20:33.807324
eb6c52a2-5788-499b-83d4-fbe678191c2c	SE003	1	W	t	FM007	f	2022-08-09 15:20:33.81274	2022-08-09 15:20:33.81274
2093b6bf-7368-436f-813e-0089e231744b	SE003	1	Z	t	FM007	f	2022-08-09 15:20:33.818643	2022-08-09 15:20:33.818643
6d6ddb7c-4e72-444a-ba07-2e42ee7526d5	SE003	1	A	f	FM007	f	2022-08-09 15:20:33.824024	2022-08-09 15:20:33.824024
ae64e213-89a0-4c45-a27b-fd06969da78d	SE003	1	D	f	FM007	f	2022-08-09 15:20:33.829985	2022-08-09 15:20:33.829985
90c33a33-1636-4a2d-9841-f1349dc6800d	SE003	1	I	f	FM007	f	2022-08-09 15:20:33.836028	2022-08-09 15:20:33.836028
581a424c-463b-4274-aff8-5ac5cea91bb3	SE003	1	W	f	FM007	f	2022-08-09 15:20:33.842043	2022-08-09 15:20:33.842043
7a770f65-b2e8-4205-8970-100c4c5f8c31	SE003	1	Z	f	FM007	f	2022-08-09 15:20:33.847549	2022-08-09 15:20:33.847549
4981d366-2a8a-44c4-8248-d962d319d28a	SE003	1	A	t	FM015	f	2022-08-09 15:20:33.853371	2022-08-09 15:20:33.853371
5b14bb56-2f62-4870-9140-8f48fff3932c	SE003	1	D	t	FM015	f	2022-08-09 15:20:33.85891	2022-08-09 15:20:33.85891
8b37e54a-1f6d-4c5d-935f-d06267064318	SE003	1	I	t	FM015	f	2022-08-09 15:20:33.864308	2022-08-09 15:20:33.864308
c18a489b-28ae-42b5-9c77-362cf8b7bfb1	SE003	1	W	t	FM015	f	2022-08-09 15:20:33.870108	2022-08-09 15:20:33.870108
d4a863b8-8d7b-40ef-87a7-207efa083fc9	SE003	1	Z	t	FM015	f	2022-08-09 15:20:33.87548	2022-08-09 15:20:33.87548
3a94471f-2452-4425-a459-65a9b534aca2	SE003	1	A	f	FM015	f	2022-08-09 15:20:33.882022	2022-08-09 15:20:33.882022
5fb746b0-22ee-4c28-bdef-a84c1a922119	SE003	1	D	f	FM015	f	2022-08-09 15:20:33.888947	2022-08-09 15:20:33.888947
61d714f4-d624-49e7-bf19-ff33e576882b	SE003	1	I	f	FM015	f	2022-08-09 15:20:33.895037	2022-08-09 15:20:33.895037
abd93cba-9d44-498d-85c7-3800e5756449	SE003	1	W	f	FM015	f	2022-08-09 15:20:33.900822	2022-08-09 15:20:33.900822
d54f67f0-bf77-4f6c-846d-9b8972bcb1c3	SE003	1	Z	f	FM015	f	2022-08-09 15:20:33.906392	2022-08-09 15:20:33.906392
9c3cc718-4e0f-4963-a1ac-4e92f31f8de3	SE003	1	A	t	FM019	f	2022-08-09 15:20:33.91195	2022-08-09 15:20:33.91195
18c618ea-1422-46cb-9d5b-a4f16ee2b58f	SE003	1	D	t	FM019	f	2022-08-09 15:20:33.917528	2022-08-09 15:20:33.917528
bef7918c-8be6-42f1-880b-186d8228e893	SE003	1	I	t	FM019	f	2022-08-09 15:20:33.922948	2022-08-09 15:20:33.922948
1ed12d01-f275-4853-a5c1-4e7808038348	SE003	1	W	t	FM019	f	2022-08-09 15:20:33.928311	2022-08-09 15:20:33.928311
c7a6b715-3235-46ea-a8e8-460ef5f55a13	SE003	1	Z	t	FM019	f	2022-08-09 15:20:33.93408	2022-08-09 15:20:33.93408
dfe43178-1166-427d-b026-fdca2e8a7924	SE003	1	A	f	FM019	f	2022-08-09 15:20:33.939497	2022-08-09 15:20:33.939497
f4a473da-f2fb-4303-ac40-c11eec163a32	SE003	1	D	f	FM019	f	2022-08-09 15:20:33.946677	2022-08-09 15:20:33.946677
031889d0-87eb-45e9-ab17-3ae24a18d4bf	SE003	1	I	f	FM019	f	2022-08-09 15:20:33.952511	2022-08-09 15:20:33.952511
22329d83-ccfd-4a8b-b891-9f64a3c66d1f	SE003	1	W	f	FM019	f	2022-08-09 15:20:33.958202	2022-08-09 15:20:33.958202
49b08e0b-7d14-4c1b-9bb7-bc28468db754	SE003	1	Z	f	FM019	f	2022-08-09 15:20:33.963575	2022-08-09 15:20:33.963575
2b3f0c6f-1e69-4047-9401-116c8c79393a	SE003	1	A	f	FM059	t	2022-08-09 15:20:33.973154	2022-08-09 15:20:34.006227
fe35b484-f43a-45c5-b466-4929158ec1b7	SE003	1	D	f	FM059	t	2022-08-09 15:20:33.979593	2022-08-09 15:20:34.014111
bd8a4f7b-d160-4fbc-9965-80d09b2b1930	SE003	1	I	f	FM059	t	2022-08-09 15:20:33.985898	2022-08-09 15:20:34.021669
07c88d50-e6aa-42c3-af5f-4ff1f15026b1	SE003	1	W	f	FM059	t	2022-08-09 15:20:33.991211	2022-08-09 15:20:34.029441
6dad4f4f-bc7c-4546-b7a9-1a4f560e23f9	SE003	1	Z	f	FM059	t	2022-08-09 15:20:33.996898	2022-08-09 15:20:34.037267
9279ec48-70a7-4399-b924-f975e33e1e2a	SE003	1	A	t	CV117	t	2022-08-09 15:20:33.518985	2022-08-09 15:20:34.045081
966e9fa0-4a0f-464c-b599-5d7e14aac520	SE003	1	D	t	CV118	t	2022-08-09 15:20:33.603121	2022-08-09 15:20:34.052842
87052023-9b77-4e63-bbcb-9d199ea33d1b	SE003	1	I	t	CV118	t	2022-08-09 15:20:33.608983	2022-08-09 15:20:34.060499
84ddaf10-c07c-4dd2-a7f0-6111441bb572	SE003	1	W	t	CV118	t	2022-08-09 15:20:33.616103	2022-08-09 15:20:34.067969
8136ffdb-cdca-4408-b938-ceeedc8868fe	SE003	1	Z	t	CV118	t	2022-08-09 15:20:33.621665	2022-08-09 15:20:34.075837
1582cf3a-41df-4b0a-9f89-c8535f043884	SE004	1	A	t	CV027	f	2022-08-09 15:20:34.084933	2022-08-09 15:20:34.084933
b985152b-08f7-4674-b938-f92591e7a130	SE004	1	D	t	CV027	f	2022-08-09 15:20:34.091154	2022-08-09 15:20:34.091154
be1bb048-dc1d-4b7c-8977-f102efd550be	SE004	1	I	t	CV027	f	2022-08-09 15:20:34.097003	2022-08-09 15:20:34.097003
77a29f44-8867-4d02-8009-1f394a742c4a	SE004	1	W	t	CV027	f	2022-08-09 15:20:34.102834	2022-08-09 15:20:34.102834
d51bbd44-be43-4f4c-8992-e5f058b42411	SE004	1	Z	t	CV027	f	2022-08-09 15:20:34.108766	2022-08-09 15:20:34.108766
609cb02c-327b-4e1b-b946-e63ac67d5bcb	SE004	1	A	f	CV027	f	2022-08-09 15:20:34.114874	2022-08-09 15:20:34.114874
0f596527-5410-419a-9ba5-3d914eb9cf5f	SE004	1	D	f	CV027	f	2022-08-09 15:20:34.120702	2022-08-09 15:20:34.120702
e9261c84-73df-4369-9d70-4086cebebb09	SE004	1	I	f	CV027	f	2022-08-09 15:20:34.126406	2022-08-09 15:20:34.126406
279903ac-1254-4dbf-8ad6-c022c2e02ee7	SE004	1	W	f	CV027	f	2022-08-09 15:20:34.132526	2022-08-09 15:20:34.132526
21924fa4-c068-4702-97a5-9c87a28e13e5	SE004	1	Z	f	CV027	f	2022-08-09 15:20:34.138171	2022-08-09 15:20:34.138171
b54ed49c-eeac-4feb-bdd4-78f0de484ca0	SE004	1	A	t	CV079	f	2022-08-09 15:20:34.144087	2022-08-09 15:20:34.144087
d790d4df-8eab-4d90-992a-328cc70653e8	SE004	1	D	t	CV079	f	2022-08-09 15:20:34.151014	2022-08-09 15:20:34.151014
e3d0b591-da6c-4c52-b82d-879743db2880	SE004	1	I	t	CV079	f	2022-08-09 15:20:34.157885	2022-08-09 15:20:34.157885
3a8c7fcd-fece-41c1-83f4-7dd51458b21d	SE004	1	W	t	CV079	f	2022-08-09 15:20:34.164718	2022-08-09 15:20:34.164718
4de391c0-6127-4022-bebc-b86fd60ffe87	SE004	1	Z	t	CV079	f	2022-08-09 15:20:34.170507	2022-08-09 15:20:34.170507
b7a4dd58-ba23-4b23-b1c7-2a8b384c576f	SE004	1	A	f	CV079	f	2022-08-09 15:20:34.176168	2022-08-09 15:20:34.176168
e24481dc-0514-4390-b298-3c242efaff5f	SE004	1	D	f	CV079	f	2022-08-09 15:20:34.181536	2022-08-09 15:20:34.181536
0004c9a1-24ad-4430-9b52-9ad6955cab5c	SE004	1	I	f	CV079	f	2022-08-09 15:20:34.187125	2022-08-09 15:20:34.187125
a63a08f1-7ced-4a18-aee9-a861f1491e00	SE004	1	W	f	CV079	f	2022-08-09 15:20:34.19253	2022-08-09 15:20:34.19253
b616d730-4c67-44ae-9bfa-5e06208297e1	SE004	1	Z	f	CV079	f	2022-08-09 15:20:34.198375	2022-08-09 15:20:34.198375
6b3e4e3e-cfac-4e8b-ba6d-46a151380c3d	SE004	1	D	t	CV117	f	2022-08-09 15:20:34.209128	2022-08-09 15:20:34.209128
c23ba130-b21f-44f6-a1b0-27cd2074df84	SE004	1	I	t	CV117	f	2022-08-09 15:20:34.214744	2022-08-09 15:20:34.214744
415bd864-e571-48f5-908b-713a6a3567e3	SE004	1	W	t	CV117	f	2022-08-09 15:20:34.220323	2022-08-09 15:20:34.220323
34e3ff8a-998b-459a-a6a2-4125b01fdcf1	SE004	1	Z	t	CV117	f	2022-08-09 15:20:34.225933	2022-08-09 15:20:34.225933
e8f6a3b5-14ee-4041-a5e1-35ecc9492f42	SE004	1	A	f	CV117	f	2022-08-09 15:20:34.231842	2022-08-09 15:20:34.231842
b96a7581-002b-4ee9-bee7-b44d60be0a3d	SE004	1	D	f	CV117	f	2022-08-09 15:20:34.237485	2022-08-09 15:20:34.237485
cfc8d6c1-0cb4-491f-8c12-f72e56047d4c	SE004	1	I	f	CV117	f	2022-08-09 15:20:34.243306	2022-08-09 15:20:34.243306
d5ead555-6076-4575-8f64-23a45831768d	SE004	1	W	f	CV117	f	2022-08-09 15:20:34.248771	2022-08-09 15:20:34.248771
47b43c79-ddae-43db-99f3-121a1e5000c9	SE004	1	Z	f	CV117	f	2022-08-09 15:20:34.254356	2022-08-09 15:20:34.254356
981db5c9-162a-4eeb-994c-fd61cc5e161e	SE004	1	A	t	CV118	f	2022-08-09 15:20:34.260558	2022-08-09 15:20:34.260558
1961e75f-fa3a-4f3e-8aca-fcb89c887b8f	SE004	1	A	f	CV118	f	2022-08-09 15:20:34.287967	2022-08-09 15:20:34.287967
eb11a5d7-cecb-419e-b7c3-eebda4e84606	SE004	1	D	f	CV118	f	2022-08-09 15:20:34.293277	2022-08-09 15:20:34.293277
d2f192fe-0381-41fd-b170-b498fe82c17a	SE004	1	I	f	CV118	f	2022-08-09 15:20:34.298867	2022-08-09 15:20:34.298867
e2bd963f-8e69-4054-9a01-e4d0c6688e03	SE004	1	W	f	CV118	f	2022-08-09 15:20:34.304228	2022-08-09 15:20:34.304228
5e61e290-8f63-4010-82ff-84a00756db08	SE004	1	Z	f	CV118	f	2022-08-09 15:20:34.309415	2022-08-09 15:20:34.309415
3d6936af-f964-4691-82eb-be427926946d	SE004	1	A	t	FM004	f	2022-08-09 15:20:34.315083	2022-08-09 15:20:34.315083
6123c418-7123-403f-a6f9-84d5663337f7	SE004	1	D	t	FM004	f	2022-08-09 15:20:34.320634	2022-08-09 15:20:34.320634
d049fe2a-1456-499a-a838-4e0466cea152	SE004	1	I	t	FM004	f	2022-08-09 15:20:34.325784	2022-08-09 15:20:34.325784
068b933e-54cd-4882-9b39-fd5309fc2f2f	SE004	1	W	t	FM004	f	2022-08-09 15:20:34.331483	2022-08-09 15:20:34.331483
46bd8db4-e0e4-4823-80e0-b2bdef61c0ee	SE004	1	Z	t	FM004	f	2022-08-09 15:20:34.336813	2022-08-09 15:20:34.336813
d7f1ad64-e4e9-4c59-b7dd-f5eaa6437eeb	SE004	1	A	f	FM004	f	2022-08-09 15:20:34.342412	2022-08-09 15:20:34.342412
4bec4f38-99bb-4c5a-9ba0-81461d55547e	SE004	1	D	f	FM004	f	2022-08-09 15:20:34.349068	2022-08-09 15:20:34.349068
b369e0c0-aa79-4444-91c3-cb513e393815	SE004	1	I	f	FM004	f	2022-08-09 15:20:34.355332	2022-08-09 15:20:34.355332
29a7956c-01e1-4731-b512-0e139784d75d	SE004	1	W	f	FM004	f	2022-08-09 15:20:34.36204	2022-08-09 15:20:34.36204
acd2fed6-4916-43cd-8286-e94a797b188a	SE004	1	Z	f	FM004	f	2022-08-09 15:20:34.368193	2022-08-09 15:20:34.368193
0f349a49-caf6-44a5-b84b-9ad71fa26981	SE004	1	A	t	FM007	f	2022-08-09 15:20:34.373815	2022-08-09 15:20:34.373815
23efb570-93c0-4fbb-b48f-cde5536254b5	SE004	1	D	t	FM007	f	2022-08-09 15:20:34.380413	2022-08-09 15:20:34.380413
087cebc6-90c2-41fa-ae5f-d920b51cee25	SE004	1	I	t	FM007	f	2022-08-09 15:20:34.385936	2022-08-09 15:20:34.385936
b45763ed-a067-46df-95ab-d3593423f031	SE004	1	W	t	FM007	f	2022-08-09 15:20:34.391914	2022-08-09 15:20:34.391914
6eeeb991-a2a5-4bff-9ff5-602c95144b84	SE004	1	Z	t	FM007	f	2022-08-09 15:20:34.397692	2022-08-09 15:20:34.397692
11181d07-3df1-413c-8be6-3f5e85a72efb	SE004	1	A	f	FM007	f	2022-08-09 15:20:34.403368	2022-08-09 15:20:34.403368
0ffdeeec-73a0-4623-ae14-af6c82c6820f	SE004	1	D	f	FM007	f	2022-08-09 15:20:34.408707	2022-08-09 15:20:34.408707
515fc39d-8c34-4aa0-8ddb-6582060625be	SE004	1	I	f	FM007	f	2022-08-09 15:20:34.41406	2022-08-09 15:20:34.41406
f1d952cb-c81b-492d-bb19-5e7045457a9b	SE004	1	W	f	FM007	f	2022-08-09 15:20:34.423544	2022-08-09 15:20:34.423544
142d27d8-6bd6-4c0b-89a0-735d6cabd7b9	SE004	1	Z	f	FM007	f	2022-08-09 15:20:34.430233	2022-08-09 15:20:34.430233
4f4fb6fd-a77b-42c8-bce0-6655f3a65fe9	SE004	1	A	t	FM015	f	2022-08-09 15:20:34.436372	2022-08-09 15:20:34.436372
154aadd4-aaa2-4df4-881d-2a3fd43c2ae6	SE004	1	D	t	FM015	f	2022-08-09 15:20:34.442036	2022-08-09 15:20:34.442036
b6fa3ec3-db31-4393-871c-50e561ef0859	SE004	1	I	t	FM015	f	2022-08-09 15:20:34.447566	2022-08-09 15:20:34.447566
1a3ebe9d-888e-42d0-83e0-5bb38da4011c	SE004	1	W	t	FM015	f	2022-08-09 15:20:34.453399	2022-08-09 15:20:34.453399
4678155b-26bb-4824-8dd4-bbbe09c2ccb1	SE004	1	Z	t	FM015	f	2022-08-09 15:20:34.459007	2022-08-09 15:20:34.459007
6d9a7a2c-621b-4fa2-887f-e94bb796d8c6	SE004	1	A	f	FM015	f	2022-08-09 15:20:34.465035	2022-08-09 15:20:34.465035
bf2ed547-e7e0-46d5-8d9e-03681b1a076b	SE004	1	D	f	FM015	f	2022-08-09 15:20:34.470619	2022-08-09 15:20:34.470619
8581c97a-4d73-452c-beff-304c82a9e0c6	SE004	1	I	f	FM015	f	2022-08-09 15:20:34.476394	2022-08-09 15:20:34.476394
ac07ffd7-1d66-42e6-b667-67b604de9c15	SE004	1	W	f	FM015	f	2022-08-09 15:20:34.483139	2022-08-09 15:20:34.483139
0fc7b657-c884-494a-8176-045a8d66d8c2	SE004	1	Z	f	FM015	f	2022-08-09 15:20:34.489131	2022-08-09 15:20:34.489131
d0d695d5-a58a-4bec-9a3b-4f82db92ffa2	SE004	1	A	t	FM019	f	2022-08-09 15:20:34.494565	2022-08-09 15:20:34.494565
7a9f4e29-f26a-4969-892b-eded9366f9e4	SE004	1	D	t	FM019	f	2022-08-09 15:20:34.50026	2022-08-09 15:20:34.50026
824ef1e2-40a2-4074-bfa0-7d6a92eaa522	SE004	1	I	t	FM019	f	2022-08-09 15:20:34.505771	2022-08-09 15:20:34.505771
051916e5-8675-4ca7-a822-119a4323fb25	SE004	1	W	t	FM019	f	2022-08-09 15:20:34.511445	2022-08-09 15:20:34.511445
879f094c-b032-403a-b9e5-de620449fbaa	SE004	1	Z	t	FM019	f	2022-08-09 15:20:34.516839	2022-08-09 15:20:34.516839
d8f0ebaa-4036-430e-81ac-959c8ca88e1e	SE004	1	A	f	FM019	f	2022-08-09 15:20:34.522187	2022-08-09 15:20:34.522187
c7c9eb54-5f7a-4f47-8eaf-a7249f096d1c	SE004	1	D	f	FM019	f	2022-08-09 15:20:34.528189	2022-08-09 15:20:34.528189
a2cf0f69-7041-4ac7-aba5-8d832a2589c7	SE004	1	I	f	FM019	f	2022-08-09 15:20:34.53349	2022-08-09 15:20:34.53349
59117ac0-9853-4f7c-9cbd-68e4e2e6a334	SE004	1	W	f	FM019	f	2022-08-09 15:20:34.538763	2022-08-09 15:20:34.538763
bb2f7e74-fe31-40b7-ab9e-f06577590456	SE004	1	Z	f	FM019	f	2022-08-09 15:20:34.544453	2022-08-09 15:20:34.544453
e1268f78-8043-421a-b320-1d496b4d7d68	SE004	1	A	f	FM059	t	2022-08-09 15:20:34.553862	2022-08-09 15:20:34.584299
0d09efe4-8bfd-428a-9816-c9ea1d3cd44b	SE004	1	D	f	FM059	t	2022-08-09 15:20:34.559382	2022-08-09 15:20:34.591608
db2ccf47-3ca2-414f-8598-9ceb16024e3d	SE004	1	I	f	FM059	t	2022-08-09 15:20:34.5647	2022-08-09 15:20:34.599257
f7f103f8-6f2c-43e2-a7f0-1c8ee85ccc49	SE004	1	W	f	FM059	t	2022-08-09 15:20:34.57055	2022-08-09 15:20:34.6068
c4d6b7c6-cbb6-4ac0-aa5f-7dc828a8ff68	SE004	1	Z	f	FM059	t	2022-08-09 15:20:34.576424	2022-08-09 15:20:34.614429
923d2f4b-62ce-4a4b-a876-d4badf186eda	SE004	1	A	t	CV117	t	2022-08-09 15:20:34.203755	2022-08-09 15:20:34.621892
a4c05f8d-9998-41d1-98ca-ec864f42cb8f	SE004	1	D	t	CV118	t	2022-08-09 15:20:34.26592	2022-08-09 15:20:34.629582
703ac896-0356-4162-84a5-229727f4313a	SE004	1	I	t	CV118	t	2022-08-09 15:20:34.271461	2022-08-09 15:20:34.637408
2d15bee5-8271-4535-9ea7-ddba411bb95e	SE004	1	W	t	CV118	t	2022-08-09 15:20:34.27668	2022-08-09 15:20:34.645508
da738a8b-bf73-486c-b50b-6b6f76cb6480	SE004	1	Z	t	CV118	t	2022-08-09 15:20:34.282276	2022-08-09 15:20:34.652908
3fbb2a0d-5dc6-469a-b460-4ccd453ed22d	SE007	1	A	t	CV027	f	2022-08-09 15:20:34.658743	2022-08-09 15:20:34.658743
390ac049-6b0d-4751-8ea1-640699fc1ac2	SE007	1	D	t	CV027	f	2022-08-09 15:20:34.665287	2022-08-09 15:20:34.665287
d3269c74-911d-4441-a529-250fa6b7d10d	SE007	1	I	t	CV027	f	2022-08-09 15:20:34.670752	2022-08-09 15:20:34.670752
5e59760a-e6e6-4466-949d-c75175ec972a	SE007	1	W	t	CV027	f	2022-08-09 15:20:34.676268	2022-08-09 15:20:34.676268
400d4d33-27ef-4e10-b0ea-70c9ec5cc3f9	SE007	1	Z	t	CV027	f	2022-08-09 15:20:34.683006	2022-08-09 15:20:34.683006
46d3afdc-e142-4803-af0a-cca26320f0da	SE007	1	A	f	CV027	f	2022-08-09 15:20:34.689112	2022-08-09 15:20:34.689112
3d14b649-c180-44ef-a007-1531f43ad0ba	SE007	1	D	f	CV027	f	2022-08-09 15:20:34.694731	2022-08-09 15:20:34.694731
4d7fb23f-8fa9-4953-afef-75f0460b6625	SE007	1	I	f	CV027	f	2022-08-09 15:20:34.700099	2022-08-09 15:20:34.700099
64688f5d-6867-4fdc-af4a-c1ee3403fe55	SE007	1	W	f	CV027	f	2022-08-09 15:20:34.705766	2022-08-09 15:20:34.705766
94e42bf0-2dab-4cbe-a1d1-1ef90a5e628c	SE007	1	Z	f	CV027	f	2022-08-09 15:20:34.711195	2022-08-09 15:20:34.711195
224e39c3-fb2a-4288-b30c-f88fa3af757b	SE007	1	A	t	CV079	f	2022-08-09 15:20:34.717159	2022-08-09 15:20:34.717159
89be4167-a234-4d45-b2cf-33469f1ab4cb	SE007	1	D	t	CV079	f	2022-08-09 15:20:34.722497	2022-08-09 15:20:34.722497
3721ed39-0d5f-4b3e-9377-0e833a806ac1	SE007	1	I	t	CV079	f	2022-08-09 15:20:34.728279	2022-08-09 15:20:34.728279
51b5ee84-2cb1-4582-875e-2fb8d50aa9e6	SE007	1	W	t	CV079	f	2022-08-09 15:20:34.733734	2022-08-09 15:20:34.733734
c7d681ae-0c34-4670-bf45-66de89e410e3	SE007	1	Z	t	CV079	f	2022-08-09 15:20:34.739021	2022-08-09 15:20:34.739021
d78c8ac1-0eb7-4218-a52e-92b8fe685315	SE007	1	A	f	CV079	f	2022-08-09 15:20:34.744733	2022-08-09 15:20:34.744733
5654558d-24e6-4597-af16-84f82d9fa03c	SE007	1	D	f	CV079	f	2022-08-09 15:20:34.75035	2022-08-09 15:20:34.75035
a03ac60a-b9cb-4230-b97c-882e35239650	SE007	1	I	f	CV079	f	2022-08-09 15:20:34.757695	2022-08-09 15:20:34.757695
4f3dbfa5-3bc0-40c9-b471-db7ab09641ec	SE007	1	W	f	CV079	f	2022-08-09 15:20:34.763186	2022-08-09 15:20:34.763186
c64fc24a-13ea-44db-a2bf-2c38eb03254e	SE007	1	Z	f	CV079	f	2022-08-09 15:20:34.76893	2022-08-09 15:20:34.76893
06100f4a-645d-401f-9f1b-fe3605d89cb7	SE007	1	D	t	CV117	f	2022-08-09 15:20:34.780495	2022-08-09 15:20:34.780495
06245a68-a524-4f61-88d8-2c8e66ee42b0	SE007	1	I	t	CV117	f	2022-08-09 15:20:34.786784	2022-08-09 15:20:34.786784
9f1b757f-5017-4a9b-9aef-6145668a4fd4	SE007	1	W	t	CV117	f	2022-08-09 15:20:34.793597	2022-08-09 15:20:34.793597
9b3f9f83-4d15-49c6-ad07-7d04f5127c7a	SE007	1	Z	t	CV117	f	2022-08-09 15:20:34.800151	2022-08-09 15:20:34.800151
b525e564-51e7-4432-8222-d9d32f0d5cd7	SE007	1	A	f	CV117	f	2022-08-09 15:20:34.80563	2022-08-09 15:20:34.80563
1b94f29f-404f-4522-8330-e5765fbdf00f	SE007	1	D	f	CV117	f	2022-08-09 15:20:34.811246	2022-08-09 15:20:34.811246
c302e77e-66fa-47a0-8049-66165c487baf	SE007	1	I	f	CV117	f	2022-08-09 15:20:34.816899	2022-08-09 15:20:34.816899
320a0fd7-702a-4b33-8609-952aaad9820e	SE007	1	W	f	CV117	f	2022-08-09 15:20:34.82384	2022-08-09 15:20:34.82384
42b123b4-19fc-4a0b-bbe5-538e99d5e005	SE007	1	Z	f	CV117	f	2022-08-09 15:20:34.8305	2022-08-09 15:20:34.8305
667c5ac6-75e2-4c01-9416-c6dd0e01b05f	SE007	1	A	t	CV118	f	2022-08-09 15:20:34.837418	2022-08-09 15:20:34.837418
122e031a-68d4-4cd0-b00d-fc180d9b9032	SE007	1	A	f	CV118	f	2022-08-09 15:20:34.867194	2022-08-09 15:20:34.867194
bb8a862b-eef3-4e0a-886b-8bfd2bc35cf1	SE007	1	D	f	CV118	f	2022-08-09 15:20:34.872503	2022-08-09 15:20:34.872503
7e52ca17-480b-416b-a923-413549a26f0e	SE007	1	I	f	CV118	f	2022-08-09 15:20:34.877954	2022-08-09 15:20:34.877954
25e97941-bdfc-45de-bdbb-d7d67e26fe54	SE007	1	W	f	CV118	f	2022-08-09 15:20:34.884532	2022-08-09 15:20:34.884532
32b9a65f-983f-41f6-a308-5e489e49de28	SE007	1	Z	f	CV118	f	2022-08-09 15:20:34.89013	2022-08-09 15:20:34.89013
f70cfacf-1587-4e4a-bdab-3bc004d8e570	SE007	1	A	t	FM004	f	2022-08-09 15:20:34.895768	2022-08-09 15:20:34.895768
85d38bed-5b7f-4a81-a501-52e214c57046	SE007	1	D	t	FM004	f	2022-08-09 15:20:34.901609	2022-08-09 15:20:34.901609
fdc48af8-347e-4a48-ac75-514aac1da1e0	SE007	1	I	t	FM004	f	2022-08-09 15:20:34.90696	2022-08-09 15:20:34.90696
b7e8521f-a608-4e33-b9e3-34c5ba840324	SE007	1	W	t	FM004	f	2022-08-09 15:20:34.912623	2022-08-09 15:20:34.912623
e3bc31b2-1a31-461d-9efd-8b88b8507f68	SE007	1	Z	t	FM004	f	2022-08-09 15:20:34.918365	2022-08-09 15:20:34.918365
b810d13e-39bc-4ece-a660-b28cb5e8976e	SE007	1	A	f	FM004	f	2022-08-09 15:20:34.924054	2022-08-09 15:20:34.924054
daf286e7-6818-495e-a485-68f8b0dc5a03	SE007	1	D	f	FM004	f	2022-08-09 15:20:34.929679	2022-08-09 15:20:34.929679
456f578e-494d-4c39-8e99-6b21f623ce24	SE007	1	I	f	FM004	f	2022-08-09 15:20:34.935132	2022-08-09 15:20:34.935132
33f73ef4-1ae4-46d6-aa34-e3c9b4581a92	SE007	1	W	f	FM004	f	2022-08-09 15:20:34.940898	2022-08-09 15:20:34.940898
57d55996-5f0f-49db-8968-ab3f0caa3c76	SE007	1	Z	f	FM004	f	2022-08-09 15:20:34.946346	2022-08-09 15:20:34.946346
e03bb57b-de31-4926-9d25-a997de6cae62	SE007	1	A	t	FM007	f	2022-08-09 15:20:34.953157	2022-08-09 15:20:34.953157
573ac1ee-ba1c-4049-bc59-e135d819c8cf	SE007	1	D	t	FM007	f	2022-08-09 15:20:34.958904	2022-08-09 15:20:34.958904
a881d9cd-c104-4acc-983c-bd6d626ce2e1	SE007	1	I	t	FM007	f	2022-08-09 15:20:34.9645	2022-08-09 15:20:34.9645
8b6ba6c3-c567-4b33-8e5a-e2432417723a	SE007	1	W	t	FM007	f	2022-08-09 15:20:34.970523	2022-08-09 15:20:34.970523
4ec08fda-838f-4494-ad0e-18032968aed4	SE007	1	Z	t	FM007	f	2022-08-09 15:20:34.976091	2022-08-09 15:20:34.976091
bfa902f7-6e42-4503-81f0-1544717fcbcd	SE007	1	A	f	FM007	f	2022-08-09 15:20:34.981804	2022-08-09 15:20:34.981804
868dd525-674c-44e8-a8fb-47569442f6ff	SE007	1	D	f	FM007	f	2022-08-09 15:20:34.987942	2022-08-09 15:20:34.987942
46c9d020-ce3a-4c5f-8b66-d9f5e7f201da	SE007	1	I	f	FM007	f	2022-08-09 15:20:34.993705	2022-08-09 15:20:34.993705
8aedaaee-4b2c-401d-bfea-4b26099e75fb	SE007	1	W	f	FM007	f	2022-08-09 15:20:34.999254	2022-08-09 15:20:34.999254
d46dea05-3784-47ba-b214-c6aa7950ab06	SE007	1	Z	f	FM007	f	2022-08-09 15:20:35.004891	2022-08-09 15:20:35.004891
46bb028a-3872-44e4-b845-9bffbde485d1	SE007	1	A	t	FM015	f	2022-08-09 15:20:35.010378	2022-08-09 15:20:35.010378
958350c0-9544-4afc-bca1-fe9a0e8f5a50	SE007	1	D	t	FM015	f	2022-08-09 15:20:35.016051	2022-08-09 15:20:35.016051
280a7453-4d86-40ca-a499-02c77ac749b6	SE007	1	I	t	FM015	f	2022-08-09 15:20:35.021326	2022-08-09 15:20:35.021326
f42d7932-249b-45e8-8e7e-7566ca55dad0	SE007	1	W	t	FM015	f	2022-08-09 15:20:35.026568	2022-08-09 15:20:35.026568
174f712b-2c6a-44bc-9768-7fbf864b5519	SE007	1	Z	t	FM015	f	2022-08-09 15:20:35.032305	2022-08-09 15:20:35.032305
9792f617-db82-457c-9b0c-2d746dfec420	SE007	1	A	f	FM015	f	2022-08-09 15:20:35.037846	2022-08-09 15:20:35.037846
86be6348-3157-4b9b-b338-ca754e7c346f	SE007	1	D	f	FM015	f	2022-08-09 15:20:35.043196	2022-08-09 15:20:35.043196
7099c7bb-9d0b-47b3-a2e2-b4a788023ad2	SE007	1	I	f	FM015	f	2022-08-09 15:20:35.04873	2022-08-09 15:20:35.04873
a7b884dc-e0ce-46b4-8ad5-2e4bf5abc678	SE007	1	W	f	FM015	f	2022-08-09 15:20:35.054092	2022-08-09 15:20:35.054092
e0f926e2-966f-47a8-8045-af68b405dacf	SE007	1	Z	f	FM015	f	2022-08-09 15:20:35.059745	2022-08-09 15:20:35.059745
87c75511-0de9-4bd6-ba13-320eded319e5	SE007	1	A	t	FM019	f	2022-08-09 15:20:35.065148	2022-08-09 15:20:35.065148
ae313970-3857-493f-b1dd-404d6f2266d2	SE007	1	D	t	FM019	f	2022-08-09 15:20:35.070797	2022-08-09 15:20:35.070797
d639052d-cd5b-429b-a88b-1d7d48dcb93c	SE007	1	I	t	FM019	f	2022-08-09 15:20:35.076474	2022-08-09 15:20:35.076474
31bc9a33-8669-496d-87f5-ef7316a48b97	SE007	1	W	t	FM019	f	2022-08-09 15:20:35.08381	2022-08-09 15:20:35.08381
975b99ce-703d-456f-80af-adc39e7d0da4	SE007	1	Z	t	FM019	f	2022-08-09 15:20:35.090994	2022-08-09 15:20:35.090994
9a907f32-4537-4f67-ba49-5b328a9da335	SE007	1	A	f	FM019	f	2022-08-09 15:20:35.097282	2022-08-09 15:20:35.097282
8bdf9561-b8bc-43b6-bd62-1605bb9daa33	SE007	1	D	f	FM019	f	2022-08-09 15:20:35.102703	2022-08-09 15:20:35.102703
bd2b0f73-18ff-43f8-aee4-b64284c84efb	SE007	1	I	f	FM019	f	2022-08-09 15:20:35.109041	2022-08-09 15:20:35.109041
e3255ccc-4087-4044-8a64-bc450bf49ad9	SE007	1	W	f	FM019	f	2022-08-09 15:20:35.115929	2022-08-09 15:20:35.115929
009a3dbc-430f-4e2d-a57b-556fb54edfa0	SE007	1	Z	f	FM019	f	2022-08-09 15:20:35.12205	2022-08-09 15:20:35.12205
13f7aa4f-6703-4c04-84c0-2cc4f08354f5	SE007	1	A	f	FM059	t	2022-08-09 15:20:35.13241	2022-08-09 15:20:35.163465
f6dd786e-67c4-4fea-8941-0b31f56fa277	SE007	1	D	f	FM059	t	2022-08-09 15:20:35.138139	2022-08-09 15:20:35.171239
6ea41952-0cdf-4b93-ba0e-b25f3876efa2	SE007	1	I	f	FM059	t	2022-08-09 15:20:35.144164	2022-08-09 15:20:35.179023
434a4b38-8db6-4260-a961-2853fe4573f2	SE007	1	W	f	FM059	t	2022-08-09 15:20:35.149545	2022-08-09 15:20:35.186631
5e4c0171-2ce3-44b9-85c8-a2c2bc4482be	SE007	1	Z	f	FM059	t	2022-08-09 15:20:35.155824	2022-08-09 15:20:35.19449
19aa514d-4012-4cdb-968d-8bd6e37f0af1	SE007	1	A	t	CV117	t	2022-08-09 15:20:34.774466	2022-08-09 15:20:35.202373
3ef5a454-33a3-4c37-bc1b-0bc3db3b9e9c	SE007	1	D	t	CV118	t	2022-08-09 15:20:34.844236	2022-08-09 15:20:35.209918
927e0ac1-a83a-4aec-bcae-452fef3f7aea	SE007	1	I	t	CV118	t	2022-08-09 15:20:34.850528	2022-08-09 15:20:35.217547
35773fc0-b9f0-4750-9a8d-3d485981c4de	SE007	1	W	t	CV118	t	2022-08-09 15:20:34.855934	2022-08-09 15:20:35.225251
dc6e699e-b35a-4d39-9943-61c41f98ab36	SE007	1	Z	t	CV118	t	2022-08-09 15:20:34.861512	2022-08-09 15:20:35.232612
cbe62b41-1ea0-4283-9632-f35b0d661d12	SE008	1	A	t	CV027	f	2022-08-09 15:20:35.238272	2022-08-09 15:20:35.238272
397ea642-69e0-40e4-8ffe-9190a0ad7eba	SE008	1	D	t	CV027	f	2022-08-09 15:20:35.243542	2022-08-09 15:20:35.243542
0a5f4d73-1c31-4349-9415-d5f75d5c645f	SE008	1	I	t	CV027	f	2022-08-09 15:20:35.249146	2022-08-09 15:20:35.249146
0a7067b9-53e2-48ca-8a7f-c7ec92433b03	SE008	1	W	t	CV027	f	2022-08-09 15:20:35.254436	2022-08-09 15:20:35.254436
f763c27e-9cb3-4eaa-968a-520215d3ef03	SE008	1	Z	t	CV027	f	2022-08-09 15:20:35.260131	2022-08-09 15:20:35.260131
4bbb5e52-d17a-4c31-90f7-089d93c93b57	SE008	1	A	f	CV027	f	2022-08-09 15:20:35.265577	2022-08-09 15:20:35.265577
d6a198fc-f31b-493a-b8fd-58b2b9f60c02	SE008	1	D	f	CV027	f	2022-08-09 15:20:35.270834	2022-08-09 15:20:35.270834
0b78eadc-18ff-4979-9402-d1f6e4ece8c2	SE008	1	I	f	CV027	f	2022-08-09 15:20:35.276486	2022-08-09 15:20:35.276486
045a3626-d089-43c4-a66b-97889d1b52a2	SE008	1	W	f	CV027	f	2022-08-09 15:20:35.282693	2022-08-09 15:20:35.282693
f76c45de-00e5-49cd-a956-c9b9119dd85b	SE008	1	Z	f	CV027	f	2022-08-09 15:20:35.288492	2022-08-09 15:20:35.288492
2f8814b6-0ecf-4cd8-a5f6-d3b3c59e823c	SE008	1	A	t	CV079	f	2022-08-09 15:20:35.29392	2022-08-09 15:20:35.29392
5cd1174c-ccac-4d24-8c27-978e2f04e842	SE008	1	D	t	CV079	f	2022-08-09 15:20:35.299228	2022-08-09 15:20:35.299228
93961c1a-c16b-4f72-8473-2cdcc25a85a6	SE008	1	I	t	CV079	f	2022-08-09 15:20:35.304776	2022-08-09 15:20:35.304776
7de56636-0fc5-4445-a98c-871c9f848a7f	SE008	1	W	t	CV079	f	2022-08-09 15:20:35.310308	2022-08-09 15:20:35.310308
a36308dd-489a-4f79-a9fa-aed4d54e4f8b	SE008	1	Z	t	CV079	f	2022-08-09 15:20:35.315751	2022-08-09 15:20:35.315751
c0a499f4-cc49-4b63-afff-3e254eed000e	SE008	1	A	f	CV079	f	2022-08-09 15:20:35.322695	2022-08-09 15:20:35.322695
ee8c5283-5e92-4f53-8c9e-a26f41bec5ba	SE008	1	D	f	CV079	f	2022-08-09 15:20:35.329331	2022-08-09 15:20:35.329331
289500bf-e011-4a24-9397-063d9b51e9f3	SE008	1	I	f	CV079	f	2022-08-09 15:20:35.335856	2022-08-09 15:20:35.335856
6ffa0e78-101b-4c01-a92f-fe4b6842145d	SE008	1	W	f	CV079	f	2022-08-09 15:20:35.341957	2022-08-09 15:20:35.341957
b203e156-961c-42aa-83ab-9c383e0400bb	SE008	1	Z	f	CV079	f	2022-08-09 15:20:35.347778	2022-08-09 15:20:35.347778
54639aa7-17a2-4a77-9d76-c13a276335f6	SE008	1	D	t	CV117	f	2022-08-09 15:20:35.360938	2022-08-09 15:20:35.360938
b1c2d6fb-6b9f-44ff-bdac-ad421d262f0b	SE008	1	I	t	CV117	f	2022-08-09 15:20:35.367297	2022-08-09 15:20:35.367297
54e7bf67-49f2-46b5-8211-5b02bdfcade7	SE008	1	W	t	CV117	f	2022-08-09 15:20:35.373379	2022-08-09 15:20:35.373379
05705513-49c4-4451-87b6-20c03f03d115	SE008	1	Z	t	CV117	f	2022-08-09 15:20:35.37967	2022-08-09 15:20:35.37967
97f2ce93-8eca-4fd5-a73d-5e896e78b28d	SE008	1	A	f	CV117	f	2022-08-09 15:20:35.38559	2022-08-09 15:20:35.38559
0fbe2dd0-c420-4e92-b280-df218b1d4b07	SE008	1	D	f	CV117	f	2022-08-09 15:20:35.39157	2022-08-09 15:20:35.39157
c120bba6-81f7-4223-95a7-7682db637fd3	SE008	1	I	f	CV117	f	2022-08-09 15:20:35.39798	2022-08-09 15:20:35.39798
ee9bb273-dc11-415e-a2d2-bd21d2d88a71	SE008	1	W	f	CV117	f	2022-08-09 15:20:35.403831	2022-08-09 15:20:35.403831
c55dd91d-1b44-4467-b87b-c6aa1ca13873	SE008	1	Z	f	CV117	f	2022-08-09 15:20:35.4092	2022-08-09 15:20:35.4092
b6c3cadf-cbb1-4d3b-aa2d-08cd00094509	SE008	1	A	t	CV118	f	2022-08-09 15:20:35.415316	2022-08-09 15:20:35.415316
4854ee74-adac-4138-a539-c335ab97de8d	SE008	1	A	f	CV118	f	2022-08-09 15:20:35.445288	2022-08-09 15:20:35.445288
97be7cdb-d876-4347-9545-50ab6c5f4397	SE008	1	D	f	CV118	f	2022-08-09 15:20:35.450679	2022-08-09 15:20:35.450679
e43f5983-35aa-4565-b778-29b07a17c003	SE008	1	I	f	CV118	f	2022-08-09 15:20:35.456745	2022-08-09 15:20:35.456745
39b34cca-c04d-472d-a359-6ebecf660358	SE008	1	W	f	CV118	f	2022-08-09 15:20:35.463277	2022-08-09 15:20:35.463277
57eda11b-8b1a-40c3-b291-5107b8581207	SE008	1	Z	f	CV118	f	2022-08-09 15:20:35.468964	2022-08-09 15:20:35.468964
03a6ea94-0df8-4afc-ba65-29452e15cdd2	SE008	1	A	t	FM004	f	2022-08-09 15:20:35.474852	2022-08-09 15:20:35.474852
89e98edf-be6c-4a89-b071-fbdae1cf8343	SE008	1	D	t	FM004	f	2022-08-09 15:20:35.480532	2022-08-09 15:20:35.480532
6f2580d3-0f92-4e3f-9ee3-72e68ad75d81	SE008	1	I	t	FM004	f	2022-08-09 15:20:35.486404	2022-08-09 15:20:35.486404
3e2d1be0-d25b-4050-9950-f57b62ac3bec	SE008	1	W	t	FM004	f	2022-08-09 15:20:35.49187	2022-08-09 15:20:35.49187
a98fedaa-c92d-4eb0-ba97-9e552321dc34	SE008	1	Z	t	FM004	f	2022-08-09 15:20:35.497895	2022-08-09 15:20:35.497895
bc4426ff-b56d-424c-a292-76a81a21c7c1	SE008	1	A	f	FM004	f	2022-08-09 15:20:35.503432	2022-08-09 15:20:35.503432
b23bf007-a96d-40d5-9edd-7ed3fe301d51	SE008	1	D	f	FM004	f	2022-08-09 15:20:35.509168	2022-08-09 15:20:35.509168
bf69e42d-40c2-48de-b0b4-3bb322716fc5	SE008	1	I	f	FM004	f	2022-08-09 15:20:35.514545	2022-08-09 15:20:35.514545
d800cd5b-ce76-4136-934c-e572651e8ffb	SE008	1	W	f	FM004	f	2022-08-09 15:20:35.520312	2022-08-09 15:20:35.520312
b091b739-bc9d-4cf7-bbf6-1c780560b408	SE008	1	Z	f	FM004	f	2022-08-09 15:20:35.525913	2022-08-09 15:20:35.525913
ecab675b-7526-4bd3-a00a-6467e3a432be	SE008	1	A	t	FM007	f	2022-08-09 15:20:35.531409	2022-08-09 15:20:35.531409
b95c96ef-6aa1-4577-9ea9-0974e597b53c	SE008	1	D	t	FM007	f	2022-08-09 15:20:35.537286	2022-08-09 15:20:35.537286
e5e85638-4afe-4e7c-a534-8c9849545988	SE008	1	I	t	FM007	f	2022-08-09 15:20:35.542537	2022-08-09 15:20:35.542537
b153d8e3-307b-4c5b-9810-f5b5fb00f148	SE008	1	W	t	FM007	f	2022-08-09 15:20:35.548407	2022-08-09 15:20:35.548407
2daf7726-15b1-485f-9d79-c727a32ab16c	SE008	1	Z	t	FM007	f	2022-08-09 15:20:35.554011	2022-08-09 15:20:35.554011
02435ccf-aea0-4f56-a4da-c1addcd90ce1	SE008	1	A	f	FM007	f	2022-08-09 15:20:35.559431	2022-08-09 15:20:35.559431
1aca6fd7-6f34-4766-9d83-4d747c94beb9	SE008	1	D	f	FM007	f	2022-08-09 15:20:35.565121	2022-08-09 15:20:35.565121
45f1c4e5-5998-4058-a4d9-15570f65ac02	SE008	1	I	f	FM007	f	2022-08-09 15:20:35.570459	2022-08-09 15:20:35.570459
88a4f1ff-c08f-44c3-b73a-dbf6819362b6	SE008	1	W	f	FM007	f	2022-08-09 15:20:35.575911	2022-08-09 15:20:35.575911
799eccbf-553b-4e8c-93bb-a6009188ff46	SE008	1	Z	f	FM007	f	2022-08-09 15:20:35.581921	2022-08-09 15:20:35.581921
38bc1a8c-5418-43ab-9ecf-cca760290c89	SE008	1	A	t	FM015	f	2022-08-09 15:20:35.588734	2022-08-09 15:20:35.588734
7b673da0-d6f1-4f15-99b0-558f49d80503	SE008	1	D	t	FM015	f	2022-08-09 15:20:35.594794	2022-08-09 15:20:35.594794
90218bbb-723e-4bff-abfb-3f0159390aab	SE008	1	I	t	FM015	f	2022-08-09 15:20:35.600436	2022-08-09 15:20:35.600436
6359f9ce-6d55-45a6-b938-1dda646bd1a4	SE008	1	W	t	FM015	f	2022-08-09 15:20:35.605972	2022-08-09 15:20:35.605972
d21fafee-0cd2-4516-b003-67205a5f1fd1	SE008	1	Z	t	FM015	f	2022-08-09 15:20:35.612793	2022-08-09 15:20:35.612793
e2f2b605-1fcb-41ae-a4fa-5fdb5f5de274	SE008	1	A	f	FM015	f	2022-08-09 15:20:35.618662	2022-08-09 15:20:35.618662
0c3d6950-be70-4cb8-80d9-e90aef93acb7	SE008	1	D	f	FM015	f	2022-08-09 15:20:35.624321	2022-08-09 15:20:35.624321
2c4b6340-35b5-4187-8dea-f97827946fb1	SE008	1	I	f	FM015	f	2022-08-09 15:20:35.629889	2022-08-09 15:20:35.629889
f5af5846-149b-4ac8-af00-7b50cd745609	SE008	1	W	f	FM015	f	2022-08-09 15:20:35.635253	2022-08-09 15:20:35.635253
2a73d0b8-8b13-443f-9508-0795bf10ba4b	SE008	1	Z	f	FM015	f	2022-08-09 15:20:35.640934	2022-08-09 15:20:35.640934
eb2557aa-2b2f-4dfb-9c2a-80cdb2e57f7e	SE008	1	A	t	FM019	f	2022-08-09 15:20:35.646409	2022-08-09 15:20:35.646409
84e8ed1b-c834-44f0-af38-76db05ea3387	SE008	1	D	t	FM019	f	2022-08-09 15:20:35.652134	2022-08-09 15:20:35.652134
ef0cf7e6-8fa2-4105-be27-cb86848d1f7c	SE008	1	I	t	FM019	f	2022-08-09 15:20:35.657759	2022-08-09 15:20:35.657759
1dd6a480-e07b-4bc4-89f1-abe156403d04	SE008	1	W	t	FM019	f	2022-08-09 15:20:35.663545	2022-08-09 15:20:35.663545
b52e0954-fcf9-4e67-af70-9f1558f785e4	SE008	1	Z	t	FM019	f	2022-08-09 15:20:35.669608	2022-08-09 15:20:35.669608
7f482cee-fd8c-4fd0-9153-50c0a6edf720	SE008	1	A	f	FM019	f	2022-08-09 15:20:35.675055	2022-08-09 15:20:35.675055
647ac21e-0faa-441e-9c9f-d78167010c5c	SE008	1	D	f	FM019	f	2022-08-09 15:20:35.680765	2022-08-09 15:20:35.680765
c9b4babf-b090-4f81-8b52-ca7847ae29ca	SE008	1	I	f	FM019	f	2022-08-09 15:20:35.686994	2022-08-09 15:20:35.686994
abbb7aff-4a8f-4f54-b7c4-597b542286ee	SE008	1	W	f	FM019	f	2022-08-09 15:20:35.692676	2022-08-09 15:20:35.692676
9126478a-3fc6-42bb-b6f1-5e3995fc0b86	SE008	1	Z	f	FM019	f	2022-08-09 15:20:35.698081	2022-08-09 15:20:35.698081
1b35172c-5c59-4571-809c-e7f6265231f7	SE008	1	A	f	FM059	t	2022-08-09 15:20:35.707932	2022-08-09 15:20:35.739024
d60c2e4f-6a50-4d13-a08d-e14b9b17a0d7	SE008	1	D	f	FM059	t	2022-08-09 15:20:35.713427	2022-08-09 15:20:35.746659
78180f2b-c77f-4537-8988-819abb3c941e	SE008	1	I	f	FM059	t	2022-08-09 15:20:35.719527	2022-08-09 15:20:35.753952
9eed5f3c-a7eb-465b-9cf8-94337f1f9bee	SE008	1	W	f	FM059	t	2022-08-09 15:20:35.725506	2022-08-09 15:20:35.761699
3844fa7a-aca5-430c-9053-e047993d1f97	SE008	1	Z	f	FM059	t	2022-08-09 15:20:35.731493	2022-08-09 15:20:35.771412
c7d89536-1242-473e-9767-d0e8236e3867	SE008	1	A	t	CV117	t	2022-08-09 15:20:35.354213	2022-08-09 15:20:35.779873
28519d3c-fe8c-411b-99c1-ad67864cf04b	SE008	1	D	t	CV118	t	2022-08-09 15:20:35.420891	2022-08-09 15:20:35.787766
020be9ec-cdb0-4bd1-b664-5caec256185c	SE008	1	I	t	CV118	t	2022-08-09 15:20:35.426687	2022-08-09 15:20:35.795625
5a8510be-ed84-4ddd-badf-f70e78f12c49	SE008	1	W	t	CV118	t	2022-08-09 15:20:35.433634	2022-08-09 15:20:35.803216
ede37cc8-68e9-4abb-bd57-ce1e5117239f	SE008	1	Z	t	CV118	t	2022-08-09 15:20:35.43923	2022-08-09 15:20:35.810696
10140d3c-9a98-4a65-b29c-6656f2fb71d1	SE013	1	A	t	CV027	f	2022-08-09 15:20:35.816278	2022-08-09 15:20:35.816278
be1ff23f-5974-4b48-8887-de69230e9f3e	SE013	1	D	t	CV027	f	2022-08-09 15:20:35.8222	2022-08-09 15:20:35.8222
eab24d85-419b-4fa7-afe1-2a5a9e2c7043	SE013	1	I	t	CV027	f	2022-08-09 15:20:35.827767	2022-08-09 15:20:35.827767
87ab72c2-fef7-4001-8ba0-af2cf19354e4	SE013	1	W	t	CV027	f	2022-08-09 15:20:35.833429	2022-08-09 15:20:35.833429
a4bd460d-c957-4d40-9163-86ee23d9b102	SE013	1	Z	t	CV027	f	2022-08-09 15:20:35.838901	2022-08-09 15:20:35.838901
3027b234-7f73-41af-a7fc-15a2b7df4621	SE013	1	A	f	CV027	f	2022-08-09 15:20:35.844346	2022-08-09 15:20:35.844346
8a4012e2-6515-41aa-8de3-c01caf8d52a0	SE013	1	D	f	CV027	f	2022-08-09 15:20:35.850742	2022-08-09 15:20:35.850742
d1d0566b-8731-4f65-b3a3-749c87a7f30a	SE013	1	I	f	CV027	f	2022-08-09 15:20:35.856287	2022-08-09 15:20:35.856287
03e8ff02-8770-4a9f-be56-082355aadea3	SE013	1	W	f	CV027	f	2022-08-09 15:20:35.861967	2022-08-09 15:20:35.861967
d159e413-0d99-459d-b6f0-972c46efeb2a	SE013	1	Z	f	CV027	f	2022-08-09 15:20:35.867481	2022-08-09 15:20:35.867481
07e63a78-c6e2-455f-ab92-4094323adf87	SE013	1	A	t	CV079	f	2022-08-09 15:20:35.874415	2022-08-09 15:20:35.874415
7fe40f03-3da6-402b-87f6-0f626a7a9846	SE013	1	D	t	CV079	f	2022-08-09 15:20:35.881345	2022-08-09 15:20:35.881345
96fffbe3-53aa-4f65-80fe-fc6e4b614d25	SE013	1	I	t	CV079	f	2022-08-09 15:20:35.887768	2022-08-09 15:20:35.887768
b30df49b-fc18-4987-baa9-2c1f7699daba	SE013	1	W	t	CV079	f	2022-08-09 15:20:35.895049	2022-08-09 15:20:35.895049
38548e78-ad9d-48c9-84cc-5cab2f1b60e6	SE013	1	Z	t	CV079	f	2022-08-09 15:20:35.900662	2022-08-09 15:20:35.900662
6894a168-63c7-41a7-8e69-115fb3763e17	SE013	1	A	f	CV079	f	2022-08-09 15:20:35.905913	2022-08-09 15:20:35.905913
58fbf7c1-2f97-49d8-bcec-fc5d1b3245ee	SE013	1	D	f	CV079	f	2022-08-09 15:20:35.911616	2022-08-09 15:20:35.911616
dfb5ce43-5bce-4d39-8840-c179674f910b	SE013	1	I	f	CV079	f	2022-08-09 15:20:35.917304	2022-08-09 15:20:35.917304
97457266-1c19-4b0b-b986-19dd6e66a96f	SE013	1	W	f	CV079	f	2022-08-09 15:20:35.923475	2022-08-09 15:20:35.923475
dd7c6358-4466-4442-901e-366119d9b217	SE013	1	Z	f	CV079	f	2022-08-09 15:20:35.928845	2022-08-09 15:20:35.928845
9f2b52f7-f15c-45b3-87da-067e0962ca08	SE013	1	D	t	CV117	f	2022-08-09 15:20:35.940166	2022-08-09 15:20:35.940166
57bce72b-39fc-4f46-aa3f-440aa9122045	SE013	1	I	t	CV117	f	2022-08-09 15:20:35.946066	2022-08-09 15:20:35.946066
f734bab4-d6f1-403c-8beb-9db3348077cb	SE013	1	W	t	CV117	f	2022-08-09 15:20:35.951868	2022-08-09 15:20:35.951868
ef4f181c-c62e-4bb7-8efe-52c6784fd767	SE013	1	Z	t	CV117	f	2022-08-09 15:20:35.957285	2022-08-09 15:20:35.957285
8897bd6e-c47f-42f7-ab55-420969fca1c3	SE013	1	A	f	CV117	f	2022-08-09 15:20:35.962669	2022-08-09 15:20:35.962669
7396151a-4966-4d24-b1aa-587cd258ed71	SE013	1	D	f	CV117	f	2022-08-09 15:20:35.9684	2022-08-09 15:20:35.9684
571a3ca0-e5bf-4c04-8da6-de68fc622c67	SE013	1	I	f	CV117	f	2022-08-09 15:20:35.974321	2022-08-09 15:20:35.974321
7e6edd17-a5fd-498c-afa4-503d00039e43	SE013	1	W	f	CV117	f	2022-08-09 15:20:35.98044	2022-08-09 15:20:35.98044
29ab08df-331c-4a69-9903-60c20164fdf4	SE013	1	Z	f	CV117	f	2022-08-09 15:20:35.98577	2022-08-09 15:20:35.98577
ed58e0ba-31b2-4210-887c-bde9c4bd9131	SE013	1	A	t	CV118	f	2022-08-09 15:20:35.991345	2022-08-09 15:20:35.991345
83d8928d-6d62-4c89-b701-319ed8490d85	SE013	1	A	f	CV118	f	2022-08-09 15:20:36.022038	2022-08-09 15:20:36.022038
d3a7855e-1b86-4bb6-8200-7dc0367be4ac	SE013	1	D	f	CV118	f	2022-08-09 15:20:36.028377	2022-08-09 15:20:36.028377
94bbc7b1-12d0-409d-9750-d3cd7ef49a8f	SE013	1	I	f	CV118	f	2022-08-09 15:20:36.034268	2022-08-09 15:20:36.034268
71236831-237f-474b-be72-18cc6fe77cae	SE013	1	W	f	CV118	f	2022-08-09 15:20:36.0402	2022-08-09 15:20:36.0402
1e5871e6-b22c-4aa4-91c8-e14259efad35	SE013	1	Z	f	CV118	f	2022-08-09 15:20:36.046616	2022-08-09 15:20:36.046616
17efc0a9-4fbf-43c3-a817-7d1e3b24008c	SE013	1	A	t	FM004	f	2022-08-09 15:20:36.052138	2022-08-09 15:20:36.052138
80e0e740-8a43-4712-9265-3313ef12eec0	SE013	1	D	t	FM004	f	2022-08-09 15:20:36.057261	2022-08-09 15:20:36.057261
bf21e31b-ad4d-4344-8abb-f32a568763d6	SE013	1	I	t	FM004	f	2022-08-09 15:20:36.062909	2022-08-09 15:20:36.062909
f8f605dc-4a9e-48be-83e1-c8e10abd2656	SE013	1	W	t	FM004	f	2022-08-09 15:20:36.068688	2022-08-09 15:20:36.068688
7c118057-c55b-4d41-aa10-b08db60126c3	SE013	1	Z	t	FM004	f	2022-08-09 15:20:36.07514	2022-08-09 15:20:36.07514
c81fa779-91a5-4587-be51-5ac517ad7d8d	SE013	1	A	f	FM004	f	2022-08-09 15:20:36.081906	2022-08-09 15:20:36.081906
6cbeddbb-d577-4f53-a284-06b595fa9922	SE013	1	D	f	FM004	f	2022-08-09 15:20:36.088158	2022-08-09 15:20:36.088158
aed1596f-1422-43d6-b56a-a2495032270f	SE013	1	I	f	FM004	f	2022-08-09 15:20:36.094565	2022-08-09 15:20:36.094565
90cf4d98-7ed8-4798-8baf-54689250b7e2	SE013	1	W	f	FM004	f	2022-08-09 15:20:36.101868	2022-08-09 15:20:36.101868
e52e3b92-eebe-462e-8437-618e3abeb52d	SE013	1	Z	f	FM004	f	2022-08-09 15:20:36.10877	2022-08-09 15:20:36.10877
68803494-36bc-4e09-918f-2e78a3446ddc	SE013	1	A	t	FM007	f	2022-08-09 15:20:36.115665	2022-08-09 15:20:36.115665
d92043bb-cd0f-4b16-9958-d35c437752ae	SE013	1	D	t	FM007	f	2022-08-09 15:20:36.122377	2022-08-09 15:20:36.122377
34f1c89c-19c6-4739-ba1c-5f20e6297a8e	SE013	1	I	t	FM007	f	2022-08-09 15:20:36.1283	2022-08-09 15:20:36.1283
e497c6e2-c336-4c8d-b1b5-d6fdde07c79c	SE013	1	W	t	FM007	f	2022-08-09 15:20:36.13426	2022-08-09 15:20:36.13426
ab77f0ca-0596-431a-891a-0bc825dae023	SE013	1	Z	t	FM007	f	2022-08-09 15:20:36.140893	2022-08-09 15:20:36.140893
70ea59ab-fd08-446f-a75d-4389d0f25541	SE013	1	A	f	FM007	f	2022-08-09 15:20:36.148023	2022-08-09 15:20:36.148023
0b8b7138-ee98-41e7-a9e2-524f1c7b876f	SE013	1	D	f	FM007	f	2022-08-09 15:20:36.154731	2022-08-09 15:20:36.154731
f1ba934f-1ebb-427e-afd8-1ad0362a717e	SE013	1	I	f	FM007	f	2022-08-09 15:20:36.160001	2022-08-09 15:20:36.160001
d7d0b2ef-7898-48fb-b82f-a186cca03ad0	SE013	1	W	f	FM007	f	2022-08-09 15:20:36.167201	2022-08-09 15:20:36.167201
643ac8c1-903b-4e94-accd-aa61f0b8db08	SE013	1	Z	f	FM007	f	2022-08-09 15:20:36.173648	2022-08-09 15:20:36.173648
ec1c3f56-1444-47e1-a9c2-afaebb3a60d9	SE013	1	A	t	FM015	f	2022-08-09 15:20:36.179748	2022-08-09 15:20:36.179748
592927c6-da95-4b97-ac8b-2555bba797ff	SE013	1	D	t	FM015	f	2022-08-09 15:20:36.184911	2022-08-09 15:20:36.184911
a1d92824-2f7c-4f27-a9df-fd687bdcb868	SE013	1	I	t	FM015	f	2022-08-09 15:20:36.190991	2022-08-09 15:20:36.190991
1768f149-f433-4a54-ba4f-4d96447fda3c	SE013	1	W	t	FM015	f	2022-08-09 15:20:36.197025	2022-08-09 15:20:36.197025
14c25d26-31d0-4d9c-a8e7-5369de4bf7f0	SE013	1	Z	t	FM015	f	2022-08-09 15:20:36.203643	2022-08-09 15:20:36.203643
55345fdc-abc0-405c-8e8a-d150f78a2fa3	SE013	1	A	f	FM015	f	2022-08-09 15:20:36.209485	2022-08-09 15:20:36.209485
130af805-4ee6-42b2-9870-40d023882509	SE013	1	D	f	FM015	f	2022-08-09 15:20:36.215665	2022-08-09 15:20:36.215665
6d63608b-4575-42cc-b2ba-c71f38378693	SE013	1	I	f	FM015	f	2022-08-09 15:20:36.221854	2022-08-09 15:20:36.221854
51c799ed-a833-4c31-ade6-2b95862c3db8	SE013	1	W	f	FM015	f	2022-08-09 15:20:36.227805	2022-08-09 15:20:36.227805
88154633-c51b-440d-815d-9228e93a4869	SE013	1	Z	f	FM015	f	2022-08-09 15:20:36.234086	2022-08-09 15:20:36.234086
9e794c8e-c160-4212-8f3d-f4204a049c51	SE013	1	A	t	FM019	f	2022-08-09 15:20:36.23984	2022-08-09 15:20:36.23984
e247ffbb-f80d-43ae-9bc8-373e7a02f9f8	SE013	1	D	t	FM019	f	2022-08-09 15:20:36.245713	2022-08-09 15:20:36.245713
fdb9658e-e879-4686-89c3-2e38f470e985	SE013	1	I	t	FM019	f	2022-08-09 15:20:36.252246	2022-08-09 15:20:36.252246
83f1957d-ee4f-473e-99e5-63d0a829bf0b	SE013	1	W	t	FM019	f	2022-08-09 15:20:36.258017	2022-08-09 15:20:36.258017
832c80ae-1463-4e5d-bc4d-a24bcee90ef9	SE013	1	Z	t	FM019	f	2022-08-09 15:20:36.264063	2022-08-09 15:20:36.264063
2ecaee94-8aeb-46c4-b578-fabc3a9a33ee	SE013	1	A	f	FM019	f	2022-08-09 15:20:36.270695	2022-08-09 15:20:36.270695
10af1dee-4543-443f-b7a3-3230fe98719c	SE013	1	D	f	FM019	f	2022-08-09 15:20:36.276486	2022-08-09 15:20:36.276486
a8358532-b111-47dc-8bae-c8a3ece5aaac	SE013	1	I	f	FM019	f	2022-08-09 15:20:36.282497	2022-08-09 15:20:36.282497
44ef2e03-7e3b-4ee0-82dc-e965995685f2	SE013	1	W	f	FM019	f	2022-08-09 15:20:36.287676	2022-08-09 15:20:36.287676
77b8cd64-2fd8-4c9e-88cb-0c687e7bbe98	SE013	1	Z	f	FM019	f	2022-08-09 15:20:36.293772	2022-08-09 15:20:36.293772
386be992-8288-4dde-93a9-6d628972cc8d	SE013	1	A	f	FM059	t	2022-08-09 15:20:36.303374	2022-08-09 15:20:36.334201
9d0475d1-e7c0-40aa-9d0f-56559958fea3	SE013	1	D	f	FM059	t	2022-08-09 15:20:36.309465	2022-08-09 15:20:36.342892
15dc7b88-289e-4afc-80bc-14c8c5192306	SE013	1	I	f	FM059	t	2022-08-09 15:20:36.315571	2022-08-09 15:20:36.352213
7fae06e8-390c-43f0-a039-e2dc51dd9e56	SE013	1	W	f	FM059	t	2022-08-09 15:20:36.320676	2022-08-09 15:20:36.359501
fb82231e-bb6e-41cf-b326-715e38ced00f	SE013	1	Z	f	FM059	t	2022-08-09 15:20:36.326217	2022-08-09 15:20:36.368774
d86e6e6a-b155-4086-b114-b0d869f65edd	SE013	1	A	t	CV117	t	2022-08-09 15:20:35.934467	2022-08-09 15:20:36.378
0946e3bc-09f2-4b15-9012-06b605ef5ef8	SE013	1	D	t	CV118	t	2022-08-09 15:20:35.997129	2022-08-09 15:20:36.386002
2e027378-783a-4e9a-8086-9220cd2359d4	SE013	1	I	t	CV118	t	2022-08-09 15:20:36.002634	2022-08-09 15:20:36.392683
1334b199-9124-47f8-be6b-9e6c2b8dd28b	SE013	1	W	t	CV118	t	2022-08-09 15:20:36.009288	2022-08-09 15:20:36.400772
f29286eb-70a1-488e-be70-05e903be2a52	SE013	1	Z	t	CV118	t	2022-08-09 15:20:36.015893	2022-08-09 15:20:36.409033
17eef63c-681c-4ce5-9ac6-502a306b1557	SE014	1	A	t	CV027	f	2022-08-09 15:20:36.415449	2022-08-09 15:20:36.415449
9f240913-823a-4cfc-a47c-7c1cff22d027	SE014	1	D	t	CV027	f	2022-08-09 15:20:36.557034	2022-08-09 15:20:36.557034
7ea1b37b-32ec-4f00-b51e-c52abe38a81a	SE014	1	I	t	CV027	f	2022-08-09 15:20:36.563009	2022-08-09 15:20:36.563009
52d261d0-1d1c-4655-a978-2820c246e88f	SE014	1	W	t	CV027	f	2022-08-09 15:20:36.569753	2022-08-09 15:20:36.569753
e5b952a9-4a00-4ec7-b2e7-3e03c21ef84b	SE014	1	Z	t	CV027	f	2022-08-09 15:20:36.679075	2022-08-09 15:20:36.679075
cc0084a6-8e5f-4f04-a7d9-daeb5a0c9e5f	SE014	1	A	f	CV027	f	2022-08-09 15:20:36.684932	2022-08-09 15:20:36.684932
83e55f6e-90cb-497c-9476-127d4093d24a	SE014	1	D	f	CV027	f	2022-08-09 15:20:36.690989	2022-08-09 15:20:36.690989
3398ff9d-3e6a-4a16-945e-ea6de24ec71d	SE014	1	I	f	CV027	f	2022-08-09 15:20:36.697575	2022-08-09 15:20:36.697575
d6f8eed7-a574-4261-840d-32f91fe7e65b	SE014	1	W	f	CV027	f	2022-08-09 15:20:36.703394	2022-08-09 15:20:36.703394
ef2c259a-28af-450d-9d54-599f326665f1	SE014	1	Z	f	CV027	f	2022-08-09 15:20:36.710147	2022-08-09 15:20:36.710147
1b20a1c1-25ca-40af-8f64-6aef3dd5ecf1	SE014	1	A	t	CV079	f	2022-08-09 15:20:36.717334	2022-08-09 15:20:36.717334
785274f6-d358-4e94-a627-184bcd2cf45c	SE014	1	D	t	CV079	f	2022-08-09 15:20:36.72314	2022-08-09 15:20:36.72314
926a07b8-7ce4-4fb9-9e11-dc4153c2b067	SE014	1	I	t	CV079	f	2022-08-09 15:20:36.728728	2022-08-09 15:20:36.728728
50536c25-8e54-4b25-9eca-8575a1e1ad26	SE014	1	W	t	CV079	f	2022-08-09 15:20:36.733903	2022-08-09 15:20:36.733903
446c36c4-c50e-422e-bab5-417985c595d3	SE014	1	Z	t	CV079	f	2022-08-09 15:20:36.739673	2022-08-09 15:20:36.739673
818ded1a-f826-465b-a8c7-088d75a41877	SE014	1	A	f	CV079	f	2022-08-09 15:20:36.745779	2022-08-09 15:20:36.745779
8deb5597-b735-4cfd-a704-cb593f87f20c	SE014	1	D	f	CV079	f	2022-08-09 15:20:36.751816	2022-08-09 15:20:36.751816
f2419f60-c144-45ee-91a9-5397c9d4c023	SE014	1	I	f	CV079	f	2022-08-09 15:20:36.759154	2022-08-09 15:20:36.759154
17821739-d898-43cd-939d-4670f85e2e47	SE014	1	W	f	CV079	f	2022-08-09 15:20:36.765147	2022-08-09 15:20:36.765147
04942d55-53b8-4a72-96a4-b436d626762c	SE014	1	Z	f	CV079	f	2022-08-09 15:20:36.770519	2022-08-09 15:20:36.770519
2e820cd8-9a48-403f-9d49-f3bcd7c612d3	SE014	1	D	t	CV117	f	2022-08-09 15:20:36.781522	2022-08-09 15:20:36.781522
f5b4fc09-2a82-4a04-86fa-9bb54fb974eb	SE014	1	I	t	CV117	f	2022-08-09 15:20:36.78793	2022-08-09 15:20:36.78793
83cda66f-c108-461f-915e-23e0fdf5522e	SE014	1	W	t	CV117	f	2022-08-09 15:20:36.794527	2022-08-09 15:20:36.794527
f22dd458-a053-4ebe-8142-86cae6a51e7f	SE014	1	Z	t	CV117	f	2022-08-09 15:20:36.80159	2022-08-09 15:20:36.80159
13c56ce9-b16b-4ea0-a549-bf0f289a9106	SE014	1	A	f	CV117	f	2022-08-09 15:20:36.807413	2022-08-09 15:20:36.807413
5dc6cf21-43af-4050-a90f-ebdb33f32adf	SE014	1	D	f	CV117	f	2022-08-09 15:20:36.813048	2022-08-09 15:20:36.813048
e4f7ec56-ca0b-494b-8968-4e272b63d51b	SE014	1	I	f	CV117	f	2022-08-09 15:20:36.818415	2022-08-09 15:20:36.818415
43ac87fb-79cc-479e-80b6-3451e3b9d33c	SE014	1	W	f	CV117	f	2022-08-09 15:20:36.824535	2022-08-09 15:20:36.824535
9620fe23-a5c1-4b5e-a2a6-d5eb1dc1cba5	SE014	1	Z	f	CV117	f	2022-08-09 15:20:36.830898	2022-08-09 15:20:36.830898
17f31297-8f58-48dc-8357-add2a32fe19d	SE014	1	A	t	CV118	f	2022-08-09 15:20:36.836526	2022-08-09 15:20:36.836526
3918c309-c153-444f-ad79-87a70ff810f9	SE014	1	A	f	CV118	f	2022-08-09 15:20:36.865083	2022-08-09 15:20:36.865083
2e17ec91-02d1-40ea-af15-3945840eb70f	SE014	1	D	f	CV118	f	2022-08-09 15:20:36.871645	2022-08-09 15:20:36.871645
12ff496d-107f-44a2-a309-da4dc2d6affc	SE014	1	I	f	CV118	f	2022-08-09 15:20:36.877688	2022-08-09 15:20:36.877688
db50bf36-20d5-4e68-a2ef-9b1fd9264e09	SE014	1	W	f	CV118	f	2022-08-09 15:20:36.883303	2022-08-09 15:20:36.883303
a7d7fd83-c1e9-4051-a414-3de68a730ed6	SE014	1	Z	f	CV118	f	2022-08-09 15:20:36.888931	2022-08-09 15:20:36.888931
1e373a06-4f62-40c0-9e82-30c8bf96e2b3	SE014	1	A	t	FM004	f	2022-08-09 15:20:36.894563	2022-08-09 15:20:36.894563
583f715e-e15d-4355-a314-aed4dde9c07d	SE014	1	D	t	FM004	f	2022-08-09 15:20:36.900369	2022-08-09 15:20:36.900369
a43d708b-8a00-4c2b-aa24-c5b6b3fe6b8e	SE014	1	I	t	FM004	f	2022-08-09 15:20:36.906491	2022-08-09 15:20:36.906491
fa35cb12-22f3-4da3-a8c9-0199fb007d95	SE014	1	W	t	FM004	f	2022-08-09 15:20:36.911766	2022-08-09 15:20:36.911766
e23693d2-7763-4bc1-b4e0-5f1bc4634436	SE014	1	Z	t	FM004	f	2022-08-09 15:20:36.917284	2022-08-09 15:20:36.917284
050bbd05-e33d-47f0-9502-8907b6145005	SE014	1	A	f	FM004	f	2022-08-09 15:20:36.92328	2022-08-09 15:20:36.92328
ef59c971-a5a1-4535-aaf8-4f3e8e376e93	SE014	1	D	f	FM004	f	2022-08-09 15:20:36.929502	2022-08-09 15:20:36.929502
5b6b1412-c0d2-48fd-987e-808a16566db0	SE014	1	I	f	FM004	f	2022-08-09 15:20:36.936502	2022-08-09 15:20:36.936502
2129c9c8-0f66-459e-a5d6-6ff0836e42c3	SE014	1	W	f	FM004	f	2022-08-09 15:20:36.942642	2022-08-09 15:20:36.942642
a68d0a50-ed39-47ca-b4c8-95e1db43a7ea	SE014	1	Z	f	FM004	f	2022-08-09 15:20:36.94829	2022-08-09 15:20:36.94829
03d59519-d12f-482e-a872-33222c266429	SE014	1	A	t	FM007	f	2022-08-09 15:20:36.954789	2022-08-09 15:20:36.954789
ab32b4e5-e96d-4f93-8790-60b4ca3d6d30	SE014	1	D	t	FM007	f	2022-08-09 15:20:36.960781	2022-08-09 15:20:36.960781
d51ff8fd-51a6-43bf-b966-b4ed34b8d1ba	SE014	1	I	t	FM007	f	2022-08-09 15:20:36.967094	2022-08-09 15:20:36.967094
4fb07565-53c8-43d3-afab-d4dd4bb98af0	SE014	1	W	t	FM007	f	2022-08-09 15:20:36.972796	2022-08-09 15:20:36.972796
cd21e0ff-810d-4df2-8fef-1d140439f722	SE014	1	Z	t	FM007	f	2022-08-09 15:20:36.978434	2022-08-09 15:20:36.978434
2472c0d1-c158-4960-a277-9b4c2a8ffaf3	SE014	1	A	f	FM007	f	2022-08-09 15:20:36.984493	2022-08-09 15:20:36.984493
29aa4c97-d854-4788-8dc9-e011a47c7acd	SE014	1	D	f	FM007	f	2022-08-09 15:20:36.990483	2022-08-09 15:20:36.990483
f2e24014-5fcd-4177-9c85-fa331d04cf0f	SE014	1	I	f	FM007	f	2022-08-09 15:20:36.996119	2022-08-09 15:20:36.996119
3d917ffc-7a69-42c0-9c50-03d66a8a9c97	SE014	1	W	f	FM007	f	2022-08-09 15:20:37.001804	2022-08-09 15:20:37.001804
7c90fb54-1068-4e2b-86d9-08fdc74f7b2e	SE014	1	Z	f	FM007	f	2022-08-09 15:20:37.007304	2022-08-09 15:20:37.007304
ea776f1b-5ac1-498c-979e-ead794d23b8a	SE014	1	A	t	FM015	f	2022-08-09 15:20:37.012964	2022-08-09 15:20:37.012964
cd2da6ca-3ca3-4ac2-b4d1-24ab2af1b5c4	SE014	1	D	t	FM015	f	2022-08-09 15:20:37.018371	2022-08-09 15:20:37.018371
21493e4f-6798-425f-8f99-e504ebfa0630	SE014	1	I	t	FM015	f	2022-08-09 15:20:37.025168	2022-08-09 15:20:37.025168
535a0ff9-8c62-4d66-addb-a4da699006b2	SE014	1	W	t	FM015	f	2022-08-09 15:20:37.031396	2022-08-09 15:20:37.031396
eef292fb-7de2-4d99-868c-67db2f5b1672	SE014	1	Z	t	FM015	f	2022-08-09 15:20:37.036905	2022-08-09 15:20:37.036905
ec28f239-ecc8-40da-8d43-9b56693bc13f	SE014	1	A	f	FM015	f	2022-08-09 15:20:37.042788	2022-08-09 15:20:37.042788
38993df9-d3cc-41e7-a5e0-645b39eb8961	SE014	1	D	f	FM015	f	2022-08-09 15:20:37.048216	2022-08-09 15:20:37.048216
fd3bc6d9-1733-4347-a84e-07a886b6be20	SE014	1	I	f	FM015	f	2022-08-09 15:20:37.055211	2022-08-09 15:20:37.055211
e83c2ec5-02de-4c4d-8d68-503b9d88d0a0	SE014	1	W	f	FM015	f	2022-08-09 15:20:37.060845	2022-08-09 15:20:37.060845
950c20ba-9b5e-4ee4-a2bd-950abc76a7b8	SE014	1	Z	f	FM015	f	2022-08-09 15:20:37.066527	2022-08-09 15:20:37.066527
d88b5c80-8bbc-420b-bd15-4112546083d3	SE014	1	A	t	FM019	f	2022-08-09 15:20:37.072254	2022-08-09 15:20:37.072254
1a70710c-cac8-4b18-9736-ed866fd7429d	SE014	1	D	t	FM019	f	2022-08-09 15:20:37.077859	2022-08-09 15:20:37.077859
71274efc-7323-4e2e-baf5-b24117617b61	SE014	1	I	t	FM019	f	2022-08-09 15:20:37.08366	2022-08-09 15:20:37.08366
ffa5adaf-dc67-43a7-b742-0e7ad59e1585	SE014	1	W	t	FM019	f	2022-08-09 15:20:37.089051	2022-08-09 15:20:37.089051
c19cc0a8-d655-45d1-81d8-5ee302cf198e	SE014	1	Z	t	FM019	f	2022-08-09 15:20:37.094753	2022-08-09 15:20:37.094753
7f978dc5-a76e-4683-9ceb-4ab1cbee4bd1	SE014	1	A	f	FM019	f	2022-08-09 15:20:37.101137	2022-08-09 15:20:37.101137
7b1a9d58-bc1c-486e-8892-ec675dc75586	SE014	1	D	f	FM019	f	2022-08-09 15:20:37.106948	2022-08-09 15:20:37.106948
e0cfcee2-302d-4ef1-9cca-77f1517d7294	SE014	1	I	f	FM019	f	2022-08-09 15:20:37.112346	2022-08-09 15:20:37.112346
6abf9bab-a184-4a94-9a8a-5fe46a7d458b	SE014	1	W	f	FM019	f	2022-08-09 15:20:37.119124	2022-08-09 15:20:37.119124
9a674270-3839-4084-8982-d5bf789e9792	SE014	1	Z	f	FM019	f	2022-08-09 15:20:37.125803	2022-08-09 15:20:37.125803
5484dacb-7f9d-4eff-b800-887bc9d49563	SE014	1	A	f	FM059	t	2022-08-09 15:20:37.136733	2022-08-09 15:20:37.166992
730e2cb9-5158-4b52-b5df-643d2aceec07	SE014	1	D	f	FM059	t	2022-08-09 15:20:37.142379	2022-08-09 15:20:37.174876
60c2630b-1aae-43cb-87b4-8e6bb6105733	SE014	1	I	f	FM059	t	2022-08-09 15:20:37.148165	2022-08-09 15:20:37.182516
2e5d651e-d15b-4216-a57d-2143f5698ce8	SE014	1	W	f	FM059	t	2022-08-09 15:20:37.15356	2022-08-09 15:20:37.190032
acaf7f5d-bc89-40cc-8e62-f19f0ed0033e	SE014	1	Z	f	FM059	t	2022-08-09 15:20:37.158956	2022-08-09 15:20:37.197464
e6c29234-5dad-481a-a21f-8ae8dcb7bca6	SE014	1	A	t	CV117	t	2022-08-09 15:20:36.775584	2022-08-09 15:20:37.205065
ad98f261-d60d-4e32-ad21-b7fccfbb428d	SE014	1	D	t	CV118	t	2022-08-09 15:20:36.842216	2022-08-09 15:20:37.212895
4cb7d35a-f557-43cf-9c1d-dcd38d1bdd9b	SE014	1	I	t	CV118	t	2022-08-09 15:20:36.847542	2022-08-09 15:20:37.220674
797be65f-c53e-4db9-bdc2-ca3b7bbf38a2	SE014	1	W	t	CV118	t	2022-08-09 15:20:36.853115	2022-08-09 15:20:37.22793
5f4cf3e4-1744-4ca5-84d7-3bb902ce94ab	SE014	1	Z	t	CV118	t	2022-08-09 15:20:36.859238	2022-08-09 15:20:37.235313
a8bb05ea-eb55-4ac3-a2ac-c35969ee80de	SE015	1	A	t	CV027	f	2022-08-09 15:20:37.240689	2022-08-09 15:20:37.240689
a0ab6f0b-d45c-48e4-a78d-b36cca67f17a	SE015	1	D	t	CV027	f	2022-08-09 15:20:37.246459	2022-08-09 15:20:37.246459
24c70e02-1da0-4057-bc24-5d0cd433ae31	SE015	1	I	t	CV027	f	2022-08-09 15:20:37.251938	2022-08-09 15:20:37.251938
ae60a35e-12c5-402c-a556-1af592f86041	SE015	1	W	t	CV027	f	2022-08-09 15:20:37.257714	2022-08-09 15:20:37.257714
0389c985-8ba6-421f-9b6a-620663834913	SE015	1	Z	t	CV027	f	2022-08-09 15:20:37.263265	2022-08-09 15:20:37.263265
ac5dee5b-b860-4d56-9923-1353aa45931a	SE015	1	A	f	CV027	f	2022-08-09 15:20:37.268637	2022-08-09 15:20:37.268637
f34932ea-2f9e-468f-a8e8-e9b95ba70e5d	SE015	1	D	f	CV027	f	2022-08-09 15:20:37.274367	2022-08-09 15:20:37.274367
706faa36-7775-408d-8df4-bf3f37c2698d	SE015	1	I	f	CV027	f	2022-08-09 15:20:37.279626	2022-08-09 15:20:37.279626
11db48e7-7646-45be-b098-13ace0257358	SE015	1	W	f	CV027	f	2022-08-09 15:20:37.285027	2022-08-09 15:20:37.285027
656a45b5-75e6-4beb-bc4f-09257f1ac5cd	SE015	1	Z	f	CV027	f	2022-08-09 15:20:37.290669	2022-08-09 15:20:37.290669
2295f86a-28f0-41ab-8921-e15656eb27d6	SE015	1	A	t	CV079	f	2022-08-09 15:20:37.295961	2022-08-09 15:20:37.295961
1d60c497-42ab-48b1-af46-67f3d769e0a2	SE015	1	D	t	CV079	f	2022-08-09 15:20:37.301356	2022-08-09 15:20:37.301356
a8580559-3152-4bfa-aede-418cfed57501	SE015	1	I	t	CV079	f	2022-08-09 15:20:37.307019	2022-08-09 15:20:37.307019
376ac9e0-1a28-47c8-b81e-188aee496346	SE015	1	W	t	CV079	f	2022-08-09 15:20:37.312351	2022-08-09 15:20:37.312351
bb2427ff-527b-414b-bfc4-08ba4132deb0	SE015	1	Z	t	CV079	f	2022-08-09 15:20:37.318078	2022-08-09 15:20:37.318078
6219d62c-4742-4505-8584-1f40ae914295	SE015	1	A	f	CV079	f	2022-08-09 15:20:37.323374	2022-08-09 15:20:37.323374
5431f82f-3801-4b24-b130-1bad1e9eb1a7	SE015	1	D	f	CV079	f	2022-08-09 15:20:37.32881	2022-08-09 15:20:37.32881
403607f1-5d93-4b8c-b750-2cf97b92e524	SE015	1	I	f	CV079	f	2022-08-09 15:20:37.334545	2022-08-09 15:20:37.334545
bb361bf6-c3b3-44c6-88c6-19dd7876883f	SE015	1	W	f	CV079	f	2022-08-09 15:20:37.340184	2022-08-09 15:20:37.340184
8b521acd-953f-441d-b771-cdefb05187c0	SE015	1	Z	f	CV079	f	2022-08-09 15:20:37.34629	2022-08-09 15:20:37.34629
0e2b6958-1eb4-45b3-a7e8-ade923e78d9d	SE015	1	D	t	CV117	f	2022-08-09 15:20:37.35887	2022-08-09 15:20:37.35887
35898f47-d32d-48c2-b77e-af7c739c10b7	SE015	1	I	t	CV117	f	2022-08-09 15:20:37.365888	2022-08-09 15:20:37.365888
109c695f-2b77-424b-a200-de59c027e194	SE015	1	W	t	CV117	f	2022-08-09 15:20:37.371967	2022-08-09 15:20:37.371967
3aef85a8-a60d-4604-8b16-92f47a75af67	SE015	1	Z	t	CV117	f	2022-08-09 15:20:37.378601	2022-08-09 15:20:37.378601
7d9b3216-d2c8-4609-a597-1f7a82dd14ce	SE015	1	A	f	CV117	f	2022-08-09 15:20:37.384715	2022-08-09 15:20:37.384715
94143e12-f860-4e7a-99da-0df45cd176c3	SE015	1	D	f	CV117	f	2022-08-09 15:20:37.392512	2022-08-09 15:20:37.392512
7585ce98-fd4d-48ac-b2c1-aaaf292cff4e	SE015	1	I	f	CV117	f	2022-08-09 15:20:37.399402	2022-08-09 15:20:37.399402
8c51aaa8-30b8-4bea-8bf5-4845b9bb3f34	SE015	1	W	f	CV117	f	2022-08-09 15:20:37.405559	2022-08-09 15:20:37.405559
10789fc3-181a-4c72-9afe-688494fe14fb	SE015	1	Z	f	CV117	f	2022-08-09 15:20:37.41123	2022-08-09 15:20:37.41123
27edb96d-fb15-4827-a014-38ccb0493a80	SE015	1	A	t	CV118	f	2022-08-09 15:20:37.417168	2022-08-09 15:20:37.417168
1479e50e-4af4-46a2-8c50-70388c266227	SE015	1	A	f	CV118	f	2022-08-09 15:20:37.44675	2022-08-09 15:20:37.44675
42a9906a-bf5a-4361-9110-2562318f80da	SE015	1	D	f	CV118	f	2022-08-09 15:20:37.45211	2022-08-09 15:20:37.45211
0b0dd1ac-f496-4330-8442-055abf670796	SE015	1	I	f	CV118	f	2022-08-09 15:20:37.457759	2022-08-09 15:20:37.457759
de3b3a73-f76c-4c8d-8b32-11bf8dc75052	SE015	1	W	f	CV118	f	2022-08-09 15:20:37.463385	2022-08-09 15:20:37.463385
f65420e8-b0d6-4974-a18d-41e4d0f03ae2	SE015	1	Z	f	CV118	f	2022-08-09 15:20:37.468882	2022-08-09 15:20:37.468882
46d1c3cc-d6b7-489c-86df-47b064d58f7b	SE015	1	A	t	FM004	f	2022-08-09 15:20:37.474702	2022-08-09 15:20:37.474702
a1c106d7-39f7-4604-a285-033c30a2d5c4	SE015	1	D	t	FM004	f	2022-08-09 15:20:37.480564	2022-08-09 15:20:37.480564
fe0367cd-7a88-427e-9f7e-aa5aea5d4dc2	SE015	1	I	t	FM004	f	2022-08-09 15:20:37.486227	2022-08-09 15:20:37.486227
3c0e4f21-3e57-4f71-a7ec-4233680fa911	SE015	1	W	t	FM004	f	2022-08-09 15:20:37.491802	2022-08-09 15:20:37.491802
e7d262a0-d63f-406f-9f78-93a3f79d0655	SE015	1	Z	t	FM004	f	2022-08-09 15:20:37.497361	2022-08-09 15:20:37.497361
5b9b7629-061d-4320-a826-2da7097af5ed	SE015	1	A	f	FM004	f	2022-08-09 15:20:37.502682	2022-08-09 15:20:37.502682
8806b710-3430-4735-ac42-0c2d916b8af3	SE015	1	D	f	FM004	f	2022-08-09 15:20:37.508121	2022-08-09 15:20:37.508121
2ad7e82d-6e33-4be0-a3aa-88fe946f4d39	SE015	1	I	f	FM004	f	2022-08-09 15:20:37.513994	2022-08-09 15:20:37.513994
ccb1312f-5117-466c-bbd9-a941de8a7d8a	SE015	1	W	f	FM004	f	2022-08-09 15:20:37.519573	2022-08-09 15:20:37.519573
b486f373-df0c-492d-8e7e-7ea33e9d74f0	SE015	1	Z	f	FM004	f	2022-08-09 15:20:37.524964	2022-08-09 15:20:37.524964
7b94368f-66ea-409f-a5b2-13bd950023eb	SE015	1	A	t	FM007	f	2022-08-09 15:20:37.530631	2022-08-09 15:20:37.530631
6abe8315-0624-4de3-9867-98b1defd7d1e	SE015	1	D	t	FM007	f	2022-08-09 15:20:37.536035	2022-08-09 15:20:37.536035
9480b3fa-ed54-4af9-bb6d-27c69b0556e8	SE015	1	I	t	FM007	f	2022-08-09 15:20:37.541833	2022-08-09 15:20:37.541833
2d56966d-2e0c-4a75-8249-59e8bf568045	SE015	1	W	t	FM007	f	2022-08-09 15:20:37.547414	2022-08-09 15:20:37.547414
67bf35f3-37b3-4cda-b24b-3c4dc906b33b	SE015	1	Z	t	FM007	f	2022-08-09 15:20:37.553304	2022-08-09 15:20:37.553304
58822003-7f31-47d6-8349-727658bf933d	SE015	1	A	f	FM007	f	2022-08-09 15:20:37.558612	2022-08-09 15:20:37.558612
b46539ad-d03c-4bff-b122-8214c3f8e4cd	SE015	1	D	f	FM007	f	2022-08-09 15:20:37.56412	2022-08-09 15:20:37.56412
0232cc6f-7dcc-41be-a13b-f3785ffdcf91	SE015	1	I	f	FM007	f	2022-08-09 15:20:37.569748	2022-08-09 15:20:37.569748
345c8a38-8275-4104-ae51-a9f0ab9fad6b	SE015	1	W	f	FM007	f	2022-08-09 15:20:37.57504	2022-08-09 15:20:37.57504
7758779c-df11-48a9-8319-dfe3b32f89f4	SE015	1	Z	f	FM007	f	2022-08-09 15:20:37.580999	2022-08-09 15:20:37.580999
da42fa1b-d3a6-4740-84e8-5ea8ec471052	SE015	1	A	t	FM015	f	2022-08-09 15:20:37.587967	2022-08-09 15:20:37.587967
c52728c9-811b-4e69-898d-f68d86eed22f	SE015	1	D	t	FM015	f	2022-08-09 15:20:37.593317	2022-08-09 15:20:37.593317
eca7269f-8a2a-41d8-9ea2-c4beab116568	SE015	1	I	t	FM015	f	2022-08-09 15:20:37.599169	2022-08-09 15:20:37.599169
7ed6d48e-4947-4694-83c3-f63bbf0c3ace	SE015	1	W	t	FM015	f	2022-08-09 15:20:37.604787	2022-08-09 15:20:37.604787
b49735b3-e00a-42ac-b1d5-d20194ce31f0	SE015	1	Z	t	FM015	f	2022-08-09 15:20:37.610368	2022-08-09 15:20:37.610368
353f5609-6f50-4e81-9bc7-d5746052e234	SE015	1	A	f	FM015	f	2022-08-09 15:20:37.616233	2022-08-09 15:20:37.616233
97e9dc04-ef7d-45b5-be73-69b2274a8917	SE015	1	D	f	FM015	f	2022-08-09 15:20:37.621758	2022-08-09 15:20:37.621758
76b40e29-8791-401a-adfc-5ca146e82944	SE015	1	I	f	FM015	f	2022-08-09 15:20:37.627209	2022-08-09 15:20:37.627209
4ca5cd1d-3b74-4b7a-a65b-f46e19ebe2c2	SE015	1	W	f	FM015	f	2022-08-09 15:20:37.632918	2022-08-09 15:20:37.632918
ce30f0f6-4211-46b3-8a2a-7b501aa143e0	SE015	1	Z	f	FM015	f	2022-08-09 15:20:37.638458	2022-08-09 15:20:37.638458
4757de85-3e70-44ca-8313-be61d27def8a	SE015	1	A	t	FM019	f	2022-08-09 15:20:37.644282	2022-08-09 15:20:37.644282
83c3770d-fdfa-4b12-b803-1777ceef8d52	SE015	1	D	t	FM019	f	2022-08-09 15:20:37.650026	2022-08-09 15:20:37.650026
3f7d9676-66d6-48b4-a11a-f6ac8f58f73e	SE015	1	I	t	FM019	f	2022-08-09 15:20:37.65554	2022-08-09 15:20:37.65554
71bfeb1d-1e22-4789-89d7-5aad4d52e317	SE015	1	W	t	FM019	f	2022-08-09 15:20:37.66152	2022-08-09 15:20:37.66152
9703b86f-a8c9-4c19-a86e-e0ea78ad5e48	SE015	1	Z	t	FM019	f	2022-08-09 15:20:37.667129	2022-08-09 15:20:37.667129
b2d2f61a-d361-497e-9656-beade376ab31	SE015	1	A	f	FM019	f	2022-08-09 15:20:37.672638	2022-08-09 15:20:37.672638
6325191f-3f3a-4aaa-8329-f89f9b3f2e76	SE015	1	D	f	FM019	f	2022-08-09 15:20:37.67862	2022-08-09 15:20:37.67862
dfc17ab1-53f6-4008-8bc7-fe31df271d1b	SE015	1	I	f	FM019	f	2022-08-09 15:20:37.684	2022-08-09 15:20:37.684
b36ca51f-3cb7-496e-b481-50ca5fc32f32	SE015	1	W	f	FM019	f	2022-08-09 15:20:37.689658	2022-08-09 15:20:37.689658
77e530ff-e126-4a56-a8ce-231866b64870	SE015	1	Z	f	FM019	f	2022-08-09 15:20:37.695212	2022-08-09 15:20:37.695212
3139566d-cc04-498d-a822-af18605af3bf	SE015	1	A	f	FM059	t	2022-08-09 15:20:37.705045	2022-08-09 15:20:37.737869
faf066aa-8b5f-42ae-9444-2016acabe0a5	SE015	1	D	f	FM059	t	2022-08-09 15:20:37.710327	2022-08-09 15:20:37.745529
10d59175-df52-4c40-be94-36dac0bb5b46	SE015	1	I	f	FM059	t	2022-08-09 15:20:37.717286	2022-08-09 15:20:37.75464
ca3543e0-51eb-4cd9-afd9-7774b56b0f9d	SE015	1	W	f	FM059	t	2022-08-09 15:20:37.722912	2022-08-09 15:20:37.764465
7ff1976b-d9a0-4f41-b1a5-89471f6ea522	SE015	1	Z	f	FM059	t	2022-08-09 15:20:37.729548	2022-08-09 15:20:37.772774
e46997c5-1c29-428c-ad8f-ccbdb9cb0dd5	SE015	1	A	t	CV117	t	2022-08-09 15:20:37.352958	2022-08-09 15:20:37.780558
02ddd7f1-4eb5-49c5-b5f6-0322b7b87b36	SE015	1	D	t	CV118	t	2022-08-09 15:20:37.422949	2022-08-09 15:20:37.787704
c9b74a5e-4c41-4f3a-8675-0070d6b14364	SE015	1	I	t	CV118	t	2022-08-09 15:20:37.42832	2022-08-09 15:20:37.795533
c3e756d0-8c20-4525-a079-15a0712a0a52	SE015	1	W	t	CV118	t	2022-08-09 15:20:37.435348	2022-08-09 15:20:37.803332
61d66d89-c20a-427b-8d92-5147c51af0d9	SE015	1	Z	t	CV118	t	2022-08-09 15:20:37.440935	2022-08-09 15:20:37.812071
689c2597-9132-4716-870f-6f393e74349f	SE016	1	A	t	CV027	f	2022-08-09 15:20:37.818046	2022-08-09 15:20:37.818046
928fb4d2-7467-4905-9375-dec81f1464d6	SE016	1	D	t	CV027	f	2022-08-09 15:20:37.824065	2022-08-09 15:20:37.824065
ebdf134f-0b7d-43ca-87a2-3c0c242e4c95	SE016	1	I	t	CV027	f	2022-08-09 15:20:37.82957	2022-08-09 15:20:37.82957
53b0f747-1ae9-47a4-b8e3-a9bb80f9d045	SE016	1	W	t	CV027	f	2022-08-09 15:20:37.835265	2022-08-09 15:20:37.835265
ac05e78f-7f18-4f39-9617-a0f3fd97aa11	SE016	1	Z	t	CV027	f	2022-08-09 15:20:37.840705	2022-08-09 15:20:37.840705
9767fba6-9c99-4bc6-a56c-696b1daf843f	SE016	1	A	f	CV027	f	2022-08-09 15:20:37.846199	2022-08-09 15:20:37.846199
c78541b4-2b9f-4dfe-8741-71e2e5b86814	SE016	1	D	f	CV027	f	2022-08-09 15:20:37.852128	2022-08-09 15:20:37.852128
fbb76121-0a02-41c8-b832-c48989c71b13	SE016	1	I	f	CV027	f	2022-08-09 15:20:37.857627	2022-08-09 15:20:37.857627
f37a0cf2-bdb9-4242-848d-e3ed5f2651f8	SE016	1	W	f	CV027	f	2022-08-09 15:20:37.862923	2022-08-09 15:20:37.862923
594d843d-d8bc-41ac-ab1a-553227683dda	SE016	1	Z	f	CV027	f	2022-08-09 15:20:37.868544	2022-08-09 15:20:37.868544
19e77127-b65a-4655-ab93-d90bc5bbf802	SE016	1	A	t	CV079	f	2022-08-09 15:20:37.87394	2022-08-09 15:20:37.87394
a8fd8b5e-e693-4fa6-857e-610412d185f8	SE016	1	D	t	CV079	f	2022-08-09 15:20:37.879689	2022-08-09 15:20:37.879689
05b719e0-2092-40cc-af10-fb52c9948013	SE016	1	I	t	CV079	f	2022-08-09 15:20:37.884964	2022-08-09 15:20:37.884964
8788e9ac-ebb1-40c8-bb37-b3f90e75ebd8	SE016	1	W	t	CV079	f	2022-08-09 15:20:37.890617	2022-08-09 15:20:37.890617
42d904f0-7cb3-4007-b3e4-2a732d64fa46	SE016	1	Z	t	CV079	f	2022-08-09 15:20:37.895924	2022-08-09 15:20:37.895924
c48400dd-c607-40ca-8507-8da3855a7416	SE016	1	A	f	CV079	f	2022-08-09 15:20:37.901281	2022-08-09 15:20:37.901281
420f9914-fee5-46e4-8ac9-86f65e0e2b08	SE016	1	D	f	CV079	f	2022-08-09 15:20:37.907051	2022-08-09 15:20:37.907051
cd8498f0-9710-4506-9f88-f8ef721ded8e	SE016	1	I	f	CV079	f	2022-08-09 15:20:37.912297	2022-08-09 15:20:37.912297
8ece3c0c-ce0b-4a23-854c-f3014bda3afb	SE016	1	W	f	CV079	f	2022-08-09 15:20:37.917986	2022-08-09 15:20:37.917986
4b0d6a62-0e56-4f46-b2bf-9141ab625078	SE016	1	Z	f	CV079	f	2022-08-09 15:20:37.923282	2022-08-09 15:20:37.923282
943cdf04-2e81-45b8-949b-bbef1e79b7ae	SE016	1	D	t	CV117	f	2022-08-09 15:20:37.934762	2022-08-09 15:20:37.934762
a058d1f5-a7fa-45d9-a87f-331e88364dc7	SE016	1	I	t	CV117	f	2022-08-09 15:20:37.940225	2022-08-09 15:20:37.940225
f9a46469-77a5-40f3-9665-271bacc74228	SE016	1	W	t	CV117	f	2022-08-09 15:20:37.9456	2022-08-09 15:20:37.9456
02990c4e-e907-4dcf-9a46-312f593a3f40	SE016	1	Z	t	CV117	f	2022-08-09 15:20:37.951223	2022-08-09 15:20:37.951223
b1345eb1-2352-40d5-9aab-3a0304172908	SE016	1	A	f	CV117	f	2022-08-09 15:20:37.956671	2022-08-09 15:20:37.956671
dfbaba33-bfe0-4698-bb17-f643bab3cdcb	SE016	1	D	f	CV117	f	2022-08-09 15:20:37.961972	2022-08-09 15:20:37.961972
899f9753-c918-4b3b-9025-a64513b2d9c9	SE016	1	I	f	CV117	f	2022-08-09 15:20:37.967595	2022-08-09 15:20:37.967595
030ceeaa-644e-43e3-b59d-b999012001ea	SE016	1	W	f	CV117	f	2022-08-09 15:20:37.973013	2022-08-09 15:20:37.973013
e4c465b8-18ac-41d8-b627-4f1a45e89226	SE016	1	Z	f	CV117	f	2022-08-09 15:20:37.978752	2022-08-09 15:20:37.978752
eec77399-b255-4346-ad0a-6b288abcfdd3	SE016	1	A	t	CV118	f	2022-08-09 15:20:37.98463	2022-08-09 15:20:37.98463
df95f360-5f32-4eb1-80d5-08cf09a26a5d	SE016	1	A	f	CV118	f	2022-08-09 15:20:38.012822	2022-08-09 15:20:38.012822
d4a25983-1550-41a4-ac86-4a02fd7ed2cf	SE016	1	D	f	CV118	f	2022-08-09 15:20:38.018139	2022-08-09 15:20:38.018139
5f1a6f09-ab98-4bf6-889f-463463a53c2e	SE016	1	I	f	CV118	f	2022-08-09 15:20:38.023774	2022-08-09 15:20:38.023774
5b623402-8df1-4c32-b0e2-5090044a157b	SE016	1	W	f	CV118	f	2022-08-09 15:20:38.029134	2022-08-09 15:20:38.029134
7599d8c2-bb0e-4f03-9438-f445548f4e89	SE016	1	Z	f	CV118	f	2022-08-09 15:20:38.034668	2022-08-09 15:20:38.034668
9e947b09-683d-4534-b692-b845db2ecb82	SE016	1	A	t	FM004	f	2022-08-09 15:20:38.040115	2022-08-09 15:20:38.040115
4b38276e-c455-4b55-aa0f-a0ec8973b8fc	SE016	1	D	t	FM004	f	2022-08-09 15:20:38.046116	2022-08-09 15:20:38.046116
e4bfeb89-f286-4349-860d-69b0749e8d8b	SE016	1	I	t	FM004	f	2022-08-09 15:20:38.053067	2022-08-09 15:20:38.053067
c81ae6ac-9277-454f-8a82-e2a3b7afcf60	SE016	1	W	t	FM004	f	2022-08-09 15:20:38.059495	2022-08-09 15:20:38.059495
fd7a7b6b-082d-4b62-860c-deebce14d68c	SE016	1	Z	t	FM004	f	2022-08-09 15:20:38.065131	2022-08-09 15:20:38.065131
114e991f-7918-419d-8554-b0a21f80ff28	SE016	1	A	f	FM004	f	2022-08-09 15:20:38.071084	2022-08-09 15:20:38.071084
f439dc5b-5184-4520-aab7-7c03ba125f02	SE016	1	D	f	FM004	f	2022-08-09 15:20:38.076586	2022-08-09 15:20:38.076586
342e5472-06b4-49e4-8c26-5a0cd6f2a774	SE016	1	I	f	FM004	f	2022-08-09 15:20:38.083256	2022-08-09 15:20:38.083256
31c127ef-da49-42b6-8a80-9ed747ab1f4b	SE016	1	W	f	FM004	f	2022-08-09 15:20:38.089185	2022-08-09 15:20:38.089185
502c5874-6ba8-4456-8ebd-183f85ae3083	SE016	1	Z	f	FM004	f	2022-08-09 15:20:38.095205	2022-08-09 15:20:38.095205
f5c44ff6-f0ba-4e06-9091-28085aabca9d	SE016	1	A	t	FM007	f	2022-08-09 15:20:38.100713	2022-08-09 15:20:38.100713
bc92f18e-288a-4ca3-87e5-025d3ac96bab	SE016	1	D	t	FM007	f	2022-08-09 15:20:38.106623	2022-08-09 15:20:38.106623
f8af66a2-b5d7-4db0-9898-a6a3270654cf	SE016	1	I	t	FM007	f	2022-08-09 15:20:38.112047	2022-08-09 15:20:38.112047
1b98d6d7-fcfc-41d1-b1ee-626e8fe9856d	SE016	1	W	t	FM007	f	2022-08-09 15:20:38.117676	2022-08-09 15:20:38.117676
3e8d4c66-0ebc-4c6d-956c-194db7f9881e	SE016	1	Z	t	FM007	f	2022-08-09 15:20:38.123362	2022-08-09 15:20:38.123362
f30ff294-2e7e-4631-a667-0cfdb1074aa1	SE016	1	A	f	FM007	f	2022-08-09 15:20:38.129581	2022-08-09 15:20:38.129581
384d7d95-4543-4c73-9d77-936e1bf8457d	SE016	1	D	f	FM007	f	2022-08-09 15:20:38.135266	2022-08-09 15:20:38.135266
a6a1131a-3435-4df8-9d18-ee1b82ad4059	SE016	1	I	f	FM007	f	2022-08-09 15:20:38.141022	2022-08-09 15:20:38.141022
8707ecf8-93cf-4183-abc8-3a897bedbf90	SE016	1	W	f	FM007	f	2022-08-09 15:20:38.146529	2022-08-09 15:20:38.146529
c47de64d-933d-44a4-b652-44ea09a68d9e	SE016	1	Z	f	FM007	f	2022-08-09 15:20:38.152196	2022-08-09 15:20:38.152196
bf1f98be-14f5-4d22-8147-59e415e6e400	SE016	1	A	t	FM015	f	2022-08-09 15:20:38.157782	2022-08-09 15:20:38.157782
37d4f2a8-b9a3-4aa6-8ebb-9acce65d45fb	SE016	1	D	t	FM015	f	2022-08-09 15:20:38.163188	2022-08-09 15:20:38.163188
de636918-6064-4b40-93df-ad02751de0b5	SE016	1	I	t	FM015	f	2022-08-09 15:20:38.16947	2022-08-09 15:20:38.16947
b1ebf01f-9783-46c0-9c23-f7456bfbcc23	SE016	1	W	t	FM015	f	2022-08-09 15:20:38.175244	2022-08-09 15:20:38.175244
550b3cfd-e90a-4a07-8f4a-a3a685b49712	SE016	1	Z	t	FM015	f	2022-08-09 15:20:38.180745	2022-08-09 15:20:38.180745
f31ed155-eb47-46c3-bbc2-e4dfc4ba453c	SE016	1	A	f	FM015	f	2022-08-09 15:20:38.186798	2022-08-09 15:20:38.186798
4cff0e55-7d49-4cb3-9759-cbe7ac5b6257	SE016	1	D	f	FM015	f	2022-08-09 15:20:38.192189	2022-08-09 15:20:38.192189
28cfa47a-0e96-4044-b88c-9c679d3f7e5d	SE016	1	I	f	FM015	f	2022-08-09 15:20:38.197945	2022-08-09 15:20:38.197945
2a468f13-e1a7-49ae-95d0-ec3c2925ef6a	SE016	1	W	f	FM015	f	2022-08-09 15:20:38.203473	2022-08-09 15:20:38.203473
4c29ad72-91f1-4230-9748-0bf9c0994913	SE016	1	Z	f	FM015	f	2022-08-09 15:20:38.20945	2022-08-09 15:20:38.20945
591135b1-a108-4386-9f04-1440993e7791	SE016	1	A	t	FM019	f	2022-08-09 15:20:38.215028	2022-08-09 15:20:38.215028
ee98f299-0616-4e5a-bd21-c609ffc37a18	SE016	1	D	t	FM019	f	2022-08-09 15:20:38.220361	2022-08-09 15:20:38.220361
519bf31c-d963-4450-9c6c-c4770099d66d	SE016	1	I	t	FM019	f	2022-08-09 15:20:38.226062	2022-08-09 15:20:38.226062
148fd8b4-acd7-46b4-bdc1-6b6093c70963	SE016	1	W	t	FM019	f	2022-08-09 15:20:38.231633	2022-08-09 15:20:38.231633
cbb5843a-8dac-4a74-9838-25df918ee2a4	SE016	1	Z	t	FM019	f	2022-08-09 15:20:38.236858	2022-08-09 15:20:38.236858
c7f05251-f459-46c1-8eb1-564c57628444	SE016	1	A	f	FM019	f	2022-08-09 15:20:38.242545	2022-08-09 15:20:38.242545
dc724615-4a5f-4bf6-b985-ffb926f8a7eb	SE016	1	D	f	FM019	f	2022-08-09 15:20:38.247939	2022-08-09 15:20:38.247939
b4e31dbc-2e69-471c-8473-84d1eb568603	SE016	1	I	f	FM019	f	2022-08-09 15:20:38.253572	2022-08-09 15:20:38.253572
48a5f9a9-79ee-4e7e-816f-20910dca125a	SE016	1	W	f	FM019	f	2022-08-09 15:20:38.258887	2022-08-09 15:20:38.258887
a435878d-7d5d-4a36-955e-edfc377a0325	SE016	1	Z	f	FM019	f	2022-08-09 15:20:38.264299	2022-08-09 15:20:38.264299
c65f8e78-9244-4768-b76b-9266014a8691	SE016	1	A	f	FM059	t	2022-08-09 15:20:38.274049	2022-08-09 15:20:38.303869
709c8088-8b73-47eb-aa78-474ac4e11b21	SE016	1	D	f	FM059	t	2022-08-09 15:20:38.279444	2022-08-09 15:20:38.311415
837ce152-863e-444d-94db-7f2c72cdae94	SE016	1	I	f	FM059	t	2022-08-09 15:20:38.284901	2022-08-09 15:20:38.318563
7b712b29-2298-4c2a-98b0-a69abc96b8f8	SE016	1	W	f	FM059	t	2022-08-09 15:20:38.290608	2022-08-09 15:20:38.326209
672fc729-a427-40cd-92b2-f302f54756cb	SE016	1	Z	f	FM059	t	2022-08-09 15:20:38.295987	2022-08-09 15:20:38.334116
81366c3e-3815-4f8b-aaef-f981a650592f	SE016	1	A	t	CV117	t	2022-08-09 15:20:37.928829	2022-08-09 15:20:38.341835
b551aa25-9d40-490a-b312-fca281616234	SE016	1	D	t	CV118	t	2022-08-09 15:20:37.990062	2022-08-09 15:20:38.351976
7b26e19d-93dc-4f89-bf1b-a6cbd5359ce1	SE016	1	I	t	CV118	t	2022-08-09 15:20:37.995875	2022-08-09 15:20:38.360327
4840dab0-0da5-4c48-8c3e-70c690ed6a73	SE016	1	W	t	CV118	t	2022-08-09 15:20:38.001721	2022-08-09 15:20:38.36909
f161fc1d-d647-4616-834c-c05c1faee49a	SE016	1	Z	t	CV118	t	2022-08-09 15:20:38.007175	2022-08-09 15:20:38.37724
37b6378c-ff55-41b0-b39f-cfc82def3146	SE095	1	A	t	CV027	f	2022-08-09 15:20:38.383869	2022-08-09 15:20:38.383869
000f2524-bd8a-47d5-add6-fcf578741290	SE095	1	D	t	CV027	f	2022-08-09 15:20:38.39076	2022-08-09 15:20:38.39076
9313f47c-a443-40f9-add5-93cd116cb7e9	SE095	1	I	t	CV027	f	2022-08-09 15:20:38.3968	2022-08-09 15:20:38.3968
437591dc-2cf5-4b4c-b63d-348446629ad4	SE095	1	W	t	CV027	f	2022-08-09 15:20:38.402909	2022-08-09 15:20:38.402909
65697ba3-0197-42b0-b4b0-0700aeae72b6	SE095	1	Z	t	CV027	f	2022-08-09 15:20:38.408565	2022-08-09 15:20:38.408565
f06f82cd-6ded-4ba2-b6a0-8dcf6ca0db49	SE095	1	A	f	CV027	f	2022-08-09 15:20:38.414416	2022-08-09 15:20:38.414416
07c8abdc-e842-43c9-ae6b-bf6ff407611e	SE095	1	D	f	CV027	f	2022-08-09 15:20:38.420312	2022-08-09 15:20:38.420312
70ab4ef3-a6b3-4832-93ae-d947e35084a3	SE095	1	I	f	CV027	f	2022-08-09 15:20:38.425733	2022-08-09 15:20:38.425733
d67e2902-9d6d-4112-bf05-64175f474316	SE095	1	W	f	CV027	f	2022-08-09 15:20:38.431568	2022-08-09 15:20:38.431568
50dda672-29ea-4dfc-8844-9f321b51ff4d	SE095	1	Z	f	CV027	f	2022-08-09 15:20:38.43694	2022-08-09 15:20:38.43694
1a5221f8-b831-45bf-8d7b-a32cd4eab3a4	SE095	1	A	t	CV079	f	2022-08-09 15:20:38.442711	2022-08-09 15:20:38.442711
e4571d39-189f-4203-9321-fcdbb319ca48	SE095	1	D	t	CV079	f	2022-08-09 15:20:38.44818	2022-08-09 15:20:38.44818
9729a584-6065-4f2b-acee-0ed41114f4ea	SE095	1	I	t	CV079	f	2022-08-09 15:20:38.453849	2022-08-09 15:20:38.453849
32b88f8d-9ce6-4818-93e6-e73cd6a0699c	SE095	1	W	t	CV079	f	2022-08-09 15:20:38.459147	2022-08-09 15:20:38.459147
5b810a06-faea-4852-8f84-9ebd36f84dc9	SE095	1	Z	t	CV079	f	2022-08-09 15:20:38.465046	2022-08-09 15:20:38.465046
ddc02eb9-5d57-4e9f-bcda-00c208b2769b	SE095	1	A	f	CV079	f	2022-08-09 15:20:38.470435	2022-08-09 15:20:38.470435
dff31167-9a7a-4073-b096-a5983981f69e	SE095	1	D	f	CV079	f	2022-08-09 15:20:38.476239	2022-08-09 15:20:38.476239
42d8c751-bb15-4b2e-95dd-bf65dbf05f28	SE095	1	I	f	CV079	f	2022-08-09 15:20:38.482849	2022-08-09 15:20:38.482849
77eeab7d-d7db-4a8b-87b7-e7d3bba14505	SE095	1	W	f	CV079	f	2022-08-09 15:20:38.489208	2022-08-09 15:20:38.489208
a8ed1e1c-89c4-4015-baf6-af92b7baf5bb	SE095	1	Z	f	CV079	f	2022-08-09 15:20:38.495084	2022-08-09 15:20:38.495084
689feaa4-ed94-4e7f-98df-f6fda276c03b	SE095	1	D	t	CV117	f	2022-08-09 15:20:38.506256	2022-08-09 15:20:38.506256
717512af-fa07-4e55-b8e0-4ec42383d58b	SE095	1	I	t	CV117	f	2022-08-09 15:20:38.511803	2022-08-09 15:20:38.511803
932fff03-c662-4b38-893d-2d8afe154880	SE095	1	W	t	CV117	f	2022-08-09 15:20:38.517113	2022-08-09 15:20:38.517113
ab36f71c-5049-4007-8183-307932259df3	SE095	1	Z	t	CV117	f	2022-08-09 15:20:38.522974	2022-08-09 15:20:38.522974
8f2a9b44-d70e-486d-8c05-9d24af910edb	SE095	1	A	f	CV117	f	2022-08-09 15:20:38.528481	2022-08-09 15:20:38.528481
e71277f9-b76c-4a60-a13d-04637df3bea8	SE095	1	D	f	CV117	f	2022-08-09 15:20:38.534221	2022-08-09 15:20:38.534221
0d862b79-b5ce-4e0a-bffd-84c27aebb220	SE095	1	I	f	CV117	f	2022-08-09 15:20:38.539697	2022-08-09 15:20:38.539697
625e0776-aaaa-4b25-b9d3-5f785d5eaa1f	SE095	1	W	f	CV117	f	2022-08-09 15:20:38.545088	2022-08-09 15:20:38.545088
85843da9-b7b9-4028-bee1-2bd21373138d	SE095	1	Z	f	CV117	f	2022-08-09 15:20:38.550856	2022-08-09 15:20:38.550856
07f38e4d-2ca4-4f59-8dad-a62d3824081c	SE095	1	A	t	CV118	f	2022-08-09 15:20:38.557483	2022-08-09 15:20:38.557483
fb8ed3fc-2f78-4fe1-a8b2-65d32cb40d7f	SE095	1	A	f	CV118	f	2022-08-09 15:20:38.586744	2022-08-09 15:20:38.586744
a6bf4ee0-5637-4713-8ac7-1431d1d6e611	SE095	1	D	f	CV118	f	2022-08-09 15:20:38.59243	2022-08-09 15:20:38.59243
25b48998-c790-4db2-bc33-c81b433b05b2	SE095	1	I	f	CV118	f	2022-08-09 15:20:38.598611	2022-08-09 15:20:38.598611
8e5daeaa-adbd-4379-844f-3784e8daadbc	SE095	1	W	f	CV118	f	2022-08-09 15:20:38.604497	2022-08-09 15:20:38.604497
050dcc0b-be1e-4b41-aa18-cd5f2f5a0f2b	SE095	1	Z	f	CV118	f	2022-08-09 15:20:38.610482	2022-08-09 15:20:38.610482
7f7986ae-3f8b-41a1-b076-f478e248ff9f	SE095	1	A	t	FM004	f	2022-08-09 15:20:38.615923	2022-08-09 15:20:38.615923
9345bde9-c666-4569-ac51-fbec33243f78	SE095	1	D	t	FM004	f	2022-08-09 15:20:38.621372	2022-08-09 15:20:38.621372
ef40aa6a-081a-46df-bf34-2164ef86a47f	SE095	1	I	t	FM004	f	2022-08-09 15:20:38.627169	2022-08-09 15:20:38.627169
e0f6ff63-6cf9-4245-bc1d-cd24771e5d4c	SE095	1	W	t	FM004	f	2022-08-09 15:20:38.632622	2022-08-09 15:20:38.632622
c4327e78-7bf4-4efd-a5d5-e1a8c1d1ca6a	SE095	1	Z	t	FM004	f	2022-08-09 15:20:38.63797	2022-08-09 15:20:38.63797
4e958721-9aa4-4b00-bae1-04ef699ae19d	SE095	1	A	f	FM004	f	2022-08-09 15:20:38.643816	2022-08-09 15:20:38.643816
e2b557ee-63a8-42b0-a7a5-85b1c2ce6eb2	SE095	1	D	f	FM004	f	2022-08-09 15:20:38.649415	2022-08-09 15:20:38.649415
5646cf49-150d-4b8f-8b60-4e9c8fbb7534	SE095	1	I	f	FM004	f	2022-08-09 15:20:38.654829	2022-08-09 15:20:38.654829
2c5d2d03-e13a-44bb-b39f-dd50ba295f6a	SE095	1	W	f	FM004	f	2022-08-09 15:20:38.66054	2022-08-09 15:20:38.66054
bd905804-24c7-461b-9149-c07790d15a34	SE095	1	Z	f	FM004	f	2022-08-09 15:20:38.665833	2022-08-09 15:20:38.665833
67caf7d9-ca00-4abb-bb80-59d1384c5467	SE095	1	A	t	FM007	f	2022-08-09 15:20:38.671417	2022-08-09 15:20:38.671417
4f9ff301-6308-4ed3-a88b-ccced5297ade	SE095	1	D	t	FM007	f	2022-08-09 15:20:38.677347	2022-08-09 15:20:38.677347
8fc1672a-a4b4-4a24-8fc5-a51d7719d032	SE095	1	I	t	FM007	f	2022-08-09 15:20:38.682895	2022-08-09 15:20:38.682895
a2ac2483-3010-4c69-ae3c-951530c7ec7c	SE095	1	W	t	FM007	f	2022-08-09 15:20:38.688948	2022-08-09 15:20:38.688948
0d4f208d-2e6b-4559-acc8-88cdacae22de	SE095	1	Z	t	FM007	f	2022-08-09 15:20:38.694825	2022-08-09 15:20:38.694825
04bc61e4-e21b-452b-8507-777f10b05e59	SE095	1	A	f	FM007	f	2022-08-09 15:20:38.700121	2022-08-09 15:20:38.700121
f32e9f84-8438-4235-8658-0e86c065528f	SE095	1	D	f	FM007	f	2022-08-09 15:20:38.705563	2022-08-09 15:20:38.705563
5ee5da66-ebb3-4928-943b-13dfb7e14086	SE095	1	I	f	FM007	f	2022-08-09 15:20:38.711277	2022-08-09 15:20:38.711277
2cc9a777-4c0b-4a45-99c0-a4857e2c851e	SE095	1	W	f	FM007	f	2022-08-09 15:20:38.71673	2022-08-09 15:20:38.71673
37286224-fbe4-46c5-b159-25d1d1c0d07b	SE095	1	Z	f	FM007	f	2022-08-09 15:20:38.72342	2022-08-09 15:20:38.72342
daac71cf-3fa9-4e97-9510-51d79fa37192	SE095	1	A	t	FM015	f	2022-08-09 15:20:38.729424	2022-08-09 15:20:38.729424
46fa2c09-39b1-47b0-b880-229937cf2023	SE095	1	D	t	FM015	f	2022-08-09 15:20:38.735329	2022-08-09 15:20:38.735329
308a6b81-0c5d-473f-b9f2-bfdaf65e4754	SE095	1	I	t	FM015	f	2022-08-09 15:20:38.740695	2022-08-09 15:20:38.740695
ef09a442-63ad-484f-9f18-fd145a13336a	SE095	1	W	t	FM015	f	2022-08-09 15:20:38.746566	2022-08-09 15:20:38.746566
af15aea4-dc20-4e1b-a809-049f3854f61b	SE095	1	Z	t	FM015	f	2022-08-09 15:20:38.751977	2022-08-09 15:20:38.751977
9adbdac0-f67c-4b20-b00a-23b4606e65cc	SE095	1	A	f	FM015	f	2022-08-09 15:20:38.757789	2022-08-09 15:20:38.757789
be56af72-ffd8-4697-8e28-46ca51f55049	SE095	1	D	f	FM015	f	2022-08-09 15:20:38.763208	2022-08-09 15:20:38.763208
73c61f19-27f8-4cb1-8ea3-09acb3511fbd	SE095	1	I	f	FM015	f	2022-08-09 15:20:38.768999	2022-08-09 15:20:38.768999
090e682e-c5f7-49da-a819-807ac67a3c66	SE095	1	W	f	FM015	f	2022-08-09 15:20:38.774688	2022-08-09 15:20:38.774688
15999f7f-1c4c-4246-924d-94a297383f15	SE095	1	Z	f	FM015	f	2022-08-09 15:20:38.780076	2022-08-09 15:20:38.780076
65a8243e-5022-4b40-9f32-8dc768b09e10	SE095	1	A	t	FM019	f	2022-08-09 15:20:38.785369	2022-08-09 15:20:38.785369
ba5a2967-5597-45da-8916-2628c4a45348	SE095	1	D	t	FM019	f	2022-08-09 15:20:38.791103	2022-08-09 15:20:38.791103
81f2991e-e58d-4a23-ab5b-765edfedd405	SE095	1	I	t	FM019	f	2022-08-09 15:20:38.796592	2022-08-09 15:20:38.796592
b898db4e-cb82-4d81-baf0-a5ee87a8fa6b	SE095	1	W	t	FM019	f	2022-08-09 15:20:38.802288	2022-08-09 15:20:38.802288
b0c73c0f-f52c-4e13-aae2-88644608854b	SE095	1	Z	t	FM019	f	2022-08-09 15:20:38.807681	2022-08-09 15:20:38.807681
bf56a401-d058-4d62-9027-494e7c587669	SE095	1	A	f	FM019	f	2022-08-09 15:20:38.813447	2022-08-09 15:20:38.813447
ec8ad1f8-0196-4834-8d28-6ff071923aeb	SE095	1	D	f	FM019	f	2022-08-09 15:20:38.818725	2022-08-09 15:20:38.818725
feed23b9-549f-44ed-b6ab-918da7469cfa	SE095	1	I	f	FM019	f	2022-08-09 15:20:38.824255	2022-08-09 15:20:38.824255
85850951-2388-4e98-b99b-2b449f3abaeb	SE095	1	W	f	FM019	f	2022-08-09 15:20:38.830017	2022-08-09 15:20:38.830017
6d9250bc-3813-4b10-b825-979ed497fd6b	SE095	1	Z	f	FM019	f	2022-08-09 15:20:38.835463	2022-08-09 15:20:38.835463
957c313d-97ba-466a-9b8f-c8694c352ae0	SE095	1	A	f	FM059	t	2022-08-09 15:20:38.845224	2022-08-09 15:20:38.875116
3c4d707c-65bd-4c28-b825-efe6726ec4e8	SE095	1	D	f	FM059	t	2022-08-09 15:20:38.851027	2022-08-09 15:20:38.882609
8d95374d-1a20-41bc-8e9b-b6145cd15e1c	SE095	1	I	f	FM059	t	2022-08-09 15:20:38.85665	2022-08-09 15:20:38.890768
1440ee51-aef7-4aa3-9e5e-56148f509461	SE095	1	W	f	FM059	t	2022-08-09 15:20:38.862243	2022-08-09 15:20:38.898725
91a38f3f-7925-4555-8844-68aaf9bb2178	SE095	1	Z	f	FM059	t	2022-08-09 15:20:38.867635	2022-08-09 15:20:38.9064
47e10249-eef3-46fd-be59-1deebfbe5c86	SE095	1	A	t	CV117	t	2022-08-09 15:20:38.500643	2022-08-09 15:20:38.914022
033804f3-e4c7-466d-8459-75ce2f52df49	SE095	1	D	t	CV118	t	2022-08-09 15:20:38.562903	2022-08-09 15:20:38.921528
e2bf264c-2e27-4ae6-8d03-f86bc316d6b9	SE095	1	I	t	CV118	t	2022-08-09 15:20:38.568628	2022-08-09 15:20:38.929177
0c4a3eec-62a0-45fa-ba67-80e8295b1560	SE095	1	W	t	CV118	t	2022-08-09 15:20:38.574099	2022-08-09 15:20:38.937057
8b09f644-c472-459a-b807-0db7232377fe	SE095	1	Z	t	CV118	t	2022-08-09 15:20:38.579833	2022-08-09 15:20:38.944597
7af26565-bab6-4b2c-a960-a1d00eca3785	SE097	1	A	t	CV027	f	2022-08-09 15:20:38.949871	2022-08-09 15:20:38.949871
7c2edfe0-a41f-40bc-9008-b7ba9e039d84	SE097	1	D	t	CV027	f	2022-08-09 15:20:38.955378	2022-08-09 15:20:38.955378
9d18f2c9-6139-4510-a74a-242835fb25ce	SE097	1	I	t	CV027	f	2022-08-09 15:20:38.960958	2022-08-09 15:20:38.960958
83f26120-8195-430e-8791-6da1b74a102a	SE097	1	W	t	CV027	f	2022-08-09 15:20:38.966525	2022-08-09 15:20:38.966525
8afc2189-9bf8-4929-8f84-9967fbc24fdf	SE097	1	Z	t	CV027	f	2022-08-09 15:20:38.971927	2022-08-09 15:20:38.971927
50a0ca4c-b093-43b1-8a94-511a9e004052	SE097	1	A	f	CV027	f	2022-08-09 15:20:38.978015	2022-08-09 15:20:38.978015
0f5d085d-8439-4150-8489-5294a270717a	SE097	1	D	f	CV027	f	2022-08-09 15:20:38.983595	2022-08-09 15:20:38.983595
e008ed40-60ba-4466-8f38-baa8a70b1682	SE097	1	I	f	CV027	f	2022-08-09 15:20:38.98938	2022-08-09 15:20:38.98938
bf5157e9-ce20-4dfd-a2c5-930e30fe1950	SE097	1	W	f	CV027	f	2022-08-09 15:20:38.995158	2022-08-09 15:20:38.995158
00a5e36a-9fba-4392-9bd8-290e1c0edb5e	SE097	1	Z	f	CV027	f	2022-08-09 15:20:39.000613	2022-08-09 15:20:39.000613
b60f2888-dc62-45da-ae73-b8b51f347441	SE097	1	A	t	CV079	f	2022-08-09 15:20:39.006339	2022-08-09 15:20:39.006339
7374f63f-d2a0-48b6-82ca-b0af5cc63858	SE097	1	D	t	CV079	f	2022-08-09 15:20:39.01205	2022-08-09 15:20:39.01205
decbf67b-f42a-454a-8463-0adba4701d12	SE097	1	I	t	CV079	f	2022-08-09 15:20:39.017816	2022-08-09 15:20:39.017816
65dacfbb-242e-4ea5-914f-c28cf69f8d3b	SE097	1	W	t	CV079	f	2022-08-09 15:20:39.023323	2022-08-09 15:20:39.023323
ed4ca349-90cf-4f54-a7a8-66dfe97f5483	SE097	1	Z	t	CV079	f	2022-08-09 15:20:39.029242	2022-08-09 15:20:39.029242
35fe0638-3365-412e-8d75-6d232fec8a51	SE097	1	A	f	CV079	f	2022-08-09 15:20:39.034769	2022-08-09 15:20:39.034769
0d42ea7b-e4d4-4662-ade8-2c5e8a9eaef0	SE097	1	D	f	CV079	f	2022-08-09 15:20:39.040184	2022-08-09 15:20:39.040184
0413e97d-9347-4dd0-bafa-d7d15f6470fe	SE097	1	I	f	CV079	f	2022-08-09 15:20:39.045789	2022-08-09 15:20:39.045789
af117639-acc0-43b7-8edc-dc5a02b05bd5	SE097	1	W	f	CV079	f	2022-08-09 15:20:39.052431	2022-08-09 15:20:39.052431
d3f6b587-e037-4432-9c12-ca84d5649e4d	SE097	1	Z	f	CV079	f	2022-08-09 15:20:39.058511	2022-08-09 15:20:39.058511
aea66a85-3e2e-4d98-a85f-e870ebdfa4fa	SE097	1	D	t	CV117	f	2022-08-09 15:20:39.06977	2022-08-09 15:20:39.06977
b6df75ce-e089-47c7-8755-c41f665825eb	SE097	1	I	t	CV117	f	2022-08-09 15:20:39.075446	2022-08-09 15:20:39.075446
ce4014bf-2a86-4131-b304-0f6d46f70e22	SE097	1	W	t	CV117	f	2022-08-09 15:20:39.080829	2022-08-09 15:20:39.080829
2fddddb1-9b28-4f8c-9de4-c23d932ae2a1	SE097	1	Z	t	CV117	f	2022-08-09 15:20:39.086817	2022-08-09 15:20:39.086817
416dacb1-92c1-4e3e-a47c-147c870e8ff4	SE097	1	A	f	CV117	f	2022-08-09 15:20:39.092356	2022-08-09 15:20:39.092356
905b739b-3e13-40d3-bb21-a78f8761b27a	SE097	1	D	f	CV117	f	2022-08-09 15:20:39.09811	2022-08-09 15:20:39.09811
ea49c58b-1bea-4675-a388-b568e60f1299	SE097	1	I	f	CV117	f	2022-08-09 15:20:39.10339	2022-08-09 15:20:39.10339
77f22149-150a-4d69-a15e-fc1753724771	SE097	1	W	f	CV117	f	2022-08-09 15:20:39.109296	2022-08-09 15:20:39.109296
bef9e576-6016-4673-b9bc-9dd1dcd1c719	SE097	1	Z	f	CV117	f	2022-08-09 15:20:39.114712	2022-08-09 15:20:39.114712
fcef623c-e0ef-4e90-a68b-a40c81771b5d	SE097	1	A	t	CV118	f	2022-08-09 15:20:39.122181	2022-08-09 15:20:39.122181
4b5dd0c3-f259-4f6a-990c-7b6f12e21a60	SE097	1	A	f	CV118	f	2022-08-09 15:20:39.151699	2022-08-09 15:20:39.151699
07bde1fc-4684-4413-a9d3-602019052b34	SE097	1	D	f	CV118	f	2022-08-09 15:20:39.157037	2022-08-09 15:20:39.157037
479b8f20-284f-4098-b549-e5169c4059a8	SE097	1	I	f	CV118	f	2022-08-09 15:20:39.1627	2022-08-09 15:20:39.1627
23fe4aff-d25b-45bf-9d35-b11e0642818d	SE097	1	W	f	CV118	f	2022-08-09 15:20:39.168307	2022-08-09 15:20:39.168307
bfb43f05-0654-422d-8aa3-a073a46f74c1	SE097	1	Z	f	CV118	f	2022-08-09 15:20:39.17418	2022-08-09 15:20:39.17418
13418ccd-f801-4e17-93e9-f8b070d2c1cb	SE097	1	A	t	FM004	f	2022-08-09 15:20:39.180202	2022-08-09 15:20:39.180202
a32c1a46-67d4-4513-baff-3c539c80a87a	SE097	1	D	t	FM004	f	2022-08-09 15:20:39.18563	2022-08-09 15:20:39.18563
025a95cd-71d8-4d0f-83e8-4d8fc938cfea	SE097	1	I	t	FM004	f	2022-08-09 15:20:39.191264	2022-08-09 15:20:39.191264
b2fbfe36-9198-4512-ad25-0b0179b8968f	SE097	1	W	t	FM004	f	2022-08-09 15:20:39.196623	2022-08-09 15:20:39.196623
e403deb6-2b4a-4cf2-b074-c3079b53ca04	SE097	1	Z	t	FM004	f	2022-08-09 15:20:39.201956	2022-08-09 15:20:39.201956
17f2b033-c51e-4c6e-a5c1-0e6000eb1630	SE097	1	A	f	FM004	f	2022-08-09 15:20:39.207603	2022-08-09 15:20:39.207603
58e3ea7b-5865-41a1-a2aa-30cf3e4e2b9e	SE097	1	D	f	FM004	f	2022-08-09 15:20:39.213018	2022-08-09 15:20:39.213018
98841da8-e898-4465-8f34-7d9f98b6e9e0	SE097	1	I	f	FM004	f	2022-08-09 15:20:39.218688	2022-08-09 15:20:39.218688
4dc99c28-f0c1-4395-aa27-9318f3ff98db	SE097	1	W	f	FM004	f	2022-08-09 15:20:39.224017	2022-08-09 15:20:39.224017
5ebdb842-0faa-4dce-96a6-6b6531f4502d	SE097	1	Z	f	FM004	f	2022-08-09 15:20:39.229587	2022-08-09 15:20:39.229587
ad40983f-4fa1-4b45-a8d2-44c12df6cabf	SE097	1	A	t	FM007	f	2022-08-09 15:20:39.235196	2022-08-09 15:20:39.235196
e3b06f58-720c-427d-93d7-9c49c56720a2	SE097	1	D	t	FM007	f	2022-08-09 15:20:39.240594	2022-08-09 15:20:39.240594
ccb59813-97ee-4aa1-ac63-e70b1c19b686	SE097	1	I	t	FM007	f	2022-08-09 15:20:39.246274	2022-08-09 15:20:39.246274
b0437e37-cdbc-4bcf-9721-19b23a60b989	SE097	1	W	t	FM007	f	2022-08-09 15:20:39.251518	2022-08-09 15:20:39.251518
cc197924-043a-425d-a727-7395cee0f6b3	SE097	1	Z	t	FM007	f	2022-08-09 15:20:39.257164	2022-08-09 15:20:39.257164
3cfe4764-3805-4f99-aecd-685cb991f5b1	SE097	1	A	f	FM007	f	2022-08-09 15:20:39.262908	2022-08-09 15:20:39.262908
9e07f5b8-69a0-4729-8405-2a4b8c65571f	SE097	1	D	f	FM007	f	2022-08-09 15:20:39.268623	2022-08-09 15:20:39.268623
ce92305e-91b0-4445-b28c-2908a72978c8	SE097	1	I	f	FM007	f	2022-08-09 15:20:39.273986	2022-08-09 15:20:39.273986
92ab3675-5e39-4768-9902-20d5a3fa72fe	SE097	1	W	f	FM007	f	2022-08-09 15:20:39.279812	2022-08-09 15:20:39.279812
953baba4-2d30-4d2e-a7bd-a5abef2a3add	SE097	1	Z	f	FM007	f	2022-08-09 15:20:39.28567	2022-08-09 15:20:39.28567
cc397bb3-d408-4582-a681-6183f826711f	SE097	1	A	t	FM015	f	2022-08-09 15:20:39.291407	2022-08-09 15:20:39.291407
ad7775d6-b3a0-488d-bd41-e684f74c74bc	SE097	1	D	t	FM015	f	2022-08-09 15:20:39.297411	2022-08-09 15:20:39.297411
708ebdaf-d4eb-4e92-a022-ec0fb0fc4b78	SE097	1	I	t	FM015	f	2022-08-09 15:20:39.30367	2022-08-09 15:20:39.30367
4cf0e5d4-34aa-42c3-9844-048d3d388a63	SE097	1	W	t	FM015	f	2022-08-09 15:20:39.309882	2022-08-09 15:20:39.309882
6076dee2-4265-408c-9046-c8c2de3ab511	SE097	1	Z	t	FM015	f	2022-08-09 15:20:39.315773	2022-08-09 15:20:39.315773
9a564139-0711-4359-9360-21578c682977	SE097	1	A	f	FM015	f	2022-08-09 15:20:39.321323	2022-08-09 15:20:39.321323
188b4914-4a81-4956-9c25-f653539091cc	SE097	1	D	f	FM015	f	2022-08-09 15:20:39.327698	2022-08-09 15:20:39.327698
4dfc5a44-5303-480e-817c-ba46bdf1c960	SE097	1	I	f	FM015	f	2022-08-09 15:20:39.333392	2022-08-09 15:20:39.333392
7ddc7391-1a8e-4378-b82e-8a5298e5365e	SE097	1	W	f	FM015	f	2022-08-09 15:20:39.338794	2022-08-09 15:20:39.338794
29a310c6-2bd2-4835-9813-f955061c93b2	SE097	1	Z	f	FM015	f	2022-08-09 15:20:39.344485	2022-08-09 15:20:39.344485
2633e148-60e7-4be6-9931-918e45b817b2	SE097	1	A	t	FM019	f	2022-08-09 15:20:39.35074	2022-08-09 15:20:39.35074
874ba594-f2dd-49b2-a7cc-dad7fa2a9f4c	SE097	1	D	t	FM019	f	2022-08-09 15:20:39.356952	2022-08-09 15:20:39.356952
0e83052c-bffe-4cb5-9384-865d272cada0	SE097	1	I	t	FM019	f	2022-08-09 15:20:39.363373	2022-08-09 15:20:39.363373
07abd909-9067-4491-b01a-aee62eb77a48	SE097	1	W	t	FM019	f	2022-08-09 15:20:39.369829	2022-08-09 15:20:39.369829
2abed110-4586-4297-9fc2-e74be482ba12	SE097	1	Z	t	FM019	f	2022-08-09 15:20:39.375573	2022-08-09 15:20:39.375573
2a8b9e5a-f6d1-4e2f-b34a-a14b6e816616	SE097	1	A	f	FM019	f	2022-08-09 15:20:39.382166	2022-08-09 15:20:39.382166
50a34e42-1089-4f25-a8a7-3ab660dab94f	SE097	1	D	f	FM019	f	2022-08-09 15:20:39.390649	2022-08-09 15:20:39.390649
14e5ab4b-5f7e-40fd-baa8-44ba50f0a99e	SE097	1	I	f	FM019	f	2022-08-09 15:20:39.397447	2022-08-09 15:20:39.397447
cc4bde27-3fc0-457f-aeae-b0ab5bc587ba	SE097	1	W	f	FM019	f	2022-08-09 15:20:39.403587	2022-08-09 15:20:39.403587
675d977a-ee7d-4129-91de-37229a34a3ce	SE097	1	Z	f	FM019	f	2022-08-09 15:20:39.409828	2022-08-09 15:20:39.409828
6af6ed69-d4b9-4c38-99f8-380a833aa150	SE097	1	A	f	FM059	t	2022-08-09 15:20:39.419865	2022-08-09 15:20:39.45025
de95c21c-1668-4ffb-a676-965667d8c86f	SE097	1	D	f	FM059	t	2022-08-09 15:20:39.42529	2022-08-09 15:20:39.45782
20d1656d-6a64-4563-8f77-6f22b2230cc7	SE097	1	I	f	FM059	t	2022-08-09 15:20:39.431216	2022-08-09 15:20:39.465585
3b7a3df7-33d5-4e71-8fd5-fd66ea340fd4	SE097	1	W	f	FM059	t	2022-08-09 15:20:39.436796	2022-08-09 15:20:39.473093
36d278c0-2dd0-41fd-96e3-8c558de86b0d	SE097	1	Z	f	FM059	t	2022-08-09 15:20:39.442532	2022-08-09 15:20:39.480644
ca84ed9c-f961-45df-b6fd-2b8d248699c1	SE097	1	A	t	CV117	t	2022-08-09 15:20:39.063983	2022-08-09 15:20:39.488478
585a0538-1825-4a1a-a86a-ed4f19331e49	SE097	1	D	t	CV118	t	2022-08-09 15:20:39.128689	2022-08-09 15:20:39.495932
d677bffd-9b8c-4925-97f5-f35b1bada573	SE097	1	I	t	CV118	t	2022-08-09 15:20:39.135112	2022-08-09 15:20:39.503755
717df905-9e47-44f4-8be9-554debe5b246	SE097	1	W	t	CV118	t	2022-08-09 15:20:39.140552	2022-08-09 15:20:39.511961
5c4f0a00-c95d-4502-be95-f3d6414c6b92	SE097	1	Z	t	CV118	t	2022-08-09 15:20:39.146221	2022-08-09 15:20:39.520899
040c8b90-21a0-404f-b6c2-641ed04178bc	SE003	3	A	t	CV027	f	2022-08-09 15:20:39.527621	2022-08-09 15:20:39.527621
10642f22-200d-4d34-ba8e-f68fa65effa8	SE003	3	D	t	CV027	f	2022-08-09 15:20:39.534727	2022-08-09 15:20:39.534727
33f175a6-3249-4e9b-a691-2e6fa00f1745	SE003	3	I	t	CV027	f	2022-08-09 15:20:39.541747	2022-08-09 15:20:39.541747
ce5c4b0c-5f1d-4ada-b9e6-ba4747981b0d	SE003	3	W	t	CV027	f	2022-08-09 15:20:39.547822	2022-08-09 15:20:39.547822
84cec9a2-3dff-423a-992e-11d439609227	SE003	3	Z	t	CV027	f	2022-08-09 15:20:39.553507	2022-08-09 15:20:39.553507
5fd1aab2-e2f8-49d8-8343-ba3efce16289	SE003	3	A	f	CV027	f	2022-08-09 15:20:39.559027	2022-08-09 15:20:39.559027
7c065254-24e3-4949-8b88-84ee801b0c98	SE003	3	D	f	CV027	f	2022-08-09 15:20:39.564388	2022-08-09 15:20:39.564388
4054c38f-1932-4037-909b-20cfddb3ce91	SE003	3	I	f	CV027	f	2022-08-09 15:20:39.570255	2022-08-09 15:20:39.570255
5ed6e4da-64dc-4438-8454-bbf25953c7b6	SE003	3	W	f	CV027	f	2022-08-09 15:20:39.575662	2022-08-09 15:20:39.575662
a8f3153e-6c93-4115-924b-e34f4ccc5872	SE003	3	Z	f	CV027	f	2022-08-09 15:20:39.581659	2022-08-09 15:20:39.581659
239c88aa-60a9-4973-b437-2f77491a50d8	SE003	3	D	t	CV117	f	2022-08-09 15:20:39.593366	2022-08-09 15:20:39.593366
72177001-c571-4965-90de-da01cad519cd	SE003	3	I	t	CV117	f	2022-08-09 15:20:39.59954	2022-08-09 15:20:39.59954
ce5017a4-0ebe-4875-936c-3340b4d8e37d	SE003	3	W	t	CV117	f	2022-08-09 15:20:39.605321	2022-08-09 15:20:39.605321
47db4935-0e56-4be5-a3ff-cbe131126949	SE003	3	Z	t	CV117	f	2022-08-09 15:20:39.611297	2022-08-09 15:20:39.611297
4e8cd48a-984e-4d41-a845-afe193906507	SE003	3	A	f	CV117	f	2022-08-09 15:20:39.616878	2022-08-09 15:20:39.616878
a4e76508-4d07-4d66-b0fd-44ba0acd94d2	SE003	3	D	f	CV117	f	2022-08-09 15:20:39.622336	2022-08-09 15:20:39.622336
6c25371c-be99-48e8-bdcb-c812b3a44397	SE003	3	I	f	CV117	f	2022-08-09 15:20:39.628312	2022-08-09 15:20:39.628312
1889f853-28bc-4bb6-b5bc-e506eaeb8ccb	SE003	3	W	f	CV117	f	2022-08-09 15:20:39.633858	2022-08-09 15:20:39.633858
48550635-1952-4b63-a066-eb8b67c7e9f4	SE003	3	Z	f	CV117	f	2022-08-09 15:20:39.639368	2022-08-09 15:20:39.639368
205c719e-610d-4dbb-bf26-8f025d47d416	SE003	3	A	t	CV118	f	2022-08-09 15:20:39.645028	2022-08-09 15:20:39.645028
d4f6ff35-9d93-4109-b994-92d4c2f3970e	SE003	3	A	f	CV118	f	2022-08-09 15:20:39.673378	2022-08-09 15:20:39.673378
66c121cc-e9b6-48a6-85ef-aa751d9636ac	SE003	3	D	f	CV118	f	2022-08-09 15:20:39.67915	2022-08-09 15:20:39.67915
1fdc489c-0d06-48fe-9cd4-b4e190b6f4c9	SE003	3	I	f	CV118	f	2022-08-09 15:20:39.684423	2022-08-09 15:20:39.684423
c61cc5fa-84b4-455e-91e7-8a04b2ddf51c	SE003	3	W	f	CV118	f	2022-08-09 15:20:39.689977	2022-08-09 15:20:39.689977
6db9dab9-b11a-4780-b0b8-a6b0c1fd545a	SE003	3	Z	f	CV118	f	2022-08-09 15:20:39.695357	2022-08-09 15:20:39.695357
b2f54ecd-4cf4-442d-adf5-1f5dcb265e32	SE003	3	A	t	FM007	f	2022-08-09 15:20:39.700907	2022-08-09 15:20:39.700907
803a70eb-f41f-4f71-8a30-46aae640f580	SE003	3	D	t	FM007	f	2022-08-09 15:20:39.706334	2022-08-09 15:20:39.706334
fa593961-4b12-47aa-b8aa-5c52b393c9b3	SE003	3	I	t	FM007	f	2022-08-09 15:20:39.712089	2022-08-09 15:20:39.712089
33badf09-6d6b-4a43-a8d1-0d504042b5aa	SE003	3	W	t	FM007	f	2022-08-09 15:20:39.717507	2022-08-09 15:20:39.717507
458df0b6-c47f-4f9a-bd58-aaf563d325d5	SE003	3	Z	t	FM007	f	2022-08-09 15:20:39.723249	2022-08-09 15:20:39.723249
07521e95-7195-4309-86d2-a185ff526f0b	SE003	3	A	f	FM007	f	2022-08-09 15:20:39.730675	2022-08-09 15:20:39.730675
d78c3af5-ef6e-4d06-aac1-171c99246438	SE003	3	D	f	FM007	f	2022-08-09 15:20:39.736273	2022-08-09 15:20:39.736273
1f084625-fbd9-4316-9352-147e774009ac	SE003	3	I	f	FM007	f	2022-08-09 15:20:39.742169	2022-08-09 15:20:39.742169
af53538c-a396-488f-a8f6-c71610b95eeb	SE003	3	W	f	FM007	f	2022-08-09 15:20:39.747897	2022-08-09 15:20:39.747897
35705c3c-cef9-4e1f-92dc-bd41206678a7	SE003	3	Z	f	FM007	f	2022-08-09 15:20:39.753166	2022-08-09 15:20:39.753166
83fbd457-9e7a-4689-9f52-5192b42b577f	SE003	3	A	t	FM019	f	2022-08-09 15:20:39.758914	2022-08-09 15:20:39.758914
f3fa1d33-fde8-488b-a353-91d2a55d59ed	SE003	3	D	t	FM019	f	2022-08-09 15:20:39.764401	2022-08-09 15:20:39.764401
4c91c995-5857-4ac6-ac9c-33e1472fed3a	SE003	3	I	t	FM019	f	2022-08-09 15:20:39.770169	2022-08-09 15:20:39.770169
3d9b1cb2-2dca-4614-899e-cf722673fb63	SE003	3	W	t	FM019	f	2022-08-09 15:20:39.775589	2022-08-09 15:20:39.775589
9eeb98fb-148e-4e22-a94f-829d8057bce4	SE003	3	Z	t	FM019	f	2022-08-09 15:20:39.781323	2022-08-09 15:20:39.781323
ec974eea-1ad7-4897-962a-0bfcaac623a8	SE003	3	A	f	FM019	f	2022-08-09 15:20:39.786688	2022-08-09 15:20:39.786688
30e4a509-96ed-420b-bf3b-54237706463a	SE003	3	D	f	FM019	f	2022-08-09 15:20:39.792445	2022-08-09 15:20:39.792445
b2252f50-e3ae-4a0d-a86d-7ede583c7838	SE003	3	I	f	FM019	f	2022-08-09 15:20:39.798037	2022-08-09 15:20:39.798037
07702f18-c978-405d-a6e5-aa7df6cd47ed	SE003	3	W	f	FM019	f	2022-08-09 15:20:39.803793	2022-08-09 15:20:39.803793
8d035224-4370-455d-a779-46ed54ecc11a	SE003	3	Z	f	FM019	f	2022-08-09 15:20:39.809656	2022-08-09 15:20:39.809656
af149cd4-0c1d-4b05-927f-7e829571c157	SE003	3	A	t	FM039	f	2022-08-09 15:20:39.816442	2022-08-09 15:20:39.816442
5a5f9f3a-1c2f-4165-93ed-c243ecc67023	SE003	3	D	t	FM039	f	2022-08-09 15:20:39.822852	2022-08-09 15:20:39.822852
78899c7e-0838-4e70-b1d9-b02bea486517	SE003	3	I	t	FM039	f	2022-08-09 15:20:39.82929	2022-08-09 15:20:39.82929
df836345-a8ef-46c1-a67d-4ed0e0c8497b	SE003	3	W	t	FM039	f	2022-08-09 15:20:39.836395	2022-08-09 15:20:39.836395
d9d37eab-b1c3-459b-95c9-2f19cac0d93f	SE003	3	Z	t	FM039	f	2022-08-09 15:20:39.842801	2022-08-09 15:20:39.842801
bae7ae18-929c-4def-a2ba-54f754ab19d0	SE003	3	A	f	FM039	f	2022-08-09 15:20:39.848782	2022-08-09 15:20:39.848782
d5ae4d1f-df63-4756-b73d-1b29c65d1f99	SE003	3	D	f	FM039	f	2022-08-09 15:20:39.854472	2022-08-09 15:20:39.854472
03f88ab9-eef7-4dfe-915a-143449cdab5a	SE003	3	I	f	FM039	f	2022-08-09 15:20:39.860046	2022-08-09 15:20:39.860046
ef3e7390-701c-4b30-8662-eb3e60aff152	SE003	3	W	f	FM039	f	2022-08-09 15:20:39.866356	2022-08-09 15:20:39.866356
f3e3261e-9a66-492b-a292-f5fd00e62bd3	SE003	3	Z	f	FM039	f	2022-08-09 15:20:39.871804	2022-08-09 15:20:39.871804
812b8b27-23b8-4e6e-9197-efc5cffc3ea3	SE003	3	A	t	FM049	f	2022-08-09 15:20:39.877456	2022-08-09 15:20:39.877456
673ba5d8-f2d9-4e91-9d5a-4b8b40087d27	SE003	3	D	t	FM049	f	2022-08-09 15:20:39.882815	2022-08-09 15:20:39.882815
da6508e3-82f0-417c-988a-1c3a5ae078e8	SE003	3	I	t	FM049	f	2022-08-09 15:20:39.888117	2022-08-09 15:20:39.888117
5f144fe7-b950-48a6-9770-a16fff0a4ba7	SE003	3	W	t	FM049	f	2022-08-09 15:20:39.893639	2022-08-09 15:20:39.893639
599a1a20-c7f7-4f11-9e7d-ac0e2c4c44b7	SE003	3	Z	t	FM049	f	2022-08-09 15:20:39.899202	2022-08-09 15:20:39.899202
c342b3a4-43da-4d83-bdcb-302f8224d596	SE003	3	A	f	FM049	t	2022-08-09 15:20:39.904531	2022-08-09 15:20:39.934801
7832d400-92a7-4627-a49e-14ef6712e642	SE003	3	D	f	FM049	t	2022-08-09 15:20:39.910384	2022-08-09 15:20:39.942041
2fa9d9dc-0a1b-4f25-b620-7a6b4f5c0e1b	SE003	3	I	f	FM049	t	2022-08-09 15:20:39.915666	2022-08-09 15:20:39.949543
fa861cf0-6f23-42ce-b8bc-4137d73f706d	SE003	3	W	f	FM049	t	2022-08-09 15:20:39.921223	2022-08-09 15:20:39.957167
dfd3529d-ad92-44af-aa5b-df843db475a3	SE003	3	Z	f	FM049	t	2022-08-09 15:20:39.927037	2022-08-09 15:20:39.964852
9de05192-bdf0-4ad1-b391-599705c68d7f	SE003	3	A	t	CV117	t	2022-08-09 15:20:39.588045	2022-08-09 15:20:39.971908
0c6deb98-bb6a-4eaf-a6a4-913bd6de8209	SE003	3	D	t	CV118	t	2022-08-09 15:20:39.650528	2022-08-09 15:20:39.979615
6f9aac76-a451-4d0d-b6d3-be63991aa4db	SE003	3	I	t	CV118	t	2022-08-09 15:20:39.655865	2022-08-09 15:20:39.987341
c8d025e8-a8f2-4c55-8589-acf6bed31924	SE003	3	W	t	CV118	t	2022-08-09 15:20:39.662012	2022-08-09 15:20:39.995004
2caeafbc-dad5-4cd3-bc29-434ceaf2c383	SE003	3	Z	t	CV118	t	2022-08-09 15:20:39.667846	2022-08-09 15:20:40.002718
2a901369-97c4-4110-b33e-cfdf2b9f88cf	SE004	3	A	t	CV027	f	2022-08-09 15:20:40.008976	2022-08-09 15:20:40.008976
ddf2f6d9-4b59-45b5-885a-eea3274a6ed6	SE004	3	D	t	CV027	f	2022-08-09 15:20:40.014453	2022-08-09 15:20:40.014453
b5c95eea-cf4f-47e5-830a-5e8213729dfa	SE004	3	I	t	CV027	f	2022-08-09 15:20:40.019824	2022-08-09 15:20:40.019824
e1f1452d-478a-4c11-b344-dc92d099b39a	SE004	3	W	t	CV027	f	2022-08-09 15:20:40.02546	2022-08-09 15:20:40.02546
50e93f56-07ac-4b1f-b999-5699928e4cb4	SE004	3	Z	t	CV027	f	2022-08-09 15:20:40.031248	2022-08-09 15:20:40.031248
ed0bf8d4-7329-4508-aab0-a6486bf02bdc	SE004	3	A	f	CV027	f	2022-08-09 15:20:40.036922	2022-08-09 15:20:40.036922
7ab2d122-9324-441c-a90e-ede776ac66a0	SE004	3	D	f	CV027	f	2022-08-09 15:20:40.042267	2022-08-09 15:20:40.042267
0011f724-f922-4764-be8c-0b19b1d7c2df	SE004	3	I	f	CV027	f	2022-08-09 15:20:40.048056	2022-08-09 15:20:40.048056
1ab9a28d-6443-4fdf-a2b0-853fb4ae5146	SE004	3	W	f	CV027	f	2022-08-09 15:20:40.053405	2022-08-09 15:20:40.053405
7d07c4e2-0e60-4b27-aa63-31a1afb24ae3	SE004	3	Z	f	CV027	f	2022-08-09 15:20:40.060103	2022-08-09 15:20:40.060103
b143df09-1494-4e18-a39a-372cae9c0a1b	SE004	3	D	t	CV117	f	2022-08-09 15:20:40.071921	2022-08-09 15:20:40.071921
3ed9ba49-7949-4cff-9aba-385568326293	SE004	3	I	t	CV117	f	2022-08-09 15:20:40.077983	2022-08-09 15:20:40.077983
acd8d36b-227c-45b8-8b35-1b4104c902d1	SE004	3	W	t	CV117	f	2022-08-09 15:20:40.08528	2022-08-09 15:20:40.08528
fb8d1c55-e6e9-4473-9916-2dfe320b0f05	SE004	3	Z	t	CV117	f	2022-08-09 15:20:40.091036	2022-08-09 15:20:40.091036
1f3275b8-fe20-4cd6-9626-cb9afeacd81d	SE004	3	A	f	CV117	f	2022-08-09 15:20:40.096952	2022-08-09 15:20:40.096952
079f20c0-b3e1-467f-9340-25971449bd88	SE004	3	D	f	CV117	f	2022-08-09 15:20:40.103001	2022-08-09 15:20:40.103001
50002b93-972c-42ee-a6ab-ae56081b59c2	SE004	3	I	f	CV117	f	2022-08-09 15:20:40.10858	2022-08-09 15:20:40.10858
e345e95f-02a3-441a-b2ae-c61de6e6c72e	SE004	3	W	f	CV117	f	2022-08-09 15:20:40.114238	2022-08-09 15:20:40.114238
28162fec-8982-4959-934d-a6b234bfca2b	SE004	3	Z	f	CV117	f	2022-08-09 15:20:40.119681	2022-08-09 15:20:40.119681
60dc8913-67c5-488c-984e-816118316eec	SE004	3	A	t	CV118	f	2022-08-09 15:20:40.125731	2022-08-09 15:20:40.125731
808cfc48-89f4-42e7-8591-a35b26dfcb1d	SE004	3	A	f	CV118	f	2022-08-09 15:20:40.155189	2022-08-09 15:20:40.155189
830ab5fc-24e4-449f-957b-d89278ff8fbb	SE004	3	D	f	CV118	f	2022-08-09 15:20:40.160687	2022-08-09 15:20:40.160687
6b08fd79-5605-4423-8140-9ca2c2644525	SE004	3	I	f	CV118	f	2022-08-09 15:20:40.16667	2022-08-09 15:20:40.16667
bbfda0f2-2010-48c3-9ff0-8526628f2d5d	SE004	3	W	f	CV118	f	2022-08-09 15:20:40.172625	2022-08-09 15:20:40.172625
27caacf2-0edf-458f-aa0d-483e5d7cde11	SE004	3	Z	f	CV118	f	2022-08-09 15:20:40.178079	2022-08-09 15:20:40.178079
e016d964-aa14-4c06-9b9c-330885f55fad	SE004	3	A	t	FM007	f	2022-08-09 15:20:40.184414	2022-08-09 15:20:40.184414
c0d31727-b4e3-45ce-b306-d3f43bab62f1	SE004	3	D	t	FM007	f	2022-08-09 15:20:40.190636	2022-08-09 15:20:40.190636
a60d0648-7455-4ca4-9621-11affbb1c631	SE004	3	I	t	FM007	f	2022-08-09 15:20:40.196429	2022-08-09 15:20:40.196429
51e4b3a7-17f4-428c-ab54-282d3dcf25ad	SE004	3	W	t	FM007	f	2022-08-09 15:20:40.202538	2022-08-09 15:20:40.202538
6d735c10-fb98-419d-ac94-7e3c4a6ac771	SE004	3	Z	t	FM007	f	2022-08-09 15:20:40.208677	2022-08-09 15:20:40.208677
135c76c0-92e1-45b5-a990-00518a470634	SE004	3	A	f	FM007	f	2022-08-09 15:20:40.214719	2022-08-09 15:20:40.214719
572e8c19-e0c0-4894-a098-c6d2ff46eb35	SE004	3	D	f	FM007	f	2022-08-09 15:20:40.220259	2022-08-09 15:20:40.220259
229e490f-68d4-49e4-b910-539a58087508	SE004	3	I	f	FM007	f	2022-08-09 15:20:40.225923	2022-08-09 15:20:40.225923
dd8fefcf-3099-48e4-a607-c55427364e9c	SE004	3	W	f	FM007	f	2022-08-09 15:20:40.231817	2022-08-09 15:20:40.231817
3327d5c1-6a16-49cf-aa4a-2b528ad06ed4	SE004	3	Z	f	FM007	f	2022-08-09 15:20:40.237323	2022-08-09 15:20:40.237323
baa1bac6-6c29-47b0-bc12-e6319b2c30bb	SE004	3	A	t	FM019	f	2022-08-09 15:20:40.243205	2022-08-09 15:20:40.243205
f2a43ba3-5818-48c4-a1f8-8ce36f5f212d	SE004	3	D	t	FM019	f	2022-08-09 15:20:40.248541	2022-08-09 15:20:40.248541
358775c7-65aa-4462-83a0-6954daed7fd9	SE004	3	I	t	FM019	f	2022-08-09 15:20:40.254144	2022-08-09 15:20:40.254144
8d689d8b-67c3-4e54-8046-a0cd121657e0	SE004	3	W	t	FM019	f	2022-08-09 15:20:40.260162	2022-08-09 15:20:40.260162
724f75cf-e3cf-40bb-b783-41e17ee10591	SE004	3	Z	t	FM019	f	2022-08-09 15:20:40.265604	2022-08-09 15:20:40.265604
ae9a364c-8aca-4738-a59b-0c9caae71e89	SE004	3	A	f	FM019	f	2022-08-09 15:20:40.271235	2022-08-09 15:20:40.271235
ab075fda-3c5f-409c-836f-13f288fdefc1	SE004	3	D	f	FM019	f	2022-08-09 15:20:40.276716	2022-08-09 15:20:40.276716
f6d4700a-6e6a-4c80-8eea-8ca27b826e20	SE004	3	I	f	FM019	f	2022-08-09 15:20:40.2821	2022-08-09 15:20:40.2821
86428d69-e815-4653-bcb4-c75585426aca	SE004	3	W	f	FM019	f	2022-08-09 15:20:40.287679	2022-08-09 15:20:40.287679
cb2a1859-4f66-4e70-b915-3133a4758878	SE004	3	Z	f	FM019	f	2022-08-09 15:20:40.293124	2022-08-09 15:20:40.293124
44aa3eb8-e187-4fa2-843a-eafe6acd4533	SE004	3	A	t	FM039	f	2022-08-09 15:20:40.298533	2022-08-09 15:20:40.298533
4b6e830d-372d-4637-af02-02bc5ada9ff1	SE004	3	D	t	FM039	f	2022-08-09 15:20:40.305377	2022-08-09 15:20:40.305377
0cc176d9-b433-4f82-ace2-910a35ee26ac	SE004	3	I	t	FM039	f	2022-08-09 15:20:40.311996	2022-08-09 15:20:40.311996
48dc9d65-aeca-4a65-8374-54d68d821aa6	SE004	3	W	t	FM039	f	2022-08-09 15:20:40.317796	2022-08-09 15:20:40.317796
f29d1e31-2a61-4d2f-b816-52dc26e33106	SE004	3	Z	t	FM039	f	2022-08-09 15:20:40.323547	2022-08-09 15:20:40.323547
fdb9d651-e5c6-4894-ae87-dbae4a5eccab	SE004	3	A	f	FM039	f	2022-08-09 15:20:40.329504	2022-08-09 15:20:40.329504
41f4507a-a069-4bd9-af08-208483506094	SE004	3	D	f	FM039	f	2022-08-09 15:20:40.335411	2022-08-09 15:20:40.335411
c4840cc6-b728-4d73-8465-4c167b061a8c	SE004	3	I	f	FM039	f	2022-08-09 15:20:40.340738	2022-08-09 15:20:40.340738
9cbc5c87-905a-40fc-929a-1d9268fe49f7	SE004	3	W	f	FM039	f	2022-08-09 15:20:40.346182	2022-08-09 15:20:40.346182
b3ff4f57-2aa8-4e29-9c0b-f8e955ec74f4	SE004	3	Z	f	FM039	f	2022-08-09 15:20:40.35317	2022-08-09 15:20:40.35317
827cb266-de8c-4b08-8520-4dc085a32c57	SE004	3	A	t	FM049	f	2022-08-09 15:20:40.359052	2022-08-09 15:20:40.359052
8989bf51-b2a5-46f3-810f-c7ac3f5191cc	SE004	3	D	t	FM049	f	2022-08-09 15:20:40.36582	2022-08-09 15:20:40.36582
dd565310-2673-46db-a27f-022de6dc2ecd	SE004	3	I	t	FM049	f	2022-08-09 15:20:40.371695	2022-08-09 15:20:40.371695
58bd2231-9c9a-476f-aea2-6e72561d2f87	SE004	3	W	t	FM049	f	2022-08-09 15:20:40.377868	2022-08-09 15:20:40.377868
b59b305f-ab1b-448c-a141-c6497209c29f	SE004	3	Z	t	FM049	f	2022-08-09 15:20:40.38446	2022-08-09 15:20:40.38446
e76bdd89-4626-4294-a561-1407143aa9cb	SE004	3	A	f	FM049	t	2022-08-09 15:20:40.390412	2022-08-09 15:20:40.424621
4a53faf0-f064-4310-9d42-7a7e8451b302	SE004	3	D	f	FM049	t	2022-08-09 15:20:40.396028	2022-08-09 15:20:40.432573
20cf6c69-e083-48f5-bda0-b410ddd45615	SE004	3	I	f	FM049	t	2022-08-09 15:20:40.403152	2022-08-09 15:20:40.440272
6f28e296-cbf1-4097-8041-81927d0e6cdb	SE004	3	W	f	FM049	t	2022-08-09 15:20:40.410628	2022-08-09 15:20:40.448149
6a3a6c32-272d-40d9-8b7e-1336ba49f14d	SE004	3	Z	f	FM049	t	2022-08-09 15:20:40.41679	2022-08-09 15:20:40.45613
631641cd-ff61-46dc-b884-9b4ea2f7edc0	SE004	3	A	t	CV117	t	2022-08-09 15:20:40.065698	2022-08-09 15:20:40.463725
37524eae-8282-45e1-a2b6-fe9ee682f889	SE004	3	D	t	CV118	t	2022-08-09 15:20:40.131984	2022-08-09 15:20:40.47169
ee7d723c-6bc5-4381-a6ac-91cc25dddc02	SE004	3	I	t	CV118	t	2022-08-09 15:20:40.138171	2022-08-09 15:20:40.47923
37c2114f-3978-4cd1-b623-b104381eca01	SE004	3	W	t	CV118	t	2022-08-09 15:20:40.144099	2022-08-09 15:20:40.487392
af547085-f7a0-49cb-9600-020ddcf2f220	SE004	3	Z	t	CV118	t	2022-08-09 15:20:40.149368	2022-08-09 15:20:40.495596
b2baf4ee-47ca-46dd-85a1-c6663339e229	SE007	3	A	t	CV027	f	2022-08-09 15:20:40.501429	2022-08-09 15:20:40.501429
cb7a1682-ef6c-408c-ad0a-4c6909fea69e	SE007	3	D	t	CV027	f	2022-08-09 15:20:40.507229	2022-08-09 15:20:40.507229
3dcd5e1d-16a2-48f6-ab06-d3b96fcd9635	SE007	3	I	t	CV027	f	2022-08-09 15:20:40.513503	2022-08-09 15:20:40.513503
55cdecfd-681d-45a7-9748-7817a88da6f7	SE007	3	W	t	CV027	f	2022-08-09 15:20:40.519145	2022-08-09 15:20:40.519145
a5ba9859-ef73-4383-b2c4-6e4e9036d06c	SE007	3	Z	t	CV027	f	2022-08-09 15:20:40.525182	2022-08-09 15:20:40.525182
fea49acc-84f1-4a4d-a8b8-3eb692fafbf4	SE007	3	A	f	CV027	f	2022-08-09 15:20:40.534746	2022-08-09 15:20:40.534746
f4af2969-7c44-49ed-8f00-c467e1f6bfd3	SE007	3	D	f	CV027	f	2022-08-09 15:20:40.542292	2022-08-09 15:20:40.542292
066bf89f-56de-41ac-a550-ff25785c797c	SE007	3	I	f	CV027	f	2022-08-09 15:20:40.549877	2022-08-09 15:20:40.549877
2b037499-f7fa-4fb3-a140-d8d0987606e2	SE007	3	W	f	CV027	f	2022-08-09 15:20:40.55596	2022-08-09 15:20:40.55596
6144c7fe-d3ba-4f98-855a-ea73a4203ed3	SE007	3	Z	f	CV027	f	2022-08-09 15:20:40.56217	2022-08-09 15:20:40.56217
362e51be-e72a-414b-a88c-95d3a2507eba	SE007	3	D	t	CV117	f	2022-08-09 15:20:40.573844	2022-08-09 15:20:40.573844
de197ab4-e3ef-407a-8f55-35889873384f	SE007	3	I	t	CV117	f	2022-08-09 15:20:40.582194	2022-08-09 15:20:40.582194
7164f8ce-53c5-4f5f-952e-768b14331cbd	SE007	3	W	t	CV117	f	2022-08-09 15:20:40.589128	2022-08-09 15:20:40.589128
bf4b7bd7-a4ad-450b-b8bb-a95aaba63285	SE007	3	Z	t	CV117	f	2022-08-09 15:20:40.601589	2022-08-09 15:20:40.601589
d9dba896-6969-45df-ab5d-87fdd5e69aba	SE007	3	A	f	CV117	f	2022-08-09 15:20:40.630658	2022-08-09 15:20:40.630658
c235eaee-8da9-43aa-9027-ae52e540cf75	SE007	3	D	f	CV117	f	2022-08-09 15:20:40.639415	2022-08-09 15:20:40.639415
c22ab056-ab51-49d0-9a94-6bd265b72c29	SE007	3	I	f	CV117	f	2022-08-09 15:20:40.646075	2022-08-09 15:20:40.646075
393d26cf-4668-4d41-abb4-686de4646f92	SE007	3	W	f	CV117	f	2022-08-09 15:20:40.652869	2022-08-09 15:20:40.652869
be63ccdf-fbde-4f00-b8de-c2c36932a117	SE007	3	Z	f	CV117	f	2022-08-09 15:20:40.659909	2022-08-09 15:20:40.659909
4ad55fb4-5525-4384-a0bc-810ea957bd4c	SE007	3	A	t	CV118	f	2022-08-09 15:20:40.667146	2022-08-09 15:20:40.667146
0b8e58b8-365a-41cf-af03-0a4638d3d64f	SE007	3	A	f	CV118	f	2022-08-09 15:20:40.696728	2022-08-09 15:20:40.696728
911c0596-fc80-41d1-be91-276fce728d72	SE007	3	D	f	CV118	f	2022-08-09 15:20:40.702325	2022-08-09 15:20:40.702325
ab5391db-c1a8-4c09-97ec-b24c177f094d	SE007	3	I	f	CV118	f	2022-08-09 15:20:40.707836	2022-08-09 15:20:40.707836
88752c66-22da-49cc-9e66-7155d70609be	SE007	3	W	f	CV118	f	2022-08-09 15:20:40.71346	2022-08-09 15:20:40.71346
4e23e510-ad0d-40c7-912d-b18b262c275c	SE007	3	Z	f	CV118	f	2022-08-09 15:20:40.718922	2022-08-09 15:20:40.718922
db8e5fc2-32aa-4ce6-bec0-64ffa234456d	SE007	3	A	t	FM007	f	2022-08-09 15:20:40.724231	2022-08-09 15:20:40.724231
5440ebb0-a8f1-408b-8e71-adeba2bb50a6	SE007	3	D	t	FM007	f	2022-08-09 15:20:40.730201	2022-08-09 15:20:40.730201
17f8e257-a714-41c1-a8b3-5bea8033e93b	SE007	3	I	t	FM007	f	2022-08-09 15:20:40.735639	2022-08-09 15:20:40.735639
2185bcb0-4e4f-4b7c-a02a-c5e6cb33022e	SE007	3	W	t	FM007	f	2022-08-09 15:20:40.740983	2022-08-09 15:20:40.740983
c1d4d934-e0d6-4a59-9c3d-bf00b58fc015	SE007	3	Z	t	FM007	f	2022-08-09 15:20:40.747162	2022-08-09 15:20:40.747162
c86fa59a-c79c-4cf6-9305-8d83d33249e9	SE007	3	A	f	FM007	f	2022-08-09 15:20:40.75243	2022-08-09 15:20:40.75243
75adf3ee-505c-4106-8eb3-e9ff1f3d8b06	SE007	3	D	f	FM007	f	2022-08-09 15:20:40.75824	2022-08-09 15:20:40.75824
ce42b11e-b293-47c4-a84a-58439cba7890	SE007	3	I	f	FM007	f	2022-08-09 15:20:40.763609	2022-08-09 15:20:40.763609
28c6a541-5bfc-4c89-a0b4-6e7e55eb123b	SE007	3	W	f	FM007	f	2022-08-09 15:20:40.770475	2022-08-09 15:20:40.770475
5b52b7c9-1538-4cce-9629-f061f5c5dc3c	SE007	3	Z	f	FM007	f	2022-08-09 15:20:40.776494	2022-08-09 15:20:40.776494
02afe9b2-dfb4-4a28-b006-d70b42fd1ed1	SE007	3	A	t	FM019	f	2022-08-09 15:20:40.782419	2022-08-09 15:20:40.782419
b5bd322c-2b6a-452b-8c49-af46358c66f4	SE007	3	D	t	FM019	f	2022-08-09 15:20:40.787762	2022-08-09 15:20:40.787762
44c42987-2f23-45fe-86c8-c29f4e9c5cf6	SE007	3	I	t	FM019	f	2022-08-09 15:20:40.79472	2022-08-09 15:20:40.79472
ff21e509-ca9c-42b2-a504-86375e88e60e	SE007	3	W	t	FM019	f	2022-08-09 15:20:40.800363	2022-08-09 15:20:40.800363
50ddf05d-fa8f-4ced-b7ff-28e4ec0a5ca6	SE007	3	Z	t	FM019	f	2022-08-09 15:20:40.806249	2022-08-09 15:20:40.806249
2be3de60-ede7-4a9e-b40d-b58bbb5f79e2	SE007	3	A	f	FM019	f	2022-08-09 15:20:40.811739	2022-08-09 15:20:40.811739
d33a139a-7af4-4ddd-9429-b221a8c4e49f	SE007	3	D	f	FM019	f	2022-08-09 15:20:40.817524	2022-08-09 15:20:40.817524
1da994e9-9422-47aa-8e17-8e6c23051870	SE007	3	I	f	FM019	f	2022-08-09 15:20:40.823073	2022-08-09 15:20:40.823073
f40b67e0-346a-4793-a6f7-beb11686f474	SE007	3	W	f	FM019	f	2022-08-09 15:20:40.828971	2022-08-09 15:20:40.828971
cb19b238-3808-43b7-a946-179c793eccc8	SE007	3	Z	f	FM019	f	2022-08-09 15:20:40.834766	2022-08-09 15:20:40.834766
ce1380d6-eb91-4ac3-86d1-d24347941086	SE007	3	A	t	FM039	f	2022-08-09 15:20:40.840239	2022-08-09 15:20:40.840239
9dd9bec6-b52b-4efc-a42d-40be1dbcb62f	SE007	3	D	t	FM039	f	2022-08-09 15:20:40.845837	2022-08-09 15:20:40.845837
73affdfb-bd29-4b76-bb17-ad4eddcfdfee	SE007	3	I	t	FM039	f	2022-08-09 15:20:40.851349	2022-08-09 15:20:40.851349
d424e0b6-023c-4aef-acc5-d0b58dac729c	SE007	3	W	t	FM039	f	2022-08-09 15:20:40.856797	2022-08-09 15:20:40.856797
deebe9e6-4e06-41b1-b6d2-5272367bf255	SE007	3	Z	t	FM039	f	2022-08-09 15:20:40.862498	2022-08-09 15:20:40.862498
4ea59ee4-2297-443e-821e-ba133939160f	SE007	3	A	f	FM039	f	2022-08-09 15:20:40.867816	2022-08-09 15:20:40.867816
b693dfab-03c0-46f3-8fff-a4363d718948	SE007	3	D	f	FM039	f	2022-08-09 15:20:40.873466	2022-08-09 15:20:40.873466
927186d6-6540-458e-8641-7b62a2610545	SE007	3	I	f	FM039	f	2022-08-09 15:20:40.878748	2022-08-09 15:20:40.878748
a393b36b-9882-4fb9-a6ce-83385142aace	SE007	3	W	f	FM039	f	2022-08-09 15:20:40.884319	2022-08-09 15:20:40.884319
d1f77ad5-8b5f-4a7b-845e-699f76b8a9da	SE007	3	Z	f	FM039	f	2022-08-09 15:20:40.889684	2022-08-09 15:20:40.889684
449f60df-c8be-46ef-9a55-03058ba7dd70	SE007	3	A	t	FM049	f	2022-08-09 15:20:40.895337	2022-08-09 15:20:40.895337
82b46a0c-b502-4280-85a3-479d11550a00	SE007	3	D	t	FM049	f	2022-08-09 15:20:40.900581	2022-08-09 15:20:40.900581
fa6445ae-9ea3-485b-8ced-71498e632dd0	SE007	3	I	t	FM049	f	2022-08-09 15:20:40.906078	2022-08-09 15:20:40.906078
a6af2e7b-a417-4268-86f8-ea46023b48dd	SE007	3	W	t	FM049	f	2022-08-09 15:20:40.911966	2022-08-09 15:20:40.911966
9c922fae-f2bf-470f-8e55-16b9b246112c	SE007	3	Z	t	FM049	f	2022-08-09 15:20:40.917406	2022-08-09 15:20:40.917406
1a2f89ac-b7a0-4448-932a-f3640cc661c2	SE007	3	A	f	FM049	t	2022-08-09 15:20:40.922885	2022-08-09 15:20:40.953362
fb6a094f-a2dd-4648-bb04-276191c970eb	SE007	3	D	f	FM049	t	2022-08-09 15:20:40.928885	2022-08-09 15:20:40.960995
4d921304-751d-4cfe-9482-49b20da94bb1	SE007	3	I	f	FM049	t	2022-08-09 15:20:40.934327	2022-08-09 15:20:40.968201
d0b420be-04ff-49b6-bb4a-825e0f835bd6	SE007	3	W	f	FM049	t	2022-08-09 15:20:40.940181	2022-08-09 15:20:40.97577
9b7e068e-5921-487d-b8f1-335e9d16d797	SE007	3	Z	f	FM049	t	2022-08-09 15:20:40.945608	2022-08-09 15:20:40.983541
b947998f-8fac-4214-b49f-b1dbcd0e3abc	SE007	3	A	t	CV117	t	2022-08-09 15:20:40.568013	2022-08-09 15:20:40.991026
677ab8b7-cc06-456c-be50-85be34757c34	SE007	3	D	t	CV118	t	2022-08-09 15:20:40.67373	2022-08-09 15:20:40.998635
338206b8-a134-4148-95bd-078a89025242	SE007	3	I	t	CV118	t	2022-08-09 15:20:40.679715	2022-08-09 15:20:41.006335
2e39a4f8-4b65-49ff-b7a1-a751258161b9	SE007	3	W	t	CV118	t	2022-08-09 15:20:40.685441	2022-08-09 15:20:41.013963
c477fb0d-9caf-4305-9797-f8f6536e6d29	SE007	3	Z	t	CV118	t	2022-08-09 15:20:40.690883	2022-08-09 15:20:41.021329
64d78c9f-eea4-40b4-beaa-a6f5a5181f29	SE008	3	A	t	CV027	f	2022-08-09 15:20:41.027312	2022-08-09 15:20:41.027312
e06a346d-ed48-4883-9e64-fee78483c6e3	SE008	3	D	t	CV027	f	2022-08-09 15:20:41.032751	2022-08-09 15:20:41.032751
20eb6d89-f809-447c-95e7-a449e2e1ea5a	SE008	3	I	t	CV027	f	2022-08-09 15:20:41.038371	2022-08-09 15:20:41.038371
e47d5e99-c7ba-4f3b-a176-faa64bdd0be2	SE008	3	W	t	CV027	f	2022-08-09 15:20:41.044067	2022-08-09 15:20:41.044067
eefdce11-39d3-4d4b-8efd-a274beab8656	SE008	3	Z	t	CV027	f	2022-08-09 15:20:41.049656	2022-08-09 15:20:41.049656
56a4f2ff-2bef-46e9-bc46-724c80c299f8	SE008	3	A	f	CV027	f	2022-08-09 15:20:41.055644	2022-08-09 15:20:41.055644
a1288863-b1b6-4382-b782-9116b9b6c6c4	SE008	3	D	f	CV027	f	2022-08-09 15:20:41.061185	2022-08-09 15:20:41.061185
136025a0-1af9-4796-a113-0abf896198d9	SE008	3	I	f	CV027	f	2022-08-09 15:20:41.0666	2022-08-09 15:20:41.0666
1c36d5e4-c994-4ac4-990a-1621a1e8bb41	SE008	3	W	f	CV027	f	2022-08-09 15:20:41.072191	2022-08-09 15:20:41.072191
ece7f13b-02f3-4327-9319-4c37fb7eb004	SE008	3	Z	f	CV027	f	2022-08-09 15:20:41.077549	2022-08-09 15:20:41.077549
d2ca0bd4-2419-402e-b0e0-fcf0ed3635d0	SE008	3	D	t	CV117	f	2022-08-09 15:20:41.088986	2022-08-09 15:20:41.088986
cd8fba3a-55c9-4427-8bfd-acd6eb677412	SE008	3	I	t	CV117	f	2022-08-09 15:20:41.095669	2022-08-09 15:20:41.095669
249941d6-b7bb-4aa9-8051-d34e951ed6c6	SE008	3	W	t	CV117	f	2022-08-09 15:20:41.101549	2022-08-09 15:20:41.101549
90bbb478-d7dc-43b6-9a36-4f1b75e89c8f	SE008	3	Z	t	CV117	f	2022-08-09 15:20:41.107205	2022-08-09 15:20:41.107205
28ad1973-d9fc-4299-8cfc-a86e0cdb9fa4	SE008	3	A	f	CV117	f	2022-08-09 15:20:41.113093	2022-08-09 15:20:41.113093
8b33c999-91a1-46ad-93f6-605e5fce41d1	SE008	3	D	f	CV117	f	2022-08-09 15:20:41.118854	2022-08-09 15:20:41.118854
6702f45e-e955-489d-8dfd-3ed89a29976f	SE008	3	I	f	CV117	f	2022-08-09 15:20:41.12604	2022-08-09 15:20:41.12604
c109bea4-54e3-4191-a662-bf887110f617	SE008	3	W	f	CV117	f	2022-08-09 15:20:41.131592	2022-08-09 15:20:41.131592
0a936830-4a87-4354-b4ad-eaa841807509	SE008	3	Z	f	CV117	f	2022-08-09 15:20:41.137481	2022-08-09 15:20:41.137481
45cb7f03-2b84-4760-8ecb-15adadc1304c	SE008	3	A	t	CV118	f	2022-08-09 15:20:41.143394	2022-08-09 15:20:41.143394
b277511e-d17e-49d5-893e-fcc593c76d11	SE008	3	A	f	CV118	f	2022-08-09 15:20:41.172245	2022-08-09 15:20:41.172245
8dccb476-32ab-4211-ab92-c9b61df124fd	SE008	3	D	f	CV118	f	2022-08-09 15:20:41.179241	2022-08-09 15:20:41.179241
f4bae765-de23-4ed3-b370-550bdb276227	SE008	3	I	f	CV118	f	2022-08-09 15:20:41.185038	2022-08-09 15:20:41.185038
99ca8ca6-65b5-4b80-b81b-7247196fa22a	SE008	3	W	f	CV118	f	2022-08-09 15:20:41.190894	2022-08-09 15:20:41.190894
efab553e-75db-4929-a884-081faf547b90	SE008	3	Z	f	CV118	f	2022-08-09 15:20:41.1963	2022-08-09 15:20:41.1963
9df8e53c-8066-4646-b06b-97a9e0a17df1	SE008	3	A	t	FM007	f	2022-08-09 15:20:41.201965	2022-08-09 15:20:41.201965
e61195a8-82a6-4f7d-a96b-3899f52e014c	SE008	3	D	t	FM007	f	2022-08-09 15:20:41.207363	2022-08-09 15:20:41.207363
2ee80e5f-d947-4bfe-a30b-f8e72548e7c1	SE008	3	I	t	FM007	f	2022-08-09 15:20:41.213131	2022-08-09 15:20:41.213131
d7c18904-5aae-471d-aa1f-7ae214af0806	SE008	3	W	t	FM007	f	2022-08-09 15:20:41.218623	2022-08-09 15:20:41.218623
f086fa6b-9cbc-43e5-9f9c-7785c5c05a59	SE008	3	Z	t	FM007	f	2022-08-09 15:20:41.22402	2022-08-09 15:20:41.22402
af73cb30-bfb8-438f-8c0e-5f03b7de8ae7	SE008	3	A	f	FM007	f	2022-08-09 15:20:41.229682	2022-08-09 15:20:41.229682
6e5700ba-01d4-496b-8696-2c27675470ed	SE008	3	D	f	FM007	f	2022-08-09 15:20:41.235005	2022-08-09 15:20:41.235005
690525fc-c5f8-496a-b3d0-caa48e2fdfd0	SE008	3	I	f	FM007	f	2022-08-09 15:20:41.240441	2022-08-09 15:20:41.240441
a40f2086-acd2-41e9-ba7b-be7fff5fc607	SE008	3	W	f	FM007	f	2022-08-09 15:20:41.246409	2022-08-09 15:20:41.246409
fb677499-39af-415b-afdd-91fe8c07c4e6	SE008	3	Z	f	FM007	f	2022-08-09 15:20:41.251728	2022-08-09 15:20:41.251728
044dd8ad-d709-40c0-aa16-d17b08ba5dcb	SE008	3	A	t	FM019	f	2022-08-09 15:20:41.257084	2022-08-09 15:20:41.257084
43d60deb-59dc-4b28-a6f5-530096dd227a	SE008	3	D	t	FM019	f	2022-08-09 15:20:41.263045	2022-08-09 15:20:41.263045
10ab7abf-d33b-4ff1-bdee-ff0e8e93766e	SE008	3	I	t	FM019	f	2022-08-09 15:20:41.268964	2022-08-09 15:20:41.268964
510ee1c1-2fac-45e0-9850-acfd626bd546	SE008	3	W	t	FM019	f	2022-08-09 15:20:41.274346	2022-08-09 15:20:41.274346
272542fa-dab0-47ec-8bab-202eebbd47f7	SE008	3	Z	t	FM019	f	2022-08-09 15:20:41.279811	2022-08-09 15:20:41.279811
3a686159-2082-47b2-8787-f98be85212cb	SE008	3	A	f	FM019	f	2022-08-09 15:20:41.285915	2022-08-09 15:20:41.285915
30a62f7d-e2e9-491b-b44d-763999070e7b	SE008	3	D	f	FM019	f	2022-08-09 15:20:41.291281	2022-08-09 15:20:41.291281
c8deab0f-b952-4aba-9bda-fa344da6c9a1	SE008	3	I	f	FM019	f	2022-08-09 15:20:41.296665	2022-08-09 15:20:41.296665
84e71648-e529-41a3-8165-b5024cf053d1	SE008	3	W	f	FM019	f	2022-08-09 15:20:41.302282	2022-08-09 15:20:41.302282
d49bd336-46ea-4e05-ade4-6743a7cfb840	SE008	3	Z	f	FM019	f	2022-08-09 15:20:41.307717	2022-08-09 15:20:41.307717
51c1a9e9-cc94-4ead-a13f-09b92cabb754	SE008	3	A	t	FM039	f	2022-08-09 15:20:41.31341	2022-08-09 15:20:41.31341
5cb494cb-05e7-458c-a9fd-170f5d4bcdf6	SE008	3	D	t	FM039	f	2022-08-09 15:20:41.318894	2022-08-09 15:20:41.318894
e0b1a60d-1ed2-4949-b84e-258d34486aa9	SE008	3	I	t	FM039	f	2022-08-09 15:20:41.324353	2022-08-09 15:20:41.324353
d4f0e0f0-3393-422f-9d86-5ece573091e4	SE008	3	W	t	FM039	f	2022-08-09 15:20:41.330016	2022-08-09 15:20:41.330016
0fb48c70-fcff-4d79-9f84-16db78efa95f	SE008	3	Z	t	FM039	f	2022-08-09 15:20:41.335338	2022-08-09 15:20:41.335338
5cea9ef0-d530-4adb-b6f8-9c34f185e8c3	SE008	3	A	f	FM039	f	2022-08-09 15:20:41.34068	2022-08-09 15:20:41.34068
c7207aea-3e03-4a34-af95-ae1134966ba3	SE008	3	D	f	FM039	f	2022-08-09 15:20:41.346867	2022-08-09 15:20:41.346867
c3fe1732-ae42-40df-bf35-04199bcd7918	SE008	3	I	f	FM039	f	2022-08-09 15:20:41.35354	2022-08-09 15:20:41.35354
942eb6d8-b8d4-48d1-86eb-b41bb8292f6f	SE008	3	W	f	FM039	f	2022-08-09 15:20:41.359365	2022-08-09 15:20:41.359365
46f03eb9-d04e-42a3-8d6c-4a7eee9e9f80	SE008	3	Z	f	FM039	f	2022-08-09 15:20:41.366374	2022-08-09 15:20:41.366374
d9852af4-84a5-4687-9dd8-5d2dc0ee413b	SE008	3	A	t	FM049	f	2022-08-09 15:20:41.372123	2022-08-09 15:20:41.372123
41ef2720-1cf3-4158-8169-78734890155d	SE008	3	D	t	FM049	f	2022-08-09 15:20:41.378506	2022-08-09 15:20:41.378506
0fa1fdd5-d6b8-411e-86f8-75d2b5f0fb0a	SE008	3	I	t	FM049	f	2022-08-09 15:20:41.385041	2022-08-09 15:20:41.385041
c75a27f9-5078-4a35-9189-01731f5cf0f1	SE008	3	W	t	FM049	f	2022-08-09 15:20:41.390692	2022-08-09 15:20:41.390692
23357540-66fc-46f4-91a0-f2830e9add2a	SE008	3	Z	t	FM049	f	2022-08-09 15:20:41.39659	2022-08-09 15:20:41.39659
6d6ddb79-582f-4b71-bb2f-37e1f04a8f9b	SE008	3	A	f	FM049	t	2022-08-09 15:20:41.402696	2022-08-09 15:20:41.432981
1d451028-81ef-46b8-b339-ae6beb339cb4	SE008	3	D	f	FM049	t	2022-08-09 15:20:41.408277	2022-08-09 15:20:41.440615
6ee7aa4a-71e9-479a-a8b9-f6b42201bfa1	SE008	3	I	f	FM049	t	2022-08-09 15:20:41.414255	2022-08-09 15:20:41.448182
16b22a41-abf7-4b02-b272-3f9567ac6730	SE008	3	W	f	FM049	t	2022-08-09 15:20:41.419698	2022-08-09 15:20:41.457007
13198545-f2e6-4c8f-a14f-09badff5658a	SE008	3	Z	f	FM049	t	2022-08-09 15:20:41.425318	2022-08-09 15:20:41.464981
528e6f23-e40d-4cec-8393-89c661034df1	SE008	3	A	t	CV117	t	2022-08-09 15:20:41.083553	2022-08-09 15:20:41.473442
6e11e0fb-bf01-47d2-9b1b-fead14e00c1b	SE008	3	D	t	CV118	t	2022-08-09 15:20:41.149011	2022-08-09 15:20:41.482002
e6696c8c-b338-49b2-b5cc-96fbfbe3eaf0	SE008	3	I	t	CV118	t	2022-08-09 15:20:41.154803	2022-08-09 15:20:41.489553
998ccd17-72e9-460c-8424-938a0b34a569	SE008	3	W	t	CV118	t	2022-08-09 15:20:41.160233	2022-08-09 15:20:41.497096
d51ea1fb-aa61-4de0-9c6a-0c28e41f2083	SE008	3	Z	t	CV118	t	2022-08-09 15:20:41.166334	2022-08-09 15:20:41.504734
d9cd4f0c-e684-4f24-b0f7-091089f269ee	SE013	3	A	t	CV027	f	2022-08-09 15:20:41.510568	2022-08-09 15:20:41.510568
02eb0398-95aa-4d86-80d0-ec4a81a2524f	SE013	3	D	t	CV027	f	2022-08-09 15:20:41.516461	2022-08-09 15:20:41.516461
b43d5f48-b921-4e66-8377-5d53aeeec7d2	SE013	3	I	t	CV027	f	2022-08-09 15:20:41.52178	2022-08-09 15:20:41.52178
486803d9-4bd3-4c0a-a6a6-13769c26a100	SE013	3	W	t	CV027	f	2022-08-09 15:20:41.52752	2022-08-09 15:20:41.52752
0b693b6a-3754-4154-bf4f-ef58791d5f70	SE013	3	Z	t	CV027	f	2022-08-09 15:20:41.533158	2022-08-09 15:20:41.533158
65fcae55-05e3-498a-bd8e-211c8c3e66fb	SE013	3	A	f	CV027	f	2022-08-09 15:20:41.539906	2022-08-09 15:20:41.539906
b51bfd54-3096-4033-9d76-0842d3b4fc8f	SE013	3	D	f	CV027	f	2022-08-09 15:20:41.546663	2022-08-09 15:20:41.546663
7b157b0f-76f7-4bbc-820b-4ef7e710e523	SE013	3	I	f	CV027	f	2022-08-09 15:20:41.553258	2022-08-09 15:20:41.553258
d46a7c04-3dff-4478-ae6c-e1043130e75e	SE013	3	W	f	CV027	f	2022-08-09 15:20:41.558655	2022-08-09 15:20:41.558655
7dd492cd-c849-4272-b277-3012de83c9b9	SE013	3	Z	f	CV027	f	2022-08-09 15:20:41.564469	2022-08-09 15:20:41.564469
09074d56-77dd-468a-90b4-eb64769b30ed	SE013	3	D	t	CV117	f	2022-08-09 15:20:41.57552	2022-08-09 15:20:41.57552
706a1385-e253-4906-a149-0b10057fb095	SE013	3	I	t	CV117	f	2022-08-09 15:20:41.582814	2022-08-09 15:20:41.582814
c3746ace-28f7-4bc6-a703-d39e8102333c	SE013	3	W	t	CV117	f	2022-08-09 15:20:41.588749	2022-08-09 15:20:41.588749
2bc1bbc3-1a69-4227-8173-0bd21187f7f6	SE013	3	Z	t	CV117	f	2022-08-09 15:20:41.59429	2022-08-09 15:20:41.59429
a2cc563c-ee34-4954-a120-346a5e267283	SE013	3	A	f	CV117	f	2022-08-09 15:20:41.600746	2022-08-09 15:20:41.600746
ebcd3fb9-294c-435a-a289-29c5d83343c2	SE013	3	D	f	CV117	f	2022-08-09 15:20:41.606444	2022-08-09 15:20:41.606444
58177aff-8fa9-47f3-97a1-3a85908ef712	SE013	3	I	f	CV117	f	2022-08-09 15:20:41.612435	2022-08-09 15:20:41.612435
f0fb4192-30c3-405f-81a7-d163de41ef4a	SE013	3	W	f	CV117	f	2022-08-09 15:20:41.618112	2022-08-09 15:20:41.618112
0d866284-6957-480e-a8e5-f2f8e6e9b323	SE013	3	Z	f	CV117	f	2022-08-09 15:20:41.623977	2022-08-09 15:20:41.623977
08986900-ad23-414b-a8da-2f3f319aeeb2	SE013	3	A	t	CV118	f	2022-08-09 15:20:41.629479	2022-08-09 15:20:41.629479
0b49ab61-d918-4916-8659-6d3fd830ad03	SE013	3	A	f	CV118	f	2022-08-09 15:20:41.65809	2022-08-09 15:20:41.65809
b340f63b-5ac1-4bfc-be5a-402e2254dc23	SE013	3	D	f	CV118	f	2022-08-09 15:20:41.663636	2022-08-09 15:20:41.663636
28627795-c182-4717-8c18-a4bb4150d4b8	SE013	3	I	f	CV118	f	2022-08-09 15:20:41.669811	2022-08-09 15:20:41.669811
a7cce152-44e0-49d9-a18c-7a136abb8f60	SE013	3	W	f	CV118	f	2022-08-09 15:20:41.675352	2022-08-09 15:20:41.675352
ccc3ca9d-992b-42b5-86ce-dadf149117b1	SE013	3	Z	f	CV118	f	2022-08-09 15:20:41.680656	2022-08-09 15:20:41.680656
d6a5dce8-d49c-44d0-ae5e-67b46fc2b032	SE013	3	A	t	FM007	f	2022-08-09 15:20:41.686512	2022-08-09 15:20:41.686512
fb5a60b0-fdaf-4bbe-b10f-03b8884c255d	SE013	3	D	t	FM007	f	2022-08-09 15:20:41.692013	2022-08-09 15:20:41.692013
35bb3a48-81b8-4330-b965-8329da7c7be9	SE013	3	I	t	FM007	f	2022-08-09 15:20:41.697357	2022-08-09 15:20:41.697357
e2256624-e17b-451d-852a-5bb1787f56d1	SE013	3	W	t	FM007	f	2022-08-09 15:20:41.703295	2022-08-09 15:20:41.703295
78e1eef4-5348-4683-bfb7-3251b5c516db	SE013	3	Z	t	FM007	f	2022-08-09 15:20:41.708923	2022-08-09 15:20:41.708923
4ae4cb90-cea7-421f-bcbc-5e44ce126141	SE013	3	A	f	FM007	f	2022-08-09 15:20:41.714728	2022-08-09 15:20:41.714728
b0d2882f-d110-4079-bbad-bb99cb58f769	SE013	3	D	f	FM007	f	2022-08-09 15:20:41.720718	2022-08-09 15:20:41.720718
8016f6be-29b3-4240-960a-435a8c8b7ec0	SE013	3	I	f	FM007	f	2022-08-09 15:20:41.725999	2022-08-09 15:20:41.725999
9f9ea37f-08f4-4cbc-8293-aeb37b9d426e	SE013	3	W	f	FM007	f	2022-08-09 15:20:41.731609	2022-08-09 15:20:41.731609
8b5eb08a-9714-4259-905e-a47d114db4f4	SE013	3	Z	f	FM007	f	2022-08-09 15:20:41.736904	2022-08-09 15:20:41.736904
09de4881-5804-4c8f-bbc0-5835918ce6ef	SE013	3	A	t	FM019	f	2022-08-09 15:20:41.742199	2022-08-09 15:20:41.742199
2373cd0d-a1f6-4956-a720-5ed7e0519e94	SE013	3	D	t	FM019	f	2022-08-09 15:20:41.747997	2022-08-09 15:20:41.747997
f077be47-1d6c-4725-8100-438119774f71	SE013	3	I	t	FM019	f	2022-08-09 15:20:41.75341	2022-08-09 15:20:41.75341
7c7c2d43-628b-48bb-bcb5-7d7ce4b48ac1	SE013	3	W	t	FM019	f	2022-08-09 15:20:41.759008	2022-08-09 15:20:41.759008
72055d6a-ab7f-4a27-8682-471bb8714358	SE013	3	Z	t	FM019	f	2022-08-09 15:20:41.764406	2022-08-09 15:20:41.764406
6f5b2e0f-1933-46d9-bb19-c6d708dd3199	SE013	3	A	f	FM019	f	2022-08-09 15:20:41.770115	2022-08-09 15:20:41.770115
633b77ca-8e48-4efc-ab18-4ddd3a0c71c1	SE013	3	D	f	FM019	f	2022-08-09 15:20:41.775673	2022-08-09 15:20:41.775673
b7988e2b-fb7b-4aea-9290-a9b33cd69ff5	SE013	3	I	f	FM019	f	2022-08-09 15:20:41.781184	2022-08-09 15:20:41.781184
349a8c66-0f79-4546-8f29-54ab19f1a6d9	SE013	3	W	f	FM019	f	2022-08-09 15:20:41.786863	2022-08-09 15:20:41.786863
c8946bb0-c1c3-4d39-95ae-d67f2b18f011	SE013	3	Z	f	FM019	f	2022-08-09 15:20:41.793488	2022-08-09 15:20:41.793488
5956a412-3b15-474c-8ba1-98599de4ff0b	SE013	3	A	t	FM039	f	2022-08-09 15:20:41.799769	2022-08-09 15:20:41.799769
18d0db44-a76c-4567-8d18-fe0971550f47	SE013	3	D	t	FM039	f	2022-08-09 15:20:41.805222	2022-08-09 15:20:41.805222
1fa40ab9-7d79-47fc-a01b-248514fbd14d	SE013	3	I	t	FM039	f	2022-08-09 15:20:41.810869	2022-08-09 15:20:41.810869
8cef6081-5a58-496f-bc23-62a108a719a0	SE013	3	W	t	FM039	f	2022-08-09 15:20:41.816518	2022-08-09 15:20:41.816518
644944cb-7754-4fde-8a5f-184c93f3b2f3	SE013	3	Z	t	FM039	f	2022-08-09 15:20:41.82274	2022-08-09 15:20:41.82274
3de16c26-9df3-49e7-b8d2-34bd06e8f074	SE013	3	A	f	FM039	f	2022-08-09 15:20:41.828534	2022-08-09 15:20:41.828534
49d86800-8146-4dda-ab72-f72fe29f74ba	SE013	3	D	f	FM039	f	2022-08-09 15:20:41.833935	2022-08-09 15:20:41.833935
49ed0100-8e0a-4253-8003-691f03c74abd	SE013	3	I	f	FM039	f	2022-08-09 15:20:41.839941	2022-08-09 15:20:41.839941
fcb3bb9a-cc2e-4cc3-a8c7-418cc3c040ce	SE013	3	W	f	FM039	f	2022-08-09 15:20:41.845314	2022-08-09 15:20:41.845314
62412bd7-1825-4bc2-85da-914c9ed88175	SE013	3	Z	f	FM039	f	2022-08-09 15:20:41.851011	2022-08-09 15:20:41.851011
47563939-c3c0-40f0-9c63-2acbff05e4c2	SE013	3	A	t	FM049	f	2022-08-09 15:20:41.856449	2022-08-09 15:20:41.856449
24bf895f-5813-4673-ab25-82e87b16d441	SE013	3	D	t	FM049	f	2022-08-09 15:20:41.862461	2022-08-09 15:20:41.862461
935e6e2d-0336-4e23-93f7-ba5678bab82d	SE013	3	I	t	FM049	f	2022-08-09 15:20:41.867864	2022-08-09 15:20:41.867864
aabe0fec-db02-4071-acc7-dc7de6d61740	SE013	3	W	t	FM049	f	2022-08-09 15:20:41.87369	2022-08-09 15:20:41.87369
87eb58ad-eb5b-4c09-ad77-6664e28c6409	SE013	3	Z	t	FM049	f	2022-08-09 15:20:41.879128	2022-08-09 15:20:41.879128
1d1e4bbe-d57c-4b2e-97e7-47f3f5a7e5e7	SE013	3	A	f	FM049	t	2022-08-09 15:20:41.884548	2022-08-09 15:20:41.918132
539ce3f1-59d8-4e3a-a517-89affd61617a	SE013	3	D	f	FM049	t	2022-08-09 15:20:41.890229	2022-08-09 15:20:41.926846
7a6dd671-1c28-480d-b943-0e4969cd7dc3	SE013	3	I	f	FM049	t	2022-08-09 15:20:41.895477	2022-08-09 15:20:41.935006
f0fa0d69-45e5-4e9b-bca2-e13b27e9da14	SE013	3	W	f	FM049	t	2022-08-09 15:20:41.902219	2022-08-09 15:20:41.942563
2c844136-0eee-4ff4-b582-730eb549556c	SE013	3	Z	f	FM049	t	2022-08-09 15:20:41.908788	2022-08-09 15:20:41.950398
c3fdb516-3a46-4e0c-a5c0-9a2d8f506576	SE013	3	A	t	CV117	t	2022-08-09 15:20:41.570103	2022-08-09 15:20:41.95803
db094b04-3b64-49bb-bf7f-435ee6ce9e59	SE013	3	D	t	CV118	t	2022-08-09 15:20:41.635218	2022-08-09 15:20:41.965352
a2fc2711-1d4a-4afd-815b-0f46f19bbb36	SE013	3	I	t	CV118	t	2022-08-09 15:20:41.641198	2022-08-09 15:20:41.97282
4954859e-6a7b-4d30-8646-7fa42055b9e6	SE013	3	W	t	CV118	t	2022-08-09 15:20:41.646628	2022-08-09 15:20:41.980456
de8f9161-976c-42db-9ed6-a4c05aeacfb6	SE013	3	Z	t	CV118	t	2022-08-09 15:20:41.652293	2022-08-09 15:20:41.98816
4721caed-5415-4af8-9fa3-ffaf929d4a06	SE014	3	A	t	CV027	f	2022-08-09 15:20:41.993733	2022-08-09 15:20:41.993733
2d805f87-2ac3-49b8-8f82-7003c066c00c	SE014	3	D	t	CV027	f	2022-08-09 15:20:41.999411	2022-08-09 15:20:41.999411
78ff7027-5ad3-4ea8-aba1-a307200df037	SE014	3	I	t	CV027	f	2022-08-09 15:20:42.005081	2022-08-09 15:20:42.005081
52c18434-42d8-4ace-9435-64b94ee947ef	SE014	3	W	t	CV027	f	2022-08-09 15:20:42.010374	2022-08-09 15:20:42.010374
6d1cae19-4b8b-4c84-be38-a181a5197878	SE014	3	Z	t	CV027	f	2022-08-09 15:20:42.01574	2022-08-09 15:20:42.01574
c9b9da95-5230-4ee8-a2ed-8c03a9a269ae	SE014	3	A	f	CV027	f	2022-08-09 15:20:42.021549	2022-08-09 15:20:42.021549
0d16d461-c4f5-4a22-bf45-263bc4316fbe	SE014	3	D	f	CV027	f	2022-08-09 15:20:42.026861	2022-08-09 15:20:42.026861
e8339447-dcb7-4d97-8538-2aff093b1d60	SE014	3	I	f	CV027	f	2022-08-09 15:20:42.032057	2022-08-09 15:20:42.032057
58f2c57b-f386-4024-821b-cb97b8326ceb	SE014	3	W	f	CV027	f	2022-08-09 15:20:42.037649	2022-08-09 15:20:42.037649
2f495a05-2566-4cfb-b5d4-1ed08c98beca	SE014	3	Z	f	CV027	f	2022-08-09 15:20:42.042949	2022-08-09 15:20:42.042949
c09cc75f-20e5-4795-8316-bc46e7bcf2d1	SE014	3	D	t	CV117	f	2022-08-09 15:20:42.054026	2022-08-09 15:20:42.054026
d1cc2eb3-4ca6-44b9-a1b3-41fe0b19bd8f	SE014	3	I	t	CV117	f	2022-08-09 15:20:42.059342	2022-08-09 15:20:42.059342
959151ae-06b4-4814-85e9-014858297942	SE014	3	W	t	CV117	f	2022-08-09 15:20:42.06525	2022-08-09 15:20:42.06525
8f77d5bc-9c1f-486a-9f4e-9d9c6bd29d80	SE014	3	Z	t	CV117	f	2022-08-09 15:20:42.070558	2022-08-09 15:20:42.070558
e4e2708f-4eab-4bb5-bf6d-2a235940a608	SE014	3	A	f	CV117	f	2022-08-09 15:20:42.076299	2022-08-09 15:20:42.076299
fefd3821-14ec-4a12-88b4-c02e8b4f5b09	SE014	3	D	f	CV117	f	2022-08-09 15:20:42.083967	2022-08-09 15:20:42.083967
95de036a-18db-41cc-8dcf-f179917b3813	SE014	3	I	f	CV117	f	2022-08-09 15:20:42.089827	2022-08-09 15:20:42.089827
95fc8779-c093-4c92-8f2d-e7451cbdb356	SE014	3	W	f	CV117	f	2022-08-09 15:20:42.095494	2022-08-09 15:20:42.095494
20c38394-f938-4fb8-8d29-c506dd67fdb6	SE014	3	Z	f	CV117	f	2022-08-09 15:20:42.101696	2022-08-09 15:20:42.101696
13f2d023-7d69-49a0-acc7-2a105ef06cf8	SE014	3	A	t	CV118	f	2022-08-09 15:20:42.107878	2022-08-09 15:20:42.107878
cdbf5f13-7a8a-4a69-a7d7-6e925b045318	SE014	3	A	f	CV118	f	2022-08-09 15:20:42.137549	2022-08-09 15:20:42.137549
8bb2597c-c301-4530-9490-71aca7a9bd4d	SE014	3	D	f	CV118	f	2022-08-09 15:20:42.143554	2022-08-09 15:20:42.143554
389213f2-e57f-433c-8bff-7734817b78e6	SE014	3	I	f	CV118	f	2022-08-09 15:20:42.148932	2022-08-09 15:20:42.148932
3e24763c-e3f6-4122-b99e-56e39c37b098	SE014	3	W	f	CV118	f	2022-08-09 15:20:42.154664	2022-08-09 15:20:42.154664
b4110e93-c593-49af-80a9-8c5aae5c88e7	SE014	3	Z	f	CV118	f	2022-08-09 15:20:42.160022	2022-08-09 15:20:42.160022
9477a466-b71a-4bda-959e-6b043288645d	SE014	3	A	t	FM007	f	2022-08-09 15:20:42.165689	2022-08-09 15:20:42.165689
4f1086d9-90dc-439a-8bfa-667a1f43e452	SE014	3	D	t	FM007	f	2022-08-09 15:20:42.171072	2022-08-09 15:20:42.171072
ff414152-a6c9-4c18-ac08-a9341b48cc54	SE014	3	I	t	FM007	f	2022-08-09 15:20:42.177007	2022-08-09 15:20:42.177007
725dbf63-5196-4ecc-aa29-6b1fd587a0ab	SE014	3	W	t	FM007	f	2022-08-09 15:20:42.18293	2022-08-09 15:20:42.18293
8bad7508-bd2e-49db-9e12-6e5673323571	SE014	3	Z	t	FM007	f	2022-08-09 15:20:42.188505	2022-08-09 15:20:42.188505
75cfe5d0-e75c-40fe-8afc-1cf48a0d483d	SE014	3	A	f	FM007	f	2022-08-09 15:20:42.193956	2022-08-09 15:20:42.193956
fea3d581-03b7-42ae-a43d-282e71224b56	SE014	3	D	f	FM007	f	2022-08-09 15:20:42.199563	2022-08-09 15:20:42.199563
136e5c1c-0ea7-4e6e-aa57-d8489cd351a7	SE014	3	I	f	FM007	f	2022-08-09 15:20:42.204995	2022-08-09 15:20:42.204995
07c36b94-ca2a-43e1-b87b-75c8c8e6c853	SE014	3	W	f	FM007	f	2022-08-09 15:20:42.210678	2022-08-09 15:20:42.210678
9c951710-17a4-4f08-8103-57c77e3bfb24	SE014	3	Z	f	FM007	f	2022-08-09 15:20:42.21603	2022-08-09 15:20:42.21603
75515906-6030-4453-9cb5-f36077cf1006	SE014	3	A	t	FM019	f	2022-08-09 15:20:42.221768	2022-08-09 15:20:42.221768
defb5a63-3622-41ac-9453-0d5213aea2c1	SE014	3	D	t	FM019	f	2022-08-09 15:20:42.227086	2022-08-09 15:20:42.227086
49345ab0-0deb-4b75-ba23-115a7ed4dbf7	SE014	3	I	t	FM019	f	2022-08-09 15:20:42.232373	2022-08-09 15:20:42.232373
30d66f83-a225-46ac-a2f6-1aa96e01709b	SE014	3	W	t	FM019	f	2022-08-09 15:20:42.237805	2022-08-09 15:20:42.237805
656ce12a-52cb-4b60-982f-189db6bcdc23	SE014	3	Z	t	FM019	f	2022-08-09 15:20:42.24305	2022-08-09 15:20:42.24305
b9837736-2332-4190-9900-082e6e8cf00c	SE014	3	A	f	FM019	f	2022-08-09 15:20:42.248676	2022-08-09 15:20:42.248676
44fd4aa5-50fe-41ee-98db-0d2af3f2ce21	SE014	3	D	f	FM019	f	2022-08-09 15:20:42.254365	2022-08-09 15:20:42.254365
d3dcbf53-7010-49ce-bf40-56d87f1e1ab9	SE014	3	I	f	FM019	f	2022-08-09 15:20:42.259882	2022-08-09 15:20:42.259882
f8020277-6366-4633-8daf-1963a17ca0c5	SE014	3	W	f	FM019	f	2022-08-09 15:20:42.265653	2022-08-09 15:20:42.265653
b6b46d08-f9cd-462e-a036-3697396f974f	SE014	3	Z	f	FM019	f	2022-08-09 15:20:42.271003	2022-08-09 15:20:42.271003
d4ca7ff0-e50b-4739-ac71-9f0b0b90da8d	SE014	3	A	t	FM039	f	2022-08-09 15:20:42.277111	2022-08-09 15:20:42.277111
2c1a2fa4-63dd-474a-8232-661d716a8e9b	SE014	3	D	t	FM039	f	2022-08-09 15:20:42.282758	2022-08-09 15:20:42.282758
bb36ed8f-cae5-46a8-9939-af0879760c2a	SE014	3	I	t	FM039	f	2022-08-09 15:20:42.288067	2022-08-09 15:20:42.288067
93928b24-03ce-4741-963c-639819970110	SE014	3	W	t	FM039	f	2022-08-09 15:20:42.29385	2022-08-09 15:20:42.29385
7fbfd8bf-fa58-4f1a-b985-933c16504ff2	SE014	3	Z	t	FM039	f	2022-08-09 15:20:42.299243	2022-08-09 15:20:42.299243
9b744e1a-3a68-43a3-9dde-bd31e1180863	SE014	3	A	f	FM039	f	2022-08-09 15:20:42.304543	2022-08-09 15:20:42.304543
47342019-e7f3-4857-bd91-8c294d3a5e03	SE014	3	D	f	FM039	f	2022-08-09 15:20:42.310202	2022-08-09 15:20:42.310202
d58d2aa6-1a8a-4c4c-b968-c9631d3621a4	SE014	3	I	f	FM039	f	2022-08-09 15:20:42.31573	2022-08-09 15:20:42.31573
6a9efb53-f0d7-4c31-91af-4ce38fc97dd6	SE014	3	W	f	FM039	f	2022-08-09 15:20:42.321294	2022-08-09 15:20:42.321294
0903d795-fdaf-4362-899c-2637eedf8e0f	SE014	3	Z	f	FM039	f	2022-08-09 15:20:42.326565	2022-08-09 15:20:42.326565
f4360e42-78cc-4d62-bb78-a81af346b7a1	SE014	3	A	t	FM049	f	2022-08-09 15:20:42.332107	2022-08-09 15:20:42.332107
22b918b9-fee5-4d98-a702-90d157e45567	SE014	3	D	t	FM049	f	2022-08-09 15:20:42.337793	2022-08-09 15:20:42.337793
b1d3b102-1078-485f-a235-2eb74224eb2b	SE014	3	I	t	FM049	f	2022-08-09 15:20:42.34319	2022-08-09 15:20:42.34319
240383f2-db58-46b5-821d-3e0201fd1793	SE014	3	W	t	FM049	f	2022-08-09 15:20:42.349669	2022-08-09 15:20:42.349669
b84d3411-c823-4de8-a750-f95ff0389fe8	SE014	3	Z	t	FM049	f	2022-08-09 15:20:42.355806	2022-08-09 15:20:42.355806
770733a5-f446-42e6-8bc2-4617f92360d2	SE014	3	A	f	FM049	t	2022-08-09 15:20:42.361549	2022-08-09 15:20:42.394744
57d62c4c-c44f-4fab-9cd9-55f4fdfa5801	SE014	3	D	f	FM049	t	2022-08-09 15:20:42.368136	2022-08-09 15:20:42.402229
80d8612c-dc73-4a4e-9a8e-cc934ea79375	SE014	3	I	f	FM049	t	2022-08-09 15:20:42.374135	2022-08-09 15:20:42.409814
d9c7ec9b-7bb0-460f-8c27-9bb9b2c561f1	SE014	3	W	f	FM049	t	2022-08-09 15:20:42.380222	2022-08-09 15:20:42.417236
8de00c68-1953-46a7-bf3f-e6211a76118a	SE014	3	Z	f	FM049	t	2022-08-09 15:20:42.387066	2022-08-09 15:20:42.424626
94af9c5b-0298-45b3-81ce-8f3e88bf9ba8	SE014	3	A	t	CV117	t	2022-08-09 15:20:42.048651	2022-08-09 15:20:42.431828
91cdd8f5-875e-4246-bacc-553d733a027f	SE014	3	D	t	CV118	t	2022-08-09 15:20:42.113562	2022-08-09 15:20:42.438727
af58b7a9-ae30-4efd-ae77-8c7c5a3a8f31	SE014	3	I	t	CV118	t	2022-08-09 15:20:42.119207	2022-08-09 15:20:42.445921
5163813d-bb42-4e64-bb6a-e5a1203a566c	SE014	3	W	t	CV118	t	2022-08-09 15:20:42.124778	2022-08-09 15:20:42.453296
21b7bc64-0b79-4002-8fac-70eea3a4c67f	SE014	3	Z	t	CV118	t	2022-08-09 15:20:42.131382	2022-08-09 15:20:42.46224
34656109-94a0-49b8-9455-38e05068b1b5	SE015	3	A	t	CV027	f	2022-08-09 15:20:42.467832	2022-08-09 15:20:42.467832
7cbe259a-2ec0-4be2-a3be-eaf521abdd49	SE015	3	D	t	CV027	f	2022-08-09 15:20:42.47366	2022-08-09 15:20:42.47366
c41909cf-c95d-4caf-8cbd-3f6bec72fc8f	SE015	3	I	t	CV027	f	2022-08-09 15:20:42.479144	2022-08-09 15:20:42.479144
8a4c1570-b69e-4957-ad63-83a08f88f000	SE015	3	W	t	CV027	f	2022-08-09 15:20:42.484915	2022-08-09 15:20:42.484915
e9268bfe-04e8-4a3e-9ab9-60c317c9e928	SE015	3	Z	t	CV027	f	2022-08-09 15:20:42.490383	2022-08-09 15:20:42.490383
c9e85d0a-4938-4f86-a384-58ad3dc62ccc	SE015	3	A	f	CV027	f	2022-08-09 15:20:42.496216	2022-08-09 15:20:42.496216
454b1667-e4d2-4fd0-bac1-a14c74f2c387	SE015	3	D	f	CV027	f	2022-08-09 15:20:42.501936	2022-08-09 15:20:42.501936
fc577e76-6585-4fd6-9ce2-b7351892abe1	SE015	3	I	f	CV027	f	2022-08-09 15:20:42.508096	2022-08-09 15:20:42.508096
9deddf32-e21c-4206-8859-f9bb8127e8fe	SE015	3	W	f	CV027	f	2022-08-09 15:20:42.51359	2022-08-09 15:20:42.51359
9cd27805-7200-4461-8d3a-8a6fa14b435a	SE015	3	Z	f	CV027	f	2022-08-09 15:20:42.518918	2022-08-09 15:20:42.518918
0c3ca2b9-5c03-4426-bf3d-ae668adfb1d8	SE015	3	D	t	CV117	f	2022-08-09 15:20:42.52997	2022-08-09 15:20:42.52997
89a13f7b-9a0c-4e63-af84-cba5d499e051	SE015	3	I	t	CV117	f	2022-08-09 15:20:42.535288	2022-08-09 15:20:42.535288
cc0d9502-a522-487b-8186-05ff36eab011	SE015	3	W	t	CV117	f	2022-08-09 15:20:42.540982	2022-08-09 15:20:42.540982
cb805c95-caa3-4e00-b8ca-9a8dfeb8cea1	SE015	3	Z	t	CV117	f	2022-08-09 15:20:42.546371	2022-08-09 15:20:42.546371
49372062-6f2a-4727-8f2c-bfae8009762d	SE015	3	A	f	CV117	f	2022-08-09 15:20:42.552244	2022-08-09 15:20:42.552244
2ec3e2cb-8278-48ee-8a64-21fc60c5148f	SE015	3	D	f	CV117	f	2022-08-09 15:20:42.557594	2022-08-09 15:20:42.557594
995e8a65-42bb-4c8e-94d3-4369bc13044b	SE015	3	I	f	CV117	f	2022-08-09 15:20:42.563166	2022-08-09 15:20:42.563166
b1b24ce5-44af-4753-a1f6-7220e3e218dc	SE015	3	W	f	CV117	f	2022-08-09 15:20:42.568377	2022-08-09 15:20:42.568377
21c8399b-bfd9-4057-ad87-00ada48d4bef	SE015	3	Z	f	CV117	f	2022-08-09 15:20:42.573708	2022-08-09 15:20:42.573708
9c74f047-ea74-4fc6-8ef1-7d54ec09de34	SE015	3	A	t	CV118	f	2022-08-09 15:20:42.579657	2022-08-09 15:20:42.579657
c7a1304a-1b66-4da9-a067-6b47a08e3d1c	SE015	3	A	f	CV118	f	2022-08-09 15:20:42.60904	2022-08-09 15:20:42.60904
444049ed-8b77-400c-8ead-d537b5b3cf71	SE015	3	D	f	CV118	f	2022-08-09 15:20:42.614407	2022-08-09 15:20:42.614407
4caea065-b6b4-4be7-9504-2ed7b7522f72	SE015	3	I	f	CV118	f	2022-08-09 15:20:42.620126	2022-08-09 15:20:42.620126
31074fef-2d6a-412e-ae4c-ce6d8fb47507	SE015	3	W	f	CV118	f	2022-08-09 15:20:42.625979	2022-08-09 15:20:42.625979
ecc9a518-1d44-4d6d-b2f9-ae9b62133e71	SE015	3	Z	f	CV118	f	2022-08-09 15:20:42.631262	2022-08-09 15:20:42.631262
eab08fcf-c86a-423a-9276-ffe9fe560d18	SE015	3	A	t	FM007	f	2022-08-09 15:20:42.636777	2022-08-09 15:20:42.636777
1288bc50-8a41-42dd-9b37-f583e4d7181e	SE015	3	D	t	FM007	f	2022-08-09 15:20:42.642406	2022-08-09 15:20:42.642406
86386bba-71b5-447a-baad-97b94b8bf8fd	SE015	3	I	t	FM007	f	2022-08-09 15:20:42.647856	2022-08-09 15:20:42.647856
b256d24f-0670-4889-8f93-4ca19f5a13fd	SE015	3	W	t	FM007	f	2022-08-09 15:20:42.653802	2022-08-09 15:20:42.653802
8380e9fa-4b7e-493c-ab6f-6f97ee63ec96	SE015	3	Z	t	FM007	f	2022-08-09 15:20:42.659216	2022-08-09 15:20:42.659216
fdccb136-28e6-4dad-998c-f8c036b68602	SE015	3	A	f	FM007	f	2022-08-09 15:20:42.66485	2022-08-09 15:20:42.66485
c3ab72b9-a45e-452b-8c49-cd9b2645ebda	SE015	3	D	f	FM007	f	2022-08-09 15:20:42.670547	2022-08-09 15:20:42.670547
e45a5e36-d89d-43d0-a3b1-bd4b7e2d1c78	SE015	3	I	f	FM007	f	2022-08-09 15:20:42.675895	2022-08-09 15:20:42.675895
0ed7acd8-4c1f-460d-9c77-992715aab457	SE015	3	W	f	FM007	f	2022-08-09 15:20:42.681676	2022-08-09 15:20:42.681676
3858918c-bdea-4117-8363-f42b323aa3c0	SE015	3	Z	f	FM007	f	2022-08-09 15:20:42.687859	2022-08-09 15:20:42.687859
49864e7b-9930-4367-92ef-386c50df8f4a	SE015	3	A	t	FM019	f	2022-08-09 15:20:42.693323	2022-08-09 15:20:42.693323
36f45a32-46c6-4565-847c-f86d8acd2839	SE015	3	D	t	FM019	f	2022-08-09 15:20:42.699123	2022-08-09 15:20:42.699123
6af57eb5-0efc-4e1f-926e-fd4b63a80fac	SE015	3	I	t	FM019	f	2022-08-09 15:20:42.704767	2022-08-09 15:20:42.704767
32ab1296-fd6a-4651-9e9b-1bd236960395	SE015	3	W	t	FM019	f	2022-08-09 15:20:42.710913	2022-08-09 15:20:42.710913
c4ebc904-6919-4c1e-bca0-b3061dab86e9	SE015	3	Z	t	FM019	f	2022-08-09 15:20:42.717851	2022-08-09 15:20:42.717851
01675a13-8a47-46f3-af29-fb6c16d6c287	SE015	3	A	f	FM019	f	2022-08-09 15:20:42.724462	2022-08-09 15:20:42.724462
d8f1353b-1d69-41b4-9929-71abd5bc3258	SE015	3	D	f	FM019	f	2022-08-09 15:20:42.731193	2022-08-09 15:20:42.731193
a078b226-499b-40e4-a928-d61c98c285ff	SE015	3	I	f	FM019	f	2022-08-09 15:20:42.738211	2022-08-09 15:20:42.738211
293be979-5373-4a6d-a826-9230673b49fb	SE015	3	W	f	FM019	f	2022-08-09 15:20:42.744365	2022-08-09 15:20:42.744365
835a2cc1-4e22-4305-ae10-034381740cc5	SE015	3	Z	f	FM019	f	2022-08-09 15:20:42.750076	2022-08-09 15:20:42.750076
202826c3-1519-4d6c-ade9-7b68999b48cb	SE015	3	A	t	FM039	f	2022-08-09 15:20:42.755329	2022-08-09 15:20:42.755329
560a73a6-b997-43f1-8e48-7a21b7b68919	SE015	3	D	t	FM039	f	2022-08-09 15:20:42.760975	2022-08-09 15:20:42.760975
4c4a54e3-ef9a-46c5-b358-0e9f9b5ceeed	SE015	3	I	t	FM039	f	2022-08-09 15:20:42.766597	2022-08-09 15:20:42.766597
4bbccbe3-4f29-4096-8f1c-1110067d883e	SE015	3	W	t	FM039	f	2022-08-09 15:20:42.772457	2022-08-09 15:20:42.772457
d24e8a63-bffd-4a8d-a40f-43990b655428	SE015	3	Z	t	FM039	f	2022-08-09 15:20:42.7783	2022-08-09 15:20:42.7783
8c28de82-308f-4186-a3d1-0359dbd45615	SE015	3	A	f	FM039	f	2022-08-09 15:20:42.784081	2022-08-09 15:20:42.784081
6fb0d5ad-a1b2-4a62-aea7-811d7d868953	SE015	3	D	f	FM039	f	2022-08-09 15:20:42.790877	2022-08-09 15:20:42.790877
441fc1bd-7d42-4902-a258-aeea807dc7d0	SE015	3	I	f	FM039	f	2022-08-09 15:20:42.796559	2022-08-09 15:20:42.796559
96110527-490a-4e15-9d23-fd43b880000c	SE015	3	W	f	FM039	f	2022-08-09 15:20:42.802493	2022-08-09 15:20:42.802493
3f5a84ba-064f-4092-9c58-46719763aac1	SE015	3	Z	f	FM039	f	2022-08-09 15:20:42.808066	2022-08-09 15:20:42.808066
89980f4f-6215-4a8b-85d5-f099fcfb9152	SE015	3	A	t	FM049	f	2022-08-09 15:20:42.813851	2022-08-09 15:20:42.813851
7b01bae3-05cc-4103-88fd-3d82ccdc2171	SE015	3	D	t	FM049	f	2022-08-09 15:20:42.819561	2022-08-09 15:20:42.819561
ac44a8fa-3828-4641-8fbf-b65076918837	SE015	3	I	t	FM049	f	2022-08-09 15:20:42.825252	2022-08-09 15:20:42.825252
5105d6aa-922e-4a91-b050-190c57b723ce	SE015	3	W	t	FM049	f	2022-08-09 15:20:42.831536	2022-08-09 15:20:42.831536
55a22b91-69fa-49a7-a8b8-67d3cef36a30	SE015	3	Z	t	FM049	f	2022-08-09 15:20:42.837039	2022-08-09 15:20:42.837039
6f1adf94-3bb2-4904-a7d5-34734817a321	SE015	3	A	f	FM049	t	2022-08-09 15:20:42.842838	2022-08-09 15:20:42.872899
035ae838-9300-44e2-983a-7ee5b0236266	SE015	3	D	f	FM049	t	2022-08-09 15:20:42.84813	2022-08-09 15:20:42.88031
aae7d5e2-b9cf-4b4e-a3d9-d45a03a09bca	SE015	3	I	f	FM049	t	2022-08-09 15:20:42.853758	2022-08-09 15:20:42.88756
6da45873-6ef7-4f3a-a3b3-d68bb7a6c698	SE015	3	W	f	FM049	t	2022-08-09 15:20:42.859119	2022-08-09 15:20:42.894849
8e1fbc35-618d-4e15-b1f4-8beaefc53140	SE015	3	Z	f	FM049	t	2022-08-09 15:20:42.86491	2022-08-09 15:20:42.901971
d8dae086-e5b1-4c78-9e5b-0a78707a2ff1	SE015	3	A	t	CV117	t	2022-08-09 15:20:42.524487	2022-08-09 15:20:42.908841
3d17e0ec-c177-4688-8dd4-2e71dd595b57	SE015	3	D	t	CV118	t	2022-08-09 15:20:42.585407	2022-08-09 15:20:42.916085
2ab18e72-4304-4b10-85ab-9923885f02f4	SE015	3	I	t	CV118	t	2022-08-09 15:20:42.591212	2022-08-09 15:20:42.923406
a6c6d575-706e-4812-b292-d455a44f774c	SE015	3	W	t	CV118	t	2022-08-09 15:20:42.597187	2022-08-09 15:20:42.93067
eacc6a36-140c-4dcc-93b5-837bc0488bc5	SE015	3	Z	t	CV118	t	2022-08-09 15:20:42.603068	2022-08-09 15:20:42.93811
6182f5eb-9af0-495e-a402-3b793d1e8a9d	SE016	3	A	t	CV027	f	2022-08-09 15:20:42.943579	2022-08-09 15:20:42.943579
4b147203-9de5-4711-833d-d6541082ced8	SE016	3	D	t	CV027	f	2022-08-09 15:20:42.948896	2022-08-09 15:20:42.948896
8729e3e4-445d-4438-9560-30ea3af404cf	SE016	3	I	t	CV027	f	2022-08-09 15:20:42.954649	2022-08-09 15:20:42.954649
da450fb1-a388-40da-94aa-5974c5569eba	SE016	3	W	t	CV027	f	2022-08-09 15:20:42.96002	2022-08-09 15:20:42.96002
f0e6b781-8b05-4f5c-9587-331249eecf2a	SE016	3	Z	t	CV027	f	2022-08-09 15:20:42.965467	2022-08-09 15:20:42.965467
e7591a64-6331-44c7-a7c7-92e95a0f6c55	SE016	3	A	f	CV027	f	2022-08-09 15:20:42.971215	2022-08-09 15:20:42.971215
de023fc5-a28a-407c-be8f-b2a623e80fe0	SE016	3	D	f	CV027	f	2022-08-09 15:20:42.976611	2022-08-09 15:20:42.976611
c6163089-8167-4bd7-83e3-ea4b9effb449	SE016	3	I	f	CV027	f	2022-08-09 15:20:42.982703	2022-08-09 15:20:42.982703
3c6006c8-dc43-427a-9c0e-3e77c947dea7	SE016	3	W	f	CV027	f	2022-08-09 15:20:42.988164	2022-08-09 15:20:42.988164
2c1d86c0-6a4b-421a-bd0d-d40ada5bf415	SE016	3	Z	f	CV027	f	2022-08-09 15:20:42.993678	2022-08-09 15:20:42.993678
b6f6db95-6712-4fa8-8fb6-8f08e3d1ec9e	SE016	3	D	t	CV117	f	2022-08-09 15:20:43.00475	2022-08-09 15:20:43.00475
de4d9ef1-142c-42e3-b49f-e35c5154a66e	SE016	3	I	t	CV117	f	2022-08-09 15:20:43.010092	2022-08-09 15:20:43.010092
ddb1b1f9-5dc2-4efb-89c3-cd8565b1b853	SE016	3	W	t	CV117	f	2022-08-09 15:20:43.015671	2022-08-09 15:20:43.015671
df9d5501-5112-4e41-abe1-aac32fc899b6	SE016	3	Z	t	CV117	f	2022-08-09 15:20:43.021044	2022-08-09 15:20:43.021044
ab6009cd-7100-4548-b09d-715775b8eedf	SE016	3	A	f	CV117	f	2022-08-09 15:20:43.026547	2022-08-09 15:20:43.026547
4f2a06da-86a0-4380-99dc-fa54fc0d1bdb	SE016	3	D	f	CV117	f	2022-08-09 15:20:43.03212	2022-08-09 15:20:43.03212
5221e8a3-e413-423a-a833-849c16c2b223	SE016	3	I	f	CV117	f	2022-08-09 15:20:43.037594	2022-08-09 15:20:43.037594
ecd6ef50-8a66-4836-906e-ee0581b6e144	SE016	3	W	f	CV117	f	2022-08-09 15:20:43.042936	2022-08-09 15:20:43.042936
0008c1aa-10cd-4684-86e1-01afb4186c9d	SE016	3	Z	f	CV117	f	2022-08-09 15:20:43.048459	2022-08-09 15:20:43.048459
328bca3b-95db-4ba4-a9c5-a6766f2a4fbf	SE016	3	A	t	CV118	f	2022-08-09 15:20:43.05376	2022-08-09 15:20:43.05376
ee4e9bdf-2327-4b03-9de4-ba6ac518fd2e	SE016	3	A	f	CV118	f	2022-08-09 15:20:43.081761	2022-08-09 15:20:43.081761
1ad3555e-94ca-4b2e-9739-d76fbe8593cc	SE016	3	D	f	CV118	f	2022-08-09 15:20:43.088568	2022-08-09 15:20:43.088568
83beccf7-2400-43ea-b495-ac6231578cb9	SE016	3	I	f	CV118	f	2022-08-09 15:20:43.094301	2022-08-09 15:20:43.094301
a1ea9beb-cb47-4925-a62f-aff8c3abce58	SE016	3	W	f	CV118	f	2022-08-09 15:20:43.099997	2022-08-09 15:20:43.099997
1868950f-91a8-460b-944d-7bbbe79c2dde	SE016	3	Z	f	CV118	f	2022-08-09 15:20:43.105782	2022-08-09 15:20:43.105782
fd27ece9-294c-43ff-9178-901d9710a43a	SE016	3	A	t	FM007	f	2022-08-09 15:20:43.11156	2022-08-09 15:20:43.11156
46f1a4b2-df55-43a6-a03f-7d2aed34a653	SE016	3	D	t	FM007	f	2022-08-09 15:20:43.118191	2022-08-09 15:20:43.118191
9403b974-b506-470c-8be4-ef131ea91bd6	SE016	3	I	t	FM007	f	2022-08-09 15:20:43.124094	2022-08-09 15:20:43.124094
b1cd42bf-0ea4-42da-b954-80e8eb3af329	SE016	3	W	t	FM007	f	2022-08-09 15:20:43.129524	2022-08-09 15:20:43.129524
dc8e5c62-44c0-488d-a16f-4e17af693715	SE016	3	Z	t	FM007	f	2022-08-09 15:20:43.135382	2022-08-09 15:20:43.135382
fe4b7f39-f4a2-417b-95da-ffcebace4f6e	SE016	3	A	f	FM007	f	2022-08-09 15:20:43.140807	2022-08-09 15:20:43.140807
1b5b4d67-94c8-4bae-917c-66bb651c72ab	SE016	3	D	f	FM007	f	2022-08-09 15:20:43.146621	2022-08-09 15:20:43.146621
e08a17c0-3aed-4fe7-951d-10707594098c	SE016	3	I	f	FM007	f	2022-08-09 15:20:43.151977	2022-08-09 15:20:43.151977
45299689-4ac8-4fff-aa29-431f73baa19f	SE016	3	W	f	FM007	f	2022-08-09 15:20:43.157698	2022-08-09 15:20:43.157698
8ca60b4c-6289-4c81-a69d-2156b72eaaee	SE016	3	Z	f	FM007	f	2022-08-09 15:20:43.163037	2022-08-09 15:20:43.163037
d9495000-7bcb-4ac5-9909-b7514560e449	SE016	3	A	t	FM019	f	2022-08-09 15:20:43.168649	2022-08-09 15:20:43.168649
5f55e067-9894-4959-a731-c59c16669132	SE016	3	D	t	FM019	f	2022-08-09 15:20:43.174005	2022-08-09 15:20:43.174005
b3ad6589-2a47-4972-b43d-c082c9194d68	SE016	3	I	t	FM019	f	2022-08-09 15:20:43.180468	2022-08-09 15:20:43.180468
e1ef07fb-1112-44fe-a5fb-f5e627bd9614	SE016	3	W	t	FM019	f	2022-08-09 15:20:43.185945	2022-08-09 15:20:43.185945
72cf766a-99bc-479b-984e-0f0209e89a99	SE016	3	Z	t	FM019	f	2022-08-09 15:20:43.191739	2022-08-09 15:20:43.191739
04695f31-6171-40f0-9841-af7a901a90bd	SE016	3	A	f	FM019	f	2022-08-09 15:20:43.197313	2022-08-09 15:20:43.197313
da8fa932-27b7-4d1c-89ab-8d89ee7296b4	SE016	3	D	f	FM019	f	2022-08-09 15:20:43.202994	2022-08-09 15:20:43.202994
09591147-a06a-4522-800a-89ef768cf340	SE016	3	I	f	FM019	f	2022-08-09 15:20:43.208469	2022-08-09 15:20:43.208469
8a45dcae-866f-44d8-bef6-6c69818ceae3	SE016	3	W	f	FM019	f	2022-08-09 15:20:43.214227	2022-08-09 15:20:43.214227
05ebbfa8-4d1c-4a4f-8a84-cec3a1388614	SE016	3	Z	f	FM019	f	2022-08-09 15:20:43.219535	2022-08-09 15:20:43.219535
c7b7db86-119b-42c9-b05c-50407234cca1	SE016	3	A	t	FM039	f	2022-08-09 15:20:43.224883	2022-08-09 15:20:43.224883
e5360e04-61f9-41cb-be9c-7458536b59e3	SE016	3	D	t	FM039	f	2022-08-09 15:20:43.23062	2022-08-09 15:20:43.23062
ca4b5f44-ad4f-40bf-a587-30ea54e47c96	SE016	3	I	t	FM039	f	2022-08-09 15:20:43.236329	2022-08-09 15:20:43.236329
fa955a0e-24d4-4088-a7dc-53a4972dfff1	SE016	3	W	t	FM039	f	2022-08-09 15:20:43.241861	2022-08-09 15:20:43.241861
089cc815-da38-41ba-90ce-5735e10203b1	SE016	3	Z	t	FM039	f	2022-08-09 15:20:43.247487	2022-08-09 15:20:43.247487
cf23cac7-4eb1-44ad-9aed-d3e14034bfcb	SE016	3	A	f	FM039	f	2022-08-09 15:20:43.253077	2022-08-09 15:20:43.253077
e098e77b-4bc5-4432-902a-9a7228af85ce	SE016	3	D	f	FM039	f	2022-08-09 15:20:43.258813	2022-08-09 15:20:43.258813
58c11612-bc84-4334-b73d-fcac79a9614a	SE016	3	I	f	FM039	f	2022-08-09 15:20:43.264142	2022-08-09 15:20:43.264142
2d02c120-bf2b-4093-bebb-86c3abf16bca	SE016	3	W	f	FM039	f	2022-08-09 15:20:43.269832	2022-08-09 15:20:43.269832
57ccd08a-11d1-4d75-a0ae-c0b490dd8de1	SE016	3	Z	f	FM039	f	2022-08-09 15:20:43.275261	2022-08-09 15:20:43.275261
fd476cbc-2fd7-4ce0-b5dc-cfe4eeda7748	SE016	3	A	t	FM049	f	2022-08-09 15:20:43.280583	2022-08-09 15:20:43.280583
f179e65b-3bb2-4e3d-9e44-6eb205d5fee3	SE016	3	D	t	FM049	f	2022-08-09 15:20:43.286296	2022-08-09 15:20:43.286296
fcdca249-af55-4de2-9748-07ceef0bf053	SE016	3	I	t	FM049	f	2022-08-09 15:20:43.291821	2022-08-09 15:20:43.291821
e7ab8528-d19b-4e39-b009-a97fe41380ea	SE016	3	W	t	FM049	f	2022-08-09 15:20:43.297322	2022-08-09 15:20:43.297322
f1054e2b-f7c8-4e73-a52d-5be92377645a	SE016	3	Z	t	FM049	f	2022-08-09 15:20:43.303014	2022-08-09 15:20:43.303014
cdce743e-bf62-4a7f-9195-76457f1a5eeb	SE016	3	A	f	FM049	t	2022-08-09 15:20:43.308639	2022-08-09 15:20:43.338294
7927ebda-0ef9-4133-886e-401b60382aa6	SE016	3	D	f	FM049	t	2022-08-09 15:20:43.314469	2022-08-09 15:20:43.345884
d0cdaedc-44ca-454f-a11f-2e1b22eddb98	SE016	3	I	f	FM049	t	2022-08-09 15:20:43.320149	2022-08-09 15:20:43.354936
17b4598e-4bda-4176-ad1f-070161d4f095	SE016	3	W	f	FM049	t	2022-08-09 15:20:43.325303	2022-08-09 15:20:43.362497
e29a4f29-aa8c-40f6-ba36-05667f069cbc	SE016	3	Z	f	FM049	t	2022-08-09 15:20:43.331207	2022-08-09 15:20:43.370696
568f4e85-dcb8-478c-8fc0-cef988efef7a	SE016	3	A	t	CV117	t	2022-08-09 15:20:42.999407	2022-08-09 15:20:43.379204
7da9e12f-564b-42c0-b69a-209a4dae8e5f	SE016	3	D	t	CV118	t	2022-08-09 15:20:43.059656	2022-08-09 15:20:43.387703
b196ac04-0467-4b51-8b93-c5e1ed31e6ec	SE016	3	I	t	CV118	t	2022-08-09 15:20:43.065023	2022-08-09 15:20:43.394909
b8310e52-3746-4fc0-b94c-ef3eeb678892	SE016	3	W	t	CV118	t	2022-08-09 15:20:43.070368	2022-08-09 15:20:43.40266
010eeaec-bdb3-40e9-ba45-36931ec8e4e5	SE016	3	Z	t	CV118	t	2022-08-09 15:20:43.075831	2022-08-09 15:20:43.410067
4cc9d6a6-8105-4417-82fb-f637e0e46ceb	SE095	3	A	t	CV027	f	2022-08-09 15:20:43.415881	2022-08-09 15:20:43.415881
e28284b4-dc46-4ab2-8fb2-da27d6b1fdd1	SE095	3	D	t	CV027	f	2022-08-09 15:20:43.421267	2022-08-09 15:20:43.421267
9e3f5a78-b750-462a-a91e-d9272d34c743	SE095	3	I	t	CV027	f	2022-08-09 15:20:43.427102	2022-08-09 15:20:43.427102
fa9fd02b-ad02-4477-a74f-806e1780ecfa	SE095	3	W	t	CV027	f	2022-08-09 15:20:43.432975	2022-08-09 15:20:43.432975
a12c2ff6-ad40-414d-84e8-ed90bd11ae3b	SE095	3	Z	t	CV027	f	2022-08-09 15:20:43.438399	2022-08-09 15:20:43.438399
ef246e5b-47ac-44e4-8641-6e512d28a6e9	SE095	3	A	f	CV027	f	2022-08-09 15:20:43.443936	2022-08-09 15:20:43.443936
5caff7ce-8221-45f4-8b4f-7764cf18a5e0	SE095	3	D	f	CV027	f	2022-08-09 15:20:43.45044	2022-08-09 15:20:43.45044
fbbbbd83-2901-4dc6-800c-d19a199536b1	SE095	3	I	f	CV027	f	2022-08-09 15:20:43.456264	2022-08-09 15:20:43.456264
b0b6b86d-74a9-4db6-8328-62f4fead2bb9	SE095	3	W	f	CV027	f	2022-08-09 15:20:43.461719	2022-08-09 15:20:43.461719
c0767313-757a-4e53-8856-c5039704d83a	SE095	3	Z	f	CV027	f	2022-08-09 15:20:43.467616	2022-08-09 15:20:43.467616
f93e7cb9-8ecc-4931-99d2-90ad01b1afd9	SE095	3	D	t	CV117	f	2022-08-09 15:20:43.479579	2022-08-09 15:20:43.479579
6041a337-354a-4a76-88e1-6daa31c74b19	SE095	3	I	t	CV117	f	2022-08-09 15:20:43.48541	2022-08-09 15:20:43.48541
cb9123cc-52df-4532-bbec-f5208317fa07	SE095	3	W	t	CV117	f	2022-08-09 15:20:43.490812	2022-08-09 15:20:43.490812
0e4cea85-5705-4594-8445-b6fcf33a2166	SE095	3	Z	t	CV117	f	2022-08-09 15:20:43.496525	2022-08-09 15:20:43.496525
39371634-e673-4d60-90ad-b3c1b71c4e39	SE095	3	A	f	CV117	f	2022-08-09 15:20:43.50207	2022-08-09 15:20:43.50207
7de711b6-e11c-41c7-8d67-0e8ffe33eaf5	SE095	3	D	f	CV117	f	2022-08-09 15:20:43.50782	2022-08-09 15:20:43.50782
adb62b24-7368-43d1-908b-a734b2f703b2	SE095	3	I	f	CV117	f	2022-08-09 15:20:43.513469	2022-08-09 15:20:43.513469
b4f2bc8a-16f2-451b-b403-d423b8f988ed	SE095	3	W	f	CV117	f	2022-08-09 15:20:43.518842	2022-08-09 15:20:43.518842
e618dd11-e744-4075-99a7-4c1c890f3740	SE095	3	Z	f	CV117	f	2022-08-09 15:20:43.525074	2022-08-09 15:20:43.525074
f8d616ee-0acd-4b9e-94da-ee899b67d24a	SE095	3	A	t	CV118	f	2022-08-09 15:20:43.530514	2022-08-09 15:20:43.530514
138a1b48-93ad-4a53-906f-3761239a53b2	SE095	3	A	f	CV118	f	2022-08-09 15:20:43.559456	2022-08-09 15:20:43.559456
d076711a-115f-4767-9b1a-1854d4fc83af	SE095	3	D	f	CV118	f	2022-08-09 15:20:43.564971	2022-08-09 15:20:43.564971
df336956-7079-4d28-97eb-c6548f40f844	SE095	3	I	f	CV118	f	2022-08-09 15:20:43.57033	2022-08-09 15:20:43.57033
95ae03aa-acb9-43a8-bd75-32b8d4bf88ab	SE095	3	W	f	CV118	f	2022-08-09 15:20:43.57602	2022-08-09 15:20:43.57602
e489781a-931e-41c7-94ba-93f05b12a916	SE095	3	Z	f	CV118	f	2022-08-09 15:20:43.581454	2022-08-09 15:20:43.581454
234de167-6e62-4d0c-817d-182607de6459	SE095	3	A	t	FM007	f	2022-08-09 15:20:43.586866	2022-08-09 15:20:43.586866
ad94859b-3b79-472b-b6dc-d95872c10e3b	SE095	3	D	t	FM007	f	2022-08-09 15:20:43.592689	2022-08-09 15:20:43.592689
1e989061-97cc-43ab-8dc9-b2a69dd5fe7d	SE095	3	I	t	FM007	f	2022-08-09 15:20:43.598336	2022-08-09 15:20:43.598336
738e9108-e2a6-4547-9598-ce91e1ec1ffe	SE095	3	W	t	FM007	f	2022-08-09 15:20:43.604075	2022-08-09 15:20:43.604075
3c0b33a1-4e58-4834-b3e5-3be8094d10e0	SE095	3	Z	t	FM007	f	2022-08-09 15:20:43.609363	2022-08-09 15:20:43.609363
4de3db68-600c-4a64-8c80-7bf4c4dca139	SE095	3	A	f	FM007	f	2022-08-09 15:20:43.614791	2022-08-09 15:20:43.614791
9696d63b-0da1-46ec-a9ee-38c9b497e61b	SE095	3	D	f	FM007	f	2022-08-09 15:20:43.620869	2022-08-09 15:20:43.620869
31f4d819-118c-456d-8301-bd98c89265d5	SE095	3	I	f	FM007	f	2022-08-09 15:20:43.627135	2022-08-09 15:20:43.627135
e2ba7d24-4ea5-4baf-a7f3-8087a35b5f95	SE095	3	W	f	FM007	f	2022-08-09 15:20:43.642083	2022-08-09 15:20:43.642083
35964171-f75b-417e-9fd7-538af1abab82	SE095	3	Z	f	FM007	f	2022-08-09 15:20:43.650682	2022-08-09 15:20:43.650682
88f66333-7455-43c0-9e37-840267cda7d0	SE095	3	A	t	FM019	f	2022-08-09 15:20:43.657648	2022-08-09 15:20:43.657648
b48c55c8-b911-4e3d-be6f-2733e1f8f427	SE095	3	D	t	FM019	f	2022-08-09 15:20:43.664168	2022-08-09 15:20:43.664168
8fd13a50-a018-4f8f-9e38-b47ad6aceb3f	SE095	3	I	t	FM019	f	2022-08-09 15:20:43.669797	2022-08-09 15:20:43.669797
bcc1a195-7eb2-46b4-a11f-2e2caaadff27	SE095	3	W	t	FM019	f	2022-08-09 15:20:43.675262	2022-08-09 15:20:43.675262
a03918be-22fb-4871-b1b2-d5242b672582	SE095	3	Z	t	FM019	f	2022-08-09 15:20:43.680993	2022-08-09 15:20:43.680993
8cdbcec0-156d-4301-bc80-b90a1690fa7e	SE095	3	A	f	FM019	f	2022-08-09 15:20:43.686565	2022-08-09 15:20:43.686565
29346860-28aa-4de6-88a2-07fd751a2ae4	SE095	3	D	f	FM019	f	2022-08-09 15:20:43.692584	2022-08-09 15:20:43.692584
85ccb03c-6b76-45e0-8d06-282dfcf824fc	SE095	3	I	f	FM019	f	2022-08-09 15:20:43.698239	2022-08-09 15:20:43.698239
86286dd8-e09d-46d2-934d-b50bcea25ee2	SE095	3	W	f	FM019	f	2022-08-09 15:20:43.703646	2022-08-09 15:20:43.703646
cc091c88-5360-4f32-b735-37fb5de4c9f7	SE095	3	Z	f	FM019	f	2022-08-09 15:20:43.710483	2022-08-09 15:20:43.710483
36391cc3-0f9b-4707-b7bf-720eadc5ed0f	SE095	3	A	t	FM039	f	2022-08-09 15:20:43.716681	2022-08-09 15:20:43.716681
8adb429d-b18d-4c78-a686-722929898d8e	SE095	3	D	t	FM039	f	2022-08-09 15:20:43.722642	2022-08-09 15:20:43.722642
cb616710-2584-4bf8-aeb8-443675045c47	SE095	3	I	t	FM039	f	2022-08-09 15:20:43.728877	2022-08-09 15:20:43.728877
153db246-abed-475b-81c5-a448d55b33d4	SE095	3	W	t	FM039	f	2022-08-09 15:20:43.734506	2022-08-09 15:20:43.734506
84ebdd20-1159-4ce2-8ebe-f624aa9e9862	SE095	3	Z	t	FM039	f	2022-08-09 15:20:43.740288	2022-08-09 15:20:43.740288
ab0260a1-155d-4ecd-9da4-a32e148b6174	SE095	3	A	f	FM039	f	2022-08-09 15:20:43.746468	2022-08-09 15:20:43.746468
e991ba72-20e2-4f79-b483-21e25f27c8c8	SE095	3	D	f	FM039	f	2022-08-09 15:20:43.752418	2022-08-09 15:20:43.752418
bb9cb15a-dd81-4ac4-80d6-0b4af8b4ac1d	SE095	3	I	f	FM039	f	2022-08-09 15:20:43.758365	2022-08-09 15:20:43.758365
bf7df306-69e6-4536-9f39-7e6468bb7416	SE095	3	W	f	FM039	f	2022-08-09 15:20:43.763803	2022-08-09 15:20:43.763803
3d61dc0a-c727-4346-afaf-d6656e7361a1	SE095	3	Z	f	FM039	f	2022-08-09 15:20:43.77008	2022-08-09 15:20:43.77008
20a68b90-65dc-49c1-80b7-e78afdc0140f	SE095	3	A	t	FM049	f	2022-08-09 15:20:43.7759	2022-08-09 15:20:43.7759
e22727b3-cc8c-4525-a625-4e116ba61d4b	SE095	3	D	t	FM049	f	2022-08-09 15:20:43.782234	2022-08-09 15:20:43.782234
79f005cc-d60a-41c8-850c-33a51db10daf	SE095	3	I	t	FM049	f	2022-08-09 15:20:43.787784	2022-08-09 15:20:43.787784
c730cacd-ba4f-4fa4-8890-7658d5079431	SE095	3	W	t	FM049	f	2022-08-09 15:20:43.793152	2022-08-09 15:20:43.793152
d8eeb1ae-a0c0-40ae-b5b2-ac965d4ca774	SE095	3	Z	t	FM049	f	2022-08-09 15:20:43.800028	2022-08-09 15:20:43.800028
cee18512-ad8e-474c-846d-ae33f8ffddd7	SE095	3	A	f	FM049	t	2022-08-09 15:20:43.805625	2022-08-09 15:20:43.835652
9c5cded1-d63c-43fd-a75f-8905f585b253	SE095	3	D	f	FM049	t	2022-08-09 15:20:43.811577	2022-08-09 15:20:43.843212
d57687a6-4328-4dda-90c3-2bd1556b47a8	SE095	3	I	f	FM049	t	2022-08-09 15:20:43.81715	2022-08-09 15:20:43.850851
7a57c8b4-d703-489b-84f7-9fb1bca6e4cb	SE095	3	W	f	FM049	t	2022-08-09 15:20:43.822464	2022-08-09 15:20:43.857971
c84c6f93-1a03-4cca-aa78-749d0600c2be	SE095	3	Z	f	FM049	t	2022-08-09 15:20:43.828197	2022-08-09 15:20:43.865802
9951931f-6e99-4a5d-a98b-720cf1977804	SE095	3	A	t	CV117	t	2022-08-09 15:20:43.473251	2022-08-09 15:20:43.873108
6f28f208-b429-4b6e-ba7f-97a1834bfd6f	SE095	3	D	t	CV118	t	2022-08-09 15:20:43.53616	2022-08-09 15:20:43.881135
d59129d6-08ac-47ec-ab97-ef0c5ca8020a	SE095	3	I	t	CV118	t	2022-08-09 15:20:43.541363	2022-08-09 15:20:43.888421
01d0c255-df9b-4600-8a62-7429ae78dc36	SE095	3	W	t	CV118	t	2022-08-09 15:20:43.547054	2022-08-09 15:20:43.895679
ef4656b9-7bf7-49a4-96b0-54ea1a7d00cc	SE095	3	Z	t	CV118	t	2022-08-09 15:20:43.553061	2022-08-09 15:20:43.902781
faec5753-058a-43c7-a9d7-c7bca123dcbd	SE097	3	A	t	CV027	f	2022-08-09 15:20:43.908364	2022-08-09 15:20:43.908364
42574e5e-2c7f-46f4-8f1d-762cbb08ff85	SE097	3	D	t	CV027	f	2022-08-09 15:20:43.913753	2022-08-09 15:20:43.913753
66ddafdc-a998-4ac6-925d-95b00a3a33ad	SE097	3	I	t	CV027	f	2022-08-09 15:20:43.919013	2022-08-09 15:20:43.919013
e13cb108-48a3-4823-b488-189e21f188f8	SE097	3	W	t	CV027	f	2022-08-09 15:20:43.924537	2022-08-09 15:20:43.924537
716add5b-4772-4e7e-9e3c-659aff4fff8d	SE097	3	Z	t	CV027	f	2022-08-09 15:20:43.929814	2022-08-09 15:20:43.929814
99e26cd6-24b8-493c-b1a6-2edbd8717067	SE097	3	A	f	CV027	f	2022-08-09 15:20:43.935507	2022-08-09 15:20:43.935507
408ba527-d5aa-476a-8078-edecf56103a2	SE097	3	D	f	CV027	f	2022-08-09 15:20:43.94101	2022-08-09 15:20:43.94101
65770e70-0215-4b31-972c-7c4522aa62de	SE097	3	I	f	CV027	f	2022-08-09 15:20:43.946462	2022-08-09 15:20:43.946462
ce9da6ea-582f-44b3-b9eb-783bbcd11505	SE097	3	W	f	CV027	f	2022-08-09 15:20:43.952203	2022-08-09 15:20:43.952203
c1d456e6-0a3e-47c0-b98a-9188414375e4	SE097	3	Z	f	CV027	f	2022-08-09 15:20:43.957484	2022-08-09 15:20:43.957484
b310205a-e30e-4ac8-b63a-3db6aa4aa985	SE097	3	D	t	CV117	f	2022-08-09 15:20:43.968422	2022-08-09 15:20:43.968422
b8aa12a5-d89c-4f1f-9142-dfc74cce38fb	SE097	3	I	t	CV117	f	2022-08-09 15:20:43.973814	2022-08-09 15:20:43.973814
c01f25bb-0add-4063-b521-44a3f35e8864	SE097	3	W	t	CV117	f	2022-08-09 15:20:43.980147	2022-08-09 15:20:43.980147
aa605dbc-03e7-4a78-a8a1-a03d2d47feaa	SE097	3	Z	t	CV117	f	2022-08-09 15:20:43.985631	2022-08-09 15:20:43.985631
fb4f851d-c4b1-4d29-8446-0e67906bd5fd	SE097	3	A	f	CV117	f	2022-08-09 15:20:43.991434	2022-08-09 15:20:43.991434
092c880f-70d3-49a0-9861-02c0d478c003	SE097	3	D	f	CV117	f	2022-08-09 15:20:43.99687	2022-08-09 15:20:43.99687
830a2386-05fc-46f6-bc1a-446ec2bc5f2b	SE097	3	I	f	CV117	f	2022-08-09 15:20:44.002186	2022-08-09 15:20:44.002186
7f952235-0154-4208-80cf-5c12f1f7399d	SE097	3	W	f	CV117	f	2022-08-09 15:20:44.008154	2022-08-09 15:20:44.008154
5d512e96-6355-4fb8-9651-2176813e7238	SE097	3	Z	f	CV117	f	2022-08-09 15:20:44.013544	2022-08-09 15:20:44.013544
45ac7603-dfac-45f6-a1ee-385cd1f7ffc7	SE097	3	A	t	CV118	f	2022-08-09 15:20:44.018856	2022-08-09 15:20:44.018856
57e4ab28-7270-48de-97dc-55a23c67b28e	SE097	3	A	f	CV118	f	2022-08-09 15:20:44.046442	2022-08-09 15:20:44.046442
9cbb1e85-000e-4d4f-bf57-ab0b2772f821	SE097	3	D	f	CV118	f	2022-08-09 15:20:44.051761	2022-08-09 15:20:44.051761
fd24b91a-cfeb-4455-9d5d-c88dc1b2f48f	SE097	3	I	f	CV118	f	2022-08-09 15:20:44.057405	2022-08-09 15:20:44.057405
a773b4b9-9f5f-4829-aece-8de6da9aef15	SE097	3	W	f	CV118	f	2022-08-09 15:20:44.062698	2022-08-09 15:20:44.062698
63ed8a44-4aae-4b52-92d2-d5ca46fac928	SE097	3	Z	f	CV118	f	2022-08-09 15:20:44.068345	2022-08-09 15:20:44.068345
e2d372d4-33c7-40a9-a84e-3c0354e226a4	SE097	3	A	t	FM007	f	2022-08-09 15:20:44.073649	2022-08-09 15:20:44.073649
fe4c485f-3852-49ea-a724-b01f00c13fcc	SE097	3	D	t	FM007	f	2022-08-09 15:20:44.079333	2022-08-09 15:20:44.079333
178629be-9c8f-4706-a31d-add848dd8773	SE097	3	I	t	FM007	f	2022-08-09 15:20:44.087276	2022-08-09 15:20:44.087276
f28408b0-db63-4185-a01e-4f435cdc9a9a	SE097	3	W	t	FM007	f	2022-08-09 15:20:44.093012	2022-08-09 15:20:44.093012
eab00643-77bc-458d-b7cf-a4260b68cd2c	SE097	3	Z	t	FM007	f	2022-08-09 15:20:44.098697	2022-08-09 15:20:44.098697
9eda59f6-6793-46d7-9442-f8e83cdd04af	SE097	3	A	f	FM007	f	2022-08-09 15:20:44.10438	2022-08-09 15:20:44.10438
7a0599fd-0509-4ea9-a0f1-89c69e706727	SE097	3	D	f	FM007	f	2022-08-09 15:20:44.110201	2022-08-09 15:20:44.110201
42112aef-9ca5-4c48-97e3-ebf915af5e40	SE097	3	I	f	FM007	f	2022-08-09 15:20:44.115931	2022-08-09 15:20:44.115931
1a37b96a-86f3-4791-8405-c3ad37e8514b	SE097	3	W	f	FM007	f	2022-08-09 15:20:44.123441	2022-08-09 15:20:44.123441
90655868-c1f2-487f-beb0-b6d44fd9ca67	SE097	3	Z	f	FM007	f	2022-08-09 15:20:44.129275	2022-08-09 15:20:44.129275
9e201ec2-a2c8-49b3-aab7-7d02f86c5a99	SE097	3	A	t	FM019	f	2022-08-09 15:20:44.135001	2022-08-09 15:20:44.135001
9eed5b98-d2ac-4517-9584-5f5811eeda14	SE097	3	D	t	FM019	f	2022-08-09 15:20:44.14054	2022-08-09 15:20:44.14054
3b3834a9-edc1-484d-ad5d-8b02826c07a2	SE097	3	I	t	FM019	f	2022-08-09 15:20:44.146396	2022-08-09 15:20:44.146396
f4835af4-e76b-425d-b693-38c0a516be99	SE097	3	W	t	FM019	f	2022-08-09 15:20:44.15181	2022-08-09 15:20:44.15181
0bacce31-9e7e-4563-9a3b-032d0fb7556d	SE097	3	Z	t	FM019	f	2022-08-09 15:20:44.157511	2022-08-09 15:20:44.157511
0c94a298-aefd-40d8-b821-b78abd08e3b0	SE097	3	A	f	FM019	f	2022-08-09 15:20:44.163367	2022-08-09 15:20:44.163367
9cba5d6f-8cbb-4153-971a-9883b13b41dc	SE097	3	D	f	FM019	f	2022-08-09 15:20:44.168742	2022-08-09 15:20:44.168742
730b3901-8d9d-44bb-ab9f-8dd25687897a	SE097	3	I	f	FM019	f	2022-08-09 15:20:44.17456	2022-08-09 15:20:44.17456
0338e63e-24e7-4f47-a9fe-7a5c41066708	SE097	3	W	f	FM019	f	2022-08-09 15:20:44.180271	2022-08-09 15:20:44.180271
6fb991e7-0c76-4e10-8b5f-9f722ff2eb5f	SE097	3	Z	f	FM019	f	2022-08-09 15:20:44.186289	2022-08-09 15:20:44.186289
f2948f6e-b4b2-4385-8229-64fea0bd292e	SE097	3	A	t	FM039	f	2022-08-09 15:20:44.191662	2022-08-09 15:20:44.191662
7979a4aa-e805-4316-8ad6-bde7b6a0944f	SE097	3	D	t	FM039	f	2022-08-09 15:20:44.19692	2022-08-09 15:20:44.19692
4892d3ca-6300-4ac9-ae39-e962cd9ae04b	SE097	3	I	t	FM039	f	2022-08-09 15:20:44.202557	2022-08-09 15:20:44.202557
d78294c7-b4fa-4bf1-95f7-2775c8385eca	SE097	3	W	t	FM039	f	2022-08-09 15:20:44.207909	2022-08-09 15:20:44.207909
bb20b831-8d05-460d-8b5a-f9e15e0e5c30	SE097	3	Z	t	FM039	f	2022-08-09 15:20:44.213484	2022-08-09 15:20:44.213484
61fa3cbc-8a54-44f7-bb5b-c6ba6c9bbece	SE097	3	A	f	FM039	f	2022-08-09 15:20:44.218882	2022-08-09 15:20:44.218882
138bf22d-ccef-48fa-a3b8-5739ecd39dc0	SE097	3	D	f	FM039	f	2022-08-09 15:20:44.224527	2022-08-09 15:20:44.224527
d0e88e20-fd2b-4e88-af30-c106c861b39f	SE097	3	I	f	FM039	f	2022-08-09 15:20:44.230142	2022-08-09 15:20:44.230142
50c27d55-9bf1-4aa2-99a0-60d2e8b52259	SE097	3	W	f	FM039	f	2022-08-09 15:20:44.235433	2022-08-09 15:20:44.235433
c5b7e87a-65a5-4871-a2a8-0a3ccc8f8b55	SE097	3	Z	f	FM039	f	2022-08-09 15:20:44.24088	2022-08-09 15:20:44.24088
626d8506-4d7c-4e90-a4df-6838549fe280	SE097	3	A	t	FM049	f	2022-08-09 15:20:44.246431	2022-08-09 15:20:44.246431
616482e1-5697-4f2b-b962-e5a1e35e46f6	SE097	3	D	t	FM049	f	2022-08-09 15:20:44.251748	2022-08-09 15:20:44.251748
57544abe-d812-42be-a672-423533878249	SE097	3	I	t	FM049	f	2022-08-09 15:20:44.257525	2022-08-09 15:20:44.257525
97cd978c-c5bd-40b8-89ec-e57bcecd294e	SE097	3	W	t	FM049	f	2022-08-09 15:20:44.26282	2022-08-09 15:20:44.26282
545ad449-9d9c-47ec-b87b-229538e6f7b6	SE097	3	Z	t	FM049	f	2022-08-09 15:20:44.268549	2022-08-09 15:20:44.268549
8f450c58-8252-41d4-aa33-0a870901971d	SE097	3	A	f	FM049	t	2022-08-09 15:20:44.274032	2022-08-09 15:20:44.303165
786ce459-4aaf-4af9-92c7-f4901e03fda7	SE097	3	D	f	FM049	t	2022-08-09 15:20:44.279684	2022-08-09 15:20:44.310906
87e06003-628b-42bb-91c7-1a28459fc30b	SE097	3	I	f	FM049	t	2022-08-09 15:20:44.285111	2022-08-09 15:20:44.318644
e80a5d5e-8ab0-44a1-adef-bbc2edac196d	SE097	3	W	f	FM049	t	2022-08-09 15:20:44.290456	2022-08-09 15:20:44.326127
4cd36162-e325-4ea3-809c-8e256e0275f0	SE097	3	Z	f	FM049	t	2022-08-09 15:20:44.296065	2022-08-09 15:20:44.333328
cae39bfd-2199-46f1-a2e0-caec0c859190	SE097	3	A	t	CV117	t	2022-08-09 15:20:43.963203	2022-08-09 15:20:44.340418
a750d667-5e5a-425d-8234-f3b7c8a91212	SE097	3	D	t	CV118	t	2022-08-09 15:20:44.024648	2022-08-09 15:20:44.348159
f3ba0f3e-3569-44e5-9bdf-77a154112357	SE097	3	I	t	CV118	t	2022-08-09 15:20:44.030054	2022-08-09 15:20:44.356866
abb4c567-4bfc-4327-8d5d-f919a01eac64	SE097	3	W	t	CV118	t	2022-08-09 15:20:44.035451	2022-08-09 15:20:44.364614
4f2b9e09-3c33-4b2d-ad95-ef372dfe1e48	SE097	3	Z	t	CV118	t	2022-08-09 15:20:44.041064	2022-08-09 15:20:44.372935
c856bce7-c4ae-47f3-9c47-e815c1951bea	SE003A	3	A	t	APL09	f	2022-08-09 15:20:44.378747	2022-08-09 15:20:44.378747
a4c440e1-7921-4fce-88af-45c1ad537107	SE003A	3	D	t	APL09	f	2022-08-09 15:20:44.385027	2022-08-09 15:20:44.385027
b22f1892-4e28-4123-849a-7ed7f603c311	SE003A	3	I	t	APL09	f	2022-08-09 15:20:44.390746	2022-08-09 15:20:44.390746
e2342ff5-33cb-4e68-ae8f-3832ef1268ce	SE003A	3	W	t	APL09	f	2022-08-09 15:20:44.396413	2022-08-09 15:20:44.396413
a38c2cae-a6de-4581-8b82-86ee725b74c7	SE003A	3	Z	t	APL09	f	2022-08-09 15:20:44.40213	2022-08-09 15:20:44.40213
85f8accf-3f18-4e0d-a77e-b405e0fea857	SE003A	3	A	f	APL09	f	2022-08-09 15:20:44.407566	2022-08-09 15:20:44.407566
1a4e8694-c2ae-4b3f-a3a3-04e10de6ed31	SE003A	3	D	f	APL09	f	2022-08-09 15:20:44.413489	2022-08-09 15:20:44.413489
016f4f33-3e6f-47f4-9c69-fad3da228e97	SE003A	3	I	f	APL09	f	2022-08-09 15:20:44.418986	2022-08-09 15:20:44.418986
4e92312a-12ef-4aca-a5c9-80e0ece6f2f3	SE003A	3	W	f	APL09	f	2022-08-09 15:20:44.424493	2022-08-09 15:20:44.424493
a178ed93-a18a-4efb-a18f-ba63bd71a6dd	SE003A	3	Z	f	APL09	f	2022-08-09 15:20:44.429771	2022-08-09 15:20:44.429771
534662b9-1638-4ad4-87f2-d31456b61a25	SE003A	3	A	t	APL07	f	2022-08-09 15:20:44.435623	2022-08-09 15:20:44.435623
fcd5cf60-50b6-4a02-b0f2-8acefd1a0ef2	SE003A	3	D	t	APL07	f	2022-08-09 15:20:44.44128	2022-08-09 15:20:44.44128
777832d6-c2db-4ff1-9bc9-1709bb03a246	SE003A	3	I	t	APL07	f	2022-08-09 15:20:44.44699	2022-08-09 15:20:44.44699
de78fd57-6755-4858-b465-bde3272a8f58	SE003A	3	W	t	APL07	f	2022-08-09 15:20:44.454063	2022-08-09 15:20:44.454063
766868ef-6588-4228-908d-451b980ffb55	SE003A	3	Z	t	APL07	f	2022-08-09 15:20:44.459556	2022-08-09 15:20:44.459556
be1df29b-caef-454d-b631-4963af086137	SE003A	3	A	f	APL07	f	2022-08-09 15:20:44.465298	2022-08-09 15:20:44.465298
c11d3aa2-df4f-4ebd-a92a-37bda85c786a	SE003A	3	D	f	APL07	f	2022-08-09 15:20:44.470695	2022-08-09 15:20:44.470695
d3a72dd3-9223-466e-9b41-8b54415a876e	SE003A	3	I	f	APL07	f	2022-08-09 15:20:44.476493	2022-08-09 15:20:44.476493
bb7c3803-dce3-435e-a54d-2b0717ba3a2b	SE003A	3	W	f	APL07	f	2022-08-09 15:20:44.482261	2022-08-09 15:20:44.482261
2d3bc3c0-9ee3-4399-b850-0c0ae4300d52	SE003A	3	Z	f	APL07	f	2022-08-09 15:20:44.487854	2022-08-09 15:20:44.487854
6432874e-6f65-402a-806d-8b6cc0ed839b	SE003A	3	A	t	APL11	f	2022-08-09 15:20:44.493566	2022-08-09 15:20:44.493566
7adfdf08-4ffb-4202-9587-400947d37aa7	SE003A	3	D	t	APL11	f	2022-08-09 15:20:44.499034	2022-08-09 15:20:44.499034
bcab01f7-0266-4ed6-afeb-58bca4136a44	SE003A	3	I	t	APL11	f	2022-08-09 15:20:44.504977	2022-08-09 15:20:44.504977
94e1784a-448e-4c75-a0a4-97166d692e6a	SE003A	3	W	t	APL11	f	2022-08-09 15:20:44.510548	2022-08-09 15:20:44.510548
7fe4bd6e-ed1f-4125-95fd-81a8735e3cb6	SE003A	3	Z	t	APL11	f	2022-08-09 15:20:44.516317	2022-08-09 15:20:44.516317
8fcd5dad-0eba-4465-b3e6-a662b39dfe4c	SE003A	3	A	f	APL11	f	2022-08-09 15:20:44.52182	2022-08-09 15:20:44.52182
f6f5df29-b80e-4110-8747-682c29e7b228	SE003A	3	D	f	APL11	f	2022-08-09 15:20:44.527808	2022-08-09 15:20:44.527808
c32c861a-f9fa-4619-914a-0b2a93aca763	SE003A	3	I	f	APL11	f	2022-08-09 15:20:44.533114	2022-08-09 15:20:44.533114
f84a9752-1e28-458b-b4c9-045fcbc322bf	SE003A	3	W	f	APL11	f	2022-08-09 15:20:44.538577	2022-08-09 15:20:44.538577
642c6f95-fa32-4080-b331-436bccf15e24	SE003A	3	Z	f	APL11	f	2022-08-09 15:20:44.54389	2022-08-09 15:20:44.54389
e118b7e2-74d5-4f77-acfa-894c83e69e63	SE003A	3	A	t	APL13	f	2022-08-09 15:20:44.549191	2022-08-09 15:20:44.549191
6f6aaef3-50d5-4aff-895e-cadfa74bcda9	SE003A	3	D	t	APL13	f	2022-08-09 15:20:44.554815	2022-08-09 15:20:44.554815
9da4dba4-467b-4154-84e4-eb201ace34ec	SE003A	3	I	t	APL13	f	2022-08-09 15:20:44.560338	2022-08-09 15:20:44.560338
090628e5-0762-43e4-a142-9a18972d579a	SE003A	3	W	t	APL13	f	2022-08-09 15:20:44.565891	2022-08-09 15:20:44.565891
a9857037-1644-4c81-a48d-9ba92657ab42	SE003A	3	Z	t	APL13	f	2022-08-09 15:20:44.571041	2022-08-09 15:20:44.571041
499c6f66-3a73-4a9f-bed0-4e584ac27d33	SE003A	3	A	f	APL13	f	2022-08-09 15:20:44.576333	2022-08-09 15:20:44.576333
9cd6205a-a27a-4619-b454-719574de3cf2	SE003A	3	D	f	APL13	f	2022-08-09 15:20:44.582137	2022-08-09 15:20:44.582137
4144db40-e8ab-4909-b578-16d373da3b09	SE003A	3	I	f	APL13	f	2022-08-09 15:20:44.587509	2022-08-09 15:20:44.587509
416c3e52-5b36-4a4b-98b6-6c999dc3f72f	SE003A	3	W	f	APL13	f	2022-08-09 15:20:44.594223	2022-08-09 15:20:44.594223
b78d490d-ef0c-4d31-a866-3cd8676af225	SE003A	3	Z	f	APL13	f	2022-08-09 15:20:44.600695	2022-08-09 15:20:44.600695
6947dd63-0e31-4202-b703-34184688fa47	SE003A	3	A	t	APL15	f	2022-08-09 15:20:44.60661	2022-08-09 15:20:44.60661
6e115cdf-c616-497a-a13c-d56d7ed4a560	SE003A	3	D	t	APL15	f	2022-08-09 15:20:44.612354	2022-08-09 15:20:44.612354
37ec24dc-a0ae-4e58-935a-20267d75e338	SE003A	3	I	t	APL15	f	2022-08-09 15:20:44.617744	2022-08-09 15:20:44.617744
b325856c-c378-424f-8cf0-70f633ac1872	SE003A	3	W	t	APL15	f	2022-08-09 15:20:44.623049	2022-08-09 15:20:44.623049
49957647-e8a4-4d3e-ad03-105eec64a0b7	SE003A	3	Z	t	APL15	f	2022-08-09 15:20:44.628654	2022-08-09 15:20:44.628654
7d657e66-1a84-4f59-bbd3-d14ca4d5af1c	SE003A	3	A	f	APL15	f	2022-08-09 15:20:44.633993	2022-08-09 15:20:44.633993
ba494819-17e9-4d0e-8bad-dd267501cd3f	SE003A	3	D	f	APL15	f	2022-08-09 15:20:44.639557	2022-08-09 15:20:44.639557
a3ed6ce8-3b80-4417-b7ac-fb76410349f5	SE003A	3	I	f	APL15	f	2022-08-09 15:20:44.645174	2022-08-09 15:20:44.645174
b8bbe2e9-26c6-4f0d-aa30-da8b420a5685	SE003A	3	W	f	APL15	f	2022-08-09 15:20:44.650774	2022-08-09 15:20:44.650774
55d33e91-7fe9-4a27-be08-542ace5614d5	SE003A	3	Z	f	APL15	f	2022-08-09 15:20:44.656402	2022-08-09 15:20:44.656402
6bb85a9d-e702-42dc-9733-c2ef965b4ede	SE003A	3	A	t	APL16	f	2022-08-09 15:20:44.661852	2022-08-09 15:20:44.661852
0ed8fc9b-2225-409d-af40-8021751ee915	SE003A	3	D	t	APL16	f	2022-08-09 15:20:44.667574	2022-08-09 15:20:44.667574
b0d5c832-3982-4c27-a2d6-8f7407a5c683	SE003A	3	I	t	APL16	f	2022-08-09 15:20:44.672873	2022-08-09 15:20:44.672873
dee5434a-a2af-43bb-91cd-cd8f1a36beee	SE003A	3	W	t	APL16	f	2022-08-09 15:20:44.678155	2022-08-09 15:20:44.678155
ea9a0cbe-722a-4fde-b1cb-337b22fb79e9	SE003A	3	Z	t	APL16	f	2022-08-09 15:20:44.683864	2022-08-09 15:20:44.683864
80b62ed9-4093-4645-86dd-f165040e62e1	SE003A	3	A	f	APL16	f	2022-08-09 15:20:44.689393	2022-08-09 15:20:44.689393
146b342e-2b20-407f-bc07-7e1067d7d7a1	SE003A	3	D	f	APL16	f	2022-08-09 15:20:44.694822	2022-08-09 15:20:44.694822
1a212c6e-bc49-45f0-905b-f41abc869eec	SE003A	3	I	f	APL16	f	2022-08-09 15:20:44.700417	2022-08-09 15:20:44.700417
499e9a94-9df6-442a-b2d8-d45ed24769b8	SE003A	3	W	f	APL16	f	2022-08-09 15:20:44.705701	2022-08-09 15:20:44.705701
f704ac28-2ea0-460d-b050-a478c436560a	SE003A	3	Z	f	APL16	f	2022-08-09 15:20:44.711	2022-08-09 15:20:44.711
4f173a0d-bac3-4834-8066-3b8cd5cfaef2	SE003A	3	A	t	APL18	f	2022-08-09 15:20:44.716542	2022-08-09 15:20:44.716542
2576b0c5-55e5-4f1b-9940-415de7b44b35	SE003A	3	D	t	APL18	f	2022-08-09 15:20:44.721926	2022-08-09 15:20:44.721926
59577341-934e-4427-84de-8fb8f9aa19ac	SE003A	3	I	t	APL18	f	2022-08-09 15:20:44.727358	2022-08-09 15:20:44.727358
6ee71cb3-27bf-46dc-9979-0b307ab5ed5b	SE003A	3	W	t	APL18	f	2022-08-09 15:20:44.732946	2022-08-09 15:20:44.732946
9ec4509f-ef2f-4d8d-a3b4-bdded0933c29	SE003A	3	Z	t	APL18	f	2022-08-09 15:20:44.738192	2022-08-09 15:20:44.738192
31fb46a2-3ae1-45c5-b1d2-eb2c618c695b	SE003A	3	A	f	APL18	f	2022-08-09 15:20:44.743708	2022-08-09 15:20:44.743708
ba28371c-1e2e-4b17-8b0b-d88bf0cc0cd4	SE003A	3	D	f	APL18	f	2022-08-09 15:20:44.749467	2022-08-09 15:20:44.749467
10931bd2-3084-4707-877d-59db7f6e890a	SE003A	3	I	f	APL18	f	2022-08-09 15:20:44.754819	2022-08-09 15:20:44.754819
98bfdff4-547c-47e7-aef2-94b236033c84	SE003A	3	W	f	APL18	f	2022-08-09 15:20:44.759992	2022-08-09 15:20:44.759992
7a9d2554-4144-4398-8ebd-8880f73ee9ee	SE003A	3	Z	f	APL18	f	2022-08-09 15:20:44.765719	2022-08-09 15:20:44.765719
10b6b745-0fd9-4b60-aa5e-f5900550f6d5	SE003A	3	A	t	APL20	f	2022-08-09 15:20:44.770928	2022-08-09 15:20:44.770928
d4f8f5e6-38c5-449b-9cb4-b0d0adef9fa6	SE003A	3	D	t	APL20	f	2022-08-09 15:20:44.777721	2022-08-09 15:20:44.777721
e2029d20-233a-4f53-b6fa-6bd15bdb8c59	SE003A	3	I	t	APL20	f	2022-08-09 15:20:44.784407	2022-08-09 15:20:44.784407
1bfcd76f-2d41-4b3c-8d9b-6068810635d3	SE003A	3	W	t	APL20	f	2022-08-09 15:20:44.790109	2022-08-09 15:20:44.790109
e94aef93-a497-4ff7-a5fa-47669d655adc	SE003A	3	Z	t	APL20	f	2022-08-09 15:20:44.795518	2022-08-09 15:20:44.795518
16483715-0eee-474f-adca-165b3db6d31a	SE003A	3	A	f	APL20	f	2022-08-09 15:20:44.801185	2022-08-09 15:20:44.801185
ffb86ef3-b1ce-465b-b71b-b38bfcaf0e66	SE003A	3	D	f	APL20	f	2022-08-09 15:20:44.806752	2022-08-09 15:20:44.806752
38da44ad-1fb4-4a2e-9a3d-2688364230e1	SE003A	3	I	f	APL20	f	2022-08-09 15:20:44.812601	2022-08-09 15:20:44.812601
7af9ebb2-c5a9-41c0-b2fb-32c308cf3787	SE003A	3	W	f	APL20	f	2022-08-09 15:20:44.818149	2022-08-09 15:20:44.818149
e3ef5f5b-4a9b-48e9-a692-21c0d56a1f41	SE003A	3	Z	f	APL20	f	2022-08-09 15:20:44.823928	2022-08-09 15:20:44.823928
fbb24f27-097e-4d7d-8df4-1a02e93018a0	SE003A	3	A	t	APL22	f	2022-08-09 15:20:44.829615	2022-08-09 15:20:44.829615
11ae263b-a64d-4757-98ea-dcd0c6b6ad90	SE003A	3	D	t	APL22	f	2022-08-09 15:20:44.835276	2022-08-09 15:20:44.835276
748f1f84-17c0-4d47-ad99-259a2518f46a	SE003A	3	I	t	APL22	f	2022-08-09 15:20:44.840624	2022-08-09 15:20:44.840624
1bfab665-b485-443b-89ff-2e041188a878	SE003A	3	W	t	APL22	f	2022-08-09 15:20:44.846639	2022-08-09 15:20:44.846639
6e99cd65-c605-4672-97f7-0551d838f102	SE003A	3	Z	t	APL22	f	2022-08-09 15:20:44.852244	2022-08-09 15:20:44.852244
baf8f813-7f16-4e34-a1a9-cef895e886ae	SE003A	3	A	f	APL22	f	2022-08-09 15:20:44.858017	2022-08-09 15:20:44.858017
cd2e00bc-ab5f-4d71-b3e6-d7c3a9f682a3	SE003A	3	D	f	APL22	f	2022-08-09 15:20:44.863453	2022-08-09 15:20:44.863453
0e08633b-e976-4032-ab1a-1abf7d90ba5c	SE003A	3	I	f	APL22	f	2022-08-09 15:20:44.869176	2022-08-09 15:20:44.869176
3b66073a-ec49-4e3d-b5a2-fe3806a310c8	SE003A	3	W	f	APL22	f	2022-08-09 15:20:44.87489	2022-08-09 15:20:44.87489
a71f5a08-d7f0-4d51-841c-324128c63cc0	SE003A	3	Z	f	APL22	f	2022-08-09 15:20:44.880548	2022-08-09 15:20:44.880548
148e6120-9483-42fa-8ab4-e42737fc226e	SE003A	3	A	t	APL27	f	2022-08-09 15:20:44.886466	2022-08-09 15:20:44.886466
ec4d6f2c-f707-444d-acfa-6047816dd2ba	SE003A	3	D	t	APL27	f	2022-08-09 15:20:44.892007	2022-08-09 15:20:44.892007
abb40172-8014-471b-96ad-71eb3902bf45	SE003A	3	I	t	APL27	f	2022-08-09 15:20:44.897899	2022-08-09 15:20:44.897899
6633b514-eb1f-4d9c-8fa7-32a6717848d8	SE003A	3	W	t	APL27	f	2022-08-09 15:20:44.904243	2022-08-09 15:20:44.904243
66b47265-f68e-4d2b-bfb7-a2dca9765a54	SE003A	3	Z	t	APL27	f	2022-08-09 15:20:44.910165	2022-08-09 15:20:44.910165
f845c656-63b7-49c6-83ed-2289987c4968	SE003A	3	A	f	APL27	f	2022-08-09 15:20:44.915997	2022-08-09 15:20:44.915997
935793a5-52b0-475c-a1d3-15d963edfc62	SE003A	3	D	f	APL27	f	2022-08-09 15:20:44.921842	2022-08-09 15:20:44.921842
6c24a4e8-8898-4bd2-bfc7-54c0c014c534	SE003A	3	I	f	APL27	f	2022-08-09 15:20:44.927824	2022-08-09 15:20:44.927824
afcd4e1b-acdd-4035-9139-e07a10f86b97	SE003A	3	W	f	APL27	f	2022-08-09 15:20:44.933237	2022-08-09 15:20:44.933237
49ee4eb4-2d1b-46ac-9e19-61c3a5da8a19	SE003A	3	Z	f	APL27	f	2022-08-09 15:20:44.938444	2022-08-09 15:20:44.938444
eb0e5fb7-4e1d-4e6b-bf07-6207d2dd6760	SE003A	3	A	t	APL29	f	2022-08-09 15:20:44.944672	2022-08-09 15:20:44.944672
84d9a2be-e4dd-443b-8958-9d7da3fe6b77	SE003A	3	D	t	APL29	f	2022-08-09 15:20:44.950119	2022-08-09 15:20:44.950119
af9d973c-b4ef-4475-814d-b6c805c57bad	SE003A	3	I	t	APL29	f	2022-08-09 15:20:44.955347	2022-08-09 15:20:44.955347
f480683f-b89a-42c4-89e5-66f8f5baa368	SE003A	3	W	t	APL29	f	2022-08-09 15:20:44.960728	2022-08-09 15:20:44.960728
a85b7983-08bb-4d0b-afec-bd0337febef6	SE003A	3	Z	t	APL29	f	2022-08-09 15:20:44.96608	2022-08-09 15:20:44.96608
cd5c0035-5ab5-45a9-9802-55bdac6c0cd0	SE003A	3	A	f	APL29	f	2022-08-09 15:20:44.971934	2022-08-09 15:20:44.971934
7f0ddf04-abb2-4fde-b49c-4738ec81830c	SE003A	3	D	f	APL29	f	2022-08-09 15:20:44.977473	2022-08-09 15:20:44.977473
001ffd9e-e505-48f4-b380-37315864b810	SE003A	3	I	f	APL29	f	2022-08-09 15:20:44.983035	2022-08-09 15:20:44.983035
a77967ca-ca8f-49b2-b26e-d56b7d936aab	SE003A	3	W	f	APL29	f	2022-08-09 15:20:44.988823	2022-08-09 15:20:44.988823
2fe6eaf4-26dc-42ba-8ac3-3e8c263929a1	SE003A	3	Z	f	APL29	f	2022-08-09 15:20:44.994099	2022-08-09 15:20:44.994099
346bafbd-1e27-4e02-ad2e-e8c17c85cf71	SE003A	3	A	t	APL31	f	2022-08-09 15:20:44.999505	2022-08-09 15:20:44.999505
dbd369ca-9f5b-4b77-98c7-93b18f00a9b0	SE003A	3	D	t	APL31	f	2022-08-09 15:20:45.005121	2022-08-09 15:20:45.005121
f9787cc9-2ef1-4518-87f2-5754902091c6	SE003A	3	I	t	APL31	f	2022-08-09 15:20:45.010557	2022-08-09 15:20:45.010557
68eba92d-c057-4976-972d-f726e9c485cf	SE003A	3	W	t	APL31	f	2022-08-09 15:20:45.016496	2022-08-09 15:20:45.016496
7f332e88-9b3a-4774-a7de-a358ca58986c	SE003A	3	Z	t	APL31	f	2022-08-09 15:20:45.021871	2022-08-09 15:20:45.021871
2487afd0-4850-48d6-a391-70678abb6596	SE003A	3	A	f	APL31	f	2022-08-09 15:20:45.027212	2022-08-09 15:20:45.027212
33abcac8-5e84-4e8e-84c0-1000e7e11387	SE003A	3	D	f	APL31	f	2022-08-09 15:20:45.03276	2022-08-09 15:20:45.03276
a0b60f5a-1f73-45df-8a8a-7431b7f26640	SE003A	3	I	f	APL31	f	2022-08-09 15:20:45.038375	2022-08-09 15:20:45.038375
e11d4a8d-a1a7-4f52-ac06-8d9813524885	SE003A	3	W	f	APL31	f	2022-08-09 15:20:45.044168	2022-08-09 15:20:45.044168
a4c52fac-55fc-447c-b557-01ceffa74578	SE003A	3	Z	f	APL31	f	2022-08-09 15:20:45.050975	2022-08-09 15:20:45.050975
70468c8a-6719-4b76-8823-43e4b84c164a	SE003A	3	A	t	APL48	f	2022-08-09 15:20:45.057534	2022-08-09 15:20:45.057534
b7438a53-4a04-490c-8e53-d8fff934dad4	SE003A	3	D	t	APL48	f	2022-08-09 15:20:45.064491	2022-08-09 15:20:45.064491
b4e69f88-4e4d-41d8-acb6-08968402d4c2	SE003A	3	I	t	APL48	f	2022-08-09 15:20:45.070222	2022-08-09 15:20:45.070222
1f7a7c0d-39d3-4e6e-ab0c-e72293effacf	SE003A	3	W	t	APL48	f	2022-08-09 15:20:45.075764	2022-08-09 15:20:45.075764
a7f12f2c-b04c-4dae-ad94-9e7467466bbe	SE003A	3	Z	t	APL48	f	2022-08-09 15:20:45.082378	2022-08-09 15:20:45.082378
82dca4a3-c6c6-4cd4-a5c0-2d8a1c1e8eb6	SE003A	3	A	f	APL48	f	2022-08-09 15:20:45.088993	2022-08-09 15:20:45.088993
6d8cdf61-62e9-4ea9-b7be-f61781a20176	SE003A	3	D	f	APL48	f	2022-08-09 15:20:45.094718	2022-08-09 15:20:45.094718
c5bd6c9a-01da-4c87-a024-cf8d83746d59	SE003A	3	I	f	APL48	f	2022-08-09 15:20:45.100316	2022-08-09 15:20:45.100316
e00fed0c-5fa8-4641-ac43-9794feba1881	SE003A	3	W	f	APL48	f	2022-08-09 15:20:45.10758	2022-08-09 15:20:45.10758
48164c24-477d-46d2-bac8-4bd09b912e07	SE003A	3	Z	f	APL48	f	2022-08-09 15:20:45.113326	2022-08-09 15:20:45.113326
e1ae1151-f0ab-4fa4-b4da-3da5ca3546f5	SE003A	3	A	t	APL49	f	2022-08-09 15:20:45.118989	2022-08-09 15:20:45.118989
0010f4db-2053-4b67-b781-635d79799109	SE003A	3	D	t	APL49	f	2022-08-09 15:20:45.124334	2022-08-09 15:20:45.124334
52f617c9-8e6f-4c7e-b70a-61fed223de59	SE003A	3	I	t	APL49	f	2022-08-09 15:20:45.129989	2022-08-09 15:20:45.129989
4baebafd-4635-4fe5-b736-a0a52dec298e	SE003A	3	W	t	APL49	f	2022-08-09 15:20:45.135359	2022-08-09 15:20:45.135359
502747bf-397a-47ea-a22d-9f59121f22ba	SE003A	3	Z	t	APL49	f	2022-08-09 15:20:45.140873	2022-08-09 15:20:45.140873
3601eb17-08dc-4ecd-9406-fb2adb41c3f4	SE003A	3	A	f	APL49	f	2022-08-09 15:20:45.14645	2022-08-09 15:20:45.14645
fe85e9c2-3abe-4b43-a593-bc11fee22334	SE003A	3	D	f	APL49	f	2022-08-09 15:20:45.151789	2022-08-09 15:20:45.151789
7bda1261-bb82-4bef-a4fe-b6476e44b611	SE003A	3	I	f	APL49	f	2022-08-09 15:20:45.157696	2022-08-09 15:20:45.157696
a3851611-e624-494f-92c3-201f4f382842	SE003A	3	W	f	APL49	f	2022-08-09 15:20:45.163142	2022-08-09 15:20:45.163142
fdb42996-e76c-4471-8ba1-bd35f2673f4c	SE003A	3	Z	f	APL49	f	2022-08-09 15:20:45.168992	2022-08-09 15:20:45.168992
77af7036-ea1b-4cdd-8853-e959c2be9562	SE003A	3	A	t	APL50	f	2022-08-09 15:20:45.174447	2022-08-09 15:20:45.174447
81340966-3d06-49d2-8cb2-026ff91c7034	SE003A	3	D	t	APL50	f	2022-08-09 15:20:45.180072	2022-08-09 15:20:45.180072
e21c6340-b8af-49c6-a275-97722b4a7512	SE003A	3	I	t	APL50	f	2022-08-09 15:20:45.185842	2022-08-09 15:20:45.185842
12852cd4-c764-4954-a304-344132d1bd15	SE003A	3	W	t	APL50	f	2022-08-09 15:20:45.191339	2022-08-09 15:20:45.191339
771b7a0c-2e72-42a5-9b84-2b54ab33116f	SE003A	3	Z	t	APL50	f	2022-08-09 15:20:45.196899	2022-08-09 15:20:45.196899
fef81d83-76e6-4c7b-9fdc-b33bf8cd2349	SE003A	3	A	f	APL50	f	2022-08-09 15:20:45.202266	2022-08-09 15:20:45.202266
88c45f77-d9a8-4289-ae4c-5f7ee62ccd58	SE003A	3	D	f	APL50	f	2022-08-09 15:20:45.207996	2022-08-09 15:20:45.207996
cd9bae24-18f3-4e54-ad0a-fc382d0d5cd5	SE003A	3	I	f	APL50	f	2022-08-09 15:20:45.213424	2022-08-09 15:20:45.213424
4f823641-fa42-4ade-8626-8f1a6877cc89	SE003A	3	W	f	APL50	f	2022-08-09 15:20:45.21878	2022-08-09 15:20:45.21878
47ab8511-fa77-458c-bc2f-7f88e6a64ce8	SE003A	3	Z	f	APL50	f	2022-08-09 15:20:45.224327	2022-08-09 15:20:45.224327
19801a7e-85a6-4573-af29-c50c9408eadf	SE003A	3	A	t	APL51	f	2022-08-09 15:20:45.229593	2022-08-09 15:20:45.229593
51546e9c-335a-4d2a-9708-dccc25a8eba8	SE003A	3	D	t	APL51	f	2022-08-09 15:20:45.235574	2022-08-09 15:20:45.235574
badca38f-e938-4cd8-81b3-2dd9808cfc24	SE003A	3	I	t	APL51	f	2022-08-09 15:20:45.241879	2022-08-09 15:20:45.241879
ded68740-9445-448f-aae4-01f98470ad5d	SE003A	3	W	t	APL51	f	2022-08-09 15:20:45.247131	2022-08-09 15:20:45.247131
6d98bc09-54da-4fd6-b2d1-d0f7c53f6bf0	SE003A	3	Z	t	APL51	f	2022-08-09 15:20:45.252822	2022-08-09 15:20:45.252822
1714c117-67ea-4af4-bb34-358add2a4a7b	SE003A	3	A	f	APL51	f	2022-08-09 15:20:45.258376	2022-08-09 15:20:45.258376
d2c67b30-955e-46da-81fa-a9db21f8280a	SE003A	3	D	f	APL51	f	2022-08-09 15:20:45.264011	2022-08-09 15:20:45.264011
b21e66e9-f2fa-4515-9921-0da92f5eca04	SE003A	3	I	f	APL51	f	2022-08-09 15:20:45.269343	2022-08-09 15:20:45.269343
d2325450-86eb-4171-b0de-13f5a3573430	SE003A	3	W	f	APL51	f	2022-08-09 15:20:45.274672	2022-08-09 15:20:45.274672
dd6f5f8b-0ae9-43fd-937e-42a2953e50bd	SE003A	3	Z	f	APL51	f	2022-08-09 15:20:45.28031	2022-08-09 15:20:45.28031
5ae49126-7c7d-4ac7-a0de-29f02c3b1460	SE003A	3	A	t	APL52	f	2022-08-09 15:20:45.285563	2022-08-09 15:20:45.285563
be98450d-cb2b-42c0-9257-fc96fdd448ac	SE003A	3	D	t	APL52	f	2022-08-09 15:20:45.290785	2022-08-09 15:20:45.290785
343d1b99-5582-495e-8d37-e1f514923495	SE003A	3	I	t	APL52	f	2022-08-09 15:20:45.296561	2022-08-09 15:20:45.296561
001fe309-26c8-4a80-9f6b-819b096c9f04	SE003A	3	W	t	APL52	f	2022-08-09 15:20:45.302151	2022-08-09 15:20:45.302151
78e1a7f7-03cf-4c8a-a9c8-96375776f3d0	SE003A	3	Z	t	APL52	f	2022-08-09 15:20:45.307985	2022-08-09 15:20:45.307985
7660487b-e223-4d0e-a6d5-dcc629a62c24	SE003A	3	A	f	APL52	f	2022-08-09 15:20:45.313574	2022-08-09 15:20:45.313574
3be65c1d-26ba-4a6f-b107-2d90eafd23fc	SE003A	3	D	f	APL52	f	2022-08-09 15:20:45.318976	2022-08-09 15:20:45.318976
b952fae4-f8e2-4e2a-b455-5eebe57e14ad	SE003A	3	I	f	APL52	f	2022-08-09 15:20:45.324594	2022-08-09 15:20:45.324594
0f1abbbc-78e4-470b-a29f-a49045f4b250	SE003A	3	W	f	APL52	f	2022-08-09 15:20:45.330021	2022-08-09 15:20:45.330021
7a48684f-63ed-4fca-95e9-0986ba89e905	SE003A	3	Z	f	APL52	f	2022-08-09 15:20:45.335278	2022-08-09 15:20:45.335278
7458a59f-691a-450a-bf27-063c12a7f241	SE003A	3	A	t	APL53	f	2022-08-09 15:20:45.340902	2022-08-09 15:20:45.340902
0b327b3d-e49a-433f-a5c8-2b1dc6767427	SE003A	3	D	t	APL53	f	2022-08-09 15:20:45.346478	2022-08-09 15:20:45.346478
c098f68c-205c-49aa-bde4-ba9db7468d3e	SE003A	3	I	t	APL53	f	2022-08-09 15:20:45.353221	2022-08-09 15:20:45.353221
d773d356-ac23-47e3-bdd8-1dfaccafc607	SE003A	3	W	t	APL53	f	2022-08-09 15:20:45.35932	2022-08-09 15:20:45.35932
baf6c8cb-1d19-4946-9740-35f800361c6d	SE003A	3	Z	t	APL53	f	2022-08-09 15:20:45.365237	2022-08-09 15:20:45.365237
23abf64c-f89c-4792-8a91-6837a072c073	SE003A	3	A	f	APL53	f	2022-08-09 15:20:45.37175	2022-08-09 15:20:45.37175
905eb5cc-db8f-4be0-b260-7a29c618b583	SE003A	3	D	f	APL53	f	2022-08-09 15:20:45.377652	2022-08-09 15:20:45.377652
64169237-122f-440c-845a-f72370946fde	SE003A	3	I	f	APL53	f	2022-08-09 15:20:45.383766	2022-08-09 15:20:45.383766
a1976e51-b47a-4bba-b18b-e47c464d7d5a	SE003A	3	W	f	APL53	f	2022-08-09 15:20:45.39011	2022-08-09 15:20:45.39011
bbe8cbd8-3e89-43f6-9c00-c762a4e6955f	SE003A	3	Z	f	APL53	f	2022-08-09 15:20:45.395899	2022-08-09 15:20:45.395899
c24cb449-c266-4a7e-8760-0e2235888545	SE003A	3	A	t	APL54	f	2022-08-09 15:20:45.401859	2022-08-09 15:20:45.401859
b3896de0-e7a9-49d6-b4c3-6619ba5224f9	SE003A	3	D	t	APL54	f	2022-08-09 15:20:45.407285	2022-08-09 15:20:45.407285
87db2414-27ab-458f-b849-653441e397a9	SE003A	3	I	t	APL54	f	2022-08-09 15:20:45.413024	2022-08-09 15:20:45.413024
9ca42b99-3ebd-4e33-961e-d953fd3f1dff	SE003A	3	W	t	APL54	f	2022-08-09 15:20:45.419012	2022-08-09 15:20:45.419012
cddd4610-bba8-453b-a1c5-190add30640f	SE003A	3	Z	t	APL54	f	2022-08-09 15:20:45.425352	2022-08-09 15:20:45.425352
ee7a29f3-efb9-4b49-85a7-5363d5f21c86	SE003A	3	A	f	APL54	f	2022-08-09 15:20:45.431019	2022-08-09 15:20:45.431019
f188cfc2-26ab-4d8a-8d4a-c678a7a6b1fd	SE003A	3	D	f	APL54	f	2022-08-09 15:20:45.437762	2022-08-09 15:20:45.437762
e8ad6814-2d7b-47aa-8075-fd290c66f08e	SE003A	3	I	f	APL54	f	2022-08-09 15:20:45.444084	2022-08-09 15:20:45.444084
4ebde0f0-97aa-43f6-8a88-04d3aa631480	SE003A	3	W	f	APL54	f	2022-08-09 15:20:45.450264	2022-08-09 15:20:45.450264
73bd0ff9-1e9a-44da-98ea-d69e7351ee63	SE003A	3	Z	f	APL54	f	2022-08-09 15:20:45.45588	2022-08-09 15:20:45.45588
b9a6b69c-42e3-4c5c-b374-925cb6a69906	SE003A	3	A	t	APL55	f	2022-08-09 15:20:45.461972	2022-08-09 15:20:45.461972
724f1200-ff6c-4633-9c1a-3a3220f9ff65	SE003A	3	D	t	APL55	f	2022-08-09 15:20:45.46741	2022-08-09 15:20:45.46741
9eede6be-677f-4194-8d73-84e54c52ed11	SE003A	3	I	t	APL55	f	2022-08-09 15:20:45.473169	2022-08-09 15:20:45.473169
a392bdcc-68bc-4488-bd28-bb3a3ebb4737	SE003A	3	W	t	APL55	f	2022-08-09 15:20:45.478734	2022-08-09 15:20:45.478734
36554735-a06e-48a6-9a51-09036d9f1ac9	SE003A	3	Z	t	APL55	f	2022-08-09 15:20:45.484713	2022-08-09 15:20:45.484713
a533a087-0cc8-46be-af54-29d988c15687	SE003A	3	A	f	APL55	f	2022-08-09 15:20:45.490348	2022-08-09 15:20:45.490348
1a3392eb-24cc-4349-81fb-3670be5f5f6e	SE003A	3	D	f	APL55	f	2022-08-09 15:20:45.49585	2022-08-09 15:20:45.49585
5e034f44-56ad-48f6-8adb-658407dd6382	SE003A	3	I	f	APL55	f	2022-08-09 15:20:45.501163	2022-08-09 15:20:45.501163
a0ced433-d4c8-4681-9052-1489f7ec9cee	SE003A	3	W	f	APL55	f	2022-08-09 15:20:45.507025	2022-08-09 15:20:45.507025
60ba78de-411b-46bd-b73c-7ef2c013bc6f	SE003A	3	Z	f	APL55	f	2022-08-09 15:20:45.512642	2022-08-09 15:20:45.512642
6c6672cd-5b98-43ec-a79e-cad8a37736b4	SE003A	3	A	t	APL56	f	2022-08-09 15:20:45.518272	2022-08-09 15:20:45.518272
8417e4f0-2ec6-4397-a93c-f24ba45e7bad	SE003A	3	D	t	APL56	f	2022-08-09 15:20:45.523822	2022-08-09 15:20:45.523822
ccdee87b-93eb-4f10-b521-aeafcb975ff6	SE003A	3	I	t	APL56	f	2022-08-09 15:20:45.530878	2022-08-09 15:20:45.530878
5104feb6-63a6-4d5d-8f03-357a8cb9db0c	SE003A	3	W	t	APL56	f	2022-08-09 15:20:45.537329	2022-08-09 15:20:45.537329
80a6ea70-670e-45b9-885b-8ebe36c4cedc	SE003A	3	Z	t	APL56	f	2022-08-09 15:20:45.542985	2022-08-09 15:20:45.542985
d53215dd-6a6a-4f0c-bc95-5e2d54747fcc	SE003A	3	A	f	APL56	f	2022-08-09 15:20:45.54868	2022-08-09 15:20:45.54868
15a79b4a-dd65-4118-80d0-15d2e25075d5	SE003A	3	D	f	APL56	f	2022-08-09 15:20:45.554261	2022-08-09 15:20:45.554261
6590d46d-c9c9-4575-9910-4470ede02a03	SE003A	3	I	f	APL56	f	2022-08-09 15:20:45.560488	2022-08-09 15:20:45.560488
ae74f644-4b00-46ba-b8c2-b3f0d10d3536	SE003A	3	W	f	APL56	f	2022-08-09 15:20:45.56746	2022-08-09 15:20:45.56746
174ab2e7-e353-46b5-aa9d-471b38163924	SE003A	3	Z	f	APL56	f	2022-08-09 15:20:45.573943	2022-08-09 15:20:45.573943
8f954c81-463c-4f40-8810-d238804e8981	SE003A	3	A	t	APL57	f	2022-08-09 15:20:45.580929	2022-08-09 15:20:45.580929
fd90f8b4-f9de-45d6-9871-b385402b8f9b	SE003A	3	D	t	APL57	f	2022-08-09 15:20:45.586698	2022-08-09 15:20:45.586698
10460345-553d-4116-941d-4f438abe1cc6	SE003A	3	I	t	APL57	f	2022-08-09 15:20:45.592899	2022-08-09 15:20:45.592899
6c78364c-c1fa-40cd-b352-bdd2227e8b2e	SE003A	3	W	t	APL57	f	2022-08-09 15:20:45.598649	2022-08-09 15:20:45.598649
26468547-20dd-4fe7-8d4b-9a8bc1970de8	SE003A	3	Z	t	APL57	f	2022-08-09 15:20:45.60396	2022-08-09 15:20:45.60396
5661ef1e-38c0-4ea9-81df-d2932ac79988	SE003A	3	A	f	APL57	f	2022-08-09 15:20:45.609607	2022-08-09 15:20:45.609607
ee41b936-cb42-46f4-9cdf-8c44aca4a9be	SE003A	3	D	f	APL57	f	2022-08-09 15:20:45.615062	2022-08-09 15:20:45.615062
335135e4-311f-46be-9029-55be6a7dbc4b	SE003A	3	I	f	APL57	f	2022-08-09 15:20:45.621075	2022-08-09 15:20:45.621075
dbec992d-536c-491f-917e-85ad82faf108	SE003A	3	W	f	APL57	f	2022-08-09 15:20:45.6267	2022-08-09 15:20:45.6267
7dadf852-c3c6-4d6e-82b8-6c03cd7cb224	SE003A	3	Z	f	APL57	f	2022-08-09 15:20:45.632002	2022-08-09 15:20:45.632002
bae5c2d3-7e63-42c5-97da-b02924942b56	SE003A	3	A	t	APL65	f	2022-08-09 15:20:45.637712	2022-08-09 15:20:45.637712
e86f7f81-195f-479a-8fec-7db26fbcb75f	SE003A	3	D	t	APL65	f	2022-08-09 15:20:45.643303	2022-08-09 15:20:45.643303
147ff38a-ab51-4ddf-8974-6794106b38f4	SE003A	3	I	t	APL65	f	2022-08-09 15:20:45.648755	2022-08-09 15:20:45.648755
d1c47d0f-f89a-4654-a7ac-7b81fa982636	SE003A	3	W	t	APL65	f	2022-08-09 15:20:45.65455	2022-08-09 15:20:45.65455
de053b04-f819-4e96-b76e-b0616990445d	SE003A	3	Z	t	APL65	f	2022-08-09 15:20:45.660246	2022-08-09 15:20:45.660246
4fa82661-6d54-4dc3-8a7a-1a586380b3e3	SE003A	3	A	f	APL65	f	2022-08-09 15:20:45.665763	2022-08-09 15:20:45.665763
0a59efaf-bca8-4229-bfb6-71bd9d9f76a1	SE003A	3	D	f	APL65	f	2022-08-09 15:20:45.671446	2022-08-09 15:20:45.671446
2fbac5c4-6a49-4285-8d88-8f795b259b07	SE003A	3	I	f	APL65	f	2022-08-09 15:20:45.677019	2022-08-09 15:20:45.677019
5c8d92a3-561e-49eb-b59d-f2b2b65e2a00	SE003A	3	W	f	APL65	f	2022-08-09 15:20:45.682299	2022-08-09 15:20:45.682299
39ae7565-fc50-4357-b2c6-59f1d912ecba	SE003A	3	Z	f	APL65	f	2022-08-09 15:20:45.688031	2022-08-09 15:20:45.688031
18ad66b6-86c2-455e-a07f-e265be94d6d4	SE003A	3	A	t	APL66	f	2022-08-09 15:20:45.693315	2022-08-09 15:20:45.693315
f29757c8-a1aa-41ce-ae03-2eb8f94cb525	SE003A	3	D	t	APL66	f	2022-08-09 15:20:45.699176	2022-08-09 15:20:45.699176
3595c21b-ad9d-44c6-8bb1-a35e92d40840	SE003A	3	I	t	APL66	f	2022-08-09 15:20:45.704668	2022-08-09 15:20:45.704668
0001ba57-2269-4902-9638-b5b937f18d6d	SE003A	3	W	t	APL66	f	2022-08-09 15:20:45.710501	2022-08-09 15:20:45.710501
9155fc97-db55-4e09-b8ba-7224611392df	SE003A	3	Z	t	APL66	f	2022-08-09 15:20:45.71658	2022-08-09 15:20:45.71658
74751ece-8dea-4dca-a6b5-2d2180f53413	SE003A	3	A	f	APL66	f	2022-08-09 15:20:45.721873	2022-08-09 15:20:45.721873
9203fd98-52ba-463b-812c-316d7fd096fb	SE003A	3	D	f	APL66	f	2022-08-09 15:20:45.727447	2022-08-09 15:20:45.727447
91c1a841-b282-4fa2-9c1c-a7b42a8caddc	SE003A	3	I	f	APL66	f	2022-08-09 15:20:45.732972	2022-08-09 15:20:45.732972
6f7560bc-52e0-409b-babb-8f0892b4bd20	SE003A	3	W	f	APL66	f	2022-08-09 15:20:45.738894	2022-08-09 15:20:45.738894
8d7c4924-2c64-40bf-8c5b-b4f97b7445bc	SE003A	3	Z	f	APL66	f	2022-08-09 15:20:45.744231	2022-08-09 15:20:45.744231
da00942f-76e8-4d11-b8d2-5c14559c6150	SE003A	3	A	t	APL67	f	2022-08-09 15:20:45.749563	2022-08-09 15:20:45.749563
114b8b28-d745-429a-a27f-2a3e1a6a642a	SE003A	3	D	t	APL67	f	2022-08-09 15:20:45.755238	2022-08-09 15:20:45.755238
a81f4ede-19b0-47de-bf3b-40127690fa55	SE003A	3	I	t	APL67	f	2022-08-09 15:20:45.760543	2022-08-09 15:20:45.760543
06a7cb17-bfd3-4af3-9292-d7add5f69b34	SE003A	3	W	t	APL67	f	2022-08-09 15:20:45.767469	2022-08-09 15:20:45.767469
af530047-210f-4439-be90-0501a56fcc3d	SE003A	3	Z	t	APL67	f	2022-08-09 15:20:45.773094	2022-08-09 15:20:45.773094
94c7d1f8-49b5-42fa-8a58-870907dfc47a	SE003A	3	A	f	APL67	f	2022-08-09 15:20:45.779058	2022-08-09 15:20:45.779058
9c5c6cbe-0803-42e7-9578-04b5032947d5	SE003A	3	D	f	APL67	f	2022-08-09 15:20:45.785017	2022-08-09 15:20:45.785017
3c86e943-2d75-4ecd-8ec0-2ec00e1c906a	SE003A	3	I	f	APL67	f	2022-08-09 15:20:45.790765	2022-08-09 15:20:45.790765
62ca3611-dd26-4c22-938f-535ceaf464f1	SE003A	3	W	f	APL67	f	2022-08-09 15:20:45.796058	2022-08-09 15:20:45.796058
e4e24a9d-03af-4f72-9110-003c3cc23c65	SE003A	3	Z	f	APL67	f	2022-08-09 15:20:45.802221	2022-08-09 15:20:45.802221
8fdb5eea-9ac6-48bb-9e7b-2dc2c2a753e8	SE003A	3	A	t	APL68	f	2022-08-09 15:20:45.80798	2022-08-09 15:20:45.80798
ac4355d2-fe1d-40a9-8319-bd80e60bcf26	SE003A	3	D	t	APL68	f	2022-08-09 15:20:45.813658	2022-08-09 15:20:45.813658
db8ab39a-66f3-42ad-b80a-192b56422ae4	SE003A	3	I	t	APL68	f	2022-08-09 15:20:45.819435	2022-08-09 15:20:45.819435
442fe7b8-01ac-4d8e-9121-5a8cf8a95b93	SE003A	3	W	t	APL68	f	2022-08-09 15:20:45.825833	2022-08-09 15:20:45.825833
e9cb65ce-6c2b-4731-a549-4ac0278990ab	SE003A	3	Z	t	APL68	f	2022-08-09 15:20:45.832186	2022-08-09 15:20:45.832186
88260218-4b8a-412d-9ce4-8eb064684716	SE003A	3	A	f	APL68	f	2022-08-09 15:20:45.837664	2022-08-09 15:20:45.837664
d88d9d3d-e0ca-4be8-966b-2654bc3a7c88	SE003A	3	D	f	APL68	f	2022-08-09 15:20:45.842867	2022-08-09 15:20:45.842867
5140d4ce-5d93-474f-86cc-c18acdb68ef3	SE003A	3	I	f	APL68	f	2022-08-09 15:20:45.84842	2022-08-09 15:20:45.84842
87b61817-e212-4993-b037-2a9fc41a2705	SE003A	3	W	f	APL68	f	2022-08-09 15:20:45.853781	2022-08-09 15:20:45.853781
a0cb1d5e-aa40-4b39-96eb-c2b7bb215818	SE003A	3	Z	f	APL68	f	2022-08-09 15:20:45.859398	2022-08-09 15:20:45.859398
24807d07-20b0-4720-9679-4c9b6f24d8c9	SE003A	3	A	t	APL69	f	2022-08-09 15:20:45.864927	2022-08-09 15:20:45.864927
bec09d98-c1e4-4e75-90ab-760abca0d1fe	SE003A	3	D	t	APL69	f	2022-08-09 15:20:45.870767	2022-08-09 15:20:45.870767
df9477c6-b93b-4fea-905c-630f604ff299	SE003A	3	I	t	APL69	f	2022-08-09 15:20:45.876293	2022-08-09 15:20:45.876293
722b307a-7dd0-401f-8275-cbc9a6b8e2a2	SE003A	3	W	t	APL69	f	2022-08-09 15:20:45.881735	2022-08-09 15:20:45.881735
5d32e613-839b-431d-a38d-65272a7dfc5b	SE003A	3	Z	t	APL69	f	2022-08-09 15:20:45.88745	2022-08-09 15:20:45.88745
7a7884eb-4cf7-4a54-a3a6-9106b62e1aac	SE003A	3	A	f	APL69	f	2022-08-09 15:20:45.89266	2022-08-09 15:20:45.89266
ac1e54b4-a28e-4d92-b909-87028703d3cd	SE003A	3	D	f	APL69	f	2022-08-09 15:20:45.898021	2022-08-09 15:20:45.898021
6cd2c347-a885-42ac-8bf9-535ef9489cfe	SE003A	3	I	f	APL69	f	2022-08-09 15:20:45.903556	2022-08-09 15:20:45.903556
60daa464-e257-4485-97a9-dd764c7d2482	SE003A	3	W	f	APL69	f	2022-08-09 15:20:45.908818	2022-08-09 15:20:45.908818
049a125b-723e-4a5f-85ff-0300064164d1	SE003A	3	Z	f	APL69	f	2022-08-09 15:20:45.914423	2022-08-09 15:20:45.914423
a449b324-df49-42a9-9454-af3a6c10b864	SE003A	3	A	t	APL70	f	2022-08-09 15:20:45.919991	2022-08-09 15:20:45.919991
5afc3dd3-2045-47d8-a3ea-f278aae592a1	SE003A	3	D	t	APL70	f	2022-08-09 15:20:45.925684	2022-08-09 15:20:45.925684
a4ef6558-e8de-4f20-8b39-a29f86585301	SE003A	3	I	t	APL70	f	2022-08-09 15:20:45.931395	2022-08-09 15:20:45.931395
f6965732-a182-4091-8eae-cc4ccbf5bf5e	SE003A	3	W	t	APL70	f	2022-08-09 15:20:45.937042	2022-08-09 15:20:45.937042
aab03211-6884-4a2f-9745-c32a74fd0150	SE003A	3	Z	t	APL70	f	2022-08-09 15:20:45.942743	2022-08-09 15:20:45.942743
beba7915-76be-4351-9991-263c4e9da270	SE003A	3	A	f	APL70	f	2022-08-09 15:20:45.948136	2022-08-09 15:20:45.948136
d140484b-5db0-489c-8d24-3bc8bac50fb4	SE003A	3	D	f	APL70	f	2022-08-09 15:20:45.953329	2022-08-09 15:20:45.953329
e67dac08-48b5-49b8-8992-6db275c295fe	SE003A	3	I	f	APL70	f	2022-08-09 15:20:45.958906	2022-08-09 15:20:45.958906
b6d23f5a-4751-4f47-a93f-18deee57f849	SE003A	3	W	f	APL70	f	2022-08-09 15:20:45.964344	2022-08-09 15:20:45.964344
1349910b-95fc-48a6-b5ba-e0dd65a3db76	SE003A	3	Z	f	APL70	f	2022-08-09 15:20:45.970022	2022-08-09 15:20:45.970022
1e3d448e-e90d-449a-baf7-4b66713f1d52	SE003A	3	A	t	CV027	f	2022-08-09 15:20:45.975351	2022-08-09 15:20:45.975351
abca386f-2dae-404b-9cf0-38e8b5301060	SE003A	3	D	t	CV027	f	2022-08-09 15:20:45.981383	2022-08-09 15:20:45.981383
3bdbb48f-d83d-4f74-9cf2-02a98c7610d4	SE003A	3	I	t	CV027	f	2022-08-09 15:20:45.98742	2022-08-09 15:20:45.98742
4c997580-5223-4c39-b86e-c82e97ffa237	SE003A	3	W	t	CV027	f	2022-08-09 15:20:45.992752	2022-08-09 15:20:45.992752
c0c0e612-81ca-4f0d-994b-cd34f7d9cb38	SE003A	3	Z	t	CV027	f	2022-08-09 15:20:45.998221	2022-08-09 15:20:45.998221
0175bcfb-317d-45f9-bd72-5a3a7204bff6	SE003A	3	A	f	CV027	f	2022-08-09 15:20:46.00379	2022-08-09 15:20:46.00379
c440e5d2-a5d9-4296-b9cc-41e48afe355a	SE003A	3	D	f	CV027	f	2022-08-09 15:20:46.009135	2022-08-09 15:20:46.009135
a38196e6-df2c-42dd-b9de-94ae1441bf10	SE003A	3	I	f	CV027	f	2022-08-09 15:20:46.014439	2022-08-09 15:20:46.014439
ec4b8ec9-34d3-437f-bfce-5bc3739d8630	SE003A	3	W	f	CV027	f	2022-08-09 15:20:46.020093	2022-08-09 15:20:46.020093
bfc65fa3-110e-4f91-b067-9f8dda4d2daa	SE003A	3	Z	f	CV027	f	2022-08-09 15:20:46.02537	2022-08-09 15:20:46.02537
899a5513-3853-4e02-bc42-7120001cb959	SE003A	3	A	t	CV079	f	2022-08-09 15:20:46.030977	2022-08-09 15:20:46.030977
ad08031f-32d6-478e-af97-7eba3de9935b	SE003A	3	D	t	CV079	f	2022-08-09 15:20:46.036532	2022-08-09 15:20:46.036532
8c0f036d-2a48-433e-8991-a517bd6de695	SE003A	3	I	t	CV079	f	2022-08-09 15:20:46.041755	2022-08-09 15:20:46.041755
a6732dc9-df1a-4a7f-a102-58ed4f0b2e91	SE003A	3	W	t	CV079	f	2022-08-09 15:20:46.047351	2022-08-09 15:20:46.047351
7d8b3359-ee26-498a-80c3-76e3c1d99f2f	SE003A	3	Z	t	CV079	f	2022-08-09 15:20:46.052676	2022-08-09 15:20:46.052676
b7c66c64-3e30-4e87-a2e5-1d59f40395cf	SE003A	3	A	f	CV118	f	2022-08-09 15:20:46.119466	2022-08-09 15:20:46.119466
0eadb132-8cca-487d-97e6-ddf9698275b4	SE003A	3	D	f	CV118	f	2022-08-09 15:20:46.12481	2022-08-09 15:20:46.12481
89cbe7ba-d9a3-48cb-895b-3fa83e39bbcc	SE003A	3	I	f	CV118	f	2022-08-09 15:20:46.130474	2022-08-09 15:20:46.130474
32cf1d60-c524-4536-8b24-c4beb68af7fa	SE003A	3	W	f	CV118	f	2022-08-09 15:20:46.135765	2022-08-09 15:20:46.135765
89d4d25f-a5cd-43c8-8af1-a5e4509f444e	SE003A	3	Z	f	CV118	f	2022-08-09 15:20:46.141491	2022-08-09 15:20:46.141491
75cc6369-c154-4db5-a9c8-638f2644e507	SE003A	3	A	f	CV079	t	2022-08-09 15:20:46.05837	2022-08-09 15:20:46.148979
41ce2d8e-6a49-48c5-be7e-fb8212513c46	SE003A	3	D	f	CV079	t	2022-08-09 15:20:46.063614	2022-08-09 15:20:46.156351
16dbc842-219f-4933-9443-740dc5400c70	SE003A	3	I	f	CV079	t	2022-08-09 15:20:46.069154	2022-08-09 15:20:46.163444
bac054af-dcd2-483c-94eb-0d3f96a9f33c	SE003A	3	W	f	CV079	t	2022-08-09 15:20:46.074684	2022-08-09 15:20:46.170993
091e3a1e-6136-4c59-a01d-f2fd8e57ec8c	SE003A	3	Z	f	CV079	t	2022-08-09 15:20:46.081133	2022-08-09 15:20:46.178565
44861857-9c05-4d16-a5da-f6a87f4094b1	SE003A	3	A	t	CV118	t	2022-08-09 15:20:46.088667	2022-08-09 15:20:46.185989
f7acdc78-35ec-4234-a24d-a9389e7bf95b	SE003A	3	D	t	CV118	t	2022-08-09 15:20:46.095505	2022-08-09 15:20:46.193332
8bdbe19c-9913-43b0-b028-61051fa7f0b8	SE003A	3	I	t	CV118	t	2022-08-09 15:20:46.101719	2022-08-09 15:20:46.200718
05f2b69a-030f-423e-ace6-df37b6e7fc87	SE003A	3	W	t	CV118	t	2022-08-09 15:20:46.10786	2022-08-09 15:20:46.207745
63d1632e-7ddf-4395-a18b-274dd46f2f67	SE003A	3	Z	t	CV118	t	2022-08-09 15:20:46.113553	2022-08-09 15:20:46.215128
32f701d0-d3b8-4bd6-9700-5399a4f068af	SE004A	3	A	t	APL09	f	2022-08-09 15:20:46.220555	2022-08-09 15:20:46.220555
3da6b65f-acfc-49c2-9894-2e461d4a2b57	SE004A	3	D	t	APL09	f	2022-08-09 15:20:46.226363	2022-08-09 15:20:46.226363
3c63f0e7-1893-4a31-bee9-ca0ae71b527b	SE004A	3	I	t	APL09	f	2022-08-09 15:20:46.231744	2022-08-09 15:20:46.231744
b87d1474-0ed7-49f7-948a-981d2d84f088	SE004A	3	W	t	APL09	f	2022-08-09 15:20:46.237468	2022-08-09 15:20:46.237468
9d026354-178c-493e-a9e1-9d62a6e25a8e	SE004A	3	Z	t	APL09	f	2022-08-09 15:20:46.242651	2022-08-09 15:20:46.242651
e8c68f81-040f-4337-b5d5-9580b53c8d82	SE004A	3	A	f	APL09	f	2022-08-09 15:20:46.248089	2022-08-09 15:20:46.248089
c69842f0-06cb-40a5-b8a9-c2f1f756b524	SE004A	3	D	f	APL09	f	2022-08-09 15:20:46.253839	2022-08-09 15:20:46.253839
5dd41732-fb09-409c-90e0-fd5c86840890	SE004A	3	I	f	APL09	f	2022-08-09 15:20:46.259412	2022-08-09 15:20:46.259412
8c843d97-b930-4d03-a80a-0b3ca27d919a	SE004A	3	W	f	APL09	f	2022-08-09 15:20:46.264806	2022-08-09 15:20:46.264806
04a8b51c-76a1-4149-aec0-d9a6e6afb26e	SE004A	3	Z	f	APL09	f	2022-08-09 15:20:46.270421	2022-08-09 15:20:46.270421
9b30a95e-740b-47b5-99af-c6236380433b	SE004A	3	A	t	APL07	f	2022-08-09 15:20:46.275897	2022-08-09 15:20:46.275897
89befb70-09af-4752-8991-ef736581e5f2	SE004A	3	D	t	APL07	f	2022-08-09 15:20:46.281913	2022-08-09 15:20:46.281913
ed4853a4-e436-4466-8a2b-f46b86895d68	SE004A	3	I	t	APL07	f	2022-08-09 15:20:46.287493	2022-08-09 15:20:46.287493
2c9a985c-da52-4a01-af47-592ff222462f	SE004A	3	W	t	APL07	f	2022-08-09 15:20:46.292878	2022-08-09 15:20:46.292878
4a49f394-6368-46f3-b88c-aa11ed789314	SE004A	3	Z	t	APL07	f	2022-08-09 15:20:46.298886	2022-08-09 15:20:46.298886
cb1df0a0-5ae2-4bde-95fe-da7a01a3c204	SE004A	3	A	f	APL07	f	2022-08-09 15:20:46.30457	2022-08-09 15:20:46.30457
a2c62da2-d93c-4e23-8835-f73ca813b5de	SE004A	3	D	f	APL07	f	2022-08-09 15:20:46.310427	2022-08-09 15:20:46.310427
3400c851-8bb8-4207-937b-9aa608167e4f	SE004A	3	I	f	APL07	f	2022-08-09 15:20:46.316016	2022-08-09 15:20:46.316016
c936728b-4a4d-42c0-b194-05df98b552ed	SE004A	3	W	f	APL07	f	2022-08-09 15:20:46.321572	2022-08-09 15:20:46.321572
922f71c5-3650-43a5-9777-21c23de9bec1	SE004A	3	Z	f	APL07	f	2022-08-09 15:20:46.327334	2022-08-09 15:20:46.327334
cc8a28ad-8533-4bee-8170-b25ab4d130c6	SE004A	3	A	t	APL11	f	2022-08-09 15:20:46.332612	2022-08-09 15:20:46.332612
ac9357d3-c346-490d-855e-c54f58ac7027	SE004A	3	D	t	APL11	f	2022-08-09 15:20:46.337813	2022-08-09 15:20:46.337813
043bc671-e12a-4e20-8996-191e766156c7	SE004A	3	I	t	APL11	f	2022-08-09 15:20:46.343397	2022-08-09 15:20:46.343397
694f1aab-ec8c-4b7e-a630-474c7d26bdcb	SE004A	3	W	t	APL11	f	2022-08-09 15:20:46.34952	2022-08-09 15:20:46.34952
54918f39-9544-4dd9-9b3e-8798cab787c5	SE004A	3	Z	t	APL11	f	2022-08-09 15:20:46.35607	2022-08-09 15:20:46.35607
07244d47-920d-4c0c-9114-4266174c4790	SE004A	3	A	f	APL11	f	2022-08-09 15:20:46.362531	2022-08-09 15:20:46.362531
601d5e94-fc1a-4157-b358-36b4cb201cea	SE004A	3	D	f	APL11	f	2022-08-09 15:20:46.368629	2022-08-09 15:20:46.368629
8f0df9d3-69e9-4e08-bb15-9c18b5713524	SE004A	3	I	f	APL11	f	2022-08-09 15:20:46.374438	2022-08-09 15:20:46.374438
28e9e385-4a7a-4d3b-8262-72b432bb2273	SE004A	3	W	f	APL11	f	2022-08-09 15:20:46.380619	2022-08-09 15:20:46.380619
cd02b05e-345e-4d4a-adc6-85b697a3823e	SE004A	3	Z	f	APL11	f	2022-08-09 15:20:46.386492	2022-08-09 15:20:46.386492
0e58661a-9bfe-4843-93cf-f26a9e10f8dc	SE004A	3	A	t	APL13	f	2022-08-09 15:20:46.392362	2022-08-09 15:20:46.392362
f6a29277-73a8-4411-849e-36d49b2b1d94	SE004A	3	D	t	APL13	f	2022-08-09 15:20:46.399177	2022-08-09 15:20:46.399177
eba0d3fd-eff8-41df-8aba-c452dd159de1	SE004A	3	I	t	APL13	f	2022-08-09 15:20:46.40581	2022-08-09 15:20:46.40581
0e0d1f71-f2a3-436b-a581-1edc0e297192	SE004A	3	W	t	APL13	f	2022-08-09 15:20:46.411567	2022-08-09 15:20:46.411567
2c7fcec5-36d6-46f5-991c-a5785845f642	SE004A	3	Z	t	APL13	f	2022-08-09 15:20:46.417197	2022-08-09 15:20:46.417197
e50559af-3e22-42e0-90ff-c7b45b44dd6d	SE004A	3	A	f	APL13	f	2022-08-09 15:20:46.422899	2022-08-09 15:20:46.422899
30fb40ad-0d61-4778-94fa-9c89117dee6c	SE004A	3	D	f	APL13	f	2022-08-09 15:20:46.430016	2022-08-09 15:20:46.430016
5d2ebdcb-97ae-4c2a-87e9-7d910c5e42d2	SE004A	3	I	f	APL13	f	2022-08-09 15:20:46.435622	2022-08-09 15:20:46.435622
1b3ce525-013d-4b05-a435-5a5219ce0a6f	SE004A	3	W	f	APL13	f	2022-08-09 15:20:46.441397	2022-08-09 15:20:46.441397
907067a8-9f98-41eb-a2b3-69092fbc1364	SE004A	3	Z	f	APL13	f	2022-08-09 15:20:46.446686	2022-08-09 15:20:46.446686
df0bf0c9-d321-4499-b390-f6a6ef0f6e64	SE004A	3	A	t	APL15	f	2022-08-09 15:20:46.452332	2022-08-09 15:20:46.452332
2f5e33fa-88cd-4569-bfd0-8689ffe02a9c	SE004A	3	D	t	APL15	f	2022-08-09 15:20:46.457827	2022-08-09 15:20:46.457827
bb8de0aa-6fa9-4355-997c-806fb27f4796	SE004A	3	I	t	APL15	f	2022-08-09 15:20:46.463964	2022-08-09 15:20:46.463964
c10015c3-5115-4ff9-90ae-3a41f6a2d47f	SE004A	3	W	t	APL15	f	2022-08-09 15:20:46.469845	2022-08-09 15:20:46.469845
d99cd2c1-0433-48af-b77c-e8a066951a1b	SE004A	3	Z	t	APL15	f	2022-08-09 15:20:46.475139	2022-08-09 15:20:46.475139
9d8edc95-58ec-45f0-9ddf-365f79784f9a	SE004A	3	A	f	APL15	f	2022-08-09 15:20:46.481163	2022-08-09 15:20:46.481163
db31d861-4728-447a-b088-9f4c343389b0	SE004A	3	D	f	APL15	f	2022-08-09 15:20:46.486567	2022-08-09 15:20:46.486567
b195fe5c-63ea-4e11-a716-22bed28e9e5f	SE004A	3	I	f	APL15	f	2022-08-09 15:20:46.492014	2022-08-09 15:20:46.492014
245c7c72-50c1-411b-93a3-8ee8cd0b023e	SE004A	3	W	f	APL15	f	2022-08-09 15:20:46.497783	2022-08-09 15:20:46.497783
7451524f-9aec-4789-8e6f-44d8ea202f2b	SE004A	3	Z	f	APL15	f	2022-08-09 15:20:46.503447	2022-08-09 15:20:46.503447
f5354b85-8696-4a1a-9c1d-242d8dcf5b85	SE004A	3	A	t	APL16	f	2022-08-09 15:20:46.510264	2022-08-09 15:20:46.510264
677bb298-b261-4d76-b7d4-f5c18d41ae32	SE004A	3	D	t	APL16	f	2022-08-09 15:20:46.515999	2022-08-09 15:20:46.515999
2000825b-dc0f-4565-9bad-7c45c4f47ba7	SE004A	3	I	t	APL16	f	2022-08-09 15:20:46.521998	2022-08-09 15:20:46.521998
e2054242-f836-4672-837d-059ae1e2b121	SE004A	3	W	t	APL16	f	2022-08-09 15:20:46.527346	2022-08-09 15:20:46.527346
aa1dbbeb-2180-4925-92be-d3dec062bdfa	SE004A	3	Z	t	APL16	f	2022-08-09 15:20:46.533372	2022-08-09 15:20:46.533372
0b913768-e002-4bb9-bfc7-a9279d66696d	SE004A	3	A	f	APL16	f	2022-08-09 15:20:46.538704	2022-08-09 15:20:46.538704
fa23e2cc-5013-4a9a-80b6-47f9bb53d32b	SE004A	3	D	f	APL16	f	2022-08-09 15:20:46.543944	2022-08-09 15:20:46.543944
3078d0cf-670a-4992-97d8-ef1e3f1c5ae7	SE004A	3	I	f	APL16	f	2022-08-09 15:20:46.549459	2022-08-09 15:20:46.549459
0c60f456-2d97-4a78-aeb6-6e70bb0b5d72	SE004A	3	W	f	APL16	f	2022-08-09 15:20:46.554909	2022-08-09 15:20:46.554909
05bbabf9-3493-4f78-9168-cc133e33328f	SE004A	3	Z	f	APL16	f	2022-08-09 15:20:46.560125	2022-08-09 15:20:46.560125
d04f8155-7f62-4695-b361-204502c1b382	SE004A	3	A	t	APL18	f	2022-08-09 15:20:46.565707	2022-08-09 15:20:46.565707
32e7a2ed-8fbd-4c40-87e5-d5d150537fd2	SE004A	3	D	t	APL18	f	2022-08-09 15:20:46.57088	2022-08-09 15:20:46.57088
e9f255bd-c570-474a-81a6-ca022a95e397	SE004A	3	I	t	APL18	f	2022-08-09 15:20:46.576827	2022-08-09 15:20:46.576827
fc5b2137-95b9-4b3b-9a50-987631da22f0	SE004A	3	W	t	APL18	f	2022-08-09 15:20:46.582682	2022-08-09 15:20:46.582682
9c478d23-9ab6-411e-9167-939d3a6a08cd	SE004A	3	Z	t	APL18	f	2022-08-09 15:20:46.588082	2022-08-09 15:20:46.588082
697a5b97-6d84-431d-a3a3-ca3d1b5ecdf2	SE004A	3	A	f	APL18	f	2022-08-09 15:20:46.593616	2022-08-09 15:20:46.593616
66eef92e-1e00-46d4-9450-b3e87d89e7e2	SE004A	3	D	f	APL18	f	2022-08-09 15:20:46.599218	2022-08-09 15:20:46.599218
d9d2aa2e-c0d7-466c-8608-a79f3fa04fb1	SE004A	3	I	f	APL18	f	2022-08-09 15:20:46.604774	2022-08-09 15:20:46.604774
34de6765-3d70-4cf7-a959-ca4924d6d834	SE004A	3	W	f	APL18	f	2022-08-09 15:20:46.610199	2022-08-09 15:20:46.610199
ee8c8c17-a20c-4e22-9755-2282640cd3cf	SE004A	3	Z	f	APL18	f	2022-08-09 15:20:46.615549	2022-08-09 15:20:46.615549
9a642fb3-cf9c-43b2-9e9a-27e6970ad089	SE004A	3	A	t	APL20	f	2022-08-09 15:20:46.621211	2022-08-09 15:20:46.621211
391b856a-849e-4af4-ab04-b6f409187b26	SE004A	3	D	t	APL20	f	2022-08-09 15:20:46.626553	2022-08-09 15:20:46.626553
7694913d-3385-41da-a602-9c430f15de7e	SE004A	3	I	t	APL20	f	2022-08-09 15:20:46.632363	2022-08-09 15:20:46.632363
9ca2ebb6-9b16-459a-94f6-976b3a29b144	SE004A	3	W	t	APL20	f	2022-08-09 15:20:46.637872	2022-08-09 15:20:46.637872
f8f4f847-d65b-402e-bd74-088012981c84	SE004A	3	Z	t	APL20	f	2022-08-09 15:20:46.643233	2022-08-09 15:20:46.643233
f341842d-5c1c-4204-9425-93c8d83eb24b	SE004A	3	A	f	APL20	f	2022-08-09 15:20:46.648958	2022-08-09 15:20:46.648958
141d0cfc-1e26-41e1-9c58-b76c8404d379	SE004A	3	D	f	APL20	f	2022-08-09 15:20:46.654546	2022-08-09 15:20:46.654546
e251387b-e98e-49d0-977e-08cd277ed0e2	SE004A	3	I	f	APL20	f	2022-08-09 15:20:46.659821	2022-08-09 15:20:46.659821
410335c2-153c-4665-9f7d-6182d7dea9d8	SE004A	3	W	f	APL20	f	2022-08-09 15:20:46.666546	2022-08-09 15:20:46.666546
1dde884d-cc08-4e30-85e4-fc5ed68f3abf	SE004A	3	Z	f	APL20	f	2022-08-09 15:20:46.673111	2022-08-09 15:20:46.673111
278e0e0d-5a83-4184-a88b-8630b2e8fbd0	SE004A	3	A	t	APL22	f	2022-08-09 15:20:46.678925	2022-08-09 15:20:46.678925
493d1d36-76a7-41be-afd1-fe86bbc3f405	SE004A	3	D	t	APL22	f	2022-08-09 15:20:46.684678	2022-08-09 15:20:46.684678
3e29e8c6-e8dd-41ea-ad90-d5ddd06351e4	SE004A	3	I	t	APL22	f	2022-08-09 15:20:46.690258	2022-08-09 15:20:46.690258
97158d8d-e451-4a30-ad6b-d09287eb8645	SE004A	3	W	t	APL22	f	2022-08-09 15:20:46.695952	2022-08-09 15:20:46.695952
13bcafcb-e844-4a60-90a2-f0aa4c5715f6	SE004A	3	Z	t	APL22	f	2022-08-09 15:20:46.701617	2022-08-09 15:20:46.701617
ae01ed94-5668-4ee9-b1cd-a7bf5dbe7e53	SE004A	3	A	f	APL22	f	2022-08-09 15:20:46.70686	2022-08-09 15:20:46.70686
11d364d6-7c38-4917-ba1c-352d99773a46	SE004A	3	D	f	APL22	f	2022-08-09 15:20:46.712758	2022-08-09 15:20:46.712758
f40e786f-45df-4a68-ba7a-15270099c21b	SE004A	3	I	f	APL22	f	2022-08-09 15:20:46.718458	2022-08-09 15:20:46.718458
02de23dd-d5a4-4417-a570-3f104a89795b	SE004A	3	W	f	APL22	f	2022-08-09 15:20:46.724146	2022-08-09 15:20:46.724146
4c7deb89-e7da-45b9-94f0-3f34015bcca9	SE004A	3	Z	f	APL22	f	2022-08-09 15:20:46.729441	2022-08-09 15:20:46.729441
fdeb3e63-d13d-48e8-966e-a2c39161ba57	SE004A	3	A	t	APL27	f	2022-08-09 15:20:46.735098	2022-08-09 15:20:46.735098
3afc8879-6eff-42dd-ab5a-ed2e2d108ea8	SE004A	3	D	t	APL27	f	2022-08-09 15:20:46.740377	2022-08-09 15:20:46.740377
0a86817a-24c9-4068-946c-a9be95c62e44	SE004A	3	I	t	APL27	f	2022-08-09 15:20:46.745772	2022-08-09 15:20:46.745772
b5662167-ae42-47f0-83cd-48528fa8ffdd	SE004A	3	W	t	APL27	f	2022-08-09 15:20:46.752939	2022-08-09 15:20:46.752939
397bfc65-df5b-476a-b314-2e0585a05786	SE004A	3	Z	t	APL27	f	2022-08-09 15:20:46.758701	2022-08-09 15:20:46.758701
a02f092d-3cb0-48d2-a02b-91a74e409129	SE004A	3	A	f	APL27	f	2022-08-09 15:20:46.764531	2022-08-09 15:20:46.764531
2a4e93e7-bb0c-43bf-81c2-ec04566760ce	SE004A	3	D	f	APL27	f	2022-08-09 15:20:46.770157	2022-08-09 15:20:46.770157
0bb84ec4-1864-4446-9ee0-52e0dd93bd06	SE004A	3	I	f	APL27	f	2022-08-09 15:20:46.775552	2022-08-09 15:20:46.775552
c3542ae3-fce8-4749-97f0-96a5c6168ec0	SE004A	3	W	f	APL27	f	2022-08-09 15:20:46.781826	2022-08-09 15:20:46.781826
313ae31a-f316-4da4-80ee-b656cfb2e908	SE004A	3	Z	f	APL27	f	2022-08-09 15:20:46.787495	2022-08-09 15:20:46.787495
d7397ed3-2383-4103-8ede-852855b0eba5	SE004A	3	A	t	APL29	f	2022-08-09 15:20:46.79322	2022-08-09 15:20:46.79322
51c4d039-431b-416b-acd8-6fc26e471ded	SE004A	3	D	t	APL29	f	2022-08-09 15:20:46.798605	2022-08-09 15:20:46.798605
85633b77-9dfc-4818-8d4d-87d7fa9fb834	SE004A	3	I	t	APL29	f	2022-08-09 15:20:46.804396	2022-08-09 15:20:46.804396
c9e6b1af-17e6-41fb-9d36-3c508ff4dff2	SE004A	3	W	t	APL29	f	2022-08-09 15:20:46.809977	2022-08-09 15:20:46.809977
5ed62db2-af9f-4bec-8b62-984ffeadf927	SE004A	3	Z	t	APL29	f	2022-08-09 15:20:46.815797	2022-08-09 15:20:46.815797
4e5bd5cc-99eb-4603-bc68-a2517a408879	SE004A	3	A	f	APL29	f	2022-08-09 15:20:46.821125	2022-08-09 15:20:46.821125
3e67bcba-3c6c-4daf-95a8-2b44cba63fb9	SE004A	3	D	f	APL29	f	2022-08-09 15:20:46.826898	2022-08-09 15:20:46.826898
0fdbc30d-fd27-427b-9680-71c0a2754f7d	SE004A	3	I	f	APL29	f	2022-08-09 15:20:46.832416	2022-08-09 15:20:46.832416
a7a66ce5-9494-4cac-8eeb-d785099ca183	SE004A	3	W	f	APL29	f	2022-08-09 15:20:46.838027	2022-08-09 15:20:46.838027
1a6fd034-f602-453c-b526-753255ac8be8	SE004A	3	Z	f	APL29	f	2022-08-09 15:20:46.843291	2022-08-09 15:20:46.843291
602ccef8-3ae5-4d75-bfa5-35d537feb10c	SE004A	3	A	t	APL31	f	2022-08-09 15:20:46.848988	2022-08-09 15:20:46.848988
17eaed70-0d87-4dac-9bc3-528a89439ded	SE004A	3	D	t	APL31	f	2022-08-09 15:20:46.854318	2022-08-09 15:20:46.854318
8dedc42c-2e40-4baf-991d-75a1fdbf6eae	SE004A	3	I	t	APL31	f	2022-08-09 15:20:46.859477	2022-08-09 15:20:46.859477
b74a1788-7e3d-4d74-b803-587b48e7db47	SE004A	3	W	t	APL31	f	2022-08-09 15:20:46.865096	2022-08-09 15:20:46.865096
54fc0d4e-1c28-4916-aeb4-beb386bec779	SE004A	3	Z	t	APL31	f	2022-08-09 15:20:46.870509	2022-08-09 15:20:46.870509
719a1a44-add9-46ab-8612-094b12447c9d	SE004A	3	A	f	APL31	f	2022-08-09 15:20:46.875894	2022-08-09 15:20:46.875894
bb716661-360e-43fd-a944-f1a0ac69f92a	SE004A	3	D	f	APL31	f	2022-08-09 15:20:46.8815	2022-08-09 15:20:46.8815
57bc3326-771b-4ae3-9882-e7eabde00858	SE004A	3	I	f	APL31	f	2022-08-09 15:20:46.88684	2022-08-09 15:20:46.88684
df3f270f-b51a-4df5-811a-9c810812f55f	SE004A	3	W	f	APL31	f	2022-08-09 15:20:46.892326	2022-08-09 15:20:46.892326
fd167eef-56d6-4127-9b85-917ee4a5fe99	SE004A	3	Z	f	APL31	f	2022-08-09 15:20:46.897726	2022-08-09 15:20:46.897726
010ee745-8d78-421d-89d9-8cb1ba2ae3b7	SE004A	3	A	t	APL48	f	2022-08-09 15:20:46.903024	2022-08-09 15:20:46.903024
1c3ed09a-84f2-4a07-93ad-614d73eeb7e5	SE004A	3	D	t	APL48	f	2022-08-09 15:20:46.908692	2022-08-09 15:20:46.908692
70b89c74-5fb0-4445-bab3-88a071bc6ee2	SE004A	3	I	t	APL48	f	2022-08-09 15:20:46.914047	2022-08-09 15:20:46.914047
48102e21-5b34-46f2-92a4-8d3a59a12636	SE004A	3	W	t	APL48	f	2022-08-09 15:20:46.919408	2022-08-09 15:20:46.919408
945fe686-8c76-4bce-b532-8221717f6bd4	SE004A	3	Z	t	APL48	f	2022-08-09 15:20:46.925307	2022-08-09 15:20:46.925307
8c124513-e00c-4329-a32a-0abb4c647f47	SE004A	3	A	f	APL48	f	2022-08-09 15:20:46.930714	2022-08-09 15:20:46.930714
32e4d445-f100-4f7e-8a95-0f45f08ab35e	SE004A	3	D	f	APL48	f	2022-08-09 15:20:46.936404	2022-08-09 15:20:46.936404
efcbeb21-8452-42f4-bc7d-0cbf1383e45d	SE004A	3	I	f	APL48	f	2022-08-09 15:20:46.94232	2022-08-09 15:20:46.94232
7ab3b157-f29e-4927-baa2-2107158e1ee2	SE004A	3	W	f	APL48	f	2022-08-09 15:20:46.948017	2022-08-09 15:20:46.948017
0fd8c417-067c-4cab-ba94-31b1d530ce34	SE004A	3	Z	f	APL48	f	2022-08-09 15:20:46.953649	2022-08-09 15:20:46.953649
dc7c50e5-f6fd-4604-9803-e3bdd75056e6	SE004A	3	A	t	APL49	f	2022-08-09 15:20:46.959074	2022-08-09 15:20:46.959074
5b0b562e-82dc-4583-b5b1-c272c7645b4d	SE004A	3	D	t	APL49	f	2022-08-09 15:20:46.964936	2022-08-09 15:20:46.964936
cd896f2a-3f68-4ec7-9eae-9f7b20935809	SE004A	3	I	t	APL49	f	2022-08-09 15:20:46.971773	2022-08-09 15:20:46.971773
fdf39f8e-aa11-4add-80dd-f56d9fab059a	SE004A	3	W	t	APL49	f	2022-08-09 15:20:46.978232	2022-08-09 15:20:46.978232
feccb044-8840-44bd-959a-f477be25cdd8	SE004A	3	Z	t	APL49	f	2022-08-09 15:20:46.985115	2022-08-09 15:20:46.985115
f4b72d6d-7b4e-4f32-93c7-56fd9eb73683	SE004A	3	A	f	APL49	f	2022-08-09 15:20:46.990921	2022-08-09 15:20:46.990921
c57435f6-2691-4451-b2bd-77cd565afb19	SE004A	3	D	f	APL49	f	2022-08-09 15:20:46.997139	2022-08-09 15:20:46.997139
30070fd8-981c-4050-9b28-a6b0f7c82d3d	SE004A	3	I	f	APL49	f	2022-08-09 15:20:47.003826	2022-08-09 15:20:47.003826
61812e49-2e6c-4087-9f68-1afcff5919c5	SE004A	3	W	f	APL49	f	2022-08-09 15:20:47.009963	2022-08-09 15:20:47.009963
c048afda-dbe2-4cc7-b062-7adfb413da3c	SE004A	3	Z	f	APL49	f	2022-08-09 15:20:47.015662	2022-08-09 15:20:47.015662
85643474-53a6-438c-aded-d394f5d33acc	SE004A	3	A	t	APL50	f	2022-08-09 15:20:47.021477	2022-08-09 15:20:47.021477
ee1a4a78-7aef-422f-87e4-951c857818a7	SE004A	3	D	t	APL50	f	2022-08-09 15:20:47.026891	2022-08-09 15:20:47.026891
d1aa7f04-3279-45d1-928d-b21fede92e78	SE004A	3	I	t	APL50	f	2022-08-09 15:20:47.033201	2022-08-09 15:20:47.033201
29c8f950-eeab-4690-9610-8db0f9140a16	SE004A	3	W	t	APL50	f	2022-08-09 15:20:47.03926	2022-08-09 15:20:47.03926
08288cdb-8a1d-4831-af5b-bb2c85394830	SE004A	3	Z	t	APL50	f	2022-08-09 15:20:47.045144	2022-08-09 15:20:47.045144
dc1aac01-0f8c-4e70-b552-9f0f68b71c28	SE004A	3	A	f	APL50	f	2022-08-09 15:20:47.05164	2022-08-09 15:20:47.05164
c8086c0e-7e87-4152-85f7-94552482eb5e	SE004A	3	D	f	APL50	f	2022-08-09 15:20:47.058117	2022-08-09 15:20:47.058117
a8d1267e-5343-450b-8837-72e537775e0a	SE004A	3	I	f	APL50	f	2022-08-09 15:20:47.063993	2022-08-09 15:20:47.063993
9f821a07-c36b-47e9-bc5f-2b3d4aea5e02	SE004A	3	W	f	APL50	f	2022-08-09 15:20:47.069537	2022-08-09 15:20:47.069537
eb886d64-49b1-41ab-a404-a1c2d0c0f171	SE004A	3	Z	f	APL50	f	2022-08-09 15:20:47.076049	2022-08-09 15:20:47.076049
9fb91013-e96f-4136-a1d5-770f2958149f	SE004A	3	A	t	APL51	f	2022-08-09 15:20:47.083599	2022-08-09 15:20:47.083599
6c82fe6f-f5f2-46e3-a0ac-c75bbcb734b0	SE004A	3	D	t	APL51	f	2022-08-09 15:20:47.090982	2022-08-09 15:20:47.090982
417275d7-da30-4ffc-ab24-b51f56f1bb77	SE004A	3	I	t	APL51	f	2022-08-09 15:20:47.096894	2022-08-09 15:20:47.096894
526fd2a1-3cf0-4331-bb2f-0d297e976344	SE004A	3	W	t	APL51	f	2022-08-09 15:20:47.104018	2022-08-09 15:20:47.104018
36b38c0f-2dc0-47a5-8e40-9c323823a020	SE004A	3	Z	t	APL51	f	2022-08-09 15:20:47.11003	2022-08-09 15:20:47.11003
6266468b-297d-4efa-9f49-81ef293e6da5	SE004A	3	A	f	APL51	f	2022-08-09 15:20:47.116425	2022-08-09 15:20:47.116425
2278c069-0242-45eb-8bb5-8a015e2151da	SE004A	3	D	f	APL51	f	2022-08-09 15:20:47.123051	2022-08-09 15:20:47.123051
0ecad49a-7d50-4bbf-810f-c61eca78a442	SE004A	3	I	f	APL51	f	2022-08-09 15:20:47.128778	2022-08-09 15:20:47.128778
29250e5e-1ee2-44ff-a647-b0a5987d2551	SE004A	3	W	f	APL51	f	2022-08-09 15:20:47.13432	2022-08-09 15:20:47.13432
4063905e-94dd-4953-9b9d-24b4ddc9ef9d	SE004A	3	Z	f	APL51	f	2022-08-09 15:20:47.139501	2022-08-09 15:20:47.139501
a0d4e782-6249-4b3f-9cc7-1edc91fd6968	SE004A	3	A	t	APL52	f	2022-08-09 15:20:47.145427	2022-08-09 15:20:47.145427
8deb936c-8c43-42d6-8472-085fc15c8a9f	SE004A	3	D	t	APL52	f	2022-08-09 15:20:47.151178	2022-08-09 15:20:47.151178
0d8fba28-eee4-4078-8bcc-0ce414aa913d	SE004A	3	I	t	APL52	f	2022-08-09 15:20:47.156978	2022-08-09 15:20:47.156978
14c38e43-45dd-4c6f-9d18-b2abb802287a	SE004A	3	W	t	APL52	f	2022-08-09 15:20:47.163218	2022-08-09 15:20:47.163218
b83b531a-5d62-401f-a389-8420dafdd4e3	SE004A	3	Z	t	APL52	f	2022-08-09 15:20:47.168855	2022-08-09 15:20:47.168855
54362b60-8e19-4209-85a0-52b35818dc2c	SE004A	3	A	f	APL52	f	2022-08-09 15:20:47.174522	2022-08-09 15:20:47.174522
2a6dcd69-2c4e-495f-b508-cc609622ae62	SE004A	3	D	f	APL52	f	2022-08-09 15:20:47.179782	2022-08-09 15:20:47.179782
77b14a84-4b56-43d5-8368-898aa8c56fa9	SE004A	3	I	f	APL52	f	2022-08-09 15:20:47.185432	2022-08-09 15:20:47.185432
37f4b50f-f2a7-4ec7-8693-18b3697abb18	SE004A	3	W	f	APL52	f	2022-08-09 15:20:47.190903	2022-08-09 15:20:47.190903
675057a8-b940-4c3e-b9ab-3a724e5d2dae	SE004A	3	Z	f	APL52	f	2022-08-09 15:20:47.197325	2022-08-09 15:20:47.197325
d3c16c66-9469-4378-9d2c-8dbf02668d37	SE004A	3	A	t	APL53	f	2022-08-09 15:20:47.203672	2022-08-09 15:20:47.203672
47c13d95-9be3-4704-b612-a1b6bae263b8	SE004A	3	D	t	APL53	f	2022-08-09 15:20:47.209591	2022-08-09 15:20:47.209591
9d2f8335-27b1-4e6f-a845-174be5f75bba	SE004A	3	I	t	APL53	f	2022-08-09 15:20:47.215912	2022-08-09 15:20:47.215912
dd4b719e-db02-4d00-8645-3acd645089a2	SE004A	3	W	t	APL53	f	2022-08-09 15:20:47.221908	2022-08-09 15:20:47.221908
8b7ca78e-6f4d-4074-ae84-a1aba1146fb5	SE004A	3	Z	t	APL53	f	2022-08-09 15:20:47.227542	2022-08-09 15:20:47.227542
4dc7db44-dbd3-4bf4-9bf1-a935b0637ad4	SE004A	3	A	f	APL53	f	2022-08-09 15:20:47.23399	2022-08-09 15:20:47.23399
960fffec-1e5f-4351-bdad-5cf43155f469	SE004A	3	D	f	APL53	f	2022-08-09 15:20:47.239938	2022-08-09 15:20:47.239938
38eb2de3-8c23-43fc-9091-2d253b362930	SE004A	3	I	f	APL53	f	2022-08-09 15:20:47.246499	2022-08-09 15:20:47.246499
060128ca-deea-4b96-84be-f95567dcaf3a	SE004A	3	W	f	APL53	f	2022-08-09 15:20:47.252565	2022-08-09 15:20:47.252565
b81200c2-ae2f-4a11-a71f-29261ce1dc64	SE004A	3	Z	f	APL53	f	2022-08-09 15:20:47.258612	2022-08-09 15:20:47.258612
861d0dd4-42e2-44b3-bec7-b20794e791e2	SE004A	3	A	t	APL54	f	2022-08-09 15:20:47.264372	2022-08-09 15:20:47.264372
71b0a1fb-c88f-4f3b-a5a9-925a14b53225	SE004A	3	D	t	APL54	f	2022-08-09 15:20:47.270657	2022-08-09 15:20:47.270657
12444ab3-24e7-4abb-9984-08459813de96	SE004A	3	I	t	APL54	f	2022-08-09 15:20:47.277222	2022-08-09 15:20:47.277222
6f9adadb-a264-4812-806f-362a0211db4e	SE004A	3	W	t	APL54	f	2022-08-09 15:20:47.283007	2022-08-09 15:20:47.283007
c86b0e61-2069-4034-9bc2-9cac7e80f8da	SE004A	3	Z	t	APL54	f	2022-08-09 15:20:47.288264	2022-08-09 15:20:47.288264
46949c63-8e03-4c92-9711-fa5ed577cf10	SE004A	3	A	f	APL54	f	2022-08-09 15:20:47.294606	2022-08-09 15:20:47.294606
69056f6c-9112-4013-9c7a-c0b36b424ca5	SE004A	3	D	f	APL54	f	2022-08-09 15:20:47.300154	2022-08-09 15:20:47.300154
ec50d4c6-4e59-487c-94d8-1b70278a925f	SE004A	3	I	f	APL54	f	2022-08-09 15:20:47.306063	2022-08-09 15:20:47.306063
73b91078-2d3b-406c-8ee6-0d9eadc8cada	SE004A	3	W	f	APL54	f	2022-08-09 15:20:47.311704	2022-08-09 15:20:47.311704
94e3be51-fb82-45a2-9c19-5c5faafe66c7	SE004A	3	Z	f	APL54	f	2022-08-09 15:20:47.317121	2022-08-09 15:20:47.317121
b10ca35d-d622-484d-a5ff-c6fcf4ac6602	SE004A	3	A	t	APL55	f	2022-08-09 15:20:47.322828	2022-08-09 15:20:47.322828
185901b7-6de6-4c67-9798-b0fa8482bee1	SE004A	3	D	t	APL55	f	2022-08-09 15:20:47.328671	2022-08-09 15:20:47.328671
390ec515-3f0a-47a2-800f-c771abd3709c	SE004A	3	I	t	APL55	f	2022-08-09 15:20:47.334434	2022-08-09 15:20:47.334434
408a9eaf-85e9-48df-b0f0-376d408d091b	SE004A	3	W	t	APL55	f	2022-08-09 15:20:47.340795	2022-08-09 15:20:47.340795
5da456a0-2ce7-43e1-a773-954b9f2be690	SE004A	3	Z	t	APL55	f	2022-08-09 15:20:47.347603	2022-08-09 15:20:47.347603
f83c2f24-3c42-4af3-93de-ae9c40352566	SE004A	3	A	f	APL55	f	2022-08-09 15:20:47.354782	2022-08-09 15:20:47.354782
36584c58-90b6-4a66-80de-2a58abfec0da	SE004A	3	D	f	APL55	f	2022-08-09 15:20:47.360525	2022-08-09 15:20:47.360525
9188df06-d583-4c48-abdf-ab92781ff5f8	SE004A	3	I	f	APL55	f	2022-08-09 15:20:47.366233	2022-08-09 15:20:47.366233
8e4f68ea-f53a-464d-b5bb-66d009ec577c	SE004A	3	W	f	APL55	f	2022-08-09 15:20:47.372931	2022-08-09 15:20:47.372931
abb7b3fe-5a8e-4360-a979-6f929778e8cc	SE004A	3	Z	f	APL55	f	2022-08-09 15:20:47.380076	2022-08-09 15:20:47.380076
533759bd-bf5d-4d80-82b6-4bc40caf4348	SE004A	3	A	t	APL56	f	2022-08-09 15:20:47.386015	2022-08-09 15:20:47.386015
c7a4b122-60f4-4d9d-9ead-e212e1da6456	SE004A	3	D	t	APL56	f	2022-08-09 15:20:47.391751	2022-08-09 15:20:47.391751
0468c556-b32d-45b5-8a00-0174d62c3ad2	SE004A	3	I	t	APL56	f	2022-08-09 15:20:47.39702	2022-08-09 15:20:47.39702
f7cfd644-cf5d-4174-85c9-c1201992a264	SE004A	3	W	t	APL56	f	2022-08-09 15:20:47.403766	2022-08-09 15:20:47.403766
07c34b28-029c-4f06-8cbe-4a186ffe6838	SE004A	3	Z	t	APL56	f	2022-08-09 15:20:47.409671	2022-08-09 15:20:47.409671
4ba41d2f-77cf-4cc6-8a31-ed7af4e64411	SE004A	3	A	f	APL56	f	2022-08-09 15:20:47.415564	2022-08-09 15:20:47.415564
4a56f0b3-063c-4c53-9598-8d22f093bef1	SE004A	3	D	f	APL56	f	2022-08-09 15:20:47.421191	2022-08-09 15:20:47.421191
e7828d2d-939f-4d7c-9fc5-e1919b9182c7	SE004A	3	I	f	APL56	f	2022-08-09 15:20:47.427777	2022-08-09 15:20:47.427777
05c560fb-4a52-4f00-a253-2bc156926764	SE004A	3	W	f	APL56	f	2022-08-09 15:20:47.435178	2022-08-09 15:20:47.435178
13855e99-fa4d-4175-97f4-d191ce260bf6	SE004A	3	Z	f	APL56	f	2022-08-09 15:20:47.441443	2022-08-09 15:20:47.441443
f4246d24-1faa-4748-bbd0-1542c9d89df6	SE004A	3	A	t	APL57	f	2022-08-09 15:20:47.447894	2022-08-09 15:20:47.447894
2d35b5b1-19e3-498a-926f-28a94ee5cf4c	SE004A	3	D	t	APL57	f	2022-08-09 15:20:47.454079	2022-08-09 15:20:47.454079
326d6589-fa35-437b-acd1-20065a84a911	SE004A	3	I	t	APL57	f	2022-08-09 15:20:47.459844	2022-08-09 15:20:47.459844
f731907a-e49b-407f-beb3-2c481af05922	SE004A	3	W	t	APL57	f	2022-08-09 15:20:47.466326	2022-08-09 15:20:47.466326
e2d1664f-0d8c-4b28-9cce-f64919c62ef9	SE004A	3	Z	t	APL57	f	2022-08-09 15:20:47.472316	2022-08-09 15:20:47.472316
e6a51f2e-fe05-4bdb-b706-6c2a8ca98fa0	SE004A	3	A	f	APL57	f	2022-08-09 15:20:47.478223	2022-08-09 15:20:47.478223
5180e510-0176-4339-996c-4b0f0484f534	SE004A	3	D	f	APL57	f	2022-08-09 15:20:47.483775	2022-08-09 15:20:47.483775
9e405f4a-2505-4a43-8aad-199cb09ed431	SE004A	3	I	f	APL57	f	2022-08-09 15:20:47.489607	2022-08-09 15:20:47.489607
bfa431ff-4c19-4cfc-806e-23fbdcfdc63b	SE004A	3	W	f	APL57	f	2022-08-09 15:20:47.49568	2022-08-09 15:20:47.49568
c8b76a36-8780-4345-918e-9032643d8009	SE004A	3	Z	f	APL57	f	2022-08-09 15:20:47.501916	2022-08-09 15:20:47.501916
36444112-c88e-43aa-96b2-5a6fc40ce445	SE004A	3	A	t	APL65	f	2022-08-09 15:20:47.507231	2022-08-09 15:20:47.507231
b287fefa-8334-46fb-8d39-2873f349c002	SE004A	3	D	t	APL65	f	2022-08-09 15:20:47.512752	2022-08-09 15:20:47.512752
1b99a71b-c0ae-44fb-9328-b615b57e7e4c	SE004A	3	I	t	APL65	f	2022-08-09 15:20:47.518161	2022-08-09 15:20:47.518161
a5cfb988-a732-4599-a851-5e760722add1	SE004A	3	W	t	APL65	f	2022-08-09 15:20:47.524205	2022-08-09 15:20:47.524205
e5b9f16c-aaab-4213-9406-e57830448e64	SE004A	3	Z	t	APL65	f	2022-08-09 15:20:47.530962	2022-08-09 15:20:47.530962
aee2af60-9b17-43ef-8f1c-52b30e60ccf3	SE004A	3	A	f	APL65	f	2022-08-09 15:20:47.537028	2022-08-09 15:20:47.537028
f059aa9b-8198-40bb-9dc7-66a6a4459669	SE004A	3	D	f	APL65	f	2022-08-09 15:20:47.54288	2022-08-09 15:20:47.54288
1876f271-c115-4d0f-b5e7-22de4d5c5d57	SE004A	3	I	f	APL65	f	2022-08-09 15:20:47.548385	2022-08-09 15:20:47.548385
03ff68fc-2138-457a-b6c7-f8626e3ddd60	SE004A	3	W	f	APL65	f	2022-08-09 15:20:47.554416	2022-08-09 15:20:47.554416
a88ca9bf-ea3c-476a-8991-6e11f290b07c	SE004A	3	Z	f	APL65	f	2022-08-09 15:20:47.5604	2022-08-09 15:20:47.5604
7c48c4b2-c2ff-4dac-8a19-be1775ff3b75	SE004A	3	A	t	APL66	f	2022-08-09 15:20:47.566271	2022-08-09 15:20:47.566271
7209d08d-7423-42fa-822d-7bdd2b167253	SE004A	3	D	t	APL66	f	2022-08-09 15:20:47.571709	2022-08-09 15:20:47.571709
f0152907-aeeb-473d-a82a-bbeef719b659	SE004A	3	I	t	APL66	f	2022-08-09 15:20:47.576741	2022-08-09 15:20:47.576741
6cf25b01-b20b-429d-8b17-346d967afe59	SE004A	3	W	t	APL66	f	2022-08-09 15:20:47.583228	2022-08-09 15:20:47.583228
41a1169d-9b4a-4838-bb62-2aeca35adc49	SE004A	3	Z	t	APL66	f	2022-08-09 15:20:47.589471	2022-08-09 15:20:47.589471
efc1a946-2ec5-452d-be5b-a7b5dab5b42e	SE004A	3	A	f	APL66	f	2022-08-09 15:20:47.59505	2022-08-09 15:20:47.59505
64a93bc1-036f-40a6-80de-1ef33e3aae18	SE004A	3	D	f	APL66	f	2022-08-09 15:20:47.600831	2022-08-09 15:20:47.600831
6ed9d5be-c73c-4082-bb4a-9a6ebf680c8d	SE004A	3	I	f	APL66	f	2022-08-09 15:20:47.606461	2022-08-09 15:20:47.606461
b42b9f3e-9458-4839-94c4-506ddadbdfe1	SE004A	3	W	f	APL66	f	2022-08-09 15:20:47.612426	2022-08-09 15:20:47.612426
2c8ba636-1b4a-4612-945a-22aaca9a7485	SE004A	3	Z	f	APL66	f	2022-08-09 15:20:47.618687	2022-08-09 15:20:47.618687
e983c68a-fe64-4fc4-a5a6-38a1a3343b10	SE004A	3	A	t	APL67	f	2022-08-09 15:20:47.624758	2022-08-09 15:20:47.624758
7243844e-4179-4c2b-89f0-259cb798688d	SE004A	3	D	t	APL67	f	2022-08-09 15:20:47.630836	2022-08-09 15:20:47.630836
5b58c837-4f40-44e9-af1c-ca9133d4defa	SE004A	3	I	t	APL67	f	2022-08-09 15:20:47.636629	2022-08-09 15:20:47.636629
9d877a4e-6a1b-4dbd-b588-27e0b2abf7c9	SE004A	3	W	t	APL67	f	2022-08-09 15:20:47.642733	2022-08-09 15:20:47.642733
ca75a5fc-1f9e-4896-9004-e14dd4b7ab03	SE004A	3	Z	t	APL67	f	2022-08-09 15:20:47.648638	2022-08-09 15:20:47.648638
6dc89d29-3153-4437-9eaf-22aaecc2fade	SE004A	3	A	f	APL67	f	2022-08-09 15:20:47.654456	2022-08-09 15:20:47.654456
48c71cae-90d8-469f-9d2b-797d16e49766	SE004A	3	D	f	APL67	f	2022-08-09 15:20:47.660965	2022-08-09 15:20:47.660965
7f27e9e6-360a-49ad-954c-daf0bdac1422	SE004A	3	I	f	APL67	f	2022-08-09 15:20:47.666568	2022-08-09 15:20:47.666568
0f8b248f-8f7b-4b3e-a7bb-9920c7d24539	SE004A	3	W	f	APL67	f	2022-08-09 15:20:47.671967	2022-08-09 15:20:47.671967
21e6dbc1-55be-4325-8fc6-82a82eca70c7	SE004A	3	Z	f	APL67	f	2022-08-09 15:20:47.678232	2022-08-09 15:20:47.678232
c9b41c17-5797-4390-9b45-05c3443b01c6	SE004A	3	A	t	APL68	f	2022-08-09 15:20:47.684308	2022-08-09 15:20:47.684308
e5c5ecd8-a858-4c5a-98d8-632260d724c5	SE004A	3	D	t	APL68	f	2022-08-09 15:20:47.69034	2022-08-09 15:20:47.69034
46d4a2a9-f897-4412-ad91-67d6452e87aa	SE004A	3	I	t	APL68	f	2022-08-09 15:20:47.696901	2022-08-09 15:20:47.696901
8619bdf0-1ca8-4085-ba67-8a666347678b	SE004A	3	W	t	APL68	f	2022-08-09 15:20:47.702625	2022-08-09 15:20:47.702625
7d4b1786-8e4c-4967-9628-b51f35bf799c	SE004A	3	Z	t	APL68	f	2022-08-09 15:20:47.708623	2022-08-09 15:20:47.708623
fa8eb4de-1af1-49e6-ac3c-5e46f95cca3f	SE004A	3	A	f	APL68	f	2022-08-09 15:20:47.714943	2022-08-09 15:20:47.714943
05f71fad-24be-4b8b-90c0-76f70416ec7b	SE004A	3	D	f	APL68	f	2022-08-09 15:20:47.721687	2022-08-09 15:20:47.721687
08f72834-3579-4f1f-9599-d24b0e32a42d	SE004A	3	I	f	APL68	f	2022-08-09 15:20:47.728597	2022-08-09 15:20:47.728597
5b7e42a1-2df3-40e3-bed0-d04a1671f9f8	SE004A	3	W	f	APL68	f	2022-08-09 15:20:47.736478	2022-08-09 15:20:47.736478
2e723e12-4435-4d28-a006-e9baacddc3ab	SE004A	3	Z	f	APL68	f	2022-08-09 15:20:47.743909	2022-08-09 15:20:47.743909
5491f901-2f09-443c-a224-c03398214034	SE004A	3	A	t	APL69	f	2022-08-09 15:20:47.750179	2022-08-09 15:20:47.750179
68732c0d-a109-44cf-bfef-895ccd93c896	SE004A	3	D	t	APL69	f	2022-08-09 15:20:47.756525	2022-08-09 15:20:47.756525
14a17fc5-e527-4b79-a4ec-77a9d9b2e5eb	SE004A	3	I	t	APL69	f	2022-08-09 15:20:47.762954	2022-08-09 15:20:47.762954
22d8dc20-1d33-4194-b90d-13745ec0335a	SE004A	3	W	t	APL69	f	2022-08-09 15:20:47.769139	2022-08-09 15:20:47.769139
bc36ce8e-2daa-48b7-8b7d-3db7687bafe8	SE004A	3	Z	t	APL69	f	2022-08-09 15:20:47.77489	2022-08-09 15:20:47.77489
05fda53f-a294-4bf1-9ca1-21bc9848343a	SE004A	3	A	f	APL69	f	2022-08-09 15:20:47.781913	2022-08-09 15:20:47.781913
77eeba28-556f-4964-89f9-72e1953f4fc5	SE004A	3	D	f	APL69	f	2022-08-09 15:20:47.791525	2022-08-09 15:20:47.791525
5777fc20-e2c2-4ad2-80fb-2a13eed26b6b	SE004A	3	I	f	APL69	f	2022-08-09 15:20:47.798375	2022-08-09 15:20:47.798375
d3ce45f4-08db-49f3-9bf7-a7ba813d8087	SE004A	3	W	f	APL69	f	2022-08-09 15:20:47.805467	2022-08-09 15:20:47.805467
7fb4f66e-b45f-4231-9eef-74e3c672f6f1	SE004A	3	Z	f	APL69	f	2022-08-09 15:20:47.811294	2022-08-09 15:20:47.811294
3d0ba29e-f846-40f3-8f48-f0df80e05f57	SE004A	3	A	t	APL70	f	2022-08-09 15:20:47.816602	2022-08-09 15:20:47.816602
abdbc7df-6f1a-4ae1-8d67-d0a2dd90bb4b	SE004A	3	D	t	APL70	f	2022-08-09 15:20:47.822032	2022-08-09 15:20:47.822032
fe4cec45-d81b-456c-82d0-6186d72f3b76	SE004A	3	I	t	APL70	f	2022-08-09 15:20:47.828434	2022-08-09 15:20:47.828434
d35c352b-a88c-4928-bbf1-0949ac4f29b3	SE004A	3	W	t	APL70	f	2022-08-09 15:20:47.836921	2022-08-09 15:20:47.836921
fac36379-e820-446f-b459-4ed6e1dc8b14	SE004A	3	Z	t	APL70	f	2022-08-09 15:20:47.844829	2022-08-09 15:20:47.844829
c1482c74-6463-40fc-83c5-349b929a90f0	SE004A	3	A	f	APL70	f	2022-08-09 15:20:47.851729	2022-08-09 15:20:47.851729
7b5672e6-13dc-4cf1-b500-ca76e2b24abd	SE004A	3	D	f	APL70	f	2022-08-09 15:20:47.857622	2022-08-09 15:20:47.857622
8b9100a5-0b3c-4ec3-8ab7-e71d9129f285	SE004A	3	I	f	APL70	f	2022-08-09 15:20:47.862862	2022-08-09 15:20:47.862862
3ee6c9e6-38ef-4690-a90e-061a9fb474e2	SE004A	3	W	f	APL70	f	2022-08-09 15:20:47.868556	2022-08-09 15:20:47.868556
7e355dde-df01-4f50-9918-31617b33f64e	SE004A	3	Z	f	APL70	f	2022-08-09 15:20:47.873799	2022-08-09 15:20:47.873799
31db2fc7-2ad1-400b-b437-7666611c2619	SE004A	3	A	t	CV027	f	2022-08-09 15:20:47.881075	2022-08-09 15:20:47.881075
a48e088b-5f12-4e0c-a547-9a106afa4e55	SE004A	3	D	t	CV027	f	2022-08-09 15:20:47.890033	2022-08-09 15:20:47.890033
69c736b2-6cee-4795-91f3-b5970b1d7972	SE004A	3	I	t	CV027	f	2022-08-09 15:20:47.898301	2022-08-09 15:20:47.898301
22b20b33-008a-4bcf-aec3-e9ad736ab045	SE004A	3	W	t	CV027	f	2022-08-09 15:20:47.904093	2022-08-09 15:20:47.904093
dc6d4686-dbb1-4cf3-bb7d-16b11fee720e	SE004A	3	Z	t	CV027	f	2022-08-09 15:20:47.909756	2022-08-09 15:20:47.909756
9e3d17e1-85c7-4724-95f6-365f8bbaa840	SE004A	3	A	f	CV027	f	2022-08-09 15:20:47.91521	2022-08-09 15:20:47.91521
e1d8b187-ddfe-4675-a0d0-11f512c3b3a6	SE004A	3	D	f	CV027	f	2022-08-09 15:20:47.920526	2022-08-09 15:20:47.920526
413acf9c-dd5c-49d3-8104-5fef546af755	SE004A	3	I	f	CV027	f	2022-08-09 15:20:47.926283	2022-08-09 15:20:47.926283
5fb559c5-9e45-4f56-961e-17614ac6a0f4	SE004A	3	W	f	CV027	f	2022-08-09 15:20:47.933758	2022-08-09 15:20:47.933758
b6f531d0-7c30-49e9-b2b9-70c91f1c1aca	SE004A	3	Z	f	CV027	f	2022-08-09 15:20:47.939615	2022-08-09 15:20:47.939615
23aa05b6-b45e-4091-8d1a-b52db1e14595	SE004A	3	A	t	CV079	f	2022-08-09 15:20:47.945465	2022-08-09 15:20:47.945465
2138c25c-2d3d-45d9-9dec-cc7de3123594	SE004A	3	D	t	CV079	f	2022-08-09 15:20:47.950799	2022-08-09 15:20:47.950799
7cd34ea0-0a4b-4eba-a856-7d3ed39f967e	SE004A	3	I	t	CV079	f	2022-08-09 15:20:47.956354	2022-08-09 15:20:47.956354
0d4585ee-b691-479d-b278-b60f39335c74	SE004A	3	W	t	CV079	f	2022-08-09 15:20:47.962077	2022-08-09 15:20:47.962077
bd0ce6ee-4178-45f0-8862-7215c87f9e49	SE004A	3	Z	t	CV079	f	2022-08-09 15:20:47.968604	2022-08-09 15:20:47.968604
22801ffa-9c60-4f3f-9051-afe0dfbdc774	SE004A	3	A	f	CV118	f	2022-08-09 15:20:48.034779	2022-08-09 15:20:48.034779
af0caa1d-f22c-413e-b9d9-363c71a08207	SE004A	3	D	f	CV118	f	2022-08-09 15:20:48.040172	2022-08-09 15:20:48.040172
39576b24-2c21-454c-b73d-a455a933581a	SE004A	3	I	f	CV118	f	2022-08-09 15:20:48.045429	2022-08-09 15:20:48.045429
82becabb-590c-4647-b307-a73f25f7ddd3	SE004A	3	W	f	CV118	f	2022-08-09 15:20:48.051239	2022-08-09 15:20:48.051239
161d4c63-c4a2-4ba4-8172-95334b176c70	SE004A	3	Z	f	CV118	f	2022-08-09 15:20:48.056599	2022-08-09 15:20:48.056599
d4efe842-1fbb-423d-915e-259bf604fd6b	SE004A	3	A	f	CV079	t	2022-08-09 15:20:47.97485	2022-08-09 15:20:48.064138
057b22d1-5764-49b6-9594-52277dd70d28	SE004A	3	D	f	CV079	t	2022-08-09 15:20:47.980743	2022-08-09 15:20:48.07198
d29b39a8-775d-43e5-8665-ff805b40bf7e	SE004A	3	I	f	CV079	t	2022-08-09 15:20:47.987122	2022-08-09 15:20:48.079754
9b3138e1-d6ec-4641-bcc2-1fcca3dbc6e8	SE004A	3	W	f	CV079	t	2022-08-09 15:20:47.993871	2022-08-09 15:20:48.089686
020df4c2-e7e3-423f-ac16-9e70e8bc6258	SE004A	3	Z	f	CV079	t	2022-08-09 15:20:48.000834	2022-08-09 15:20:48.097299
533efce3-ec11-4496-bd52-7b19fe4d6118	SE004A	3	A	t	CV118	t	2022-08-09 15:20:48.007028	2022-08-09 15:20:48.105914
6c3ab812-0b7d-4d25-882e-0e8e5e64d9c8	SE004A	3	D	t	CV118	t	2022-08-09 15:20:48.012675	2022-08-09 15:20:48.11372
e6a5e735-bd65-42fa-8f1f-9d15eb017c04	SE004A	3	I	t	CV118	t	2022-08-09 15:20:48.01843	2022-08-09 15:20:48.121164
03ad1a0d-0a8b-4890-ad20-d371571b9a31	SE004A	3	W	t	CV118	t	2022-08-09 15:20:48.023775	2022-08-09 15:20:48.128504
7aa18b0f-5567-449e-9195-b87f9d927893	SE004A	3	Z	t	CV118	t	2022-08-09 15:20:48.029177	2022-08-09 15:20:48.136305
0c372d95-f84d-493e-8493-e6d52f5aa772	SE007A	3	A	t	APL09	f	2022-08-09 15:20:48.141795	2022-08-09 15:20:48.141795
55c79fe5-e1cd-42f9-96c9-4f9270bc8b7f	SE007A	3	D	t	APL09	f	2022-08-09 15:20:48.149177	2022-08-09 15:20:48.149177
32bdd389-a48c-432a-9ac9-d8546c1026bd	SE007A	3	I	t	APL09	f	2022-08-09 15:20:48.154734	2022-08-09 15:20:48.154734
3b8e2a28-2887-4501-aa6b-0983b5b43228	SE007A	3	W	t	APL09	f	2022-08-09 15:20:48.160562	2022-08-09 15:20:48.160562
011b7718-9751-4930-89cf-457b6f761c5d	SE007A	3	Z	t	APL09	f	2022-08-09 15:20:48.16637	2022-08-09 15:20:48.16637
6a06e175-d56f-404a-8490-d1745bb1307a	SE007A	3	A	f	APL09	f	2022-08-09 15:20:48.171887	2022-08-09 15:20:48.171887
9ff7bb59-0827-4556-ab44-623d58b76b73	SE007A	3	D	f	APL09	f	2022-08-09 15:20:48.177604	2022-08-09 15:20:48.177604
0bc0fbc3-fce1-43a4-9edc-43819acd7b87	SE007A	3	I	f	APL09	f	2022-08-09 15:20:48.182992	2022-08-09 15:20:48.182992
f6bf06a3-fe4f-47b9-8ff1-8b9d2a205a56	SE007A	3	W	f	APL09	f	2022-08-09 15:20:48.188814	2022-08-09 15:20:48.188814
b9223c18-e4d0-4199-95b3-2ebb2a7a9607	SE007A	3	Z	f	APL09	f	2022-08-09 15:20:48.194155	2022-08-09 15:20:48.194155
b63bbcfd-557c-4f01-95e3-1213730b793c	SE007A	3	A	t	APL07	f	2022-08-09 15:20:48.199855	2022-08-09 15:20:48.199855
87fe5ec6-2c12-4b5a-a354-92d98c5a394f	SE007A	3	D	t	APL07	f	2022-08-09 15:20:48.205009	2022-08-09 15:20:48.205009
e99018b4-7dd1-4a3c-8877-b4c10d396fa8	SE007A	3	I	t	APL07	f	2022-08-09 15:20:48.210653	2022-08-09 15:20:48.210653
5e530e99-c866-4b98-93f0-147b2220363a	SE007A	3	W	t	APL07	f	2022-08-09 15:20:48.21601	2022-08-09 15:20:48.21601
c42037ae-2533-4ae6-a33d-0509b85a98f2	SE007A	3	Z	t	APL07	f	2022-08-09 15:20:48.221462	2022-08-09 15:20:48.221462
62ca4f87-8b94-4a09-aa52-fa22d5aa276f	SE007A	3	A	f	APL07	f	2022-08-09 15:20:48.226726	2022-08-09 15:20:48.226726
8d5785bc-e05d-4ae5-87a0-c5c4be0519a7	SE007A	3	D	f	APL07	f	2022-08-09 15:20:48.232315	2022-08-09 15:20:48.232315
8d3da91e-5fd3-46cd-9f08-faa789d9cfb5	SE007A	3	I	f	APL07	f	2022-08-09 15:20:48.237828	2022-08-09 15:20:48.237828
a4e894e3-4e13-47ba-8b7f-709a0b8a0b31	SE007A	3	W	f	APL07	f	2022-08-09 15:20:48.243086	2022-08-09 15:20:48.243086
35c83622-18ce-4333-ac96-b6ce2a6b0230	SE007A	3	Z	f	APL07	f	2022-08-09 15:20:48.248654	2022-08-09 15:20:48.248654
500950cd-2b5a-4216-811b-68199721f212	SE007A	3	A	t	APL11	f	2022-08-09 15:20:48.253996	2022-08-09 15:20:48.253996
deb73825-e15e-4642-99a7-a1838e58df79	SE007A	3	D	t	APL11	f	2022-08-09 15:20:48.259313	2022-08-09 15:20:48.259313
73d147de-e2d2-4c03-9659-7f9d069e79a2	SE007A	3	I	t	APL11	f	2022-08-09 15:20:48.26489	2022-08-09 15:20:48.26489
60e05928-cf8c-43e5-b4e1-59bf90b34fe7	SE007A	3	W	t	APL11	f	2022-08-09 15:20:48.270203	2022-08-09 15:20:48.270203
d18c9f30-bb89-4448-94d0-30833d602c36	SE007A	3	Z	t	APL11	f	2022-08-09 15:20:48.275848	2022-08-09 15:20:48.275848
0254535c-ea87-4c7a-a9fd-799d4537a89e	SE007A	3	A	f	APL11	f	2022-08-09 15:20:48.28158	2022-08-09 15:20:48.28158
b9651cdd-e6c8-49b1-a8e2-0f44ed5e95d9	SE007A	3	D	f	APL11	f	2022-08-09 15:20:48.287312	2022-08-09 15:20:48.287312
58c7ae75-6ce7-47ee-b3a1-d8aef9c177b9	SE007A	3	I	f	APL11	f	2022-08-09 15:20:48.292592	2022-08-09 15:20:48.292592
8d2d4f00-259a-443c-b078-470eb72bcb6a	SE007A	3	W	f	APL11	f	2022-08-09 15:20:48.298067	2022-08-09 15:20:48.298067
c182238e-5b1a-40c7-9f63-70a0edc64b9e	SE007A	3	Z	f	APL11	f	2022-08-09 15:20:48.30361	2022-08-09 15:20:48.30361
b007cabc-8137-4b24-b51c-7e3c11d01134	SE007A	3	A	t	APL13	f	2022-08-09 15:20:48.309042	2022-08-09 15:20:48.309042
17d0e1f6-9386-46d8-9d23-23a05e2cb5dc	SE007A	3	D	t	APL13	f	2022-08-09 15:20:48.314403	2022-08-09 15:20:48.314403
1ef257e5-24d4-4a9a-b619-aba4494104b5	SE007A	3	I	t	APL13	f	2022-08-09 15:20:48.31991	2022-08-09 15:20:48.31991
1b8a171b-685a-4dad-9d4d-fd05cf59591b	SE007A	3	W	t	APL13	f	2022-08-09 15:20:48.325391	2022-08-09 15:20:48.325391
dceaa9d9-0b85-4738-80c5-ef10e936c318	SE007A	3	Z	t	APL13	f	2022-08-09 15:20:48.330959	2022-08-09 15:20:48.330959
9601e307-dee6-4abb-aa20-b206ed8bf77e	SE007A	3	A	f	APL13	f	2022-08-09 15:20:48.336647	2022-08-09 15:20:48.336647
93554ae5-c70e-414a-add4-312af9238cf8	SE007A	3	D	f	APL13	f	2022-08-09 15:20:48.342401	2022-08-09 15:20:48.342401
c12fb02c-3907-4b95-abca-917a609f50e0	SE007A	3	I	f	APL13	f	2022-08-09 15:20:48.3493	2022-08-09 15:20:48.3493
31fe2976-eb74-484f-8a0d-5061aa06ecd8	SE007A	3	W	f	APL13	f	2022-08-09 15:20:48.355759	2022-08-09 15:20:48.355759
8ae6820d-a1a2-40a1-b5e6-692041843ddd	SE007A	3	Z	f	APL13	f	2022-08-09 15:20:48.361552	2022-08-09 15:20:48.361552
55c1d80a-9998-42df-aebe-b27cbc4902c6	SE007A	3	A	t	APL15	f	2022-08-09 15:20:48.36785	2022-08-09 15:20:48.36785
06cb267b-d78a-4a3c-8631-8e43a57ea4c0	SE007A	3	D	t	APL15	f	2022-08-09 15:20:48.37428	2022-08-09 15:20:48.37428
1b282eea-ff95-4d45-a06c-d0a385c45af5	SE007A	3	I	t	APL15	f	2022-08-09 15:20:48.380452	2022-08-09 15:20:48.380452
39b0a47f-b586-4142-9582-349f7c35a3e2	SE007A	3	W	t	APL15	f	2022-08-09 15:20:48.386033	2022-08-09 15:20:48.386033
535e9044-15b5-451a-be60-61bd0a6e5d26	SE007A	3	Z	t	APL15	f	2022-08-09 15:20:48.391664	2022-08-09 15:20:48.391664
bc403b35-6992-40ef-b393-a3fe93913115	SE007A	3	A	f	APL15	f	2022-08-09 15:20:48.397333	2022-08-09 15:20:48.397333
d64b03d1-88e7-41c8-93f7-4dd1862ccd3b	SE007A	3	D	f	APL15	f	2022-08-09 15:20:48.402691	2022-08-09 15:20:48.402691
6b87b3fd-0b3e-4897-94a5-3cb4e08e388d	SE007A	3	I	f	APL15	f	2022-08-09 15:20:48.408093	2022-08-09 15:20:48.408093
b45797df-8fe1-4c69-a2a8-2cf5d4fdb40a	SE007A	3	W	f	APL15	f	2022-08-09 15:20:48.413758	2022-08-09 15:20:48.413758
79a40733-bd93-4ec9-9dc3-26cb92bc5c78	SE007A	3	Z	f	APL15	f	2022-08-09 15:20:48.419356	2022-08-09 15:20:48.419356
77b366d1-096f-4ccb-a6be-af8dcb87a053	SE007A	3	A	t	APL16	f	2022-08-09 15:20:48.424783	2022-08-09 15:20:48.424783
63e89c6b-c610-4d0d-a5d1-c6c0f0c77ed6	SE007A	3	D	t	APL16	f	2022-08-09 15:20:48.430554	2022-08-09 15:20:48.430554
dcbfe1c0-fb9f-46bf-ac5a-d972cded29bc	SE007A	3	I	t	APL16	f	2022-08-09 15:20:48.436062	2022-08-09 15:20:48.436062
2185cc82-703f-4a39-9bba-0e9babd6cab9	SE007A	3	W	t	APL16	f	2022-08-09 15:20:48.441463	2022-08-09 15:20:48.441463
ddfbc6a5-efe0-4b54-a4f6-99abfd75f5d7	SE007A	3	Z	t	APL16	f	2022-08-09 15:20:48.44696	2022-08-09 15:20:48.44696
f9ba9a47-95f3-4f7b-8411-651011a558c6	SE007A	3	A	f	APL16	f	2022-08-09 15:20:48.452352	2022-08-09 15:20:48.452352
063dcd0f-be4a-40c9-95d9-c9f78132d611	SE007A	3	D	f	APL16	f	2022-08-09 15:20:48.457707	2022-08-09 15:20:48.457707
37beeeb0-81a9-4f14-a8b3-7e82388ef564	SE007A	3	I	f	APL16	f	2022-08-09 15:20:48.463718	2022-08-09 15:20:48.463718
37e698e3-3671-4750-83dd-ff0bf748ae5f	SE007A	3	W	f	APL16	f	2022-08-09 15:20:48.470383	2022-08-09 15:20:48.470383
44250534-261e-439e-bef3-968a62f23f9a	SE007A	3	Z	f	APL16	f	2022-08-09 15:20:48.476428	2022-08-09 15:20:48.476428
729efebf-95db-4104-a0bb-6b27c5c0679e	SE007A	3	A	t	APL18	f	2022-08-09 15:20:48.4819	2022-08-09 15:20:48.4819
1e350a66-757b-43e4-b7c0-accd1d585be9	SE007A	3	D	t	APL18	f	2022-08-09 15:20:48.487738	2022-08-09 15:20:48.487738
16591a67-bad4-4e90-8e9b-54b3fd835937	SE007A	3	I	t	APL18	f	2022-08-09 15:20:48.493116	2022-08-09 15:20:48.493116
2d1395f6-294d-4b83-90df-237bbc59f22f	SE007A	3	W	t	APL18	f	2022-08-09 15:20:48.498734	2022-08-09 15:20:48.498734
fdc13226-1b9e-45ec-b0b8-f1406c462c45	SE007A	3	Z	t	APL18	f	2022-08-09 15:20:48.504479	2022-08-09 15:20:48.504479
519a0aa8-d567-40e5-afef-87a7aa72ef24	SE007A	3	A	f	APL18	f	2022-08-09 15:20:48.510002	2022-08-09 15:20:48.510002
b5df3998-3840-4daa-9834-05507c3def30	SE007A	3	D	f	APL18	f	2022-08-09 15:20:48.515729	2022-08-09 15:20:48.515729
326c334c-bc49-49ef-ab2a-eeb5d25d889b	SE007A	3	I	f	APL18	f	2022-08-09 15:20:48.521193	2022-08-09 15:20:48.521193
f1269c52-ee76-449a-8cf4-62fe0b578dff	SE007A	3	W	f	APL18	f	2022-08-09 15:20:48.526822	2022-08-09 15:20:48.526822
f6cfada3-4fbe-4190-852c-b9d6659fea9a	SE007A	3	Z	f	APL18	f	2022-08-09 15:20:48.532201	2022-08-09 15:20:48.532201
0b300496-7670-404e-93f1-0d9af0b9631b	SE007A	3	A	t	APL20	f	2022-08-09 15:20:48.537517	2022-08-09 15:20:48.537517
b92f63bc-1cc2-4d6f-8aa9-9ec439db9d3b	SE007A	3	D	t	APL20	f	2022-08-09 15:20:48.543865	2022-08-09 15:20:48.543865
d679419f-23b7-4da8-8080-c115c733d8bd	SE007A	3	I	t	APL20	f	2022-08-09 15:20:48.549152	2022-08-09 15:20:48.549152
0fb62356-ac9f-4bba-bc42-dfa8b9e333f8	SE007A	3	W	t	APL20	f	2022-08-09 15:20:48.554737	2022-08-09 15:20:48.554737
860b170a-00fd-46c1-9fae-9a3a6fc73425	SE007A	3	Z	t	APL20	f	2022-08-09 15:20:48.560231	2022-08-09 15:20:48.560231
4c7212b1-4760-4c16-a42d-d2d6000759b1	SE007A	3	A	f	APL20	f	2022-08-09 15:20:48.566107	2022-08-09 15:20:48.566107
a609fc2e-2c88-48db-8518-550c4de3a8ef	SE007A	3	D	f	APL20	f	2022-08-09 15:20:48.571709	2022-08-09 15:20:48.571709
856ccdc1-db43-42a7-9ecc-e635f6f7f02f	SE007A	3	I	f	APL20	f	2022-08-09 15:20:48.577422	2022-08-09 15:20:48.577422
dbbb5f23-dc2a-4c0b-9e1b-d5e4840c8e64	SE007A	3	W	f	APL20	f	2022-08-09 15:20:48.584576	2022-08-09 15:20:48.584576
8511560b-972e-4d85-ab27-0ecabc96dc35	SE007A	3	Z	f	APL20	f	2022-08-09 15:20:48.590322	2022-08-09 15:20:48.590322
8aa298a2-f66c-452d-bbcd-188c446352c7	SE007A	3	A	t	APL22	f	2022-08-09 15:20:48.596231	2022-08-09 15:20:48.596231
a1fffc51-e900-4faa-b493-57b156fdc24d	SE007A	3	D	t	APL22	f	2022-08-09 15:20:48.601938	2022-08-09 15:20:48.601938
6182094a-e88f-4ec0-996d-12736c1a93c0	SE007A	3	I	t	APL22	f	2022-08-09 15:20:48.607552	2022-08-09 15:20:48.607552
6a843521-d826-4d09-aacf-d50452525fa6	SE007A	3	W	t	APL22	f	2022-08-09 15:20:48.613435	2022-08-09 15:20:48.613435
f4b72405-5a9b-4a75-957a-5a6693969549	SE007A	3	Z	t	APL22	f	2022-08-09 15:20:48.618772	2022-08-09 15:20:48.618772
4fe02d95-df8e-4638-9a79-2577b6b8a0ab	SE007A	3	A	f	APL22	f	2022-08-09 15:20:48.624457	2022-08-09 15:20:48.624457
79502781-a6d1-4d34-aa8c-ebf4e91ffa6e	SE007A	3	D	f	APL22	f	2022-08-09 15:20:48.629964	2022-08-09 15:20:48.629964
7c43c472-424e-4103-a206-2f72e2fd0c02	SE007A	3	I	f	APL22	f	2022-08-09 15:20:48.635265	2022-08-09 15:20:48.635265
814d7c27-1abc-4d88-b20c-5eab105a7c12	SE007A	3	W	f	APL22	f	2022-08-09 15:20:48.640861	2022-08-09 15:20:48.640861
2c224b52-983a-49d1-bec5-ccf48d9ba257	SE007A	3	Z	f	APL22	f	2022-08-09 15:20:48.646433	2022-08-09 15:20:48.646433
bd2dac10-9293-4052-8f1e-f2080543f9f5	SE007A	3	A	t	APL27	f	2022-08-09 15:20:48.651782	2022-08-09 15:20:48.651782
e23238a2-6b87-4408-91bf-8e6392c88152	SE007A	3	D	t	APL27	f	2022-08-09 15:20:48.65726	2022-08-09 15:20:48.65726
bfaf48ba-74e9-40a1-806a-7f713a4c800f	SE007A	3	I	t	APL27	f	2022-08-09 15:20:48.662614	2022-08-09 15:20:48.662614
3b0ebbfc-be8a-477e-a290-c2c355caa9fc	SE007A	3	W	t	APL27	f	2022-08-09 15:20:48.668216	2022-08-09 15:20:48.668216
94c230e0-93e3-453f-82b1-2fa2dc4b77bc	SE007A	3	Z	t	APL27	f	2022-08-09 15:20:48.673507	2022-08-09 15:20:48.673507
f4e01cfb-2c90-4774-b9dc-60c2f9981220	SE007A	3	A	f	APL27	f	2022-08-09 15:20:48.679617	2022-08-09 15:20:48.679617
e1a5d10b-23ca-4adc-b17d-95adc1edc324	SE007A	3	D	f	APL27	f	2022-08-09 15:20:48.685585	2022-08-09 15:20:48.685585
58f76720-8b0a-4bc2-80e6-ac04012dd405	SE007A	3	I	f	APL27	f	2022-08-09 15:20:48.690924	2022-08-09 15:20:48.690924
8aa41724-2b0b-4339-a75b-b68cb3c597e3	SE007A	3	W	f	APL27	f	2022-08-09 15:20:48.696603	2022-08-09 15:20:48.696603
cd4eb88d-fd47-4a2d-a0fb-7e1532b7e8df	SE007A	3	Z	f	APL27	f	2022-08-09 15:20:48.701976	2022-08-09 15:20:48.701976
d9a54f34-ee34-4fcd-9e4a-6a6b0d3d8e54	SE007A	3	A	t	APL29	f	2022-08-09 15:20:48.707545	2022-08-09 15:20:48.707545
bd11b969-6754-49e0-b5a2-13f621ea0a61	SE007A	3	D	t	APL29	f	2022-08-09 15:20:48.713511	2022-08-09 15:20:48.713511
926fb832-8d1b-4ce9-888f-ff1375a7d3e7	SE007A	3	I	t	APL29	f	2022-08-09 15:20:48.719255	2022-08-09 15:20:48.719255
88b8cb06-fd0a-478f-be4f-901f58b683c5	SE007A	3	W	t	APL29	f	2022-08-09 15:20:48.724882	2022-08-09 15:20:48.724882
6b5cc0c6-e163-4278-8f39-f5149e184723	SE007A	3	Z	t	APL29	f	2022-08-09 15:20:48.730684	2022-08-09 15:20:48.730684
ed436486-bfa8-4edf-9166-8cfb95225a74	SE007A	3	A	f	APL29	f	2022-08-09 15:20:48.736268	2022-08-09 15:20:48.736268
0da1ea7e-3ecb-4ab6-ae0a-55c88b0109b3	SE007A	3	D	f	APL29	f	2022-08-09 15:20:48.741855	2022-08-09 15:20:48.741855
cdee04bb-154f-40b9-90a6-1faa886693d3	SE007A	3	I	f	APL29	f	2022-08-09 15:20:48.747491	2022-08-09 15:20:48.747491
3335d760-75ec-49f1-8b95-63fddea355a5	SE007A	3	W	f	APL29	f	2022-08-09 15:20:48.752937	2022-08-09 15:20:48.752937
2aa9e1ae-cfe3-4314-9a8b-7c926efe9e81	SE007A	3	Z	f	APL29	f	2022-08-09 15:20:48.758573	2022-08-09 15:20:48.758573
310f2958-53e3-4716-ac4b-b7dfa297bec6	SE007A	3	A	t	APL31	f	2022-08-09 15:20:48.76391	2022-08-09 15:20:48.76391
c415b8e9-ed8a-4f76-a69a-b1300798326f	SE007A	3	D	t	APL31	f	2022-08-09 15:20:48.76948	2022-08-09 15:20:48.76948
74c3ad57-c78c-449e-b6be-dd332bcad4d3	SE007A	3	I	t	APL31	f	2022-08-09 15:20:48.7747	2022-08-09 15:20:48.7747
96c14e0c-7ba3-45d5-8277-a6db2673f5e3	SE007A	3	W	t	APL31	f	2022-08-09 15:20:48.780804	2022-08-09 15:20:48.780804
d8bd3f14-112b-4a5e-a2e8-477b8d632765	SE007A	3	Z	t	APL31	f	2022-08-09 15:20:48.786712	2022-08-09 15:20:48.786712
fbbb7555-29eb-406b-846d-96c95d543bdd	SE007A	3	A	f	APL31	f	2022-08-09 15:20:48.79211	2022-08-09 15:20:48.79211
f392cb4d-8c03-4cce-aa09-ddc8374dd3f9	SE007A	3	D	f	APL31	f	2022-08-09 15:20:48.799125	2022-08-09 15:20:48.799125
93bdb8eb-79c9-4b07-8a42-1e8d3865f223	SE007A	3	I	f	APL31	f	2022-08-09 15:20:48.805083	2022-08-09 15:20:48.805083
a367a392-1c1b-46cb-ae06-040e2b5196a6	SE007A	3	W	f	APL31	f	2022-08-09 15:20:48.810753	2022-08-09 15:20:48.810753
1a0fb2ea-08f7-4721-99b3-6444e166a311	SE007A	3	Z	f	APL31	f	2022-08-09 15:20:48.816401	2022-08-09 15:20:48.816401
deb001a7-6e58-449f-ab32-4afb6cee4416	SE007A	3	A	t	APL48	f	2022-08-09 15:20:48.821851	2022-08-09 15:20:48.821851
e75e691d-78f5-4f6e-94eb-0f3a70751d36	SE007A	3	D	t	APL48	f	2022-08-09 15:20:48.8276	2022-08-09 15:20:48.8276
e32cc7ff-e6ea-4dd1-baee-e3143419ea86	SE007A	3	I	t	APL48	f	2022-08-09 15:20:48.833012	2022-08-09 15:20:48.833012
06a462a8-4fdc-4636-a4df-ad47982ee8ef	SE007A	3	W	t	APL48	f	2022-08-09 15:20:48.838799	2022-08-09 15:20:48.838799
7ba0557b-411c-421a-ad6f-13bb8c782744	SE007A	3	Z	t	APL48	f	2022-08-09 15:20:48.844097	2022-08-09 15:20:48.844097
bc9fc63f-855e-4ce7-a74a-4bd8f409e8a2	SE007A	3	A	f	APL48	f	2022-08-09 15:20:48.849845	2022-08-09 15:20:48.849845
e012b026-0d36-4ec7-958c-d5cc42495c82	SE007A	3	D	f	APL48	f	2022-08-09 15:20:48.855256	2022-08-09 15:20:48.855256
ebc38f73-d2d3-45dd-ae36-7454723d256c	SE007A	3	I	f	APL48	f	2022-08-09 15:20:48.861118	2022-08-09 15:20:48.861118
0dac625a-22f5-4d8d-abc6-467a5d21163b	SE007A	3	W	f	APL48	f	2022-08-09 15:20:48.866408	2022-08-09 15:20:48.866408
60605e3f-08cf-4f94-8e8a-9fab4a3c21ac	SE007A	3	Z	f	APL48	f	2022-08-09 15:20:48.872191	2022-08-09 15:20:48.872191
60d83372-50c7-4354-b916-7e37564c620a	SE007A	3	A	t	APL49	f	2022-08-09 15:20:48.878611	2022-08-09 15:20:48.878611
6a804499-e847-487e-9d04-6dcb1523d1b1	SE007A	3	D	t	APL49	f	2022-08-09 15:20:48.885374	2022-08-09 15:20:48.885374
f138fd9b-438b-4c90-810a-ffc3d5207a24	SE007A	3	I	t	APL49	f	2022-08-09 15:20:48.891675	2022-08-09 15:20:48.891675
762ed52b-e877-49e2-972d-84efac8db8d8	SE007A	3	W	t	APL49	f	2022-08-09 15:20:48.897588	2022-08-09 15:20:48.897588
0c2ea7a2-05f5-471f-9618-6c5109c6021a	SE007A	3	Z	t	APL49	f	2022-08-09 15:20:48.903276	2022-08-09 15:20:48.903276
d29e82ca-a7f6-4a3f-80a2-462a2b3a93db	SE007A	3	A	f	APL49	f	2022-08-09 15:20:48.908532	2022-08-09 15:20:48.908532
4dfc8849-698c-4e04-9d31-46146bff82f3	SE007A	3	D	f	APL49	f	2022-08-09 15:20:48.914195	2022-08-09 15:20:48.914195
267e3365-87af-43eb-839d-96eb16ad9b0d	SE007A	3	I	f	APL49	f	2022-08-09 15:20:48.919507	2022-08-09 15:20:48.919507
d91dcd59-f75f-4e95-b53b-1a671e0edfee	SE007A	3	W	f	APL49	f	2022-08-09 15:20:48.924894	2022-08-09 15:20:48.924894
8c7070da-4454-4e21-bf27-0f0048fbac35	SE007A	3	Z	f	APL49	f	2022-08-09 15:20:48.930402	2022-08-09 15:20:48.930402
60e8c04e-b9d0-4df9-a8fa-7daaf5915b9a	SE007A	3	A	t	APL50	f	2022-08-09 15:20:48.935811	2022-08-09 15:20:48.935811
8eb311b6-b7f5-451d-8064-6702da6d30d2	SE007A	3	D	t	APL50	f	2022-08-09 15:20:48.941234	2022-08-09 15:20:48.941234
0c94253e-3ca5-4771-92e5-0b501e0033fe	SE007A	3	I	t	APL50	f	2022-08-09 15:20:48.947366	2022-08-09 15:20:48.947366
764aa810-6949-4444-ac8a-c3da063ed41c	SE007A	3	W	t	APL50	f	2022-08-09 15:20:48.952937	2022-08-09 15:20:48.952937
7a69f29f-8ec5-4d34-94da-0031dccf8034	SE007A	3	Z	t	APL50	f	2022-08-09 15:20:48.958772	2022-08-09 15:20:48.958772
7fa3a2f3-b562-4d16-8138-5e6664b6c088	SE007A	3	A	f	APL50	f	2022-08-09 15:20:48.96405	2022-08-09 15:20:48.96405
4ec06708-0e60-4cbc-8649-24772887b9d4	SE007A	3	D	f	APL50	f	2022-08-09 15:20:48.969476	2022-08-09 15:20:48.969476
74152495-87d6-47aa-99f1-47a3dcb1f653	SE007A	3	I	f	APL50	f	2022-08-09 15:20:48.975228	2022-08-09 15:20:48.975228
72018539-5b89-4952-8aaa-71e443b0508f	SE007A	3	W	f	APL50	f	2022-08-09 15:20:48.980618	2022-08-09 15:20:48.980618
9e1421a7-0ccf-4fec-901c-8b36f6bb8b1b	SE007A	3	Z	f	APL50	f	2022-08-09 15:20:48.987153	2022-08-09 15:20:48.987153
39a866e9-41d5-4953-b3e5-874bb96d38e3	SE007A	3	A	t	APL51	f	2022-08-09 15:20:48.992838	2022-08-09 15:20:48.992838
c07d69ba-eccb-402b-873c-d651aea48e54	SE007A	3	D	t	APL51	f	2022-08-09 15:20:48.998446	2022-08-09 15:20:48.998446
c100c7e0-82c8-42d5-980c-0f1b67a597d7	SE007A	3	I	t	APL51	f	2022-08-09 15:20:49.004104	2022-08-09 15:20:49.004104
6ec7ec4b-ca97-4edd-8891-2a981b1428c0	SE007A	3	W	t	APL51	f	2022-08-09 15:20:49.009555	2022-08-09 15:20:49.009555
5c521314-e370-4740-a09b-dd729434a201	SE007A	3	Z	t	APL51	f	2022-08-09 15:20:49.015142	2022-08-09 15:20:49.015142
8e9b7e04-39f2-403b-96a0-6cd4df1901c0	SE007A	3	A	f	APL51	f	2022-08-09 15:20:49.020486	2022-08-09 15:20:49.020486
7cfd1217-9260-4bbe-b03b-1866d44306d0	SE007A	3	D	f	APL51	f	2022-08-09 15:20:49.025898	2022-08-09 15:20:49.025898
d5bca1ea-d663-4749-ae7f-df814967d07f	SE007A	3	I	f	APL51	f	2022-08-09 15:20:49.031718	2022-08-09 15:20:49.031718
ca45b84f-7e0a-457a-8651-da9c9f606e6d	SE007A	3	W	f	APL51	f	2022-08-09 15:20:49.037161	2022-08-09 15:20:49.037161
ec6df113-da0f-4c1c-b980-53065018a27b	SE007A	3	Z	f	APL51	f	2022-08-09 15:20:49.042381	2022-08-09 15:20:49.042381
50e39c63-fed3-435a-8bf5-06b2640e680f	SE007A	3	A	t	APL52	f	2022-08-09 15:20:49.047914	2022-08-09 15:20:49.047914
5862104b-eb59-4848-b6a6-ee9f16a3a7be	SE007A	3	D	t	APL52	f	2022-08-09 15:20:49.053144	2022-08-09 15:20:49.053144
f0b8db62-76e0-4186-bc0a-298f0c52ef55	SE007A	3	I	t	APL52	f	2022-08-09 15:20:49.05854	2022-08-09 15:20:49.05854
23ed70b7-576c-4435-a703-54465e6770b0	SE007A	3	W	t	APL52	f	2022-08-09 15:20:49.064132	2022-08-09 15:20:49.064132
e557f5ce-279d-4d94-bb6f-9764ef04daf3	SE007A	3	Z	t	APL52	f	2022-08-09 15:20:49.069562	2022-08-09 15:20:49.069562
680273b2-6016-453b-aae5-999bcc1f8b0d	SE007A	3	A	f	APL52	f	2022-08-09 15:20:49.075108	2022-08-09 15:20:49.075108
6d865bdd-5c61-4cd2-8d6b-7b64fd1ca745	SE007A	3	D	f	APL52	f	2022-08-09 15:20:49.080498	2022-08-09 15:20:49.080498
0e1f6633-0b91-4799-8d7a-1aae56d180a3	SE007A	3	I	f	APL52	f	2022-08-09 15:20:49.086312	2022-08-09 15:20:49.086312
f1f8b0bf-7bfc-4599-8e29-26513d0f3838	SE007A	3	W	f	APL52	f	2022-08-09 15:20:49.091704	2022-08-09 15:20:49.091704
37baa3c1-4c84-4178-9ecd-c51b59360755	SE007A	3	Z	f	APL52	f	2022-08-09 15:20:49.097459	2022-08-09 15:20:49.097459
e746e086-005f-45b8-847c-7d3773124991	SE007A	3	A	t	APL53	f	2022-08-09 15:20:49.102939	2022-08-09 15:20:49.102939
c1bf7b84-c4b7-4b98-ba66-c9598b2bc772	SE007A	3	D	t	APL53	f	2022-08-09 15:20:49.108361	2022-08-09 15:20:49.108361
a946668b-c3fd-44c6-87f9-5d69f69a3a7e	SE007A	3	I	t	APL53	f	2022-08-09 15:20:49.113961	2022-08-09 15:20:49.113961
b59d77ee-3420-4fc9-aa25-8f991819f52e	SE007A	3	W	t	APL53	f	2022-08-09 15:20:49.120598	2022-08-09 15:20:49.120598
c7f2b833-ae8e-4a7f-84ad-b284a332a612	SE007A	3	Z	t	APL53	f	2022-08-09 15:20:49.128073	2022-08-09 15:20:49.128073
bd93cf31-3577-4484-91d3-8f16236162b8	SE007A	3	A	f	APL53	f	2022-08-09 15:20:49.134448	2022-08-09 15:20:49.134448
7157354f-3068-4b5d-a2da-07deb79618bc	SE007A	3	D	f	APL53	f	2022-08-09 15:20:49.140704	2022-08-09 15:20:49.140704
d694960d-0615-42a2-8b41-e52a7eff7d53	SE007A	3	I	f	APL53	f	2022-08-09 15:20:49.146475	2022-08-09 15:20:49.146475
9921c795-32fc-467d-9a87-bb1374f69a80	SE007A	3	W	f	APL53	f	2022-08-09 15:20:49.152098	2022-08-09 15:20:49.152098
f02f0a3e-1125-4230-92f9-e9bbb5a23409	SE007A	3	Z	f	APL53	f	2022-08-09 15:20:49.157983	2022-08-09 15:20:49.157983
23f05d8c-c3ce-4900-bf06-44f89ba37810	SE007A	3	A	t	APL54	f	2022-08-09 15:20:49.163425	2022-08-09 15:20:49.163425
8a477da4-aff9-4704-971c-00a9a427399b	SE007A	3	D	t	APL54	f	2022-08-09 15:20:49.168971	2022-08-09 15:20:49.168971
8bd8fd11-bcdf-4042-afbc-bcd27507e261	SE007A	3	I	t	APL54	f	2022-08-09 15:20:49.174264	2022-08-09 15:20:49.174264
2ba92f56-afa2-471c-b4d4-2e6c34f057f4	SE007A	3	W	t	APL54	f	2022-08-09 15:20:49.179889	2022-08-09 15:20:49.179889
38e4b210-fe6b-4bcf-b7c4-c139e48a721c	SE007A	3	Z	t	APL54	f	2022-08-09 15:20:49.185319	2022-08-09 15:20:49.185319
24084513-6391-4626-9873-be021f8a1929	SE007A	3	A	f	APL54	f	2022-08-09 15:20:49.191629	2022-08-09 15:20:49.191629
014e63d9-8bb7-4864-b0d2-b153271a0d8e	SE007A	3	D	f	APL54	f	2022-08-09 15:20:49.19719	2022-08-09 15:20:49.19719
996e87c4-6340-4a64-b558-35ca2759b4ce	SE007A	3	I	f	APL54	f	2022-08-09 15:20:49.202456	2022-08-09 15:20:49.202456
f9d71761-43b3-4c22-9a5b-e69939509505	SE007A	3	W	f	APL54	f	2022-08-09 15:20:49.207916	2022-08-09 15:20:49.207916
29b5e09f-1d38-4a9c-b1cf-2fdf07ced4fe	SE007A	3	Z	f	APL54	f	2022-08-09 15:20:49.213413	2022-08-09 15:20:49.213413
9ebe9707-b3f6-48d1-b525-5648cfce889a	SE007A	3	A	t	APL55	f	2022-08-09 15:20:49.219124	2022-08-09 15:20:49.219124
aa65072f-7486-43bd-8d7e-5a581384fd1b	SE007A	3	D	t	APL55	f	2022-08-09 15:20:49.224507	2022-08-09 15:20:49.224507
0f8279a0-c059-41d6-8ac7-648735206148	SE007A	3	I	t	APL55	f	2022-08-09 15:20:49.230328	2022-08-09 15:20:49.230328
6a8f0bd3-813f-4fbb-b5c0-d5b526a06fe8	SE007A	3	W	t	APL55	f	2022-08-09 15:20:49.235688	2022-08-09 15:20:49.235688
3b7d3d04-b8ce-4506-b0c6-ffdea7a4c302	SE007A	3	Z	t	APL55	f	2022-08-09 15:20:49.240902	2022-08-09 15:20:49.240902
9ce269b3-40c7-4d97-8ab0-2e6ba35b0d66	SE007A	3	A	f	APL55	f	2022-08-09 15:20:49.246792	2022-08-09 15:20:49.246792
915e9487-15c6-4030-93b7-035c8067d64c	SE007A	3	D	f	APL55	f	2022-08-09 15:20:49.252119	2022-08-09 15:20:49.252119
a00b87f2-454b-4929-940f-5b2db63b39b9	SE007A	3	I	f	APL55	f	2022-08-09 15:20:49.257279	2022-08-09 15:20:49.257279
2745bb49-dc95-4bc3-b9cc-ac05ac08c020	SE007A	3	W	f	APL55	f	2022-08-09 15:20:49.262874	2022-08-09 15:20:49.262874
4555935d-2a8c-436c-afcd-283ede4d8a85	SE007A	3	Z	f	APL55	f	2022-08-09 15:20:49.268303	2022-08-09 15:20:49.268303
74796c2b-55db-478b-aee7-479807b96476	SE007A	3	A	t	APL56	f	2022-08-09 15:20:49.273909	2022-08-09 15:20:49.273909
61064617-63c1-4dd8-ad3b-7c3a8ba99261	SE007A	3	D	t	APL56	f	2022-08-09 15:20:49.279528	2022-08-09 15:20:49.279528
15a29e45-ce75-4379-b778-a67d86ab6824	SE007A	3	I	t	APL56	f	2022-08-09 15:20:49.284904	2022-08-09 15:20:49.284904
c7420706-4dcd-4538-8185-f68587c574c1	SE007A	3	W	t	APL56	f	2022-08-09 15:20:49.290534	2022-08-09 15:20:49.290534
7e1cf5c8-aab4-45a7-a45a-5ee61c99ea2f	SE007A	3	Z	t	APL56	f	2022-08-09 15:20:49.29579	2022-08-09 15:20:49.29579
841554af-0e19-4b59-902f-8ba51d8450f5	SE007A	3	A	f	APL56	f	2022-08-09 15:20:49.301381	2022-08-09 15:20:49.301381
257c141b-c602-45ad-a3d6-a7366d96991a	SE007A	3	D	f	APL56	f	2022-08-09 15:20:49.306628	2022-08-09 15:20:49.306628
56f295d0-4bb3-4f09-b5f6-4fdaedcc9358	SE007A	3	I	f	APL56	f	2022-08-09 15:20:49.311948	2022-08-09 15:20:49.311948
509d64a1-750e-439c-aee5-87f26c5adf9e	SE007A	3	W	f	APL56	f	2022-08-09 15:20:49.317591	2022-08-09 15:20:49.317591
72d87474-196f-4493-9522-08f3c15d5661	SE007A	3	Z	f	APL56	f	2022-08-09 15:20:49.322917	2022-08-09 15:20:49.322917
24229a50-078e-46d7-9fcc-410a9f768f95	SE007A	3	A	t	APL57	f	2022-08-09 15:20:49.328747	2022-08-09 15:20:49.328747
b12e9aeb-ab9c-4d79-8c11-c3304af5fb83	SE007A	3	D	t	APL57	f	2022-08-09 15:20:49.334143	2022-08-09 15:20:49.334143
375425db-9c4f-4c1e-9cf7-3dd47e575bd3	SE007A	3	I	t	APL57	f	2022-08-09 15:20:49.339293	2022-08-09 15:20:49.339293
a219b948-b224-4480-b7ac-6dfa0b0d73b6	SE007A	3	W	t	APL57	f	2022-08-09 15:20:49.344973	2022-08-09 15:20:49.344973
7fea477c-3ae6-4d8c-bdfe-1d1cde8153b0	SE007A	3	Z	t	APL57	f	2022-08-09 15:20:49.351747	2022-08-09 15:20:49.351747
5db1435d-1869-4586-9a68-41d411447bfd	SE007A	3	A	f	APL57	f	2022-08-09 15:20:49.358121	2022-08-09 15:20:49.358121
71163794-1443-44df-99ac-e93fb7e4ece5	SE007A	3	D	f	APL57	f	2022-08-09 15:20:49.364745	2022-08-09 15:20:49.364745
62d82dd9-e42f-43e8-990b-c1269076eb87	SE007A	3	I	f	APL57	f	2022-08-09 15:20:49.370823	2022-08-09 15:20:49.370823
7d030ba6-14fd-4640-83df-ff8b0378d0f5	SE007A	3	W	f	APL57	f	2022-08-09 15:20:49.376808	2022-08-09 15:20:49.376808
1495fc71-be1a-455d-83db-f4c717b41c19	SE007A	3	Z	f	APL57	f	2022-08-09 15:20:49.383302	2022-08-09 15:20:49.383302
c2613327-98ac-4e5b-b1c2-43b6cbc06374	SE007A	3	A	t	APL65	f	2022-08-09 15:20:49.389622	2022-08-09 15:20:49.389622
125e7b9d-3622-45a0-80ea-807bed6868c8	SE007A	3	D	t	APL65	f	2022-08-09 15:20:49.395641	2022-08-09 15:20:49.395641
12f49763-7a56-4407-9eec-08a3cb829183	SE007A	3	I	t	APL65	f	2022-08-09 15:20:49.401578	2022-08-09 15:20:49.401578
ab2359fe-2f84-4182-bbd8-6eff2a547389	SE007A	3	W	t	APL65	f	2022-08-09 15:20:49.407047	2022-08-09 15:20:49.407047
c7f099df-882d-4965-9394-90a928c8e49c	SE007A	3	Z	t	APL65	f	2022-08-09 15:20:49.412784	2022-08-09 15:20:49.412784
5331c05c-33eb-4b63-a6f8-5578de853e1d	SE007A	3	A	f	APL65	f	2022-08-09 15:20:49.418018	2022-08-09 15:20:49.418018
6d174c4c-a815-42b0-bbe1-582fea54b86c	SE007A	3	D	f	APL65	f	2022-08-09 15:20:49.423726	2022-08-09 15:20:49.423726
b46380da-dd04-4853-9043-6aaa0cb8b4da	SE007A	3	I	f	APL65	f	2022-08-09 15:20:49.429093	2022-08-09 15:20:49.429093
c33fc827-d9a7-4b30-8b02-7d51c9a605d1	SE007A	3	W	f	APL65	f	2022-08-09 15:20:49.434726	2022-08-09 15:20:49.434726
629f87bf-ac00-473b-be2e-3dae2354e410	SE007A	3	Z	f	APL65	f	2022-08-09 15:20:49.440097	2022-08-09 15:20:49.440097
3f67034d-b44c-440b-b246-2e949c72495e	SE007A	3	A	t	APL66	f	2022-08-09 15:20:49.445486	2022-08-09 15:20:49.445486
b8038bed-346f-4f39-b4b6-4b6ea7c7766a	SE007A	3	D	t	APL66	f	2022-08-09 15:20:49.452493	2022-08-09 15:20:49.452493
0ac98cfa-87ab-4aa5-99b5-b6a60fba11f6	SE007A	3	I	t	APL66	f	2022-08-09 15:20:49.458413	2022-08-09 15:20:49.458413
1a0d1805-255e-43cf-9504-226480bfcf9d	SE007A	3	W	t	APL66	f	2022-08-09 15:20:49.463911	2022-08-09 15:20:49.463911
c3d4fd42-e179-4f0e-81e1-631517124dc1	SE007A	3	Z	t	APL66	f	2022-08-09 15:20:49.469559	2022-08-09 15:20:49.469559
a52d8376-abc3-41b7-83fe-128df8d6db31	SE007A	3	A	f	APL66	f	2022-08-09 15:20:49.475308	2022-08-09 15:20:49.475308
88d93548-5edc-46a2-b51e-3880a3ab3034	SE007A	3	D	f	APL66	f	2022-08-09 15:20:49.48158	2022-08-09 15:20:49.48158
631bc77f-ad05-42a3-867f-6e403c38cb20	SE007A	3	I	f	APL66	f	2022-08-09 15:20:49.487098	2022-08-09 15:20:49.487098
9d6e8b6e-76bc-4282-a46c-60c6a568e65a	SE007A	3	W	f	APL66	f	2022-08-09 15:20:49.492725	2022-08-09 15:20:49.492725
442d2b72-17e5-4bb8-a213-f382f76904c4	SE007A	3	Z	f	APL66	f	2022-08-09 15:20:49.498232	2022-08-09 15:20:49.498232
1cdfc8cc-4c64-4cfc-ab6c-fcf88af20fae	SE007A	3	A	t	APL67	f	2022-08-09 15:20:49.504145	2022-08-09 15:20:49.504145
dfc198ce-2b67-487f-a68b-2e668d4fdc0c	SE007A	3	D	t	APL67	f	2022-08-09 15:20:49.509769	2022-08-09 15:20:49.509769
e8549124-7982-4900-8772-2003f6cd478a	SE007A	3	I	t	APL67	f	2022-08-09 15:20:49.515808	2022-08-09 15:20:49.515808
4bf87dc0-6fbf-49e3-809f-3b3684546391	SE007A	3	W	t	APL67	f	2022-08-09 15:20:49.521745	2022-08-09 15:20:49.521745
87532afd-9db5-450b-a6bf-dd97ede6a98c	SE007A	3	Z	t	APL67	f	2022-08-09 15:20:49.527867	2022-08-09 15:20:49.527867
e42c5c0e-c903-4975-8e57-1052c720ca47	SE007A	3	A	f	APL67	f	2022-08-09 15:20:49.533308	2022-08-09 15:20:49.533308
43e5a570-c5ea-4751-89a4-1a78bffd410c	SE007A	3	D	f	APL67	f	2022-08-09 15:20:49.538918	2022-08-09 15:20:49.538918
473626f3-2118-4efd-b567-d626d20a12a1	SE007A	3	I	f	APL67	f	2022-08-09 15:20:49.544229	2022-08-09 15:20:49.544229
47f65778-eda6-4777-b58f-2a10f7dfdd09	SE007A	3	W	f	APL67	f	2022-08-09 15:20:49.549898	2022-08-09 15:20:49.549898
6e729e72-02de-4102-b8b3-d1477c58d655	SE007A	3	Z	f	APL67	f	2022-08-09 15:20:49.55563	2022-08-09 15:20:49.55563
145f8a29-7f54-42d5-8915-c14698016f03	SE007A	3	A	t	APL68	f	2022-08-09 15:20:49.56123	2022-08-09 15:20:49.56123
54136def-a917-49a3-8f88-e88fbddf2242	SE007A	3	D	t	APL68	f	2022-08-09 15:20:49.56688	2022-08-09 15:20:49.56688
f9bc7b4a-a629-4f04-8382-6c1bbfdabd75	SE007A	3	I	t	APL68	f	2022-08-09 15:20:49.572396	2022-08-09 15:20:49.572396
a913adf9-8313-4f12-9264-fcd1cc213eeb	SE007A	3	W	t	APL68	f	2022-08-09 15:20:49.577656	2022-08-09 15:20:49.577656
54c8fe79-c170-423b-aaa7-459ea911a3c9	SE007A	3	Z	t	APL68	f	2022-08-09 15:20:49.584892	2022-08-09 15:20:49.584892
29764f63-af60-4d7d-9512-916f514bf2e4	SE007A	3	A	f	APL68	f	2022-08-09 15:20:49.590677	2022-08-09 15:20:49.590677
a0914c1b-3c89-4fdb-abd7-91f308a49185	SE007A	3	D	f	APL68	f	2022-08-09 15:20:49.596546	2022-08-09 15:20:49.596546
a5b8d7e3-5568-44db-b37c-eea4efb4240c	SE007A	3	I	f	APL68	f	2022-08-09 15:20:49.60211	2022-08-09 15:20:49.60211
aecb89c7-5c18-49db-a2d3-90816aeabb51	SE007A	3	W	f	APL68	f	2022-08-09 15:20:49.607756	2022-08-09 15:20:49.607756
b8a74ccb-b1a5-4c35-b90b-f9618e85a2de	SE007A	3	Z	f	APL68	f	2022-08-09 15:20:49.613408	2022-08-09 15:20:49.613408
eb65d7f1-582a-4cf3-bb1c-cb8785c610e4	SE007A	3	A	t	APL69	f	2022-08-09 15:20:49.618775	2022-08-09 15:20:49.618775
ff805df1-f2d0-463e-8402-7e25b1bacd61	SE007A	3	D	t	APL69	f	2022-08-09 15:20:49.624873	2022-08-09 15:20:49.624873
a6992359-a04a-4fdb-8921-9ea16a5ce565	SE007A	3	I	t	APL69	f	2022-08-09 15:20:49.633222	2022-08-09 15:20:49.633222
65cbe5d3-0a7c-4db3-b5ec-71e64e52c8aa	SE007A	3	W	t	APL69	f	2022-08-09 15:20:49.639407	2022-08-09 15:20:49.639407
9fdbf284-248d-4369-afc6-9eab98bcd5f1	SE007A	3	Z	t	APL69	f	2022-08-09 15:20:49.645409	2022-08-09 15:20:49.645409
9027b92a-518a-41fb-befe-85d4ff0a5dc1	SE007A	3	A	f	APL69	f	2022-08-09 15:20:49.650816	2022-08-09 15:20:49.650816
0c63acc6-3417-4015-9146-05b2887e0805	SE007A	3	D	f	APL69	f	2022-08-09 15:20:49.656227	2022-08-09 15:20:49.656227
006e071c-4243-416c-8713-336c623ffa47	SE007A	3	I	f	APL69	f	2022-08-09 15:20:49.661984	2022-08-09 15:20:49.661984
50474400-1e70-403d-9672-c7987b467671	SE007A	3	W	f	APL69	f	2022-08-09 15:20:49.667265	2022-08-09 15:20:49.667265
e08f036b-ef03-474b-85f5-73df9a971e88	SE007A	3	Z	f	APL69	f	2022-08-09 15:20:49.672758	2022-08-09 15:20:49.672758
49217b0d-fe9b-4322-8fdb-886916399140	SE007A	3	A	t	APL70	f	2022-08-09 15:20:49.678195	2022-08-09 15:20:49.678195
dfa04a6f-6168-45ae-9200-c57f18ba161a	SE007A	3	D	t	APL70	f	2022-08-09 15:20:49.683774	2022-08-09 15:20:49.683774
63a4f0aa-5758-41ac-91ce-23563e629a54	SE007A	3	I	t	APL70	f	2022-08-09 15:20:49.689711	2022-08-09 15:20:49.689711
c714e8b4-1d51-4799-a903-4ae97b3d3743	SE007A	3	W	t	APL70	f	2022-08-09 15:20:49.695139	2022-08-09 15:20:49.695139
168b79f9-be2d-44a6-b219-3b5f7014652a	SE007A	3	Z	t	APL70	f	2022-08-09 15:20:49.700473	2022-08-09 15:20:49.700473
e510f692-5886-4f05-bd45-997549fafcf0	SE007A	3	A	f	APL70	f	2022-08-09 15:20:49.706089	2022-08-09 15:20:49.706089
7c98be0b-16cd-426f-87a9-d75d5a4dd0a6	SE007A	3	D	f	APL70	f	2022-08-09 15:20:49.711325	2022-08-09 15:20:49.711325
21d81a7d-fcaf-4c3b-9f31-24bae7e9ca04	SE007A	3	I	f	APL70	f	2022-08-09 15:20:49.716655	2022-08-09 15:20:49.716655
99ef03d2-60b4-4139-8107-503d1dbb5aa7	SE007A	3	W	f	APL70	f	2022-08-09 15:20:49.722225	2022-08-09 15:20:49.722225
d7c0bb8e-b1e2-4eb7-b27f-f18e7be0b985	SE007A	3	Z	f	APL70	f	2022-08-09 15:20:49.728027	2022-08-09 15:20:49.728027
d214acc9-9e9e-4151-97b2-26c6d7f13a36	SE007A	3	A	t	CV027	f	2022-08-09 15:20:49.733819	2022-08-09 15:20:49.733819
f001fec6-7fd4-4f8a-a60a-18f773bd22e5	SE007A	3	D	t	CV027	f	2022-08-09 15:20:49.739107	2022-08-09 15:20:49.739107
a36a21ed-3077-43bf-a246-3c92577d75cb	SE007A	3	I	t	CV027	f	2022-08-09 15:20:49.744537	2022-08-09 15:20:49.744537
bf50022a-e3bb-41fd-8283-6818d4ae29f9	SE007A	3	W	t	CV027	f	2022-08-09 15:20:49.749935	2022-08-09 15:20:49.749935
646b06a8-045f-4475-81f7-30fef2c28e14	SE007A	3	Z	t	CV027	f	2022-08-09 15:20:49.755645	2022-08-09 15:20:49.755645
fc780672-987d-484d-aa26-255ff1b61961	SE007A	3	A	f	CV027	f	2022-08-09 15:20:49.760976	2022-08-09 15:20:49.760976
f445db91-5997-48f8-9e5d-1e630b8110b5	SE007A	3	D	f	CV027	f	2022-08-09 15:20:49.766258	2022-08-09 15:20:49.766258
94eae331-f085-43e8-8280-2f9e39ef1983	SE007A	3	I	f	CV027	f	2022-08-09 15:20:49.772086	2022-08-09 15:20:49.772086
59e116b8-0570-4feb-9abc-31e80ce5cfa1	SE007A	3	W	f	CV027	f	2022-08-09 15:20:49.77866	2022-08-09 15:20:49.77866
22f13d98-cbce-4184-b082-f5aeb5bb6906	SE007A	3	Z	f	CV027	f	2022-08-09 15:20:49.78491	2022-08-09 15:20:49.78491
ea9ab32f-8151-41f6-b937-90de5eab9d25	SE007A	3	A	t	CV079	f	2022-08-09 15:20:49.790486	2022-08-09 15:20:49.790486
4cfa5cc4-3a77-4bc1-9a7a-d03cc4f3ef1e	SE007A	3	D	t	CV079	f	2022-08-09 15:20:49.796418	2022-08-09 15:20:49.796418
57a96f4c-add7-40be-8bc5-79058189edc7	SE007A	3	I	t	CV079	f	2022-08-09 15:20:49.801983	2022-08-09 15:20:49.801983
655f1f94-bc4c-49b1-9b58-c91d8b7dfd50	SE007A	3	W	t	CV079	f	2022-08-09 15:20:49.807768	2022-08-09 15:20:49.807768
7b06ef93-323c-4649-920a-6c59034aeb6e	SE007A	3	Z	t	CV079	f	2022-08-09 15:20:49.813568	2022-08-09 15:20:49.813568
c478e3ad-9eb4-4196-ae73-e2e4c959d4e4	SE007A	3	A	f	CV118	f	2022-08-09 15:20:49.875472	2022-08-09 15:20:49.875472
63ebde9e-857c-4fd3-aba4-4d9de91422b6	SE007A	3	D	f	CV118	f	2022-08-09 15:20:49.88077	2022-08-09 15:20:49.88077
d9ed1fcf-06de-4103-b5ee-1c26077edf91	SE007A	3	I	f	CV118	f	2022-08-09 15:20:49.886555	2022-08-09 15:20:49.886555
ef61009c-834f-4b57-a7e3-fb2792be2a87	SE007A	3	W	f	CV118	f	2022-08-09 15:20:49.892019	2022-08-09 15:20:49.892019
2a09e3c3-8433-4d88-859a-8a022c90c151	SE007A	3	Z	f	CV118	f	2022-08-09 15:20:49.89755	2022-08-09 15:20:49.89755
c7154b83-b8aa-44eb-b8f9-74e80c2a9dcd	SE007A	3	A	f	CV079	t	2022-08-09 15:20:49.819072	2022-08-09 15:20:49.904797
a6f54422-9d53-4be1-8235-fb95f4a080de	SE007A	3	D	f	CV079	t	2022-08-09 15:20:49.824781	2022-08-09 15:20:49.912267
74d065ff-2b5c-40c1-8b7c-742533164d04	SE007A	3	I	f	CV079	t	2022-08-09 15:20:49.830342	2022-08-09 15:20:49.919543
90e1812f-16c0-4ad4-83b9-12af396fa7cf	SE007A	3	W	f	CV079	t	2022-08-09 15:20:49.836721	2022-08-09 15:20:49.92651
40ac248b-5414-4dde-bff8-4d6c2ad40f33	SE007A	3	Z	f	CV079	t	2022-08-09 15:20:49.842205	2022-08-09 15:20:49.934019
8fccae2f-e894-4d3a-9b71-e2563f9ea032	SE007A	3	A	t	CV118	t	2022-08-09 15:20:49.847846	2022-08-09 15:20:49.941457
08710aea-8ad9-454a-bb69-28081b97476d	SE007A	3	D	t	CV118	t	2022-08-09 15:20:49.853442	2022-08-09 15:20:49.94871
94aef4e5-7cfa-4369-b73f-776dd9a2251e	SE007A	3	I	t	CV118	t	2022-08-09 15:20:49.858933	2022-08-09 15:20:49.956111
d3ef9e6d-e52e-459e-82c0-e3e1559f5fa8	SE007A	3	W	t	CV118	t	2022-08-09 15:20:49.864547	2022-08-09 15:20:49.963451
0d46faf3-667a-4b4a-a88d-fd3f653268c2	SE007A	3	Z	t	CV118	t	2022-08-09 15:20:49.869871	2022-08-09 15:20:49.971455
ec3314b1-7117-43f5-8a4d-c2a1efc58d6b	SE008A	3	A	t	APL09	f	2022-08-09 15:20:49.976696	2022-08-09 15:20:49.976696
656e2bae-90d2-4b3d-8adf-6038136f7b99	SE008A	3	D	t	APL09	f	2022-08-09 15:20:49.982636	2022-08-09 15:20:49.982636
3e80741d-41c0-4e26-a2d8-c00976cd68a4	SE008A	3	I	t	APL09	f	2022-08-09 15:20:49.987995	2022-08-09 15:20:49.987995
acc1e213-3e4e-48dd-95cd-24a9c1456678	SE008A	3	W	t	APL09	f	2022-08-09 15:20:49.993443	2022-08-09 15:20:49.993443
f42f590e-4105-48db-b279-7dd2d08887d9	SE008A	3	Z	t	APL09	f	2022-08-09 15:20:49.999168	2022-08-09 15:20:49.999168
f47c3f16-d93f-4ce4-b913-e37fccf9535e	SE008A	3	A	f	APL09	f	2022-08-09 15:20:50.004428	2022-08-09 15:20:50.004428
bf83ec37-c045-476d-93af-92f26f210d49	SE008A	3	D	f	APL09	f	2022-08-09 15:20:50.009943	2022-08-09 15:20:50.009943
cc37d3f9-d38a-4a1e-b428-7274e284c9ca	SE008A	3	I	f	APL09	f	2022-08-09 15:20:50.015716	2022-08-09 15:20:50.015716
adb351f3-c0aa-468c-9e80-9db52137b3a5	SE008A	3	W	f	APL09	f	2022-08-09 15:20:50.021	2022-08-09 15:20:50.021
d4d66872-fd9b-4469-abc1-a77fc291b40b	SE008A	3	Z	f	APL09	f	2022-08-09 15:20:50.026586	2022-08-09 15:20:50.026586
19754b27-e3e4-490f-8aba-80ee0aea5ddd	SE008A	3	A	t	APL07	f	2022-08-09 15:20:50.031817	2022-08-09 15:20:50.031817
bb378b03-a319-48ba-865c-051e483658c2	SE008A	3	D	t	APL07	f	2022-08-09 15:20:50.037374	2022-08-09 15:20:50.037374
567b893e-eb25-4818-9eca-acbf1b1ae895	SE008A	3	I	t	APL07	f	2022-08-09 15:20:50.043777	2022-08-09 15:20:50.043777
c7819274-9142-4959-a1f9-ca8a1f85181a	SE008A	3	W	t	APL07	f	2022-08-09 15:20:50.049296	2022-08-09 15:20:50.049296
16c73d40-a6fe-4185-85ed-79e54f70f5f3	SE008A	3	Z	t	APL07	f	2022-08-09 15:20:50.054827	2022-08-09 15:20:50.054827
2f701686-c45d-41a5-b198-2d97169418c4	SE008A	3	A	f	APL07	f	2022-08-09 15:20:50.060972	2022-08-09 15:20:50.060972
b7a2089f-8571-4ec8-a105-3443b7fba1a4	SE008A	3	D	f	APL07	f	2022-08-09 15:20:50.066568	2022-08-09 15:20:50.066568
8598a31a-c75a-4835-a409-88657b86041f	SE008A	3	I	f	APL07	f	2022-08-09 15:20:50.07233	2022-08-09 15:20:50.07233
662c7282-4092-4013-a438-51a3bd15bb51	SE008A	3	W	f	APL07	f	2022-08-09 15:20:50.077861	2022-08-09 15:20:50.077861
b0803dde-c731-499c-8c17-89723d586c79	SE008A	3	Z	f	APL07	f	2022-08-09 15:20:50.084079	2022-08-09 15:20:50.084079
5ce4d801-fee4-4988-bd3f-3a020fc764b7	SE008A	3	A	t	APL11	f	2022-08-09 15:20:50.089648	2022-08-09 15:20:50.089648
44167536-9bf3-4e3d-949b-17291fd8ced8	SE008A	3	D	t	APL11	f	2022-08-09 15:20:50.095006	2022-08-09 15:20:50.095006
73fbf713-2f3c-48c1-92cf-b94f575b68af	SE008A	3	I	t	APL11	f	2022-08-09 15:20:50.10078	2022-08-09 15:20:50.10078
8b89b9b8-7f07-4b31-aebe-e5cce104e875	SE008A	3	W	t	APL11	f	2022-08-09 15:20:50.107668	2022-08-09 15:20:50.107668
ab96306d-c47b-4d9f-a44e-e9c268fb0f9a	SE008A	3	Z	t	APL11	f	2022-08-09 15:20:50.113903	2022-08-09 15:20:50.113903
04242c00-55a3-4883-8bfb-55771104ba73	SE008A	3	A	f	APL11	f	2022-08-09 15:20:50.119678	2022-08-09 15:20:50.119678
a529d489-f929-4140-a2d9-f7346f78e29c	SE008A	3	D	f	APL11	f	2022-08-09 15:20:50.125129	2022-08-09 15:20:50.125129
5c09c743-dab4-4e92-9d10-2b314b8d090c	SE008A	3	I	f	APL11	f	2022-08-09 15:20:50.130902	2022-08-09 15:20:50.130902
c3643ff6-2496-4e5e-aa21-b59b9c6c07c2	SE008A	3	W	f	APL11	f	2022-08-09 15:20:50.136399	2022-08-09 15:20:50.136399
e6f52497-2a3f-4480-a3b9-f26a05737e6d	SE008A	3	Z	f	APL11	f	2022-08-09 15:20:50.143079	2022-08-09 15:20:50.143079
46655340-ca14-49f4-8370-ddadf804ce87	SE008A	3	A	t	APL13	f	2022-08-09 15:20:50.149361	2022-08-09 15:20:50.149361
4cbef4ae-e833-4a04-bc00-176e85a6e83b	SE008A	3	D	t	APL13	f	2022-08-09 15:20:50.155311	2022-08-09 15:20:50.155311
b2d890c4-38f9-480a-9188-1d577a69f80d	SE008A	3	I	t	APL13	f	2022-08-09 15:20:50.160944	2022-08-09 15:20:50.160944
26cd2759-f1c1-4099-a329-199c4e96a213	SE008A	3	W	t	APL13	f	2022-08-09 15:20:50.166241	2022-08-09 15:20:50.166241
96386444-0940-4ac9-b8dc-f05fe5d2424e	SE008A	3	Z	t	APL13	f	2022-08-09 15:20:50.171755	2022-08-09 15:20:50.171755
29318c88-63f1-4df9-96bb-1bc9b452b1ab	SE008A	3	A	f	APL13	f	2022-08-09 15:20:50.177419	2022-08-09 15:20:50.177419
0c834f50-252a-4c58-a079-66c1e1f29008	SE008A	3	D	f	APL13	f	2022-08-09 15:20:50.182923	2022-08-09 15:20:50.182923
d23fc966-631c-453a-9055-4c6a7f1d78a2	SE008A	3	I	f	APL13	f	2022-08-09 15:20:50.188575	2022-08-09 15:20:50.188575
49ca8217-643a-4dc6-b5f6-0f8b26915aa7	SE008A	3	W	f	APL13	f	2022-08-09 15:20:50.193982	2022-08-09 15:20:50.193982
6acf7c6e-2abf-490e-9412-73429a0ce60f	SE008A	3	Z	f	APL13	f	2022-08-09 15:20:50.199794	2022-08-09 15:20:50.199794
44cf787f-44a7-4a6f-a53f-2522a98f38f3	SE008A	3	A	t	APL15	f	2022-08-09 15:20:50.20537	2022-08-09 15:20:50.20537
387665aa-aefe-41d6-83f2-8d42537c1d69	SE008A	3	D	t	APL15	f	2022-08-09 15:20:50.210848	2022-08-09 15:20:50.210848
c88f4375-c8aa-4ec8-af6c-a6c4d900d605	SE008A	3	I	t	APL15	f	2022-08-09 15:20:50.216604	2022-08-09 15:20:50.216604
dc356d70-26d9-4e02-aa2c-29d45414ff9a	SE008A	3	W	t	APL15	f	2022-08-09 15:20:50.221918	2022-08-09 15:20:50.221918
725d1427-3d91-4935-86f4-28637592d9f4	SE008A	3	Z	t	APL15	f	2022-08-09 15:20:50.227264	2022-08-09 15:20:50.227264
f423c0f3-de14-475c-a17b-15b6e74bed77	SE008A	3	A	f	APL15	f	2022-08-09 15:20:50.232971	2022-08-09 15:20:50.232971
592c434d-c891-4898-a235-23a31a39dcb8	SE008A	3	D	f	APL15	f	2022-08-09 15:20:50.238335	2022-08-09 15:20:50.238335
fce182af-ffb2-46b8-8857-a984f0a927a0	SE008A	3	I	f	APL15	f	2022-08-09 15:20:50.244332	2022-08-09 15:20:50.244332
443d27e7-a96d-4300-bd62-efbf9213812b	SE008A	3	W	f	APL15	f	2022-08-09 15:20:50.249749	2022-08-09 15:20:50.249749
69c38024-7a0a-4008-8ca4-564f7f1a6eac	SE008A	3	Z	f	APL15	f	2022-08-09 15:20:50.255636	2022-08-09 15:20:50.255636
40bce20b-1959-4c2f-a16e-7afc80d6b8c8	SE008A	3	A	t	APL16	f	2022-08-09 15:20:50.26105	2022-08-09 15:20:50.26105
64453ecd-a3fa-4bd9-876b-6417609bc858	SE008A	3	D	t	APL16	f	2022-08-09 15:20:50.266389	2022-08-09 15:20:50.266389
1e97cda9-babe-4ac8-a9ce-08c918f53765	SE008A	3	I	t	APL16	f	2022-08-09 15:20:50.272105	2022-08-09 15:20:50.272105
47e1c791-f2e7-4c2b-bf90-7f29ced023ab	SE008A	3	W	t	APL16	f	2022-08-09 15:20:50.277401	2022-08-09 15:20:50.277401
f4659b87-300c-47de-a892-44453d49af9f	SE008A	3	Z	t	APL16	f	2022-08-09 15:20:50.28297	2022-08-09 15:20:50.28297
42cc36c1-234d-4de4-aeb7-5c587ffa19a1	SE008A	3	A	f	APL16	f	2022-08-09 15:20:50.288582	2022-08-09 15:20:50.288582
b8327205-ae9d-4e03-8c15-31c2451ed535	SE008A	3	D	f	APL16	f	2022-08-09 15:20:50.294122	2022-08-09 15:20:50.294122
8f1aaaad-539c-40c7-a7e0-fa3486b0ffe3	SE008A	3	I	f	APL16	f	2022-08-09 15:20:50.299637	2022-08-09 15:20:50.299637
46b0b240-6efa-4bd4-819f-8b74a4989daf	SE008A	3	W	f	APL16	f	2022-08-09 15:20:50.305221	2022-08-09 15:20:50.305221
2170cac7-421e-4629-8648-e8fc9e52e96a	SE008A	3	Z	f	APL16	f	2022-08-09 15:20:50.310587	2022-08-09 15:20:50.310587
c5a7bbda-7971-4943-b818-461b5ed520dd	SE008A	3	A	t	APL18	f	2022-08-09 15:20:50.316339	2022-08-09 15:20:50.316339
ad292c2b-6ada-41b2-bfe2-cce15900d9cf	SE008A	3	D	t	APL18	f	2022-08-09 15:20:50.322094	2022-08-09 15:20:50.322094
eda6063d-0adf-4d81-b0c1-14e0d1f1c771	SE008A	3	I	t	APL18	f	2022-08-09 15:20:50.327445	2022-08-09 15:20:50.327445
ba48492a-9ba6-4dc5-8464-6af425e57201	SE008A	3	W	t	APL18	f	2022-08-09 15:20:50.333079	2022-08-09 15:20:50.333079
41de8497-7b10-4b33-965c-8bf5b094eb4b	SE008A	3	Z	t	APL18	f	2022-08-09 15:20:50.338406	2022-08-09 15:20:50.338406
dcf6b476-3678-4560-920c-f4b9e1f52564	SE008A	3	A	f	APL18	f	2022-08-09 15:20:50.343695	2022-08-09 15:20:50.343695
16de7cf6-4b8a-4313-bae7-edd62a9630ff	SE008A	3	D	f	APL18	f	2022-08-09 15:20:50.350459	2022-08-09 15:20:50.350459
9a093b39-6719-4dff-b28a-e958132a13e5	SE008A	3	I	f	APL18	f	2022-08-09 15:20:50.356809	2022-08-09 15:20:50.356809
686ab47c-a8eb-4f0a-b0aa-0491e5dd1632	SE008A	3	W	f	APL18	f	2022-08-09 15:20:50.363152	2022-08-09 15:20:50.363152
d718fb29-ee97-453a-b8b3-39860638eddb	SE008A	3	Z	f	APL18	f	2022-08-09 15:20:50.368944	2022-08-09 15:20:50.368944
317ca951-7ff7-4980-b699-7db7792c0a95	SE008A	3	A	t	APL20	f	2022-08-09 15:20:50.375343	2022-08-09 15:20:50.375343
674fe278-64fa-4e95-8837-7b74ba2cf324	SE008A	3	D	t	APL20	f	2022-08-09 15:20:50.381504	2022-08-09 15:20:50.381504
7d08c41f-1156-4038-bd40-acb0a1eaab48	SE008A	3	I	t	APL20	f	2022-08-09 15:20:50.387235	2022-08-09 15:20:50.387235
1cfc0d15-90cf-4f85-882e-d00e90bb7256	SE008A	3	W	t	APL20	f	2022-08-09 15:20:50.39383	2022-08-09 15:20:50.39383
acaf0663-ba72-4507-afbe-39fe4ea56549	SE008A	3	Z	t	APL20	f	2022-08-09 15:20:50.399695	2022-08-09 15:20:50.399695
a3cde82d-5315-42c3-8fd0-2a2ec60257ba	SE008A	3	A	f	APL20	f	2022-08-09 15:20:50.405445	2022-08-09 15:20:50.405445
98d0e252-2006-4ea0-90ff-5f740610435b	SE008A	3	D	f	APL20	f	2022-08-09 15:20:50.411097	2022-08-09 15:20:50.411097
00e43700-166a-4c1d-ba73-a1d03ee23fd2	SE008A	3	I	f	APL20	f	2022-08-09 15:20:50.416348	2022-08-09 15:20:50.416348
e4e8010d-762d-49e0-ab80-4ec27999c1c5	SE008A	3	W	f	APL20	f	2022-08-09 15:20:50.42205	2022-08-09 15:20:50.42205
c71be509-9aea-4bb9-8530-40f01b5e1aae	SE008A	3	Z	f	APL20	f	2022-08-09 15:20:50.427271	2022-08-09 15:20:50.427271
e78f01a6-209b-4ce9-a6fa-b71528fd21cf	SE008A	3	A	t	APL22	f	2022-08-09 15:20:50.433988	2022-08-09 15:20:50.433988
75ab8de3-e162-49a2-b5b3-f6831f7fb302	SE008A	3	D	t	APL22	f	2022-08-09 15:20:50.439725	2022-08-09 15:20:50.439725
92f907ea-3ce9-4f60-ae10-918a1849cc71	SE008A	3	I	t	APL22	f	2022-08-09 15:20:50.445723	2022-08-09 15:20:50.445723
6fd81e53-6378-4c0a-b9aa-fc9423d4e710	SE008A	3	W	t	APL22	f	2022-08-09 15:20:50.451269	2022-08-09 15:20:50.451269
ba2f18b4-5da4-4406-b39e-3f2ecdb6af7c	SE008A	3	Z	t	APL22	f	2022-08-09 15:20:50.45695	2022-08-09 15:20:50.45695
2a0f6d13-6c3d-45c1-914f-65f6e5b05713	SE008A	3	A	f	APL22	f	2022-08-09 15:20:50.462266	2022-08-09 15:20:50.462266
49830b37-0c20-41e7-a4ad-98c3cc079e40	SE008A	3	D	f	APL22	f	2022-08-09 15:20:50.468112	2022-08-09 15:20:50.468112
4c337f1d-36d8-4a75-8ea8-547482cd2fd9	SE008A	3	I	f	APL22	f	2022-08-09 15:20:50.473667	2022-08-09 15:20:50.473667
b68bc5dd-318c-4af3-8ff9-01555a071d04	SE008A	3	W	f	APL22	f	2022-08-09 15:20:50.479168	2022-08-09 15:20:50.479168
002420e1-aaaf-411d-a072-75d1d26d96d7	SE008A	3	Z	f	APL22	f	2022-08-09 15:20:50.485312	2022-08-09 15:20:50.485312
0cd31230-3354-4842-9f3a-f78f42c677ea	SE008A	3	A	t	APL27	f	2022-08-09 15:20:50.490831	2022-08-09 15:20:50.490831
6931b0ca-1955-449f-861d-10f33bd42cee	SE008A	3	D	t	APL27	f	2022-08-09 15:20:50.49669	2022-08-09 15:20:50.49669
924da408-d0e3-4f4c-a215-e5c825b0d21f	SE008A	3	I	t	APL27	f	2022-08-09 15:20:50.502072	2022-08-09 15:20:50.502072
e674524a-52ff-4de2-b01a-93be6893a4b8	SE008A	3	W	t	APL27	f	2022-08-09 15:20:50.507604	2022-08-09 15:20:50.507604
980883a6-b61f-4c27-9109-17d3f45986d8	SE008A	3	Z	t	APL27	f	2022-08-09 15:20:50.513137	2022-08-09 15:20:50.513137
2c3a6902-e3c7-4251-917d-0cad37650136	SE008A	3	A	f	APL27	f	2022-08-09 15:20:50.519362	2022-08-09 15:20:50.519362
54742ad0-c187-4461-9a78-54059ee50731	SE008A	3	D	f	APL27	f	2022-08-09 15:20:50.525319	2022-08-09 15:20:50.525319
80f5c719-e602-4a72-8614-7e9a84172ef2	SE008A	3	I	f	APL27	f	2022-08-09 15:20:50.530639	2022-08-09 15:20:50.530639
f60224de-60e2-4462-ac86-128d0a8ba79d	SE008A	3	W	f	APL27	f	2022-08-09 15:20:50.53637	2022-08-09 15:20:50.53637
863e06a7-a8dc-41c8-81db-d9eee7b19d76	SE008A	3	Z	f	APL27	f	2022-08-09 15:20:50.541628	2022-08-09 15:20:50.541628
19ca8326-033e-47c7-82b5-ede47c29946e	SE008A	3	A	t	APL29	f	2022-08-09 15:20:50.546898	2022-08-09 15:20:50.546898
0c58e007-640e-4fc9-8a78-7248df2200b5	SE008A	3	D	t	APL29	f	2022-08-09 15:20:50.552512	2022-08-09 15:20:50.552512
a8973ed0-a053-44ab-8149-4879a8520aaf	SE008A	3	I	t	APL29	f	2022-08-09 15:20:50.557987	2022-08-09 15:20:50.557987
0b98e598-beb9-4395-85e4-5e79922eceb9	SE008A	3	W	t	APL29	f	2022-08-09 15:20:50.563213	2022-08-09 15:20:50.563213
eed0e0fc-2427-4cc3-be99-0a18d99fcd26	SE008A	3	Z	t	APL29	f	2022-08-09 15:20:50.56877	2022-08-09 15:20:50.56877
3c5d59ff-8d48-4eb2-99eb-104441e6af52	SE008A	3	A	f	APL29	f	2022-08-09 15:20:50.573986	2022-08-09 15:20:50.573986
7efff1ac-330c-4eb6-9d07-33bd1d5d860c	SE008A	3	D	f	APL29	f	2022-08-09 15:20:50.580056	2022-08-09 15:20:50.580056
68f8e93a-9129-4741-94fb-abbc2692b9fc	SE008A	3	I	f	APL29	f	2022-08-09 15:20:50.587308	2022-08-09 15:20:50.587308
f4694832-fb63-4a94-b0a8-c3e8e0ae15dd	SE008A	3	W	f	APL29	f	2022-08-09 15:20:50.593161	2022-08-09 15:20:50.593161
d53a134c-3d72-4b95-a387-0710bf021dc9	SE008A	3	Z	f	APL29	f	2022-08-09 15:20:50.598559	2022-08-09 15:20:50.598559
90efb24f-7ac4-427f-ae90-50582a98eac5	SE008A	3	A	t	APL31	f	2022-08-09 15:20:50.604327	2022-08-09 15:20:50.604327
6b06addd-5f58-44a9-9376-6b68b8c3b594	SE008A	3	D	t	APL31	f	2022-08-09 15:20:50.610486	2022-08-09 15:20:50.610486
ebe4dd9e-3f8f-44e3-80d8-6cbe770a6d63	SE008A	3	I	t	APL31	f	2022-08-09 15:20:50.616096	2022-08-09 15:20:50.616096
5d1b8353-0411-40fc-a740-524b78089169	SE008A	3	W	t	APL31	f	2022-08-09 15:20:50.621793	2022-08-09 15:20:50.621793
14ac1f0d-916b-4616-be67-ea32814de4ea	SE008A	3	Z	t	APL31	f	2022-08-09 15:20:50.627119	2022-08-09 15:20:50.627119
2b6575a8-39a4-46c6-8378-b22989f9b749	SE008A	3	A	f	APL31	f	2022-08-09 15:20:50.632471	2022-08-09 15:20:50.632471
bb3380b0-f383-4696-b4b6-fdd63c2d8475	SE008A	3	D	f	APL31	f	2022-08-09 15:20:50.638104	2022-08-09 15:20:50.638104
57ae4a22-7b30-4c90-b54d-212bc836c682	SE008A	3	I	f	APL31	f	2022-08-09 15:20:50.643445	2022-08-09 15:20:50.643445
8a469a30-6e9e-4ce3-a5ae-a1993fb0b8c1	SE008A	3	W	f	APL31	f	2022-08-09 15:20:50.648881	2022-08-09 15:20:50.648881
75ef3e2b-c924-4d9d-9e7a-5c4355fa73d3	SE008A	3	Z	f	APL31	f	2022-08-09 15:20:50.654511	2022-08-09 15:20:50.654511
65d22a6c-1485-4c04-8d2e-d2713a7faadc	SE008A	3	A	t	APL48	f	2022-08-09 15:20:50.659808	2022-08-09 15:20:50.659808
ec521d84-8cb9-4a34-a52f-158653731547	SE008A	3	D	t	APL48	f	2022-08-09 15:20:50.665245	2022-08-09 15:20:50.665245
512ff934-b17e-4824-a3a2-3323cb00d6e7	SE008A	3	I	t	APL48	f	2022-08-09 15:20:50.671114	2022-08-09 15:20:50.671114
c5b0069d-40b7-45aa-bdc7-65cad8e362a8	SE008A	3	W	t	APL48	f	2022-08-09 15:20:50.67691	2022-08-09 15:20:50.67691
705afa8d-6a57-489b-aa94-a971cd2a4721	SE008A	3	Z	t	APL48	f	2022-08-09 15:20:50.682974	2022-08-09 15:20:50.682974
7e9e7215-498a-40cd-8cd1-77e3337f81da	SE008A	3	A	f	APL48	f	2022-08-09 15:20:50.689181	2022-08-09 15:20:50.689181
70b50353-6d97-4433-8c0f-23c36880a199	SE008A	3	D	f	APL48	f	2022-08-09 15:20:50.694794	2022-08-09 15:20:50.694794
5a08df47-ea97-4156-b6a8-9a2f812e59b7	SE008A	3	I	f	APL48	f	2022-08-09 15:20:50.700487	2022-08-09 15:20:50.700487
7fdbfc88-ea20-43ed-a3d1-c1c694986e99	SE008A	3	W	f	APL48	f	2022-08-09 15:20:50.705765	2022-08-09 15:20:50.705765
fa67f927-b297-42d9-9225-8be47c6ede8a	SE008A	3	Z	f	APL48	f	2022-08-09 15:20:50.711222	2022-08-09 15:20:50.711222
779bfe2b-78be-4cde-bca0-5181f8c05fb4	SE008A	3	A	t	APL49	f	2022-08-09 15:20:50.717142	2022-08-09 15:20:50.717142
521616f8-01ab-475d-9f87-12ce4081bce3	SE008A	3	D	t	APL49	f	2022-08-09 15:20:50.722502	2022-08-09 15:20:50.722502
62ca7b17-774a-4fcf-b91b-90795d86396f	SE008A	3	I	t	APL49	f	2022-08-09 15:20:50.728257	2022-08-09 15:20:50.728257
2ba62aef-fc89-400f-a6d7-e570d5c41f79	SE008A	3	W	t	APL49	f	2022-08-09 15:20:50.733551	2022-08-09 15:20:50.733551
b3d0985d-0f51-4ac6-861d-33fc944c836e	SE008A	3	Z	t	APL49	f	2022-08-09 15:20:50.739102	2022-08-09 15:20:50.739102
7f23ebcf-3246-46df-8c57-a6748d60ea1d	SE008A	3	A	f	APL49	f	2022-08-09 15:20:50.744499	2022-08-09 15:20:50.744499
7c290485-e649-49f2-9b89-abedb62ace66	SE008A	3	D	f	APL49	f	2022-08-09 15:20:50.750079	2022-08-09 15:20:50.750079
1c0554b4-28fb-4728-903f-a18aa074afa7	SE008A	3	I	f	APL49	f	2022-08-09 15:20:50.755441	2022-08-09 15:20:50.755441
9ad6fe02-2e97-4368-9175-ea78de6c9044	SE008A	3	W	f	APL49	f	2022-08-09 15:20:50.762298	2022-08-09 15:20:50.762298
af1ae0af-f933-406e-931d-53ce47f0bfa7	SE008A	3	Z	f	APL49	f	2022-08-09 15:20:50.767893	2022-08-09 15:20:50.767893
e0f92ab9-65e1-485a-bc7a-d9ce264ee84a	SE008A	3	A	t	APL50	f	2022-08-09 15:20:50.773711	2022-08-09 15:20:50.773711
fbe43a25-b91c-4325-9dca-6935151fc7f5	SE008A	3	D	t	APL50	f	2022-08-09 15:20:50.779257	2022-08-09 15:20:50.779257
cf9bcf41-bc5c-4bda-9eb4-896865fa525a	SE008A	3	I	t	APL50	f	2022-08-09 15:20:50.784964	2022-08-09 15:20:50.784964
b19ff8d3-9309-4e66-bb06-c1bb84053bf3	SE008A	3	W	t	APL50	f	2022-08-09 15:20:50.790305	2022-08-09 15:20:50.790305
07af55b1-17c4-472b-b8cd-21c71f0e7f52	SE008A	3	Z	t	APL50	f	2022-08-09 15:20:50.796129	2022-08-09 15:20:50.796129
cd25f94c-0765-45b0-a31c-11ca8fe9c732	SE008A	3	A	f	APL50	f	2022-08-09 15:20:50.801474	2022-08-09 15:20:50.801474
35d0f74c-9639-4042-bcb2-6357df02ff77	SE008A	3	D	f	APL50	f	2022-08-09 15:20:50.8073	2022-08-09 15:20:50.8073
c65a64f4-a9ca-492f-8868-6e0e9c5beca2	SE008A	3	I	f	APL50	f	2022-08-09 15:20:50.813078	2022-08-09 15:20:50.813078
2b1ba4b6-6898-470f-91bd-affa036fcbb4	SE008A	3	W	f	APL50	f	2022-08-09 15:20:50.818466	2022-08-09 15:20:50.818466
435d2e4a-b8e1-4b44-8a9d-6cb049805f5e	SE008A	3	Z	f	APL50	f	2022-08-09 15:20:50.824043	2022-08-09 15:20:50.824043
77dc721c-b4d3-4326-b50a-891aa7284735	SE008A	3	A	t	APL51	f	2022-08-09 15:20:50.829761	2022-08-09 15:20:50.829761
a33d4cf0-25c5-45b7-b3cf-8624786bc843	SE008A	3	D	t	APL51	f	2022-08-09 15:20:50.835278	2022-08-09 15:20:50.835278
f99ba147-ca02-4bd1-a19f-94353d685478	SE008A	3	I	t	APL51	f	2022-08-09 15:20:50.841005	2022-08-09 15:20:50.841005
affe6261-caf7-4c82-a2ca-e285f36f20a4	SE008A	3	W	t	APL51	f	2022-08-09 15:20:50.846405	2022-08-09 15:20:50.846405
91da0005-2605-4287-a997-84376f62dd01	SE008A	3	Z	t	APL51	f	2022-08-09 15:20:50.852296	2022-08-09 15:20:50.852296
a83d8577-0917-4d89-88d4-b1b88056377f	SE008A	3	A	f	APL51	f	2022-08-09 15:20:50.857815	2022-08-09 15:20:50.857815
0d3b7b74-0c18-4dea-ba56-5d5375078eeb	SE008A	3	D	f	APL51	f	2022-08-09 15:20:50.863667	2022-08-09 15:20:50.863667
115fb495-02da-4c02-8caa-94a82dadbd4a	SE008A	3	I	f	APL51	f	2022-08-09 15:20:50.869236	2022-08-09 15:20:50.869236
5edde5d1-d651-4cac-b8b9-1376ec78090a	SE008A	3	W	f	APL51	f	2022-08-09 15:20:50.874587	2022-08-09 15:20:50.874587
40a74426-ed60-4c82-a84e-b90bc75eb2f9	SE008A	3	Z	f	APL51	f	2022-08-09 15:20:50.88021	2022-08-09 15:20:50.88021
db6a02eb-ed04-4c76-b2c3-355b0458a792	SE008A	3	A	t	APL52	f	2022-08-09 15:20:50.885388	2022-08-09 15:20:50.885388
c42ec41d-75f3-4863-970a-16631f7ddf7c	SE008A	3	D	t	APL52	f	2022-08-09 15:20:50.890699	2022-08-09 15:20:50.890699
6e234add-a7c6-4581-80d8-086eac9133ad	SE008A	3	I	t	APL52	f	2022-08-09 15:20:50.89698	2022-08-09 15:20:50.89698
1dfbd32b-3a35-4541-a12b-4e956081fc10	SE008A	3	W	t	APL52	f	2022-08-09 15:20:50.902562	2022-08-09 15:20:50.902562
423592bf-a3d6-48cc-98f0-f4ed8f21a371	SE008A	3	Z	t	APL52	f	2022-08-09 15:20:50.90862	2022-08-09 15:20:50.90862
dd5d45e8-6a3c-4b2d-abc2-a17905119579	SE008A	3	A	f	APL52	f	2022-08-09 15:20:50.914023	2022-08-09 15:20:50.914023
2966e8b7-c06b-4ab1-adcd-f492489f9bc8	SE008A	3	D	f	APL52	f	2022-08-09 15:20:50.919237	2022-08-09 15:20:50.919237
449598d4-5248-472d-b81b-6d4bacd40034	SE008A	3	I	f	APL52	f	2022-08-09 15:20:50.924884	2022-08-09 15:20:50.924884
b98cd2db-edea-4035-a760-7382a15ff1b3	SE008A	3	W	f	APL52	f	2022-08-09 15:20:50.93035	2022-08-09 15:20:50.93035
56258cf3-ea23-46ce-80fa-e194a8fbb2e2	SE008A	3	Z	f	APL52	f	2022-08-09 15:20:50.935702	2022-08-09 15:20:50.935702
993bddc1-7df9-49d1-a121-e620e66d5f34	SE008A	3	A	t	APL53	f	2022-08-09 15:20:50.941439	2022-08-09 15:20:50.941439
33d76c9a-41ee-4876-b9fa-34b2b1890905	SE008A	3	D	t	APL53	f	2022-08-09 15:20:50.946631	2022-08-09 15:20:50.946631
1d407624-144b-4184-83c4-3eb9d436ef68	SE008A	3	I	t	APL53	f	2022-08-09 15:20:50.952222	2022-08-09 15:20:50.952222
b6ac7817-8d3b-48a1-9a66-223ae072b24f	SE008A	3	W	t	APL53	f	2022-08-09 15:20:50.957584	2022-08-09 15:20:50.957584
05ba4ec2-f0f1-4341-9613-b3825a781a21	SE008A	3	Z	t	APL53	f	2022-08-09 15:20:50.962807	2022-08-09 15:20:50.962807
2220cb4d-b91f-440e-b651-23cc9cd4aa21	SE008A	3	A	f	APL53	f	2022-08-09 15:20:50.968592	2022-08-09 15:20:50.968592
77cfd631-1de6-46cd-aa33-ef2e6b86f53c	SE008A	3	D	f	APL53	f	2022-08-09 15:20:50.975041	2022-08-09 15:20:50.975041
76f51fc1-261b-4629-a9fc-be670023313f	SE008A	3	I	f	APL53	f	2022-08-09 15:20:50.981758	2022-08-09 15:20:50.981758
3a437dc1-01e8-4f1e-b194-ae933f57080c	SE008A	3	W	f	APL53	f	2022-08-09 15:20:50.987428	2022-08-09 15:20:50.987428
501e4e56-6462-4192-8a2a-7c0d955552e9	SE008A	3	Z	f	APL53	f	2022-08-09 15:20:50.992757	2022-08-09 15:20:50.992757
1879b83a-a65c-4a83-b00e-5a4e993c84f5	SE008A	3	A	t	APL54	f	2022-08-09 15:20:50.99858	2022-08-09 15:20:50.99858
497512c9-859a-43d6-a2b4-780e8e024229	SE008A	3	D	t	APL54	f	2022-08-09 15:20:51.003933	2022-08-09 15:20:51.003933
42ecec9b-458c-47ee-8104-f421cc8ed78c	SE008A	3	I	t	APL54	f	2022-08-09 15:20:51.009191	2022-08-09 15:20:51.009191
a74a1eaf-20b6-4d2d-a7dd-90c0507f076e	SE008A	3	W	t	APL54	f	2022-08-09 15:20:51.01508	2022-08-09 15:20:51.01508
602d4c76-e90d-466a-87a9-2f547c6a2153	SE008A	3	Z	t	APL54	f	2022-08-09 15:20:51.020609	2022-08-09 15:20:51.020609
aedb797f-136e-4679-863e-4efd1d3757a1	SE008A	3	A	f	APL54	f	2022-08-09 15:20:51.025908	2022-08-09 15:20:51.025908
b2700f33-2377-4e53-bad4-23103c2080ce	SE008A	3	D	f	APL54	f	2022-08-09 15:20:51.031381	2022-08-09 15:20:51.031381
be46aa0c-2140-41de-a03a-deada53947aa	SE008A	3	I	f	APL54	f	2022-08-09 15:20:51.036688	2022-08-09 15:20:51.036688
8c3c78d7-1cf4-4cc6-8a45-5b909cb3b7a8	SE008A	3	W	f	APL54	f	2022-08-09 15:20:51.042341	2022-08-09 15:20:51.042341
40132af7-cfc1-4117-97ee-5e8624d17211	SE008A	3	Z	f	APL54	f	2022-08-09 15:20:51.047672	2022-08-09 15:20:51.047672
47b1a3ac-2ee2-46b7-9bf5-74a11d4ba64b	SE008A	3	A	t	APL55	f	2022-08-09 15:20:51.053197	2022-08-09 15:20:51.053197
a85b5f60-50f0-4ec2-ae16-d46cf6f10f6f	SE008A	3	D	t	APL55	f	2022-08-09 15:20:51.05894	2022-08-09 15:20:51.05894
c2e7770a-1483-4484-a1fd-1ea380ea6507	SE008A	3	I	t	APL55	f	2022-08-09 15:20:51.0647	2022-08-09 15:20:51.0647
d14d2b42-d72b-4d16-a45e-21ea512669aa	SE008A	3	W	t	APL55	f	2022-08-09 15:20:51.069978	2022-08-09 15:20:51.069978
1c5aedb7-4a55-4d03-adb2-87615728024e	SE008A	3	Z	t	APL55	f	2022-08-09 15:20:51.075431	2022-08-09 15:20:51.075431
14c3819c-15cb-4149-a973-16514e8c4dab	SE008A	3	A	f	APL55	f	2022-08-09 15:20:51.083952	2022-08-09 15:20:51.083952
db55747a-a1d8-4fad-8713-1c2f34886ed9	SE008A	3	D	f	APL55	f	2022-08-09 15:20:51.09029	2022-08-09 15:20:51.09029
989a0f6c-156a-4b85-a8da-bbb900ef67fb	SE008A	3	I	f	APL55	f	2022-08-09 15:20:51.096122	2022-08-09 15:20:51.096122
ee1df89f-b3c4-4152-8cee-e35639402de5	SE008A	3	W	f	APL55	f	2022-08-09 15:20:51.102051	2022-08-09 15:20:51.102051
fb4b069e-6888-4473-bb69-022d69e91360	SE008A	3	Z	f	APL55	f	2022-08-09 15:20:51.108146	2022-08-09 15:20:51.108146
74a99c32-c583-4432-bda6-f0f17951d6a8	SE008A	3	A	t	APL56	f	2022-08-09 15:20:51.11397	2022-08-09 15:20:51.11397
ed9321bd-3902-4f30-81e6-eba1dfeebd52	SE008A	3	D	t	APL56	f	2022-08-09 15:20:51.119824	2022-08-09 15:20:51.119824
492eae36-3f41-4dcc-8c4a-b0067788056e	SE008A	3	I	t	APL56	f	2022-08-09 15:20:51.125539	2022-08-09 15:20:51.125539
916fc9f0-d448-481d-bd21-4d5252a25810	SE008A	3	W	t	APL56	f	2022-08-09 15:20:51.131853	2022-08-09 15:20:51.131853
b3f6388c-dcac-4f06-9de0-a00e7d1f064c	SE008A	3	Z	t	APL56	f	2022-08-09 15:20:51.138263	2022-08-09 15:20:51.138263
122c4ee4-9b36-463d-a734-1fd91df1d7b1	SE008A	3	A	f	APL56	f	2022-08-09 15:20:51.144008	2022-08-09 15:20:51.144008
5d4226d1-af1a-4ca0-81bf-724971114c8d	SE008A	3	D	f	APL56	f	2022-08-09 15:20:51.149788	2022-08-09 15:20:51.149788
655dab6a-e723-4977-a64f-b9ede8b3066e	SE008A	3	I	f	APL56	f	2022-08-09 15:20:51.155081	2022-08-09 15:20:51.155081
a4258049-c4c2-49bb-8d99-1a3f230deac8	SE008A	3	W	f	APL56	f	2022-08-09 15:20:51.160598	2022-08-09 15:20:51.160598
d71d9120-7291-4732-b82e-9a07a6e25af6	SE008A	3	Z	f	APL56	f	2022-08-09 15:20:51.165802	2022-08-09 15:20:51.165802
b6ccefb9-7c2c-4ca6-b4ca-91d053c86a3a	SE008A	3	A	t	APL57	f	2022-08-09 15:20:51.171592	2022-08-09 15:20:51.171592
59df47f7-e67e-4f49-b394-27abae3a4281	SE008A	3	D	t	APL57	f	2022-08-09 15:20:51.178015	2022-08-09 15:20:51.178015
fa7838b6-8f0d-4187-9ee1-f447980ed55d	SE008A	3	I	t	APL57	f	2022-08-09 15:20:51.184026	2022-08-09 15:20:51.184026
a13629a8-3288-4a1e-99ca-600487002f61	SE008A	3	W	t	APL57	f	2022-08-09 15:20:51.190756	2022-08-09 15:20:51.190756
9921ee86-f9b7-404f-9551-d7a207ad5029	SE008A	3	Z	t	APL57	f	2022-08-09 15:20:51.19759	2022-08-09 15:20:51.19759
5d5911cb-e66d-43b8-a7eb-d0d2ff5ba3df	SE008A	3	A	f	APL57	f	2022-08-09 15:20:51.204773	2022-08-09 15:20:51.204773
d0d6a319-ab8b-4164-aee3-524f96d475eb	SE008A	3	D	f	APL57	f	2022-08-09 15:20:51.211211	2022-08-09 15:20:51.211211
b56a46cf-f75f-4e7e-be65-af2a36a2ca38	SE008A	3	I	f	APL57	f	2022-08-09 15:20:51.217753	2022-08-09 15:20:51.217753
de0a368e-0845-46fa-8677-93df73c2900e	SE008A	3	W	f	APL57	f	2022-08-09 15:20:51.224011	2022-08-09 15:20:51.224011
984bf78f-da04-4385-be5d-0e6ae56b3660	SE008A	3	Z	f	APL57	f	2022-08-09 15:20:51.229418	2022-08-09 15:20:51.229418
22243978-ec4b-4e0a-80d9-561ca398bcd4	SE008A	3	A	t	APL65	f	2022-08-09 15:20:51.235728	2022-08-09 15:20:51.235728
4ad2cde4-78b8-428b-a9f3-254dbeb737a7	SE008A	3	D	t	APL65	f	2022-08-09 15:20:51.242505	2022-08-09 15:20:51.242505
dfbae356-daa4-4a01-9414-1676320930c7	SE008A	3	I	t	APL65	f	2022-08-09 15:20:51.24865	2022-08-09 15:20:51.24865
6916ad8d-f7a1-4f16-a469-f639267cecc1	SE008A	3	W	t	APL65	f	2022-08-09 15:20:51.254628	2022-08-09 15:20:51.254628
39661689-160b-4d10-96f2-e06452b13aa8	SE008A	3	Z	t	APL65	f	2022-08-09 15:20:51.259949	2022-08-09 15:20:51.259949
f3b3ba69-4a69-40da-997c-0cbf89476cb3	SE008A	3	A	f	APL65	f	2022-08-09 15:20:51.265451	2022-08-09 15:20:51.265451
33c0b82e-4e78-43c1-b6b4-6d36c9f7c659	SE008A	3	D	f	APL65	f	2022-08-09 15:20:51.270997	2022-08-09 15:20:51.270997
cf90e7cd-c448-4584-9d60-94d6ebd1907c	SE008A	3	I	f	APL65	f	2022-08-09 15:20:51.27635	2022-08-09 15:20:51.27635
7e4e1b3b-b0be-4c4e-bdbf-f63058d4ee64	SE008A	3	W	f	APL65	f	2022-08-09 15:20:51.28206	2022-08-09 15:20:51.28206
b0f645fe-9147-4026-8d36-06a4c5281bbb	SE008A	3	Z	f	APL65	f	2022-08-09 15:20:51.287758	2022-08-09 15:20:51.287758
a9207f20-e28a-4493-9163-beb2cc5949ab	SE008A	3	A	t	APL66	f	2022-08-09 15:20:51.293083	2022-08-09 15:20:51.293083
ebb43bb2-e4b8-4625-b37a-cab4eb9c06a4	SE008A	3	D	t	APL66	f	2022-08-09 15:20:51.298734	2022-08-09 15:20:51.298734
c94c24db-9ee5-41cb-9201-207d7d554079	SE008A	3	I	t	APL66	f	2022-08-09 15:20:51.303928	2022-08-09 15:20:51.303928
e4b0acd7-8fff-4c2f-ac6b-f8c563650972	SE008A	3	W	t	APL66	f	2022-08-09 15:20:51.309597	2022-08-09 15:20:51.309597
44469067-c1fb-42b3-b3e0-dbfd09c3c62e	SE008A	3	Z	t	APL66	f	2022-08-09 15:20:51.314859	2022-08-09 15:20:51.314859
2a89b512-2921-45e7-a5f4-5fdb0b900ee2	SE008A	3	A	f	APL66	f	2022-08-09 15:20:51.320096	2022-08-09 15:20:51.320096
f8fbb87a-4605-4319-ac21-f42b5fdda455	SE008A	3	D	f	APL66	f	2022-08-09 15:20:51.325915	2022-08-09 15:20:51.325915
fd649632-99df-4273-8a16-45ffde66ef12	SE008A	3	I	f	APL66	f	2022-08-09 15:20:51.332461	2022-08-09 15:20:51.332461
cf018dff-3e5a-43e3-845c-e1d0bd541d28	SE008A	3	W	f	APL66	f	2022-08-09 15:20:51.338635	2022-08-09 15:20:51.338635
0fe2a55b-0c98-4288-b579-787bbb4f6abe	SE008A	3	Z	f	APL66	f	2022-08-09 15:20:51.345737	2022-08-09 15:20:51.345737
9c592f26-bc80-43e6-8373-8070b023af83	SE008A	3	A	t	APL67	f	2022-08-09 15:20:51.35268	2022-08-09 15:20:51.35268
fdb13f9a-15dc-4bc5-b824-c0b6ed9495da	SE008A	3	D	t	APL67	f	2022-08-09 15:20:51.359193	2022-08-09 15:20:51.359193
f09c3c29-4164-4300-94bb-bcbcd9a1c52c	SE008A	3	I	t	APL67	f	2022-08-09 15:20:51.366483	2022-08-09 15:20:51.366483
7a0b0e47-0f60-45c2-9251-b46e4f0ffde8	SE008A	3	W	t	APL67	f	2022-08-09 15:20:51.372111	2022-08-09 15:20:51.372111
85c74255-ac17-4e48-9c6a-10853c769803	SE008A	3	Z	t	APL67	f	2022-08-09 15:20:51.378078	2022-08-09 15:20:51.378078
d12c75d7-27e6-48b1-835f-45fbf0bdee45	SE008A	3	A	f	APL67	f	2022-08-09 15:20:51.383946	2022-08-09 15:20:51.383946
ef1ed56c-0809-4535-9c30-0a7b67c118cc	SE008A	3	D	f	APL67	f	2022-08-09 15:20:51.390234	2022-08-09 15:20:51.390234
5e5a2ca5-6a9e-47bf-82ae-77fda75861d4	SE008A	3	I	f	APL67	f	2022-08-09 15:20:51.395998	2022-08-09 15:20:51.395998
e2fefbe7-b1cc-43c9-9c56-528355ae463a	SE008A	3	W	f	APL67	f	2022-08-09 15:20:51.401951	2022-08-09 15:20:51.401951
1ee84bfc-219e-40e0-823d-36a11d89d16a	SE008A	3	Z	f	APL67	f	2022-08-09 15:20:51.407717	2022-08-09 15:20:51.407717
e84d3367-0038-4e93-baa1-208cf783ec32	SE008A	3	A	t	APL68	f	2022-08-09 15:20:51.413775	2022-08-09 15:20:51.413775
9f9df51a-7bd6-44c5-8c1a-3a83fbf42a43	SE008A	3	D	t	APL68	f	2022-08-09 15:20:51.419427	2022-08-09 15:20:51.419427
017fdd47-fda0-4024-99fc-9f32978081b3	SE008A	3	I	t	APL68	f	2022-08-09 15:20:51.424902	2022-08-09 15:20:51.424902
24b919f1-b3e9-4609-bc31-4522ac58b0fa	SE008A	3	W	t	APL68	f	2022-08-09 15:20:51.432227	2022-08-09 15:20:51.432227
6f34dbc6-fa5c-4fa9-8285-8f2867c9fc9e	SE008A	3	Z	t	APL68	f	2022-08-09 15:20:51.437891	2022-08-09 15:20:51.437891
6f06908e-7f9c-44e9-968d-2f09c0b54e4c	SE008A	3	A	f	APL68	f	2022-08-09 15:20:51.44473	2022-08-09 15:20:51.44473
0ef1085d-ddb2-49bc-8dfd-460dd9788ba3	SE008A	3	D	f	APL68	f	2022-08-09 15:20:51.45047	2022-08-09 15:20:51.45047
3d044d87-11a4-4c9c-b39b-6174032fc9d5	SE008A	3	I	f	APL68	f	2022-08-09 15:20:51.456223	2022-08-09 15:20:51.456223
72f39a92-84be-4760-a7c6-bb5b82b1f9c7	SE008A	3	W	f	APL68	f	2022-08-09 15:20:51.46175	2022-08-09 15:20:51.46175
00f8c9e9-f955-442e-9766-5ce11b0209ae	SE008A	3	Z	f	APL68	f	2022-08-09 15:20:51.467665	2022-08-09 15:20:51.467665
5361e013-4d83-4ddc-ae79-3af969f0f266	SE008A	3	A	t	APL69	f	2022-08-09 15:20:51.473448	2022-08-09 15:20:51.473448
53e17d27-f794-45c2-b480-0aeb4ed75f95	SE008A	3	D	t	APL69	f	2022-08-09 15:20:51.478862	2022-08-09 15:20:51.478862
f670ad9f-2faf-4d0e-b77a-f9ebf9633e79	SE008A	3	I	t	APL69	f	2022-08-09 15:20:51.484606	2022-08-09 15:20:51.484606
3509a5c3-9c7d-4bde-8bed-1d5794f60518	SE008A	3	W	t	APL69	f	2022-08-09 15:20:51.490168	2022-08-09 15:20:51.490168
79ea4480-de20-45da-a5e4-da5c0026ef7c	SE008A	3	Z	t	APL69	f	2022-08-09 15:20:51.495531	2022-08-09 15:20:51.495531
6e5d54f9-64c3-4c83-97f7-7cedfd635408	SE008A	3	A	f	APL69	f	2022-08-09 15:20:51.501085	2022-08-09 15:20:51.501085
b0fdbb8d-c285-4d10-97f8-976cc12f74cd	SE008A	3	D	f	APL69	f	2022-08-09 15:20:51.50653	2022-08-09 15:20:51.50653
f91bb53f-908d-47ba-ad57-2b2053994a8a	SE008A	3	I	f	APL69	f	2022-08-09 15:20:51.512349	2022-08-09 15:20:51.512349
b2153862-35e8-4738-917c-2cc3256b278c	SE008A	3	W	f	APL69	f	2022-08-09 15:20:51.517811	2022-08-09 15:20:51.517811
2193939f-d216-40d0-b6b6-66ea59261950	SE008A	3	Z	f	APL69	f	2022-08-09 15:20:51.523743	2022-08-09 15:20:51.523743
4d26de5d-e3d8-4f8f-a73c-89f848cde239	SE008A	3	A	t	APL70	f	2022-08-09 15:20:51.529156	2022-08-09 15:20:51.529156
69f2c45a-1ec2-4708-a2b3-df208649dd85	SE008A	3	D	t	APL70	f	2022-08-09 15:20:51.534821	2022-08-09 15:20:51.534821
a43452fc-2896-4810-b349-be9920649f59	SE008A	3	I	t	APL70	f	2022-08-09 15:20:51.540156	2022-08-09 15:20:51.540156
5118a4ec-fd56-4a5a-98bb-f8db20110e3d	SE008A	3	W	t	APL70	f	2022-08-09 15:20:51.545535	2022-08-09 15:20:51.545535
3bd5a16e-de45-4d4c-9293-d992bb10d0f5	SE008A	3	Z	t	APL70	f	2022-08-09 15:20:51.551255	2022-08-09 15:20:51.551255
50b83636-ad8f-4441-8452-fc1cd15584e4	SE008A	3	A	f	APL70	f	2022-08-09 15:20:51.556502	2022-08-09 15:20:51.556502
4c4f1e4b-ce3b-4f3f-bbee-a9f66a4870ac	SE008A	3	D	f	APL70	f	2022-08-09 15:20:51.561749	2022-08-09 15:20:51.561749
9d39d50f-42fa-4592-a4d5-3f31841fe1c9	SE008A	3	I	f	APL70	f	2022-08-09 15:20:51.56719	2022-08-09 15:20:51.56719
b1324903-a231-43a5-a81a-cd2ce957680b	SE008A	3	W	f	APL70	f	2022-08-09 15:20:51.572566	2022-08-09 15:20:51.572566
717272c8-7b0d-49e3-a7dd-23f80c06dc1d	SE008A	3	Z	f	APL70	f	2022-08-09 15:20:51.578177	2022-08-09 15:20:51.578177
e24f2acb-6f21-4068-a9c9-1f3fb4d47266	SE008A	3	A	t	CV027	f	2022-08-09 15:20:51.583911	2022-08-09 15:20:51.583911
719efbe9-493d-4055-aec8-392e96958470	SE008A	3	D	t	CV027	f	2022-08-09 15:20:51.589345	2022-08-09 15:20:51.589345
5cdb604f-54a2-4632-8d90-0c648862a5a3	SE008A	3	I	t	CV027	f	2022-08-09 15:20:51.594969	2022-08-09 15:20:51.594969
251a4651-5850-4234-ace2-f85f2be747cf	SE008A	3	W	t	CV027	f	2022-08-09 15:20:51.60039	2022-08-09 15:20:51.60039
b30d2dc2-8ee4-4ad9-a110-440377a8b194	SE008A	3	Z	t	CV027	f	2022-08-09 15:20:51.605986	2022-08-09 15:20:51.605986
31d3015c-3979-4e14-b08a-fd2072dfb211	SE008A	3	A	f	CV027	f	2022-08-09 15:20:51.611776	2022-08-09 15:20:51.611776
ac0ba756-6819-4d82-8854-9460c5c4ee2e	SE008A	3	D	f	CV027	f	2022-08-09 15:20:51.617088	2022-08-09 15:20:51.617088
362d97d7-1bf6-4566-aea2-f2b2be595231	SE008A	3	I	f	CV027	f	2022-08-09 15:20:51.622985	2022-08-09 15:20:51.622985
ec3a78c6-fa86-4456-8688-b8e6caff9ed4	SE008A	3	W	f	CV027	f	2022-08-09 15:20:51.628898	2022-08-09 15:20:51.628898
5ba75d36-7b9b-491e-8e16-5f184f857241	SE008A	3	Z	f	CV027	f	2022-08-09 15:20:51.634853	2022-08-09 15:20:51.634853
bb09a616-4e94-4037-a2d9-14e48fc5ee61	SE008A	3	A	t	CV079	f	2022-08-09 15:20:51.640161	2022-08-09 15:20:51.640161
ae0a0c81-4d97-4058-bc85-c5b41fb5431a	SE008A	3	D	t	CV079	f	2022-08-09 15:20:51.645504	2022-08-09 15:20:51.645504
d1149f67-63c1-4d87-a95d-654a89258304	SE008A	3	I	t	CV079	f	2022-08-09 15:20:51.651265	2022-08-09 15:20:51.651265
125cd50d-2138-43d2-9d56-cd6716d3f8d4	SE008A	3	W	t	CV079	f	2022-08-09 15:20:51.6565	2022-08-09 15:20:51.6565
5530f5ee-2c94-4143-847a-63279b8d3a82	SE008A	3	Z	t	CV079	f	2022-08-09 15:20:51.66184	2022-08-09 15:20:51.66184
2b0ad26c-459c-4119-a2aa-44e30b0120b9	SE008A	3	A	f	CV118	f	2022-08-09 15:20:51.723148	2022-08-09 15:20:51.723148
b36b500a-c5d5-407c-b455-06760b0e405d	SE008A	3	D	f	CV118	f	2022-08-09 15:20:51.728435	2022-08-09 15:20:51.728435
1f0182bb-4bde-4bf3-ac90-bd09182ad2ab	SE008A	3	I	f	CV118	f	2022-08-09 15:20:51.734071	2022-08-09 15:20:51.734071
8010bda6-080e-431b-a5b9-900154d11eef	SE008A	3	W	f	CV118	f	2022-08-09 15:20:51.739436	2022-08-09 15:20:51.739436
ee2aa9bc-6406-4048-9cc6-0543a312f9bd	SE008A	3	Z	f	CV118	f	2022-08-09 15:20:51.745226	2022-08-09 15:20:51.745226
534ca053-6771-48f1-b944-de1101e43865	SE008A	3	A	f	CV079	t	2022-08-09 15:20:51.667443	2022-08-09 15:20:51.753694
36b1b117-28b6-434c-959a-1bb218ee1d7c	SE008A	3	D	f	CV079	t	2022-08-09 15:20:51.673113	2022-08-09 15:20:51.761446
8ea5690b-9003-437f-b5cd-ce3bd818fb5d	SE008A	3	I	f	CV079	t	2022-08-09 15:20:51.678683	2022-08-09 15:20:51.769062
1aaf37d2-39bb-48cc-b207-587f0e0023ed	SE008A	3	W	f	CV079	t	2022-08-09 15:20:51.684688	2022-08-09 15:20:51.776516
b9ee0828-13b1-4a28-86ed-f5213a3b8066	SE008A	3	Z	f	CV079	t	2022-08-09 15:20:51.690028	2022-08-09 15:20:51.78433
6d1e5a59-0056-49f5-aa24-a69de15cb6c5	SE008A	3	A	t	CV118	t	2022-08-09 15:20:51.695591	2022-08-09 15:20:51.791869
4588d4b6-5cc7-4b49-8868-36fd488edb4a	SE008A	3	D	t	CV118	t	2022-08-09 15:20:51.701271	2022-08-09 15:20:51.799267
170b60c6-b05b-478c-9a44-7f7a6cfc78ab	SE008A	3	I	t	CV118	t	2022-08-09 15:20:51.706405	2022-08-09 15:20:51.806818
ee3343b0-cf9f-4556-a7f7-5f2058f3c586	SE008A	3	W	t	CV118	t	2022-08-09 15:20:51.712215	2022-08-09 15:20:51.814533
fb2632b4-c4ee-4495-92cd-fd2b9e02d6f2	SE008A	3	Z	t	CV118	t	2022-08-09 15:20:51.717531	2022-08-09 15:20:51.822014
fd9dd531-4b06-41d5-8847-39e2a5025af2	SE013A	3	A	t	APL09	f	2022-08-09 15:20:51.827356	2022-08-09 15:20:51.827356
9377f671-c912-4af9-9edf-a91e9256f675	SE013A	3	D	t	APL09	f	2022-08-09 15:20:51.832991	2022-08-09 15:20:51.832991
47af29b0-be6f-465b-8d6a-fd01f8a69ccd	SE013A	3	I	t	APL09	f	2022-08-09 15:20:51.838372	2022-08-09 15:20:51.838372
0f754aa9-2ee5-4c5d-9417-0743355cc234	SE013A	3	W	t	APL09	f	2022-08-09 15:20:51.843982	2022-08-09 15:20:51.843982
81445d5d-5d73-4fd1-a2d1-89bc899df6f0	SE013A	3	Z	t	APL09	f	2022-08-09 15:20:51.849305	2022-08-09 15:20:51.849305
eb9de605-e200-4d38-99f9-8b3e341b613f	SE013A	3	A	f	APL09	f	2022-08-09 15:20:51.856309	2022-08-09 15:20:51.856309
9952213b-05af-4dc2-9222-c3c55fa603d6	SE013A	3	D	f	APL09	f	2022-08-09 15:20:51.863521	2022-08-09 15:20:51.863521
23ecf038-7177-428a-b6c0-2c8ea3efc4c7	SE013A	3	I	f	APL09	f	2022-08-09 15:20:51.869219	2022-08-09 15:20:51.869219
410403ac-ae91-496f-80a6-5261637763e4	SE013A	3	W	f	APL09	f	2022-08-09 15:20:51.875598	2022-08-09 15:20:51.875598
7e6f6d9d-b1bd-4139-80d5-5d4a140bd9af	SE013A	3	Z	f	APL09	f	2022-08-09 15:20:51.881608	2022-08-09 15:20:51.881608
da03ca42-09c8-48c5-93da-18827c4eb994	SE013A	3	A	t	APL07	f	2022-08-09 15:20:51.88723	2022-08-09 15:20:51.88723
42dd89f6-3087-4a82-b1da-9f90e2b8e26b	SE013A	3	D	t	APL07	f	2022-08-09 15:20:51.893374	2022-08-09 15:20:51.893374
d3f184e7-650a-4434-88eb-76978dc7447c	SE013A	3	I	t	APL07	f	2022-08-09 15:20:51.900297	2022-08-09 15:20:51.900297
f857a693-194f-42d7-9988-308ec707d420	SE013A	3	W	t	APL07	f	2022-08-09 15:20:51.908044	2022-08-09 15:20:51.908044
4345f541-cb90-4314-bb71-48f61f786824	SE013A	3	Z	t	APL07	f	2022-08-09 15:20:51.913668	2022-08-09 15:20:51.913668
b3ec10b5-d5df-430e-9532-1f79f8c697d3	SE013A	3	A	f	APL07	f	2022-08-09 15:20:51.919127	2022-08-09 15:20:51.919127
d2f31492-8b85-45ed-be54-c0416c045f85	SE013A	3	D	f	APL07	f	2022-08-09 15:20:51.924654	2022-08-09 15:20:51.924654
3b821da4-9047-4003-8012-b9df19511b1b	SE013A	3	I	f	APL07	f	2022-08-09 15:20:51.930256	2022-08-09 15:20:51.930256
445bc9b1-74cd-471f-b2ca-72908105d90f	SE013A	3	W	f	APL07	f	2022-08-09 15:20:51.936592	2022-08-09 15:20:51.936592
61f6ed9e-c6d3-4989-ad40-78064b870c6d	SE013A	3	Z	f	APL07	f	2022-08-09 15:20:51.943417	2022-08-09 15:20:51.943417
71f4cb6b-ee2a-4580-a57c-22644b44516a	SE013A	3	A	t	APL11	f	2022-08-09 15:20:51.948852	2022-08-09 15:20:51.948852
c2bf7c56-95e5-4bb5-9d44-30b62bded629	SE013A	3	D	t	APL11	f	2022-08-09 15:20:51.954501	2022-08-09 15:20:51.954501
8f9f8708-f8cd-4834-9651-4f3b57a00a7a	SE013A	3	I	t	APL11	f	2022-08-09 15:20:51.959778	2022-08-09 15:20:51.959778
e69ec213-fba3-4044-aa5d-99a9e2948828	SE013A	3	W	t	APL11	f	2022-08-09 15:20:51.965272	2022-08-09 15:20:51.965272
2d877324-dc6f-4392-90fc-fb2a6bd6f695	SE013A	3	Z	t	APL11	f	2022-08-09 15:20:51.971145	2022-08-09 15:20:51.971145
ad2caa77-7a8c-4781-9218-745bb746e26c	SE013A	3	A	f	APL11	f	2022-08-09 15:20:51.976807	2022-08-09 15:20:51.976807
7ac3096b-e7b3-45ef-a95a-d728a3b70b69	SE013A	3	D	f	APL11	f	2022-08-09 15:20:51.982498	2022-08-09 15:20:51.982498
aca4f23c-4a88-40e0-b7ca-7e25300fd615	SE013A	3	I	f	APL11	f	2022-08-09 15:20:51.988333	2022-08-09 15:20:51.988333
e5be9dfd-7c12-461e-8ab8-3d66ab8a2b52	SE013A	3	W	f	APL11	f	2022-08-09 15:20:51.993995	2022-08-09 15:20:51.993995
5adf8273-90a2-4374-98d1-d2406ed4c097	SE013A	3	Z	f	APL11	f	2022-08-09 15:20:51.999907	2022-08-09 15:20:51.999907
55a5b0f0-6d30-41a5-957a-aaf3690adf52	SE013A	3	A	t	APL13	f	2022-08-09 15:20:52.005378	2022-08-09 15:20:52.005378
2e09d2e7-0ffe-4322-a77a-47db5b3ef3d0	SE013A	3	D	t	APL13	f	2022-08-09 15:20:52.010761	2022-08-09 15:20:52.010761
f2d0405d-f82a-4172-b5e9-abbbe3fe0b9d	SE013A	3	I	t	APL13	f	2022-08-09 15:20:52.017008	2022-08-09 15:20:52.017008
a551f03b-c679-4992-a1d9-02a446f28ed7	SE013A	3	W	t	APL13	f	2022-08-09 15:20:52.023167	2022-08-09 15:20:52.023167
4accc7aa-2e1e-47d7-9f0a-24cfbaeea5dd	SE013A	3	Z	t	APL13	f	2022-08-09 15:20:52.028589	2022-08-09 15:20:52.028589
f128822a-2051-42ee-8bed-ffaed00136a6	SE013A	3	A	f	APL13	f	2022-08-09 15:20:52.034606	2022-08-09 15:20:52.034606
740fb682-8a78-432d-b319-7ff97d897edc	SE013A	3	D	f	APL13	f	2022-08-09 15:20:52.039958	2022-08-09 15:20:52.039958
ef2fa4f3-cbe1-4818-b91f-ddaec94ba037	SE013A	3	I	f	APL13	f	2022-08-09 15:20:52.04532	2022-08-09 15:20:52.04532
91ad5568-8d24-40e0-9a09-d83b1755c221	SE013A	3	W	f	APL13	f	2022-08-09 15:20:52.050998	2022-08-09 15:20:52.050998
3d57bae5-e39f-4c53-88d2-e4cd9f8c9c80	SE013A	3	Z	f	APL13	f	2022-08-09 15:20:52.056432	2022-08-09 15:20:52.056432
a72712c4-e00c-461e-b213-12b4cf6e04ee	SE013A	3	A	t	APL15	f	2022-08-09 15:20:52.061595	2022-08-09 15:20:52.061595
3d35af86-40d1-4c4d-9b69-bad77d15c932	SE013A	3	D	t	APL15	f	2022-08-09 15:20:52.067472	2022-08-09 15:20:52.067472
fcd27ac9-64d8-4106-a6af-a9572021e476	SE013A	3	I	t	APL15	f	2022-08-09 15:20:52.072767	2022-08-09 15:20:52.072767
c33ec7a4-29ca-48e7-8924-88ec2bb9e825	SE013A	3	W	t	APL15	f	2022-08-09 15:20:52.078477	2022-08-09 15:20:52.078477
503da3c3-b6de-4dd6-853c-b50ac2be01c4	SE013A	3	Z	t	APL15	f	2022-08-09 15:20:52.086331	2022-08-09 15:20:52.086331
004f0205-505d-4970-b5b9-40158efdac91	SE013A	3	A	f	APL15	f	2022-08-09 15:20:52.093607	2022-08-09 15:20:52.093607
3a215d3c-db04-4903-8b84-0ba7efe8d18b	SE013A	3	D	f	APL15	f	2022-08-09 15:20:52.099779	2022-08-09 15:20:52.099779
9a6347fa-591e-481d-a8ee-cb9dc42335f1	SE013A	3	I	f	APL15	f	2022-08-09 15:20:52.105608	2022-08-09 15:20:52.105608
bb5b335e-b220-488d-a018-43c09ed35f85	SE013A	3	W	f	APL15	f	2022-08-09 15:20:52.111757	2022-08-09 15:20:52.111757
62e437a4-1531-47c8-a79c-a74a836879d3	SE013A	3	Z	f	APL15	f	2022-08-09 15:20:52.117264	2022-08-09 15:20:52.117264
beaab164-70c3-4ec6-a06e-86c3f46ee4aa	SE013A	3	A	t	APL16	f	2022-08-09 15:20:52.122992	2022-08-09 15:20:52.122992
351bcd78-b65e-4d3d-81d7-59f3a37e065b	SE013A	3	D	t	APL16	f	2022-08-09 15:20:52.128779	2022-08-09 15:20:52.128779
bc98f87a-8921-4fde-a771-45bec2e101e5	SE013A	3	I	t	APL16	f	2022-08-09 15:20:52.134119	2022-08-09 15:20:52.134119
da3d6885-3524-4e78-8180-8f6d1591bb57	SE013A	3	W	t	APL16	f	2022-08-09 15:20:52.139865	2022-08-09 15:20:52.139865
596fc080-a042-4bc8-b17e-7909349390dd	SE013A	3	Z	t	APL16	f	2022-08-09 15:20:52.145201	2022-08-09 15:20:52.145201
51a443ff-ba54-43bc-a4e7-e2bd7316d6cb	SE013A	3	A	f	APL16	f	2022-08-09 15:20:52.150914	2022-08-09 15:20:52.150914
ee0525f6-d062-41b4-9700-3358581dcd91	SE013A	3	D	f	APL16	f	2022-08-09 15:20:52.156235	2022-08-09 15:20:52.156235
fc58b398-a065-40d6-b7ce-f27197241b5a	SE013A	3	I	f	APL16	f	2022-08-09 15:20:52.161822	2022-08-09 15:20:52.161822
46bf4e70-d7d7-4e0b-846f-d472e96879ef	SE013A	3	W	f	APL16	f	2022-08-09 15:20:52.167638	2022-08-09 15:20:52.167638
8fcc56ab-3bf2-4c16-9218-110400e8935e	SE013A	3	Z	f	APL16	f	2022-08-09 15:20:52.173234	2022-08-09 15:20:52.173234
7f0106f7-0506-4916-9bf9-fbf13deb86ec	SE013A	3	A	t	APL18	f	2022-08-09 15:20:52.179208	2022-08-09 15:20:52.179208
5c926e66-0ef1-496b-a7a1-28f5adc46619	SE013A	3	D	t	APL18	f	2022-08-09 15:20:52.18451	2022-08-09 15:20:52.18451
5e9051a3-91bc-4aac-9ac3-1053759d0b3d	SE013A	3	I	t	APL18	f	2022-08-09 15:20:52.190673	2022-08-09 15:20:52.190673
feb24a29-6552-42e9-b46b-698aa7a37695	SE013A	3	W	t	APL18	f	2022-08-09 15:20:52.196107	2022-08-09 15:20:52.196107
a0f7b276-81cb-478d-9c2a-e978192a950d	SE013A	3	Z	t	APL18	f	2022-08-09 15:20:52.201616	2022-08-09 15:20:52.201616
f0355591-012d-4b55-bba7-78a2882dfe1e	SE013A	3	A	f	APL18	f	2022-08-09 15:20:52.207051	2022-08-09 15:20:52.207051
e649770a-a7d6-46da-8cf8-8b2b6ebb4b54	SE013A	3	D	f	APL18	f	2022-08-09 15:20:52.212447	2022-08-09 15:20:52.212447
b6e16203-a497-497f-9514-e8ee2afe6093	SE013A	3	I	f	APL18	f	2022-08-09 15:20:52.21809	2022-08-09 15:20:52.21809
0807c488-4bef-4b8e-8d25-d97557486322	SE013A	3	W	f	APL18	f	2022-08-09 15:20:52.223389	2022-08-09 15:20:52.223389
6234c8df-2583-4acb-98a3-8ed3f1ea60e1	SE013A	3	Z	f	APL18	f	2022-08-09 15:20:52.229087	2022-08-09 15:20:52.229087
e785d733-b711-41e4-9ef1-5895658cd3d0	SE013A	3	A	t	APL20	f	2022-08-09 15:20:52.235434	2022-08-09 15:20:52.235434
eadec80b-3cac-4800-856c-ec10de98d8eb	SE013A	3	D	t	APL20	f	2022-08-09 15:20:52.240685	2022-08-09 15:20:52.240685
0358e15a-a2df-4ed8-ba8a-6597a28c35c5	SE013A	3	I	t	APL20	f	2022-08-09 15:20:52.246378	2022-08-09 15:20:52.246378
44ed6867-e551-4f94-ab0a-138ef7fbb869	SE013A	3	W	t	APL20	f	2022-08-09 15:20:52.251568	2022-08-09 15:20:52.251568
827d2c34-b1c1-47d0-b11a-06bc31a30354	SE013A	3	Z	t	APL20	f	2022-08-09 15:20:52.256747	2022-08-09 15:20:52.256747
b86a9d22-1641-4fef-a24c-4bf35f697e49	SE013A	3	A	f	APL20	f	2022-08-09 15:20:52.262447	2022-08-09 15:20:52.262447
edbfe28b-a9be-48f4-a1b5-dce58fef638e	SE013A	3	D	f	APL20	f	2022-08-09 15:20:52.268059	2022-08-09 15:20:52.268059
25ea5946-f61e-4997-83f0-9c5fe93b3a2b	SE013A	3	I	f	APL20	f	2022-08-09 15:20:52.273516	2022-08-09 15:20:52.273516
abfcdfe3-8455-4a20-82d3-d45ab062a09a	SE013A	3	W	f	APL20	f	2022-08-09 15:20:52.278886	2022-08-09 15:20:52.278886
9aa9ae12-a69e-4d39-a7fd-833a494efdbf	SE013A	3	Z	f	APL20	f	2022-08-09 15:20:52.284186	2022-08-09 15:20:52.284186
1107dd9f-f340-456c-b351-64e31ce362c6	SE013A	3	A	t	APL22	f	2022-08-09 15:20:52.289862	2022-08-09 15:20:52.289862
8cfd3aa5-8293-48d2-ab50-22e548c46476	SE013A	3	D	t	APL22	f	2022-08-09 15:20:52.295398	2022-08-09 15:20:52.295398
6c0654a9-25fd-4d4b-84bf-96eccc4e00ec	SE013A	3	I	t	APL22	f	2022-08-09 15:20:52.301743	2022-08-09 15:20:52.301743
5c81d8e0-75b3-4479-9df1-e4ea1cb5cda4	SE013A	3	W	t	APL22	f	2022-08-09 15:20:52.307161	2022-08-09 15:20:52.307161
fe616ab7-6756-4651-9ace-34819ad7f185	SE013A	3	Z	t	APL22	f	2022-08-09 15:20:52.312563	2022-08-09 15:20:52.312563
d6a9c7dd-fdda-4db1-b9a4-a8956fcf8c42	SE013A	3	A	f	APL22	f	2022-08-09 15:20:52.318068	2022-08-09 15:20:52.318068
3e597f2c-37bf-4eb6-9f3d-9e6cb18d24cb	SE013A	3	D	f	APL22	f	2022-08-09 15:20:52.323565	2022-08-09 15:20:52.323565
838690c6-8575-4509-9dbf-dfc8be0ecf39	SE013A	3	I	f	APL22	f	2022-08-09 15:20:52.329372	2022-08-09 15:20:52.329372
f47bf0a5-b38e-4e62-a4b2-87aeead59825	SE013A	3	W	f	APL22	f	2022-08-09 15:20:52.335015	2022-08-09 15:20:52.335015
b53195c9-9e56-4f23-950c-912e9d363985	SE013A	3	Z	f	APL22	f	2022-08-09 15:20:52.340351	2022-08-09 15:20:52.340351
c0153ca5-5c61-49eb-88dd-79ca4ca2657d	SE013A	3	A	t	APL27	f	2022-08-09 15:20:52.345679	2022-08-09 15:20:52.345679
58f4c266-772e-4789-8a85-6eb43efb8aac	SE013A	3	D	t	APL27	f	2022-08-09 15:20:52.352517	2022-08-09 15:20:52.352517
c8193394-049f-42dd-9f55-4ad52f6646f8	SE013A	3	I	t	APL27	f	2022-08-09 15:20:52.35906	2022-08-09 15:20:52.35906
437f90bb-d839-44ad-b20c-b9c23a4e5083	SE013A	3	W	t	APL27	f	2022-08-09 15:20:52.365961	2022-08-09 15:20:52.365961
d24da448-6cf3-409b-8972-bc32357e9644	SE013A	3	Z	t	APL27	f	2022-08-09 15:20:52.371734	2022-08-09 15:20:52.371734
8f9d7d0f-12e3-4441-a763-3efc79187109	SE013A	3	A	f	APL27	f	2022-08-09 15:20:52.377894	2022-08-09 15:20:52.377894
f48f37d6-8227-4783-bea1-7cfdce437633	SE013A	3	D	f	APL27	f	2022-08-09 15:20:52.383702	2022-08-09 15:20:52.383702
855b5313-5128-45f0-8e1c-87d10af74f39	SE013A	3	I	f	APL27	f	2022-08-09 15:20:52.388951	2022-08-09 15:20:52.388951
26822b83-c6da-4d9a-8c0f-c4eee2f74ac5	SE013A	3	W	f	APL27	f	2022-08-09 15:20:52.395077	2022-08-09 15:20:52.395077
1c18efea-e998-4699-8270-c18c79800006	SE013A	3	Z	f	APL27	f	2022-08-09 15:20:52.400474	2022-08-09 15:20:52.400474
f4729a86-9d24-40ab-ab3d-71b922ecd288	SE013A	3	A	t	APL29	f	2022-08-09 15:20:52.406338	2022-08-09 15:20:52.406338
c2d4c188-1d36-4c53-9a8c-637ffcb0cdf5	SE013A	3	D	t	APL29	f	2022-08-09 15:20:52.412864	2022-08-09 15:20:52.412864
47035d0e-5fb2-4e37-9926-1570f3ffdc30	SE013A	3	I	t	APL29	f	2022-08-09 15:20:52.419119	2022-08-09 15:20:52.419119
cb950dff-7990-4983-b67a-030db4856d5c	SE013A	3	W	t	APL29	f	2022-08-09 15:20:52.427266	2022-08-09 15:20:52.427266
c9335cf3-d21d-47d1-b505-9f5e0b1d8c08	SE013A	3	Z	t	APL29	f	2022-08-09 15:20:52.433945	2022-08-09 15:20:52.433945
63c99b8e-7974-4581-827e-892083e192c3	SE013A	3	A	f	APL29	f	2022-08-09 15:20:52.43966	2022-08-09 15:20:52.43966
9a51aa85-9e93-4014-a2b6-ef8db5993b0b	SE013A	3	D	f	APL29	f	2022-08-09 15:20:52.445371	2022-08-09 15:20:52.445371
dcd16719-c453-41b6-a5a8-7d80243a9d45	SE013A	3	I	f	APL29	f	2022-08-09 15:20:52.450869	2022-08-09 15:20:52.450869
5c29bc4e-a0df-4170-9628-8ababf5159c1	SE013A	3	W	f	APL29	f	2022-08-09 15:20:52.45677	2022-08-09 15:20:52.45677
b7854daa-70f7-4020-b19f-af276c755a7d	SE013A	3	Z	f	APL29	f	2022-08-09 15:20:52.462224	2022-08-09 15:20:52.462224
fed4162b-1d7f-46f1-ab58-513fb75f1ee0	SE013A	3	A	t	APL31	f	2022-08-09 15:20:52.467922	2022-08-09 15:20:52.467922
f571d3bf-1a24-41cd-9cda-27c634d154c7	SE013A	3	D	t	APL31	f	2022-08-09 15:20:52.47342	2022-08-09 15:20:52.47342
ebd853fc-28f5-4f42-b56a-198ce6f88609	SE013A	3	I	t	APL31	f	2022-08-09 15:20:52.479103	2022-08-09 15:20:52.479103
c0e0963b-6188-4219-8cd9-945834a88c7a	SE013A	3	W	t	APL31	f	2022-08-09 15:20:52.484821	2022-08-09 15:20:52.484821
9a7e9133-679f-4cab-aa6c-50eaea041efd	SE013A	3	Z	t	APL31	f	2022-08-09 15:20:52.490817	2022-08-09 15:20:52.490817
12a3acfb-5db7-48ef-8922-a15d1cd2fda8	SE013A	3	A	f	APL31	f	2022-08-09 15:20:52.496322	2022-08-09 15:20:52.496322
17d0dd9e-7f37-4d0a-b770-f127ae05b5d9	SE013A	3	D	f	APL31	f	2022-08-09 15:20:52.502295	2022-08-09 15:20:52.502295
4c757be9-8815-4d30-b7e9-9600983af0f0	SE013A	3	I	f	APL31	f	2022-08-09 15:20:52.507621	2022-08-09 15:20:52.507621
e7da83b6-da61-4e8d-a8c8-a9ed8050c32e	SE013A	3	W	f	APL31	f	2022-08-09 15:20:52.513227	2022-08-09 15:20:52.513227
590d3404-0703-4790-a66e-2d052349936d	SE013A	3	Z	f	APL31	f	2022-08-09 15:20:52.518826	2022-08-09 15:20:52.518826
b188d257-2b10-4c2f-8805-85d4cbbdfb6a	SE013A	3	A	t	APL48	f	2022-08-09 15:20:52.524662	2022-08-09 15:20:52.524662
aa99178e-13a4-4ac8-9c71-15ffd09e521f	SE013A	3	D	t	APL48	f	2022-08-09 15:20:52.530089	2022-08-09 15:20:52.530089
e572a0f0-c11a-4f02-a297-f667a43d8f96	SE013A	3	I	t	APL48	f	2022-08-09 15:20:52.535374	2022-08-09 15:20:52.535374
d6d54511-12df-4d2d-9628-03257ce7e422	SE013A	3	W	t	APL48	f	2022-08-09 15:20:52.540983	2022-08-09 15:20:52.540983
2796657d-d0e7-4b95-9a7d-16a5182d524e	SE013A	3	Z	t	APL48	f	2022-08-09 15:20:52.546422	2022-08-09 15:20:52.546422
1acc5dff-87a5-4667-9965-8b4a4ef09f9a	SE013A	3	A	f	APL48	f	2022-08-09 15:20:52.551739	2022-08-09 15:20:52.551739
c947f003-5f77-4e01-b30a-9c26bc47652a	SE013A	3	D	f	APL48	f	2022-08-09 15:20:52.557295	2022-08-09 15:20:52.557295
142905dd-158f-458f-b82f-e2a49856ff12	SE013A	3	I	f	APL48	f	2022-08-09 15:20:52.562579	2022-08-09 15:20:52.562579
652c111e-d7e0-49c2-b662-22e60ac8440c	SE013A	3	W	f	APL48	f	2022-08-09 15:20:52.568093	2022-08-09 15:20:52.568093
cb735396-ec17-4254-bfb7-b93b91769773	SE013A	3	Z	f	APL48	f	2022-08-09 15:20:52.573407	2022-08-09 15:20:52.573407
50823a7c-4a20-4d37-ad23-10f65db4bb4e	SE013A	3	A	t	APL49	f	2022-08-09 15:20:52.57867	2022-08-09 15:20:52.57867
497f2406-d76f-4a7e-a9ac-8642b3b4c52e	SE013A	3	D	t	APL49	f	2022-08-09 15:20:52.584378	2022-08-09 15:20:52.584378
ce688673-bf62-4353-a3a0-61d2f93925a0	SE013A	3	I	t	APL49	f	2022-08-09 15:20:52.589796	2022-08-09 15:20:52.589796
fe425af8-98fa-46a3-82d6-6796831bbe23	SE013A	3	W	t	APL49	f	2022-08-09 15:20:52.595549	2022-08-09 15:20:52.595549
bdd12936-e189-48e1-af35-d9f1f683bb9f	SE013A	3	Z	t	APL49	f	2022-08-09 15:20:52.600931	2022-08-09 15:20:52.600931
ab5c431f-9526-4be8-af19-7703bad8f20b	SE013A	3	A	f	APL49	f	2022-08-09 15:20:52.606336	2022-08-09 15:20:52.606336
0348b38b-fe82-46b2-9a3b-a8ffc25de121	SE013A	3	D	f	APL49	f	2022-08-09 15:20:52.612252	2022-08-09 15:20:52.612252
993503b3-0330-456f-acfe-c708186a7fd9	SE013A	3	I	f	APL49	f	2022-08-09 15:20:52.617567	2022-08-09 15:20:52.617567
785e301c-e384-45b2-9957-f1ac2075f4c7	SE013A	3	W	f	APL49	f	2022-08-09 15:20:52.623179	2022-08-09 15:20:52.623179
f9fff75c-cbb1-495f-9277-8344bfab8a10	SE013A	3	Z	f	APL49	f	2022-08-09 15:20:52.62849	2022-08-09 15:20:52.62849
5a7c4ae4-1186-438b-be24-f4ab121bf365	SE013A	3	A	t	APL50	f	2022-08-09 15:20:52.633684	2022-08-09 15:20:52.633684
3fe82b3d-866f-4f04-9442-769d52326bff	SE013A	3	D	t	APL50	f	2022-08-09 15:20:52.639838	2022-08-09 15:20:52.639838
35555350-42bb-4c67-a097-0cd917e79d3c	SE013A	3	I	t	APL50	f	2022-08-09 15:20:52.645333	2022-08-09 15:20:52.645333
89e6e354-1aac-40e8-bae0-b0908e7e9a50	SE013A	3	W	t	APL50	f	2022-08-09 15:20:52.650709	2022-08-09 15:20:52.650709
98f04d13-eebd-41d6-92d7-e4e946d34826	SE013A	3	Z	t	APL50	f	2022-08-09 15:20:52.656446	2022-08-09 15:20:52.656446
8af48704-0d5d-4d0c-8539-af6a986973b3	SE013A	3	A	f	APL50	f	2022-08-09 15:20:52.66185	2022-08-09 15:20:52.66185
c505d3bf-99ad-45ef-bde0-1c69bb6e93e8	SE013A	3	D	f	APL50	f	2022-08-09 15:20:52.667171	2022-08-09 15:20:52.667171
b73dd350-103f-4b2d-8113-cbe6b73984e8	SE013A	3	I	f	APL50	f	2022-08-09 15:20:52.672907	2022-08-09 15:20:52.672907
b8e74369-3d44-4bd8-8799-de278cbbbe1f	SE013A	3	W	f	APL50	f	2022-08-09 15:20:52.678161	2022-08-09 15:20:52.678161
6b2d4ade-9809-4176-963f-f7c712031c4c	SE013A	3	Z	f	APL50	f	2022-08-09 15:20:52.683394	2022-08-09 15:20:52.683394
afbe298a-6174-47f3-bd97-6cb717e70c30	SE013A	3	A	t	APL51	f	2022-08-09 15:20:52.689715	2022-08-09 15:20:52.689715
17e49731-5dc6-4ba2-adbb-3641a49e5ef7	SE013A	3	D	t	APL51	f	2022-08-09 15:20:52.695767	2022-08-09 15:20:52.695767
e6caec1f-dbb4-4d3e-96e1-8e710140ed4d	SE013A	3	I	t	APL51	f	2022-08-09 15:20:52.701698	2022-08-09 15:20:52.701698
aedb7937-be4a-4409-a808-090e06019896	SE013A	3	W	t	APL51	f	2022-08-09 15:20:52.707117	2022-08-09 15:20:52.707117
de358f95-4bbf-4a05-ac72-6feabbb27a2e	SE013A	3	Z	t	APL51	f	2022-08-09 15:20:52.712674	2022-08-09 15:20:52.712674
1802b0f6-dfbf-43c3-8cd2-e66a55bbf7ee	SE013A	3	A	f	APL51	f	2022-08-09 15:20:52.718104	2022-08-09 15:20:52.718104
354e0f93-707c-4814-90bf-a939b8c7735d	SE013A	3	D	f	APL51	f	2022-08-09 15:20:52.724823	2022-08-09 15:20:52.724823
4b3d9f2e-86b1-476d-96a1-a702b3eb2eec	SE013A	3	I	f	APL51	f	2022-08-09 15:20:52.731706	2022-08-09 15:20:52.731706
f317860b-5daf-45b0-a8e9-2f9124801774	SE013A	3	W	f	APL51	f	2022-08-09 15:20:52.738525	2022-08-09 15:20:52.738525
bd485e61-c9f7-41de-9578-a48cbf65b2ef	SE013A	3	Z	f	APL51	f	2022-08-09 15:20:52.745428	2022-08-09 15:20:52.745428
af383677-f4db-4174-a43b-86cb025b9d5b	SE013A	3	A	t	APL52	f	2022-08-09 15:20:52.75268	2022-08-09 15:20:52.75268
a4e6b2e1-7ced-4b30-ae94-d4834e10dc14	SE013A	3	D	t	APL52	f	2022-08-09 15:20:52.75877	2022-08-09 15:20:52.75877
ac73d8c9-b861-4b48-9ee3-c30c6c307a76	SE013A	3	I	t	APL52	f	2022-08-09 15:20:52.764204	2022-08-09 15:20:52.764204
bba496d2-4e93-45df-a4fa-d8b919ba11cd	SE013A	3	W	t	APL52	f	2022-08-09 15:20:52.769876	2022-08-09 15:20:52.769876
4a61c76b-ac45-47a9-b151-6ae31c5f5f2e	SE013A	3	Z	t	APL52	f	2022-08-09 15:20:52.775272	2022-08-09 15:20:52.775272
81aa37a5-1a05-422c-a389-761a0fae5108	SE013A	3	A	f	APL52	f	2022-08-09 15:20:52.781326	2022-08-09 15:20:52.781326
201ef2da-6ea8-4104-83ef-1388749a7f31	SE013A	3	D	f	APL52	f	2022-08-09 15:20:52.78746	2022-08-09 15:20:52.78746
f8239a3c-29b7-4b4b-8525-601f8920e659	SE013A	3	I	f	APL52	f	2022-08-09 15:20:52.792905	2022-08-09 15:20:52.792905
2ca15c43-923f-412d-ad67-54210fa269f4	SE013A	3	W	f	APL52	f	2022-08-09 15:20:52.798655	2022-08-09 15:20:52.798655
26c8160d-8410-45f4-9bdf-a88514af819b	SE013A	3	Z	f	APL52	f	2022-08-09 15:20:52.803968	2022-08-09 15:20:52.803968
290f126d-145d-4068-bd37-ff3bb7049a2c	SE013A	3	A	t	APL53	f	2022-08-09 15:20:52.809745	2022-08-09 15:20:52.809745
939f204c-12e0-4089-a7fe-3a51df9720be	SE013A	3	D	t	APL53	f	2022-08-09 15:20:52.815339	2022-08-09 15:20:52.815339
ea4daea6-309d-461b-a391-e492914ff644	SE013A	3	I	t	APL53	f	2022-08-09 15:20:52.820962	2022-08-09 15:20:52.820962
24980aae-b1eb-49a2-a189-4a5e017c36db	SE013A	3	W	t	APL53	f	2022-08-09 15:20:52.826444	2022-08-09 15:20:52.826444
33652f06-07d1-4f4d-aa82-4c2ca0ee0830	SE013A	3	Z	t	APL53	f	2022-08-09 15:20:52.832068	2022-08-09 15:20:52.832068
b0b2a876-eba2-4b34-afe2-9a959a562cdb	SE013A	3	A	f	APL53	f	2022-08-09 15:20:52.837451	2022-08-09 15:20:52.837451
6f56e798-d417-477c-9753-e38a226f8a5a	SE013A	3	D	f	APL53	f	2022-08-09 15:20:52.843574	2022-08-09 15:20:52.843574
94e66dd1-1f55-43a5-81fe-7c01d0631075	SE013A	3	I	f	APL53	f	2022-08-09 15:20:52.849352	2022-08-09 15:20:52.849352
0219dd88-71da-4200-954d-f33e11e0b182	SE013A	3	W	f	APL53	f	2022-08-09 15:20:52.854798	2022-08-09 15:20:52.854798
dabbc029-7c95-40dd-982f-cd32781e0d4f	SE013A	3	Z	f	APL53	f	2022-08-09 15:20:52.860445	2022-08-09 15:20:52.860445
e5f7631e-cc5e-4751-809d-9794cc00a6fb	SE013A	3	A	t	APL54	f	2022-08-09 15:20:52.865963	2022-08-09 15:20:52.865963
62f80a8e-2292-443a-a6d1-4b65a4279b46	SE013A	3	D	t	APL54	f	2022-08-09 15:20:52.871601	2022-08-09 15:20:52.871601
43f2a4c8-d4b8-4398-8320-74c49ea93123	SE013A	3	I	t	APL54	f	2022-08-09 15:20:52.877136	2022-08-09 15:20:52.877136
115322d7-e957-47f4-aadc-ea035cd1fef8	SE013A	3	W	t	APL54	f	2022-08-09 15:20:52.882372	2022-08-09 15:20:52.882372
0baed3db-882e-4448-ba55-e42c047b16b2	SE013A	3	Z	t	APL54	f	2022-08-09 15:20:52.888003	2022-08-09 15:20:52.888003
5ea5a9b1-9b1a-4d67-bd8f-8c12f6c74adf	SE013A	3	A	f	APL54	f	2022-08-09 15:20:52.893401	2022-08-09 15:20:52.893401
f2219609-6c9e-4c9e-8b25-d84bf53483a4	SE013A	3	D	f	APL54	f	2022-08-09 15:20:52.898628	2022-08-09 15:20:52.898628
2d1e4ab9-3487-4802-835c-1fcf3004201f	SE013A	3	I	f	APL54	f	2022-08-09 15:20:52.904125	2022-08-09 15:20:52.904125
3e0e1471-42e1-43cf-8d7e-74898caffa31	SE013A	3	W	f	APL54	f	2022-08-09 15:20:52.909589	2022-08-09 15:20:52.909589
64271c64-398f-4a68-9cfa-688967bc7569	SE013A	3	Z	f	APL54	f	2022-08-09 15:20:52.915203	2022-08-09 15:20:52.915203
33ecf458-a2e2-439b-a8f9-ebf041a1a240	SE013A	3	A	t	APL55	f	2022-08-09 15:20:52.920576	2022-08-09 15:20:52.920576
02767eed-95b1-4627-a5d9-6583334b9b33	SE013A	3	D	t	APL55	f	2022-08-09 15:20:52.925889	2022-08-09 15:20:52.925889
89963966-b3af-44f8-8518-7028fa01cdf0	SE013A	3	I	t	APL55	f	2022-08-09 15:20:52.932132	2022-08-09 15:20:52.932132
bdfb414d-12e0-4f7a-9111-2022d873f834	SE013A	3	W	t	APL55	f	2022-08-09 15:20:52.937617	2022-08-09 15:20:52.937617
29e0387b-2b1d-44a2-bc6a-dd03cc4de5bb	SE013A	3	Z	t	APL55	f	2022-08-09 15:20:52.943435	2022-08-09 15:20:52.943435
7e160d56-58e3-48c4-8bbb-fa75a8317550	SE013A	3	A	f	APL55	f	2022-08-09 15:20:52.948753	2022-08-09 15:20:52.948753
c535401d-a732-4c0b-8458-5bd15a063fa7	SE013A	3	D	f	APL55	f	2022-08-09 15:20:52.954156	2022-08-09 15:20:52.954156
a9a29c30-366f-4655-8a15-8dc595041f50	SE013A	3	I	f	APL55	f	2022-08-09 15:20:52.959892	2022-08-09 15:20:52.959892
1b281fad-d5cb-4838-8f86-7462b719bf37	SE013A	3	W	f	APL55	f	2022-08-09 15:20:52.965269	2022-08-09 15:20:52.965269
87fc3a0a-8ea7-4084-8d0b-bea93f21946c	SE013A	3	Z	f	APL55	f	2022-08-09 15:20:52.970568	2022-08-09 15:20:52.970568
63b463b1-13ee-4a40-92f9-b3a1252ea9ca	SE013A	3	A	t	APL56	f	2022-08-09 15:20:52.976172	2022-08-09 15:20:52.976172
a194bb6b-e574-4a80-9c8f-d4773fabd443	SE013A	3	D	t	APL56	f	2022-08-09 15:20:52.981632	2022-08-09 15:20:52.981632
348609c3-9546-42e8-ad34-425535b5b866	SE013A	3	I	t	APL56	f	2022-08-09 15:20:52.987138	2022-08-09 15:20:52.987138
eb90e99d-56a3-4fea-9a40-15cde5c65ecf	SE013A	3	W	t	APL56	f	2022-08-09 15:20:52.992865	2022-08-09 15:20:52.992865
7e5835ed-105f-4027-811a-999ab44dd4bf	SE013A	3	Z	t	APL56	f	2022-08-09 15:20:52.998449	2022-08-09 15:20:52.998449
902a8ad1-afd3-4f5d-8511-2f70a48da1da	SE013A	3	A	f	APL56	f	2022-08-09 15:20:53.003889	2022-08-09 15:20:53.003889
05976b70-3da1-4fbc-8222-01f4f5c95f3b	SE013A	3	D	f	APL56	f	2022-08-09 15:20:53.009536	2022-08-09 15:20:53.009536
7266e293-7b2f-48fa-b003-3caf2b887847	SE013A	3	I	f	APL56	f	2022-08-09 15:20:53.01486	2022-08-09 15:20:53.01486
daf3aa22-820d-48bb-a547-53476d85ebae	SE013A	3	W	f	APL56	f	2022-08-09 15:20:53.020816	2022-08-09 15:20:53.020816
833d923d-9959-4c27-9f69-75e73295a911	SE013A	3	Z	f	APL56	f	2022-08-09 15:20:53.026576	2022-08-09 15:20:53.026576
25803090-061d-4192-bba8-5424ce36a94f	SE013A	3	A	t	APL57	f	2022-08-09 15:20:53.032041	2022-08-09 15:20:53.032041
4503c632-bdcb-4e35-8dbf-85ec63264bed	SE013A	3	D	t	APL57	f	2022-08-09 15:20:53.037781	2022-08-09 15:20:53.037781
746b7c40-6dac-4e55-8925-5d8fad5274b7	SE013A	3	I	t	APL57	f	2022-08-09 15:20:53.043048	2022-08-09 15:20:53.043048
8d223e0e-e63e-4b10-97ce-24ef5f30df03	SE013A	3	W	t	APL57	f	2022-08-09 15:20:53.048694	2022-08-09 15:20:53.048694
7e4fa176-9c7f-497e-a948-114750db361e	SE013A	3	Z	t	APL57	f	2022-08-09 15:20:53.054086	2022-08-09 15:20:53.054086
72ff4ed4-f487-46bc-8210-4bde21293a55	SE013A	3	A	f	APL57	f	2022-08-09 15:20:53.059714	2022-08-09 15:20:53.059714
4ec8bada-80fe-4ed6-9a5b-f596e25fda1e	SE013A	3	D	f	APL57	f	2022-08-09 15:20:53.065256	2022-08-09 15:20:53.065256
29e22ae2-026b-4140-a686-023ccfe4403e	SE013A	3	I	f	APL57	f	2022-08-09 15:20:53.070656	2022-08-09 15:20:53.070656
0e3db23f-5e85-46ea-8414-ffac20074a7e	SE013A	3	W	f	APL57	f	2022-08-09 15:20:53.078285	2022-08-09 15:20:53.078285
dc7435f0-8f44-4ae4-8a95-b971c8f39e95	SE013A	3	Z	f	APL57	f	2022-08-09 15:20:53.086622	2022-08-09 15:20:53.086622
704d1a66-6c92-434d-97ce-ac7e820fac6d	SE013A	3	A	t	APL65	f	2022-08-09 15:20:53.092797	2022-08-09 15:20:53.092797
507edeaf-7842-4c70-897d-b340e0cd593f	SE013A	3	D	t	APL65	f	2022-08-09 15:20:53.098761	2022-08-09 15:20:53.098761
7a8a4e4b-ef05-4c20-8669-e455a3ef79c9	SE013A	3	I	t	APL65	f	2022-08-09 15:20:53.10456	2022-08-09 15:20:53.10456
f4fc4069-c5bf-4bbd-b31d-3738da072cfc	SE013A	3	W	t	APL65	f	2022-08-09 15:20:53.111827	2022-08-09 15:20:53.111827
96d63709-b17c-4008-9b61-ffb398fec781	SE013A	3	Z	t	APL65	f	2022-08-09 15:20:53.117471	2022-08-09 15:20:53.117471
425f6435-19f2-4b7e-8dfc-10266fd6c2a3	SE013A	3	A	f	APL65	f	2022-08-09 15:20:53.123137	2022-08-09 15:20:53.123137
9cca03d1-6c34-42a6-914d-d049375a3f6f	SE013A	3	D	f	APL65	f	2022-08-09 15:20:53.129025	2022-08-09 15:20:53.129025
79aac119-fc7a-4c70-99b4-3ab5b36b0561	SE013A	3	I	f	APL65	f	2022-08-09 15:20:53.134385	2022-08-09 15:20:53.134385
3ad64485-e46a-45e3-89da-f47363c7daff	SE013A	3	W	f	APL65	f	2022-08-09 15:20:53.140064	2022-08-09 15:20:53.140064
d4efba4b-a396-4548-9075-a4bec09b226a	SE013A	3	Z	f	APL65	f	2022-08-09 15:20:53.146151	2022-08-09 15:20:53.146151
078067d2-89ad-41d1-b2c7-f6112b8896d6	SE013A	3	A	t	APL66	f	2022-08-09 15:20:53.151554	2022-08-09 15:20:53.151554
95628f63-a5a9-4124-becd-e776b55719f1	SE013A	3	D	t	APL66	f	2022-08-09 15:20:53.157209	2022-08-09 15:20:53.157209
fa74f929-e40d-428f-a57b-4017337cec47	SE013A	3	I	t	APL66	f	2022-08-09 15:20:53.162573	2022-08-09 15:20:53.162573
0af49815-0cbd-4c80-89d7-a0986c2a692b	SE013A	3	W	t	APL66	f	2022-08-09 15:20:53.168252	2022-08-09 15:20:53.168252
3b4b3872-e15f-441e-8999-5ca75099006c	SE013A	3	Z	t	APL66	f	2022-08-09 15:20:53.17362	2022-08-09 15:20:53.17362
9bdd4aed-8f12-4b17-9126-0fd9b71feafb	SE013A	3	A	f	APL66	f	2022-08-09 15:20:53.179318	2022-08-09 15:20:53.179318
3ff8c4e1-3987-4795-97ae-a02a72bc6a4d	SE013A	3	D	f	APL66	f	2022-08-09 15:20:53.18473	2022-08-09 15:20:53.18473
30b5d607-9dbd-4dfc-bac4-396c837c2f44	SE013A	3	I	f	APL66	f	2022-08-09 15:20:53.190212	2022-08-09 15:20:53.190212
c75504d4-56da-462e-8fba-1df2eaec606d	SE013A	3	W	f	APL66	f	2022-08-09 15:20:53.196119	2022-08-09 15:20:53.196119
b43d38cf-54d3-462b-ba72-d26377a68ee6	SE013A	3	Z	f	APL66	f	2022-08-09 15:20:53.202246	2022-08-09 15:20:53.202246
3f49a3f0-d652-4f94-b0c5-5a4e94957573	SE013A	3	A	t	APL67	f	2022-08-09 15:20:53.207589	2022-08-09 15:20:53.207589
f8648d85-badc-4bf6-b036-ca996e953556	SE013A	3	D	t	APL67	f	2022-08-09 15:20:53.21313	2022-08-09 15:20:53.21313
ecc889e7-b180-41dc-b013-d46793719460	SE013A	3	I	t	APL67	f	2022-08-09 15:20:53.218406	2022-08-09 15:20:53.218406
5bdcaee7-5dc8-4148-ad1c-0a7cdf1aabf4	SE013A	3	W	t	APL67	f	2022-08-09 15:20:53.224001	2022-08-09 15:20:53.224001
64a4c497-d466-47af-8fa0-2d29f107346e	SE013A	3	Z	t	APL67	f	2022-08-09 15:20:53.229289	2022-08-09 15:20:53.229289
c58d912a-087b-451e-9409-91ff7c6137be	SE013A	3	A	f	APL67	f	2022-08-09 15:20:53.235253	2022-08-09 15:20:53.235253
89ee4bdc-584e-4b13-a6c6-05e3424d6123	SE013A	3	D	f	APL67	f	2022-08-09 15:20:53.240661	2022-08-09 15:20:53.240661
24ed272a-1124-46fd-9d18-5aa8f5783b87	SE013A	3	I	f	APL67	f	2022-08-09 15:20:53.246045	2022-08-09 15:20:53.246045
cd799fc4-06ff-4e85-93da-5da601afcd6a	SE013A	3	W	f	APL67	f	2022-08-09 15:20:53.25178	2022-08-09 15:20:53.25178
2fdf218c-3226-4034-bea9-a184bc01fee9	SE013A	3	Z	f	APL67	f	2022-08-09 15:20:53.257224	2022-08-09 15:20:53.257224
5410b2e8-94d1-4637-8a40-cd72a55cec6d	SE013A	3	A	t	APL68	f	2022-08-09 15:20:53.262467	2022-08-09 15:20:53.262467
e3bd8ad5-0302-4c0f-abd5-e127d90a2f88	SE013A	3	D	t	APL68	f	2022-08-09 15:20:53.268156	2022-08-09 15:20:53.268156
15883960-e896-4f26-9e81-99c53cfc3cc1	SE013A	3	I	t	APL68	f	2022-08-09 15:20:53.273333	2022-08-09 15:20:53.273333
3a238edf-a1f5-4c68-a20a-e508eac2be04	SE013A	3	W	t	APL68	f	2022-08-09 15:20:53.278865	2022-08-09 15:20:53.278865
eaa2ae4c-1a3b-4ec3-8a82-1d864a921706	SE013A	3	Z	t	APL68	f	2022-08-09 15:20:53.284208	2022-08-09 15:20:53.284208
1f06f1b9-e89a-4ba7-bef9-57ba9e6d8174	SE013A	3	A	f	APL68	f	2022-08-09 15:20:53.2896	2022-08-09 15:20:53.2896
2f60329d-9439-4a93-8945-6f20a12b3335	SE013A	3	D	f	APL68	f	2022-08-09 15:20:53.295394	2022-08-09 15:20:53.295394
245c3318-13c0-49e5-bb87-da6a5b8e15e6	SE013A	3	I	f	APL68	f	2022-08-09 15:20:53.30079	2022-08-09 15:20:53.30079
1c1a30a7-5d89-4730-a1ea-52c27bec6527	SE013A	3	W	f	APL68	f	2022-08-09 15:20:53.306076	2022-08-09 15:20:53.306076
754ba1b1-5d2f-49a0-ac69-5a05cb57fb66	SE013A	3	Z	f	APL68	f	2022-08-09 15:20:53.311885	2022-08-09 15:20:53.311885
322ae210-a964-458c-a1db-7ee8beebb1bc	SE013A	3	A	t	APL69	f	2022-08-09 15:20:53.317322	2022-08-09 15:20:53.317322
b42773eb-6aa9-4272-82b1-8650511b18a2	SE013A	3	D	t	APL69	f	2022-08-09 15:20:53.322602	2022-08-09 15:20:53.322602
ee8e189f-ef3f-4808-b2ac-9341e1c2b4ff	SE013A	3	I	t	APL69	f	2022-08-09 15:20:53.328399	2022-08-09 15:20:53.328399
21060c33-351a-4130-bfda-904c86dd1761	SE013A	3	W	t	APL69	f	2022-08-09 15:20:53.334787	2022-08-09 15:20:53.334787
f4d9c924-ecde-43b0-815b-7c66d1383168	SE013A	3	Z	t	APL69	f	2022-08-09 15:20:53.340878	2022-08-09 15:20:53.340878
6424a883-2115-4268-b467-08337617b505	SE013A	3	A	f	APL69	f	2022-08-09 15:20:53.347017	2022-08-09 15:20:53.347017
6de7ceb1-92b2-4fa3-a3e8-a8bffb13f1a7	SE013A	3	D	f	APL69	f	2022-08-09 15:20:53.353899	2022-08-09 15:20:53.353899
bccc814a-c0f3-42ac-83bf-440e878e12d6	SE013A	3	I	f	APL69	f	2022-08-09 15:20:53.361455	2022-08-09 15:20:53.361455
aeec0009-7300-408c-8c1b-59d8480788d9	SE013A	3	W	f	APL69	f	2022-08-09 15:20:53.367717	2022-08-09 15:20:53.367717
83051364-4fda-44c8-a779-f91a219ea315	SE013A	3	Z	f	APL69	f	2022-08-09 15:20:53.373521	2022-08-09 15:20:53.373521
5ee24e56-cefb-49fb-a7c3-4724b30bf2fe	SE013A	3	A	t	APL70	f	2022-08-09 15:20:53.380159	2022-08-09 15:20:53.380159
14960878-45dc-4104-bf3c-0771800d66b2	SE013A	3	D	t	APL70	f	2022-08-09 15:20:53.386273	2022-08-09 15:20:53.386273
0ef5cea4-d637-44bd-b21e-5ff46db5cece	SE013A	3	I	t	APL70	f	2022-08-09 15:20:53.391997	2022-08-09 15:20:53.391997
31bf8500-cf2f-434c-af81-d0d270be6926	SE013A	3	W	t	APL70	f	2022-08-09 15:20:53.39774	2022-08-09 15:20:53.39774
292c013b-34b8-4521-b986-0e4d9982f8e0	SE013A	3	Z	t	APL70	f	2022-08-09 15:20:53.403442	2022-08-09 15:20:53.403442
89b6e8ec-80a9-4864-98fa-d01817ff335a	SE013A	3	A	f	APL70	f	2022-08-09 15:20:53.410346	2022-08-09 15:20:53.410346
989c7757-ccaa-499c-abf1-0b084e7a4687	SE013A	3	D	f	APL70	f	2022-08-09 15:20:53.416547	2022-08-09 15:20:53.416547
22ed0732-057a-4e72-8c00-f475664caf98	SE013A	3	I	f	APL70	f	2022-08-09 15:20:53.422126	2022-08-09 15:20:53.422126
0154ecc9-c6a5-4d8a-8c34-e6a50c6ab451	SE013A	3	W	f	APL70	f	2022-08-09 15:20:53.428236	2022-08-09 15:20:53.428236
a8569e90-076a-487d-ab40-cbf4adb39160	SE013A	3	Z	f	APL70	f	2022-08-09 15:20:53.434124	2022-08-09 15:20:53.434124
aab63ca8-f741-4b70-9b94-e4dbdc19f666	SE013A	3	A	t	CV027	f	2022-08-09 15:20:53.439529	2022-08-09 15:20:53.439529
bf0271dc-7197-4fb4-9bed-3963c2f2c323	SE013A	3	D	t	CV027	f	2022-08-09 15:20:53.445414	2022-08-09 15:20:53.445414
d0e0d223-c601-471a-a3ca-f6a56816693d	SE013A	3	I	t	CV027	f	2022-08-09 15:20:53.451044	2022-08-09 15:20:53.451044
f5836898-f879-461e-99c2-e1d17b8cfd24	SE013A	3	W	t	CV027	f	2022-08-09 15:20:53.456656	2022-08-09 15:20:53.456656
7f8d463d-37da-4c45-8d29-a0fc195abffa	SE013A	3	Z	t	CV027	f	2022-08-09 15:20:53.462208	2022-08-09 15:20:53.462208
36f56744-9f60-4891-8b73-ae669da7e3e5	SE013A	3	A	f	CV027	f	2022-08-09 15:20:53.467914	2022-08-09 15:20:53.467914
6e2af9b5-6dd1-4994-874b-ce1a8387bc4b	SE013A	3	D	f	CV027	f	2022-08-09 15:20:53.473118	2022-08-09 15:20:53.473118
3c7030bd-babd-427c-a9f0-1e5b680f8784	SE013A	3	I	f	CV027	f	2022-08-09 15:20:53.478903	2022-08-09 15:20:53.478903
fb6fa9cc-0250-4ea8-af95-a901664d0859	SE013A	3	W	f	CV027	f	2022-08-09 15:20:53.484214	2022-08-09 15:20:53.484214
44b64955-1f71-4a76-b512-28576e75c9d5	SE013A	3	Z	f	CV027	f	2022-08-09 15:20:53.489953	2022-08-09 15:20:53.489953
6974ceaf-dc66-4ca1-ab78-ff494712db50	SE013A	3	A	t	CV079	f	2022-08-09 15:20:53.495393	2022-08-09 15:20:53.495393
30e65561-22d8-4253-85b0-acd3611aa085	SE013A	3	D	t	CV079	f	2022-08-09 15:20:53.50099	2022-08-09 15:20:53.50099
bdb2a54b-f4fc-4f49-bfcc-f03d4265a063	SE013A	3	I	t	CV079	f	2022-08-09 15:20:53.506338	2022-08-09 15:20:53.506338
0677c235-a6aa-4c5b-b00e-8e0c3a5e79f5	SE013A	3	W	t	CV079	f	2022-08-09 15:20:53.51175	2022-08-09 15:20:53.51175
45095155-368d-45c8-a232-d2dceb462a76	SE013A	3	Z	t	CV079	f	2022-08-09 15:20:53.517531	2022-08-09 15:20:53.517531
ba7c0e76-33b7-4452-81fc-6bc80df05e13	SE013A	3	A	f	CV118	f	2022-08-09 15:20:53.580427	2022-08-09 15:20:53.580427
b93df896-53da-49f5-bf7b-3eb6fc75e184	SE013A	3	D	f	CV118	f	2022-08-09 15:20:53.587627	2022-08-09 15:20:53.587627
2cd1043a-925f-4774-9a0e-44558416605d	SE013A	3	I	f	CV118	f	2022-08-09 15:20:53.593748	2022-08-09 15:20:53.593748
aa50f428-f9ad-4d3a-8375-a0704da1c495	SE013A	3	W	f	CV118	f	2022-08-09 15:20:53.599285	2022-08-09 15:20:53.599285
c31f1113-e990-4b38-9fdc-eae3ce46b4e6	SE013A	3	Z	f	CV118	f	2022-08-09 15:20:53.605042	2022-08-09 15:20:53.605042
c8ce2135-c9a5-412a-b55b-6eca286cbd42	SE013A	3	A	f	CV079	t	2022-08-09 15:20:53.522894	2022-08-09 15:20:53.612586
7e1d7f41-26b7-448e-93fc-ec864b50cab6	SE013A	3	D	f	CV079	t	2022-08-09 15:20:53.529936	2022-08-09 15:20:53.620079
3a4cf7ee-0b47-4ee0-9cae-7a2d9f7dd66b	SE013A	3	I	f	CV079	t	2022-08-09 15:20:53.536263	2022-08-09 15:20:53.628964
4b7ad368-b63c-4076-bc35-2d186f0fc634	SE013A	3	W	f	CV079	t	2022-08-09 15:20:53.541653	2022-08-09 15:20:53.637651
72d77a28-282f-4ea4-bc88-ece77f0d8244	SE013A	3	Z	f	CV079	t	2022-08-09 15:20:53.547308	2022-08-09 15:20:53.646363
8e58e180-ca1d-4134-b615-8fc988407a3a	SE013A	3	A	t	CV118	t	2022-08-09 15:20:53.552684	2022-08-09 15:20:53.65437
59fbba40-2fa6-47ff-b9a5-054421d4f8ca	SE013A	3	D	t	CV118	t	2022-08-09 15:20:53.557956	2022-08-09 15:20:53.66252
89368c62-2f0e-4dcf-b191-20964f21b1bb	SE013A	3	I	t	CV118	t	2022-08-09 15:20:53.563492	2022-08-09 15:20:53.670412
2f264b96-a4e0-437e-8a27-4626f3797407	SE013A	3	W	t	CV118	t	2022-08-09 15:20:53.569034	2022-08-09 15:20:53.678367
7e5e357f-4f94-4a7f-992d-a5c48cc58d5e	SE013A	3	Z	t	CV118	t	2022-08-09 15:20:53.574694	2022-08-09 15:20:53.686906
a0d78499-216b-49dc-ad10-98927e1d292c	SE014A	3	A	t	APL09	f	2022-08-09 15:20:53.692667	2022-08-09 15:20:53.692667
0e72893c-5828-4d00-b41e-7f7d4eae240f	SE014A	3	D	t	APL09	f	2022-08-09 15:20:53.698917	2022-08-09 15:20:53.698917
a28e5608-8b88-483e-9b45-8f6b42cf7cb0	SE014A	3	I	t	APL09	f	2022-08-09 15:20:53.704936	2022-08-09 15:20:53.704936
696f9cdf-308c-4e77-ba74-3f6d42d5bbca	SE014A	3	W	t	APL09	f	2022-08-09 15:20:53.710924	2022-08-09 15:20:53.710924
e16ce65e-3b01-42e8-9d82-a24517e37992	SE014A	3	Z	t	APL09	f	2022-08-09 15:20:53.718556	2022-08-09 15:20:53.718556
2478f4c0-54b5-49ed-abc3-6d74b8e587e8	SE014A	3	A	f	APL09	f	2022-08-09 15:20:53.725275	2022-08-09 15:20:53.725275
161a0c8a-13b6-4db8-b342-6b0acf313795	SE014A	3	D	f	APL09	f	2022-08-09 15:20:53.732053	2022-08-09 15:20:53.732053
ea4805d3-3e57-4d9b-a8bd-b226ea8b52ca	SE014A	3	I	f	APL09	f	2022-08-09 15:20:53.73813	2022-08-09 15:20:53.73813
3a8806e7-017d-4eda-bfdf-17cd1ba9aebe	SE014A	3	W	f	APL09	f	2022-08-09 15:20:53.744883	2022-08-09 15:20:53.744883
a9c8e80b-e91e-4ac1-8b79-c975d3aade61	SE014A	3	Z	f	APL09	f	2022-08-09 15:20:53.751318	2022-08-09 15:20:53.751318
3fcd0a44-6c78-4592-8dae-956abe522400	SE014A	3	A	t	APL07	f	2022-08-09 15:20:53.759257	2022-08-09 15:20:53.759257
7668ffcb-e48c-46b2-a97b-04d1dafdcba5	SE014A	3	D	t	APL07	f	2022-08-09 15:20:53.766292	2022-08-09 15:20:53.766292
949ff848-1d7b-41ce-9003-dc3e8467134b	SE014A	3	I	t	APL07	f	2022-08-09 15:20:53.772815	2022-08-09 15:20:53.772815
5601d0b8-89bb-4bd7-824d-e9316aa1e413	SE014A	3	W	t	APL07	f	2022-08-09 15:20:53.779495	2022-08-09 15:20:53.779495
254138d9-2b64-4798-a58b-d25cb317b385	SE014A	3	Z	t	APL07	f	2022-08-09 15:20:53.785887	2022-08-09 15:20:53.785887
23ff34e5-cc67-45ff-8a9c-da220829c108	SE014A	3	A	f	APL07	f	2022-08-09 15:20:53.792365	2022-08-09 15:20:53.792365
ba762057-341b-43c4-9b90-8c9067088262	SE014A	3	D	f	APL07	f	2022-08-09 15:20:53.798642	2022-08-09 15:20:53.798642
0f998c18-3b3b-4428-b435-6702ad3ab8ed	SE014A	3	I	f	APL07	f	2022-08-09 15:20:53.804694	2022-08-09 15:20:53.804694
c4b68d3a-498e-4854-9467-239196d15587	SE014A	3	W	f	APL07	f	2022-08-09 15:20:53.810404	2022-08-09 15:20:53.810404
0f370f31-e03a-4ff4-9f37-5b61aca73a83	SE014A	3	Z	f	APL07	f	2022-08-09 15:20:53.816939	2022-08-09 15:20:53.816939
ea3e6c93-b7f4-410e-b109-4e61108e86b4	SE014A	3	A	t	APL11	f	2022-08-09 15:20:53.822559	2022-08-09 15:20:53.822559
77ac764d-32ee-4d85-a288-93c809d19f89	SE014A	3	D	t	APL11	f	2022-08-09 15:20:53.828221	2022-08-09 15:20:53.828221
94cda3c8-029f-4413-806b-ebc252b4dc60	SE014A	3	I	t	APL11	f	2022-08-09 15:20:53.835373	2022-08-09 15:20:53.835373
2bd8d020-0cfc-4c6a-9379-4f9ad54731c5	SE014A	3	W	t	APL11	f	2022-08-09 15:20:53.841685	2022-08-09 15:20:53.841685
36a7b1f2-bdbf-4ee3-b0cf-9af1367ac222	SE014A	3	Z	t	APL11	f	2022-08-09 15:20:53.847491	2022-08-09 15:20:53.847491
f660e4cf-be9e-40fc-b621-8695f87a93d1	SE014A	3	A	f	APL11	f	2022-08-09 15:20:53.853227	2022-08-09 15:20:53.853227
68130834-81c1-4193-bba4-10523c5760ec	SE014A	3	D	f	APL11	f	2022-08-09 15:20:53.859022	2022-08-09 15:20:53.859022
e3af10f2-a2ab-4f09-aec6-a19e7e1b5256	SE014A	3	I	f	APL11	f	2022-08-09 15:20:53.864414	2022-08-09 15:20:53.864414
68e9aece-62a1-4d4f-980c-3b6af88fde77	SE014A	3	W	f	APL11	f	2022-08-09 15:20:53.870415	2022-08-09 15:20:53.870415
2feb5e2c-42e9-4f66-8597-a4ef4119866e	SE014A	3	Z	f	APL11	f	2022-08-09 15:20:53.876046	2022-08-09 15:20:53.876046
b9becc67-55d2-45a6-a048-830b52bc5a52	SE014A	3	A	t	APL13	f	2022-08-09 15:20:53.881466	2022-08-09 15:20:53.881466
627a570a-5471-4a2e-81a5-64d9fc42dc2c	SE014A	3	D	t	APL13	f	2022-08-09 15:20:53.887149	2022-08-09 15:20:53.887149
bd08d4a2-94ae-40b4-981c-afcbca677abe	SE014A	3	I	t	APL13	f	2022-08-09 15:20:53.892791	2022-08-09 15:20:53.892791
0316bc80-6713-4937-9ead-e8ad39962b6c	SE014A	3	W	t	APL13	f	2022-08-09 15:20:53.898456	2022-08-09 15:20:53.898456
b969ce05-b517-4b64-8b45-20d659f0636f	SE014A	3	Z	t	APL13	f	2022-08-09 15:20:53.904257	2022-08-09 15:20:53.904257
7a11a274-973b-4be8-a0cf-6239b8fb93b8	SE014A	3	A	f	APL13	f	2022-08-09 15:20:53.909759	2022-08-09 15:20:53.909759
5856c59c-70a8-4095-9a4a-acc2e2e717f8	SE014A	3	D	f	APL13	f	2022-08-09 15:20:53.916459	2022-08-09 15:20:53.916459
1f10366a-5c6f-44b5-a27d-fcf3f9032fc5	SE014A	3	I	f	APL13	f	2022-08-09 15:20:53.922262	2022-08-09 15:20:53.922262
61246c86-184b-47a3-a495-9f45c79bc47f	SE014A	3	W	f	APL13	f	2022-08-09 15:20:53.928857	2022-08-09 15:20:53.928857
a74ec307-5d23-415d-be26-dc718fc77919	SE014A	3	Z	f	APL13	f	2022-08-09 15:20:53.934995	2022-08-09 15:20:53.934995
a10410b8-f551-4b07-a1da-3b053b1b2107	SE014A	3	A	t	APL15	f	2022-08-09 15:20:53.940724	2022-08-09 15:20:53.940724
b0d26913-2064-49ba-a7f1-1eb24d9ee4ab	SE014A	3	D	t	APL15	f	2022-08-09 15:20:53.946988	2022-08-09 15:20:53.946988
787d670d-d926-4feb-b030-8b228ab8c626	SE014A	3	I	t	APL15	f	2022-08-09 15:20:53.952895	2022-08-09 15:20:53.952895
23137fe8-18df-4e3c-85f5-b472ed448783	SE014A	3	W	t	APL15	f	2022-08-09 15:20:53.959363	2022-08-09 15:20:53.959363
1e38e771-6749-4a30-8e18-0abffa790536	SE014A	3	Z	t	APL15	f	2022-08-09 15:20:53.965629	2022-08-09 15:20:53.965629
d5cd34cc-bb45-4210-94a5-1766075ec3a5	SE014A	3	A	f	APL15	f	2022-08-09 15:20:53.971359	2022-08-09 15:20:53.971359
7208aa8d-1da5-4b69-b3f4-1b9063154a8f	SE014A	3	D	f	APL15	f	2022-08-09 15:20:53.977246	2022-08-09 15:20:53.977246
b467cbbe-f580-4cf0-ba13-b7f7a9b92877	SE014A	3	I	f	APL15	f	2022-08-09 15:20:53.983551	2022-08-09 15:20:53.983551
38161992-94ac-4dd3-8a32-c4a4714191f1	SE014A	3	W	f	APL15	f	2022-08-09 15:20:53.989197	2022-08-09 15:20:53.989197
ba3d9d7b-14ee-4eba-b735-6b296742be38	SE014A	3	Z	f	APL15	f	2022-08-09 15:20:53.995755	2022-08-09 15:20:53.995755
64ae3b35-a1cf-48c5-9056-09d663e3d93a	SE014A	3	A	t	APL16	f	2022-08-09 15:20:54.001953	2022-08-09 15:20:54.001953
78346191-4054-4537-a195-8baa04cf9621	SE014A	3	D	t	APL16	f	2022-08-09 15:20:54.008225	2022-08-09 15:20:54.008225
3f5c67c1-7250-4c22-879c-bb4b876b2065	SE014A	3	I	t	APL16	f	2022-08-09 15:20:54.015039	2022-08-09 15:20:54.015039
6f57857a-7daf-47ca-80e2-0a021e5bd1a3	SE014A	3	W	t	APL16	f	2022-08-09 15:20:54.020865	2022-08-09 15:20:54.020865
ad51db1a-a6c1-4349-affa-6fd202367ad9	SE014A	3	Z	t	APL16	f	2022-08-09 15:20:54.026402	2022-08-09 15:20:54.026402
9e727c74-1bc7-48ac-85e2-34b246802697	SE014A	3	A	f	APL16	f	2022-08-09 15:20:54.03313	2022-08-09 15:20:54.03313
ec308bd8-5416-45df-bd67-dbd1f49423ca	SE014A	3	D	f	APL16	f	2022-08-09 15:20:54.039058	2022-08-09 15:20:54.039058
6cc2592c-4b29-47d1-b4ac-453cc0d3c620	SE014A	3	I	f	APL16	f	2022-08-09 15:20:54.045691	2022-08-09 15:20:54.045691
9444b500-929d-476a-baeb-c9efc0d08d53	SE014A	3	W	f	APL16	f	2022-08-09 15:20:54.052233	2022-08-09 15:20:54.052233
82587e03-2db9-4d82-8f27-ac7b3fa91398	SE014A	3	Z	f	APL16	f	2022-08-09 15:20:54.058229	2022-08-09 15:20:54.058229
971b7b58-2e1b-40c0-852a-418ecee57746	SE014A	3	A	t	APL18	f	2022-08-09 15:20:54.064668	2022-08-09 15:20:54.064668
9caa67be-7e56-46ce-afc3-f28b9d2cbf87	SE014A	3	D	t	APL18	f	2022-08-09 15:20:54.07045	2022-08-09 15:20:54.07045
8af3ecf8-140d-4454-8bf8-3910e84860e6	SE014A	3	I	t	APL18	f	2022-08-09 15:20:54.076568	2022-08-09 15:20:54.076568
7fcb0f8f-9c4d-4bd5-8bc0-abdaece03e00	SE014A	3	W	t	APL18	f	2022-08-09 15:20:54.082794	2022-08-09 15:20:54.082794
9d739a25-6716-4a34-be3e-563fa29c4234	SE014A	3	Z	t	APL18	f	2022-08-09 15:20:54.088988	2022-08-09 15:20:54.088988
c2910364-d38d-4ab8-821b-3052765ce1d1	SE014A	3	A	f	APL18	f	2022-08-09 15:20:54.094832	2022-08-09 15:20:54.094832
7a19763b-2f70-4e09-8aa4-b744197a338c	SE014A	3	D	f	APL18	f	2022-08-09 15:20:54.100691	2022-08-09 15:20:54.100691
cf5b8841-aca7-4e08-a269-3a8be1590ff7	SE014A	3	I	f	APL18	f	2022-08-09 15:20:54.108062	2022-08-09 15:20:54.108062
6d5606da-3e08-4bb1-a2f5-e7a00bde05ef	SE014A	3	W	f	APL18	f	2022-08-09 15:20:54.114847	2022-08-09 15:20:54.114847
3eab85e5-28c3-4127-adc3-3b4d0df196fb	SE014A	3	Z	f	APL18	f	2022-08-09 15:20:54.120948	2022-08-09 15:20:54.120948
4f755df4-58dd-4a8b-9e9d-d2e225072a79	SE014A	3	A	t	APL20	f	2022-08-09 15:20:54.126968	2022-08-09 15:20:54.126968
f3a3d7dd-caad-4be4-b72c-542a4345f6cc	SE014A	3	D	t	APL20	f	2022-08-09 15:20:54.133207	2022-08-09 15:20:54.133207
5b2de1e8-e12c-4d99-a8d3-f2a4896c9615	SE014A	3	I	t	APL20	f	2022-08-09 15:20:54.139324	2022-08-09 15:20:54.139324
11bba9eb-680d-422c-aad7-a53b7e6ea07b	SE014A	3	W	t	APL20	f	2022-08-09 15:20:54.145334	2022-08-09 15:20:54.145334
6d0f41b1-a383-436c-85a5-79db44df3ab4	SE014A	3	Z	t	APL20	f	2022-08-09 15:20:54.151911	2022-08-09 15:20:54.151911
4c8e2429-1acc-495b-aa20-f5135b7d3729	SE014A	3	A	f	APL20	f	2022-08-09 15:20:54.157656	2022-08-09 15:20:54.157656
3486de2f-7b6a-40a7-aa16-64dee632cd4b	SE014A	3	D	f	APL20	f	2022-08-09 15:20:54.163854	2022-08-09 15:20:54.163854
3684b049-6c5f-43b3-a54e-3bb805f4636e	SE014A	3	I	f	APL20	f	2022-08-09 15:20:54.169576	2022-08-09 15:20:54.169576
5d154e54-e6f8-4033-ad14-bd0b47673ba2	SE014A	3	W	f	APL20	f	2022-08-09 15:20:54.175466	2022-08-09 15:20:54.175466
e5272abf-0a18-427d-b3cb-c26718679b04	SE014A	3	Z	f	APL20	f	2022-08-09 15:20:54.181844	2022-08-09 15:20:54.181844
02212b56-e45a-4a08-b1bd-e9ff282f4b1b	SE014A	3	A	t	APL22	f	2022-08-09 15:20:54.188018	2022-08-09 15:20:54.188018
10cc23ec-f950-4ad8-8443-5b54ab9b15f3	SE014A	3	D	t	APL22	f	2022-08-09 15:20:54.193864	2022-08-09 15:20:54.193864
2bb60712-c642-4e87-81e0-5785a40c1b76	SE014A	3	I	t	APL22	f	2022-08-09 15:20:54.200441	2022-08-09 15:20:54.200441
14271588-19a8-4e4b-8462-c199d52951cf	SE014A	3	W	t	APL22	f	2022-08-09 15:20:54.205989	2022-08-09 15:20:54.205989
299e8604-1dc3-4f78-81c3-6875a11ae26e	SE014A	3	Z	t	APL22	f	2022-08-09 15:20:54.212117	2022-08-09 15:20:54.212117
2a04ed2c-bb26-4f03-a7e5-371ebb20995b	SE014A	3	A	f	APL22	f	2022-08-09 15:20:54.218132	2022-08-09 15:20:54.218132
0bd24c1e-53fa-4baa-96d8-158b610b0a18	SE014A	3	D	f	APL22	f	2022-08-09 15:20:54.223712	2022-08-09 15:20:54.223712
c6e37994-b62d-464f-854e-fdebeecafaa4	SE014A	3	I	f	APL22	f	2022-08-09 15:20:54.230054	2022-08-09 15:20:54.230054
d40529dd-c859-4588-bbf2-d48cc8e1e986	SE014A	3	W	f	APL22	f	2022-08-09 15:20:54.235826	2022-08-09 15:20:54.235826
a4db5c59-a56d-4367-af45-2372131fe7f3	SE014A	3	Z	f	APL22	f	2022-08-09 15:20:54.241507	2022-08-09 15:20:54.241507
3b52b2fd-d3df-4f43-b73f-bba6defbc80d	SE014A	3	A	t	APL27	f	2022-08-09 15:20:54.248	2022-08-09 15:20:54.248
f3a52ad8-c77a-4ad0-b048-4552cbd06255	SE014A	3	D	t	APL27	f	2022-08-09 15:20:54.254027	2022-08-09 15:20:54.254027
44157593-e78a-450e-b584-833a48c6072d	SE014A	3	I	t	APL27	f	2022-08-09 15:20:54.259717	2022-08-09 15:20:54.259717
76841ac2-fd1e-4779-a4dd-e6a4632a408d	SE014A	3	W	t	APL27	f	2022-08-09 15:20:54.265503	2022-08-09 15:20:54.265503
b559a84a-927b-4f28-a3fc-fe92dac1f198	SE014A	3	Z	t	APL27	f	2022-08-09 15:20:54.271231	2022-08-09 15:20:54.271231
d8d17806-0eec-4326-bf04-1b8858b5c37a	SE014A	3	A	f	APL27	f	2022-08-09 15:20:54.276728	2022-08-09 15:20:54.276728
78816a99-1632-4daf-8b8a-506ddbfe5c46	SE014A	3	D	f	APL27	f	2022-08-09 15:20:54.282625	2022-08-09 15:20:54.282625
8faa6b81-299b-414f-9d24-e9e11f03ff42	SE014A	3	I	f	APL27	f	2022-08-09 15:20:54.288724	2022-08-09 15:20:54.288724
ea59cfb6-f424-448f-b14e-94763096ccbd	SE014A	3	W	f	APL27	f	2022-08-09 15:20:54.294146	2022-08-09 15:20:54.294146
9e556d43-d19f-4782-9860-ace71637869e	SE014A	3	Z	f	APL27	f	2022-08-09 15:20:54.2995	2022-08-09 15:20:54.2995
5037a7ce-0e4d-44e2-98c0-c2b74d3a5ac2	SE014A	3	A	t	APL29	f	2022-08-09 15:20:54.30522	2022-08-09 15:20:54.30522
2ef9c6a9-46de-4ee2-b648-76554b6a464a	SE014A	3	D	t	APL29	f	2022-08-09 15:20:54.310877	2022-08-09 15:20:54.310877
8d07d721-be61-48ec-a279-0cc7330913d8	SE014A	3	I	t	APL29	f	2022-08-09 15:20:54.317067	2022-08-09 15:20:54.317067
21134b91-6191-477e-aa69-3d15d8c5137a	SE014A	3	W	t	APL29	f	2022-08-09 15:20:54.322555	2022-08-09 15:20:54.322555
0e267221-52ee-4a33-98a3-b43629661662	SE014A	3	Z	t	APL29	f	2022-08-09 15:20:54.328245	2022-08-09 15:20:54.328245
f7c73b0d-6017-4301-bd5c-c28cbd14bdfc	SE014A	3	A	f	APL29	f	2022-08-09 15:20:54.334542	2022-08-09 15:20:54.334542
f899607d-5db6-4928-b0c1-2a19c29e13ee	SE014A	3	D	f	APL29	f	2022-08-09 15:20:54.340381	2022-08-09 15:20:54.340381
d266a9d3-25ae-4e94-949b-2c2ba471a9bf	SE014A	3	I	f	APL29	f	2022-08-09 15:20:54.347096	2022-08-09 15:20:54.347096
6c05b27a-6346-46f2-8a72-90f617a2f740	SE014A	3	W	f	APL29	f	2022-08-09 15:20:54.354067	2022-08-09 15:20:54.354067
9266fdce-4190-4ab3-b314-e8da8d41d7ce	SE014A	3	Z	f	APL29	f	2022-08-09 15:20:54.360119	2022-08-09 15:20:54.360119
f90b3908-dafd-4ff1-8d29-daa2db5b0cf2	SE014A	3	A	t	APL31	f	2022-08-09 15:20:54.366393	2022-08-09 15:20:54.366393
e700f847-fb6a-499f-bf8e-470e7e482937	SE014A	3	D	t	APL31	f	2022-08-09 15:20:54.372331	2022-08-09 15:20:54.372331
9f5f2495-2a81-4288-bef0-9d4b89c058b8	SE014A	3	I	t	APL31	f	2022-08-09 15:20:54.378918	2022-08-09 15:20:54.378918
6bfa2dea-ba31-43a6-88fc-74d734e200b5	SE014A	3	W	t	APL31	f	2022-08-09 15:20:54.385204	2022-08-09 15:20:54.385204
cd925f66-f925-4c96-a8b5-ff23ddf045fd	SE014A	3	Z	t	APL31	f	2022-08-09 15:20:54.390889	2022-08-09 15:20:54.390889
3813b446-31ed-43d3-85ee-f79ff18f9371	SE014A	3	A	f	APL31	f	2022-08-09 15:20:54.396983	2022-08-09 15:20:54.396983
279f524a-f62e-49ab-b8d9-d175d876e995	SE014A	3	D	f	APL31	f	2022-08-09 15:20:54.403067	2022-08-09 15:20:54.403067
b485215d-d306-4753-83cf-49abcf69973f	SE014A	3	I	f	APL31	f	2022-08-09 15:20:54.4086	2022-08-09 15:20:54.4086
f37de97c-5a60-4a32-ab04-00384d84d03a	SE014A	3	W	f	APL31	f	2022-08-09 15:20:54.4148	2022-08-09 15:20:54.4148
25561228-fb24-4dd0-80f1-d8c96b716a36	SE014A	3	Z	f	APL31	f	2022-08-09 15:20:54.420524	2022-08-09 15:20:54.420524
79302722-6f69-456f-9986-fac5701af51c	SE014A	3	A	t	APL48	f	2022-08-09 15:20:54.426338	2022-08-09 15:20:54.426338
c84bc538-8f13-4126-9b9d-5fa46004e37a	SE014A	3	D	t	APL48	f	2022-08-09 15:20:54.432944	2022-08-09 15:20:54.432944
b5b84776-efe4-4d0b-96c2-cd3fe5e6e4b8	SE014A	3	I	t	APL48	f	2022-08-09 15:20:54.439101	2022-08-09 15:20:54.439101
c42fbb04-e1e9-49b4-9bd3-90ee127e2f73	SE014A	3	W	t	APL48	f	2022-08-09 15:20:54.444859	2022-08-09 15:20:54.444859
7a79b22e-d592-4833-9781-581066fa2104	SE014A	3	Z	t	APL48	f	2022-08-09 15:20:54.450975	2022-08-09 15:20:54.450975
aff7b5ad-45b3-4975-8096-1729d47853a5	SE014A	3	A	f	APL48	f	2022-08-09 15:20:54.458488	2022-08-09 15:20:54.458488
43285d99-a674-4c81-bf90-1354856040d3	SE014A	3	D	f	APL48	f	2022-08-09 15:20:54.46529	2022-08-09 15:20:54.46529
35299208-9653-4b94-b848-8909f8c6f34d	SE014A	3	I	f	APL48	f	2022-08-09 15:20:54.471365	2022-08-09 15:20:54.471365
ec157d5e-8162-43fb-b632-2fa35ff12e9a	SE014A	3	W	f	APL48	f	2022-08-09 15:20:54.477116	2022-08-09 15:20:54.477116
43b62a83-77c5-427f-9a73-19bdd1a2cbe4	SE014A	3	Z	f	APL48	f	2022-08-09 15:20:54.483928	2022-08-09 15:20:54.483928
aefab3f2-2551-4da5-aeff-ba017b458c2a	SE014A	3	A	t	APL49	f	2022-08-09 15:20:54.490254	2022-08-09 15:20:54.490254
cfcae1eb-e8fa-4d58-afd0-125396c664c1	SE014A	3	D	t	APL49	f	2022-08-09 15:20:54.496681	2022-08-09 15:20:54.496681
ab9d8882-03c4-4333-a8c6-2ec9d38b867b	SE014A	3	I	t	APL49	f	2022-08-09 15:20:54.502817	2022-08-09 15:20:54.502817
812926c6-b365-488d-8901-676da03dc2b4	SE014A	3	W	t	APL49	f	2022-08-09 15:20:54.508456	2022-08-09 15:20:54.508456
75795df1-0d08-429e-b528-da165ecd9ddc	SE014A	3	Z	t	APL49	f	2022-08-09 15:20:54.514508	2022-08-09 15:20:54.514508
e6504366-08c1-46fc-9d4c-8f08d4248db0	SE014A	3	A	f	APL49	f	2022-08-09 15:20:54.520043	2022-08-09 15:20:54.520043
1068db9c-d20b-434f-bca0-a55bef93e065	SE014A	3	D	f	APL49	f	2022-08-09 15:20:54.526372	2022-08-09 15:20:54.526372
a8649e7e-9372-4ce2-a8e2-ef501e8a771d	SE014A	3	I	f	APL49	f	2022-08-09 15:20:54.532611	2022-08-09 15:20:54.532611
c932d402-c2ed-4c5d-8653-88f32f4eb99a	SE014A	3	W	f	APL49	f	2022-08-09 15:20:54.538285	2022-08-09 15:20:54.538285
00ed8213-5439-4553-93ad-6fe00abd3318	SE014A	3	Z	f	APL49	f	2022-08-09 15:20:54.543806	2022-08-09 15:20:54.543806
af248aa1-444f-494b-8b06-8854e6c79559	SE014A	3	A	t	APL50	f	2022-08-09 15:20:54.549455	2022-08-09 15:20:54.549455
9ac4f39a-8b1a-4e69-9cc0-109e51267d6d	SE014A	3	D	t	APL50	f	2022-08-09 15:20:54.554692	2022-08-09 15:20:54.554692
ca28bfad-cb03-4044-8ca9-04ca93b9c132	SE014A	3	I	t	APL50	f	2022-08-09 15:20:54.560178	2022-08-09 15:20:54.560178
cfe81967-422b-4dc6-92e0-9d8d8e67cfc2	SE014A	3	W	t	APL50	f	2022-08-09 15:20:54.565942	2022-08-09 15:20:54.565942
ba78ef7a-90a1-4583-89e5-49b9eb57d87c	SE014A	3	Z	t	APL50	f	2022-08-09 15:20:54.571416	2022-08-09 15:20:54.571416
1b7647ac-b86b-4a93-931c-1da010d6102d	SE014A	3	A	f	APL50	f	2022-08-09 15:20:54.577292	2022-08-09 15:20:54.577292
0594e767-411e-4f25-99a9-c3df0bf2b1a5	SE014A	3	D	f	APL50	f	2022-08-09 15:20:54.585451	2022-08-09 15:20:54.585451
dd8b2223-c56b-49ea-960d-e8cc3701a79a	SE014A	3	I	f	APL50	f	2022-08-09 15:20:54.59183	2022-08-09 15:20:54.59183
c7384945-7bec-417e-8eb8-a9ff663c8bf2	SE014A	3	W	f	APL50	f	2022-08-09 15:20:54.598149	2022-08-09 15:20:54.598149
cf958682-c546-472b-ac6f-dc581152b714	SE014A	3	Z	f	APL50	f	2022-08-09 15:20:54.603435	2022-08-09 15:20:54.603435
377ba7c8-4d73-47b7-8202-391a0534f84a	SE014A	3	A	t	APL51	f	2022-08-09 15:20:54.609584	2022-08-09 15:20:54.609584
458262a3-e0df-40ea-83ee-023d856db24d	SE014A	3	D	t	APL51	f	2022-08-09 15:20:54.615856	2022-08-09 15:20:54.615856
f3eda12d-a36d-458d-91c3-770503f115ae	SE014A	3	I	t	APL51	f	2022-08-09 15:20:54.621434	2022-08-09 15:20:54.621434
9bb44345-18e6-427b-ab08-ac440fd85a74	SE014A	3	W	t	APL51	f	2022-08-09 15:20:54.627528	2022-08-09 15:20:54.627528
969ceb32-cfff-436f-b3cd-61a30005380c	SE014A	3	Z	t	APL51	f	2022-08-09 15:20:54.633705	2022-08-09 15:20:54.633705
3e4ff699-4213-404b-bbf2-39d8608e8c74	SE014A	3	A	f	APL51	f	2022-08-09 15:20:54.639213	2022-08-09 15:20:54.639213
49e96ca9-bf69-42a1-934c-a8ad32a6f2ea	SE014A	3	D	f	APL51	f	2022-08-09 15:20:54.645848	2022-08-09 15:20:54.645848
7feb6d08-feef-4e6b-a278-7beddc72b22e	SE014A	3	I	f	APL51	f	2022-08-09 15:20:54.651909	2022-08-09 15:20:54.651909
2f5e7d93-aa13-4c0e-b810-2b6964f423a9	SE014A	3	W	f	APL51	f	2022-08-09 15:20:54.657842	2022-08-09 15:20:54.657842
1fb08372-c268-49f4-9d4d-67de50498092	SE014A	3	Z	f	APL51	f	2022-08-09 15:20:54.663858	2022-08-09 15:20:54.663858
5be7860d-a992-422f-900a-9db77d23c570	SE014A	3	A	t	APL52	f	2022-08-09 15:20:54.669547	2022-08-09 15:20:54.669547
b2d44000-84f2-4778-b512-972a4f1d5bf9	SE014A	3	D	t	APL52	f	2022-08-09 15:20:54.676605	2022-08-09 15:20:54.676605
2d3d5230-3051-4f61-9aa4-295f8258aa58	SE014A	3	I	t	APL52	f	2022-08-09 15:20:54.683095	2022-08-09 15:20:54.683095
3b2ea354-a1f2-4c73-8f3e-b75a3fc65db7	SE014A	3	W	t	APL52	f	2022-08-09 15:20:54.688639	2022-08-09 15:20:54.688639
de21e94d-1209-403e-8002-bf11898f5a59	SE014A	3	Z	t	APL52	f	2022-08-09 15:20:54.694744	2022-08-09 15:20:54.694744
5b9ebffd-8745-45da-b815-26413f44857c	SE014A	3	A	f	APL52	f	2022-08-09 15:20:54.701007	2022-08-09 15:20:54.701007
de10f5fc-c7c5-4e41-87c2-c6730a6a9db1	SE014A	3	D	f	APL52	f	2022-08-09 15:20:54.706593	2022-08-09 15:20:54.706593
968158e3-489d-4bcd-ba6b-34908ee0faa9	SE014A	3	I	f	APL52	f	2022-08-09 15:20:54.712466	2022-08-09 15:20:54.712466
ec6de640-8cd0-45a3-a67f-9ce8ac8919ec	SE014A	3	W	f	APL52	f	2022-08-09 15:20:54.718125	2022-08-09 15:20:54.718125
7986147e-61a1-42dc-af1b-2c9fd5af8214	SE014A	3	Z	f	APL52	f	2022-08-09 15:20:54.723847	2022-08-09 15:20:54.723847
b7058494-2a8f-4274-9b28-c03256cdcc1b	SE014A	3	A	t	APL53	f	2022-08-09 15:20:54.729441	2022-08-09 15:20:54.729441
0a72f9e9-0d70-4047-a444-8590704e4873	SE014A	3	D	t	APL53	f	2022-08-09 15:20:54.734978	2022-08-09 15:20:54.734978
22d05ee9-f0ce-43a9-8398-3b330921e475	SE014A	3	I	t	APL53	f	2022-08-09 15:20:54.740675	2022-08-09 15:20:54.740675
698374a2-a589-4a55-8cd6-3762ee2837fb	SE014A	3	W	t	APL53	f	2022-08-09 15:20:54.746226	2022-08-09 15:20:54.746226
8c6021bf-6455-4453-a901-2667e94bab53	SE014A	3	Z	t	APL53	f	2022-08-09 15:20:54.751785	2022-08-09 15:20:54.751785
d6bcc3aa-0b98-4175-b102-0c9f81b297f7	SE014A	3	A	f	APL53	f	2022-08-09 15:20:54.757583	2022-08-09 15:20:54.757583
ee26cfe2-dbc5-4cfe-996f-18a7306e88ca	SE014A	3	D	f	APL53	f	2022-08-09 15:20:54.763116	2022-08-09 15:20:54.763116
330341b4-2694-4a5d-bf0a-896e72168ee7	SE014A	3	I	f	APL53	f	2022-08-09 15:20:54.768981	2022-08-09 15:20:54.768981
0dc8466c-51de-4574-b266-c6b18a7b57fa	SE014A	3	W	f	APL53	f	2022-08-09 15:20:54.774398	2022-08-09 15:20:54.774398
a0035882-1162-4b9e-9f11-23f94ff55c62	SE014A	3	Z	f	APL53	f	2022-08-09 15:20:54.780459	2022-08-09 15:20:54.780459
917cbb93-7d01-4908-a5d2-bb1f55d924dc	SE014A	3	A	t	APL54	f	2022-08-09 15:20:54.786316	2022-08-09 15:20:54.786316
3b8b6fb9-bae3-4152-99d9-26dca613d423	SE014A	3	D	t	APL54	f	2022-08-09 15:20:54.791899	2022-08-09 15:20:54.791899
9e0174ec-e74e-477c-be9d-58781b10bec1	SE014A	3	I	t	APL54	f	2022-08-09 15:20:54.798466	2022-08-09 15:20:54.798466
85d8f06a-3ca8-4ee1-b8ea-28bd3524f5f8	SE014A	3	W	t	APL54	f	2022-08-09 15:20:54.804434	2022-08-09 15:20:54.804434
fdf800b9-806c-47e0-96c1-fbbb86f0a381	SE014A	3	Z	t	APL54	f	2022-08-09 15:20:54.809888	2022-08-09 15:20:54.809888
988ef581-12cc-4df3-95cd-d76f45271d06	SE014A	3	A	f	APL54	f	2022-08-09 15:20:54.816313	2022-08-09 15:20:54.816313
fc34334f-0c5c-4fc0-9513-e5e1c159354d	SE014A	3	D	f	APL54	f	2022-08-09 15:20:54.821943	2022-08-09 15:20:54.821943
7712604c-221e-4061-a609-fd01b6775f30	SE014A	3	I	f	APL54	f	2022-08-09 15:20:54.827786	2022-08-09 15:20:54.827786
060ddcfc-46a1-433f-8a7e-632f12c23c6c	SE014A	3	W	f	APL54	f	2022-08-09 15:20:54.833964	2022-08-09 15:20:54.833964
0fa8a38c-703b-471d-a887-be5e458ccc5b	SE014A	3	Z	f	APL54	f	2022-08-09 15:20:54.839795	2022-08-09 15:20:54.839795
6d9db468-210b-4fbe-921f-ac25fdfdcc35	SE014A	3	A	t	APL55	f	2022-08-09 15:20:54.845931	2022-08-09 15:20:54.845931
f8a54070-21eb-4f7a-97f2-b768872aaf24	SE014A	3	D	t	APL55	f	2022-08-09 15:20:54.851571	2022-08-09 15:20:54.851571
0f2219a0-b06a-4f79-9cc1-cd350dba3cba	SE014A	3	I	t	APL55	f	2022-08-09 15:20:54.857222	2022-08-09 15:20:54.857222
6050cd3e-d5a2-46eb-8161-b39aae229fb9	SE014A	3	W	t	APL55	f	2022-08-09 15:20:54.862741	2022-08-09 15:20:54.862741
8436a460-0498-49b7-886c-0c16f1f45403	SE014A	3	Z	t	APL55	f	2022-08-09 15:20:54.86825	2022-08-09 15:20:54.86825
ec7535a0-1b15-4d9d-99a9-8941cd60860d	SE014A	3	A	f	APL55	f	2022-08-09 15:20:54.87406	2022-08-09 15:20:54.87406
0b2cc527-de51-4c05-a14f-eeca8a18fca0	SE014A	3	D	f	APL55	f	2022-08-09 15:20:54.879366	2022-08-09 15:20:54.879366
3cc947a4-4829-4682-8549-b5480240335e	SE014A	3	I	f	APL55	f	2022-08-09 15:20:54.885015	2022-08-09 15:20:54.885015
9414686f-d994-469d-bdba-943a0650d53f	SE014A	3	W	f	APL55	f	2022-08-09 15:20:54.890349	2022-08-09 15:20:54.890349
839872a0-25ea-494a-b8f9-75420002f632	SE014A	3	Z	f	APL55	f	2022-08-09 15:20:54.896124	2022-08-09 15:20:54.896124
9b925df0-2216-4fc5-8447-21dcd590b47e	SE014A	3	A	t	APL56	f	2022-08-09 15:20:54.901607	2022-08-09 15:20:54.901607
cb35fc98-2fb3-4aa0-a415-9d7f3c57fd52	SE014A	3	D	t	APL56	f	2022-08-09 15:20:54.907381	2022-08-09 15:20:54.907381
6738dd6c-a254-4256-adbd-0414551bbcf5	SE014A	3	I	t	APL56	f	2022-08-09 15:20:54.912808	2022-08-09 15:20:54.912808
a29f87eb-8734-4553-8aeb-1c8b42a155b2	SE014A	3	W	t	APL56	f	2022-08-09 15:20:54.918218	2022-08-09 15:20:54.918218
525cdc34-0850-4f5f-aa71-3c58685f355f	SE014A	3	Z	t	APL56	f	2022-08-09 15:20:54.923953	2022-08-09 15:20:54.923953
6d23772f-fbfa-4639-bda5-242edbf04234	SE014A	3	A	f	APL56	f	2022-08-09 15:20:54.929771	2022-08-09 15:20:54.929771
8f54ebae-72f3-49d0-abea-8e6fde606425	SE014A	3	D	f	APL56	f	2022-08-09 15:20:54.935537	2022-08-09 15:20:54.935537
8242ce9c-7569-46fb-b82d-e257fe850cfd	SE014A	3	I	f	APL56	f	2022-08-09 15:20:54.941303	2022-08-09 15:20:54.941303
f8f5e84a-f3fd-48c9-9bfe-084c3eee3601	SE014A	3	W	f	APL56	f	2022-08-09 15:20:54.946696	2022-08-09 15:20:54.946696
bae374f5-7f14-4527-b276-9227adc08d0a	SE014A	3	Z	f	APL56	f	2022-08-09 15:20:54.952322	2022-08-09 15:20:54.952322
2f588cba-1d1b-4429-9a97-1c09077c4a8b	SE014A	3	A	t	APL57	f	2022-08-09 15:20:54.957882	2022-08-09 15:20:54.957882
74cf24ae-5ec6-4bcb-b92b-ec68e59ca7c4	SE014A	3	D	t	APL57	f	2022-08-09 15:20:54.963416	2022-08-09 15:20:54.963416
67d2738c-4e24-42a9-9df7-62e87167ea83	SE014A	3	I	t	APL57	f	2022-08-09 15:20:54.969831	2022-08-09 15:20:54.969831
9bd329ef-bb05-4f25-a072-5b38d4a6fa2c	SE014A	3	W	t	APL57	f	2022-08-09 15:20:54.975368	2022-08-09 15:20:54.975368
a9e3b4a3-754c-4a59-ab44-008c6370ebba	SE014A	3	Z	t	APL57	f	2022-08-09 15:20:54.981233	2022-08-09 15:20:54.981233
a5bb1ad3-d3a3-4d9c-93dd-caa2ace1d995	SE014A	3	A	f	APL57	f	2022-08-09 15:20:54.986614	2022-08-09 15:20:54.986614
2bc77c74-1ccb-448c-ab87-5a0de6241f64	SE014A	3	D	f	APL57	f	2022-08-09 15:20:54.992087	2022-08-09 15:20:54.992087
fabf2861-2fe9-46d9-8e5e-cdb51a79421a	SE014A	3	I	f	APL57	f	2022-08-09 15:20:54.997815	2022-08-09 15:20:54.997815
00e45f4f-8cd8-4787-af89-124e2e31b01c	SE014A	3	W	f	APL57	f	2022-08-09 15:20:55.003408	2022-08-09 15:20:55.003408
a10ba5ad-48cc-4141-8fcd-ebd1f86563ff	SE014A	3	Z	f	APL57	f	2022-08-09 15:20:55.009195	2022-08-09 15:20:55.009195
1619c1e2-2778-425a-9913-c9d8d918bf05	SE014A	3	A	t	APL65	f	2022-08-09 15:20:55.014635	2022-08-09 15:20:55.014635
309c4313-b47f-42f5-beb4-337b4663b68d	SE014A	3	D	t	APL65	f	2022-08-09 15:20:55.020217	2022-08-09 15:20:55.020217
21eb7699-0ea7-429e-a311-e0e34621ae5c	SE014A	3	I	t	APL65	f	2022-08-09 15:20:55.0261	2022-08-09 15:20:55.0261
6d400306-dda8-4de4-9f0e-8061bc09a068	SE014A	3	W	t	APL65	f	2022-08-09 15:20:55.031517	2022-08-09 15:20:55.031517
39498169-f7bf-4a4b-ba88-35636626ce00	SE014A	3	Z	t	APL65	f	2022-08-09 15:20:55.037158	2022-08-09 15:20:55.037158
13d4e11b-e69a-4178-ae7f-d7f734206f37	SE014A	3	A	f	APL65	f	2022-08-09 15:20:55.043103	2022-08-09 15:20:55.043103
33f18926-ec20-4b3f-89d8-a444de085e36	SE014A	3	D	f	APL65	f	2022-08-09 15:20:55.048518	2022-08-09 15:20:55.048518
cc6cd3ba-3bbd-4469-b28b-5ac4ec381690	SE014A	3	I	f	APL65	f	2022-08-09 15:20:55.054898	2022-08-09 15:20:55.054898
d9080d16-aa37-4c13-b9b3-98a7902da835	SE014A	3	W	f	APL65	f	2022-08-09 15:20:55.062	2022-08-09 15:20:55.062
cf4673ec-bdc2-44dd-88de-401e9caf41b1	SE014A	3	Z	f	APL65	f	2022-08-09 15:20:55.068155	2022-08-09 15:20:55.068155
5c6fbb55-aeb5-4e77-a669-bfd4d7628fce	SE014A	3	A	t	APL66	f	2022-08-09 15:20:55.074108	2022-08-09 15:20:55.074108
66ff0419-1766-44d1-b6f4-080a585fd8cf	SE014A	3	D	t	APL66	f	2022-08-09 15:20:55.080109	2022-08-09 15:20:55.080109
0d6a4dcd-2921-407b-a1c9-5b52d212f7f9	SE014A	3	I	t	APL66	f	2022-08-09 15:20:55.087415	2022-08-09 15:20:55.087415
0d1e0d1e-c0a6-427a-99c9-1b95b202936f	SE014A	3	W	t	APL66	f	2022-08-09 15:20:55.09352	2022-08-09 15:20:55.09352
699a40d0-5a76-40f4-9e79-6dec7635e89f	SE014A	3	Z	t	APL66	f	2022-08-09 15:20:55.099144	2022-08-09 15:20:55.099144
2b1e671f-eef6-41bc-a618-14afced110b3	SE014A	3	A	f	APL66	f	2022-08-09 15:20:55.105071	2022-08-09 15:20:55.105071
aca8154a-bfab-4138-84bd-14cc9fe19952	SE014A	3	D	f	APL66	f	2022-08-09 15:20:55.110928	2022-08-09 15:20:55.110928
85ec8f98-422e-4682-9ef6-2cc258844515	SE014A	3	I	f	APL66	f	2022-08-09 15:20:55.116935	2022-08-09 15:20:55.116935
2324cc26-76bb-4869-a46d-336e2e67e619	SE014A	3	W	f	APL66	f	2022-08-09 15:20:55.122383	2022-08-09 15:20:55.122383
bee4f43d-f7c3-4bef-9fd6-5901de2cf39e	SE014A	3	Z	f	APL66	f	2022-08-09 15:20:55.127852	2022-08-09 15:20:55.127852
9d127efe-a949-4f9b-a338-feb14df212d8	SE014A	3	A	t	APL67	f	2022-08-09 15:20:55.135408	2022-08-09 15:20:55.135408
f92b68da-2590-4540-b6c2-58a8bcef83a5	SE014A	3	D	t	APL67	f	2022-08-09 15:20:55.141532	2022-08-09 15:20:55.141532
2dc4f7a5-f78c-4b5f-bf7e-102630670c3d	SE014A	3	I	t	APL67	f	2022-08-09 15:20:55.147291	2022-08-09 15:20:55.147291
ff437c05-66d5-4eb2-848f-717b2c858ecf	SE014A	3	W	t	APL67	f	2022-08-09 15:20:55.153194	2022-08-09 15:20:55.153194
f232593c-2481-4090-ae11-818588a4d0b6	SE014A	3	Z	t	APL67	f	2022-08-09 15:20:55.158671	2022-08-09 15:20:55.158671
1c654c11-3346-4fed-a16f-c74af785a0b8	SE014A	3	A	f	APL67	f	2022-08-09 15:20:55.16509	2022-08-09 15:20:55.16509
d708b33e-3474-49ce-8a8f-0fcbacc5a4b4	SE014A	3	D	f	APL67	f	2022-08-09 15:20:55.170923	2022-08-09 15:20:55.170923
2fd856c8-7261-4ea0-bb08-3832428124f7	SE014A	3	I	f	APL67	f	2022-08-09 15:20:55.177414	2022-08-09 15:20:55.177414
8439efe2-c4c2-41da-a798-edf7ac4b14fc	SE014A	3	W	f	APL67	f	2022-08-09 15:20:55.183312	2022-08-09 15:20:55.183312
1422f0cf-eca6-46bc-a266-f0b69fb85711	SE014A	3	Z	f	APL67	f	2022-08-09 15:20:55.188963	2022-08-09 15:20:55.188963
7ffc523d-5a8c-4679-b7de-6474f5e60b2d	SE014A	3	A	t	APL68	f	2022-08-09 15:20:55.194397	2022-08-09 15:20:55.194397
c3927da4-55ce-4ce7-83c9-c4ec80716a6b	SE014A	3	D	t	APL68	f	2022-08-09 15:20:55.200401	2022-08-09 15:20:55.200401
5069f2ee-cbe7-4c0d-aff1-18fda2dc6d1c	SE014A	3	I	t	APL68	f	2022-08-09 15:20:55.205813	2022-08-09 15:20:55.205813
a1f59206-f756-4ec3-8b7e-389b24e09c86	SE014A	3	W	t	APL68	f	2022-08-09 15:20:55.211572	2022-08-09 15:20:55.211572
2d623788-f4e3-4dfb-8f9b-eb0d19a3c3f3	SE014A	3	Z	t	APL68	f	2022-08-09 15:20:55.217188	2022-08-09 15:20:55.217188
2034c27a-6e00-4dd5-84ef-833d9eb2122f	SE014A	3	A	f	APL68	f	2022-08-09 15:20:55.222889	2022-08-09 15:20:55.222889
031455a8-36f5-4350-b0c2-f08f79549677	SE014A	3	D	f	APL68	f	2022-08-09 15:20:55.228239	2022-08-09 15:20:55.228239
fe314252-3544-4234-b1bd-9a0ed1f6c891	SE014A	3	I	f	APL68	f	2022-08-09 15:20:55.234045	2022-08-09 15:20:55.234045
cafc5598-64d8-4997-8357-8698ac9b2536	SE014A	3	W	f	APL68	f	2022-08-09 15:20:55.239612	2022-08-09 15:20:55.239612
5e64e24b-2540-4c10-a8bd-05962c03ad52	SE014A	3	Z	f	APL68	f	2022-08-09 15:20:55.245166	2022-08-09 15:20:55.245166
15e0c124-729f-4894-b4c9-b12664b56fab	SE014A	3	A	t	APL69	f	2022-08-09 15:20:55.250955	2022-08-09 15:20:55.250955
34fe1ce5-8196-433a-b155-c2a464cd9ec3	SE014A	3	D	t	APL69	f	2022-08-09 15:20:55.256321	2022-08-09 15:20:55.256321
86d4a7a1-a999-4ec7-8191-1c21525433de	SE014A	3	I	t	APL69	f	2022-08-09 15:20:55.261765	2022-08-09 15:20:55.261765
4a4d1428-1036-4450-8e1d-a2b62769908e	SE014A	3	W	t	APL69	f	2022-08-09 15:20:55.267533	2022-08-09 15:20:55.267533
49787143-695f-439f-8c57-826282d8a73b	SE014A	3	Z	t	APL69	f	2022-08-09 15:20:55.273111	2022-08-09 15:20:55.273111
0a002d42-f787-48b0-8a31-ccd7d8a3de7d	SE014A	3	A	f	APL69	f	2022-08-09 15:20:55.278845	2022-08-09 15:20:55.278845
f29e6468-1431-484f-8ac4-099419c6e2be	SE014A	3	D	f	APL69	f	2022-08-09 15:20:55.284371	2022-08-09 15:20:55.284371
ab2ac38d-7d2c-4185-8161-452a3932e3b3	SE014A	3	I	f	APL69	f	2022-08-09 15:20:55.289879	2022-08-09 15:20:55.289879
9a729272-f5be-4d8b-b4cc-55c53f807a37	SE014A	3	W	f	APL69	f	2022-08-09 15:20:55.295846	2022-08-09 15:20:55.295846
b497ccb8-6127-4a4f-ae09-114f51edbfdc	SE014A	3	Z	f	APL69	f	2022-08-09 15:20:55.301229	2022-08-09 15:20:55.301229
ca122fbf-7dbe-462e-9963-80e7d94241cd	SE014A	3	A	t	APL70	f	2022-08-09 15:20:55.307063	2022-08-09 15:20:55.307063
196225f6-caef-4093-af30-da206910806d	SE014A	3	D	t	APL70	f	2022-08-09 15:20:55.312465	2022-08-09 15:20:55.312465
fdce4b09-07ef-4676-9442-88f85a105b45	SE014A	3	I	t	APL70	f	2022-08-09 15:20:55.317844	2022-08-09 15:20:55.317844
7f6073fb-2d89-4519-b56b-ca9cb8654b91	SE014A	3	W	t	APL70	f	2022-08-09 15:20:55.323452	2022-08-09 15:20:55.323452
1a3157cd-22c1-4f17-8b01-2aa69d857a91	SE014A	3	Z	t	APL70	f	2022-08-09 15:20:55.328881	2022-08-09 15:20:55.328881
3884c5a2-3d2e-4d80-a8e5-ab45ebb47c99	SE014A	3	A	f	APL70	f	2022-08-09 15:20:55.334629	2022-08-09 15:20:55.334629
ad41b042-ed3b-44b0-9fbc-0a1fde0b2f31	SE014A	3	D	f	APL70	f	2022-08-09 15:20:55.340306	2022-08-09 15:20:55.340306
7ad7249d-3426-45cc-903a-e08ffc7481c1	SE014A	3	I	f	APL70	f	2022-08-09 15:20:55.346467	2022-08-09 15:20:55.346467
fa9a4956-55f5-47c8-9494-b11f4a480beb	SE014A	3	W	f	APL70	f	2022-08-09 15:20:55.353263	2022-08-09 15:20:55.353263
d017f795-0996-44fe-9e59-8c70325ac54d	SE014A	3	Z	f	APL70	f	2022-08-09 15:20:55.358842	2022-08-09 15:20:55.358842
22625773-4a6d-424e-9443-57fabd7539eb	SE014A	3	A	t	CV027	f	2022-08-09 15:20:55.366001	2022-08-09 15:20:55.366001
608ac48c-4692-4a60-b3be-4640e49bdcfb	SE014A	3	D	t	CV027	f	2022-08-09 15:20:55.372168	2022-08-09 15:20:55.372168
f7b83e33-bb9a-4473-b78b-691351c8ce30	SE014A	3	I	t	CV027	f	2022-08-09 15:20:55.378429	2022-08-09 15:20:55.378429
03c67370-671f-4bc5-980f-83af2ffbb4e5	SE014A	3	W	t	CV027	f	2022-08-09 15:20:55.384702	2022-08-09 15:20:55.384702
7f85c0fa-5b99-44c7-8b13-53105e03b292	SE014A	3	Z	t	CV027	f	2022-08-09 15:20:55.390723	2022-08-09 15:20:55.390723
cb588d1f-692a-4392-a9fe-72e6b47b1a89	SE014A	3	A	f	CV027	f	2022-08-09 15:20:55.396665	2022-08-09 15:20:55.396665
ba880111-575d-4a9e-a93c-12a732fdc853	SE014A	3	D	f	CV027	f	2022-08-09 15:20:55.40282	2022-08-09 15:20:55.40282
e573011d-f744-4eae-bce8-0428baf93462	SE014A	3	I	f	CV027	f	2022-08-09 15:20:55.408398	2022-08-09 15:20:55.408398
e1b50a3a-f21d-461c-9610-cec78889a3f4	SE014A	3	W	f	CV027	f	2022-08-09 15:20:55.414096	2022-08-09 15:20:55.414096
fef4c1c1-e156-49a6-b85c-cf9735ff1806	SE014A	3	Z	f	CV027	f	2022-08-09 15:20:55.419986	2022-08-09 15:20:55.419986
b01986cb-1400-40f0-9ad8-03494b02ae20	SE014A	3	A	t	CV079	f	2022-08-09 15:20:55.425636	2022-08-09 15:20:55.425636
14177c1b-50bf-4a5e-8bf1-71a2b1e76a58	SE014A	3	D	t	CV079	f	2022-08-09 15:20:55.431417	2022-08-09 15:20:55.431417
1de898ce-95c0-4581-8351-81fb82f21da9	SE014A	3	I	t	CV079	f	2022-08-09 15:20:55.436942	2022-08-09 15:20:55.436942
b87903bd-3a99-4b64-a839-426533967f0e	SE014A	3	W	t	CV079	f	2022-08-09 15:20:55.442759	2022-08-09 15:20:55.442759
c9f59b8e-9ed1-4cbf-8350-bd28d1ac813c	SE014A	3	Z	t	CV079	f	2022-08-09 15:20:55.448381	2022-08-09 15:20:55.448381
a02691fa-d3d2-4dfd-a2ca-754164823f5c	SE014A	3	A	f	CV118	f	2022-08-09 15:20:55.514194	2022-08-09 15:20:55.514194
555daf94-2652-4225-b2a6-918fde55d8c5	SE014A	3	D	f	CV118	f	2022-08-09 15:20:55.519715	2022-08-09 15:20:55.519715
e25a19ae-dee5-4be0-843f-4f44be0b7c8a	SE014A	3	I	f	CV118	f	2022-08-09 15:20:55.525522	2022-08-09 15:20:55.525522
44bcb110-ce80-4a1a-a2c0-43ccaa32013d	SE014A	3	W	f	CV118	f	2022-08-09 15:20:55.531494	2022-08-09 15:20:55.531494
03ab447a-6e05-4155-98bc-e8776addbb98	SE014A	3	Z	f	CV118	f	2022-08-09 15:20:55.537214	2022-08-09 15:20:55.537214
9b5f7358-2da7-4ba5-88ef-f88e8406a802	SE014A	3	A	f	CV079	t	2022-08-09 15:20:55.45409	2022-08-09 15:20:55.544743
0ab155ad-3451-49f5-b71d-f6f67c1b019e	SE014A	3	D	f	CV079	t	2022-08-09 15:20:55.45987	2022-08-09 15:20:55.553826
e72bb8b1-d37b-4018-ba2d-cfee08f8a47e	SE014A	3	I	f	CV079	t	2022-08-09 15:20:55.466623	2022-08-09 15:20:55.561547
c372359f-ab9e-48ea-b3e8-080521d660be	SE014A	3	W	f	CV079	t	2022-08-09 15:20:55.473087	2022-08-09 15:20:55.569288
2714873b-44d8-4093-bb15-cb225b1e1b1d	SE014A	3	Z	f	CV079	t	2022-08-09 15:20:55.47885	2022-08-09 15:20:55.576721
f24a6210-837e-4cfe-864e-6b83e15fc151	SE014A	3	A	t	CV118	t	2022-08-09 15:20:55.484768	2022-08-09 15:20:55.583957
f1872a1a-0f2a-4388-827f-9fc5962c4054	SE014A	3	D	t	CV118	t	2022-08-09 15:20:55.4908	2022-08-09 15:20:55.591425
0ba09690-94f3-4b30-a036-3f86471ca384	SE014A	3	I	t	CV118	t	2022-08-09 15:20:55.496502	2022-08-09 15:20:55.598927
73fa10d2-0343-44a4-b352-4cb12c7bcf17	SE014A	3	W	t	CV118	t	2022-08-09 15:20:55.502332	2022-08-09 15:20:55.606327
58c46ce5-7b74-404e-a893-3191011b998e	SE014A	3	Z	t	CV118	t	2022-08-09 15:20:55.508102	2022-08-09 15:20:55.614101
8e442494-56de-4931-b32f-894d68f823d9	SE015A	3	A	t	APL09	f	2022-08-09 15:20:55.620191	2022-08-09 15:20:55.620191
1e5cb9ff-3b05-494f-a16a-0e8e9778a446	SE015A	3	D	t	APL09	f	2022-08-09 15:20:55.625831	2022-08-09 15:20:55.625831
14d7cd48-c851-49bc-ac57-0793d58bd178	SE015A	3	I	t	APL09	f	2022-08-09 15:20:55.631999	2022-08-09 15:20:55.631999
f42bb3af-b395-4009-bd0a-41d69a5ecf71	SE015A	3	W	t	APL09	f	2022-08-09 15:20:55.637874	2022-08-09 15:20:55.637874
db5a6bac-30c8-4b7b-90d8-94a104810a23	SE015A	3	Z	t	APL09	f	2022-08-09 15:20:55.643539	2022-08-09 15:20:55.643539
ef814d76-9fc4-4e12-93cc-f5b91c23039b	SE015A	3	A	f	APL09	f	2022-08-09 15:20:55.650021	2022-08-09 15:20:55.650021
3dc99a2f-0f62-4d8f-b686-446c915fe656	SE015A	3	D	f	APL09	f	2022-08-09 15:20:55.655693	2022-08-09 15:20:55.655693
c76f2263-c335-45a9-9072-ae98087151de	SE015A	3	I	f	APL09	f	2022-08-09 15:20:55.661799	2022-08-09 15:20:55.661799
51dd77ec-d38e-4e50-a89a-835b4d611ccf	SE015A	3	W	f	APL09	f	2022-08-09 15:20:55.668632	2022-08-09 15:20:55.668632
9d69da43-6f83-4f17-af00-12fda68bf5f6	SE015A	3	Z	f	APL09	f	2022-08-09 15:20:55.674495	2022-08-09 15:20:55.674495
3148e3cc-c049-42ec-bb98-c67fc1b81dac	SE015A	3	A	t	APL07	f	2022-08-09 15:20:55.680804	2022-08-09 15:20:55.680804
14e49e75-5a65-4fc5-a11f-86cca556a5f0	SE015A	3	D	t	APL07	f	2022-08-09 15:20:55.686933	2022-08-09 15:20:55.686933
810e234b-418e-4f21-820b-9af1c40a921a	SE015A	3	I	t	APL07	f	2022-08-09 15:20:55.693493	2022-08-09 15:20:55.693493
ca288768-488f-4d3d-bebf-5d607effca31	SE015A	3	W	t	APL07	f	2022-08-09 15:20:55.700281	2022-08-09 15:20:55.700281
5de00db9-6583-4543-8f60-2d59d9633ffd	SE015A	3	Z	t	APL07	f	2022-08-09 15:20:55.706002	2022-08-09 15:20:55.706002
5facb100-c152-43ab-99a7-df9bf1f24dc2	SE015A	3	A	f	APL07	f	2022-08-09 15:20:55.712615	2022-08-09 15:20:55.712615
7e80a0b9-004e-4032-8d5f-9b3430b9feb7	SE015A	3	D	f	APL07	f	2022-08-09 15:20:55.718759	2022-08-09 15:20:55.718759
20a4cbb8-6106-4e18-a700-a8ba4a604b20	SE015A	3	I	f	APL07	f	2022-08-09 15:20:55.724492	2022-08-09 15:20:55.724492
47e1fee6-acf4-4ef3-bbae-e4ff5a605daa	SE015A	3	W	f	APL07	f	2022-08-09 15:20:55.731327	2022-08-09 15:20:55.731327
577a7f0f-5c4b-407d-a607-6334475da9eb	SE015A	3	Z	f	APL07	f	2022-08-09 15:20:55.737195	2022-08-09 15:20:55.737195
d28e8e1c-a794-499d-bbb3-ba3e99008a86	SE015A	3	A	t	APL11	f	2022-08-09 15:20:55.742966	2022-08-09 15:20:55.742966
f52d064c-64e0-4a0e-b621-30f257cada9c	SE015A	3	D	t	APL11	f	2022-08-09 15:20:55.749473	2022-08-09 15:20:55.749473
6517b345-e2e0-4d7b-a3c3-76f1ca49645b	SE015A	3	I	t	APL11	f	2022-08-09 15:20:55.755173	2022-08-09 15:20:55.755173
a74007d1-b047-424e-b21f-3b7f2478b8c8	SE015A	3	W	t	APL11	f	2022-08-09 15:20:55.761078	2022-08-09 15:20:55.761078
ae84cae9-7e9a-466a-a604-f6b3e3b9a0a3	SE015A	3	Z	t	APL11	f	2022-08-09 15:20:55.767525	2022-08-09 15:20:55.767525
e01ef615-3d0c-4732-b331-95e07e888921	SE015A	3	A	f	APL11	f	2022-08-09 15:20:55.77307	2022-08-09 15:20:55.77307
b5681ef3-2bf8-4e06-8883-ca4cab4d51e2	SE015A	3	D	f	APL11	f	2022-08-09 15:20:55.779603	2022-08-09 15:20:55.779603
8ef56c11-b0d1-41c2-96dc-45b101b59363	SE015A	3	I	f	APL11	f	2022-08-09 15:20:55.785902	2022-08-09 15:20:55.785902
6862f442-2ac0-47df-ba81-a873fa87a46e	SE015A	3	W	f	APL11	f	2022-08-09 15:20:55.791678	2022-08-09 15:20:55.791678
3b7d90cc-d656-4a09-ae60-6090966a59ad	SE015A	3	Z	f	APL11	f	2022-08-09 15:20:55.797678	2022-08-09 15:20:55.797678
c090d298-ad20-42fa-be66-7dd1c6fd56c9	SE015A	3	A	t	APL13	f	2022-08-09 15:20:55.803724	2022-08-09 15:20:55.803724
2cee5400-bb4b-4d05-b7d2-ffb801cff7bb	SE015A	3	D	t	APL13	f	2022-08-09 15:20:55.809522	2022-08-09 15:20:55.809522
d4a1dd77-0858-4843-b8eb-de74a3391b91	SE015A	3	I	t	APL13	f	2022-08-09 15:20:55.817849	2022-08-09 15:20:55.817849
18b80b3d-c157-4bab-a74e-4fcad7ed0c64	SE015A	3	W	t	APL13	f	2022-08-09 15:20:55.82412	2022-08-09 15:20:55.82412
6fa2a8a8-3678-43fc-8ea5-8f18b21ef33e	SE015A	3	Z	t	APL13	f	2022-08-09 15:20:55.83149	2022-08-09 15:20:55.83149
c8e100a5-d1f2-47e7-a911-fbc6943253c2	SE015A	3	A	f	APL13	f	2022-08-09 15:20:55.837194	2022-08-09 15:20:55.837194
13768670-9871-47d2-ae5b-037945477cf8	SE015A	3	D	f	APL13	f	2022-08-09 15:20:55.842938	2022-08-09 15:20:55.842938
518fcc8d-0706-425a-bb11-94cbd2ed3b94	SE015A	3	I	f	APL13	f	2022-08-09 15:20:55.84833	2022-08-09 15:20:55.84833
e45efb6a-5796-4958-8312-49a68d4bb8df	SE015A	3	W	f	APL13	f	2022-08-09 15:20:55.854384	2022-08-09 15:20:55.854384
fb99791b-eafb-48ef-a38e-4ac9d672837e	SE015A	3	Z	f	APL13	f	2022-08-09 15:20:55.860215	2022-08-09 15:20:55.860215
2b93486c-2876-40e4-b7ce-86e1a9ed7055	SE015A	3	A	t	APL15	f	2022-08-09 15:20:55.865759	2022-08-09 15:20:55.865759
41ed9390-ac7f-4c17-9c1b-3c29ad401ff0	SE015A	3	D	t	APL15	f	2022-08-09 15:20:55.871656	2022-08-09 15:20:55.871656
9d45c13c-08de-4f30-be9b-da21938e4042	SE015A	3	I	t	APL15	f	2022-08-09 15:20:55.877561	2022-08-09 15:20:55.877561
13e6a05b-f2f8-40c1-bfa4-f6ed77e529cd	SE015A	3	W	t	APL15	f	2022-08-09 15:20:55.883312	2022-08-09 15:20:55.883312
ab6065c0-adb2-40b6-a60c-bc2eb92dd1b1	SE015A	3	Z	t	APL15	f	2022-08-09 15:20:55.889122	2022-08-09 15:20:55.889122
31e56756-7a88-4bb1-bdb7-11cb28255713	SE015A	3	A	f	APL15	f	2022-08-09 15:20:55.894792	2022-08-09 15:20:55.894792
9a9eaae8-3c65-4722-8625-6de7d9338c23	SE015A	3	D	f	APL15	f	2022-08-09 15:20:55.901468	2022-08-09 15:20:55.901468
b809f8cc-6c4f-4b53-9bbc-e359a71e92f0	SE015A	3	I	f	APL15	f	2022-08-09 15:20:55.907182	2022-08-09 15:20:55.907182
2f5b0c05-2a5a-4614-a215-07f3f064d162	SE015A	3	W	f	APL15	f	2022-08-09 15:20:55.913271	2022-08-09 15:20:55.913271
3fbc7327-9210-427b-aabb-00d47d8e2a35	SE015A	3	Z	f	APL15	f	2022-08-09 15:20:55.918776	2022-08-09 15:20:55.918776
b60a44eb-2a57-44f0-837f-3b1f5cd019de	SE015A	3	A	t	APL16	f	2022-08-09 15:20:55.924671	2022-08-09 15:20:55.924671
756a73fc-e6dc-4e94-9f55-0b60f21e0f5a	SE015A	3	D	t	APL16	f	2022-08-09 15:20:55.930584	2022-08-09 15:20:55.930584
7c03676e-f80c-4d3d-a4b7-48fc365e6241	SE015A	3	I	t	APL16	f	2022-08-09 15:20:55.936645	2022-08-09 15:20:55.936645
e3dbb678-5cde-40f1-b94b-4f3b5987d849	SE015A	3	W	t	APL16	f	2022-08-09 15:20:55.94277	2022-08-09 15:20:55.94277
8cc17eb8-07b5-4ff6-b575-015326b6dadb	SE015A	3	Z	t	APL16	f	2022-08-09 15:20:55.948523	2022-08-09 15:20:55.948523
e29467a9-bc1d-436d-998c-0d092af39c68	SE015A	3	A	f	APL16	f	2022-08-09 15:20:55.954451	2022-08-09 15:20:55.954451
2cb6d0ea-6c9c-4971-926e-ffc7f3cc57cf	SE015A	3	D	f	APL16	f	2022-08-09 15:20:55.960471	2022-08-09 15:20:55.960471
72a4b920-fd40-4d42-8478-713b0bfde823	SE015A	3	I	f	APL16	f	2022-08-09 15:20:55.966206	2022-08-09 15:20:55.966206
3378744a-aa3f-42cf-9794-b44bbc8dae42	SE015A	3	W	f	APL16	f	2022-08-09 15:20:55.97228	2022-08-09 15:20:55.97228
4eab9d21-fda4-4469-971b-306a74b97048	SE015A	3	Z	f	APL16	f	2022-08-09 15:20:55.978173	2022-08-09 15:20:55.978173
d9ea1583-8fc3-4630-8b02-18a91723891b	SE015A	3	A	t	APL18	f	2022-08-09 15:20:55.984582	2022-08-09 15:20:55.984582
2abf1903-b940-4c77-b514-ea38dd43a52f	SE015A	3	D	t	APL18	f	2022-08-09 15:20:55.991021	2022-08-09 15:20:55.991021
b4ed5e5d-a359-4b2c-92f3-ff1bba955f13	SE015A	3	I	t	APL18	f	2022-08-09 15:20:55.997261	2022-08-09 15:20:55.997261
04ff42ff-4181-4770-ac32-df4b37d1924d	SE015A	3	W	t	APL18	f	2022-08-09 15:20:56.003132	2022-08-09 15:20:56.003132
7d951a06-8776-47c2-ab82-86a97b3a1e5b	SE015A	3	Z	t	APL18	f	2022-08-09 15:20:56.009372	2022-08-09 15:20:56.009372
793fe0f1-e8d7-4fb4-b9b6-553b26882234	SE015A	3	A	f	APL18	f	2022-08-09 15:20:56.015416	2022-08-09 15:20:56.015416
c0b23f7c-df61-42f3-ba75-b9a319576004	SE015A	3	D	f	APL18	f	2022-08-09 15:20:56.021497	2022-08-09 15:20:56.021497
9c23f0f4-5ecd-45e1-bf44-031ce0102e4f	SE015A	3	I	f	APL18	f	2022-08-09 15:20:56.027111	2022-08-09 15:20:56.027111
7fde81e1-7f79-4cb1-9d04-a364549c4419	SE015A	3	W	f	APL18	f	2022-08-09 15:20:56.034031	2022-08-09 15:20:56.034031
0166f057-d078-49c4-9645-60a7082e86ac	SE015A	3	Z	f	APL18	f	2022-08-09 15:20:56.040159	2022-08-09 15:20:56.040159
d1627ec7-b9cc-471a-9c71-2b324dd0d8f9	SE015A	3	A	t	APL20	f	2022-08-09 15:20:56.046535	2022-08-09 15:20:56.046535
e5c9074d-cbfc-4bf2-8ee2-ecbd0fc68912	SE015A	3	D	t	APL20	f	2022-08-09 15:20:56.052523	2022-08-09 15:20:56.052523
db43ca5a-7a1a-4528-a511-0eae45fa9699	SE015A	3	I	t	APL20	f	2022-08-09 15:20:56.058105	2022-08-09 15:20:56.058105
fc5c43dd-c65f-4352-a52f-c1d30136f732	SE015A	3	W	t	APL20	f	2022-08-09 15:20:56.06417	2022-08-09 15:20:56.06417
584be2a1-6918-481e-9402-2d3a89660bc8	SE015A	3	Z	t	APL20	f	2022-08-09 15:20:56.070241	2022-08-09 15:20:56.070241
f2831a59-297f-45a4-bcf6-520d520e8a00	SE015A	3	A	f	APL20	f	2022-08-09 15:20:56.076118	2022-08-09 15:20:56.076118
5d0c7915-563b-4079-a188-efc20eb6fe5a	SE015A	3	D	f	APL20	f	2022-08-09 15:20:56.084134	2022-08-09 15:20:56.084134
b7d04bb3-cef0-4083-973a-75ee5afe2401	SE015A	3	I	f	APL20	f	2022-08-09 15:20:56.090357	2022-08-09 15:20:56.090357
3ee2a510-c24f-4710-999c-a29cc9bc9621	SE015A	3	W	f	APL20	f	2022-08-09 15:20:56.096365	2022-08-09 15:20:56.096365
f125438d-4e3d-4d98-93fb-9bf0f63485ec	SE015A	3	Z	f	APL20	f	2022-08-09 15:20:56.101846	2022-08-09 15:20:56.101846
94d2bda3-ef13-41a9-82a3-4c31a8622afb	SE015A	3	A	t	APL22	f	2022-08-09 15:20:56.107907	2022-08-09 15:20:56.107907
0158ece0-8d71-4657-bdce-4478072884d4	SE015A	3	D	t	APL22	f	2022-08-09 15:20:56.114248	2022-08-09 15:20:56.114248
3086f203-b545-45e7-8fc5-f8160611f10e	SE015A	3	I	t	APL22	f	2022-08-09 15:20:56.119991	2022-08-09 15:20:56.119991
7e7e5346-0f45-471e-9db4-b3711ffebf94	SE015A	3	W	t	APL22	f	2022-08-09 15:20:56.125567	2022-08-09 15:20:56.125567
6c1c52e7-84a5-4cfc-9e2a-4bb129d04377	SE015A	3	Z	t	APL22	f	2022-08-09 15:20:56.13214	2022-08-09 15:20:56.13214
6c1fe25f-09d0-4e08-82a6-ab1c2658a58a	SE015A	3	A	f	APL22	f	2022-08-09 15:20:56.137842	2022-08-09 15:20:56.137842
98a51a77-e290-47e7-84c1-eb70558f925e	SE015A	3	D	f	APL22	f	2022-08-09 15:20:56.143994	2022-08-09 15:20:56.143994
8c8c20b1-573b-4cce-b86b-bd4482b2e015	SE015A	3	I	f	APL22	f	2022-08-09 15:20:56.150141	2022-08-09 15:20:56.150141
5be1087d-ba30-4949-89aa-cc51462ee48e	SE015A	3	W	f	APL22	f	2022-08-09 15:20:56.155687	2022-08-09 15:20:56.155687
df803d42-bd29-4a18-bbb5-add9425f8502	SE015A	3	Z	f	APL22	f	2022-08-09 15:20:56.163598	2022-08-09 15:20:56.163598
30aef83e-7859-488c-80a4-603cc9c13e70	SE015A	3	A	t	APL27	f	2022-08-09 15:20:56.170189	2022-08-09 15:20:56.170189
5bb0ea90-3a3e-4880-bebb-19146a6a7da1	SE015A	3	D	t	APL27	f	2022-08-09 15:20:56.176563	2022-08-09 15:20:56.176563
b280b9e3-b6bb-4ddf-b7ed-b7ef3a1161d8	SE015A	3	I	t	APL27	f	2022-08-09 15:20:56.183298	2022-08-09 15:20:56.183298
db8e2de5-8f07-49eb-8c5a-4927eadedcc9	SE015A	3	W	t	APL27	f	2022-08-09 15:20:56.189193	2022-08-09 15:20:56.189193
d57ae0b6-deed-47c6-a0ba-87ca1da30e3a	SE015A	3	Z	t	APL27	f	2022-08-09 15:20:56.19557	2022-08-09 15:20:56.19557
1a1d9199-323b-42e5-b3ae-833d6bc2fe7b	SE015A	3	A	f	APL27	f	2022-08-09 15:20:56.201989	2022-08-09 15:20:56.201989
6a24f34b-8a2c-48c9-80ee-e8f3c230eb26	SE015A	3	D	f	APL27	f	2022-08-09 15:20:56.207908	2022-08-09 15:20:56.207908
1a46634f-bc6b-492a-91e4-179d2b83d74e	SE015A	3	I	f	APL27	f	2022-08-09 15:20:56.213976	2022-08-09 15:20:56.213976
8c77dd6e-94cf-4dab-9202-d84d6186c11f	SE015A	3	W	f	APL27	f	2022-08-09 15:20:56.219993	2022-08-09 15:20:56.219993
d77bfe85-cbb4-4032-acfd-47055430e7c4	SE015A	3	Z	f	APL27	f	2022-08-09 15:20:56.225682	2022-08-09 15:20:56.225682
efa2219a-5d01-4dd6-96e3-278f6ee42ed5	SE015A	3	A	t	APL29	f	2022-08-09 15:20:56.232319	2022-08-09 15:20:56.232319
37d4487a-832d-42d1-97e8-8126af3430a0	SE015A	3	D	t	APL29	f	2022-08-09 15:20:56.238075	2022-08-09 15:20:56.238075
318a179b-5e59-41b5-8f3c-6cab0c4c6115	SE015A	3	I	t	APL29	f	2022-08-09 15:20:56.244231	2022-08-09 15:20:56.244231
e4a6611e-7a21-4d50-be84-15cf43ffa767	SE015A	3	W	t	APL29	f	2022-08-09 15:20:56.250492	2022-08-09 15:20:56.250492
2eca695f-483d-4cfe-a677-ddf2a38e7a49	SE015A	3	Z	t	APL29	f	2022-08-09 15:20:56.256382	2022-08-09 15:20:56.256382
ba1cd56d-8801-4d1d-8a76-263b34cde371	SE015A	3	A	f	APL29	f	2022-08-09 15:20:56.261921	2022-08-09 15:20:56.261921
f1dec705-dd79-4d42-b32a-0785d22a834b	SE015A	3	D	f	APL29	f	2022-08-09 15:20:56.26782	2022-08-09 15:20:56.26782
b48d0afb-c9a4-4907-aeca-e2555566d678	SE015A	3	I	f	APL29	f	2022-08-09 15:20:56.273231	2022-08-09 15:20:56.273231
a765f7c0-8251-44c4-84dd-4e230fe5ecae	SE015A	3	W	f	APL29	f	2022-08-09 15:20:56.278792	2022-08-09 15:20:56.278792
9a7ddfed-e1ad-474c-8017-f7d1e6cb428a	SE015A	3	Z	f	APL29	f	2022-08-09 15:20:56.28466	2022-08-09 15:20:56.28466
d941c167-b0fe-4937-9fe2-e896bfadd34f	SE015A	3	A	t	APL31	f	2022-08-09 15:20:56.290817	2022-08-09 15:20:56.290817
3fdb432b-c7f4-421e-9514-17bfe7187ccf	SE015A	3	D	t	APL31	f	2022-08-09 15:20:56.296865	2022-08-09 15:20:56.296865
6d36f932-a163-4cee-aa25-f3735ec8fcaa	SE015A	3	I	t	APL31	f	2022-08-09 15:20:56.302789	2022-08-09 15:20:56.302789
3e52188b-9659-4f88-92aa-515a96863958	SE015A	3	W	t	APL31	f	2022-08-09 15:20:56.308594	2022-08-09 15:20:56.308594
24916b69-f77c-40ac-8409-0a45b950ad0d	SE015A	3	Z	t	APL31	f	2022-08-09 15:20:56.315481	2022-08-09 15:20:56.315481
d66488c4-174f-493e-be84-b48fd5684c12	SE015A	3	A	f	APL31	f	2022-08-09 15:20:56.321533	2022-08-09 15:20:56.321533
5b9415ed-c179-412b-87bc-fd6ac863afaa	SE015A	3	D	f	APL31	f	2022-08-09 15:20:56.327856	2022-08-09 15:20:56.327856
e81ee970-88ac-4cd3-8d7b-51697a190971	SE015A	3	I	f	APL31	f	2022-08-09 15:20:56.334484	2022-08-09 15:20:56.334484
8e5213d9-d4d6-4c6a-9f1f-8ad34f6f970e	SE015A	3	W	f	APL31	f	2022-08-09 15:20:56.340128	2022-08-09 15:20:56.340128
7be8f3f0-7833-47fe-bc70-553a36213186	SE015A	3	Z	f	APL31	f	2022-08-09 15:20:56.347971	2022-08-09 15:20:56.347971
64de3189-cd0c-425a-8f6a-24b0ab5c784b	SE015A	3	A	t	APL48	f	2022-08-09 15:20:56.353849	2022-08-09 15:20:56.353849
dde1689e-9483-4503-8f57-48cd9b0b17f4	SE015A	3	D	t	APL48	f	2022-08-09 15:20:56.35976	2022-08-09 15:20:56.35976
2ba755c9-53ca-49fe-9da0-deac899b251c	SE015A	3	I	t	APL48	f	2022-08-09 15:20:56.366278	2022-08-09 15:20:56.366278
bace38e5-cfaa-48f5-9d07-21913a621f29	SE015A	3	W	t	APL48	f	2022-08-09 15:20:56.372168	2022-08-09 15:20:56.372168
2f77d756-2c07-4b33-95e7-3818ddb3ca65	SE015A	3	Z	t	APL48	f	2022-08-09 15:20:56.379455	2022-08-09 15:20:56.379455
9723ce2b-9568-4e19-aa69-7e86d1879eea	SE015A	3	A	f	APL48	f	2022-08-09 15:20:56.385617	2022-08-09 15:20:56.385617
a5281438-febf-4c95-84a7-e07c1092f503	SE015A	3	D	f	APL48	f	2022-08-09 15:20:56.390927	2022-08-09 15:20:56.390927
2c90a697-1e6f-43a4-8dcc-e8b2e89e80be	SE015A	3	I	f	APL48	f	2022-08-09 15:20:56.397788	2022-08-09 15:20:56.397788
69e582c0-7e85-403c-9291-21f12fba137a	SE015A	3	W	f	APL48	f	2022-08-09 15:20:56.404006	2022-08-09 15:20:56.404006
c562baf0-516a-4cbb-88fe-c571e9437017	SE015A	3	Z	f	APL48	f	2022-08-09 15:20:56.410814	2022-08-09 15:20:56.410814
3201ac3e-1aa0-45d7-a12f-3a4e2cc6eeb0	SE015A	3	A	t	APL49	f	2022-08-09 15:20:56.417319	2022-08-09 15:20:56.417319
29ab426d-fcc9-4f8e-872c-7344f743cb49	SE015A	3	D	t	APL49	f	2022-08-09 15:20:56.422904	2022-08-09 15:20:56.422904
dfed8b38-b06a-4354-939e-3a8b98c67623	SE015A	3	I	t	APL49	f	2022-08-09 15:20:56.428804	2022-08-09 15:20:56.428804
1f32417a-cf50-44f3-a159-d1285f647e9a	SE015A	3	W	t	APL49	f	2022-08-09 15:20:56.435205	2022-08-09 15:20:56.435205
627811e4-8010-4611-af6c-8077ce2c50b7	SE015A	3	Z	t	APL49	f	2022-08-09 15:20:56.440783	2022-08-09 15:20:56.440783
c325a33b-4560-478b-8aa5-b678a0cd360d	SE015A	3	A	f	APL49	f	2022-08-09 15:20:56.44718	2022-08-09 15:20:56.44718
b8cb8566-591a-457b-b1fb-527372cafe9a	SE015A	3	D	f	APL49	f	2022-08-09 15:20:56.45318	2022-08-09 15:20:56.45318
e13bd4e5-6983-4943-a164-b3bf68a13d5d	SE015A	3	I	f	APL49	f	2022-08-09 15:20:56.45878	2022-08-09 15:20:56.45878
6fcc6aa4-dabf-4bb1-88c3-434655aa8bbf	SE015A	3	W	f	APL49	f	2022-08-09 15:20:56.465413	2022-08-09 15:20:56.465413
bddf22f7-87f3-4155-8ab2-3c45f5236a03	SE015A	3	Z	f	APL49	f	2022-08-09 15:20:56.471325	2022-08-09 15:20:56.471325
55b5d0ee-a5e6-48b5-81bc-0498af5b5fad	SE015A	3	A	t	APL50	f	2022-08-09 15:20:56.477048	2022-08-09 15:20:56.477048
b8555444-8d59-4b07-be82-de5cf2aec790	SE015A	3	D	t	APL50	f	2022-08-09 15:20:56.48288	2022-08-09 15:20:56.48288
8a55c0d9-f614-485c-ab11-cb737a6f2153	SE015A	3	I	t	APL50	f	2022-08-09 15:20:56.488904	2022-08-09 15:20:56.488904
41f2e597-8681-4345-a057-3b9374fd3057	SE015A	3	W	t	APL50	f	2022-08-09 15:20:56.494685	2022-08-09 15:20:56.494685
ca33b31d-2793-43e9-b3ee-ff18029123e6	SE015A	3	Z	t	APL50	f	2022-08-09 15:20:56.501077	2022-08-09 15:20:56.501077
e5af1499-0fc0-4378-ab14-6763d7d45af1	SE015A	3	A	f	APL50	f	2022-08-09 15:20:56.506699	2022-08-09 15:20:56.506699
bcd4023a-ee18-4d6b-9fea-62cf6446a0df	SE015A	3	D	f	APL50	f	2022-08-09 15:20:56.512777	2022-08-09 15:20:56.512777
fcc33910-c784-4705-a4b2-91fbc8af989f	SE015A	3	I	f	APL50	f	2022-08-09 15:20:56.520684	2022-08-09 15:20:56.520684
a6dd2aa7-94ba-4277-b23b-ae3c060c0c5b	SE015A	3	W	f	APL50	f	2022-08-09 15:20:56.527595	2022-08-09 15:20:56.527595
a5b992d7-f832-4a54-9138-e20cf6508763	SE015A	3	Z	f	APL50	f	2022-08-09 15:20:56.533939	2022-08-09 15:20:56.533939
cd590c70-13c6-4d9b-85f2-27a494d05edf	SE015A	3	A	t	APL51	f	2022-08-09 15:20:56.540113	2022-08-09 15:20:56.540113
9005d969-dc4c-4db1-a735-85cd297ec319	SE015A	3	D	t	APL51	f	2022-08-09 15:20:56.545838	2022-08-09 15:20:56.545838
c2b7b193-b268-46c1-9380-10e9e3507950	SE015A	3	I	t	APL51	f	2022-08-09 15:20:56.5518	2022-08-09 15:20:56.5518
beb696c0-7d45-4f5a-8255-c1eb628710ae	SE015A	3	W	t	APL51	f	2022-08-09 15:20:56.557399	2022-08-09 15:20:56.557399
4ba22d1e-7b33-4130-a460-5669404b9c6d	SE015A	3	Z	t	APL51	f	2022-08-09 15:20:56.563119	2022-08-09 15:20:56.563119
c7a6e5b6-3699-483c-95e2-d0d6917a115f	SE015A	3	A	f	APL51	f	2022-08-09 15:20:56.568684	2022-08-09 15:20:56.568684
23b869c1-87e4-4218-99e3-6746fd045f2b	SE015A	3	D	f	APL51	f	2022-08-09 15:20:56.575714	2022-08-09 15:20:56.575714
cee60899-43bf-477f-960d-65365c71a5d3	SE015A	3	I	f	APL51	f	2022-08-09 15:20:56.584469	2022-08-09 15:20:56.584469
f3a73555-06de-4bec-9b54-1190bcb6f132	SE015A	3	W	f	APL51	f	2022-08-09 15:20:56.590535	2022-08-09 15:20:56.590535
c9b71190-061a-4c75-b25e-08ddac8db6dd	SE015A	3	Z	f	APL51	f	2022-08-09 15:20:56.596341	2022-08-09 15:20:56.596341
b1942a3e-8f96-4fbe-b4d9-1e67c32ac376	SE015A	3	A	t	APL52	f	2022-08-09 15:20:56.602579	2022-08-09 15:20:56.602579
689057cc-780d-4984-8505-83fac448ef48	SE015A	3	D	t	APL52	f	2022-08-09 15:20:56.608395	2022-08-09 15:20:56.608395
5cdd92ed-2069-4910-b3d3-272415fff688	SE015A	3	I	t	APL52	f	2022-08-09 15:20:56.614753	2022-08-09 15:20:56.614753
0b98dcb9-308b-4ebf-bd14-198291ea928c	SE015A	3	W	t	APL52	f	2022-08-09 15:20:56.620618	2022-08-09 15:20:56.620618
7e561d22-40cc-4712-b1c4-8a1550a23758	SE015A	3	Z	t	APL52	f	2022-08-09 15:20:56.626536	2022-08-09 15:20:56.626536
2a270245-121b-4277-96fa-c7a4d859be34	SE015A	3	A	f	APL52	f	2022-08-09 15:20:56.633111	2022-08-09 15:20:56.633111
73a2aa2f-af13-4f8e-abff-5b0fc1d75e0e	SE015A	3	D	f	APL52	f	2022-08-09 15:20:56.638914	2022-08-09 15:20:56.638914
c8217374-7c02-4454-9ca4-7fb00102d20c	SE015A	3	I	f	APL52	f	2022-08-09 15:20:56.644718	2022-08-09 15:20:56.644718
e1cf6a20-bf18-49e3-bf28-07d865d95231	SE015A	3	W	f	APL52	f	2022-08-09 15:20:56.651276	2022-08-09 15:20:56.651276
01f37161-4b7b-4416-b00a-de64db9f1692	SE015A	3	Z	f	APL52	f	2022-08-09 15:20:56.657164	2022-08-09 15:20:56.657164
2f5fb808-2baf-4702-bc40-e1062781d2e1	SE015A	3	A	t	APL53	f	2022-08-09 15:20:56.663367	2022-08-09 15:20:56.663367
bc676ca1-baf9-4dd4-a890-9ead5a5049cf	SE015A	3	D	t	APL53	f	2022-08-09 15:20:56.669026	2022-08-09 15:20:56.669026
c3be1d89-8f39-46b1-9ebf-1ddfae546029	SE015A	3	I	t	APL53	f	2022-08-09 15:20:56.674765	2022-08-09 15:20:56.674765
fdc4a2d8-908a-483b-8bb9-d3a587f06621	SE015A	3	W	t	APL53	f	2022-08-09 15:20:56.680113	2022-08-09 15:20:56.680113
5d6c195d-7f58-4255-9819-397638cad16c	SE015A	3	Z	t	APL53	f	2022-08-09 15:20:56.685441	2022-08-09 15:20:56.685441
1ea86ccf-40af-4ec9-b325-e2d0b6e838ab	SE015A	3	A	f	APL53	f	2022-08-09 15:20:56.691129	2022-08-09 15:20:56.691129
c7648b06-1348-487d-8c63-c6562c1e546e	SE015A	3	D	f	APL53	f	2022-08-09 15:20:56.69652	2022-08-09 15:20:56.69652
50915ae5-cc47-4745-a636-7622874cc1ce	SE015A	3	I	f	APL53	f	2022-08-09 15:20:56.701979	2022-08-09 15:20:56.701979
c533a44b-7c56-4924-b536-d37a04b3976f	SE015A	3	W	f	APL53	f	2022-08-09 15:20:56.707781	2022-08-09 15:20:56.707781
906211ad-f719-4016-b7dc-fa2c66942bac	SE015A	3	Z	f	APL53	f	2022-08-09 15:20:56.713282	2022-08-09 15:20:56.713282
31768b6a-f36d-443c-8359-4b1449ad7aef	SE015A	3	A	t	APL54	f	2022-08-09 15:20:56.719023	2022-08-09 15:20:56.719023
7b3a1997-021b-443c-8efb-8cea9964289b	SE015A	3	D	t	APL54	f	2022-08-09 15:20:56.724544	2022-08-09 15:20:56.724544
a63405a5-7341-465f-82d8-a7b701a48477	SE015A	3	I	t	APL54	f	2022-08-09 15:20:56.729932	2022-08-09 15:20:56.729932
acce68be-b20d-4302-afa3-49e1ff25aee6	SE015A	3	W	t	APL54	f	2022-08-09 15:20:56.736028	2022-08-09 15:20:56.736028
fa9a620a-f1c6-41dd-b0bc-0bd2f0190866	SE015A	3	Z	t	APL54	f	2022-08-09 15:20:56.741814	2022-08-09 15:20:56.741814
ad1c8f77-f0dd-49e2-a14e-b40a313026c1	SE015A	3	A	f	APL54	f	2022-08-09 15:20:56.747779	2022-08-09 15:20:56.747779
6c9f1353-37eb-4cb6-9a47-b7dda98a1697	SE015A	3	D	f	APL54	f	2022-08-09 15:20:56.75386	2022-08-09 15:20:56.75386
edfc171b-856e-4ce5-a8f5-6dc6b6a82964	SE015A	3	I	f	APL54	f	2022-08-09 15:20:56.759319	2022-08-09 15:20:56.759319
d74e8719-3cdc-403a-9d9f-1b980e0033a0	SE015A	3	W	f	APL54	f	2022-08-09 15:20:56.764782	2022-08-09 15:20:56.764782
5570491e-94da-4eee-bfa2-5270388ed782	SE015A	3	Z	f	APL54	f	2022-08-09 15:20:56.770572	2022-08-09 15:20:56.770572
b41765f9-ec9d-412f-aca7-0064e2eba06b	SE015A	3	A	t	APL55	f	2022-08-09 15:20:56.775933	2022-08-09 15:20:56.775933
850a2bfb-554d-47fb-aa4d-9a03425df0ec	SE015A	3	D	t	APL55	f	2022-08-09 15:20:56.782414	2022-08-09 15:20:56.782414
a7fed62a-2d81-4673-a9ff-4b0eabbf2669	SE015A	3	I	t	APL55	f	2022-08-09 15:20:56.788207	2022-08-09 15:20:56.788207
a9400c15-37c9-42c4-9f92-07d2a8f9a39b	SE015A	3	W	t	APL55	f	2022-08-09 15:20:56.794157	2022-08-09 15:20:56.794157
19dfef6b-7cf8-4871-b282-859c63e6c29d	SE015A	3	Z	t	APL55	f	2022-08-09 15:20:56.799951	2022-08-09 15:20:56.799951
0c5ebd6f-6ff4-47b9-81c0-217139cb13a0	SE015A	3	A	f	APL55	f	2022-08-09 15:20:56.805702	2022-08-09 15:20:56.805702
2fd430c5-3ca4-4352-a7e0-12791c0d8feb	SE015A	3	D	f	APL55	f	2022-08-09 15:20:56.811113	2022-08-09 15:20:56.811113
6da8c446-1b4a-4c8c-abc1-ce8d5a07f947	SE015A	3	I	f	APL55	f	2022-08-09 15:20:56.816863	2022-08-09 15:20:56.816863
9dc672b6-e427-488a-9202-8ecdf4aea5c4	SE015A	3	W	f	APL55	f	2022-08-09 15:20:56.82238	2022-08-09 15:20:56.82238
4074af53-916f-4360-815c-eb8577b156dd	SE015A	3	Z	f	APL55	f	2022-08-09 15:20:56.827863	2022-08-09 15:20:56.827863
12fa3edf-c87a-4db0-9d1e-cafe882d9b21	SE015A	3	A	t	APL56	f	2022-08-09 15:20:56.833849	2022-08-09 15:20:56.833849
f3c90895-181a-4dee-a196-134cc6f43160	SE015A	3	D	t	APL56	f	2022-08-09 15:20:56.840102	2022-08-09 15:20:56.840102
283d4abb-5824-458e-9e0f-4480d0079fbc	SE015A	3	I	t	APL56	f	2022-08-09 15:20:56.846052	2022-08-09 15:20:56.846052
602e7f0d-9496-4564-a2ae-c965aa68b0eb	SE015A	3	W	t	APL56	f	2022-08-09 15:20:56.852047	2022-08-09 15:20:56.852047
4b3176fd-8246-4260-b135-3568915c5939	SE015A	3	Z	t	APL56	f	2022-08-09 15:20:56.858549	2022-08-09 15:20:56.858549
51d55cf3-847f-42be-970d-bfbfe353b2fb	SE015A	3	A	f	APL56	f	2022-08-09 15:20:56.864525	2022-08-09 15:20:56.864525
670b2731-2956-4bc0-a442-5da5e22b0388	SE015A	3	D	f	APL56	f	2022-08-09 15:20:56.86997	2022-08-09 15:20:56.86997
a82a8ed3-6f27-4abb-9b20-f3b015f68d53	SE015A	3	I	f	APL56	f	2022-08-09 15:20:56.875946	2022-08-09 15:20:56.875946
348ec0bb-56c8-406d-8696-b6f8fa5260e1	SE015A	3	W	f	APL56	f	2022-08-09 15:20:56.882075	2022-08-09 15:20:56.882075
f8238a83-74b0-4de8-b3a3-16dd45c3f266	SE015A	3	Z	f	APL56	f	2022-08-09 15:20:56.888262	2022-08-09 15:20:56.888262
158e0921-211b-4441-a40d-914dc309d52e	SE015A	3	A	t	APL57	f	2022-08-09 15:20:56.894309	2022-08-09 15:20:56.894309
710fdc7f-331a-4757-be14-8c51deb5cfdb	SE015A	3	D	t	APL57	f	2022-08-09 15:20:56.900112	2022-08-09 15:20:56.900112
54dee012-f8b0-41fe-a583-e3496a14cb28	SE015A	3	I	t	APL57	f	2022-08-09 15:20:56.906081	2022-08-09 15:20:56.906081
31317228-47be-4077-a753-f8b9f758ef13	SE015A	3	W	t	APL57	f	2022-08-09 15:20:56.91174	2022-08-09 15:20:56.91174
4acfb505-3d01-49b3-ae2c-e0c4c79fd256	SE015A	3	Z	t	APL57	f	2022-08-09 15:20:56.917473	2022-08-09 15:20:56.917473
b7c328d3-f3f6-4f68-ba18-6c2458db7f43	SE015A	3	A	f	APL57	f	2022-08-09 15:20:56.922914	2022-08-09 15:20:56.922914
04648a8c-5734-4870-9b98-8564a40a5404	SE015A	3	D	f	APL57	f	2022-08-09 15:20:56.928489	2022-08-09 15:20:56.928489
bfc027fd-2987-46ca-8d41-abbad2ad8607	SE015A	3	I	f	APL57	f	2022-08-09 15:20:56.933823	2022-08-09 15:20:56.933823
f463eeea-8a6b-4a08-9d2d-7bdf7ae85fb5	SE015A	3	W	f	APL57	f	2022-08-09 15:20:56.939406	2022-08-09 15:20:56.939406
275e50f4-3b39-47b9-8f4d-f7c450ab1599	SE015A	3	Z	f	APL57	f	2022-08-09 15:20:56.944652	2022-08-09 15:20:56.944652
46831516-e278-442c-93f9-5630ce640189	SE015A	3	A	t	APL65	f	2022-08-09 15:20:56.950075	2022-08-09 15:20:56.950075
58b67eca-7e51-4a42-9690-8f719556c3ed	SE015A	3	D	t	APL65	f	2022-08-09 15:20:56.955926	2022-08-09 15:20:56.955926
55ccb8d6-4483-4af9-9810-c7cb72973b80	SE015A	3	I	t	APL65	f	2022-08-09 15:20:56.961247	2022-08-09 15:20:56.961247
87b3fe51-d6b1-49af-81ae-f2fa84f51463	SE015A	3	W	t	APL65	f	2022-08-09 15:20:56.966879	2022-08-09 15:20:56.966879
41b4e6a0-7c9b-4386-97e4-db3db8169d4f	SE015A	3	Z	t	APL65	f	2022-08-09 15:20:56.972424	2022-08-09 15:20:56.972424
2f019c2c-1867-452b-ab1a-363018b29c69	SE015A	3	A	f	APL65	f	2022-08-09 15:20:56.977853	2022-08-09 15:20:56.977853
f77b2167-eadc-4a61-b001-02cea8fa37c7	SE015A	3	D	f	APL65	f	2022-08-09 15:20:56.9836	2022-08-09 15:20:56.9836
bc0c8396-f00f-43fc-af6d-1247990e6d15	SE015A	3	I	f	APL65	f	2022-08-09 15:20:56.989101	2022-08-09 15:20:56.989101
fe086e43-5991-4021-b952-526474ea7cd0	SE015A	3	W	f	APL65	f	2022-08-09 15:20:56.99471	2022-08-09 15:20:56.99471
a3f7fce2-ecc4-48a4-ada5-7e7df8a71063	SE015A	3	Z	f	APL65	f	2022-08-09 15:20:57.000025	2022-08-09 15:20:57.000025
544082f9-e8b0-4a4a-9934-4cbc5ad0e143	SE015A	3	A	t	APL66	f	2022-08-09 15:20:57.0054	2022-08-09 15:20:57.0054
3782bc3b-976f-4d00-b338-0cd803b51196	SE015A	3	D	t	APL66	f	2022-08-09 15:20:57.011061	2022-08-09 15:20:57.011061
14110ac3-7f24-463a-a2d2-74d359dc1dab	SE015A	3	I	t	APL66	f	2022-08-09 15:20:57.016619	2022-08-09 15:20:57.016619
7c3fd09d-4bda-40e6-a5c6-7c4ba656d883	SE015A	3	W	t	APL66	f	2022-08-09 15:20:57.022412	2022-08-09 15:20:57.022412
9325fe23-67f7-4d38-815e-8280d707c651	SE015A	3	Z	t	APL66	f	2022-08-09 15:20:57.028014	2022-08-09 15:20:57.028014
bbc72b8b-7d9a-4b8a-ad54-01bbfbdb6b3e	SE015A	3	A	f	APL66	f	2022-08-09 15:20:57.033297	2022-08-09 15:20:57.033297
b452f990-ec51-4927-8b2e-e1da295b5d75	SE015A	3	D	f	APL66	f	2022-08-09 15:20:57.038836	2022-08-09 15:20:57.038836
67970b8e-3435-40bd-a48c-e7c399fbe964	SE015A	3	I	f	APL66	f	2022-08-09 15:20:57.044179	2022-08-09 15:20:57.044179
1f81abb3-6504-4ca5-9b93-5154a76d570d	SE015A	3	W	f	APL66	f	2022-08-09 15:20:57.050077	2022-08-09 15:20:57.050077
f4d3c9ea-98db-4e38-8419-762daa58feb3	SE015A	3	Z	f	APL66	f	2022-08-09 15:20:57.055717	2022-08-09 15:20:57.055717
b4c3104c-7dd0-4403-9231-e5fb87d451c9	SE015A	3	A	t	APL67	f	2022-08-09 15:20:57.061003	2022-08-09 15:20:57.061003
989554cc-9ecc-473b-8508-76e33aad99c1	SE015A	3	D	t	APL67	f	2022-08-09 15:20:57.066658	2022-08-09 15:20:57.066658
b11f4193-f322-4144-a7bc-73f4b6ff72ad	SE015A	3	I	t	APL67	f	2022-08-09 15:20:57.071965	2022-08-09 15:20:57.071965
4d81d06b-0734-45c9-aaa2-df845164c941	SE015A	3	W	t	APL67	f	2022-08-09 15:20:57.077243	2022-08-09 15:20:57.077243
682f5e17-d46d-4685-a62f-a3089fe79ebf	SE015A	3	Z	t	APL67	f	2022-08-09 15:20:57.082912	2022-08-09 15:20:57.082912
44a011f3-f480-46eb-8c77-fbf33fe810a3	SE015A	3	A	f	APL67	f	2022-08-09 15:20:57.088416	2022-08-09 15:20:57.088416
852c778d-8055-43a7-9832-b6d16f681caf	SE015A	3	D	f	APL67	f	2022-08-09 15:20:57.094814	2022-08-09 15:20:57.094814
a22f4f54-a627-48a9-946d-bebdb9b03ae8	SE015A	3	I	f	APL67	f	2022-08-09 15:20:57.101821	2022-08-09 15:20:57.101821
4a0f214b-2dba-4a21-9e69-dc263257a860	SE015A	3	W	f	APL67	f	2022-08-09 15:20:57.107514	2022-08-09 15:20:57.107514
41d69308-e28d-45f6-aacd-0657a09a34f9	SE015A	3	Z	f	APL67	f	2022-08-09 15:20:57.112842	2022-08-09 15:20:57.112842
0ddb78c3-b675-403d-84e2-c94bdabf872e	SE015A	3	A	t	APL68	f	2022-08-09 15:20:57.118549	2022-08-09 15:20:57.118549
7c809a84-f2e7-4dc6-9876-447fe49f9569	SE015A	3	D	t	APL68	f	2022-08-09 15:20:57.123842	2022-08-09 15:20:57.123842
4a553bb3-7054-4731-852e-2b9dad96843b	SE015A	3	I	t	APL68	f	2022-08-09 15:20:57.129558	2022-08-09 15:20:57.129558
5641e92e-c475-4b21-9f99-e48da1de1b47	SE015A	3	W	t	APL68	f	2022-08-09 15:20:57.134882	2022-08-09 15:20:57.134882
bdee63f6-227b-4d81-9926-1ed36280313a	SE015A	3	Z	t	APL68	f	2022-08-09 15:20:57.14034	2022-08-09 15:20:57.14034
b26ed4b9-c94f-4758-9aae-23d013c42f03	SE015A	3	A	f	APL68	f	2022-08-09 15:20:57.146017	2022-08-09 15:20:57.146017
c08c5a09-0774-47ca-8dae-a6e595ebddb2	SE015A	3	D	f	APL68	f	2022-08-09 15:20:57.151945	2022-08-09 15:20:57.151945
6daaa573-17c6-4700-9022-767204a8bfaf	SE015A	3	I	f	APL68	f	2022-08-09 15:20:57.159165	2022-08-09 15:20:57.159165
c7b5f129-577a-4cf0-b3f7-7391e3af67fb	SE015A	3	W	f	APL68	f	2022-08-09 15:20:57.16533	2022-08-09 15:20:57.16533
d5ec9ef9-c78b-450e-9a61-3b10dd365276	SE015A	3	Z	f	APL68	f	2022-08-09 15:20:57.171114	2022-08-09 15:20:57.171114
d2d30dde-37fb-4c6b-a15f-9e85cc54e216	SE015A	3	A	t	APL69	f	2022-08-09 15:20:57.176552	2022-08-09 15:20:57.176552
3dafede5-e376-49f6-967e-f5f4915473db	SE015A	3	D	t	APL69	f	2022-08-09 15:20:57.18186	2022-08-09 15:20:57.18186
d599dfb6-173a-47e8-81d9-99dea85eead9	SE015A	3	I	t	APL69	f	2022-08-09 15:20:57.188946	2022-08-09 15:20:57.188946
f1bdc4ca-de5a-4e1f-acb3-cc21dd538a1b	SE015A	3	W	t	APL69	f	2022-08-09 15:20:57.194875	2022-08-09 15:20:57.194875
bcbc7fd7-9772-4cdc-b6a2-a47b6fdc9a29	SE015A	3	Z	t	APL69	f	2022-08-09 15:20:57.200444	2022-08-09 15:20:57.200444
4acc5a0a-7ee2-4b2a-9ebf-c5fa0a8a0ac6	SE015A	3	A	f	APL69	f	2022-08-09 15:20:57.206942	2022-08-09 15:20:57.206942
e6a7be56-e94e-4dc9-9b49-d1d47c06ade1	SE015A	3	D	f	APL69	f	2022-08-09 15:20:57.213389	2022-08-09 15:20:57.213389
1fb4cc30-6eb9-410c-902b-3bd21699e834	SE015A	3	I	f	APL69	f	2022-08-09 15:20:57.219446	2022-08-09 15:20:57.219446
dfc0519e-74bb-4824-be99-d457e52e7163	SE015A	3	W	f	APL69	f	2022-08-09 15:20:57.22503	2022-08-09 15:20:57.22503
abefc67c-a341-4502-8866-931f251d5fed	SE015A	3	Z	f	APL69	f	2022-08-09 15:20:57.230799	2022-08-09 15:20:57.230799
11a535dc-5cf9-40bb-b876-179af154919f	SE015A	3	A	t	APL70	f	2022-08-09 15:20:57.236472	2022-08-09 15:20:57.236472
36f83d37-02bb-4f7c-aab5-a2bfa97ddc87	SE015A	3	D	t	APL70	f	2022-08-09 15:20:57.241752	2022-08-09 15:20:57.241752
0f188f4c-fdf6-4298-ac07-f3da2576ecce	SE015A	3	I	t	APL70	f	2022-08-09 15:20:57.247074	2022-08-09 15:20:57.247074
935894d5-8e02-4d54-b2b6-4f966b6a5a33	SE015A	3	W	t	APL70	f	2022-08-09 15:20:57.253929	2022-08-09 15:20:57.253929
3b67f234-02be-40e5-8549-e4e364756cf4	SE015A	3	Z	t	APL70	f	2022-08-09 15:20:57.260302	2022-08-09 15:20:57.260302
60b15680-9589-4f99-8b6c-4b026e5201ca	SE015A	3	A	f	APL70	f	2022-08-09 15:20:57.266573	2022-08-09 15:20:57.266573
0bbdad3a-872b-44ed-a1fa-dcac2f1610fb	SE015A	3	D	f	APL70	f	2022-08-09 15:20:57.271828	2022-08-09 15:20:57.271828
140f7f2b-e5af-4b4e-80ee-5681ef69506d	SE015A	3	I	f	APL70	f	2022-08-09 15:20:57.27746	2022-08-09 15:20:57.27746
85b5ae28-ddd8-478c-9b91-b16fc4b8c254	SE015A	3	W	f	APL70	f	2022-08-09 15:20:57.282856	2022-08-09 15:20:57.282856
9a5487f4-8f54-4446-ae10-a7ecccbd4e84	SE015A	3	Z	f	APL70	f	2022-08-09 15:20:57.289607	2022-08-09 15:20:57.289607
655ee9aa-e938-439f-8397-f2b77e0b097c	SE015A	3	A	t	CV027	f	2022-08-09 15:20:57.297167	2022-08-09 15:20:57.297167
bd40e088-8b20-4fad-9075-c1498c8e3db9	SE015A	3	D	t	CV027	f	2022-08-09 15:20:57.303321	2022-08-09 15:20:57.303321
33aa412e-0fbf-42f1-8a5b-74415d15564a	SE015A	3	I	t	CV027	f	2022-08-09 15:20:57.310557	2022-08-09 15:20:57.310557
9b74ec60-8af7-47f3-a87d-fb5384787f73	SE015A	3	W	t	CV027	f	2022-08-09 15:20:57.317525	2022-08-09 15:20:57.317525
7352fadd-c549-4ef0-862f-d99a8833ca5d	SE015A	3	Z	t	CV027	f	2022-08-09 15:20:57.323514	2022-08-09 15:20:57.323514
f60e8120-409c-4982-aaa3-51efd2b1924f	SE015A	3	A	f	CV027	f	2022-08-09 15:20:57.329974	2022-08-09 15:20:57.329974
26d08c52-a214-49cb-a858-6012f686d3ed	SE015A	3	D	f	CV027	f	2022-08-09 15:20:57.336867	2022-08-09 15:20:57.336867
4be3c4aa-2b33-4205-a8b6-b919439f2a6b	SE015A	3	I	f	CV027	f	2022-08-09 15:20:57.343416	2022-08-09 15:20:57.343416
f0c4beb7-f9c6-4013-b5af-cb8a77d0ee1c	SE015A	3	W	f	CV027	f	2022-08-09 15:20:57.349835	2022-08-09 15:20:57.349835
2bec6592-4df8-4260-9dd3-9ef36e680e20	SE015A	3	Z	f	CV027	f	2022-08-09 15:20:57.355694	2022-08-09 15:20:57.355694
2ac1abb7-8b87-418a-8ec9-aca04db6be18	SE015A	3	A	t	CV079	f	2022-08-09 15:20:57.36163	2022-08-09 15:20:57.36163
1b7ae3d8-b15b-44c0-bb1f-173de7e5cfa9	SE015A	3	D	t	CV079	f	2022-08-09 15:20:57.368033	2022-08-09 15:20:57.368033
e7c1a77e-0b29-4b30-b761-2def6254834e	SE015A	3	I	t	CV079	f	2022-08-09 15:20:57.374125	2022-08-09 15:20:57.374125
b54066d2-5c4d-473e-a935-86380b05f1e6	SE015A	3	W	t	CV079	f	2022-08-09 15:20:57.380629	2022-08-09 15:20:57.380629
d5612a1e-5043-4a08-9f62-9f63606a489f	SE015A	3	Z	t	CV079	f	2022-08-09 15:20:57.386145	2022-08-09 15:20:57.386145
8690ed83-2eca-4c06-81fb-3e7b1fd422ec	SE015A	3	A	f	CV118	f	2022-08-09 15:20:57.450074	2022-08-09 15:20:57.450074
a9c35dc9-7c01-45e7-8198-f89e561c2fe6	SE015A	3	D	f	CV118	f	2022-08-09 15:20:57.456204	2022-08-09 15:20:57.456204
b9c999a8-2a80-4c4a-a2f1-3e7e645a64d3	SE015A	3	I	f	CV118	f	2022-08-09 15:20:57.461941	2022-08-09 15:20:57.461941
6d504272-f7a3-4657-873c-11fd3d469c0e	SE015A	3	W	f	CV118	f	2022-08-09 15:20:57.467946	2022-08-09 15:20:57.467946
567f796f-288b-4a2b-bc85-ea2c9694c7f5	SE015A	3	Z	f	CV118	f	2022-08-09 15:20:57.473424	2022-08-09 15:20:57.473424
cf907941-c1c6-4923-bc28-4c8b1d15e033	SE015A	3	A	f	CV079	t	2022-08-09 15:20:57.39213	2022-08-09 15:20:57.480887
33b42916-8c7c-4e3b-8c31-0cd403dd285f	SE015A	3	D	f	CV079	t	2022-08-09 15:20:57.398484	2022-08-09 15:20:57.488466
fabcc28a-5907-44bf-b1bd-3e64f209d952	SE015A	3	I	f	CV079	t	2022-08-09 15:20:57.40458	2022-08-09 15:20:57.496194
ce419e9d-82a4-485a-9bb6-458dbb608e36	SE015A	3	W	f	CV079	t	2022-08-09 15:20:57.410276	2022-08-09 15:20:57.503596
2feba05c-e524-46e8-bf19-cee1135588d8	SE015A	3	Z	f	CV079	t	2022-08-09 15:20:57.415932	2022-08-09 15:20:57.511187
f27fac9b-0f5a-4bba-a0ac-41b3cc62d523	SE015A	3	A	t	CV118	t	2022-08-09 15:20:57.421714	2022-08-09 15:20:57.518748
6e614a89-40a7-417a-849f-a2ede44504b5	SE015A	3	D	t	CV118	t	2022-08-09 15:20:57.427081	2022-08-09 15:20:57.526524
d130e54c-cd10-46c1-b711-a0b868fa5ede	SE015A	3	I	t	CV118	t	2022-08-09 15:20:57.432367	2022-08-09 15:20:57.535564
d0a57c72-259b-4472-a3eb-589d15d4d8d0	SE015A	3	W	t	CV118	t	2022-08-09 15:20:57.437929	2022-08-09 15:20:57.543282
e51c3a6f-c4ac-46b7-b0e5-3a010f75a835	SE015A	3	Z	t	CV118	t	2022-08-09 15:20:57.443437	2022-08-09 15:20:57.550439
6696a240-6ff4-4429-9f54-73f8f2b2b1bf	SE016A	3	A	t	APL09	f	2022-08-09 15:20:57.556483	2022-08-09 15:20:57.556483
34274f8f-58c6-4045-8e48-09023a31a634	SE016A	3	D	t	APL09	f	2022-08-09 15:20:57.562784	2022-08-09 15:20:57.562784
447ec488-bba9-4c72-acd6-af83d6e14109	SE016A	3	I	t	APL09	f	2022-08-09 15:20:57.568215	2022-08-09 15:20:57.568215
26e0fdda-89a8-42cf-8a48-229df61beb49	SE016A	3	W	t	APL09	f	2022-08-09 15:20:57.574047	2022-08-09 15:20:57.574047
98f95e9b-acc5-4e27-b4f9-d5a23241182b	SE016A	3	Z	t	APL09	f	2022-08-09 15:20:57.579721	2022-08-09 15:20:57.579721
cec76155-810c-4017-b741-82e3e2f7008e	SE016A	3	A	f	APL09	f	2022-08-09 15:20:57.586683	2022-08-09 15:20:57.586683
1d28ad4c-da5a-4c6a-af98-be67ac7b6d2f	SE016A	3	D	f	APL09	f	2022-08-09 15:20:57.59221	2022-08-09 15:20:57.59221
acff5529-376c-4557-a9a6-e807a0d1bad5	SE016A	3	I	f	APL09	f	2022-08-09 15:20:57.5985	2022-08-09 15:20:57.5985
c2d2543d-a15f-46a3-809b-ac1141bb8bf2	SE016A	3	W	f	APL09	f	2022-08-09 15:20:57.604247	2022-08-09 15:20:57.604247
eb391320-779a-41c8-b28d-d13c14638fea	SE016A	3	Z	f	APL09	f	2022-08-09 15:20:57.61043	2022-08-09 15:20:57.61043
f689fbac-f311-4daa-851b-1ddb6e81213a	SE016A	3	A	t	APL07	f	2022-08-09 15:20:57.616137	2022-08-09 15:20:57.616137
f6c8eee6-8376-47db-8243-de95a1f36ac7	SE016A	3	D	t	APL07	f	2022-08-09 15:20:57.621964	2022-08-09 15:20:57.621964
fd5b6dea-1225-448a-b667-75853585c5fb	SE016A	3	I	t	APL07	f	2022-08-09 15:20:57.627272	2022-08-09 15:20:57.627272
8781f93c-f0a0-4654-87b1-6d9a21dc7d78	SE016A	3	W	t	APL07	f	2022-08-09 15:20:57.632633	2022-08-09 15:20:57.632633
cd615689-151e-425d-9559-e0c033478ea6	SE016A	3	Z	t	APL07	f	2022-08-09 15:20:57.638415	2022-08-09 15:20:57.638415
2d1fcba2-110c-4c99-acd9-48ed69cee803	SE016A	3	A	f	APL07	f	2022-08-09 15:20:57.643923	2022-08-09 15:20:57.643923
50379ab6-3214-4f47-bcd8-634e61817e60	SE016A	3	D	f	APL07	f	2022-08-09 15:20:57.649563	2022-08-09 15:20:57.649563
4c3cd40e-d4fb-4bc9-be8f-8570365d38b7	SE016A	3	I	f	APL07	f	2022-08-09 15:20:57.655077	2022-08-09 15:20:57.655077
9d35a464-f36b-4778-b1cf-1b203b27c293	SE016A	3	W	f	APL07	f	2022-08-09 15:20:57.660422	2022-08-09 15:20:57.660422
2ea87408-64f8-4e74-bc73-59d6bb0b8118	SE016A	3	Z	f	APL07	f	2022-08-09 15:20:57.666203	2022-08-09 15:20:57.666203
c3e250a4-801e-4955-984a-87f7c80a1b27	SE016A	3	A	t	APL11	f	2022-08-09 15:20:57.67149	2022-08-09 15:20:57.67149
1fd9c55a-4ecd-482c-ba69-7e84b0a3c0eb	SE016A	3	D	t	APL11	f	2022-08-09 15:20:57.67722	2022-08-09 15:20:57.67722
086d2b22-b402-4586-9e40-ded565dd8a42	SE016A	3	I	t	APL11	f	2022-08-09 15:20:57.682584	2022-08-09 15:20:57.682584
ed2cfd6e-ae2e-49cf-812b-255329e6295f	SE016A	3	W	t	APL11	f	2022-08-09 15:20:57.687837	2022-08-09 15:20:57.687837
44713e0c-8b09-4da3-b334-0addae38cf04	SE016A	3	Z	t	APL11	f	2022-08-09 15:20:57.693627	2022-08-09 15:20:57.693627
78670a72-8dfc-47b4-bbd6-a2deea9f4b25	SE016A	3	A	f	APL11	f	2022-08-09 15:20:57.699368	2022-08-09 15:20:57.699368
6332a261-b050-449b-8836-5806dfc4e870	SE016A	3	D	f	APL11	f	2022-08-09 15:20:57.70566	2022-08-09 15:20:57.70566
46407d03-801c-4c39-8e5b-6325e37da6a3	SE016A	3	I	f	APL11	f	2022-08-09 15:20:57.712709	2022-08-09 15:20:57.712709
4d92e4f2-85c0-46eb-adfe-0ded7da44cd7	SE016A	3	W	f	APL11	f	2022-08-09 15:20:57.719221	2022-08-09 15:20:57.719221
1933cdb3-052b-4ef8-9795-133216703f9b	SE016A	3	Z	f	APL11	f	2022-08-09 15:20:57.726123	2022-08-09 15:20:57.726123
397af3c5-1b1c-40f1-ae83-e98e30b3f717	SE016A	3	A	t	APL13	f	2022-08-09 15:20:57.733139	2022-08-09 15:20:57.733139
e4de8533-50a6-45fa-9df6-4464972905ab	SE016A	3	D	t	APL13	f	2022-08-09 15:20:57.740022	2022-08-09 15:20:57.740022
6554c12a-7c78-4a4c-b92c-47b1e62aa1d1	SE016A	3	I	t	APL13	f	2022-08-09 15:20:57.746702	2022-08-09 15:20:57.746702
3b42b763-e0b6-4989-bc20-30eda24dbf06	SE016A	3	W	t	APL13	f	2022-08-09 15:20:57.752242	2022-08-09 15:20:57.752242
d54a6686-df37-497f-a27f-cbbc4b4d2b8e	SE016A	3	Z	t	APL13	f	2022-08-09 15:20:57.758047	2022-08-09 15:20:57.758047
4f3b6444-89a3-4df0-8cd0-6510ceeb1166	SE016A	3	A	f	APL13	f	2022-08-09 15:20:57.763323	2022-08-09 15:20:57.763323
fc095ef2-4c82-4714-88a1-5ecea331ecf5	SE016A	3	D	f	APL13	f	2022-08-09 15:20:57.768591	2022-08-09 15:20:57.768591
2d2ff1dc-11af-4c8c-98f3-b74d61917418	SE016A	3	I	f	APL13	f	2022-08-09 15:20:57.774217	2022-08-09 15:20:57.774217
bf9dae60-c48e-4c2a-b359-094c226ccedc	SE016A	3	W	f	APL13	f	2022-08-09 15:20:57.780859	2022-08-09 15:20:57.780859
8bb81b2a-84c6-476c-b738-de9b89ab7616	SE016A	3	Z	f	APL13	f	2022-08-09 15:20:57.787168	2022-08-09 15:20:57.787168
38d5f86f-7e91-4a5f-ac17-7dff797e3f62	SE016A	3	A	t	APL15	f	2022-08-09 15:20:57.793323	2022-08-09 15:20:57.793323
7387f43f-0d3c-461a-a64f-d710c41b1beb	SE016A	3	D	t	APL15	f	2022-08-09 15:20:57.798992	2022-08-09 15:20:57.798992
976dafba-d026-427c-ba62-5aa572afde24	SE016A	3	I	t	APL15	f	2022-08-09 15:20:57.804376	2022-08-09 15:20:57.804376
bea4216e-ca78-4fe0-b16d-ef99bd442dd2	SE016A	3	W	t	APL15	f	2022-08-09 15:20:57.810333	2022-08-09 15:20:57.810333
edf36c09-8e51-4fbd-903a-366adc29fc39	SE016A	3	Z	t	APL15	f	2022-08-09 15:20:57.815788	2022-08-09 15:20:57.815788
29d0c7b9-53e0-474a-8318-57d2aba3d510	SE016A	3	A	f	APL15	f	2022-08-09 15:20:57.821769	2022-08-09 15:20:57.821769
ed6dc872-18a0-4ab7-b46b-4f980539e34b	SE016A	3	D	f	APL15	f	2022-08-09 15:20:57.82775	2022-08-09 15:20:57.82775
5e4b071b-ed59-434e-b76f-e17c5c51cb68	SE016A	3	I	f	APL15	f	2022-08-09 15:20:57.83404	2022-08-09 15:20:57.83404
6fb669d5-f122-43bf-808d-7393e2e004d4	SE016A	3	W	f	APL15	f	2022-08-09 15:20:57.839984	2022-08-09 15:20:57.839984
60073c91-5504-4f69-a15c-a4e330ade0b5	SE016A	3	Z	f	APL15	f	2022-08-09 15:20:57.846406	2022-08-09 15:20:57.846406
c4750c7e-5ce5-4d86-94ad-80e6e4a9111d	SE016A	3	A	t	APL16	f	2022-08-09 15:20:57.852074	2022-08-09 15:20:57.852074
9bdfea27-4ded-4dbf-be8d-2ec75db2c363	SE016A	3	D	t	APL16	f	2022-08-09 15:20:57.857355	2022-08-09 15:20:57.857355
e7302c20-6483-41bc-ae62-cad57ab60d00	SE016A	3	I	t	APL16	f	2022-08-09 15:20:57.863294	2022-08-09 15:20:57.863294
697e2540-585c-4497-b14b-9c134cb2eb61	SE016A	3	W	t	APL16	f	2022-08-09 15:20:57.868543	2022-08-09 15:20:57.868543
3b0e0c52-6856-46f9-9701-e8a88bb6aad6	SE016A	3	Z	t	APL16	f	2022-08-09 15:20:57.87518	2022-08-09 15:20:57.87518
b8997a26-ed65-4809-9886-a1c921aacb5d	SE016A	3	A	f	APL16	f	2022-08-09 15:20:57.880948	2022-08-09 15:20:57.880948
14d370d6-bb51-492d-86ee-a1409e371f84	SE016A	3	D	f	APL16	f	2022-08-09 15:20:57.886903	2022-08-09 15:20:57.886903
6d9d156b-59d6-4233-92a7-4edcfb6968ca	SE016A	3	I	f	APL16	f	2022-08-09 15:20:57.893167	2022-08-09 15:20:57.893167
0e83bec0-6daa-4dcb-b48f-77d074ae3b02	SE016A	3	W	f	APL16	f	2022-08-09 15:20:57.900163	2022-08-09 15:20:57.900163
7da76225-7003-469b-8817-5435e6b30658	SE016A	3	Z	f	APL16	f	2022-08-09 15:20:57.907132	2022-08-09 15:20:57.907132
f0ef0283-5cbf-4641-9d44-2dc8544c8386	SE016A	3	A	t	APL18	f	2022-08-09 15:20:57.913494	2022-08-09 15:20:57.913494
56492b5a-cac4-435b-86d9-2ef51233042d	SE016A	3	D	t	APL18	f	2022-08-09 15:20:57.920179	2022-08-09 15:20:57.920179
bdf6fe5b-98c9-4704-84e5-9e103f5a67b3	SE016A	3	I	t	APL18	f	2022-08-09 15:20:57.925984	2022-08-09 15:20:57.925984
1489c721-3f07-43d7-b142-e14f0c91bfe8	SE016A	3	W	t	APL18	f	2022-08-09 15:20:57.932662	2022-08-09 15:20:57.932662
80781d34-ead5-422b-b49d-cce68fbf30b5	SE016A	3	Z	t	APL18	f	2022-08-09 15:20:57.939036	2022-08-09 15:20:57.939036
e4cefd2a-9734-4f55-8617-e65e356f8d32	SE016A	3	A	f	APL18	f	2022-08-09 15:20:57.945074	2022-08-09 15:20:57.945074
463d7c10-983a-445e-a8af-9f332f61d89b	SE016A	3	D	f	APL18	f	2022-08-09 15:20:57.950515	2022-08-09 15:20:57.950515
8e944192-4603-4529-9086-084b2d6f1043	SE016A	3	I	f	APL18	f	2022-08-09 15:20:57.956866	2022-08-09 15:20:57.956866
6b1da16e-bd23-46eb-8ee5-a9c37068743e	SE016A	3	W	f	APL18	f	2022-08-09 15:20:57.962912	2022-08-09 15:20:57.962912
1c746bdb-2817-4ed6-a3ee-38b785d254a3	SE016A	3	Z	f	APL18	f	2022-08-09 15:20:57.968679	2022-08-09 15:20:57.968679
a1561628-1101-421c-a8b2-1095b14b85c9	SE016A	3	A	t	APL20	f	2022-08-09 15:20:57.974385	2022-08-09 15:20:57.974385
3cedc13c-2efb-4734-93ee-29ff84c87d04	SE016A	3	D	t	APL20	f	2022-08-09 15:20:57.980306	2022-08-09 15:20:57.980306
1a3a81aa-abd5-45d6-a9df-a703b5e577fc	SE016A	3	I	t	APL20	f	2022-08-09 15:20:57.98688	2022-08-09 15:20:57.98688
ee2d6e2e-9b13-4e39-9bdf-bdc40a3002b5	SE016A	3	W	t	APL20	f	2022-08-09 15:20:57.992937	2022-08-09 15:20:57.992937
410206d3-38ac-4803-858d-563588fb2d41	SE016A	3	Z	t	APL20	f	2022-08-09 15:20:57.998684	2022-08-09 15:20:57.998684
c428181a-33af-48cc-96ea-19c6965c1b6d	SE016A	3	A	f	APL20	f	2022-08-09 15:20:58.004905	2022-08-09 15:20:58.004905
469ab067-5ed5-4cd4-a5cf-2612bf866113	SE016A	3	D	f	APL20	f	2022-08-09 15:20:58.010487	2022-08-09 15:20:58.010487
0d815eed-3193-4d78-a85c-ddb1645e664b	SE016A	3	I	f	APL20	f	2022-08-09 15:20:58.016344	2022-08-09 15:20:58.016344
9c7258c9-caac-4fad-b4de-a1efde4e8bc7	SE016A	3	W	f	APL20	f	2022-08-09 15:20:58.022821	2022-08-09 15:20:58.022821
8c40bcd0-eb80-4758-9c6c-ed9612958dd5	SE016A	3	Z	f	APL20	f	2022-08-09 15:20:58.028941	2022-08-09 15:20:58.028941
c99628f9-6e8c-4fd8-91fa-e601496eb090	SE016A	3	A	t	APL22	f	2022-08-09 15:20:58.035146	2022-08-09 15:20:58.035146
3c38f399-9ccb-4a59-ba5a-6adcd3375cee	SE016A	3	D	t	APL22	f	2022-08-09 15:20:58.040722	2022-08-09 15:20:58.040722
d347e32f-9e3d-4fb0-a889-5920334c3a19	SE016A	3	I	t	APL22	f	2022-08-09 15:20:58.047177	2022-08-09 15:20:58.047177
e20d7d8a-cd77-411a-9237-7f4942ee33d9	SE016A	3	W	t	APL22	f	2022-08-09 15:20:58.052953	2022-08-09 15:20:58.052953
d193dd4d-529e-4637-9745-56de743f2eac	SE016A	3	Z	t	APL22	f	2022-08-09 15:20:58.058274	2022-08-09 15:20:58.058274
4596841f-31a8-4837-ba9a-73472d40149d	SE016A	3	A	f	APL22	f	2022-08-09 15:20:58.063691	2022-08-09 15:20:58.063691
cbe87ad2-ad89-4e3d-9509-9c938445044a	SE016A	3	D	f	APL22	f	2022-08-09 15:20:58.068907	2022-08-09 15:20:58.068907
a47abb7e-2d0d-4dae-a073-c04490663382	SE016A	3	I	f	APL22	f	2022-08-09 15:20:58.075271	2022-08-09 15:20:58.075271
6dfdceba-8308-4e85-a344-feccd194957e	SE016A	3	W	f	APL22	f	2022-08-09 15:20:58.082867	2022-08-09 15:20:58.082867
c17440be-f3ef-434f-9d26-093522de26a2	SE016A	3	Z	f	APL22	f	2022-08-09 15:20:58.0882	2022-08-09 15:20:58.0882
79ab6cda-67c5-4457-a8cf-4b371fa06460	SE016A	3	A	t	APL27	f	2022-08-09 15:20:58.093881	2022-08-09 15:20:58.093881
e403eeab-f728-4777-8392-448b53c68d5f	SE016A	3	D	t	APL27	f	2022-08-09 15:20:58.099462	2022-08-09 15:20:58.099462
ce41479d-9768-4d04-b961-0205afc5b1d3	SE016A	3	I	t	APL27	f	2022-08-09 15:20:58.104999	2022-08-09 15:20:58.104999
ae85ac1b-bc11-401c-b7d7-108f9b4a2fbe	SE016A	3	W	t	APL27	f	2022-08-09 15:20:58.111501	2022-08-09 15:20:58.111501
13cbf11b-6c1b-42f4-b8e7-9a32608daa98	SE016A	3	Z	t	APL27	f	2022-08-09 15:20:58.117141	2022-08-09 15:20:58.117141
9718247e-aee7-40ad-932d-85a14af307c1	SE016A	3	A	f	APL27	f	2022-08-09 15:20:58.122518	2022-08-09 15:20:58.122518
0c4df21d-9935-4eed-887d-42d083836086	SE016A	3	D	f	APL27	f	2022-08-09 15:20:58.128389	2022-08-09 15:20:58.128389
4cb5c26c-a637-422a-bafc-c44ae6338ce9	SE016A	3	I	f	APL27	f	2022-08-09 15:20:58.134821	2022-08-09 15:20:58.134821
cfa085c8-c6d2-4b63-be3b-9bb8caa4cded	SE016A	3	W	f	APL27	f	2022-08-09 15:20:58.141235	2022-08-09 15:20:58.141235
53fb2ee2-94af-43ee-9bb1-66ec46d7a3c5	SE016A	3	Z	f	APL27	f	2022-08-09 15:20:58.147043	2022-08-09 15:20:58.147043
88912622-893e-4a3c-a63c-93415135d83b	SE016A	3	A	t	APL29	f	2022-08-09 15:20:58.152236	2022-08-09 15:20:58.152236
d788dc52-159e-4761-9fa8-2fc67b03d4a3	SE016A	3	D	t	APL29	f	2022-08-09 15:20:58.157664	2022-08-09 15:20:58.157664
6e7156c6-68a3-4bcd-b664-89b175c23e6e	SE016A	3	I	t	APL29	f	2022-08-09 15:20:58.163171	2022-08-09 15:20:58.163171
248cdc7e-7bc1-42f8-b92b-1563209d21a7	SE016A	3	W	t	APL29	f	2022-08-09 15:20:58.169659	2022-08-09 15:20:58.169659
68c21a6f-7674-428f-bdfb-3ab30377e005	SE016A	3	Z	t	APL29	f	2022-08-09 15:20:58.176557	2022-08-09 15:20:58.176557
46fb4672-c2c3-49d2-9587-d61497a9f28c	SE016A	3	A	f	APL29	f	2022-08-09 15:20:58.182712	2022-08-09 15:20:58.182712
a005177c-59b8-48c2-ae0f-85065a2b8f5b	SE016A	3	D	f	APL29	f	2022-08-09 15:20:58.189005	2022-08-09 15:20:58.189005
1ec6e4e7-219f-43c8-bdc5-c82ac8abd091	SE016A	3	I	f	APL29	f	2022-08-09 15:20:58.195144	2022-08-09 15:20:58.195144
0fc09408-e367-4a04-ad3d-6838ee57a0e1	SE016A	3	W	f	APL29	f	2022-08-09 15:20:58.201978	2022-08-09 15:20:58.201978
5f15a380-ba44-48e3-9cf7-c8014425f459	SE016A	3	Z	f	APL29	f	2022-08-09 15:20:58.207662	2022-08-09 15:20:58.207662
d75fad5d-5825-486e-9523-7ca9a15b5e52	SE016A	3	A	t	APL31	f	2022-08-09 15:20:58.212907	2022-08-09 15:20:58.212907
f8e64e3d-90de-48da-bf64-a0bb78ad5a26	SE016A	3	D	t	APL31	f	2022-08-09 15:20:58.220055	2022-08-09 15:20:58.220055
ca304942-7b69-4efe-8be0-516a3351d75e	SE016A	3	I	t	APL31	f	2022-08-09 15:20:58.226745	2022-08-09 15:20:58.226745
baafcf59-5bc2-47e5-8d6e-a926b5dd0a5c	SE016A	3	W	t	APL31	f	2022-08-09 15:20:58.233045	2022-08-09 15:20:58.233045
e9558a66-fff1-4cc9-9079-75b424933e9f	SE016A	3	Z	t	APL31	f	2022-08-09 15:20:58.239412	2022-08-09 15:20:58.239412
14ecf601-dd13-43ba-8981-8730228f1bb9	SE016A	3	A	f	APL31	f	2022-08-09 15:20:58.244947	2022-08-09 15:20:58.244947
8927233c-1136-4548-896e-c212e2f57d51	SE016A	3	D	f	APL31	f	2022-08-09 15:20:58.250755	2022-08-09 15:20:58.250755
515b3cca-a884-413f-9ad0-9de009017eb5	SE016A	3	I	f	APL31	f	2022-08-09 15:20:58.256627	2022-08-09 15:20:58.256627
b82f3e55-40c8-4c94-8a14-88b2bfcdfae5	SE016A	3	W	f	APL31	f	2022-08-09 15:20:58.263063	2022-08-09 15:20:58.263063
c67af29f-0e55-4b37-8fc9-82f157be9126	SE016A	3	Z	f	APL31	f	2022-08-09 15:20:58.269575	2022-08-09 15:20:58.269575
347555be-17d5-410c-a516-3fda30019810	SE016A	3	A	t	APL48	f	2022-08-09 15:20:58.275282	2022-08-09 15:20:58.275282
f496ee8d-2e3c-4f25-bad9-f2599cfcf617	SE016A	3	D	t	APL48	f	2022-08-09 15:20:58.281937	2022-08-09 15:20:58.281937
1480571a-b0ba-4d58-8392-d6120b641d5a	SE016A	3	I	t	APL48	f	2022-08-09 15:20:58.288632	2022-08-09 15:20:58.288632
c2e54dd7-2c64-4703-b746-43dae81988cb	SE016A	3	W	t	APL48	f	2022-08-09 15:20:58.294593	2022-08-09 15:20:58.294593
47a2e0c3-f592-4a90-949a-3f5ad8133947	SE016A	3	Z	t	APL48	f	2022-08-09 15:20:58.300518	2022-08-09 15:20:58.300518
2d14137a-10ba-4b15-ba27-8ec6235df81e	SE016A	3	A	f	APL48	f	2022-08-09 15:20:58.305937	2022-08-09 15:20:58.305937
f5e770e4-1f39-4ed9-bc12-42b2199b9130	SE016A	3	D	f	APL48	f	2022-08-09 15:20:58.312018	2022-08-09 15:20:58.312018
8268fb67-29c5-4f33-81b9-4523a69d8841	SE016A	3	I	f	APL48	f	2022-08-09 15:20:58.317521	2022-08-09 15:20:58.317521
98115153-8784-4386-a124-158a62c01488	SE016A	3	W	f	APL48	f	2022-08-09 15:20:58.323085	2022-08-09 15:20:58.323085
18773bd1-8a2e-48b1-ba00-a3e83647d6c7	SE016A	3	Z	f	APL48	f	2022-08-09 15:20:58.330992	2022-08-09 15:20:58.330992
1ff1decc-b6b6-4252-b3f9-93bc4bae78d3	SE016A	3	A	t	APL49	f	2022-08-09 15:20:58.340246	2022-08-09 15:20:58.340246
263f4cb7-8d18-45c6-9821-9bf351e67020	SE016A	3	D	t	APL49	f	2022-08-09 15:20:58.348648	2022-08-09 15:20:58.348648
dc085931-82fd-471f-bc25-93d0f0c5e073	SE016A	3	I	t	APL49	f	2022-08-09 15:20:58.355388	2022-08-09 15:20:58.355388
37a22544-fd39-4aaa-a16a-8b48f0d13cb8	SE016A	3	W	t	APL49	f	2022-08-09 15:20:58.363371	2022-08-09 15:20:58.363371
9a7c2242-624b-4244-aadf-0f7f87b97a86	SE016A	3	Z	t	APL49	f	2022-08-09 15:20:58.371151	2022-08-09 15:20:58.371151
c5f25b0e-fe83-4b53-9beb-76195a0832a5	SE016A	3	A	f	APL49	f	2022-08-09 15:20:58.378937	2022-08-09 15:20:58.378937
008fe068-f294-4a70-b752-be24be04aa93	SE016A	3	D	f	APL49	f	2022-08-09 15:20:58.385065	2022-08-09 15:20:58.385065
8e7ffc75-587f-4c4d-bd05-7f4dab1e3ea9	SE016A	3	I	f	APL49	f	2022-08-09 15:20:58.39079	2022-08-09 15:20:58.39079
a7340256-4a32-4020-9b1f-70d2e13dbc66	SE016A	3	W	f	APL49	f	2022-08-09 15:20:58.397576	2022-08-09 15:20:58.397576
de179610-11dd-4013-b757-bb06118c8798	SE016A	3	Z	f	APL49	f	2022-08-09 15:20:58.403468	2022-08-09 15:20:58.403468
89d580d7-ce68-4027-ba84-3346b09afb3e	SE016A	3	A	t	APL50	f	2022-08-09 15:20:58.408881	2022-08-09 15:20:58.408881
8097161c-4be3-4179-b023-efba9d1fe8e0	SE016A	3	D	t	APL50	f	2022-08-09 15:20:58.415338	2022-08-09 15:20:58.415338
e32c213e-c1dd-4190-996d-994e91a15af6	SE016A	3	I	t	APL50	f	2022-08-09 15:20:58.421094	2022-08-09 15:20:58.421094
1b93fb72-25ad-48a3-a0e8-1dfaa9075fbf	SE016A	3	W	t	APL50	f	2022-08-09 15:20:58.426317	2022-08-09 15:20:58.426317
573061a0-a019-49c7-acb2-2cd6ecd7312e	SE016A	3	Z	t	APL50	f	2022-08-09 15:20:58.432217	2022-08-09 15:20:58.432217
7dd419cb-8938-4c07-90c6-5e8a913f2261	SE016A	3	A	f	APL50	f	2022-08-09 15:20:58.437696	2022-08-09 15:20:58.437696
a93c7b27-d4a6-4e69-8c50-1d4ea11da02e	SE016A	3	D	f	APL50	f	2022-08-09 15:20:58.44351	2022-08-09 15:20:58.44351
a5a5fdde-b57e-4373-b18b-d09b228efe4e	SE016A	3	I	f	APL50	f	2022-08-09 15:20:58.449185	2022-08-09 15:20:58.449185
d9588301-3507-4a19-b100-3feb3d1ad27f	SE016A	3	W	f	APL50	f	2022-08-09 15:20:58.455507	2022-08-09 15:20:58.455507
9e541e02-d227-47b5-964f-31fb6ecee0fc	SE016A	3	Z	f	APL50	f	2022-08-09 15:20:58.46215	2022-08-09 15:20:58.46215
1128dd23-0e38-4e5f-bb4a-f08f5cdf3d1f	SE016A	3	A	t	APL51	f	2022-08-09 15:20:58.468072	2022-08-09 15:20:58.468072
fefc9caa-0ab7-496b-9589-58e55218f630	SE016A	3	D	t	APL51	f	2022-08-09 15:20:58.473953	2022-08-09 15:20:58.473953
4d45757f-3c6d-451e-b12c-6907a635e1e4	SE016A	3	I	t	APL51	f	2022-08-09 15:20:58.479916	2022-08-09 15:20:58.479916
5b2c77ee-f258-4928-86cc-bbc63cf13cee	SE016A	3	W	t	APL51	f	2022-08-09 15:20:58.485527	2022-08-09 15:20:58.485527
8a81f042-6e92-42e7-acd8-bf18cb1c8364	SE016A	3	Z	t	APL51	f	2022-08-09 15:20:58.491739	2022-08-09 15:20:58.491739
06ffc06f-cd91-4828-ba85-393b40cd7804	SE016A	3	A	f	APL51	f	2022-08-09 15:20:58.497511	2022-08-09 15:20:58.497511
3da4a6f1-7f99-4612-88e0-a5ab0e19db44	SE016A	3	D	f	APL51	f	2022-08-09 15:20:58.503219	2022-08-09 15:20:58.503219
f841eb6f-4027-47fc-84f4-57779ac7aa02	SE016A	3	I	f	APL51	f	2022-08-09 15:20:58.509227	2022-08-09 15:20:58.509227
f87bb11e-8f61-47e1-8626-6eb2f695fded	SE016A	3	W	f	APL51	f	2022-08-09 15:20:58.515068	2022-08-09 15:20:58.515068
77f3f01b-9e00-4a69-9834-994868272760	SE016A	3	Z	f	APL51	f	2022-08-09 15:20:58.520965	2022-08-09 15:20:58.520965
292febfd-70c2-4b97-a511-b298ef19a238	SE016A	3	A	t	APL52	f	2022-08-09 15:20:58.52734	2022-08-09 15:20:58.52734
deee9f39-cac1-45b1-9200-36a7c2fb38f6	SE016A	3	D	t	APL52	f	2022-08-09 15:20:58.53345	2022-08-09 15:20:58.53345
94db91ae-61b2-44f0-9db1-5ced46157474	SE016A	3	I	t	APL52	f	2022-08-09 15:20:58.539617	2022-08-09 15:20:58.539617
f7cdde80-2108-457f-8c94-3a6eae4a0666	SE016A	3	W	t	APL52	f	2022-08-09 15:20:58.545272	2022-08-09 15:20:58.545272
09591409-6a2b-4e6f-a9b1-57b927956e9a	SE016A	3	Z	t	APL52	f	2022-08-09 15:20:58.551756	2022-08-09 15:20:58.551756
6f86d893-28d1-4d82-ad89-2a416b45d11f	SE016A	3	A	f	APL52	f	2022-08-09 15:20:58.557639	2022-08-09 15:20:58.557639
c5beafe7-9cea-4891-974d-65804dab828e	SE016A	3	D	f	APL52	f	2022-08-09 15:20:58.563829	2022-08-09 15:20:58.563829
8ff5fb46-b180-4aa4-b5fb-50911b9daf11	SE016A	3	I	f	APL52	f	2022-08-09 15:20:58.569572	2022-08-09 15:20:58.569572
abeeec62-6c43-4c13-9bcf-cd16fa31649c	SE016A	3	W	f	APL52	f	2022-08-09 15:20:58.575649	2022-08-09 15:20:58.575649
369e4fa1-ba56-4c32-8f01-c6d19fbb65b1	SE016A	3	Z	f	APL52	f	2022-08-09 15:20:58.584362	2022-08-09 15:20:58.584362
d2e3756d-c9bf-4f35-b9ea-b827eef4a0ea	SE016A	3	A	t	APL53	f	2022-08-09 15:20:58.59101	2022-08-09 15:20:58.59101
4310b57b-fda2-4f36-a4c6-941cc47d274b	SE016A	3	D	t	APL53	f	2022-08-09 15:20:58.596741	2022-08-09 15:20:58.596741
40e47cd1-fe10-4ad7-aed3-ee399f52b59a	SE016A	3	I	t	APL53	f	2022-08-09 15:20:58.602411	2022-08-09 15:20:58.602411
030f5559-4ea6-4d8e-af17-3a94a5b5f78e	SE016A	3	W	t	APL53	f	2022-08-09 15:20:58.608507	2022-08-09 15:20:58.608507
689b247b-f7db-4f75-af76-712ca4534b12	SE016A	3	Z	t	APL53	f	2022-08-09 15:20:58.614163	2022-08-09 15:20:58.614163
0b2116a2-b142-40c5-9df2-f2f4cb7a64c9	SE016A	3	A	f	APL53	f	2022-08-09 15:20:58.619263	2022-08-09 15:20:58.619263
3b9df243-1bf2-4353-9e8a-81847fe881e0	SE016A	3	D	f	APL53	f	2022-08-09 15:20:58.625116	2022-08-09 15:20:58.625116
00b8cd5a-0d8e-4349-a7db-46563ad4f789	SE016A	3	I	f	APL53	f	2022-08-09 15:20:58.631392	2022-08-09 15:20:58.631392
683bf6cf-7e31-4014-90f8-ceb3556a116c	SE016A	3	W	f	APL53	f	2022-08-09 15:20:58.637822	2022-08-09 15:20:58.637822
318aa923-4835-4f02-8290-54bbb4d79bc8	SE016A	3	Z	f	APL53	f	2022-08-09 15:20:58.643477	2022-08-09 15:20:58.643477
36a36fb1-0028-4368-ab1a-922ad0f506a7	SE016A	3	A	t	APL54	f	2022-08-09 15:20:58.649249	2022-08-09 15:20:58.649249
195ada7a-9f65-434d-ba1f-b5f43ab10006	SE016A	3	D	t	APL54	f	2022-08-09 15:20:58.654833	2022-08-09 15:20:58.654833
07e467d0-1218-45c0-a500-2efe57e37993	SE016A	3	I	t	APL54	f	2022-08-09 15:20:58.661236	2022-08-09 15:20:58.661236
1f95ddc0-cd58-4419-8f30-109af6c6b70c	SE016A	3	W	t	APL54	f	2022-08-09 15:20:58.668567	2022-08-09 15:20:58.668567
16fd4634-2206-4648-9d07-6cd5d94d388a	SE016A	3	Z	t	APL54	f	2022-08-09 15:20:58.674587	2022-08-09 15:20:58.674587
a22b879c-e91b-4735-8291-39127b6683cc	SE016A	3	A	f	APL54	f	2022-08-09 15:20:58.680154	2022-08-09 15:20:58.680154
ce76ce80-e472-4578-8eb7-bd9d6da23ef2	SE016A	3	D	f	APL54	f	2022-08-09 15:20:58.685679	2022-08-09 15:20:58.685679
39e28619-9ec9-47e1-8826-78002280b580	SE016A	3	I	f	APL54	f	2022-08-09 15:20:58.691569	2022-08-09 15:20:58.691569
b404f6ea-2183-4fa2-9af8-1d8a405a5e00	SE016A	3	W	f	APL54	f	2022-08-09 15:20:58.697299	2022-08-09 15:20:58.697299
0523c0a3-84f1-480b-ab3e-8026944caeef	SE016A	3	Z	f	APL54	f	2022-08-09 15:20:58.703947	2022-08-09 15:20:58.703947
181e2a95-16ca-46ec-b490-210ecf14b67a	SE016A	3	A	t	APL55	f	2022-08-09 15:20:58.710027	2022-08-09 15:20:58.710027
6fd7a95c-5e75-4852-aad0-4c7dd5d6c0b9	SE016A	3	D	t	APL55	f	2022-08-09 15:20:58.715586	2022-08-09 15:20:58.715586
75318be2-5d36-4eeb-ade4-9467f1d93cdb	SE016A	3	I	t	APL55	f	2022-08-09 15:20:58.721256	2022-08-09 15:20:58.721256
51476a6e-c487-4717-8871-8fa2ce7cbc5c	SE016A	3	W	t	APL55	f	2022-08-09 15:20:58.726657	2022-08-09 15:20:58.726657
0c7068bc-a08c-48b5-8eb0-19d4196df9a9	SE016A	3	Z	t	APL55	f	2022-08-09 15:20:58.732933	2022-08-09 15:20:58.732933
5ce154ff-2222-4cba-bb5a-3039ffe8b865	SE016A	3	A	f	APL55	f	2022-08-09 15:20:58.739583	2022-08-09 15:20:58.739583
f72d247c-a4a9-4784-aa0a-b76b46280ee3	SE016A	3	D	f	APL55	f	2022-08-09 15:20:58.745285	2022-08-09 15:20:58.745285
27c4ff26-8c15-4909-bc2e-87c089f73990	SE016A	3	I	f	APL55	f	2022-08-09 15:20:58.750657	2022-08-09 15:20:58.750657
2c98bffc-b72c-4d35-be25-12cc1fcf60ac	SE016A	3	W	f	APL55	f	2022-08-09 15:20:58.755679	2022-08-09 15:20:58.755679
b63571a7-1166-42c5-881f-37eb77aeb371	SE016A	3	Z	f	APL55	f	2022-08-09 15:20:58.760773	2022-08-09 15:20:58.760773
cf576195-fa72-4fee-b42d-7f924ab94ec1	SE016A	3	A	t	APL56	f	2022-08-09 15:20:58.766656	2022-08-09 15:20:58.766656
127d2ee8-4909-4c66-a1b4-8f5b3a9ed95d	SE016A	3	D	t	APL56	f	2022-08-09 15:20:58.772416	2022-08-09 15:20:58.772416
fad574bb-c77d-46de-ad74-1977a0f51045	SE016A	3	I	t	APL56	f	2022-08-09 15:20:58.778893	2022-08-09 15:20:58.778893
33432300-a404-4c1a-be08-e2b0f1f0429c	SE016A	3	W	t	APL56	f	2022-08-09 15:20:58.784887	2022-08-09 15:20:58.784887
d9350da6-5b16-4a27-961e-af12abcb1061	SE016A	3	Z	t	APL56	f	2022-08-09 15:20:58.790484	2022-08-09 15:20:58.790484
dbc48c1b-647e-4d43-ac0a-b01a18591a5d	SE016A	3	A	f	APL56	f	2022-08-09 15:20:58.796204	2022-08-09 15:20:58.796204
6f228bc5-10c8-4477-ad40-38b71dc8cee7	SE016A	3	D	f	APL56	f	2022-08-09 15:20:58.801748	2022-08-09 15:20:58.801748
92fe17ae-9554-4300-8aec-09649d620e66	SE016A	3	I	f	APL56	f	2022-08-09 15:20:58.807223	2022-08-09 15:20:58.807223
add6e079-3228-4432-9656-36a3f4fe9201	SE016A	3	W	f	APL56	f	2022-08-09 15:20:58.813431	2022-08-09 15:20:58.813431
dd055ecf-ad35-41aa-94fe-10bfe44b6c95	SE016A	3	Z	f	APL56	f	2022-08-09 15:20:58.819702	2022-08-09 15:20:58.819702
8525e6c7-c2fb-4b21-9af4-9b8e405986b9	SE016A	3	A	t	APL57	f	2022-08-09 15:20:58.825807	2022-08-09 15:20:58.825807
b57ef3fa-5cb0-40f4-83b8-934c92f8d79a	SE016A	3	D	t	APL57	f	2022-08-09 15:20:58.831949	2022-08-09 15:20:58.831949
1fb69d98-e43b-4927-ba82-8225a04782c6	SE016A	3	I	t	APL57	f	2022-08-09 15:20:58.837764	2022-08-09 15:20:58.837764
9f4dfb65-023c-4fb7-85ad-f6b97d5655b8	SE016A	3	W	t	APL57	f	2022-08-09 15:20:58.843378	2022-08-09 15:20:58.843378
a66e51ae-a406-46ce-9795-d3a2fad4479f	SE016A	3	Z	t	APL57	f	2022-08-09 15:20:58.848924	2022-08-09 15:20:58.848924
a8de5df4-aa71-43a0-8b47-22b52f0dd3ec	SE016A	3	A	f	APL57	f	2022-08-09 15:20:58.85443	2022-08-09 15:20:58.85443
94faa0c0-9565-4efd-90a5-ca5117fac000	SE016A	3	D	f	APL57	f	2022-08-09 15:20:58.860221	2022-08-09 15:20:58.860221
f12344ad-a089-4546-9967-f03912d60284	SE016A	3	I	f	APL57	f	2022-08-09 15:20:58.865535	2022-08-09 15:20:58.865535
38a7db83-83b0-43c2-9bcf-18a0c72819ad	SE016A	3	W	f	APL57	f	2022-08-09 15:20:58.871065	2022-08-09 15:20:58.871065
eb2263dd-377b-4c9d-a667-11a781255b77	SE016A	3	Z	f	APL57	f	2022-08-09 15:20:58.877359	2022-08-09 15:20:58.877359
cb784813-1c35-4d01-981a-6600e8030754	SE016A	3	A	t	APL65	f	2022-08-09 15:20:58.8831	2022-08-09 15:20:58.8831
e2429b8f-7994-4b90-8877-5f8db8ed1cab	SE016A	3	D	t	APL65	f	2022-08-09 15:20:58.888546	2022-08-09 15:20:58.888546
ece80a9b-9561-49a6-afe7-e8f31e5cdb4d	SE016A	3	I	t	APL65	f	2022-08-09 15:20:58.894248	2022-08-09 15:20:58.894248
a605c650-2a1b-415d-91fb-a32eabbbb19f	SE016A	3	W	t	APL65	f	2022-08-09 15:20:58.899635	2022-08-09 15:20:58.899635
e7ca7f7b-d087-4797-8bd1-b7d0d8ab80e8	SE016A	3	Z	t	APL65	f	2022-08-09 15:20:58.904913	2022-08-09 15:20:58.904913
c2af2a20-269a-4736-9070-8c64faeccfb5	SE016A	3	A	f	APL65	f	2022-08-09 15:20:58.910656	2022-08-09 15:20:58.910656
75ba03d3-34d1-492b-a79b-00b9cf9f25a3	SE016A	3	D	f	APL65	f	2022-08-09 15:20:58.917124	2022-08-09 15:20:58.917124
437b7b3c-e119-4466-89d6-1304447e1472	SE016A	3	I	f	APL65	f	2022-08-09 15:20:58.923062	2022-08-09 15:20:58.923062
ee1fa6d0-33e2-442a-8b9f-193947b2a6a1	SE016A	3	W	f	APL65	f	2022-08-09 15:20:58.928491	2022-08-09 15:20:58.928491
8ddadf02-ad1d-466d-bca6-559341caf9da	SE016A	3	Z	f	APL65	f	2022-08-09 15:20:58.934227	2022-08-09 15:20:58.934227
0afe9182-1fc9-4f2e-bcf4-8748b5dcda08	SE016A	3	A	t	APL66	f	2022-08-09 15:20:58.939807	2022-08-09 15:20:58.939807
f770fc6b-159f-40a1-ac2b-655b0fa474ad	SE016A	3	D	t	APL66	f	2022-08-09 15:20:58.945219	2022-08-09 15:20:58.945219
b75e3cdf-8fb3-4f6b-acd7-81b060516573	SE016A	3	I	t	APL66	f	2022-08-09 15:20:58.951148	2022-08-09 15:20:58.951148
2631f75e-9bb5-45e5-964d-e2da3670be12	SE016A	3	W	t	APL66	f	2022-08-09 15:20:58.956732	2022-08-09 15:20:58.956732
a7973608-5cab-465d-8e50-8f234524b21e	SE016A	3	Z	t	APL66	f	2022-08-09 15:20:58.962602	2022-08-09 15:20:58.962602
0988d368-6b56-4a8c-b908-edae328cecee	SE016A	3	A	f	APL66	f	2022-08-09 15:20:58.967958	2022-08-09 15:20:58.967958
b7205a72-361d-44cc-972c-72146f30eb4f	SE016A	3	D	f	APL66	f	2022-08-09 15:20:58.973516	2022-08-09 15:20:58.973516
a575f18c-9d5f-4673-bf51-7af3630559d3	SE016A	3	I	f	APL66	f	2022-08-09 15:20:58.979016	2022-08-09 15:20:58.979016
2b735407-06cc-46e8-aa45-9de3e10d7504	SE016A	3	W	f	APL66	f	2022-08-09 15:20:58.985046	2022-08-09 15:20:58.985046
c7944f55-02b0-4b69-95ca-2d210fc72956	SE016A	3	Z	f	APL66	f	2022-08-09 15:20:58.990607	2022-08-09 15:20:58.990607
c1dd8ecc-7698-4fbb-9d5d-3016652566a1	SE016A	3	A	t	APL67	f	2022-08-09 15:20:58.996573	2022-08-09 15:20:58.996573
a125a475-e2d8-4398-97d9-761e88dd58ff	SE016A	3	D	t	APL67	f	2022-08-09 15:20:59.002022	2022-08-09 15:20:59.002022
aaf0f0fc-b129-4991-9aa6-598a57bb30b9	SE016A	3	I	t	APL67	f	2022-08-09 15:20:59.007778	2022-08-09 15:20:59.007778
e7c78ec9-2ef1-4cb2-8617-966f9ad8a0d3	SE016A	3	W	t	APL67	f	2022-08-09 15:20:59.013183	2022-08-09 15:20:59.013183
d9cb28d2-a452-4e0d-b95c-f6039dfd80b3	SE016A	3	Z	t	APL67	f	2022-08-09 15:20:59.018921	2022-08-09 15:20:59.018921
2033d891-0acd-49ec-a3df-b95c743646c9	SE016A	3	A	f	APL67	f	2022-08-09 15:20:59.025042	2022-08-09 15:20:59.025042
0c49967c-478f-4e2b-b53c-772b78e5c0fd	SE016A	3	D	f	APL67	f	2022-08-09 15:20:59.030515	2022-08-09 15:20:59.030515
48644a50-9ff1-4162-932e-75e4af4987e3	SE016A	3	I	f	APL67	f	2022-08-09 15:20:59.035926	2022-08-09 15:20:59.035926
9c9a6f2f-27a6-496e-b544-1a01af77cd5b	SE016A	3	W	f	APL67	f	2022-08-09 15:20:59.041824	2022-08-09 15:20:59.041824
16d6baec-7185-43db-ae67-0854dc56dc05	SE016A	3	Z	f	APL67	f	2022-08-09 15:20:59.047238	2022-08-09 15:20:59.047238
51d208a7-f989-456d-9610-8929a9af07ca	SE016A	3	A	t	APL68	f	2022-08-09 15:20:59.053139	2022-08-09 15:20:59.053139
657666f3-e6d4-41ed-a29b-21e5a7577ec4	SE016A	3	D	t	APL68	f	2022-08-09 15:20:59.058556	2022-08-09 15:20:59.058556
675943cb-910d-4c3f-869d-2ca06f0bdebc	SE016A	3	I	t	APL68	f	2022-08-09 15:20:59.063912	2022-08-09 15:20:59.063912
63de0477-bba3-435e-b177-31eb3dfe0a67	SE016A	3	W	t	APL68	f	2022-08-09 15:20:59.069582	2022-08-09 15:20:59.069582
5aec1b63-863c-4b85-b01d-f36f377a3310	SE016A	3	Z	t	APL68	f	2022-08-09 15:20:59.075	2022-08-09 15:20:59.075
6338dcfb-bacf-495d-8aab-41ef18ed9f7e	SE016A	3	A	f	APL68	f	2022-08-09 15:20:59.081392	2022-08-09 15:20:59.081392
99ef2cf6-5673-4a68-8ce5-18561e4b6ec9	SE016A	3	D	f	APL68	f	2022-08-09 15:20:59.087784	2022-08-09 15:20:59.087784
d37a2367-0d51-42c0-a40c-32d2dd054437	SE016A	3	I	f	APL68	f	2022-08-09 15:20:59.093122	2022-08-09 15:20:59.093122
8aacb42f-1d7c-4cb6-b697-46768b0f7fda	SE016A	3	W	f	APL68	f	2022-08-09 15:20:59.099409	2022-08-09 15:20:59.099409
7ceff87f-232e-43e8-9259-dda84259f89d	SE016A	3	Z	f	APL68	f	2022-08-09 15:20:59.105227	2022-08-09 15:20:59.105227
a4113b2d-21a6-47d5-9304-74d73b873288	SE016A	3	A	t	APL69	f	2022-08-09 15:20:59.11126	2022-08-09 15:20:59.11126
fa9563eb-1ad6-4927-a441-f87dbc0d23e8	SE016A	3	D	t	APL69	f	2022-08-09 15:20:59.117187	2022-08-09 15:20:59.117187
396165d0-2869-4692-ac38-398078a6b965	SE016A	3	I	t	APL69	f	2022-08-09 15:20:59.122839	2022-08-09 15:20:59.122839
8951f405-526c-462a-82ac-d7dfc2f1f94c	SE016A	3	W	t	APL69	f	2022-08-09 15:20:59.128731	2022-08-09 15:20:59.128731
f0c9f6c0-ddc3-41c4-b8dd-90edb5f26931	SE016A	3	Z	t	APL69	f	2022-08-09 15:20:59.134105	2022-08-09 15:20:59.134105
d1f29445-715d-4706-adcb-b11621c547e7	SE016A	3	A	f	APL69	f	2022-08-09 15:20:59.139459	2022-08-09 15:20:59.139459
59062e7c-e0c0-4c00-ac5e-fe1202152218	SE016A	3	D	f	APL69	f	2022-08-09 15:20:59.145326	2022-08-09 15:20:59.145326
59a79d35-725c-4cff-a2d6-79628c9d8d4e	SE016A	3	I	f	APL69	f	2022-08-09 15:20:59.150792	2022-08-09 15:20:59.150792
fa701e1e-c6c6-45dc-a7b8-47a8516f4503	SE016A	3	W	f	APL69	f	2022-08-09 15:20:59.156115	2022-08-09 15:20:59.156115
0aa4d50c-4955-4c3e-9f61-d76988462414	SE016A	3	Z	f	APL69	f	2022-08-09 15:20:59.161878	2022-08-09 15:20:59.161878
14e05a43-b8ff-46e7-8c96-a6a8440a5da8	SE016A	3	A	t	APL70	f	2022-08-09 15:20:59.167198	2022-08-09 15:20:59.167198
8abdc474-6710-43ea-8935-c89fa4de7517	SE016A	3	D	t	APL70	f	2022-08-09 15:20:59.172641	2022-08-09 15:20:59.172641
fdbf6a9a-5e29-4a59-8955-117792cf5bd7	SE016A	3	I	t	APL70	f	2022-08-09 15:20:59.178358	2022-08-09 15:20:59.178358
80634922-cca1-4e0b-81dd-52af5a9baaba	SE016A	3	W	t	APL70	f	2022-08-09 15:20:59.183873	2022-08-09 15:20:59.183873
da8ffccd-8851-49e2-9d97-50dc364db8d6	SE016A	3	Z	t	APL70	f	2022-08-09 15:20:59.189844	2022-08-09 15:20:59.189844
8cc37fba-ee55-4263-8661-27d024d472f1	SE016A	3	A	f	APL70	f	2022-08-09 15:20:59.195226	2022-08-09 15:20:59.195226
58ecd02e-f39d-4832-aa37-c56270bc34af	SE016A	3	D	f	APL70	f	2022-08-09 15:20:59.200685	2022-08-09 15:20:59.200685
1a68c777-f2ed-4a3d-8886-efd37b6b85ac	SE016A	3	I	f	APL70	f	2022-08-09 15:20:59.20672	2022-08-09 15:20:59.20672
44cd23ec-a767-4cfc-ba6c-a5879b8fe981	SE016A	3	W	f	APL70	f	2022-08-09 15:20:59.21248	2022-08-09 15:20:59.21248
73cac422-bee2-400a-a515-39a30818ab39	SE016A	3	Z	f	APL70	f	2022-08-09 15:20:59.21799	2022-08-09 15:20:59.21799
9504c5e3-3716-4ffc-9c52-056fdc3cf1fa	SE016A	3	A	t	CV027	f	2022-08-09 15:20:59.223555	2022-08-09 15:20:59.223555
c6ee7b8b-80f7-49d6-80b4-a6988406ce79	SE016A	3	D	t	CV027	f	2022-08-09 15:20:59.229601	2022-08-09 15:20:59.229601
7a7a6545-6a35-492e-b1d4-3f349f8a24bd	SE016A	3	I	t	CV027	f	2022-08-09 15:20:59.235596	2022-08-09 15:20:59.235596
80f0d948-d37e-4aea-b42b-1a550489b311	SE016A	3	W	t	CV027	f	2022-08-09 15:20:59.242253	2022-08-09 15:20:59.242253
758011bd-e153-4556-a61c-efa349726b4c	SE016A	3	Z	t	CV027	f	2022-08-09 15:20:59.248049	2022-08-09 15:20:59.248049
4f52f168-25be-42c3-a429-7eb17fae220e	SE016A	3	A	f	CV027	f	2022-08-09 15:20:59.253938	2022-08-09 15:20:59.253938
b8535ebe-bed0-41a6-b2f9-622e44f007d2	SE016A	3	D	f	CV027	f	2022-08-09 15:20:59.259595	2022-08-09 15:20:59.259595
b5952845-e356-405a-a6a4-832cbc9f5b45	SE016A	3	I	f	CV027	f	2022-08-09 15:20:59.265332	2022-08-09 15:20:59.265332
58244a78-1963-44eb-82da-8768cd09ae4f	SE016A	3	W	f	CV027	f	2022-08-09 15:20:59.270731	2022-08-09 15:20:59.270731
2d8a283f-e894-4110-8c88-6fbb6a41d64d	SE016A	3	Z	f	CV027	f	2022-08-09 15:20:59.276598	2022-08-09 15:20:59.276598
5cf2ca80-195a-4b2d-ba4f-189e2ab2dd63	SE016A	3	A	t	CV079	f	2022-08-09 15:20:59.282792	2022-08-09 15:20:59.282792
7346cda9-29cb-4284-8d17-fc945ec72086	SE016A	3	D	t	CV079	f	2022-08-09 15:20:59.288209	2022-08-09 15:20:59.288209
1def88a5-149c-432d-9c42-1cae66a8f629	SE016A	3	I	t	CV079	f	2022-08-09 15:20:59.29405	2022-08-09 15:20:59.29405
aa74b5f4-8e6c-469a-975c-8fe9038b8b81	SE016A	3	W	t	CV079	f	2022-08-09 15:20:59.299416	2022-08-09 15:20:59.299416
7166449b-b623-421c-a273-ff6b5a1ff9c9	SE016A	3	Z	t	CV079	f	2022-08-09 15:20:59.305181	2022-08-09 15:20:59.305181
4f3817e5-f998-4980-bbf5-08541f3042c1	SE016A	3	A	f	CV118	f	2022-08-09 15:20:59.370576	2022-08-09 15:20:59.370576
0eeeb08d-fd9d-4ed6-812e-b087ba4b9a73	SE016A	3	D	f	CV118	f	2022-08-09 15:20:59.376055	2022-08-09 15:20:59.376055
4b4153f7-0e3b-4a11-bd54-0b8276560f98	SE016A	3	I	f	CV118	f	2022-08-09 15:20:59.383068	2022-08-09 15:20:59.383068
87d72f55-8eec-4b26-aa2a-9950d68fb312	SE016A	3	W	f	CV118	f	2022-08-09 15:20:59.388705	2022-08-09 15:20:59.388705
faf7954a-a11a-4a30-9a72-a26c16ddd590	SE016A	3	Z	f	CV118	f	2022-08-09 15:20:59.395273	2022-08-09 15:20:59.395273
2682fb81-ec34-4b2b-9b4d-720d59ca2b96	SE016A	3	A	f	CV079	t	2022-08-09 15:20:59.310927	2022-08-09 15:20:59.403719
abab8e19-fe00-4613-b887-ac050ed48590	SE016A	3	D	f	CV079	t	2022-08-09 15:20:59.316465	2022-08-09 15:20:59.4115
af6275d3-d7bf-4c99-870a-f7b0fc1d888f	SE016A	3	I	f	CV079	t	2022-08-09 15:20:59.32259	2022-08-09 15:20:59.419145
33efc990-0081-41ed-b315-063bc8c428ac	SE016A	3	W	f	CV079	t	2022-08-09 15:20:59.32808	2022-08-09 15:20:59.426514
8df025bf-d7e9-4f91-8c78-3463e8ce7fae	SE016A	3	Z	f	CV079	t	2022-08-09 15:20:59.334018	2022-08-09 15:20:59.433554
425ae54a-f1ea-4061-bfdc-716d7b56d00d	SE016A	3	A	t	CV118	t	2022-08-09 15:20:59.339322	2022-08-09 15:20:59.441238
2ef72f28-1a01-4b87-a4b8-4ae15d0e0b7b	SE016A	3	D	t	CV118	t	2022-08-09 15:20:59.345167	2022-08-09 15:20:59.449989
c55debfb-2496-4a13-aabe-7db96a86c75b	SE016A	3	I	t	CV118	t	2022-08-09 15:20:59.352036	2022-08-09 15:20:59.458957
98c1c5a1-a177-463e-9fbb-78e3fb8d3ac0	SE016A	3	W	t	CV118	t	2022-08-09 15:20:59.357723	2022-08-09 15:20:59.46696
e316640f-fdfe-4f16-8f27-74aa207c7a16	SE016A	3	Z	t	CV118	t	2022-08-09 15:20:59.36439	2022-08-09 15:20:59.474983
45ba7790-16f2-4add-8328-25eafedfb04a	SE095A	3	A	t	APL09	f	2022-08-09 15:20:59.480858	2022-08-09 15:20:59.480858
248be9dd-92f6-4dd5-a92f-ea51182b4a43	SE095A	3	D	t	APL09	f	2022-08-09 15:20:59.48629	2022-08-09 15:20:59.48629
ed25fd6a-c0ff-46d9-8fb5-eaec0bb7e92a	SE095A	3	I	t	APL09	f	2022-08-09 15:20:59.491963	2022-08-09 15:20:59.491963
6e832d35-b90d-4e23-ab2d-b030228ef5c3	SE095A	3	W	t	APL09	f	2022-08-09 15:20:59.497688	2022-08-09 15:20:59.497688
4a17e615-6fa7-442f-a5c2-4a0aad13c76e	SE095A	3	Z	t	APL09	f	2022-08-09 15:20:59.503055	2022-08-09 15:20:59.503055
b32042cc-4539-4bb2-8a7d-4fb11e37e53f	SE095A	3	A	f	APL09	f	2022-08-09 15:20:59.508245	2022-08-09 15:20:59.508245
6531fe39-ecf1-4d28-a956-adb76ab449a7	SE095A	3	D	f	APL09	f	2022-08-09 15:20:59.513894	2022-08-09 15:20:59.513894
31220104-36d4-407a-aa5e-41e3d21ba8a6	SE095A	3	I	f	APL09	f	2022-08-09 15:20:59.519396	2022-08-09 15:20:59.519396
53d19d9a-d4af-4a64-b429-8f7d567e0730	SE095A	3	W	f	APL09	f	2022-08-09 15:20:59.525156	2022-08-09 15:20:59.525156
9d847d4f-8174-40c9-8310-baff019cd27d	SE095A	3	Z	f	APL09	f	2022-08-09 15:20:59.530652	2022-08-09 15:20:59.530652
29d681ac-47c6-4f8c-86b3-4505b659ecb5	SE095A	3	A	t	APL07	f	2022-08-09 15:20:59.536105	2022-08-09 15:20:59.536105
07caf3b5-9bcb-4aac-82c1-3a553fba5c86	SE095A	3	D	t	APL07	f	2022-08-09 15:20:59.541892	2022-08-09 15:20:59.541892
d5658f19-0495-411f-95f0-35eb22017c10	SE095A	3	I	t	APL07	f	2022-08-09 15:20:59.547205	2022-08-09 15:20:59.547205
0f7ff389-fc3b-4c99-9bd6-66d5cf103ca5	SE095A	3	W	t	APL07	f	2022-08-09 15:20:59.5532	2022-08-09 15:20:59.5532
f52b2817-87c5-4b6f-aa46-b058dda37bbc	SE095A	3	Z	t	APL07	f	2022-08-09 15:20:59.559913	2022-08-09 15:20:59.559913
60ef0305-31eb-4e32-a1fc-d5109de7e78f	SE095A	3	A	f	APL07	f	2022-08-09 15:20:59.566807	2022-08-09 15:20:59.566807
15e83537-7fed-44f0-8325-112beb30539b	SE095A	3	D	f	APL07	f	2022-08-09 15:20:59.573634	2022-08-09 15:20:59.573634
7da82932-bf0c-43d6-ad2d-41cbd1aa318e	SE095A	3	I	f	APL07	f	2022-08-09 15:20:59.580693	2022-08-09 15:20:59.580693
5104024d-e3dd-4d6d-87a2-328466784a01	SE095A	3	W	f	APL07	f	2022-08-09 15:20:59.58887	2022-08-09 15:20:59.58887
5dc64b41-8c60-4a5d-987b-6e097f4aaa8f	SE095A	3	Z	f	APL07	f	2022-08-09 15:20:59.595959	2022-08-09 15:20:59.595959
f431f33f-32b4-4897-baac-6509ef965640	SE095A	3	A	t	APL11	f	2022-08-09 15:20:59.602671	2022-08-09 15:20:59.602671
94635411-dab4-41fc-9513-f58e115bf172	SE095A	3	D	t	APL11	f	2022-08-09 15:20:59.609511	2022-08-09 15:20:59.609511
a6a966a6-3630-488c-81c2-fe187c58edaf	SE095A	3	I	t	APL11	f	2022-08-09 15:20:59.616294	2022-08-09 15:20:59.616294
a2b2f290-bf16-4b2c-b3b3-f08d4795ab90	SE095A	3	W	t	APL11	f	2022-08-09 15:20:59.62265	2022-08-09 15:20:59.62265
dc6d778b-9219-4a9f-a582-34e61816f461	SE095A	3	Z	t	APL11	f	2022-08-09 15:20:59.628172	2022-08-09 15:20:59.628172
95bd0220-09c6-4e71-bf45-66d3e4b5600a	SE095A	3	A	f	APL11	f	2022-08-09 15:20:59.63388	2022-08-09 15:20:59.63388
b0b283b1-5f90-47ca-ba11-425d862067e8	SE095A	3	D	f	APL11	f	2022-08-09 15:20:59.639385	2022-08-09 15:20:59.639385
ab4ad6e0-824e-42fc-97f0-bec78bc99b08	SE095A	3	I	f	APL11	f	2022-08-09 15:20:59.645145	2022-08-09 15:20:59.645145
0e0fbbbb-3fc2-4164-822a-c5dfc50dea5d	SE095A	3	W	f	APL11	f	2022-08-09 15:20:59.650584	2022-08-09 15:20:59.650584
baf548da-2d1b-42d3-8f01-a5ca74e23d94	SE095A	3	Z	f	APL11	f	2022-08-09 15:20:59.65633	2022-08-09 15:20:59.65633
58323dd5-383c-4803-9105-dc7a532f11b5	SE095A	3	A	t	APL13	f	2022-08-09 15:20:59.661899	2022-08-09 15:20:59.661899
98d6d9a2-a394-4c0d-ab80-fa64bc7ef358	SE095A	3	D	t	APL13	f	2022-08-09 15:20:59.667695	2022-08-09 15:20:59.667695
83379aa7-5636-4e46-abdc-896bc2d44a90	SE095A	3	I	t	APL13	f	2022-08-09 15:20:59.672981	2022-08-09 15:20:59.672981
79519e92-12de-4921-9d9c-0a10284b0b64	SE095A	3	W	t	APL13	f	2022-08-09 15:20:59.679212	2022-08-09 15:20:59.679212
20022bf0-6be5-4930-97f2-d71846af825a	SE095A	3	Z	t	APL13	f	2022-08-09 15:20:59.684996	2022-08-09 15:20:59.684996
ee9b4411-8548-486a-8666-b65ad7ac5815	SE095A	3	A	f	APL13	f	2022-08-09 15:20:59.691011	2022-08-09 15:20:59.691011
d5fc03b6-d47f-4767-bfa9-a23dbc97fac1	SE095A	3	D	f	APL13	f	2022-08-09 15:20:59.696516	2022-08-09 15:20:59.696516
efe1ff1c-5469-4672-af6f-98a12a2f3b13	SE095A	3	I	f	APL13	f	2022-08-09 15:20:59.701916	2022-08-09 15:20:59.701916
e52b5b25-a8e1-4a27-8e3e-646897beda68	SE095A	3	W	f	APL13	f	2022-08-09 15:20:59.70754	2022-08-09 15:20:59.70754
3dbc0dd9-a7d1-4070-83d4-e44aaafdea12	SE095A	3	Z	f	APL13	f	2022-08-09 15:20:59.713003	2022-08-09 15:20:59.713003
918421ae-3c92-441e-a780-1164f2cb69e4	SE095A	3	A	t	APL15	f	2022-08-09 15:20:59.718525	2022-08-09 15:20:59.718525
cc8e40b4-e79e-485a-b753-18f0c863e051	SE095A	3	D	t	APL15	f	2022-08-09 15:20:59.724406	2022-08-09 15:20:59.724406
6471ced3-237d-44cc-9a1d-24376bf882e0	SE095A	3	I	t	APL15	f	2022-08-09 15:20:59.729698	2022-08-09 15:20:59.729698
f856b856-76fb-470a-bfe6-35578d37b7a2	SE095A	3	W	t	APL15	f	2022-08-09 15:20:59.73532	2022-08-09 15:20:59.73532
648fc4ea-472a-4d5c-8640-261670311da5	SE095A	3	Z	t	APL15	f	2022-08-09 15:20:59.741047	2022-08-09 15:20:59.741047
10f27c60-c6f7-4501-af2d-41bc2eec4037	SE095A	3	A	f	APL15	f	2022-08-09 15:20:59.747175	2022-08-09 15:20:59.747175
f20ea71d-4869-4457-81c6-c5b321c7fbf6	SE095A	3	D	f	APL15	f	2022-08-09 15:20:59.752897	2022-08-09 15:20:59.752897
c4e333e3-9385-4171-b482-915c4f33a6b1	SE095A	3	I	f	APL15	f	2022-08-09 15:20:59.758407	2022-08-09 15:20:59.758407
b4de5bbe-549c-4dbf-af03-dae116e963ee	SE095A	3	W	f	APL15	f	2022-08-09 15:20:59.764191	2022-08-09 15:20:59.764191
ecd58690-c5cb-4aa3-8035-51d2de2fe2fa	SE095A	3	Z	f	APL15	f	2022-08-09 15:20:59.769845	2022-08-09 15:20:59.769845
d97d22ae-ae6d-4763-bee3-5f04c6b9cae3	SE095A	3	A	t	APL16	f	2022-08-09 15:20:59.775543	2022-08-09 15:20:59.775543
033803d7-b8be-48d4-9b14-65b9f32c9909	SE095A	3	D	t	APL16	f	2022-08-09 15:20:59.781379	2022-08-09 15:20:59.781379
3f6d5bbb-da87-4d10-bbb7-9baeb4004f42	SE095A	3	I	t	APL16	f	2022-08-09 15:20:59.787061	2022-08-09 15:20:59.787061
564f9ba3-07ea-4d4b-ad79-5633b3e3aa6b	SE095A	3	W	t	APL16	f	2022-08-09 15:20:59.792723	2022-08-09 15:20:59.792723
24b281ee-69be-4efd-88a1-546c12fd4e3b	SE095A	3	Z	t	APL16	f	2022-08-09 15:20:59.798214	2022-08-09 15:20:59.798214
ba72d1cb-bc4b-4e2b-af05-bc6d71488803	SE095A	3	A	f	APL16	f	2022-08-09 15:20:59.803536	2022-08-09 15:20:59.803536
c7b7c13c-33d0-4086-9773-0b92027159b1	SE095A	3	D	f	APL16	f	2022-08-09 15:20:59.809625	2022-08-09 15:20:59.809625
f5baefc3-1963-44f1-b816-90ff9e25b6b6	SE095A	3	I	f	APL16	f	2022-08-09 15:20:59.814873	2022-08-09 15:20:59.814873
afc1ea4b-df74-4e20-b533-446a5b669eba	SE095A	3	W	f	APL16	f	2022-08-09 15:20:59.820366	2022-08-09 15:20:59.820366
2c39f23b-c099-4c93-96b8-0f6182eaf107	SE095A	3	Z	f	APL16	f	2022-08-09 15:20:59.826396	2022-08-09 15:20:59.826396
1f5ed63d-24e3-4a73-a186-9e34c7510041	SE095A	3	A	t	APL18	f	2022-08-09 15:20:59.832019	2022-08-09 15:20:59.832019
a9e8198f-a4a4-419e-9196-65ad60065dab	SE095A	3	D	t	APL18	f	2022-08-09 15:20:59.837449	2022-08-09 15:20:59.837449
d3290737-acd8-4e02-a418-781c7ef09fa9	SE095A	3	I	t	APL18	f	2022-08-09 15:20:59.842997	2022-08-09 15:20:59.842997
43b77a8a-25b4-47c9-a943-62315d0598fd	SE095A	3	W	t	APL18	f	2022-08-09 15:20:59.848478	2022-08-09 15:20:59.848478
841b7705-da96-4fbb-9446-6aad70837bf3	SE095A	3	Z	t	APL18	f	2022-08-09 15:20:59.854665	2022-08-09 15:20:59.854665
ba294ad6-c7d2-493e-a4a0-dd8b59388f9d	SE095A	3	A	f	APL18	f	2022-08-09 15:20:59.860188	2022-08-09 15:20:59.860188
34ed1009-fff0-4d60-8dd4-ec20e30c295f	SE095A	3	D	f	APL18	f	2022-08-09 15:20:59.865522	2022-08-09 15:20:59.865522
2d2c21c3-fbea-4a43-9abb-e1cd2073be2c	SE095A	3	I	f	APL18	f	2022-08-09 15:20:59.871133	2022-08-09 15:20:59.871133
4341ca67-af13-4e50-958d-2af00cf20dc2	SE095A	3	W	f	APL18	f	2022-08-09 15:20:59.876687	2022-08-09 15:20:59.876687
86894919-5b78-48b2-bd32-06ea1a101023	SE095A	3	Z	f	APL18	f	2022-08-09 15:20:59.882489	2022-08-09 15:20:59.882489
bf90590a-ef51-4290-9773-9b0f7a8e849b	SE095A	3	A	t	APL20	f	2022-08-09 15:20:59.887855	2022-08-09 15:20:59.887855
a7f84877-eb86-477f-9cb7-422f4a6a0a1b	SE095A	3	D	t	APL20	f	2022-08-09 15:20:59.89343	2022-08-09 15:20:59.89343
833eeb24-90a3-468c-ae92-04fca53d3f85	SE095A	3	I	t	APL20	f	2022-08-09 15:20:59.898795	2022-08-09 15:20:59.898795
c20d514b-5d30-4df5-bf26-57297aaec56b	SE095A	3	W	t	APL20	f	2022-08-09 15:20:59.904575	2022-08-09 15:20:59.904575
ff2e4055-a266-4730-941a-f48d573d837a	SE095A	3	Z	t	APL20	f	2022-08-09 15:20:59.909996	2022-08-09 15:20:59.909996
2b702615-afec-4cf0-9335-50e66e0e9320	SE095A	3	A	f	APL20	f	2022-08-09 15:20:59.915258	2022-08-09 15:20:59.915258
42eadd09-c576-462e-a498-a075a87282a4	SE095A	3	D	f	APL20	f	2022-08-09 15:20:59.922581	2022-08-09 15:20:59.922581
985cfe9c-975d-4beb-aa93-4e5e64a03354	SE095A	3	I	f	APL20	f	2022-08-09 15:20:59.928632	2022-08-09 15:20:59.928632
b0b172e7-e665-44c7-9693-afefcc935b57	SE095A	3	W	f	APL20	f	2022-08-09 15:20:59.935379	2022-08-09 15:20:59.935379
6eb76185-171d-4c33-b0aa-44a51ae48e66	SE095A	3	Z	f	APL20	f	2022-08-09 15:20:59.941352	2022-08-09 15:20:59.941352
084e8677-3614-4748-aca0-ea314e928d49	SE095A	3	A	t	APL22	f	2022-08-09 15:20:59.946849	2022-08-09 15:20:59.946849
8511616a-84ef-4593-81f7-cf2c2b8d53f7	SE095A	3	D	t	APL22	f	2022-08-09 15:20:59.952558	2022-08-09 15:20:59.952558
a0460d47-270b-438e-b8ef-e3d850475ee3	SE095A	3	I	t	APL22	f	2022-08-09 15:20:59.958223	2022-08-09 15:20:59.958223
badb200e-b5c6-4891-a11a-ab091bc315eb	SE095A	3	W	t	APL22	f	2022-08-09 15:20:59.963923	2022-08-09 15:20:59.963923
c553cfa5-1ee5-4f4f-b2e0-03237b03556c	SE095A	3	Z	t	APL22	f	2022-08-09 15:20:59.969449	2022-08-09 15:20:59.969449
678a3e98-46d9-445f-9751-316a751c0674	SE095A	3	A	f	APL22	f	2022-08-09 15:20:59.975076	2022-08-09 15:20:59.975076
aa3e6eaf-dbca-4b92-a023-69a31eeda2e9	SE095A	3	D	f	APL22	f	2022-08-09 15:20:59.981149	2022-08-09 15:20:59.981149
050f0639-930c-4ff0-a8a7-6b0dd919309e	SE095A	3	I	f	APL22	f	2022-08-09 15:20:59.987858	2022-08-09 15:20:59.987858
88657b6e-d047-493d-bc2a-552664dbf2a9	SE095A	3	W	f	APL22	f	2022-08-09 15:20:59.993688	2022-08-09 15:20:59.993688
0ee69525-6712-4200-b45e-cf15506e91de	SE095A	3	Z	f	APL22	f	2022-08-09 15:20:59.999381	2022-08-09 15:20:59.999381
ca16e21e-f5c8-4a37-a7dd-6a984cb53c6f	SE095A	3	A	t	APL27	f	2022-08-09 15:21:00.006037	2022-08-09 15:21:00.006037
a3a1a601-07ef-4f51-b496-db3ddda80662	SE095A	3	D	t	APL27	f	2022-08-09 15:21:00.01215	2022-08-09 15:21:00.01215
ed2eed2b-f3a7-4d2a-abba-8d570020f5da	SE095A	3	I	t	APL27	f	2022-08-09 15:21:00.019651	2022-08-09 15:21:00.019651
6a9c9239-2b1a-484b-b415-8388f5d746fe	SE095A	3	W	t	APL27	f	2022-08-09 15:21:00.0254	2022-08-09 15:21:00.0254
12ab3d2b-6f75-414c-9265-1bf099327aad	SE095A	3	Z	t	APL27	f	2022-08-09 15:21:00.032342	2022-08-09 15:21:00.032342
3800317d-3504-43a7-9eba-64d387b076e9	SE095A	3	A	f	APL27	f	2022-08-09 15:21:00.038157	2022-08-09 15:21:00.038157
89a8a79e-d845-47b0-966b-3664bf11237e	SE095A	3	D	f	APL27	f	2022-08-09 15:21:00.044827	2022-08-09 15:21:00.044827
d33863af-3519-4dbc-af37-1ba3dab6d39a	SE095A	3	I	f	APL27	f	2022-08-09 15:21:00.052394	2022-08-09 15:21:00.052394
ce60351e-fa58-4660-abd8-a64108f12c63	SE095A	3	W	f	APL27	f	2022-08-09 15:21:00.059053	2022-08-09 15:21:00.059053
af49c692-01bb-433d-b3e5-6bf9f21c68ff	SE095A	3	Z	f	APL27	f	2022-08-09 15:21:00.065817	2022-08-09 15:21:00.065817
0abe7626-b1ac-4987-a6aa-913e36d0fdbc	SE095A	3	A	t	APL29	f	2022-08-09 15:21:00.071503	2022-08-09 15:21:00.071503
52719141-4a20-4d46-b192-121b00d432fa	SE095A	3	D	t	APL29	f	2022-08-09 15:21:00.077251	2022-08-09 15:21:00.077251
083bc4a2-c78c-4046-8881-773821ee26bf	SE095A	3	I	t	APL29	f	2022-08-09 15:21:00.084789	2022-08-09 15:21:00.084789
5a61f5a8-95ee-48e2-8b94-e68c82905eb2	SE095A	3	W	t	APL29	f	2022-08-09 15:21:00.090492	2022-08-09 15:21:00.090492
8a2dbd72-c304-445a-97c1-12a7b13db56b	SE095A	3	Z	t	APL29	f	2022-08-09 15:21:00.096363	2022-08-09 15:21:00.096363
ed18ae82-4abd-4ad9-8042-7f235915ab30	SE095A	3	A	f	APL29	f	2022-08-09 15:21:00.101992	2022-08-09 15:21:00.101992
21942e06-8375-43fd-a0c0-90d6d927003a	SE095A	3	D	f	APL29	f	2022-08-09 15:21:00.107486	2022-08-09 15:21:00.107486
189c4842-141b-463f-b329-56b3f6914083	SE095A	3	I	f	APL29	f	2022-08-09 15:21:00.113545	2022-08-09 15:21:00.113545
45af8718-2400-4db9-a55e-c6958da5a7e2	SE095A	3	W	f	APL29	f	2022-08-09 15:21:00.119611	2022-08-09 15:21:00.119611
89b0421a-8b45-43d6-9f03-9447af2b3777	SE095A	3	Z	f	APL29	f	2022-08-09 15:21:00.125408	2022-08-09 15:21:00.125408
7bfca736-abdc-4e1f-bbb9-20b02da07655	SE095A	3	A	t	APL31	f	2022-08-09 15:21:00.131141	2022-08-09 15:21:00.131141
885dbcc4-604b-4bb2-a058-801a020c4ecd	SE095A	3	D	t	APL31	f	2022-08-09 15:21:00.136636	2022-08-09 15:21:00.136636
a7ad1f9b-8e08-4196-8f45-ceaf5bedd9fc	SE095A	3	I	t	APL31	f	2022-08-09 15:21:00.142398	2022-08-09 15:21:00.142398
6c5a95ba-2d1d-408d-8bc5-8b1cb0ad4d2a	SE095A	3	W	t	APL31	f	2022-08-09 15:21:00.147766	2022-08-09 15:21:00.147766
e7b15526-b506-44fe-8e5f-334a5c835d4e	SE095A	3	Z	t	APL31	f	2022-08-09 15:21:00.153127	2022-08-09 15:21:00.153127
56de765b-1cfa-476b-90d2-ad3ff8721684	SE095A	3	A	f	APL31	f	2022-08-09 15:21:00.158919	2022-08-09 15:21:00.158919
a7906a65-1df6-4ae0-b568-4ce920f6e274	SE095A	3	D	f	APL31	f	2022-08-09 15:21:00.164459	2022-08-09 15:21:00.164459
70fbc203-f5be-4738-9e6d-3163d829ae61	SE095A	3	I	f	APL31	f	2022-08-09 15:21:00.170777	2022-08-09 15:21:00.170777
a5761053-fe59-4e01-b79d-05b75bb0e5d6	SE095A	3	W	f	APL31	f	2022-08-09 15:21:00.176406	2022-08-09 15:21:00.176406
d827595a-3d3b-4c34-b4d9-a7775be3888a	SE095A	3	Z	f	APL31	f	2022-08-09 15:21:00.182783	2022-08-09 15:21:00.182783
e8a9d652-c121-488d-af09-7b08d8ff9409	SE095A	3	A	t	APL48	f	2022-08-09 15:21:00.188721	2022-08-09 15:21:00.188721
125d0545-ad0a-4f5a-8537-ae34ac23fb66	SE095A	3	D	t	APL48	f	2022-08-09 15:21:00.194207	2022-08-09 15:21:00.194207
44ea4d80-a14f-404a-ae92-0e1e9028e725	SE095A	3	I	t	APL48	f	2022-08-09 15:21:00.199606	2022-08-09 15:21:00.199606
0d0abbfe-4418-4840-80af-f949427e40ce	SE095A	3	W	t	APL48	f	2022-08-09 15:21:00.205425	2022-08-09 15:21:00.205425
05ce5424-6204-40a0-b282-b7037b9fe3a9	SE095A	3	Z	t	APL48	f	2022-08-09 15:21:00.210891	2022-08-09 15:21:00.210891
fb7c43a9-bb02-4b91-997a-31365a83c551	SE095A	3	A	f	APL48	f	2022-08-09 15:21:00.216765	2022-08-09 15:21:00.216765
02550485-a3c1-4991-b629-89732c539e40	SE095A	3	D	f	APL48	f	2022-08-09 15:21:00.222322	2022-08-09 15:21:00.222322
fba6636b-4651-4b8b-bad3-3e1fd96da082	SE095A	3	I	f	APL48	f	2022-08-09 15:21:00.228659	2022-08-09 15:21:00.228659
3a719872-d838-418f-a0ee-9f6ae6e5ad09	SE095A	3	W	f	APL48	f	2022-08-09 15:21:00.235356	2022-08-09 15:21:00.235356
2ad692da-2a4f-45e5-b901-a002ab1a1dfe	SE095A	3	Z	f	APL48	f	2022-08-09 15:21:00.241716	2022-08-09 15:21:00.241716
1e9f4e7f-4a45-4ae1-8248-bc33a7c73b44	SE095A	3	A	t	APL49	f	2022-08-09 15:21:00.247468	2022-08-09 15:21:00.247468
da798b48-d210-4740-9cf1-d0651d9d8508	SE095A	3	D	t	APL49	f	2022-08-09 15:21:00.25278	2022-08-09 15:21:00.25278
21902ef3-0409-4ca8-b737-7fbbcf10319c	SE095A	3	I	t	APL49	f	2022-08-09 15:21:00.258505	2022-08-09 15:21:00.258505
b48d5bcd-c538-41cc-a033-74c1efc0de2e	SE095A	3	W	t	APL49	f	2022-08-09 15:21:00.265283	2022-08-09 15:21:00.265283
ee89085c-dbb1-4c6f-9d32-868310431c47	SE095A	3	Z	t	APL49	f	2022-08-09 15:21:00.271152	2022-08-09 15:21:00.271152
3493a7f0-c463-47ee-98e7-bbce5755c364	SE095A	3	A	f	APL49	f	2022-08-09 15:21:00.276862	2022-08-09 15:21:00.276862
6ff5ab54-c573-4718-844a-4b594d407cf7	SE095A	3	D	f	APL49	f	2022-08-09 15:21:00.282811	2022-08-09 15:21:00.282811
dbbb666b-9adb-4e89-9e06-b44fa3c2c275	SE095A	3	I	f	APL49	f	2022-08-09 15:21:00.288625	2022-08-09 15:21:00.288625
e5c3eaf1-a06b-405e-94ea-c4849b6b991c	SE095A	3	W	f	APL49	f	2022-08-09 15:21:00.294097	2022-08-09 15:21:00.294097
376755ce-76c6-46e7-8a82-138e27c9618f	SE095A	3	Z	f	APL49	f	2022-08-09 15:21:00.29997	2022-08-09 15:21:00.29997
282b81e8-e96a-41a4-8c8c-d8f14ea5b7e8	SE095A	3	A	t	APL50	f	2022-08-09 15:21:00.305795	2022-08-09 15:21:00.305795
40366264-2a0c-49bb-a7ec-ddb047054cc7	SE095A	3	D	t	APL50	f	2022-08-09 15:21:00.311458	2022-08-09 15:21:00.311458
f3820aeb-5a10-48f1-8b4b-d4ae0737ae02	SE095A	3	I	t	APL50	f	2022-08-09 15:21:00.316836	2022-08-09 15:21:00.316836
d93c78de-58f0-42bb-ad01-e5cffca095b2	SE095A	3	W	t	APL50	f	2022-08-09 15:21:00.322377	2022-08-09 15:21:00.322377
1a280b83-5b56-44b1-92f8-e56769cec5c1	SE095A	3	Z	t	APL50	f	2022-08-09 15:21:00.327682	2022-08-09 15:21:00.327682
b2c36cfe-b5fc-42ac-b2a0-dcf51b3b3370	SE095A	3	A	f	APL50	f	2022-08-09 15:21:00.333438	2022-08-09 15:21:00.333438
6b239d7d-4421-4336-9527-5b1c6eae3b05	SE095A	3	D	f	APL50	f	2022-08-09 15:21:00.338751	2022-08-09 15:21:00.338751
67942baf-492b-4c24-80f3-30eb4e5948c7	SE095A	3	I	f	APL50	f	2022-08-09 15:21:00.344269	2022-08-09 15:21:00.344269
3c5d285a-d208-4051-b9bc-a876497aff6d	SE095A	3	W	f	APL50	f	2022-08-09 15:21:00.350802	2022-08-09 15:21:00.350802
87ed66c7-a0be-4474-8a09-aaad763ebccd	SE095A	3	Z	f	APL50	f	2022-08-09 15:21:00.356931	2022-08-09 15:21:00.356931
a53aed9d-acf8-4e42-8e89-5b2d83e11d69	SE095A	3	A	t	APL51	f	2022-08-09 15:21:00.363449	2022-08-09 15:21:00.363449
bffff650-e0a5-4cd7-af0c-a8b21dd3ea57	SE095A	3	D	t	APL51	f	2022-08-09 15:21:00.370099	2022-08-09 15:21:00.370099
fb2172af-87b3-432f-9e40-7cd7387683ca	SE095A	3	I	t	APL51	f	2022-08-09 15:21:00.375957	2022-08-09 15:21:00.375957
d4d3e804-59e2-4cb1-b40b-21ee81f1fcde	SE095A	3	W	t	APL51	f	2022-08-09 15:21:00.382483	2022-08-09 15:21:00.382483
146b2cc4-5fe0-4310-ba4c-a5b4cefa078d	SE095A	3	Z	t	APL51	f	2022-08-09 15:21:00.388261	2022-08-09 15:21:00.388261
8b9a22ea-3bbe-4030-9dfd-f551be9c82fd	SE095A	3	A	f	APL51	f	2022-08-09 15:21:00.394197	2022-08-09 15:21:00.394197
6bdf6498-392e-4362-978f-adb17a2ff0b8	SE095A	3	D	f	APL51	f	2022-08-09 15:21:00.400183	2022-08-09 15:21:00.400183
9690e2e3-4e3d-4220-bce5-2bcc1e32ae13	SE095A	3	I	f	APL51	f	2022-08-09 15:21:00.406114	2022-08-09 15:21:00.406114
cb4a68de-b04c-471e-8166-e93aa95a78d8	SE095A	3	W	f	APL51	f	2022-08-09 15:21:00.411575	2022-08-09 15:21:00.411575
dab52060-de4b-49ac-abf9-d4a884e813f9	SE095A	3	Z	f	APL51	f	2022-08-09 15:21:00.416987	2022-08-09 15:21:00.416987
572acb47-3e2c-40fa-b3fd-4a59db5d38a8	SE095A	3	A	t	APL52	f	2022-08-09 15:21:00.422624	2022-08-09 15:21:00.422624
9abe716a-f634-490c-800d-50a913c0f74b	SE095A	3	D	t	APL52	f	2022-08-09 15:21:00.428092	2022-08-09 15:21:00.428092
929b8312-8708-4b9f-9f64-07ff1b58ff00	SE095A	3	I	t	APL52	f	2022-08-09 15:21:00.433613	2022-08-09 15:21:00.433613
0832e4cc-5d80-4344-89a3-dbe7d50adb5f	SE095A	3	W	t	APL52	f	2022-08-09 15:21:00.439039	2022-08-09 15:21:00.439039
892da3a0-153c-4685-a981-8c22ef934f69	SE095A	3	Z	t	APL52	f	2022-08-09 15:21:00.444294	2022-08-09 15:21:00.444294
29e9d585-2ade-4ccd-a781-8d91ac0141e6	SE095A	3	A	f	APL52	f	2022-08-09 15:21:00.450661	2022-08-09 15:21:00.450661
864de8f6-9004-414f-b20a-24f05119efce	SE095A	3	D	f	APL52	f	2022-08-09 15:21:00.456168	2022-08-09 15:21:00.456168
c421f0a1-eeb6-4205-a80a-5ba43bde99d5	SE095A	3	I	f	APL52	f	2022-08-09 15:21:00.461901	2022-08-09 15:21:00.461901
04382efc-ef46-443c-ae03-f69e5cfc9c85	SE095A	3	W	f	APL52	f	2022-08-09 15:21:00.467824	2022-08-09 15:21:00.467824
f88229a5-f060-4596-9c60-42b7b195bb38	SE095A	3	Z	f	APL52	f	2022-08-09 15:21:00.473259	2022-08-09 15:21:00.473259
b8b73455-c83a-4172-bdef-3cb7e0c2eff6	SE095A	3	A	t	APL53	f	2022-08-09 15:21:00.480195	2022-08-09 15:21:00.480195
34881453-97de-4064-9282-5a8f0e3b965c	SE095A	3	D	t	APL53	f	2022-08-09 15:21:00.486905	2022-08-09 15:21:00.486905
00066601-9536-4aa5-adf4-c95b5df87dc2	SE095A	3	I	t	APL53	f	2022-08-09 15:21:00.493655	2022-08-09 15:21:00.493655
4b984ed5-31d2-4e64-be98-fa52cc5203d8	SE095A	3	W	t	APL53	f	2022-08-09 15:21:00.501029	2022-08-09 15:21:00.501029
ee2aa06a-91fc-4622-b18a-1b8dcecba79c	SE095A	3	Z	t	APL53	f	2022-08-09 15:21:00.507536	2022-08-09 15:21:00.507536
fffea899-cef9-4dc3-9807-b874f49f4e2a	SE095A	3	A	f	APL53	f	2022-08-09 15:21:00.513661	2022-08-09 15:21:00.513661
ad64965a-ff04-473a-85a7-c9e090930000	SE095A	3	D	f	APL53	f	2022-08-09 15:21:00.519724	2022-08-09 15:21:00.519724
6aafff4b-9556-4196-af47-9bbdebcc24d9	SE095A	3	I	f	APL53	f	2022-08-09 15:21:00.525054	2022-08-09 15:21:00.525054
eff06dcf-2515-45f2-ba28-031f58e2a195	SE095A	3	W	f	APL53	f	2022-08-09 15:21:00.530713	2022-08-09 15:21:00.530713
c18eb185-5b1e-4c73-89fa-9439088c82bf	SE095A	3	Z	f	APL53	f	2022-08-09 15:21:00.536348	2022-08-09 15:21:00.536348
61b86ff2-5b12-4352-944e-ccd598df199d	SE095A	3	A	t	APL54	f	2022-08-09 15:21:00.541704	2022-08-09 15:21:00.541704
8232bdae-ea2a-4dc6-9151-5eb96c2b606b	SE095A	3	D	t	APL54	f	2022-08-09 15:21:00.547453	2022-08-09 15:21:00.547453
36848351-057e-4bad-a7bc-21f47e932b6b	SE095A	3	I	t	APL54	f	2022-08-09 15:21:00.552997	2022-08-09 15:21:00.552997
cc88d681-9cd8-43a2-9031-41e06ed94217	SE095A	3	W	t	APL54	f	2022-08-09 15:21:00.558596	2022-08-09 15:21:00.558596
e5501f2d-04f9-46fd-aeb5-0e766588634f	SE095A	3	Z	t	APL54	f	2022-08-09 15:21:00.564018	2022-08-09 15:21:00.564018
23ca3cba-f2a2-4666-9c66-9b5e9c786ae5	SE095A	3	A	f	APL54	f	2022-08-09 15:21:00.569502	2022-08-09 15:21:00.569502
25b7869b-9922-4a0c-9abb-9e404c450529	SE095A	3	D	f	APL54	f	2022-08-09 15:21:00.574869	2022-08-09 15:21:00.574869
3f93cfba-49c8-4bb9-a7a0-f8ccaf9f444d	SE095A	3	I	f	APL54	f	2022-08-09 15:21:00.58028	2022-08-09 15:21:00.58028
037cb939-5b70-47cb-88fd-6314517e8e03	SE095A	3	W	f	APL54	f	2022-08-09 15:21:00.586296	2022-08-09 15:21:00.586296
732286cd-d886-4905-b4ec-fcc62873ecac	SE095A	3	Z	f	APL54	f	2022-08-09 15:21:00.591777	2022-08-09 15:21:00.591777
e7311eca-694f-48f0-b1b4-7ae7732ee147	SE095A	3	A	t	APL55	f	2022-08-09 15:21:00.598749	2022-08-09 15:21:00.598749
d5da4698-da38-4b78-8697-982b38f3b1f7	SE095A	3	D	t	APL55	f	2022-08-09 15:21:00.604375	2022-08-09 15:21:00.604375
4939a55f-82f3-4a02-a6a6-037491073776	SE095A	3	I	t	APL55	f	2022-08-09 15:21:00.610121	2022-08-09 15:21:00.610121
d4652237-b577-4f96-8bc7-8179824ec15c	SE095A	3	W	t	APL55	f	2022-08-09 15:21:00.615578	2022-08-09 15:21:00.615578
cb35f76c-2503-4067-8e9b-8bdef36b99c6	SE095A	3	Z	t	APL55	f	2022-08-09 15:21:00.621389	2022-08-09 15:21:00.621389
370a140f-d68b-4e54-9b7e-124f1fff4acc	SE095A	3	A	f	APL55	f	2022-08-09 15:21:00.627065	2022-08-09 15:21:00.627065
90269aad-1c86-44f1-bce5-a57e439cf889	SE095A	3	D	f	APL55	f	2022-08-09 15:21:00.632644	2022-08-09 15:21:00.632644
b857da73-f0f2-49bb-b7be-716829cd9dff	SE095A	3	I	f	APL55	f	2022-08-09 15:21:00.638369	2022-08-09 15:21:00.638369
f436c575-35f3-4534-b06f-5a696d2e12b9	SE095A	3	W	f	APL55	f	2022-08-09 15:21:00.643834	2022-08-09 15:21:00.643834
9da425c5-9a7c-4577-a0ab-c75ab1c63763	SE095A	3	Z	f	APL55	f	2022-08-09 15:21:00.649571	2022-08-09 15:21:00.649571
8737c993-034f-41b1-8fff-fa985cca4bae	SE095A	3	A	t	APL56	f	2022-08-09 15:21:00.654915	2022-08-09 15:21:00.654915
8b3bc5bd-bc33-4ca0-a47c-d85ce9231be8	SE095A	3	D	t	APL56	f	2022-08-09 15:21:00.660588	2022-08-09 15:21:00.660588
e7da15a5-7dea-416c-8b2b-26ed971da545	SE095A	3	I	t	APL56	f	2022-08-09 15:21:00.666127	2022-08-09 15:21:00.666127
3c92a687-25fb-4af9-862b-c1ced46b483b	SE095A	3	W	t	APL56	f	2022-08-09 15:21:00.671535	2022-08-09 15:21:00.671535
22b1eddf-8239-46f4-ab1e-fdab9568d915	SE095A	3	Z	t	APL56	f	2022-08-09 15:21:00.677302	2022-08-09 15:21:00.677302
76c8dbc8-382a-4154-bd5b-9d8b642ec7fa	SE095A	3	A	f	APL56	f	2022-08-09 15:21:00.682649	2022-08-09 15:21:00.682649
78243d5e-d60e-4257-af5f-03708078bef0	SE095A	3	D	f	APL56	f	2022-08-09 15:21:00.688654	2022-08-09 15:21:00.688654
35cdef5b-a1db-4ae3-bea8-0a017c3f4e0b	SE095A	3	I	f	APL56	f	2022-08-09 15:21:00.694462	2022-08-09 15:21:00.694462
cefa92fe-d884-4e6f-9ef8-8cb75c6a3725	SE095A	3	W	f	APL56	f	2022-08-09 15:21:00.700147	2022-08-09 15:21:00.700147
004afbd3-7a39-4ef2-8b88-7c1f54bb74e5	SE095A	3	Z	f	APL56	f	2022-08-09 15:21:00.705566	2022-08-09 15:21:00.705566
6503d17b-bcd5-4fd0-b010-eae75211493b	SE095A	3	A	t	APL57	f	2022-08-09 15:21:00.711455	2022-08-09 15:21:00.711455
c1aa7f84-6acd-48c9-a28a-9b58e9b92310	SE095A	3	D	t	APL57	f	2022-08-09 15:21:00.716972	2022-08-09 15:21:00.716972
08477672-e978-4c66-920a-656158b7ef1e	SE095A	3	I	t	APL57	f	2022-08-09 15:21:00.722327	2022-08-09 15:21:00.722327
761bcd94-3610-415a-bd6a-b9c7d5cc50c8	SE095A	3	W	t	APL57	f	2022-08-09 15:21:00.728149	2022-08-09 15:21:00.728149
359e367e-6583-4091-8907-3337ad6d2a9f	SE095A	3	Z	t	APL57	f	2022-08-09 15:21:00.733467	2022-08-09 15:21:00.733467
b52f75e0-a487-427b-96cd-71d951ba4d6e	SE095A	3	A	f	APL57	f	2022-08-09 15:21:00.739234	2022-08-09 15:21:00.739234
c6de2825-50d1-4759-9ee9-d9b2caf35b00	SE095A	3	D	f	APL57	f	2022-08-09 15:21:00.744912	2022-08-09 15:21:00.744912
ffd7657d-e4ea-421a-aae9-84f43999b5f6	SE095A	3	I	f	APL57	f	2022-08-09 15:21:00.750642	2022-08-09 15:21:00.750642
f1efcc57-415f-439d-8ec6-21a21ac9572e	SE095A	3	W	f	APL57	f	2022-08-09 15:21:00.756412	2022-08-09 15:21:00.756412
f04b96f0-13d6-441f-ac81-a91cb6c8185d	SE095A	3	Z	f	APL57	f	2022-08-09 15:21:00.761747	2022-08-09 15:21:00.761747
ce86d752-b4ec-4e73-a1b5-43b734c46365	SE095A	3	A	t	APL65	f	2022-08-09 15:21:00.767104	2022-08-09 15:21:00.767104
5c23d6e7-8ed9-4771-a0cc-18bda800be71	SE095A	3	D	t	APL65	f	2022-08-09 15:21:00.772865	2022-08-09 15:21:00.772865
569f7f55-d919-4a82-b9fe-fdf6b8f8e4b5	SE095A	3	I	t	APL65	f	2022-08-09 15:21:00.778249	2022-08-09 15:21:00.778249
7a374924-6809-45bc-a89d-90344ee4c02c	SE095A	3	W	t	APL65	f	2022-08-09 15:21:00.784407	2022-08-09 15:21:00.784407
7cd6c746-b66b-4916-92de-53d26eeb15d6	SE095A	3	Z	t	APL65	f	2022-08-09 15:21:00.790079	2022-08-09 15:21:00.790079
632b68f7-a7bf-4032-b642-e8b827fb5cc7	SE095A	3	A	f	APL65	f	2022-08-09 15:21:00.795437	2022-08-09 15:21:00.795437
9cf5e651-b434-4fb5-933f-34a0ae777fcd	SE095A	3	D	f	APL65	f	2022-08-09 15:21:00.801415	2022-08-09 15:21:00.801415
9c28ae5e-b460-4ad6-b8f0-bb6647a97ec5	SE095A	3	I	f	APL65	f	2022-08-09 15:21:00.806987	2022-08-09 15:21:00.806987
2e364a40-24d0-4461-907d-8789103ac877	SE095A	3	W	f	APL65	f	2022-08-09 15:21:00.81231	2022-08-09 15:21:00.81231
7c392855-adbc-4ead-8dbb-26b007af1501	SE095A	3	Z	f	APL65	f	2022-08-09 15:21:00.818039	2022-08-09 15:21:00.818039
69ca3885-e85e-4c99-b2d8-6f4e17de1fbe	SE095A	3	A	t	APL66	f	2022-08-09 15:21:00.823488	2022-08-09 15:21:00.823488
1d9eff50-ad94-46e5-ba2f-952fb07cd680	SE095A	3	D	t	APL66	f	2022-08-09 15:21:00.829428	2022-08-09 15:21:00.829428
67ecad7a-3205-483d-b551-6db1e388c95c	SE095A	3	I	t	APL66	f	2022-08-09 15:21:00.83487	2022-08-09 15:21:00.83487
2568c518-2c3a-45e7-84d5-ebf6926f66e6	SE095A	3	W	t	APL66	f	2022-08-09 15:21:00.840128	2022-08-09 15:21:00.840128
68eb0bb9-c1ca-4cf2-99ab-84094832cde0	SE095A	3	Z	t	APL66	f	2022-08-09 15:21:00.845853	2022-08-09 15:21:00.845853
91bfe067-b4f5-4ae4-b1e5-58038f64df21	SE095A	3	A	f	APL66	f	2022-08-09 15:21:00.851495	2022-08-09 15:21:00.851495
6f0d8bfe-d333-40eb-9276-f61d9c20b928	SE095A	3	D	f	APL66	f	2022-08-09 15:21:00.857088	2022-08-09 15:21:00.857088
47d0414e-90de-4848-9323-f0fe843aa873	SE095A	3	I	f	APL66	f	2022-08-09 15:21:00.862909	2022-08-09 15:21:00.862909
3426a4a8-d519-4448-9f76-40387f54bf58	SE095A	3	W	f	APL66	f	2022-08-09 15:21:00.868266	2022-08-09 15:21:00.868266
ce834501-d4b9-4ac6-8440-a57d65d3b37b	SE095A	3	Z	f	APL66	f	2022-08-09 15:21:00.873595	2022-08-09 15:21:00.873595
d78c89be-cff7-4264-8389-4419e7cc5eda	SE095A	3	A	t	APL67	f	2022-08-09 15:21:00.879236	2022-08-09 15:21:00.879236
cecb3238-dc95-4398-a7e0-c3a74f306347	SE095A	3	D	t	APL67	f	2022-08-09 15:21:00.884472	2022-08-09 15:21:00.884472
79d96176-8c03-44af-b3b9-704217c7be4e	SE095A	3	I	t	APL67	f	2022-08-09 15:21:00.890261	2022-08-09 15:21:00.890261
df33f603-6312-4f25-8356-db6c2ce37706	SE095A	3	W	t	APL67	f	2022-08-09 15:21:00.895791	2022-08-09 15:21:00.895791
30095f6a-03dc-40c2-a467-8a22553d81ed	SE095A	3	Z	t	APL67	f	2022-08-09 15:21:00.901096	2022-08-09 15:21:00.901096
80577668-b12d-434d-b5bd-bc91b4c0da0b	SE095A	3	A	f	APL67	f	2022-08-09 15:21:00.906525	2022-08-09 15:21:00.906525
ac2146cb-d904-4065-8620-0cffd3d4928a	SE095A	3	D	f	APL67	f	2022-08-09 15:21:00.912239	2022-08-09 15:21:00.912239
980d671e-0225-4b20-94f5-c22640332f7d	SE095A	3	I	f	APL67	f	2022-08-09 15:21:00.917684	2022-08-09 15:21:00.917684
80df5e4b-0085-4117-b517-f35ee6ec4a64	SE095A	3	W	f	APL67	f	2022-08-09 15:21:00.924825	2022-08-09 15:21:00.924825
b53a53bd-f4ae-44d0-87ee-7b3602b4dea8	SE095A	3	Z	f	APL67	f	2022-08-09 15:21:00.930376	2022-08-09 15:21:00.930376
96ea9970-ca3c-4283-b04e-291ce1d1a670	SE095A	3	A	t	APL68	f	2022-08-09 15:21:00.936178	2022-08-09 15:21:00.936178
2ef1b2e0-c116-4452-a978-02b0269f8409	SE095A	3	D	t	APL68	f	2022-08-09 15:21:00.941591	2022-08-09 15:21:00.941591
09972ad6-4530-43ad-a302-097c6c65fe0b	SE095A	3	I	t	APL68	f	2022-08-09 15:21:00.9473	2022-08-09 15:21:00.9473
ed2e2fac-98bb-4049-985b-23c8d0b6fd29	SE095A	3	W	t	APL68	f	2022-08-09 15:21:00.953415	2022-08-09 15:21:00.953415
977b07db-b877-4382-9b6a-ed8b329ec3bd	SE095A	3	Z	t	APL68	f	2022-08-09 15:21:00.958922	2022-08-09 15:21:00.958922
72686f80-7a23-4ca1-820b-699e3505da37	SE095A	3	A	f	APL68	f	2022-08-09 15:21:00.964611	2022-08-09 15:21:00.964611
ffe19ff0-517f-4faf-90a8-ec668eb382e8	SE095A	3	D	f	APL68	f	2022-08-09 15:21:00.970079	2022-08-09 15:21:00.970079
d39011f1-9e7e-43bd-9c92-143c3d4b2214	SE095A	3	I	f	APL68	f	2022-08-09 15:21:00.975892	2022-08-09 15:21:00.975892
2930930d-f077-4c47-96f6-450c15e2555d	SE095A	3	W	f	APL68	f	2022-08-09 15:21:00.981259	2022-08-09 15:21:00.981259
7a80b2a4-0642-418b-923a-7b2891aa4ffa	SE095A	3	Z	f	APL68	f	2022-08-09 15:21:00.987643	2022-08-09 15:21:00.987643
369b99af-a99f-44ae-a46d-eeb481e652b9	SE095A	3	A	t	APL69	f	2022-08-09 15:21:00.994465	2022-08-09 15:21:00.994465
e68d1b6c-c8f0-4a8c-8e58-781ccdf1d434	SE095A	3	D	t	APL69	f	2022-08-09 15:21:01.000356	2022-08-09 15:21:01.000356
2c667634-9103-4929-9162-53b4faaad81a	SE095A	3	I	t	APL69	f	2022-08-09 15:21:01.006587	2022-08-09 15:21:01.006587
ccc1cc0e-cb1b-417f-a4ac-886e92a064e1	SE095A	3	W	t	APL69	f	2022-08-09 15:21:01.012197	2022-08-09 15:21:01.012197
2dc64fef-d7d9-482f-b629-a58868614ad7	SE095A	3	Z	t	APL69	f	2022-08-09 15:21:01.017967	2022-08-09 15:21:01.017967
871ee89b-c3a1-4bb4-bac8-2ce9f6357c48	SE095A	3	A	f	APL69	f	2022-08-09 15:21:01.023464	2022-08-09 15:21:01.023464
58a973ef-64d0-4538-9de5-fd121a71da5f	SE095A	3	D	f	APL69	f	2022-08-09 15:21:01.02926	2022-08-09 15:21:01.02926
502c592b-d934-4c57-a5f5-adc9e43074dd	SE095A	3	I	f	APL69	f	2022-08-09 15:21:01.034736	2022-08-09 15:21:01.034736
01e51143-47f5-421b-a3eb-f290ceef52df	SE095A	3	W	f	APL69	f	2022-08-09 15:21:01.040149	2022-08-09 15:21:01.040149
fc488867-d01e-44e8-89d5-ffc04c767298	SE095A	3	Z	f	APL69	f	2022-08-09 15:21:01.045848	2022-08-09 15:21:01.045848
5e9f9968-a5ff-4815-ad81-1861a836bab1	SE095A	3	A	t	APL70	f	2022-08-09 15:21:01.051955	2022-08-09 15:21:01.051955
11042716-6f8b-4385-a886-b2dd84481518	SE095A	3	D	t	APL70	f	2022-08-09 15:21:01.05787	2022-08-09 15:21:01.05787
c62cdf1d-41e3-499d-8e8a-f9907bae5d0b	SE095A	3	I	t	APL70	f	2022-08-09 15:21:01.063496	2022-08-09 15:21:01.063496
c0b248a0-908f-49ba-909a-10e5017f12ba	SE095A	3	W	t	APL70	f	2022-08-09 15:21:01.069209	2022-08-09 15:21:01.069209
8fd8ca54-6139-4c7f-a6af-8f24c901c9b2	SE095A	3	Z	t	APL70	f	2022-08-09 15:21:01.074852	2022-08-09 15:21:01.074852
555f5e0f-d339-4a11-b092-a5bda35f1b48	SE095A	3	A	f	APL70	f	2022-08-09 15:21:01.08205	2022-08-09 15:21:01.08205
5b58e265-bd38-4707-bb65-e387f05ce2d5	SE095A	3	D	f	APL70	f	2022-08-09 15:21:01.088316	2022-08-09 15:21:01.088316
35a03897-e818-42bf-a0a3-70bcb16f524f	SE095A	3	I	f	APL70	f	2022-08-09 15:21:01.093822	2022-08-09 15:21:01.093822
395cc64d-5011-4a44-bee3-0a54c4687f30	SE095A	3	W	f	APL70	f	2022-08-09 15:21:01.100076	2022-08-09 15:21:01.100076
4228d27f-b3a4-4881-8120-68c082e3f3bc	SE095A	3	Z	f	APL70	f	2022-08-09 15:21:01.106166	2022-08-09 15:21:01.106166
76947144-5bcb-4185-b07e-40a2dfc85a55	SE095A	3	A	t	CV027	f	2022-08-09 15:21:01.111842	2022-08-09 15:21:01.111842
029f158a-66e9-481b-a325-f8348c8e07d4	SE095A	3	D	t	CV027	f	2022-08-09 15:21:01.118721	2022-08-09 15:21:01.118721
91665c7f-b221-4d8f-bd30-3bec490c2604	SE095A	3	I	t	CV027	f	2022-08-09 15:21:01.124375	2022-08-09 15:21:01.124375
e8218e21-1fc4-4780-afa9-05bf1e252036	SE095A	3	W	t	CV027	f	2022-08-09 15:21:01.129667	2022-08-09 15:21:01.129667
7b98eb67-fef3-4596-88c6-7341641320c4	SE095A	3	Z	t	CV027	f	2022-08-09 15:21:01.135349	2022-08-09 15:21:01.135349
34b05759-6a44-45e6-8b03-0a350a1f4a24	SE095A	3	A	f	CV027	f	2022-08-09 15:21:01.140847	2022-08-09 15:21:01.140847
33383f09-3bc3-414f-8b5e-0a747b61b2e8	SE095A	3	D	f	CV027	f	2022-08-09 15:21:01.146133	2022-08-09 15:21:01.146133
de7cde46-e537-4a7b-bcfb-eb694ab5cdb1	SE095A	3	I	f	CV027	f	2022-08-09 15:21:01.151862	2022-08-09 15:21:01.151862
3cbc30c4-7bef-4ba4-9923-e8e358ffefc1	SE095A	3	W	f	CV027	f	2022-08-09 15:21:01.157303	2022-08-09 15:21:01.157303
9a5541ba-8ab8-4656-bf39-11bdaba29661	SE095A	3	Z	f	CV027	f	2022-08-09 15:21:01.162666	2022-08-09 15:21:01.162666
cb279882-5565-4eab-a008-ed4648d5d95f	SE095A	3	A	t	CV079	f	2022-08-09 15:21:01.168216	2022-08-09 15:21:01.168216
440be4d2-a913-4e71-9d98-d85644d251b2	SE095A	3	D	t	CV079	f	2022-08-09 15:21:01.173883	2022-08-09 15:21:01.173883
3f9757c6-3ffb-4bc7-9127-9e48bd67fcfb	SE095A	3	I	t	CV079	f	2022-08-09 15:21:01.17985	2022-08-09 15:21:01.17985
60d66f1f-ab12-40da-8f7c-51c7258cfd2f	SE095A	3	W	t	CV079	f	2022-08-09 15:21:01.186197	2022-08-09 15:21:01.186197
2f86c00d-cbda-40fc-b5ae-1823bed5e62f	SE095A	3	Z	t	CV079	f	2022-08-09 15:21:01.191904	2022-08-09 15:21:01.191904
1d57faa6-da00-4298-ab22-b2a66b770c12	SE095A	3	A	f	CV118	f	2022-08-09 15:21:01.254617	2022-08-09 15:21:01.254617
dd0ea5f2-abc3-4996-82eb-2655114fdb43	SE095A	3	D	f	CV118	f	2022-08-09 15:21:01.260719	2022-08-09 15:21:01.260719
e89c7b39-8f94-432c-8b2a-d606af63b24b	SE095A	3	I	f	CV118	f	2022-08-09 15:21:01.266164	2022-08-09 15:21:01.266164
08300831-1ddc-479a-b34c-abc644aa6b04	SE095A	3	W	f	CV118	f	2022-08-09 15:21:01.271898	2022-08-09 15:21:01.271898
c82575a0-467f-4412-ad10-563770ec0e34	SE095A	3	Z	f	CV118	f	2022-08-09 15:21:01.277838	2022-08-09 15:21:01.277838
4a833e25-c200-4a7d-b6bf-199762ca9937	SE095A	3	A	f	CV079	t	2022-08-09 15:21:01.197521	2022-08-09 15:21:01.286396
05367193-3081-4e45-b24b-4fd236427082	SE095A	3	D	f	CV079	t	2022-08-09 15:21:01.203278	2022-08-09 15:21:01.294379
453445d9-976e-41db-98f8-820f8f558701	SE095A	3	I	f	CV079	t	2022-08-09 15:21:01.208772	2022-08-09 15:21:01.301726
aac3b691-31c1-42d3-82db-dcb9a34c7486	SE095A	3	W	f	CV079	t	2022-08-09 15:21:01.214354	2022-08-09 15:21:01.30915
f2e0a797-0010-4e59-9b3f-aeae7474f37a	SE095A	3	Z	f	CV079	t	2022-08-09 15:21:01.219877	2022-08-09 15:21:01.316583
e201ed48-1486-4f2f-a8c9-5f83d7da7b29	SE095A	3	A	t	CV118	t	2022-08-09 15:21:01.225576	2022-08-09 15:21:01.32432
4bae36c9-6c06-4f17-b5b0-9ecd2dbc931f	SE095A	3	D	t	CV118	t	2022-08-09 15:21:01.230952	2022-08-09 15:21:01.331719
576ea389-6b6f-4c85-9f02-6c510e28f7ee	SE095A	3	I	t	CV118	t	2022-08-09 15:21:01.236901	2022-08-09 15:21:01.339151
ea9de371-e0d1-440b-afab-4bc7f9a8b414	SE095A	3	W	t	CV118	t	2022-08-09 15:21:01.242322	2022-08-09 15:21:01.346432
8acd9434-c6b8-4e98-b220-aabb814bd32b	SE095A	3	Z	t	CV118	t	2022-08-09 15:21:01.247765	2022-08-09 15:21:01.355164
5b382dbe-47dd-4dee-b977-ece2f0a2b054	SE097A	3	A	t	APL09	f	2022-08-09 15:21:01.361641	2022-08-09 15:21:01.361641
22a6dae0-5279-4549-be5e-a7740914eb2b	SE097A	3	D	t	APL09	f	2022-08-09 15:21:01.367954	2022-08-09 15:21:01.367954
81b22a26-10e2-4d52-b711-eb9f8551dbff	SE097A	3	I	t	APL09	f	2022-08-09 15:21:01.374101	2022-08-09 15:21:01.374101
6170ba44-b7db-42ef-b459-6bf651fea1c5	SE097A	3	W	t	APL09	f	2022-08-09 15:21:01.380191	2022-08-09 15:21:01.380191
5c01ded0-46a6-4be2-a792-8c6195cc4f63	SE097A	3	Z	t	APL09	f	2022-08-09 15:21:01.386452	2022-08-09 15:21:01.386452
5a2e53f4-92dc-4a40-9c9e-dd261decfc30	SE097A	3	A	f	APL09	f	2022-08-09 15:21:01.392558	2022-08-09 15:21:01.392558
acc42577-4ded-4e9a-9cd9-3a528641b5f4	SE097A	3	D	f	APL09	f	2022-08-09 15:21:01.398434	2022-08-09 15:21:01.398434
8b103ba0-b8f0-465f-8513-eb809ec8ad82	SE097A	3	I	f	APL09	f	2022-08-09 15:21:01.403885	2022-08-09 15:21:01.403885
c09e9590-8ef4-4875-b2c1-15524b243e53	SE097A	3	W	f	APL09	f	2022-08-09 15:21:01.409419	2022-08-09 15:21:01.409419
3fb5038b-1891-4f4e-be2e-d83f2eedccdf	SE097A	3	Z	f	APL09	f	2022-08-09 15:21:01.415044	2022-08-09 15:21:01.415044
b3a213fc-31df-452d-a4a1-b735450afbc1	SE097A	3	A	t	APL07	f	2022-08-09 15:21:01.421416	2022-08-09 15:21:01.421416
f69f3d84-2d10-4b05-930f-00a78b70eb7b	SE097A	3	D	t	APL07	f	2022-08-09 15:21:01.42709	2022-08-09 15:21:01.42709
0523a1ea-eec2-46c8-8cf6-a7224f36dfc8	SE097A	3	I	t	APL07	f	2022-08-09 15:21:01.432982	2022-08-09 15:21:01.432982
9ae6b17c-4164-4dab-941c-9b287e2d580e	SE097A	3	W	t	APL07	f	2022-08-09 15:21:01.438826	2022-08-09 15:21:01.438826
018934ec-9a63-43db-9fbf-e7ca5b97a730	SE097A	3	Z	t	APL07	f	2022-08-09 15:21:01.444732	2022-08-09 15:21:01.444732
51ea1f7a-09b7-42ec-9325-9be518e1a5f3	SE097A	3	A	f	APL07	f	2022-08-09 15:21:01.450541	2022-08-09 15:21:01.450541
e9626931-e5ca-4413-aa9a-90f492ce0622	SE097A	3	D	f	APL07	f	2022-08-09 15:21:01.456245	2022-08-09 15:21:01.456245
7b1b9761-6660-456b-a784-01c2d5727e34	SE097A	3	I	f	APL07	f	2022-08-09 15:21:01.462101	2022-08-09 15:21:01.462101
f2dccc4d-32ae-4170-be4c-55f652c1e139	SE097A	3	W	f	APL07	f	2022-08-09 15:21:01.468363	2022-08-09 15:21:01.468363
22753567-7271-4603-81d1-679c7dc52f9c	SE097A	3	Z	f	APL07	f	2022-08-09 15:21:01.474048	2022-08-09 15:21:01.474048
7cd5824c-4b78-43b1-b38f-2a1e6f7c640f	SE097A	3	A	t	APL11	f	2022-08-09 15:21:01.479608	2022-08-09 15:21:01.479608
031829d6-1b0c-4aa7-b33a-b1e33bea5de0	SE097A	3	D	t	APL11	f	2022-08-09 15:21:01.485574	2022-08-09 15:21:01.485574
e776157e-04e6-4259-96c9-4654368f2c93	SE097A	3	I	t	APL11	f	2022-08-09 15:21:01.491377	2022-08-09 15:21:01.491377
6638d00f-e459-42ca-a715-b6d6ab7c24df	SE097A	3	W	t	APL11	f	2022-08-09 15:21:01.496995	2022-08-09 15:21:01.496995
c98bf451-a392-4402-9131-eb1e44191a37	SE097A	3	Z	t	APL11	f	2022-08-09 15:21:01.502831	2022-08-09 15:21:01.502831
8bee9a55-ee1b-4826-9072-dcd5d820d235	SE097A	3	A	f	APL11	f	2022-08-09 15:21:01.50822	2022-08-09 15:21:01.50822
1517c4bd-97e4-4c3c-89c7-3185cad4285e	SE097A	3	D	f	APL11	f	2022-08-09 15:21:01.513541	2022-08-09 15:21:01.513541
01811676-65ee-4b78-a78a-790a33aaa092	SE097A	3	I	f	APL11	f	2022-08-09 15:21:01.519293	2022-08-09 15:21:01.519293
33521ad6-fac8-4e34-b0e5-6dfda0bd4ddf	SE097A	3	W	f	APL11	f	2022-08-09 15:21:01.525022	2022-08-09 15:21:01.525022
5c1e36ee-3b2e-4148-80e9-c661cf6b96aa	SE097A	3	Z	f	APL11	f	2022-08-09 15:21:01.531043	2022-08-09 15:21:01.531043
ba8ad6f3-21e1-4b57-98c6-2f3a59b56710	SE097A	3	A	t	APL13	f	2022-08-09 15:21:01.536763	2022-08-09 15:21:01.536763
2ce6fd41-a633-4738-8739-4457e621f5a3	SE097A	3	D	t	APL13	f	2022-08-09 15:21:01.542201	2022-08-09 15:21:01.542201
4bfabd91-3703-4fcd-8c1a-1d4a47ecd8e7	SE097A	3	I	t	APL13	f	2022-08-09 15:21:01.54784	2022-08-09 15:21:01.54784
a97ff00c-b462-4a4e-9e38-5eb9ae79a832	SE097A	3	W	t	APL13	f	2022-08-09 15:21:01.553315	2022-08-09 15:21:01.553315
77a51045-36bf-479c-b205-fc221519d6ba	SE097A	3	Z	t	APL13	f	2022-08-09 15:21:01.558896	2022-08-09 15:21:01.558896
c5d0c6b6-5b95-4723-a0dd-6de0bb311044	SE097A	3	A	f	APL13	f	2022-08-09 15:21:01.564153	2022-08-09 15:21:01.564153
b8956ee8-341c-4a4b-afab-89dd2b61708c	SE097A	3	D	f	APL13	f	2022-08-09 15:21:01.569689	2022-08-09 15:21:01.569689
d1795dc6-aef0-4dc3-891a-ff1a10464988	SE097A	3	I	f	APL13	f	2022-08-09 15:21:01.574941	2022-08-09 15:21:01.574941
da903f46-d3bf-4032-bc60-b4a7760eb57a	SE097A	3	W	f	APL13	f	2022-08-09 15:21:01.580766	2022-08-09 15:21:01.580766
7e3b9d0b-34cb-463a-b813-93d9db8754de	SE097A	3	Z	f	APL13	f	2022-08-09 15:21:01.586291	2022-08-09 15:21:01.586291
bc737c1b-f8bf-4153-8361-0e8c9e8e639c	SE097A	3	A	t	APL15	f	2022-08-09 15:21:01.593214	2022-08-09 15:21:01.593214
ff3cb27a-b657-4dff-a9f3-c62675590b88	SE097A	3	D	t	APL15	f	2022-08-09 15:21:01.599254	2022-08-09 15:21:01.599254
1e42f891-8006-4096-8d15-0bd268593ae6	SE097A	3	I	t	APL15	f	2022-08-09 15:21:01.605267	2022-08-09 15:21:01.605267
e6d7aab4-09ce-4a5a-98e7-bd2f48ed487c	SE097A	3	W	t	APL15	f	2022-08-09 15:21:01.610668	2022-08-09 15:21:01.610668
446901df-9f98-40f9-a791-608d30b63719	SE097A	3	Z	t	APL15	f	2022-08-09 15:21:01.616522	2022-08-09 15:21:01.616522
2e14070f-9d66-4468-84eb-7776cf44d382	SE097A	3	A	f	APL15	f	2022-08-09 15:21:01.621926	2022-08-09 15:21:01.621926
43153ac6-a7f2-4c54-a453-16440845e38a	SE097A	3	D	f	APL15	f	2022-08-09 15:21:01.627786	2022-08-09 15:21:01.627786
9ef2acf1-15ca-42ac-9a98-f7bdd28c5afa	SE097A	3	I	f	APL15	f	2022-08-09 15:21:01.633175	2022-08-09 15:21:01.633175
05185436-7d5c-456b-993d-c17efe26bdf6	SE097A	3	W	f	APL15	f	2022-08-09 15:21:01.638878	2022-08-09 15:21:01.638878
1e59961c-66d4-46f9-8b6a-18fcdb308269	SE097A	3	Z	f	APL15	f	2022-08-09 15:21:01.644334	2022-08-09 15:21:01.644334
5bc3be5b-1102-4c61-b9ff-ec72e0d1df16	SE097A	3	A	t	APL16	f	2022-08-09 15:21:01.650185	2022-08-09 15:21:01.650185
62b3837f-a3d5-4658-9712-7d3ad933b304	SE097A	3	D	t	APL16	f	2022-08-09 15:21:01.655843	2022-08-09 15:21:01.655843
39be686a-dd4d-4269-8830-566dd284d1f8	SE097A	3	I	t	APL16	f	2022-08-09 15:21:01.661431	2022-08-09 15:21:01.661431
702eb44d-3a9f-4ea5-a4b0-1a7e5f2f42d8	SE097A	3	W	t	APL16	f	2022-08-09 15:21:01.666754	2022-08-09 15:21:01.666754
f6334736-f6ce-49ab-91d1-3e6855b00765	SE097A	3	Z	t	APL16	f	2022-08-09 15:21:01.672524	2022-08-09 15:21:01.672524
a8f289ac-b739-4c1e-9978-379502288e2a	SE097A	3	A	f	APL16	f	2022-08-09 15:21:01.678877	2022-08-09 15:21:01.678877
c8df76e7-92b6-49fe-aeea-e9a014302702	SE097A	3	D	f	APL16	f	2022-08-09 15:21:01.685007	2022-08-09 15:21:01.685007
a6c9a9e0-cdd6-48c0-8c1b-83bea76e2368	SE097A	3	I	f	APL16	f	2022-08-09 15:21:01.690378	2022-08-09 15:21:01.690378
671ce3c6-5759-4994-913d-a27fc9b822c7	SE097A	3	W	f	APL16	f	2022-08-09 15:21:01.695726	2022-08-09 15:21:01.695726
f98be0e2-a8fa-49ba-bc52-8ff4ce05a058	SE097A	3	Z	f	APL16	f	2022-08-09 15:21:01.701443	2022-08-09 15:21:01.701443
33dd7a48-96f6-450c-95cb-c1f4dca3cab7	SE097A	3	A	t	APL18	f	2022-08-09 15:21:01.706761	2022-08-09 15:21:01.706761
fbc90bfd-931e-4e1e-8bc1-db0dedd45831	SE097A	3	D	t	APL18	f	2022-08-09 15:21:01.711982	2022-08-09 15:21:01.711982
89e12180-baab-41f4-9472-c0ebfd99bcda	SE097A	3	I	t	APL18	f	2022-08-09 15:21:01.718367	2022-08-09 15:21:01.718367
c723e315-6c29-4f25-92e0-b0ec8bacfe14	SE097A	3	W	t	APL18	f	2022-08-09 15:21:01.724069	2022-08-09 15:21:01.724069
1048e8bc-cc30-4df3-ba13-0b06917227c3	SE097A	3	Z	t	APL18	f	2022-08-09 15:21:01.729664	2022-08-09 15:21:01.729664
63b9b093-9ce0-45f7-b196-a7d56eb88ad3	SE097A	3	A	f	APL18	f	2022-08-09 15:21:01.734937	2022-08-09 15:21:01.734937
ea5b2957-c420-4469-9b11-8bd75c0ce810	SE097A	3	D	f	APL18	f	2022-08-09 15:21:01.740477	2022-08-09 15:21:01.740477
bdfe7796-5888-4ed0-85eb-f4f5019e7c05	SE097A	3	I	f	APL18	f	2022-08-09 15:21:01.745766	2022-08-09 15:21:01.745766
3304ea03-b8e4-4c3f-a563-0020ddea562b	SE097A	3	W	f	APL18	f	2022-08-09 15:21:01.750985	2022-08-09 15:21:01.750985
8e12ed8a-3e12-45cf-851f-f01707e9ad33	SE097A	3	Z	f	APL18	f	2022-08-09 15:21:01.75656	2022-08-09 15:21:01.75656
75d626be-44b5-421f-8101-bf2943089d3e	SE097A	3	A	t	APL20	f	2022-08-09 15:21:01.761695	2022-08-09 15:21:01.761695
95666b7a-8b6e-45d6-a7fa-a0ebbee7f69c	SE097A	3	D	t	APL20	f	2022-08-09 15:21:01.767017	2022-08-09 15:21:01.767017
966ef275-76c1-4ac0-8558-0e23274a95d5	SE097A	3	I	t	APL20	f	2022-08-09 15:21:01.772515	2022-08-09 15:21:01.772515
86aacff6-0394-41ce-8006-01e3381a1e2f	SE097A	3	W	t	APL20	f	2022-08-09 15:21:01.778211	2022-08-09 15:21:01.778211
ffcca2b6-f490-45fb-8af3-2e60873880ca	SE097A	3	Z	t	APL20	f	2022-08-09 15:21:01.783925	2022-08-09 15:21:01.783925
66c8d8ee-59b8-42da-9e27-bb7674232710	SE097A	3	A	f	APL20	f	2022-08-09 15:21:01.789319	2022-08-09 15:21:01.789319
40b0dd71-7284-4ca4-95a4-d2f73ed51ffe	SE097A	3	D	f	APL20	f	2022-08-09 15:21:01.794629	2022-08-09 15:21:01.794629
4d014622-903a-418c-a3b2-267ff2adc620	SE097A	3	I	f	APL20	f	2022-08-09 15:21:01.800248	2022-08-09 15:21:01.800248
ac62fe82-3bc7-49dc-b5ee-987e04ac124f	SE097A	3	W	f	APL20	f	2022-08-09 15:21:01.805673	2022-08-09 15:21:01.805673
73d2ae4e-bc92-4f33-aa66-d71379276066	SE097A	3	Z	f	APL20	f	2022-08-09 15:21:01.81115	2022-08-09 15:21:01.81115
87a249fe-ac0d-41ae-a528-92b181e22e1a	SE097A	3	A	t	APL22	f	2022-08-09 15:21:01.816751	2022-08-09 15:21:01.816751
878db10d-7c44-4b11-85af-bf3aac777457	SE097A	3	D	t	APL22	f	2022-08-09 15:21:01.822192	2022-08-09 15:21:01.822192
425f40af-89b9-4366-95f6-c254b442c902	SE097A	3	I	t	APL22	f	2022-08-09 15:21:01.827457	2022-08-09 15:21:01.827457
f534b133-82de-4a8b-b3d4-2243f2f889af	SE097A	3	W	t	APL22	f	2022-08-09 15:21:01.833026	2022-08-09 15:21:01.833026
dd52f3e7-3649-4d22-80ee-ac0d92f3c6cd	SE097A	3	Z	t	APL22	f	2022-08-09 15:21:01.838258	2022-08-09 15:21:01.838258
0025539c-4a49-4e18-9da6-37063f9f7cf0	SE097A	3	A	f	APL22	f	2022-08-09 15:21:01.843897	2022-08-09 15:21:01.843897
fb6332ef-76c7-4316-94e4-2abbd35dcfa7	SE097A	3	D	f	APL22	f	2022-08-09 15:21:01.849244	2022-08-09 15:21:01.849244
7d23ef7c-fa93-4955-9af9-add519ca2372	SE097A	3	I	f	APL22	f	2022-08-09 15:21:01.854885	2022-08-09 15:21:01.854885
51d56c03-5827-422d-8a9c-832bd9c69ef7	SE097A	3	W	f	APL22	f	2022-08-09 15:21:01.860471	2022-08-09 15:21:01.860471
9ade5560-95d3-4601-a12e-84f6927c5a5b	SE097A	3	Z	f	APL22	f	2022-08-09 15:21:01.865795	2022-08-09 15:21:01.865795
d796be84-4434-48d2-96d7-9fe4fd0ae1ee	SE097A	3	A	t	APL27	f	2022-08-09 15:21:01.871371	2022-08-09 15:21:01.871371
38bce76f-08ae-4cff-8963-48b6492b7039	SE097A	3	D	t	APL27	f	2022-08-09 15:21:01.876563	2022-08-09 15:21:01.876563
bc88415f-50a8-4bd8-864a-15fdfee7e44d	SE097A	3	I	t	APL27	f	2022-08-09 15:21:01.881981	2022-08-09 15:21:01.881981
faa89958-979f-41f3-925e-96142aa70302	SE097A	3	W	t	APL27	f	2022-08-09 15:21:01.88725	2022-08-09 15:21:01.88725
49bf7bfd-e850-4ecc-ba98-a154e36d845b	SE097A	3	Z	t	APL27	f	2022-08-09 15:21:01.892656	2022-08-09 15:21:01.892656
33aec920-ff33-4f82-8391-0dd11a12aef2	SE097A	3	A	f	APL27	f	2022-08-09 15:21:01.898446	2022-08-09 15:21:01.898446
a68d69d6-6c5c-41dc-94d1-bfbdc023ce1c	SE097A	3	D	f	APL27	f	2022-08-09 15:21:01.90374	2022-08-09 15:21:01.90374
8cbbce04-857e-4fa3-8462-1386bf7a612e	SE097A	3	I	f	APL27	f	2022-08-09 15:21:01.910714	2022-08-09 15:21:01.910714
7ec887d3-be5a-4b4d-ae0d-93940874014c	SE097A	3	W	f	APL27	f	2022-08-09 15:21:01.91633	2022-08-09 15:21:01.91633
112f2a02-db82-4d8f-b1b8-acdf7ef6b15f	SE097A	3	Z	f	APL27	f	2022-08-09 15:21:01.922281	2022-08-09 15:21:01.922281
3e08a21d-7cd0-4afd-b0ba-ab04d04b3b39	SE097A	3	A	t	APL29	f	2022-08-09 15:21:01.927644	2022-08-09 15:21:01.927644
57fdda78-61c9-4883-bfe8-0c416138e717	SE097A	3	D	t	APL29	f	2022-08-09 15:21:01.933355	2022-08-09 15:21:01.933355
017a7bbe-2313-4a20-b5b7-f69c9c20f197	SE097A	3	I	t	APL29	f	2022-08-09 15:21:01.938988	2022-08-09 15:21:01.938988
33dfb2bd-b532-4ce5-85fa-a586d5eef12e	SE097A	3	W	t	APL29	f	2022-08-09 15:21:01.94438	2022-08-09 15:21:01.94438
4ff5e0af-1a33-47a3-b3d1-f67e0d2b174f	SE097A	3	Z	t	APL29	f	2022-08-09 15:21:01.949998	2022-08-09 15:21:01.949998
85cc7a2a-1d1f-4891-bf0d-59e716776b3b	SE097A	3	A	f	APL29	f	2022-08-09 15:21:01.955321	2022-08-09 15:21:01.955321
f0baed87-f122-4a09-872d-3512f88c1bb0	SE097A	3	D	f	APL29	f	2022-08-09 15:21:01.961011	2022-08-09 15:21:01.961011
17e45fac-eac6-4fbb-b013-b56bc6c7100d	SE097A	3	I	f	APL29	f	2022-08-09 15:21:01.96636	2022-08-09 15:21:01.96636
4b418d70-4973-4d0a-8f3f-bbd92fb0cb4f	SE097A	3	W	f	APL29	f	2022-08-09 15:21:01.972253	2022-08-09 15:21:01.972253
888e7798-b731-4951-9dda-7e4c508a611a	SE097A	3	Z	f	APL29	f	2022-08-09 15:21:01.977731	2022-08-09 15:21:01.977731
7f07d2c4-7839-4610-b986-e48f651d406a	SE097A	3	A	t	APL31	f	2022-08-09 15:21:01.983348	2022-08-09 15:21:01.983348
e0c004f2-d84c-4c86-a603-a447b4f76c4f	SE097A	3	D	t	APL31	f	2022-08-09 15:21:01.989114	2022-08-09 15:21:01.989114
cc96c910-f49b-40b3-973b-a5f72c2d8933	SE097A	3	I	t	APL31	f	2022-08-09 15:21:01.994724	2022-08-09 15:21:01.994724
e03fb725-6448-4368-b08e-c0452676dc78	SE097A	3	W	t	APL31	f	2022-08-09 15:21:01.999993	2022-08-09 15:21:01.999993
d9a5f73b-2b5f-4eaf-9fa2-b2fd954377fa	SE097A	3	Z	t	APL31	f	2022-08-09 15:21:02.00547	2022-08-09 15:21:02.00547
b69c8ec5-dff6-448f-8ff5-8940e1cc73a8	SE097A	3	A	f	APL31	f	2022-08-09 15:21:02.011902	2022-08-09 15:21:02.011902
171f9531-7dc4-4f5b-849e-1a6e931c5ab3	SE097A	3	D	f	APL31	f	2022-08-09 15:21:02.018035	2022-08-09 15:21:02.018035
c6658ef3-0aaa-4037-b38a-7f5dbd03b711	SE097A	3	I	f	APL31	f	2022-08-09 15:21:02.02367	2022-08-09 15:21:02.02367
9ad75452-8f00-4095-bf1f-96ec51189f58	SE097A	3	W	f	APL31	f	2022-08-09 15:21:02.029043	2022-08-09 15:21:02.029043
1b061a14-1461-432d-b7ab-713b2cd68c7c	SE097A	3	Z	f	APL31	f	2022-08-09 15:21:02.034432	2022-08-09 15:21:02.034432
f395a463-9aea-45b3-a227-192d4bb90311	SE097A	3	A	t	APL48	f	2022-08-09 15:21:02.039861	2022-08-09 15:21:02.039861
72b9d31a-4cf4-4aaf-905f-9fbf633346ba	SE097A	3	D	t	APL48	f	2022-08-09 15:21:02.04526	2022-08-09 15:21:02.04526
8e82d53c-f57b-4b64-ad86-05da51e1262c	SE097A	3	I	t	APL48	f	2022-08-09 15:21:02.050791	2022-08-09 15:21:02.050791
2f64ae8f-1f41-40e4-8506-f5bf96bce24b	SE097A	3	W	t	APL48	f	2022-08-09 15:21:02.056059	2022-08-09 15:21:02.056059
6a6f9930-1660-4780-9690-bc7d7242b6a8	SE097A	3	Z	t	APL48	f	2022-08-09 15:21:02.061441	2022-08-09 15:21:02.061441
dabd80d4-7849-431f-978e-95cf3ca45f11	SE097A	3	A	f	APL48	f	2022-08-09 15:21:02.067288	2022-08-09 15:21:02.067288
f70ad373-0d05-4872-9e60-445dbc5fd057	SE097A	3	D	f	APL48	f	2022-08-09 15:21:02.07257	2022-08-09 15:21:02.07257
7d8484d6-9079-439c-a04a-3a583a2fbc69	SE097A	3	I	f	APL48	f	2022-08-09 15:21:02.078158	2022-08-09 15:21:02.078158
3165c957-ea98-483a-89cc-b7cf324d501d	SE097A	3	W	f	APL48	f	2022-08-09 15:21:02.085912	2022-08-09 15:21:02.085912
287a1dd6-6b51-47c4-8c81-9178df42dc3c	SE097A	3	Z	f	APL48	f	2022-08-09 15:21:02.091348	2022-08-09 15:21:02.091348
86d61f65-2e4e-4880-acef-f393fe301e16	SE097A	3	A	t	APL49	f	2022-08-09 15:21:02.097148	2022-08-09 15:21:02.097148
8fb890b2-964c-464c-b990-d28eed175876	SE097A	3	D	t	APL49	f	2022-08-09 15:21:02.103024	2022-08-09 15:21:02.103024
99482c93-c10f-4c19-a625-920c6265d2d2	SE097A	3	I	t	APL49	f	2022-08-09 15:21:02.108442	2022-08-09 15:21:02.108442
84a24e80-1f6e-4ae4-b027-3365736f9396	SE097A	3	W	t	APL49	f	2022-08-09 15:21:02.114296	2022-08-09 15:21:02.114296
8fd348a8-f02f-49ab-a9be-995cee31ffbd	SE097A	3	Z	t	APL49	f	2022-08-09 15:21:02.119978	2022-08-09 15:21:02.119978
73ca709b-f5da-4c89-86d6-ef74d4b557d5	SE097A	3	A	f	APL49	f	2022-08-09 15:21:02.125755	2022-08-09 15:21:02.125755
bad79cfc-0008-4959-a4a6-df9fefb00b66	SE097A	3	D	f	APL49	f	2022-08-09 15:21:02.131203	2022-08-09 15:21:02.131203
8039bc5e-69b7-4002-a793-bec1c940e5ce	SE097A	3	I	f	APL49	f	2022-08-09 15:21:02.136546	2022-08-09 15:21:02.136546
2cb9e04f-d819-4824-9897-44eca330d4fd	SE097A	3	W	f	APL49	f	2022-08-09 15:21:02.142212	2022-08-09 15:21:02.142212
e01471a3-b367-42e3-9665-3a714d1636b0	SE097A	3	Z	f	APL49	f	2022-08-09 15:21:02.147632	2022-08-09 15:21:02.147632
2ed706b2-79c9-4f44-843d-fa26e828293b	SE097A	3	A	t	APL50	f	2022-08-09 15:21:02.152989	2022-08-09 15:21:02.152989
25bf22b9-b6d9-4cb4-9508-e7732c13357a	SE097A	3	D	t	APL50	f	2022-08-09 15:21:02.158578	2022-08-09 15:21:02.158578
0731ca78-7c01-4f7a-920b-259169d5d501	SE097A	3	I	t	APL50	f	2022-08-09 15:21:02.163982	2022-08-09 15:21:02.163982
0583447b-3779-490a-b281-992b56c783c8	SE097A	3	W	t	APL50	f	2022-08-09 15:21:02.169722	2022-08-09 15:21:02.169722
4fad49f7-8021-443f-8764-1be6d94efba0	SE097A	3	Z	t	APL50	f	2022-08-09 15:21:02.175655	2022-08-09 15:21:02.175655
89e8beba-feb4-48d5-90c9-594bb41dbb7c	SE097A	3	A	f	APL50	f	2022-08-09 15:21:02.181467	2022-08-09 15:21:02.181467
e6c3b0e3-7890-40de-befa-361ad212cdd1	SE097A	3	D	f	APL50	f	2022-08-09 15:21:02.187187	2022-08-09 15:21:02.187187
46b0bef3-76ae-4131-864b-7f3fe131e361	SE097A	3	I	f	APL50	f	2022-08-09 15:21:02.192777	2022-08-09 15:21:02.192777
038ed52d-b690-46b9-979c-eb40fd97a5b6	SE097A	3	W	f	APL50	f	2022-08-09 15:21:02.198715	2022-08-09 15:21:02.198715
3b1d2646-3248-48d6-a4c2-b9bcf772a59a	SE097A	3	Z	f	APL50	f	2022-08-09 15:21:02.204097	2022-08-09 15:21:02.204097
66e27e32-21a7-413b-a04b-b31d2eff1961	SE097A	3	A	t	APL51	f	2022-08-09 15:21:02.210096	2022-08-09 15:21:02.210096
e611e0e9-ee16-412d-b0a4-68d124469d03	SE097A	3	D	t	APL51	f	2022-08-09 15:21:02.215604	2022-08-09 15:21:02.215604
ad2721bf-ac1a-4c3a-afb0-856aba0c7979	SE097A	3	I	t	APL51	f	2022-08-09 15:21:02.221138	2022-08-09 15:21:02.221138
925d2561-dd66-4dec-a09b-e7dec88e72b0	SE097A	3	W	t	APL51	f	2022-08-09 15:21:02.226935	2022-08-09 15:21:02.226935
1b6e3c3e-a719-47fc-87a7-319b65cb1790	SE097A	3	Z	t	APL51	f	2022-08-09 15:21:02.232196	2022-08-09 15:21:02.232196
e742749d-65a7-4f68-bcb6-3e0158bb0bb0	SE097A	3	A	f	APL51	f	2022-08-09 15:21:02.239546	2022-08-09 15:21:02.239546
bd67f44b-9773-4a6a-910d-2732b64ede3c	SE097A	3	D	f	APL51	f	2022-08-09 15:21:02.246263	2022-08-09 15:21:02.246263
2b3ea4bf-d934-42a8-85c8-db80983804f4	SE097A	3	I	f	APL51	f	2022-08-09 15:21:02.252963	2022-08-09 15:21:02.252963
99debd61-401e-4ca7-abfd-760e1fb5f5be	SE097A	3	W	f	APL51	f	2022-08-09 15:21:02.258517	2022-08-09 15:21:02.258517
496e9e5e-1a56-48f4-a0b7-c9dfe6c6597f	SE097A	3	Z	f	APL51	f	2022-08-09 15:21:02.26432	2022-08-09 15:21:02.26432
5e4df8b5-96b3-40fb-8bdf-3bb5b5dc7deb	SE097A	3	A	t	APL52	f	2022-08-09 15:21:02.269988	2022-08-09 15:21:02.269988
cba3d2b5-8149-4f9e-bd97-50e39ac1ad28	SE097A	3	D	t	APL52	f	2022-08-09 15:21:02.275321	2022-08-09 15:21:02.275321
dd321bec-0eee-482d-b19f-eda92982723d	SE097A	3	I	t	APL52	f	2022-08-09 15:21:02.281043	2022-08-09 15:21:02.281043
66a9000c-cbff-4340-a90d-988ac2abd2be	SE097A	3	W	t	APL52	f	2022-08-09 15:21:02.286538	2022-08-09 15:21:02.286538
8e6fe3df-853f-4668-8a9e-2e00c3c57c24	SE097A	3	Z	t	APL52	f	2022-08-09 15:21:02.292894	2022-08-09 15:21:02.292894
8045492d-f2e4-4aa5-9e2c-9ff98da60cea	SE097A	3	A	f	APL52	f	2022-08-09 15:21:02.29853	2022-08-09 15:21:02.29853
210ab4be-4731-4b7d-802c-c30f059d7336	SE097A	3	D	f	APL52	f	2022-08-09 15:21:02.303914	2022-08-09 15:21:02.303914
edaa2c53-09e4-4427-bc44-e508801f3cba	SE097A	3	I	f	APL52	f	2022-08-09 15:21:02.309624	2022-08-09 15:21:02.309624
6ce052ef-2854-477b-8be4-05397a653144	SE097A	3	W	f	APL52	f	2022-08-09 15:21:02.315261	2022-08-09 15:21:02.315261
e97d6dfb-7d3b-4bf0-a979-222c6fe9664a	SE097A	3	Z	f	APL52	f	2022-08-09 15:21:02.320949	2022-08-09 15:21:02.320949
0714f46a-2edf-4225-9e1e-4c3046dd3c97	SE097A	3	A	t	APL53	f	2022-08-09 15:21:02.326175	2022-08-09 15:21:02.326175
532d2dcc-2086-4627-9fbc-4f7273887a9f	SE097A	3	D	t	APL53	f	2022-08-09 15:21:02.331878	2022-08-09 15:21:02.331878
c319cde0-94af-44e1-ab4e-4fbc723bc058	SE097A	3	I	t	APL53	f	2022-08-09 15:21:02.337255	2022-08-09 15:21:02.337255
76beb8af-5140-4101-bf5e-d8cbd27e8a66	SE097A	3	W	t	APL53	f	2022-08-09 15:21:02.34328	2022-08-09 15:21:02.34328
15524628-efad-4623-a937-8f2c207ff2f8	SE097A	3	Z	t	APL53	f	2022-08-09 15:21:02.350067	2022-08-09 15:21:02.350067
4251bfca-c1e0-4d01-9992-e74b22f779d1	SE097A	3	A	f	APL53	f	2022-08-09 15:21:02.356255	2022-08-09 15:21:02.356255
cd403348-ed2c-4c06-aff2-6d90b0d75b84	SE097A	3	D	f	APL53	f	2022-08-09 15:21:02.362305	2022-08-09 15:21:02.362305
7eaadecf-150c-42bd-b6e2-8b9bbbe5dc1b	SE097A	3	I	f	APL53	f	2022-08-09 15:21:02.369144	2022-08-09 15:21:02.369144
b4f01b7d-37d0-4f04-a20d-26b4b9f22cbc	SE097A	3	W	f	APL53	f	2022-08-09 15:21:02.374711	2022-08-09 15:21:02.374711
4aed7664-b8af-4026-b6be-d8ca385c9463	SE097A	3	Z	f	APL53	f	2022-08-09 15:21:02.381169	2022-08-09 15:21:02.381169
57cb99f1-7160-49ad-b2c6-2474d83d4f37	SE097A	3	A	t	APL54	f	2022-08-09 15:21:02.387232	2022-08-09 15:21:02.387232
db0f27a5-e98f-4f92-a924-eed1b3dc2bba	SE097A	3	D	t	APL54	f	2022-08-09 15:21:02.39311	2022-08-09 15:21:02.39311
5477fc0f-2112-4454-b94b-906216d9dc45	SE097A	3	I	t	APL54	f	2022-08-09 15:21:02.398755	2022-08-09 15:21:02.398755
92bf3aeb-2ec9-4503-8295-c05335232b8f	SE097A	3	W	t	APL54	f	2022-08-09 15:21:02.404414	2022-08-09 15:21:02.404414
bb0195de-904e-47e5-ba9c-7703cfda8bec	SE097A	3	Z	t	APL54	f	2022-08-09 15:21:02.410065	2022-08-09 15:21:02.410065
49ffe212-79a2-497c-bc09-d6eb4a78892b	SE097A	3	A	f	APL54	f	2022-08-09 15:21:02.415318	2022-08-09 15:21:02.415318
56888445-8b71-461a-8632-3d89604e7503	SE097A	3	D	f	APL54	f	2022-08-09 15:21:02.420987	2022-08-09 15:21:02.420987
806178cd-ad32-405f-a610-5f947e3fdf89	SE097A	3	I	f	APL54	f	2022-08-09 15:21:02.42674	2022-08-09 15:21:02.42674
c2a93956-82bc-42ad-9556-0cde6f99f2fb	SE097A	3	W	f	APL54	f	2022-08-09 15:21:02.432246	2022-08-09 15:21:02.432246
b754a88d-9cc6-441e-8f9e-bbcb11e1fd4c	SE097A	3	Z	f	APL54	f	2022-08-09 15:21:02.437876	2022-08-09 15:21:02.437876
5a04ddbd-52f5-4298-af16-a8e9cb2b7d2f	SE097A	3	A	t	APL55	f	2022-08-09 15:21:02.44324	2022-08-09 15:21:02.44324
2ea70a93-baa1-4dff-b03b-abe88b2a2f2c	SE097A	3	D	t	APL55	f	2022-08-09 15:21:02.449149	2022-08-09 15:21:02.449149
bfc2123f-fdae-4d3c-8d60-c4281c81897a	SE097A	3	I	t	APL55	f	2022-08-09 15:21:02.454519	2022-08-09 15:21:02.454519
7afa4f3f-2058-478b-8650-d8a1e6d5a6e5	SE097A	3	W	t	APL55	f	2022-08-09 15:21:02.459834	2022-08-09 15:21:02.459834
382389a8-284d-4ed6-96ad-f92a2c595c74	SE097A	3	Z	t	APL55	f	2022-08-09 15:21:02.465518	2022-08-09 15:21:02.465518
88055acd-5ed8-413f-814a-bd01efc37bfd	SE097A	3	A	f	APL55	f	2022-08-09 15:21:02.470703	2022-08-09 15:21:02.470703
fb027fa1-ce5f-4b79-aa42-28f2f1502fa1	SE097A	3	D	f	APL55	f	2022-08-09 15:21:02.476137	2022-08-09 15:21:02.476137
b4d89309-9d38-43fd-a7d4-e725b5e6f365	SE097A	3	I	f	APL55	f	2022-08-09 15:21:02.481837	2022-08-09 15:21:02.481837
e5edd9ca-bd76-407e-9a97-80d992436bcf	SE097A	3	W	f	APL55	f	2022-08-09 15:21:02.4871	2022-08-09 15:21:02.4871
a778e8d9-ac78-44ff-9a50-83a098ac33d4	SE097A	3	Z	f	APL55	f	2022-08-09 15:21:02.492762	2022-08-09 15:21:02.492762
99ff27f6-021e-4fa1-8c4f-75e24296712f	SE097A	3	A	t	APL56	f	2022-08-09 15:21:02.498256	2022-08-09 15:21:02.498256
20521a39-fb37-4909-a5f9-409ad81d4f3d	SE097A	3	D	t	APL56	f	2022-08-09 15:21:02.503607	2022-08-09 15:21:02.503607
8401df5b-8a53-4f5f-88d2-d62330d75db2	SE097A	3	I	t	APL56	f	2022-08-09 15:21:02.509359	2022-08-09 15:21:02.509359
f813beca-67fe-4a85-8198-2427f9470cac	SE097A	3	W	t	APL56	f	2022-08-09 15:21:02.514649	2022-08-09 15:21:02.514649
7c0de7c3-4108-492f-bce0-64afe3674e94	SE097A	3	Z	t	APL56	f	2022-08-09 15:21:02.519871	2022-08-09 15:21:02.519871
c0653865-5fb6-4b9b-b96f-c6cc18739cb5	SE097A	3	A	f	APL56	f	2022-08-09 15:21:02.525393	2022-08-09 15:21:02.525393
31eb1522-dc2b-4eda-b8cc-d564d7b8b5cc	SE097A	3	D	f	APL56	f	2022-08-09 15:21:02.530594	2022-08-09 15:21:02.530594
9e2c0076-526d-4ea3-9162-ddf47fec6e23	SE097A	3	I	f	APL56	f	2022-08-09 15:21:02.536478	2022-08-09 15:21:02.536478
778f47fe-441e-40e2-a289-c1559435680b	SE097A	3	W	f	APL56	f	2022-08-09 15:21:02.542069	2022-08-09 15:21:02.542069
d196974c-1114-4606-a9be-d66b554be67b	SE097A	3	Z	f	APL56	f	2022-08-09 15:21:02.547712	2022-08-09 15:21:02.547712
c9dd6ab2-f3bf-4dc1-9295-e89ea7dadb91	SE097A	3	A	t	APL57	f	2022-08-09 15:21:02.552942	2022-08-09 15:21:02.552942
d1661ff0-86db-43e1-a642-a983c8a23a09	SE097A	3	D	t	APL57	f	2022-08-09 15:21:02.558272	2022-08-09 15:21:02.558272
f2204b7e-1374-4a5f-9e50-43a7545013d1	SE097A	3	I	t	APL57	f	2022-08-09 15:21:02.565154	2022-08-09 15:21:02.565154
74686fcf-3cc3-4b7d-bfa1-fe4443bc7719	SE097A	3	W	t	APL57	f	2022-08-09 15:21:02.570936	2022-08-09 15:21:02.570936
086b2482-92f1-4437-af9d-2f7ca15c76d8	SE097A	3	Z	t	APL57	f	2022-08-09 15:21:02.576264	2022-08-09 15:21:02.576264
4c80a25c-49be-47d8-aabf-44d50bc378f2	SE097A	3	A	f	APL57	f	2022-08-09 15:21:02.58484	2022-08-09 15:21:02.58484
d0a0de52-bd72-43e3-ac12-3ee2fccb0e78	SE097A	3	D	f	APL57	f	2022-08-09 15:21:02.590569	2022-08-09 15:21:02.590569
e9f1d3d1-0ece-4529-b122-c13413678262	SE097A	3	I	f	APL57	f	2022-08-09 15:21:02.596403	2022-08-09 15:21:02.596403
d029d1cc-4490-4ab4-98a8-af6abbfc695d	SE097A	3	W	f	APL57	f	2022-08-09 15:21:02.602286	2022-08-09 15:21:02.602286
cce42fdc-742b-4484-bc5d-e40f4d339578	SE097A	3	Z	f	APL57	f	2022-08-09 15:21:02.608141	2022-08-09 15:21:02.608141
d101f6b4-63a1-4338-9c7f-db0e6e888b78	SE097A	3	A	t	APL65	f	2022-08-09 15:21:02.613933	2022-08-09 15:21:02.613933
5fea51d2-0570-410f-abcc-8b8654f488fe	SE097A	3	D	t	APL65	f	2022-08-09 15:21:02.619106	2022-08-09 15:21:02.619106
a1265b11-6cca-4a7a-b5f2-eabb9b095f35	SE097A	3	I	t	APL65	f	2022-08-09 15:21:02.624684	2022-08-09 15:21:02.624684
f4248e81-6590-4737-89a2-74d76b364255	SE097A	3	W	t	APL65	f	2022-08-09 15:21:02.630269	2022-08-09 15:21:02.630269
22246d8d-2e37-4c9b-a353-c8ecfec47362	SE097A	3	Z	t	APL65	f	2022-08-09 15:21:02.635572	2022-08-09 15:21:02.635572
875e91f6-8905-4fd2-b744-807160e94e25	SE097A	3	A	f	APL65	f	2022-08-09 15:21:02.641179	2022-08-09 15:21:02.641179
3d97f536-4f82-41ff-ab26-1adf4870e88c	SE097A	3	D	f	APL65	f	2022-08-09 15:21:02.646606	2022-08-09 15:21:02.646606
3bbe9a14-cf81-4a40-b9cc-0251c413282a	SE097A	3	I	f	APL65	f	2022-08-09 15:21:02.652101	2022-08-09 15:21:02.652101
4caf9941-f728-489a-9f98-b5f68b679510	SE097A	3	W	f	APL65	f	2022-08-09 15:21:02.657348	2022-08-09 15:21:02.657348
b36e5802-68a4-4eae-882f-a1012a9085de	SE097A	3	Z	f	APL65	f	2022-08-09 15:21:02.663205	2022-08-09 15:21:02.663205
901ebb83-8362-403d-a16c-dff4abf68099	SE097A	3	A	t	APL66	f	2022-08-09 15:21:02.668594	2022-08-09 15:21:02.668594
18b5b17e-f370-44a6-b411-a9335b35cab4	SE097A	3	D	t	APL66	f	2022-08-09 15:21:02.674053	2022-08-09 15:21:02.674053
44d3f72f-5d28-44a1-8439-34806225f2f5	SE097A	3	I	t	APL66	f	2022-08-09 15:21:02.679758	2022-08-09 15:21:02.679758
2dc97bc0-099f-4d3d-8d74-93a3881d4884	SE097A	3	W	t	APL66	f	2022-08-09 15:21:02.685036	2022-08-09 15:21:02.685036
39dbeb0a-3ef1-48ae-866f-ca88f4e882fb	SE097A	3	Z	t	APL66	f	2022-08-09 15:21:02.690758	2022-08-09 15:21:02.690758
0cae76c2-c92a-473c-a215-3b7da79cb5f0	SE097A	3	A	f	APL66	f	2022-08-09 15:21:02.696176	2022-08-09 15:21:02.696176
4738d356-9d12-4d63-a86e-1839345254e4	SE097A	3	D	f	APL66	f	2022-08-09 15:21:02.701432	2022-08-09 15:21:02.701432
129cc99c-372d-4726-9be0-a4fbb8d2740a	SE097A	3	I	f	APL66	f	2022-08-09 15:21:02.707016	2022-08-09 15:21:02.707016
36e4db33-b83e-4637-91cf-d9a55136b1fd	SE097A	3	W	f	APL66	f	2022-08-09 15:21:02.712638	2022-08-09 15:21:02.712638
fc26ace9-5413-4ad3-b04d-719311a7c9d4	SE097A	3	Z	f	APL66	f	2022-08-09 15:21:02.718542	2022-08-09 15:21:02.718542
804f6170-270f-45b3-b0b5-cedc35bdc389	SE097A	3	A	t	APL67	f	2022-08-09 15:21:02.724331	2022-08-09 15:21:02.724331
5b60fb23-8adb-4ca5-a42b-755d052a639d	SE097A	3	D	t	APL67	f	2022-08-09 15:21:02.729784	2022-08-09 15:21:02.729784
4d81ed37-d7ed-4b34-a2d7-a06841b9f1a0	SE097A	3	I	t	APL67	f	2022-08-09 15:21:02.735453	2022-08-09 15:21:02.735453
3d847491-847b-4166-9ba6-5a2f161a237f	SE097A	3	W	t	APL67	f	2022-08-09 15:21:02.740782	2022-08-09 15:21:02.740782
33c425ef-df24-42a6-b496-5880087ad5bf	SE097A	3	Z	t	APL67	f	2022-08-09 15:21:02.746047	2022-08-09 15:21:02.746047
71b084cf-dbc4-40f7-b0fe-b7746b0732a8	SE097A	3	A	f	APL67	f	2022-08-09 15:21:02.752323	2022-08-09 15:21:02.752323
816b1496-8d3f-480b-a21d-a011ee99a492	SE097A	3	D	f	APL67	f	2022-08-09 15:21:02.758742	2022-08-09 15:21:02.758742
3f4e5b57-0250-4146-92d7-f738d37aad15	SE097A	3	I	f	APL67	f	2022-08-09 15:21:02.765749	2022-08-09 15:21:02.765749
864fb38c-6edd-4ed3-93d8-4bbaeeff8f5e	SE097A	3	W	f	APL67	f	2022-08-09 15:21:02.772346	2022-08-09 15:21:02.772346
1b8250da-9e06-480f-bca7-2ba5ac1e7372	SE097A	3	Z	f	APL67	f	2022-08-09 15:21:02.778268	2022-08-09 15:21:02.778268
0cd9ca6c-b934-47f2-bdab-41833e8ace9b	SE097A	3	A	t	APL68	f	2022-08-09 15:21:02.784005	2022-08-09 15:21:02.784005
901404f3-ba0f-4c5e-9924-89eca47fe7a6	SE097A	3	D	t	APL68	f	2022-08-09 15:21:02.789286	2022-08-09 15:21:02.789286
4177ff69-6e1a-44d3-86fe-e10c05f38f7c	SE097A	3	I	t	APL68	f	2022-08-09 15:21:02.794567	2022-08-09 15:21:02.794567
3ecbb8c0-ecfd-4c73-9ff6-86557dabe421	SE097A	3	W	t	APL68	f	2022-08-09 15:21:02.800295	2022-08-09 15:21:02.800295
283d640e-0513-4c5a-8f5a-8b4ae25ed57e	SE097A	3	Z	t	APL68	f	2022-08-09 15:21:02.805576	2022-08-09 15:21:02.805576
f364ccb0-8e43-4cd7-aeff-2b81ddb38515	SE097A	3	A	f	APL68	f	2022-08-09 15:21:02.81135	2022-08-09 15:21:02.81135
52082693-04b2-4cf3-a246-d5cfffb49cd3	SE097A	3	D	f	APL68	f	2022-08-09 15:21:02.816989	2022-08-09 15:21:02.816989
5861f62e-9ad5-48b9-b4d7-6d4e6f00dd52	SE097A	3	I	f	APL68	f	2022-08-09 15:21:02.822839	2022-08-09 15:21:02.822839
c079a43e-6060-4e7d-8b58-7844adebedbe	SE097A	3	W	f	APL68	f	2022-08-09 15:21:02.828595	2022-08-09 15:21:02.828595
6739d8fe-3ec5-462a-8617-385aa1479cc4	SE097A	3	Z	f	APL68	f	2022-08-09 15:21:02.834079	2022-08-09 15:21:02.834079
81f7e090-50d4-4eb6-807f-f324d53f2251	SE097A	3	A	t	APL69	f	2022-08-09 15:21:02.839351	2022-08-09 15:21:02.839351
2a67f82a-8228-4b8d-a90b-4b396ef5377b	SE097A	3	D	t	APL69	f	2022-08-09 15:21:02.844862	2022-08-09 15:21:02.844862
574c6fe8-0d7e-4c74-9286-2ad292e5e1c9	SE097A	3	I	t	APL69	f	2022-08-09 15:21:02.850464	2022-08-09 15:21:02.850464
b1e89aa3-b05f-48d3-8865-902a06d24a65	SE097A	3	W	t	APL69	f	2022-08-09 15:21:02.856364	2022-08-09 15:21:02.856364
98377a63-76b4-4151-a859-26f32064c73e	SE097A	3	Z	t	APL69	f	2022-08-09 15:21:02.861957	2022-08-09 15:21:02.861957
ba8b4dae-5be4-4eee-a38e-bfc07c6a54dd	SE097A	3	A	f	APL69	f	2022-08-09 15:21:02.867504	2022-08-09 15:21:02.867504
34bd7959-c5c7-4443-b91d-94fe84a4a664	SE097A	3	D	f	APL69	f	2022-08-09 15:21:02.873036	2022-08-09 15:21:02.873036
84c68a23-9f16-4212-b5f8-3da4627652fd	SE097A	3	I	f	APL69	f	2022-08-09 15:21:02.878649	2022-08-09 15:21:02.878649
987e39c6-900c-4366-b3c7-0c675c45c07e	SE097A	3	W	f	APL69	f	2022-08-09 15:21:02.883934	2022-08-09 15:21:02.883934
d208e5ff-6161-440a-b2e9-13a7ed440021	SE097A	3	Z	f	APL69	f	2022-08-09 15:21:02.889509	2022-08-09 15:21:02.889509
5a4c4399-660c-4313-baac-ad7a5e7acb03	SE097A	3	A	t	APL70	f	2022-08-09 15:21:02.896432	2022-08-09 15:21:02.896432
96e21592-4150-4b1c-9c6d-5ac837429f57	SE097A	3	D	t	APL70	f	2022-08-09 15:21:02.902253	2022-08-09 15:21:02.902253
3f8648d9-2b7a-43f8-9aec-ac062442fc74	SE097A	3	I	t	APL70	f	2022-08-09 15:21:02.907851	2022-08-09 15:21:02.907851
417b71ae-bd38-4b69-9b72-920d1134d4dc	SE097A	3	W	t	APL70	f	2022-08-09 15:21:02.913618	2022-08-09 15:21:02.913618
81fba6f2-6648-4409-8351-55407e626a8f	SE097A	3	Z	t	APL70	f	2022-08-09 15:21:02.919153	2022-08-09 15:21:02.919153
305432b0-1d96-4bda-8f10-8a05663bfbf0	SE097A	3	A	f	APL70	f	2022-08-09 15:21:02.925046	2022-08-09 15:21:02.925046
557a5d1c-d59d-43a5-8dae-b8e1e16cfae2	SE097A	3	D	f	APL70	f	2022-08-09 15:21:02.930459	2022-08-09 15:21:02.930459
d941ef07-6d3e-439b-92dc-1ac47809c10c	SE097A	3	I	f	APL70	f	2022-08-09 15:21:02.936091	2022-08-09 15:21:02.936091
b237f092-ebe5-427f-9e2e-61d425dbb796	SE097A	3	W	f	APL70	f	2022-08-09 15:21:02.94155	2022-08-09 15:21:02.94155
25712a25-709d-4322-92f0-2489ac79a5d7	SE097A	3	Z	f	APL70	f	2022-08-09 15:21:02.947152	2022-08-09 15:21:02.947152
3a583bdd-323c-4493-b9c9-b874d2c6476f	SE097A	3	A	t	CV027	f	2022-08-09 15:21:02.952452	2022-08-09 15:21:02.952452
9ab00b3e-195c-44a6-b01e-592e649e0a8b	SE097A	3	D	t	CV027	f	2022-08-09 15:21:02.958181	2022-08-09 15:21:02.958181
9414e68d-8cc1-4c91-96b0-cfb0e2f64c84	SE097A	3	I	t	CV027	f	2022-08-09 15:21:02.963462	2022-08-09 15:21:02.963462
afc3b00e-7934-4713-83d5-6106739e95d7	SE097A	3	W	t	CV027	f	2022-08-09 15:21:02.969302	2022-08-09 15:21:02.969302
e1d5a5d6-0ca8-44da-8f1a-75a4c268db4e	SE097A	3	Z	t	CV027	f	2022-08-09 15:21:02.974598	2022-08-09 15:21:02.974598
d70a66c1-f399-43fb-a373-6aa8c0c5e665	SE097A	3	A	f	CV027	f	2022-08-09 15:21:02.980402	2022-08-09 15:21:02.980402
a669bd94-c503-468b-a94b-4c7b74da7abf	SE097A	3	D	f	CV027	f	2022-08-09 15:21:02.986112	2022-08-09 15:21:02.986112
6fbd1102-2023-4249-972e-6ad5d3e46882	SE097A	3	I	f	CV027	f	2022-08-09 15:21:02.991649	2022-08-09 15:21:02.991649
699e7e7e-8962-4b63-a723-44305022d40b	SE097A	3	W	f	CV027	f	2022-08-09 15:21:02.997013	2022-08-09 15:21:02.997013
1f3d4c40-08a1-4ae9-ae0e-9ac949292442	SE097A	3	Z	f	CV027	f	2022-08-09 15:21:03.002351	2022-08-09 15:21:03.002351
79218f38-4604-4b32-ac68-bc4c34fa095a	SE097A	3	A	t	CV079	f	2022-08-09 15:21:03.00802	2022-08-09 15:21:03.00802
cc02596b-768d-4d87-aae3-8ba3ca28605f	SE097A	3	D	t	CV079	f	2022-08-09 15:21:03.01346	2022-08-09 15:21:03.01346
4f525f43-bb20-441c-a311-9a3872987a9b	SE097A	3	I	t	CV079	f	2022-08-09 15:21:03.018673	2022-08-09 15:21:03.018673
305d6f0c-5e0b-43a0-b7ee-d1c404ca621a	SE097A	3	W	t	CV079	f	2022-08-09 15:21:03.024499	2022-08-09 15:21:03.024499
563b1c24-ba41-487a-bb55-be4522d30798	SE097A	3	Z	t	CV079	f	2022-08-09 15:21:03.029931	2022-08-09 15:21:03.029931
53d4a4c4-5bbe-4ca5-a68a-b05baf952733	SE097A	3	A	f	CV118	f	2022-08-09 15:21:03.092727	2022-08-09 15:21:03.092727
c0a30baf-84f0-486d-97a3-5385662078ae	SE097A	3	D	f	CV118	f	2022-08-09 15:21:03.09866	2022-08-09 15:21:03.09866
8691a5dc-a8e5-4c87-aceb-6f85412b45e1	SE097A	3	I	f	CV118	f	2022-08-09 15:21:03.10437	2022-08-09 15:21:03.10437
478bee06-6bb9-4533-bc52-27edca5b9e20	SE097A	3	W	f	CV118	f	2022-08-09 15:21:03.110079	2022-08-09 15:21:03.110079
554d1abb-2b20-4330-880d-c2b577d27411	SE097A	3	Z	f	CV118	f	2022-08-09 15:21:03.115451	2022-08-09 15:21:03.115451
7f148e16-6e88-4032-b6dd-3f05a04ad661	SE097A	3	A	f	CV079	t	2022-08-09 15:21:03.035803	2022-08-09 15:21:03.122938
bbd82556-13cc-4a61-8cf1-47bf02ade428	SE097A	3	D	f	CV079	t	2022-08-09 15:21:03.041489	2022-08-09 15:21:03.130324
f044d729-8b1e-492e-9699-799bbc86cfe0	SE097A	3	I	f	CV079	t	2022-08-09 15:21:03.046882	2022-08-09 15:21:03.137572
efda5129-55bd-4c8a-8b11-f1ffd8d0f600	SE097A	3	W	f	CV079	t	2022-08-09 15:21:03.052689	2022-08-09 15:21:03.144798
f43f7265-ae5d-4761-8f6f-b565302931f8	SE097A	3	Z	f	CV079	t	2022-08-09 15:21:03.058015	2022-08-09 15:21:03.152001
c12f461d-2e72-423b-a08b-f59b554f748d	SE097A	3	A	t	CV118	t	2022-08-09 15:21:03.063181	2022-08-09 15:21:03.158999
cfee1eb5-3021-47c4-a401-7363fb6849b3	SE097A	3	D	t	CV118	t	2022-08-09 15:21:03.068729	2022-08-09 15:21:03.166324
de5f6b91-7f1f-4f20-bf6e-8c265c9fbaec	SE097A	3	I	t	CV118	t	2022-08-09 15:21:03.07407	2022-08-09 15:21:03.173629
5f7c1acf-8c43-4f12-af7f-be8e0017fcfa	SE097A	3	W	t	CV118	t	2022-08-09 15:21:03.08004	2022-08-09 15:21:03.181238
5d4e47a1-4c07-486e-86d0-cd95b917c54c	SE097A	3	Z	t	CV118	t	2022-08-09 15:21:03.087021	2022-08-09 15:21:03.188801
52b8bf99-2c4a-4fac-8546-0b37264056b2	SE101A	3	A	t	APL09	f	2022-08-09 15:21:03.194488	2022-08-09 15:21:03.194488
09813728-850a-4695-9c31-e651746b1c7e	SE101A	3	D	t	APL09	f	2022-08-09 15:21:03.200439	2022-08-09 15:21:03.200439
3345ad9a-7d3b-4118-a9bc-580ffcd7fb89	SE101A	3	I	t	APL09	f	2022-08-09 15:21:03.205771	2022-08-09 15:21:03.205771
f634d899-c67b-40db-8a54-5742707ad3f2	SE101A	3	W	t	APL09	f	2022-08-09 15:21:03.211264	2022-08-09 15:21:03.211264
cc20a7c2-d7d1-41f7-a937-64a505a4e0b5	SE101A	3	Z	t	APL09	f	2022-08-09 15:21:03.218348	2022-08-09 15:21:03.218348
51ea03a5-8ade-4513-a6fb-e3906b239943	SE101A	3	A	f	APL09	f	2022-08-09 15:21:03.224485	2022-08-09 15:21:03.224485
a5595131-ea4b-492d-8795-f39153ad2c27	SE101A	3	D	f	APL09	f	2022-08-09 15:21:03.230979	2022-08-09 15:21:03.230979
22271521-daee-474e-879a-516366035be3	SE101A	3	I	f	APL09	f	2022-08-09 15:21:03.23721	2022-08-09 15:21:03.23721
97420299-b285-496c-aa0c-a08b76a00da2	SE101A	3	W	f	APL09	f	2022-08-09 15:21:03.2426	2022-08-09 15:21:03.2426
e4b215c5-586b-4093-bbd1-039e0b15584b	SE101A	3	Z	f	APL09	f	2022-08-09 15:21:03.248486	2022-08-09 15:21:03.248486
4a638f68-2630-43da-a30f-27c20473457d	SE101A	3	A	t	APL07	f	2022-08-09 15:21:03.253814	2022-08-09 15:21:03.253814
b23e7d75-e39a-4410-9bdc-8789b8a65865	SE101A	3	D	t	APL07	f	2022-08-09 15:21:03.259695	2022-08-09 15:21:03.259695
4b1f6a2b-1f13-4e95-a359-eb76b456abec	SE101A	3	I	t	APL07	f	2022-08-09 15:21:03.265088	2022-08-09 15:21:03.265088
66e25955-e6ea-4423-8bf0-28b1dc30cd26	SE101A	3	W	t	APL07	f	2022-08-09 15:21:03.270729	2022-08-09 15:21:03.270729
2f9bdebd-dbce-47b0-b637-9f0e444bf3b6	SE101A	3	Z	t	APL07	f	2022-08-09 15:21:03.276088	2022-08-09 15:21:03.276088
7445c76d-9490-47de-9f0e-97f23fe61726	SE101A	3	A	f	APL07	f	2022-08-09 15:21:03.281801	2022-08-09 15:21:03.281801
1685d5a2-de5e-4bd7-8482-e150f825bd92	SE101A	3	D	f	APL07	f	2022-08-09 15:21:03.287043	2022-08-09 15:21:03.287043
bc53e266-fa09-4a59-b569-123a2fe65028	SE101A	3	I	f	APL07	f	2022-08-09 15:21:03.292647	2022-08-09 15:21:03.292647
6715a6c0-99e2-45c1-a504-662a4372ffbc	SE101A	3	W	f	APL07	f	2022-08-09 15:21:03.298055	2022-08-09 15:21:03.298055
6dc58253-3c73-4f88-93eb-b7aa25d9c722	SE101A	3	Z	f	APL07	f	2022-08-09 15:21:03.303634	2022-08-09 15:21:03.303634
1742fd47-8807-4ba8-a33e-38bed9e417a0	SE101A	3	A	t	APL11	f	2022-08-09 15:21:03.309311	2022-08-09 15:21:03.309311
634dda50-9f7d-4c39-bdb1-361116776f44	SE101A	3	D	t	APL11	f	2022-08-09 15:21:03.315229	2022-08-09 15:21:03.315229
93441946-1859-4a12-93a4-842c0b711e22	SE101A	3	I	t	APL11	f	2022-08-09 15:21:03.320699	2022-08-09 15:21:03.320699
22bc0a0e-0dd7-4598-82d6-00ec37ee55ee	SE101A	3	W	t	APL11	f	2022-08-09 15:21:03.325972	2022-08-09 15:21:03.325972
0032e424-3d81-4782-b604-b92647e4c9fe	SE101A	3	Z	t	APL11	f	2022-08-09 15:21:03.331851	2022-08-09 15:21:03.331851
1d509890-9532-4cf5-a49b-935dc2040ca6	SE101A	3	A	f	APL11	f	2022-08-09 15:21:03.33717	2022-08-09 15:21:03.33717
ccb9770a-d166-4bc8-ac30-e8a543633614	SE101A	3	D	f	APL11	f	2022-08-09 15:21:03.342639	2022-08-09 15:21:03.342639
d9531d31-7b7a-401b-8b44-0d7d0c583016	SE101A	3	I	f	APL11	f	2022-08-09 15:21:03.349854	2022-08-09 15:21:03.349854
7fbec75f-b573-4578-b7d2-75b036e3e3bd	SE101A	3	W	f	APL11	f	2022-08-09 15:21:03.356343	2022-08-09 15:21:03.356343
df314ded-212c-47e8-a8b5-753e598ab6cd	SE101A	3	Z	f	APL11	f	2022-08-09 15:21:03.362235	2022-08-09 15:21:03.362235
ade43abb-1edb-4e11-a3f1-3a93b9455bf3	SE101A	3	A	t	APL13	f	2022-08-09 15:21:03.368914	2022-08-09 15:21:03.368914
c915baae-095d-4e5d-a812-2e2ef443e04c	SE101A	3	D	t	APL13	f	2022-08-09 15:21:03.374667	2022-08-09 15:21:03.374667
fd0f984a-ac69-48d4-b4a0-eb54c6bc37b5	SE101A	3	I	t	APL13	f	2022-08-09 15:21:03.381265	2022-08-09 15:21:03.381265
d696ff6f-ae6b-44e0-a902-bb03ad2eb9e1	SE101A	3	W	t	APL13	f	2022-08-09 15:21:03.387502	2022-08-09 15:21:03.387502
62772ce3-2a52-4929-ae92-781cae9c01cc	SE101A	3	Z	t	APL13	f	2022-08-09 15:21:03.393468	2022-08-09 15:21:03.393468
dfc6c54f-5908-49f1-9022-823a7ef97f70	SE101A	3	A	f	APL13	f	2022-08-09 15:21:03.399522	2022-08-09 15:21:03.399522
d489772e-6709-4be4-906f-3cb730f9fad1	SE101A	3	D	f	APL13	f	2022-08-09 15:21:03.405403	2022-08-09 15:21:03.405403
9c413ca5-eb51-49c0-bbf2-eefab8795688	SE101A	3	I	f	APL13	f	2022-08-09 15:21:03.411293	2022-08-09 15:21:03.411293
3c04d8d4-49a9-4d78-a959-e9bc8f25c571	SE101A	3	W	f	APL13	f	2022-08-09 15:21:03.416736	2022-08-09 15:21:03.416736
418433ed-45c3-4e4c-9a77-9ec1c72a306a	SE101A	3	Z	f	APL13	f	2022-08-09 15:21:03.422687	2022-08-09 15:21:03.422687
1a418c52-6420-41f9-9061-63c8969bb7a8	SE101A	3	A	t	APL15	f	2022-08-09 15:21:03.428303	2022-08-09 15:21:03.428303
6ce708a3-dddf-40a8-898c-18471e1e8dcd	SE101A	3	D	t	APL15	f	2022-08-09 15:21:03.434642	2022-08-09 15:21:03.434642
da15a66b-a21a-4b18-afd1-de4368a69a74	SE101A	3	I	t	APL15	f	2022-08-09 15:21:03.440698	2022-08-09 15:21:03.440698
30fbc2e3-14ce-4d42-b27a-0f3b249dc5d3	SE101A	3	W	t	APL15	f	2022-08-09 15:21:03.446313	2022-08-09 15:21:03.446313
9f9ef9c7-bfd6-406b-8d92-e65858b864a4	SE101A	3	Z	t	APL15	f	2022-08-09 15:21:03.451773	2022-08-09 15:21:03.451773
0a88d359-f395-4185-942f-52600edc172a	SE101A	3	A	f	APL15	f	2022-08-09 15:21:03.457809	2022-08-09 15:21:03.457809
bccaa787-684a-4b1a-9376-c2bcdd6760e6	SE101A	3	D	f	APL15	f	2022-08-09 15:21:03.463778	2022-08-09 15:21:03.463778
9cba07b6-1e9e-4c30-a7d0-eefb7036d884	SE101A	3	I	f	APL15	f	2022-08-09 15:21:03.469537	2022-08-09 15:21:03.469537
c7e0d5ce-1a0d-4acc-8aa2-6766181ce42d	SE101A	3	W	f	APL15	f	2022-08-09 15:21:03.475614	2022-08-09 15:21:03.475614
3122ca19-677b-446b-8b46-c021594d5e3d	SE101A	3	Z	f	APL15	f	2022-08-09 15:21:03.481332	2022-08-09 15:21:03.481332
83db93ed-1451-40f1-b07c-06db90af97ed	SE101A	3	A	t	APL16	f	2022-08-09 15:21:03.48723	2022-08-09 15:21:03.48723
a5c7df3d-5fc5-4b9b-91bb-b97f500592b4	SE101A	3	D	t	APL16	f	2022-08-09 15:21:03.492736	2022-08-09 15:21:03.492736
43f68588-d41d-4f9d-bb6d-0f210315a7e0	SE101A	3	I	t	APL16	f	2022-08-09 15:21:03.498197	2022-08-09 15:21:03.498197
4ce7af91-fcbf-4ec8-8ecb-dc58ecfe130f	SE101A	3	W	t	APL16	f	2022-08-09 15:21:03.503993	2022-08-09 15:21:03.503993
406366d2-1404-4954-98ca-e01e3d16bb14	SE101A	3	Z	t	APL16	f	2022-08-09 15:21:03.509291	2022-08-09 15:21:03.509291
cc4b43ac-fdaf-437b-a66e-db59bfc0f45f	SE101A	3	A	f	APL16	f	2022-08-09 15:21:03.514989	2022-08-09 15:21:03.514989
5382df6b-1774-413b-bb95-622945dbdb49	SE101A	3	D	f	APL16	f	2022-08-09 15:21:03.520324	2022-08-09 15:21:03.520324
bb371019-b9a5-457f-96d6-45b9ddc5b5a7	SE101A	3	I	f	APL16	f	2022-08-09 15:21:03.527597	2022-08-09 15:21:03.527597
065d995e-74da-447b-88b8-f5f355814520	SE101A	3	W	f	APL16	f	2022-08-09 15:21:03.536263	2022-08-09 15:21:03.536263
0e367a20-4301-4c77-bc1c-b50b73c15052	SE101A	3	Z	f	APL16	f	2022-08-09 15:21:03.54701	2022-08-09 15:21:03.54701
c8a73ea6-4522-4135-ab9a-2c385bf5d459	SE101A	3	A	t	APL18	f	2022-08-09 15:21:03.552741	2022-08-09 15:21:03.552741
09bf15a8-f67d-41c8-9505-8b8840b72b83	SE101A	3	D	t	APL18	f	2022-08-09 15:21:03.558331	2022-08-09 15:21:03.558331
7dfa3488-ed75-43e0-8775-9dcc61e2c677	SE101A	3	I	t	APL18	f	2022-08-09 15:21:03.565508	2022-08-09 15:21:03.565508
dd37cb00-609a-4608-ba23-056cf5dac861	SE101A	3	W	t	APL18	f	2022-08-09 15:21:03.571101	2022-08-09 15:21:03.571101
8fe3ffd0-86e2-4f80-bfab-91a3c8d997c2	SE101A	3	Z	t	APL18	f	2022-08-09 15:21:03.577062	2022-08-09 15:21:03.577062
095578b7-e7e8-482e-92ac-d5dca8b10bb9	SE101A	3	A	f	APL18	f	2022-08-09 15:21:03.582534	2022-08-09 15:21:03.582534
5195c69f-8c38-457b-9363-4083491f8e6a	SE101A	3	D	f	APL18	f	2022-08-09 15:21:03.588388	2022-08-09 15:21:03.588388
b3b4e726-80c8-4231-9c90-73165a8feafd	SE101A	3	I	f	APL18	f	2022-08-09 15:21:03.594081	2022-08-09 15:21:03.594081
a6df12d1-f834-4055-a0b5-2f93eff765d0	SE101A	3	W	f	APL18	f	2022-08-09 15:21:03.59953	2022-08-09 15:21:03.59953
c7465f38-7676-424a-8e64-b6a46c176087	SE101A	3	Z	f	APL18	f	2022-08-09 15:21:03.605205	2022-08-09 15:21:03.605205
1ee6bbd0-2b63-4c70-9f9f-0cee70e7dbef	SE101A	3	A	t	APL20	f	2022-08-09 15:21:03.610833	2022-08-09 15:21:03.610833
09191cb4-bdd9-407f-b771-8a54d99f8272	SE101A	3	D	t	APL20	f	2022-08-09 15:21:03.616504	2022-08-09 15:21:03.616504
0ffc3dc5-a5aa-4ade-a783-ba5cb7086d0f	SE101A	3	I	t	APL20	f	2022-08-09 15:21:03.621832	2022-08-09 15:21:03.621832
a5b261bd-8148-484e-8b44-0a0ee29d17f1	SE101A	3	W	t	APL20	f	2022-08-09 15:21:03.627599	2022-08-09 15:21:03.627599
61140427-c4e7-4c03-a5fa-4d013a3c012c	SE101A	3	Z	t	APL20	f	2022-08-09 15:21:03.63294	2022-08-09 15:21:03.63294
a20362cc-89e0-4551-8ee0-be84b3e761c4	SE101A	3	A	f	APL20	f	2022-08-09 15:21:03.638119	2022-08-09 15:21:03.638119
50d37acb-c019-41b0-8eb0-7c9f10b7afce	SE101A	3	D	f	APL20	f	2022-08-09 15:21:03.643895	2022-08-09 15:21:03.643895
cd2e6d24-df6c-4350-854e-2e5dabd4d4d8	SE101A	3	I	f	APL20	f	2022-08-09 15:21:03.64938	2022-08-09 15:21:03.64938
9e575d64-165b-440e-93d6-117d970b21c2	SE101A	3	W	f	APL20	f	2022-08-09 15:21:03.654703	2022-08-09 15:21:03.654703
2fec147b-6974-4659-92ea-72e5783f4855	SE101A	3	Z	f	APL20	f	2022-08-09 15:21:03.660012	2022-08-09 15:21:03.660012
287ee657-6ac1-4505-959d-437fb49f66b9	SE101A	3	A	t	APL22	f	2022-08-09 15:21:03.665613	2022-08-09 15:21:03.665613
82f78743-47ee-4548-955a-1c16da661b9c	SE101A	3	D	t	APL22	f	2022-08-09 15:21:03.671296	2022-08-09 15:21:03.671296
4ceae91e-9dfe-4800-864c-f1bfc9d49580	SE101A	3	I	t	APL22	f	2022-08-09 15:21:03.676671	2022-08-09 15:21:03.676671
4030fcca-b13e-42d8-833e-1a9651128737	SE101A	3	W	t	APL22	f	2022-08-09 15:21:03.682289	2022-08-09 15:21:03.682289
6bfa582e-191a-4cf9-84a6-0d4ec7054b9d	SE101A	3	Z	t	APL22	f	2022-08-09 15:21:03.687442	2022-08-09 15:21:03.687442
557fe9ed-48d8-4d3b-a2e4-c971a3b6de2f	SE101A	3	A	f	APL22	f	2022-08-09 15:21:03.692649	2022-08-09 15:21:03.692649
205f10aa-f381-48fe-9103-83adff6df2c1	SE101A	3	D	f	APL22	f	2022-08-09 15:21:03.698437	2022-08-09 15:21:03.698437
02c58b9a-0eb4-4f0a-b222-22e777a2a243	SE101A	3	I	f	APL22	f	2022-08-09 15:21:03.704171	2022-08-09 15:21:03.704171
8ef0cc1b-4874-4351-a02e-5eff513b597d	SE101A	3	W	f	APL22	f	2022-08-09 15:21:03.710001	2022-08-09 15:21:03.710001
3e623b83-c622-4e61-8920-ad88aae6cf1a	SE101A	3	Z	f	APL22	f	2022-08-09 15:21:03.715744	2022-08-09 15:21:03.715744
e946eb0e-420d-4ace-9f40-6941550b1114	SE101A	3	A	t	APL27	f	2022-08-09 15:21:03.721667	2022-08-09 15:21:03.721667
c03bd3b0-3dab-4948-b861-0145ab996707	SE101A	3	D	t	APL27	f	2022-08-09 15:21:03.728034	2022-08-09 15:21:03.728034
7567cc8c-311b-40dc-a4be-0e89879b088a	SE101A	3	I	t	APL27	f	2022-08-09 15:21:03.733912	2022-08-09 15:21:03.733912
13479c28-089d-4fa8-a653-7639720722b4	SE101A	3	W	t	APL27	f	2022-08-09 15:21:03.740042	2022-08-09 15:21:03.740042
acdb9f5c-33f5-4a94-b334-a22c16adc33b	SE101A	3	Z	t	APL27	f	2022-08-09 15:21:03.745622	2022-08-09 15:21:03.745622
b55acbcf-3912-45fb-b9f8-132dc4b39915	SE101A	3	A	f	APL27	f	2022-08-09 15:21:03.751495	2022-08-09 15:21:03.751495
698b234f-e71f-4adf-91ce-ba9a9a9b9c3e	SE101A	3	D	f	APL27	f	2022-08-09 15:21:03.757111	2022-08-09 15:21:03.757111
690bbedf-1744-4138-b617-654d76aa62fe	SE101A	3	I	f	APL27	f	2022-08-09 15:21:03.762882	2022-08-09 15:21:03.762882
c8f744f3-0a9d-4f90-8223-5ad7771984f9	SE101A	3	W	f	APL27	f	2022-08-09 15:21:03.768757	2022-08-09 15:21:03.768757
dc6ab287-e276-477a-82c1-d05ac68fb79b	SE101A	3	Z	f	APL27	f	2022-08-09 15:21:03.774364	2022-08-09 15:21:03.774364
33f3541d-7914-4c6b-88e6-44292a1dd964	SE101A	3	A	t	APL29	f	2022-08-09 15:21:03.779947	2022-08-09 15:21:03.779947
ba40ca6e-798b-4e2e-a1ca-ee6279791edb	SE101A	3	D	t	APL29	f	2022-08-09 15:21:03.785629	2022-08-09 15:21:03.785629
bc59c085-8850-4990-8f5d-17de8bf9366b	SE101A	3	I	t	APL29	f	2022-08-09 15:21:03.790931	2022-08-09 15:21:03.790931
0da51229-7177-45f8-af09-127bc69153ec	SE101A	3	W	t	APL29	f	2022-08-09 15:21:03.796196	2022-08-09 15:21:03.796196
5f6ffbd1-fbbe-4812-914c-9838b221fb75	SE101A	3	Z	t	APL29	f	2022-08-09 15:21:03.801846	2022-08-09 15:21:03.801846
a080250a-7e3d-4edd-86ed-1c40ae60c120	SE101A	3	A	f	APL29	f	2022-08-09 15:21:03.807121	2022-08-09 15:21:03.807121
7b7250ae-f9a9-4d03-a530-c26af264f1a9	SE101A	3	D	f	APL29	f	2022-08-09 15:21:03.812682	2022-08-09 15:21:03.812682
14403c36-cfab-4034-af58-b5b9eb2aef3a	SE101A	3	I	f	APL29	f	2022-08-09 15:21:03.81806	2022-08-09 15:21:03.81806
3cd6199b-1860-4a4a-bed9-8bc057dcc467	SE101A	3	W	f	APL29	f	2022-08-09 15:21:03.823539	2022-08-09 15:21:03.823539
4aad3594-6b8d-4ea4-89f6-6455ef537994	SE101A	3	Z	f	APL29	f	2022-08-09 15:21:03.829454	2022-08-09 15:21:03.829454
b283db41-68e1-477c-a15e-2ecd8f2e3723	SE101A	3	A	t	APL31	f	2022-08-09 15:21:03.83488	2022-08-09 15:21:03.83488
a5feefa3-9de8-4636-97f1-36709daf1f38	SE101A	3	D	t	APL31	f	2022-08-09 15:21:03.840097	2022-08-09 15:21:03.840097
5fdeba84-403a-45dd-82f2-9e1375b27356	SE101A	3	I	t	APL31	f	2022-08-09 15:21:03.845657	2022-08-09 15:21:03.845657
90bda2c0-d497-42ba-8a77-26ca2c332145	SE101A	3	W	t	APL31	f	2022-08-09 15:21:03.850882	2022-08-09 15:21:03.850882
098d3cf9-986d-47fa-adb9-dc62a6631152	SE101A	3	Z	t	APL31	f	2022-08-09 15:21:03.856835	2022-08-09 15:21:03.856835
3888fd5a-473d-4b67-89f6-fd8cb2dc4436	SE101A	3	A	f	APL31	f	2022-08-09 15:21:03.862271	2022-08-09 15:21:03.862271
aef68d46-f924-4603-b0aa-91739cf87d21	SE101A	3	D	f	APL31	f	2022-08-09 15:21:03.867945	2022-08-09 15:21:03.867945
afda4232-84b9-495a-ab55-1a1967a058e2	SE101A	3	I	f	APL31	f	2022-08-09 15:21:03.873214	2022-08-09 15:21:03.873214
d98f239f-ba1d-41bc-aed8-fa8441c05bad	SE101A	3	W	f	APL31	f	2022-08-09 15:21:03.878746	2022-08-09 15:21:03.878746
41bbfc01-3a3e-44a8-8fbe-8b29af2b4eb9	SE101A	3	Z	f	APL31	f	2022-08-09 15:21:03.885377	2022-08-09 15:21:03.885377
fcbf4fe3-c8cf-4465-8b44-fe1899864abd	SE101A	3	A	t	APL48	f	2022-08-09 15:21:03.891608	2022-08-09 15:21:03.891608
a8cfb75d-aa2d-4a52-8269-e0913aaaa919	SE101A	3	D	t	APL48	f	2022-08-09 15:21:03.897106	2022-08-09 15:21:03.897106
c97fb62a-6b96-4b2e-8083-57cb31304830	SE101A	3	I	t	APL48	f	2022-08-09 15:21:03.902754	2022-08-09 15:21:03.902754
bba13f03-dc4a-4e38-a8e2-f66e04d55e4a	SE101A	3	W	t	APL48	f	2022-08-09 15:21:03.907999	2022-08-09 15:21:03.907999
3fce0bf7-6a29-48e0-96c5-6484dd922fe6	SE101A	3	Z	t	APL48	f	2022-08-09 15:21:03.913655	2022-08-09 15:21:03.913655
42cd0c5e-7e97-4edd-84b2-1b238bf0614b	SE101A	3	A	f	APL48	f	2022-08-09 15:21:03.919707	2022-08-09 15:21:03.919707
4f747057-2379-4783-9578-e534bb68c94d	SE101A	3	D	f	APL48	f	2022-08-09 15:21:03.925004	2022-08-09 15:21:03.925004
11651ca0-0f73-45bc-8d71-f297d34f0cb8	SE101A	3	I	f	APL48	f	2022-08-09 15:21:03.930806	2022-08-09 15:21:03.930806
6bd2b6a3-c36d-4871-a727-9a9cd421041d	SE101A	3	W	f	APL48	f	2022-08-09 15:21:03.936379	2022-08-09 15:21:03.936379
2b9ad4e4-87ce-442f-b66a-603db3a166db	SE101A	3	Z	f	APL48	f	2022-08-09 15:21:03.941954	2022-08-09 15:21:03.941954
4fa7cbab-c981-4d42-b63d-8615ee06ea77	SE101A	3	A	t	APL49	f	2022-08-09 15:21:03.947531	2022-08-09 15:21:03.947531
5e0096f4-d35c-407d-b9e1-c7f2fbf2c421	SE101A	3	D	t	APL49	f	2022-08-09 15:21:03.953227	2022-08-09 15:21:03.953227
6ccfaa2d-344d-4cdd-b2ae-440a00decc8c	SE101A	3	I	t	APL49	f	2022-08-09 15:21:03.958829	2022-08-09 15:21:03.958829
f37ccc9e-3377-443d-859a-8615dc3504d1	SE101A	3	W	t	APL49	f	2022-08-09 15:21:03.964055	2022-08-09 15:21:03.964055
d63c0782-5862-4796-9af8-d04c5289e60e	SE101A	3	Z	t	APL49	f	2022-08-09 15:21:03.969997	2022-08-09 15:21:03.969997
ee028e44-02ce-4d5e-b1e4-d8946d2fdc7a	SE101A	3	A	f	APL49	f	2022-08-09 15:21:03.975436	2022-08-09 15:21:03.975436
5735cbc9-7684-4596-bc31-62752f6854fa	SE101A	3	D	f	APL49	f	2022-08-09 15:21:03.981415	2022-08-09 15:21:03.981415
891d1fd1-1158-4381-9bb5-1d6f195b24bd	SE101A	3	I	f	APL49	f	2022-08-09 15:21:03.98714	2022-08-09 15:21:03.98714
f6e32572-9b04-4fca-a3b8-5cb5b465f92d	SE101A	3	W	f	APL49	f	2022-08-09 15:21:03.992966	2022-08-09 15:21:03.992966
2164c383-6453-4250-b1a0-c968ea134582	SE101A	3	Z	f	APL49	f	2022-08-09 15:21:03.998608	2022-08-09 15:21:03.998608
1a967f44-c0e5-4eab-9995-527f034f5105	SE101A	3	A	t	APL50	f	2022-08-09 15:21:04.004137	2022-08-09 15:21:04.004137
4c619edc-7677-4ad2-a86f-611940fdcc1b	SE101A	3	D	t	APL50	f	2022-08-09 15:21:04.009826	2022-08-09 15:21:04.009826
459e405a-0499-43f6-aa34-09a3eec9f547	SE101A	3	I	t	APL50	f	2022-08-09 15:21:04.015336	2022-08-09 15:21:04.015336
6c1b2f7c-7703-4350-928e-daa9eacbd815	SE101A	3	W	t	APL50	f	2022-08-09 15:21:04.020922	2022-08-09 15:21:04.020922
99ec63fe-b687-4790-85e3-8056300577f8	SE101A	3	Z	t	APL50	f	2022-08-09 15:21:04.026737	2022-08-09 15:21:04.026737
f3d2bcd7-ce5d-4ae0-b525-25fb3e988c2e	SE101A	3	A	f	APL50	f	2022-08-09 15:21:04.032229	2022-08-09 15:21:04.032229
2b239428-a9ac-4a01-bb0c-f5fa9899e66d	SE101A	3	D	f	APL50	f	2022-08-09 15:21:04.037952	2022-08-09 15:21:04.037952
8fb9929b-4b91-4065-b971-ef941dd25957	SE101A	3	I	f	APL50	f	2022-08-09 15:21:04.043522	2022-08-09 15:21:04.043522
8897622f-b911-4b1b-97a6-e52118869002	SE101A	3	W	f	APL50	f	2022-08-09 15:21:04.049224	2022-08-09 15:21:04.049224
8277e621-c117-4d44-abd7-a46e9b635c88	SE101A	3	Z	f	APL50	f	2022-08-09 15:21:04.054946	2022-08-09 15:21:04.054946
6d5e2020-6222-45fb-b8bd-8f756888ba93	SE101A	3	A	t	APL51	f	2022-08-09 15:21:04.060552	2022-08-09 15:21:04.060552
586fe524-cc34-4978-bc76-38e0d2e07170	SE101A	3	D	t	APL51	f	2022-08-09 15:21:04.065879	2022-08-09 15:21:04.065879
edd024fd-83b8-4f65-af50-14cca781f248	SE101A	3	I	t	APL51	f	2022-08-09 15:21:04.071507	2022-08-09 15:21:04.071507
1fa79632-8a62-4df6-833e-a80f40ef8263	SE101A	3	W	t	APL51	f	2022-08-09 15:21:04.076814	2022-08-09 15:21:04.076814
f2f6ba7f-94b4-4197-ac60-bbaabbc56bfa	SE101A	3	Z	t	APL51	f	2022-08-09 15:21:04.08546	2022-08-09 15:21:04.08546
0476dded-ab56-476e-ad78-5f26e757316c	SE101A	3	A	f	APL51	f	2022-08-09 15:21:04.091121	2022-08-09 15:21:04.091121
91114d63-a695-49c1-a660-6148b60114b4	SE101A	3	D	f	APL51	f	2022-08-09 15:21:04.096567	2022-08-09 15:21:04.096567
8ff89c08-a6c3-400e-8d4b-15a4e6ef5a1f	SE101A	3	I	f	APL51	f	2022-08-09 15:21:04.102529	2022-08-09 15:21:04.102529
829a031d-16e2-43ff-a803-fbd33b25a5db	SE101A	3	W	f	APL51	f	2022-08-09 15:21:04.107994	2022-08-09 15:21:04.107994
0ca56ad6-debc-4cda-80d0-a01f8abd58bb	SE101A	3	Z	f	APL51	f	2022-08-09 15:21:04.113741	2022-08-09 15:21:04.113741
66c93d0e-e4a3-42c9-be91-ab6cf65ef7f0	SE101A	3	A	t	APL52	f	2022-08-09 15:21:04.11909	2022-08-09 15:21:04.11909
af984486-41a1-45cf-adb4-f8956e48c72a	SE101A	3	D	t	APL52	f	2022-08-09 15:21:04.124367	2022-08-09 15:21:04.124367
218c1e19-846d-4ef7-8956-ed06b39cc336	SE101A	3	I	t	APL52	f	2022-08-09 15:21:04.130122	2022-08-09 15:21:04.130122
e411a4f0-776b-4f2c-b77e-bd91e5c63f9c	SE101A	3	W	t	APL52	f	2022-08-09 15:21:04.135582	2022-08-09 15:21:04.135582
2781b7e9-ea96-418e-a4ed-5bde5206b683	SE101A	3	Z	t	APL52	f	2022-08-09 15:21:04.141125	2022-08-09 15:21:04.141125
08d3388b-0256-4f59-b860-084c427294d2	SE101A	3	A	f	APL52	f	2022-08-09 15:21:04.146618	2022-08-09 15:21:04.146618
73f0d1bb-943e-4fce-9786-d153e2a7187e	SE101A	3	D	f	APL52	f	2022-08-09 15:21:04.151791	2022-08-09 15:21:04.151791
53f0a45a-8839-41b0-97f0-e69808bfa131	SE101A	3	I	f	APL52	f	2022-08-09 15:21:04.15711	2022-08-09 15:21:04.15711
9c791b50-eb14-4015-ba13-3d8c461e97a8	SE101A	3	W	f	APL52	f	2022-08-09 15:21:04.162776	2022-08-09 15:21:04.162776
b0afed9f-64a4-4b2c-84d5-475ce7c3f0c2	SE101A	3	Z	f	APL52	f	2022-08-09 15:21:04.168109	2022-08-09 15:21:04.168109
9ea1fe2c-de82-4da7-b60e-a7d496c1aab6	SE101A	3	A	t	APL53	f	2022-08-09 15:21:04.173749	2022-08-09 15:21:04.173749
f1531ec7-d8d2-4605-85ed-30e51405f018	SE101A	3	D	t	APL53	f	2022-08-09 15:21:04.179384	2022-08-09 15:21:04.179384
63cc1692-f4a9-494c-9fe5-b1f30ba75fac	SE101A	3	I	t	APL53	f	2022-08-09 15:21:04.185641	2022-08-09 15:21:04.185641
787dabca-72bb-437e-b339-71349a3b48b3	SE101A	3	W	t	APL53	f	2022-08-09 15:21:04.191691	2022-08-09 15:21:04.191691
8a634ffc-1355-4496-9420-cf79f9c0b53d	SE101A	3	Z	t	APL53	f	2022-08-09 15:21:04.197324	2022-08-09 15:21:04.197324
80b840b1-8b91-4848-ab24-af8502ca203a	SE101A	3	A	f	APL53	f	2022-08-09 15:21:04.202615	2022-08-09 15:21:04.202615
0114b3fb-5dc8-4952-8022-b71077214c09	SE101A	3	D	f	APL53	f	2022-08-09 15:21:04.209525	2022-08-09 15:21:04.209525
3186f635-63a3-476e-9f7a-02d92eeaa190	SE101A	3	I	f	APL53	f	2022-08-09 15:21:04.21541	2022-08-09 15:21:04.21541
d0078f4d-d265-431b-8445-fca56913db64	SE101A	3	W	f	APL53	f	2022-08-09 15:21:04.221296	2022-08-09 15:21:04.221296
08449162-440b-442e-8e80-89090c96aeb6	SE101A	3	Z	f	APL53	f	2022-08-09 15:21:04.226976	2022-08-09 15:21:04.226976
9e357144-ec77-4351-a9c1-e40f9aeaeaf7	SE101A	3	A	t	APL54	f	2022-08-09 15:21:04.233025	2022-08-09 15:21:04.233025
1bb28d93-6279-4c70-ba46-a09475393d72	SE101A	3	D	t	APL54	f	2022-08-09 15:21:04.238336	2022-08-09 15:21:04.238336
1f6ef9fe-e54f-44b4-a165-ae8198afaf87	SE101A	3	I	t	APL54	f	2022-08-09 15:21:04.244074	2022-08-09 15:21:04.244074
55b12c12-4d70-4c3c-939b-ed90c9f043f4	SE101A	3	W	t	APL54	f	2022-08-09 15:21:04.250357	2022-08-09 15:21:04.250357
60b095b9-1a44-432a-b02a-0d1ca68e0963	SE101A	3	Z	t	APL54	f	2022-08-09 15:21:04.257226	2022-08-09 15:21:04.257226
391db9cd-357c-4fa9-a63d-7ccb189e13b4	SE101A	3	A	f	APL54	f	2022-08-09 15:21:04.263563	2022-08-09 15:21:04.263563
ff6d81f4-f441-407d-a26b-6f60c6ff9bc1	SE101A	3	D	f	APL54	f	2022-08-09 15:21:04.268968	2022-08-09 15:21:04.268968
63bd7990-ead3-4527-826f-b889f24e0d64	SE101A	3	I	f	APL54	f	2022-08-09 15:21:04.27421	2022-08-09 15:21:04.27421
3c5ff120-356c-42e3-b2b3-51a56ef11139	SE101A	3	W	f	APL54	f	2022-08-09 15:21:04.279733	2022-08-09 15:21:04.279733
4e5a3d7c-3d7e-4dda-8681-0caae189a149	SE101A	3	Z	f	APL54	f	2022-08-09 15:21:04.285019	2022-08-09 15:21:04.285019
8641dab9-46b6-4519-bba3-935c99c76c57	SE101A	3	A	t	APL55	f	2022-08-09 15:21:04.290612	2022-08-09 15:21:04.290612
1261fd1a-a466-490d-851f-06f83df5256d	SE101A	3	D	t	APL55	f	2022-08-09 15:21:04.295895	2022-08-09 15:21:04.295895
38ef5f78-e4de-48d1-aee3-ded36bd738bd	SE101A	3	I	t	APL55	f	2022-08-09 15:21:04.301419	2022-08-09 15:21:04.301419
241be8ed-79ee-4677-ab63-9a3f54f55534	SE101A	3	W	t	APL55	f	2022-08-09 15:21:04.306906	2022-08-09 15:21:04.306906
2a334d72-9583-4f84-be9c-b709dff9bcf1	SE101A	3	Z	t	APL55	f	2022-08-09 15:21:04.312582	2022-08-09 15:21:04.312582
2d8d6ded-41dc-405f-99ad-eda93507fd8b	SE101A	3	A	f	APL55	f	2022-08-09 15:21:04.317856	2022-08-09 15:21:04.317856
e562d8e6-6774-4a50-b9ef-13c2be523fe4	SE101A	3	D	f	APL55	f	2022-08-09 15:21:04.323211	2022-08-09 15:21:04.323211
5da72b2a-0e09-4a9c-9ccf-429697e4302c	SE101A	3	I	f	APL55	f	2022-08-09 15:21:04.328943	2022-08-09 15:21:04.328943
00ab6c66-ca00-4c0c-b7d6-d7fe712959af	SE101A	3	W	f	APL55	f	2022-08-09 15:21:04.334298	2022-08-09 15:21:04.334298
5f7b0916-6fb5-4614-b543-075381f85a65	SE101A	3	Z	f	APL55	f	2022-08-09 15:21:04.339568	2022-08-09 15:21:04.339568
81065860-2d9f-49df-98c3-40f5f69177ee	SE101A	3	A	t	APL56	f	2022-08-09 15:21:04.345584	2022-08-09 15:21:04.345584
949d4fae-f393-4097-934f-87e77e44b2e8	SE101A	3	D	t	APL56	f	2022-08-09 15:21:04.352516	2022-08-09 15:21:04.352516
24b9d118-1829-4b97-857d-5932e5d74dad	SE101A	3	I	t	APL56	f	2022-08-09 15:21:04.358475	2022-08-09 15:21:04.358475
30063197-a885-4ade-b0e5-8a7df4a6c2ef	SE101A	3	W	t	APL56	f	2022-08-09 15:21:04.36422	2022-08-09 15:21:04.36422
731ce256-fb82-49e4-ae8b-d9f10207507c	SE101A	3	Z	t	APL56	f	2022-08-09 15:21:04.370633	2022-08-09 15:21:04.370633
fb4fe084-5cf6-4a22-bff5-cb53dbfa107f	SE101A	3	A	f	APL56	f	2022-08-09 15:21:04.3763	2022-08-09 15:21:04.3763
44fa1151-a6bc-4eb4-8e09-5e78dc732e14	SE101A	3	D	f	APL56	f	2022-08-09 15:21:04.382035	2022-08-09 15:21:04.382035
266c94c9-39ed-47f2-aed0-d5dfdab0902b	SE101A	3	I	f	APL56	f	2022-08-09 15:21:04.388099	2022-08-09 15:21:04.388099
0cafee6d-a017-412c-be53-f4804246c334	SE101A	3	W	f	APL56	f	2022-08-09 15:21:04.393685	2022-08-09 15:21:04.393685
8c0f1219-e6b5-4d18-86ff-03a4550d1973	SE101A	3	Z	f	APL56	f	2022-08-09 15:21:04.399019	2022-08-09 15:21:04.399019
b5133874-2a2a-4ee5-9d54-736015bccf96	SE101A	3	A	t	APL57	f	2022-08-09 15:21:04.404527	2022-08-09 15:21:04.404527
70181a2e-148b-45e1-b979-3cf457c59f4a	SE101A	3	D	t	APL57	f	2022-08-09 15:21:04.410056	2022-08-09 15:21:04.410056
d6f39e69-7417-4153-861c-a5309d229138	SE101A	3	I	t	APL57	f	2022-08-09 15:21:04.415747	2022-08-09 15:21:04.415747
b15e093e-0773-47f0-9f56-99e41821bb37	SE101A	3	W	t	APL57	f	2022-08-09 15:21:04.421182	2022-08-09 15:21:04.421182
1e8152b4-857c-46de-b2c8-eac148070ff7	SE101A	3	Z	t	APL57	f	2022-08-09 15:21:04.426568	2022-08-09 15:21:04.426568
862cb4aa-73a4-49ee-8945-8aff4d092d08	SE101A	3	A	f	APL57	f	2022-08-09 15:21:04.43326	2022-08-09 15:21:04.43326
d4da252f-44ad-4d4e-9027-c4072cef739f	SE101A	3	D	f	APL57	f	2022-08-09 15:21:04.439797	2022-08-09 15:21:04.439797
0c6148cb-6ab5-4132-8b41-e5c33671ad94	SE101A	3	I	f	APL57	f	2022-08-09 15:21:04.44539	2022-08-09 15:21:04.44539
045f6dde-28e1-421c-a3f3-bc80259e84f1	SE101A	3	W	f	APL57	f	2022-08-09 15:21:04.451121	2022-08-09 15:21:04.451121
b555b13a-3c78-4fe7-87dc-6b4afbe929cb	SE101A	3	Z	f	APL57	f	2022-08-09 15:21:04.456665	2022-08-09 15:21:04.456665
cc78e0e3-3b64-4076-8263-43012bf5746f	SE101A	3	A	t	APL65	f	2022-08-09 15:21:04.462042	2022-08-09 15:21:04.462042
8ad1882f-27ed-4a74-b672-557e7116eed4	SE101A	3	D	t	APL65	f	2022-08-09 15:21:04.467583	2022-08-09 15:21:04.467583
23359aa1-ee55-41fb-8d64-db7bb41b3c2e	SE101A	3	I	t	APL65	f	2022-08-09 15:21:04.473094	2022-08-09 15:21:04.473094
697eab0d-3910-4491-ac01-7604c6f179c5	SE101A	3	W	t	APL65	f	2022-08-09 15:21:04.478806	2022-08-09 15:21:04.478806
9260ff85-fa31-476e-8340-0bf28f500835	SE101A	3	Z	t	APL65	f	2022-08-09 15:21:04.484194	2022-08-09 15:21:04.484194
38326533-0507-4df9-b441-ea20b7305d8a	SE101A	3	A	f	APL65	f	2022-08-09 15:21:04.489538	2022-08-09 15:21:04.489538
88d2e709-5605-439a-8594-1ba3bea34ae7	SE101A	3	D	f	APL65	f	2022-08-09 15:21:04.495243	2022-08-09 15:21:04.495243
31d97907-3ce5-41c0-97c1-4e24dd158da7	SE101A	3	I	f	APL65	f	2022-08-09 15:21:04.500631	2022-08-09 15:21:04.500631
9e26da26-f648-4073-a29b-5df9670f3a67	SE101A	3	W	f	APL65	f	2022-08-09 15:21:04.506282	2022-08-09 15:21:04.506282
c868def5-ca0f-4e5c-a333-ed66aa9caa22	SE101A	3	Z	f	APL65	f	2022-08-09 15:21:04.511527	2022-08-09 15:21:04.511527
700a3a6b-201a-4c32-a96d-98bc26ac0d59	SE101A	3	A	t	APL66	f	2022-08-09 15:21:04.517118	2022-08-09 15:21:04.517118
a7f96c84-14f9-459d-a194-f4bb26cbc965	SE101A	3	D	t	APL66	f	2022-08-09 15:21:04.522447	2022-08-09 15:21:04.522447
3b2a689e-cb51-4127-a843-bbc760655cdd	SE101A	3	I	t	APL66	f	2022-08-09 15:21:04.528193	2022-08-09 15:21:04.528193
9c6505e1-72d8-460c-a2e6-5233d190f072	SE101A	3	W	t	APL66	f	2022-08-09 15:21:04.533573	2022-08-09 15:21:04.533573
5e2b77ce-e814-4303-a43c-593597b6d576	SE101A	3	Z	t	APL66	f	2022-08-09 15:21:04.54007	2022-08-09 15:21:04.54007
79754601-ebcc-474e-88bb-644c1562d9e1	SE101A	3	A	f	APL66	f	2022-08-09 15:21:04.545945	2022-08-09 15:21:04.545945
9c140dd8-df8a-4a40-923e-e151ecfc3709	SE101A	3	D	f	APL66	f	2022-08-09 15:21:04.551769	2022-08-09 15:21:04.551769
2034d80c-3107-4de1-9680-1a4592d296ee	SE101A	3	I	f	APL66	f	2022-08-09 15:21:04.557117	2022-08-09 15:21:04.557117
057b5ba0-a116-47b3-a6a3-b02f2e82db01	SE101A	3	W	f	APL66	f	2022-08-09 15:21:04.562768	2022-08-09 15:21:04.562768
6cdc3bae-e052-408b-94d3-1502b6f99656	SE101A	3	Z	f	APL66	f	2022-08-09 15:21:04.568171	2022-08-09 15:21:04.568171
eb2d1938-4b9d-41fe-9760-ea3638d9c4b3	SE101A	3	A	t	APL67	f	2022-08-09 15:21:04.574088	2022-08-09 15:21:04.574088
7f7ad345-daf9-41df-8569-06c29061f019	SE101A	3	D	t	APL67	f	2022-08-09 15:21:04.579713	2022-08-09 15:21:04.579713
7a12bac2-5f2f-4be1-822e-7a1ab72a9eb4	SE101A	3	I	t	APL67	f	2022-08-09 15:21:04.585441	2022-08-09 15:21:04.585441
1bd4a206-fde2-4970-a4ac-771b81da0570	SE101A	3	W	t	APL67	f	2022-08-09 15:21:04.591017	2022-08-09 15:21:04.591017
9b3b4ecc-215e-43d1-945c-5bcd19efae93	SE101A	3	Z	t	APL67	f	2022-08-09 15:21:04.596325	2022-08-09 15:21:04.596325
86342a94-a9e3-4723-934a-d1fc56498fe2	SE101A	3	A	f	APL67	f	2022-08-09 15:21:04.601753	2022-08-09 15:21:04.601753
6659322e-59ef-4257-afcb-0f1efb179a5f	SE101A	3	D	f	APL67	f	2022-08-09 15:21:04.607629	2022-08-09 15:21:04.607629
e564b638-2113-425d-a650-d4fe20dcf8b5	SE101A	3	I	f	APL67	f	2022-08-09 15:21:04.612936	2022-08-09 15:21:04.612936
b2f01629-4536-4faf-83c8-6fd07f65605a	SE101A	3	W	f	APL67	f	2022-08-09 15:21:04.618464	2022-08-09 15:21:04.618464
dfe344ca-bef8-4050-9836-26e8db44d464	SE101A	3	Z	f	APL67	f	2022-08-09 15:21:04.623953	2022-08-09 15:21:04.623953
2463cdfe-f3d1-4287-91e7-640e9b2a7f64	SE101A	3	A	t	APL68	f	2022-08-09 15:21:04.629739	2022-08-09 15:21:04.629739
d09e0f03-df2e-4835-9b6e-30b20ddeb846	SE101A	3	D	t	APL68	f	2022-08-09 15:21:04.635218	2022-08-09 15:21:04.635218
0e9741f1-1bac-41ef-9a36-d5a619e2a6f4	SE101A	3	I	t	APL68	f	2022-08-09 15:21:04.640484	2022-08-09 15:21:04.640484
051517c4-c8b4-449d-bd52-ac35fb8f6555	SE101A	3	W	t	APL68	f	2022-08-09 15:21:04.646305	2022-08-09 15:21:04.646305
f07ad62f-0342-4967-ba1a-669f743bfb9f	SE101A	3	Z	t	APL68	f	2022-08-09 15:21:04.65164	2022-08-09 15:21:04.65164
6c3365fb-72f2-45f7-97fc-ac5caa3ae265	SE101A	3	A	f	APL68	f	2022-08-09 15:21:04.657367	2022-08-09 15:21:04.657367
3a040789-5388-4b6c-9550-527964435c45	SE101A	3	D	f	APL68	f	2022-08-09 15:21:04.662701	2022-08-09 15:21:04.662701
b0d2e04a-8df8-4c1a-9563-773d69b02788	SE101A	3	I	f	APL68	f	2022-08-09 15:21:04.668081	2022-08-09 15:21:04.668081
ac96f727-6b59-4d7c-872c-0d3352631ffb	SE101A	3	W	f	APL68	f	2022-08-09 15:21:04.673611	2022-08-09 15:21:04.673611
abc3d5b1-0f6b-40a7-8320-163d9d0a1c50	SE101A	3	Z	f	APL68	f	2022-08-09 15:21:04.679036	2022-08-09 15:21:04.679036
af5b9fbf-f0be-4e4b-a66d-a3fe0e1f9f23	SE101A	3	A	t	APL69	f	2022-08-09 15:21:04.684774	2022-08-09 15:21:04.684774
145a5af9-e6ac-4832-8187-fb7e58492cca	SE101A	3	D	t	APL69	f	2022-08-09 15:21:04.690194	2022-08-09 15:21:04.690194
06a87f8d-e2e5-4dea-af0a-033bb0c2e83c	SE101A	3	I	t	APL69	f	2022-08-09 15:21:04.695441	2022-08-09 15:21:04.695441
1584d065-00c0-47bf-bd2d-888b35ed2ed1	SE101A	3	W	t	APL69	f	2022-08-09 15:21:04.700993	2022-08-09 15:21:04.700993
209d7d3d-02e8-4216-9c84-c0a6b3f1d342	SE101A	3	Z	t	APL69	f	2022-08-09 15:21:04.706279	2022-08-09 15:21:04.706279
54c9b2e2-d24f-4dd2-8f95-a327174ad0d7	SE101A	3	A	f	APL69	f	2022-08-09 15:21:04.711603	2022-08-09 15:21:04.711603
061ab9b6-28de-4cc9-8731-6a1017f21b94	SE101A	3	D	f	APL69	f	2022-08-09 15:21:04.717286	2022-08-09 15:21:04.717286
16b3ad8c-9d76-4804-8ab7-85b644233b6f	SE101A	3	I	f	APL69	f	2022-08-09 15:21:04.722519	2022-08-09 15:21:04.722519
a207c689-e9b2-4b13-a0c2-685709a3f153	SE101A	3	W	f	APL69	f	2022-08-09 15:21:04.728285	2022-08-09 15:21:04.728285
184fca07-7a70-4a66-a27d-689613e51643	SE101A	3	Z	f	APL69	f	2022-08-09 15:21:04.733606	2022-08-09 15:21:04.733606
a947c218-0a63-4537-be6d-b8ce52d91707	SE101A	3	A	t	APL70	f	2022-08-09 15:21:04.739057	2022-08-09 15:21:04.739057
c5e11e76-3e9f-47d6-bdef-f373db5802a2	SE101A	3	D	t	APL70	f	2022-08-09 15:21:04.744926	2022-08-09 15:21:04.744926
4f6a1baa-f14f-4ecb-92a9-88c8ad9ac6cb	SE101A	3	I	t	APL70	f	2022-08-09 15:21:04.750391	2022-08-09 15:21:04.750391
4932bdb4-5768-425e-870a-349e2645ec5c	SE101A	3	W	t	APL70	f	2022-08-09 15:21:04.755885	2022-08-09 15:21:04.755885
e363d267-0c63-49e4-9fbf-581e808a6008	SE101A	3	Z	t	APL70	f	2022-08-09 15:21:04.761383	2022-08-09 15:21:04.761383
012802de-4475-46b7-8aca-8a2bf43f3d6d	SE101A	3	A	f	APL70	f	2022-08-09 15:21:04.766771	2022-08-09 15:21:04.766771
3f361afe-d57d-4bd9-b071-70dac3e99ffd	SE101A	3	D	f	APL70	f	2022-08-09 15:21:04.77236	2022-08-09 15:21:04.77236
67b3ba7e-772b-4334-b95f-a18d9e058ce7	SE101A	3	I	f	APL70	f	2022-08-09 15:21:04.777761	2022-08-09 15:21:04.777761
b8b0029b-6449-4889-8896-bb041523480f	SE101A	3	W	f	APL70	f	2022-08-09 15:21:04.783118	2022-08-09 15:21:04.783118
06bcd1b9-e64a-43a9-b77c-5b193ff3b361	SE101A	3	Z	f	APL70	f	2022-08-09 15:21:04.788745	2022-08-09 15:21:04.788745
bb381cbe-2cb5-47c1-90cb-3ccbd60e4d9e	SE101A	3	A	t	CV027	f	2022-08-09 15:21:04.794078	2022-08-09 15:21:04.794078
60497663-d92d-4651-bc0d-1fc3931965ff	SE101A	3	D	t	CV027	f	2022-08-09 15:21:04.799428	2022-08-09 15:21:04.799428
727d7661-1c85-4fd1-821d-369e30d70461	SE101A	3	I	t	CV027	f	2022-08-09 15:21:04.805134	2022-08-09 15:21:04.805134
63e91070-e9b0-44b3-a85d-6a2d173fa301	SE101A	3	W	t	CV027	f	2022-08-09 15:21:04.810731	2022-08-09 15:21:04.810731
839ecd5e-ac76-4310-94a7-024025a77946	SE101A	3	Z	t	CV027	f	2022-08-09 15:21:04.816651	2022-08-09 15:21:04.816651
05a928ca-9057-4abc-87c5-81699a89c7d9	SE101A	3	A	f	CV027	f	2022-08-09 15:21:04.822599	2022-08-09 15:21:04.822599
779992a9-d834-4616-8b95-3ca51d39cc9f	SE101A	3	D	f	CV027	f	2022-08-09 15:21:04.828518	2022-08-09 15:21:04.828518
dbd8880d-e732-41cc-b4ab-08135caa9fca	SE101A	3	I	f	CV027	f	2022-08-09 15:21:04.834063	2022-08-09 15:21:04.834063
e7c3ac13-48b2-4f99-b925-514e6254ffd3	SE101A	3	W	f	CV027	f	2022-08-09 15:21:04.83994	2022-08-09 15:21:04.83994
327a5937-466d-4959-bb1f-da2ba1700b72	SE101A	3	Z	f	CV027	f	2022-08-09 15:21:04.846862	2022-08-09 15:21:04.846862
e7f0d9b5-5f8a-4634-bd58-231a3fc6c862	SE101A	3	A	t	CV079	f	2022-08-09 15:21:04.854444	2022-08-09 15:21:04.854444
6c51876c-ac73-422d-a3d7-cf227b742143	SE101A	3	D	t	CV079	f	2022-08-09 15:21:04.862109	2022-08-09 15:21:04.862109
2bf70ad0-ffbb-4782-a74d-bbf61e539bba	SE101A	3	I	t	CV079	f	2022-08-09 15:21:04.868051	2022-08-09 15:21:04.868051
24f7c3fb-15f7-4c48-9359-a84b9aa33d3e	SE101A	3	W	t	CV079	f	2022-08-09 15:21:04.87395	2022-08-09 15:21:04.87395
5271ac71-153c-43f6-b0b3-4fde2f3f1f7e	SE101A	3	Z	t	CV079	f	2022-08-09 15:21:04.879587	2022-08-09 15:21:04.879587
17aa9f38-cefa-44e1-bf60-2b082296b960	SE101A	3	A	f	CV118	f	2022-08-09 15:21:04.941921	2022-08-09 15:21:04.941921
4abe09ef-0afd-4a42-ac9c-8f7658be399c	SE101A	3	D	f	CV118	f	2022-08-09 15:21:04.947539	2022-08-09 15:21:04.947539
0ad0c762-54f0-4359-984a-807ef852f1dd	SE101A	3	I	f	CV118	f	2022-08-09 15:21:04.953111	2022-08-09 15:21:04.953111
19fefab7-0b71-4604-82a3-736456c70c52	SE101A	3	W	f	CV118	f	2022-08-09 15:21:04.959134	2022-08-09 15:21:04.959134
ad190170-4d3b-43c9-9abd-f7b7e182e797	SE101A	3	Z	f	CV118	f	2022-08-09 15:21:04.964544	2022-08-09 15:21:04.964544
9db455a7-aa48-4821-8562-90b936a14cf5	SE101A	3	A	f	CV079	t	2022-08-09 15:21:04.885298	2022-08-09 15:21:04.971884
ad8a3f71-89e1-4143-8abb-829fe9099193	SE101A	3	D	f	CV079	t	2022-08-09 15:21:04.890955	2022-08-09 15:21:04.97914
6809f3a3-d3f6-4902-a121-8ea060eea24a	SE101A	3	I	f	CV079	t	2022-08-09 15:21:04.896461	2022-08-09 15:21:04.986849
cf4e348a-b44d-4e9f-aeb6-b19ea2a51bc7	SE101A	3	W	f	CV079	t	2022-08-09 15:21:04.902352	2022-08-09 15:21:04.994607
74b8e3d9-0b6b-4072-a001-c6cac5d506c9	SE101A	3	Z	f	CV079	t	2022-08-09 15:21:04.907907	2022-08-09 15:21:05.002094
edd91cd2-86b8-4fa9-9fcb-9ed07cf153fd	SE101A	3	A	t	CV118	t	2022-08-09 15:21:04.913579	2022-08-09 15:21:05.00951
2db9d740-27f4-48d2-98d3-bf134842d20c	SE101A	3	D	t	CV118	t	2022-08-09 15:21:04.918916	2022-08-09 15:21:05.016585
a5b2e326-269f-48ae-853d-70dbb59f6ba8	SE101A	3	I	t	CV118	t	2022-08-09 15:21:04.925191	2022-08-09 15:21:05.023797
c9d6cc8f-d222-4232-9c53-4be9da2baf21	SE101A	3	W	t	CV118	t	2022-08-09 15:21:04.931021	2022-08-09 15:21:05.031037
a18b55de-b912-40d7-8e87-74e3895c0a82	SE101A	3	Z	t	CV118	t	2022-08-09 15:21:04.936601	2022-08-09 15:21:05.038013
784e5087-3774-441e-94e0-4e8cc927f48b	SE003E	3	A	t	CV027	f	2022-08-09 15:21:05.043855	2022-08-09 15:21:05.043855
e0974ab8-6fe3-4ee5-b38d-32ff37d6f187	SE003E	3	D	t	CV027	f	2022-08-09 15:21:05.049615	2022-08-09 15:21:05.049615
225016e9-183f-4a57-aed8-2e3ec3a34ee1	SE003E	3	I	t	CV027	f	2022-08-09 15:21:05.055432	2022-08-09 15:21:05.055432
5b65c216-023f-45a4-b38f-def84490d05b	SE003E	3	W	t	CV027	f	2022-08-09 15:21:05.060869	2022-08-09 15:21:05.060869
189fecf5-6f4a-4ab4-8c0b-7dba3f83d6bd	SE003E	3	Z	t	CV027	f	2022-08-09 15:21:05.066283	2022-08-09 15:21:05.066283
f61b17fa-116a-40b9-86fb-aca5d59f9953	SE003E	3	A	f	CV027	f	2022-08-09 15:21:05.072403	2022-08-09 15:21:05.072403
d9662887-943a-424d-b902-f5db54b48385	SE003E	3	D	f	CV027	f	2022-08-09 15:21:05.07809	2022-08-09 15:21:05.07809
ba7e121b-2ba9-4cd2-b4b9-4a78a4a9f495	SE003E	3	I	f	CV027	f	2022-08-09 15:21:05.085706	2022-08-09 15:21:05.085706
b03343d0-a0fe-4d30-bba4-76656842fa3f	SE003E	3	W	f	CV027	f	2022-08-09 15:21:05.091514	2022-08-09 15:21:05.091514
a0b5f48b-982a-4925-8b1d-719ed200abc3	SE003E	3	Z	f	CV027	f	2022-08-09 15:21:05.09695	2022-08-09 15:21:05.09695
03c7c824-da0a-4c3c-9a2a-657f790dc0ff	SE003E	3	A	t	CV118	f	2022-08-09 15:21:05.103574	2022-08-09 15:21:05.103574
6c4a1eb3-1763-4482-9e0a-945f6b6d725c	SE003E	3	D	t	CV118	f	2022-08-09 15:21:05.109117	2022-08-09 15:21:05.109117
f36edcd8-1229-40a3-9a47-5e95fe402f7f	SE003E	3	I	t	CV118	f	2022-08-09 15:21:05.114616	2022-08-09 15:21:05.114616
35b22f9c-e2a0-4ddd-ace0-896eeb63217b	SE003E	3	W	t	CV118	f	2022-08-09 15:21:05.120331	2022-08-09 15:21:05.120331
736ee3f0-a1cf-466e-b267-e26c02ec7c76	SE003E	3	Z	t	CV118	f	2022-08-09 15:21:05.126118	2022-08-09 15:21:05.126118
5e2e168f-fa5f-4cbe-9761-70921984b403	SE003E	3	A	f	CV118	f	2022-08-09 15:21:05.13162	2022-08-09 15:21:05.13162
10b5d967-9c60-425d-a8be-fe0d8579c77d	SE003E	3	D	f	CV118	f	2022-08-09 15:21:05.137162	2022-08-09 15:21:05.137162
fc5897ea-4bde-4601-9128-5c74ebbc60ff	SE003E	3	I	f	CV118	f	2022-08-09 15:21:05.142631	2022-08-09 15:21:05.142631
99ff6cd9-3048-4ba0-a27d-e3fa2e4b8388	SE003E	3	W	f	CV118	f	2022-08-09 15:21:05.148205	2022-08-09 15:21:05.148205
1fe53532-89ca-44a1-a8f0-a4a2a2a59d69	SE003E	3	Z	f	CV118	f	2022-08-09 15:21:05.153398	2022-08-09 15:21:05.153398
0cf3bf2d-1cae-4201-9402-f07f69d4fb22	SE003E	3	A	t	EF012	f	2022-08-09 15:21:05.15897	2022-08-09 15:21:05.15897
2f73e0a0-4400-459d-bab5-b80dbbbe3a9c	SE003E	3	D	t	EF012	f	2022-08-09 15:21:05.164238	2022-08-09 15:21:05.164238
8ddbd1d2-c7bb-40c4-8f94-6f1b10f93e45	SE003E	3	I	t	EF012	f	2022-08-09 15:21:05.169824	2022-08-09 15:21:05.169824
aaa97379-975e-4be6-ba4b-f0e25683565d	SE003E	3	W	t	EF012	f	2022-08-09 15:21:05.176255	2022-08-09 15:21:05.176255
f5317828-fa39-4629-85b1-19e174f6ddcb	SE003E	3	Z	t	EF012	f	2022-08-09 15:21:05.182613	2022-08-09 15:21:05.182613
886fad4f-4491-47ad-8c96-d5559829d44f	SE003E	3	A	f	EF012	f	2022-08-09 15:21:05.188396	2022-08-09 15:21:05.188396
0e78cb33-fc39-4026-a8d8-92349aeecbc8	SE003E	3	D	f	EF012	f	2022-08-09 15:21:05.19493	2022-08-09 15:21:05.19493
2aaeb6a3-9572-426a-ba9f-cc145d1de0f3	SE003E	3	I	f	EF012	f	2022-08-09 15:21:05.200752	2022-08-09 15:21:05.200752
c69fed81-46a0-4968-86e0-6d8b1065cd86	SE003E	3	W	f	EF012	f	2022-08-09 15:21:05.206149	2022-08-09 15:21:05.206149
f583bd86-471c-4c7f-aa96-c0acae314331	SE003E	3	Z	f	EF012	f	2022-08-09 15:21:05.211947	2022-08-09 15:21:05.211947
6cf71a52-0bf7-4fa6-9206-1d95c8034abb	SE003E	3	A	t	EF022	f	2022-08-09 15:21:05.217205	2022-08-09 15:21:05.217205
57d8ce20-df09-45d6-98fa-562ef05b6ca7	SE003E	3	D	t	EF022	f	2022-08-09 15:21:05.222772	2022-08-09 15:21:05.222772
455d7ce8-eba9-445d-87d2-12fcd77d4e7b	SE003E	3	I	t	EF022	f	2022-08-09 15:21:05.228641	2022-08-09 15:21:05.228641
8476b8e7-ad87-402e-90df-19f2d2c9799a	SE003E	3	W	t	EF022	f	2022-08-09 15:21:05.234132	2022-08-09 15:21:05.234132
8847ddb2-2d8a-4c88-87a3-8bab498d950f	SE003E	3	Z	t	EF022	f	2022-08-09 15:21:05.239903	2022-08-09 15:21:05.239903
b8bd876a-6efe-4cff-ae3d-3170d19f559c	SE003E	3	A	f	EF022	f	2022-08-09 15:21:05.245363	2022-08-09 15:21:05.245363
54cd38ee-ace5-4f13-9a79-6cda1a95f2e4	SE003E	3	D	f	EF022	f	2022-08-09 15:21:05.251295	2022-08-09 15:21:05.251295
9bb964da-c8f9-4fb6-a30a-ee1d5d573403	SE003E	3	I	f	EF022	f	2022-08-09 15:21:05.256501	2022-08-09 15:21:05.256501
daf0bfb1-cbef-4ce3-83a2-9c51acc83abb	SE003E	3	W	f	EF022	f	2022-08-09 15:21:05.262277	2022-08-09 15:21:05.262277
2cf5629b-a8b8-4c0d-8fa5-5544c3e7ad55	SE003E	3	Z	f	EF022	f	2022-08-09 15:21:05.267605	2022-08-09 15:21:05.267605
331b1bea-e4aa-4f72-bf2f-e33f617eb6fd	SE003E	3	A	t	EF025	f	2022-08-09 15:21:05.27285	2022-08-09 15:21:05.27285
afb4057e-fb72-4de4-9a99-49b2a49043ad	SE003E	3	D	t	EF025	f	2022-08-09 15:21:05.278411	2022-08-09 15:21:05.278411
5a2e26a6-3516-453a-aead-53e024ac2f49	SE003E	3	I	t	EF025	f	2022-08-09 15:21:05.283677	2022-08-09 15:21:05.283677
e0df19f5-596a-47a0-96cd-2d9981bad11b	SE003E	3	W	t	EF025	f	2022-08-09 15:21:05.289255	2022-08-09 15:21:05.289255
78e5f8a7-01f6-4028-93c6-9e9928aceb53	SE003E	3	Z	t	EF025	f	2022-08-09 15:21:05.294613	2022-08-09 15:21:05.294613
d36859b1-6c3f-4fac-bd85-2a5a5abd468a	SE003E	3	A	f	EF025	f	2022-08-09 15:21:05.300187	2022-08-09 15:21:05.300187
022c0260-6567-46f9-8ffb-c37279a2481c	SE003E	3	D	f	EF025	f	2022-08-09 15:21:05.30555	2022-08-09 15:21:05.30555
c1432638-eb18-4b27-8689-75036e9e7f33	SE003E	3	I	f	EF025	f	2022-08-09 15:21:05.310912	2022-08-09 15:21:05.310912
b1551670-4038-48fc-a521-70df752510af	SE003E	3	W	f	EF025	f	2022-08-09 15:21:05.316711	2022-08-09 15:21:05.316711
5f0bdb35-268b-41e4-b689-602025a72e5c	SE003E	3	Z	f	EF025	f	2022-08-09 15:21:05.322264	2022-08-09 15:21:05.322264
09e754a0-fffb-4ab9-8869-90dab80457aa	SE003E	3	A	t	EF026	f	2022-08-09 15:21:05.327897	2022-08-09 15:21:05.327897
eeb2c8b1-8dad-4c14-bd2a-2e50d0c0447b	SE003E	3	D	t	EF026	f	2022-08-09 15:21:05.333627	2022-08-09 15:21:05.333627
96b3560a-1543-4adb-ac18-33795651c5de	SE003E	3	I	t	EF026	f	2022-08-09 15:21:05.338932	2022-08-09 15:21:05.338932
72e4941f-f763-4b44-a599-20a4a21e03cb	SE003E	3	W	t	EF026	f	2022-08-09 15:21:05.344907	2022-08-09 15:21:05.344907
36282741-629b-479b-a15c-2a9dfef24fd2	SE003E	3	Z	t	EF026	f	2022-08-09 15:21:05.351793	2022-08-09 15:21:05.351793
e5a24620-7c0a-4af0-928e-209fccb23e22	SE003E	3	A	f	EF026	f	2022-08-09 15:21:05.358032	2022-08-09 15:21:05.358032
4b25ca55-7740-4182-b06e-a25bbee62c63	SE003E	3	D	f	EF026	f	2022-08-09 15:21:05.363992	2022-08-09 15:21:05.363992
ef65ebb9-40ff-4d6e-a39a-efa6a87456ca	SE003E	3	I	f	EF026	f	2022-08-09 15:21:05.370493	2022-08-09 15:21:05.370493
2d413a82-4157-4f7e-bccc-0aa3459af855	SE003E	3	W	f	EF026	f	2022-08-09 15:21:05.37664	2022-08-09 15:21:05.37664
e087e33a-99ef-4426-b5f0-3abf90c741c3	SE003E	3	Z	f	EF026	f	2022-08-09 15:21:05.382929	2022-08-09 15:21:05.382929
cca37eb8-25d1-496a-afcd-d933ef1fc095	SE003E	3	A	t	EF027	f	2022-08-09 15:21:05.389247	2022-08-09 15:21:05.389247
d0dd35b5-e940-4914-bf34-5d408bf33ad9	SE003E	3	D	t	EF027	f	2022-08-09 15:21:05.395816	2022-08-09 15:21:05.395816
a7dd60fb-9e7a-40e2-8c41-7991b66a39cc	SE003E	3	I	t	EF027	f	2022-08-09 15:21:05.402465	2022-08-09 15:21:05.402465
2c4a2f8a-3e8e-4829-bc22-cc134127efd4	SE003E	3	W	t	EF027	f	2022-08-09 15:21:05.409623	2022-08-09 15:21:05.409623
7bb43fe5-38a3-4bdc-ad18-437a648e8fd3	SE003E	3	Z	t	EF027	f	2022-08-09 15:21:05.416448	2022-08-09 15:21:05.416448
de07580e-ce91-4b95-9b5e-7375fb92e957	SE003E	3	A	f	EF027	f	2022-08-09 15:21:05.422192	2022-08-09 15:21:05.422192
cad0fa7a-6f39-46ad-9f5f-e71ddddfd71c	SE003E	3	D	f	EF027	f	2022-08-09 15:21:05.42787	2022-08-09 15:21:05.42787
a2fb00ef-3b27-4aeb-a64a-02ab6afb42cf	SE003E	3	I	f	EF027	f	2022-08-09 15:21:05.433164	2022-08-09 15:21:05.433164
4aae8ee1-c366-42e2-a96a-c2b9af5a8b75	SE003E	3	W	f	EF027	f	2022-08-09 15:21:05.43849	2022-08-09 15:21:05.43849
45169f5f-9712-47e0-97d4-3c5a8513e38d	SE003E	3	Z	f	EF027	f	2022-08-09 15:21:05.444301	2022-08-09 15:21:05.444301
77c4d8d1-c25c-48c6-875d-50c1090dca39	SE003E	3	A	t	FM049	f	2022-08-09 15:21:05.505489	2022-08-09 15:21:05.505489
9f325da1-0027-4301-9a94-cfba073b1e39	SE003E	3	D	t	FM049	f	2022-08-09 15:21:05.511223	2022-08-09 15:21:05.511223
a6b99226-36b8-4bc9-bbce-1c7216734a60	SE003E	3	I	t	FM049	f	2022-08-09 15:21:05.516562	2022-08-09 15:21:05.516562
67ed8c71-ea14-4866-908a-8b4f15a498f3	SE003E	3	W	t	FM049	f	2022-08-09 15:21:05.52335	2022-08-09 15:21:05.52335
47acd6c2-aad0-4a37-a942-e68cf03ebe84	SE003E	3	Z	t	FM049	f	2022-08-09 15:21:05.529075	2022-08-09 15:21:05.529075
895df859-15e7-436d-9adf-85090263cc9e	SE003E	3	A	f	FM049	f	2022-08-09 15:21:05.535083	2022-08-09 15:21:05.535083
c035a081-85fe-4a62-8511-19964f772c2a	SE003E	3	D	f	FM049	f	2022-08-09 15:21:05.540801	2022-08-09 15:21:05.540801
549b335c-cd18-4ae8-a6a1-c10ae1a8d7fd	SE003E	3	I	f	FM049	f	2022-08-09 15:21:05.546437	2022-08-09 15:21:05.546437
88741a04-da6a-4867-a588-af307006f399	SE003E	3	W	f	FM049	f	2022-08-09 15:21:05.552534	2022-08-09 15:21:05.552534
5cfe4086-7acd-4b1b-aec9-832309018931	SE003E	3	Z	f	FM049	f	2022-08-09 15:21:05.558643	2022-08-09 15:21:05.558643
08e6c191-c5a3-4f51-9469-1f9be28404ea	SE003E	3	A	t	MC029	f	2022-08-09 15:21:05.564334	2022-08-09 15:21:05.564334
877f87ef-e35c-476f-b77a-95bf9f04da11	SE003E	3	D	t	MC029	f	2022-08-09 15:21:05.56979	2022-08-09 15:21:05.56979
dcb12908-06e8-4d45-aeea-0906b2f68744	SE003E	3	I	t	MC029	f	2022-08-09 15:21:05.575542	2022-08-09 15:21:05.575542
3e670054-8897-496b-bd1b-0c95d323fd38	SE003E	3	W	t	MC029	f	2022-08-09 15:21:05.581231	2022-08-09 15:21:05.581231
f5b66b17-b1e2-4546-a7cb-6a230ed18069	SE003E	3	Z	t	MC029	f	2022-08-09 15:21:05.586867	2022-08-09 15:21:05.586867
4cd60e8c-01d7-4f0d-9bb4-b07450e653c4	SE003E	3	A	f	MC029	f	2022-08-09 15:21:05.592185	2022-08-09 15:21:05.592185
db556753-8159-4b42-b415-14fde9e5c918	SE003E	3	D	f	MC029	f	2022-08-09 15:21:05.597544	2022-08-09 15:21:05.597544
0630deb5-22c9-412a-a435-08174f9b0bd3	SE003E	3	I	f	MC029	f	2022-08-09 15:21:05.603193	2022-08-09 15:21:05.603193
1c4ad76a-0821-42b0-b1f3-7281d2ca8216	SE003E	3	W	f	MC029	f	2022-08-09 15:21:05.608578	2022-08-09 15:21:05.608578
f7b96825-61ac-48c9-89cf-df7274345e3a	SE003E	3	Z	f	MC029	f	2022-08-09 15:21:05.614098	2022-08-09 15:21:05.614098
abf70dcb-784c-4f11-9075-dedc67c41f76	SE003E	3	A	f	FM019	t	2022-08-09 15:21:05.477625	2022-08-09 15:21:05.621762
51b5eeb2-4c41-4a3f-9acc-0a79024ce087	SE003E	3	D	f	FM019	t	2022-08-09 15:21:05.48305	2022-08-09 15:21:05.628815
ec2dcbf5-2aba-4cfb-a32a-9efcd0e3346d	SE003E	3	I	f	FM019	t	2022-08-09 15:21:05.488873	2022-08-09 15:21:05.636251
39fab1c6-44be-4746-877e-7622b155bfed	SE003E	3	W	f	FM019	t	2022-08-09 15:21:05.494108	2022-08-09 15:21:05.64362
d6c2700a-3603-46f0-9b7c-362b292fc313	SE003E	3	Z	f	FM019	t	2022-08-09 15:21:05.500007	2022-08-09 15:21:05.651029
72830347-ace5-488e-a43e-951f5e7efabc	SE003E	3	A	t	FM019	t	2022-08-09 15:21:05.44997	2022-08-09 15:21:05.658015
09be277d-456d-46a2-a31c-f9471d97975a	SE003E	3	D	t	FM019	t	2022-08-09 15:21:05.455533	2022-08-09 15:21:05.665614
c0cf068a-c786-48e2-9a24-ecc9ef8a9d51	SE003E	3	I	t	FM019	t	2022-08-09 15:21:05.461195	2022-08-09 15:21:05.672787
9dac3e98-09ea-41f9-9f79-d1fecb2f79ef	SE003E	3	W	t	FM019	t	2022-08-09 15:21:05.466491	2022-08-09 15:21:05.679911
0456b020-776d-433d-9344-584f469ae299	SE003E	3	Z	t	FM019	t	2022-08-09 15:21:05.472154	2022-08-09 15:21:05.687174
a2c27040-25be-4896-a5fe-844bd21e822f	SE004E	3	A	t	CV027	f	2022-08-09 15:21:05.692541	2022-08-09 15:21:05.692541
06532832-edca-423f-9628-f1c5052d378c	SE004E	3	D	t	CV027	f	2022-08-09 15:21:05.698027	2022-08-09 15:21:05.698027
d2626e13-76cd-4c9a-a794-f7fa4b8e8b04	SE004E	3	I	t	CV027	f	2022-08-09 15:21:05.70382	2022-08-09 15:21:05.70382
2023bffa-745c-499d-aa5e-22eba6dfa210	SE004E	3	W	t	CV027	f	2022-08-09 15:21:05.709542	2022-08-09 15:21:05.709542
68cbfd74-0b6d-438d-85d6-342a580959bb	SE004E	3	Z	t	CV027	f	2022-08-09 15:21:05.715248	2022-08-09 15:21:05.715248
8bb5158b-8922-4a77-b44b-0d48303ae908	SE004E	3	A	f	CV027	f	2022-08-09 15:21:05.721094	2022-08-09 15:21:05.721094
1df96f5a-b0af-473a-9166-b3b05c645314	SE004E	3	D	f	CV027	f	2022-08-09 15:21:05.726678	2022-08-09 15:21:05.726678
78a2f8b1-f2e1-450c-b5f4-652222b89930	SE004E	3	I	f	CV027	f	2022-08-09 15:21:05.732756	2022-08-09 15:21:05.732756
4f0ad2bb-893e-438b-b52d-766f979d5a18	SE004E	3	W	f	CV027	f	2022-08-09 15:21:05.738373	2022-08-09 15:21:05.738373
b71b3b60-f036-4762-93fc-a08164b69316	SE004E	3	Z	f	CV027	f	2022-08-09 15:21:05.74377	2022-08-09 15:21:05.74377
1b43a9a8-7974-4015-aa74-f254e0af2a99	SE004E	3	A	t	CV118	f	2022-08-09 15:21:05.749648	2022-08-09 15:21:05.749648
7c3db9c5-0421-4bc8-a891-1839164a7118	SE004E	3	D	t	CV118	f	2022-08-09 15:21:05.755069	2022-08-09 15:21:05.755069
9345917a-8a2d-40a2-9ce9-1e841814845d	SE004E	3	I	t	CV118	f	2022-08-09 15:21:05.760451	2022-08-09 15:21:05.760451
fb720566-d22f-4801-8226-ac0384e61287	SE004E	3	W	t	CV118	f	2022-08-09 15:21:05.766077	2022-08-09 15:21:05.766077
d20d5fc3-d2e7-4c6b-a6d9-1e49ed44f30b	SE004E	3	Z	t	CV118	f	2022-08-09 15:21:05.771453	2022-08-09 15:21:05.771453
9cd78d9a-6062-4759-bbba-5780267e1ef3	SE004E	3	A	f	CV118	f	2022-08-09 15:21:05.776752	2022-08-09 15:21:05.776752
d0a8241f-939b-4ac0-990a-10990c79824d	SE004E	3	D	f	CV118	f	2022-08-09 15:21:05.78244	2022-08-09 15:21:05.78244
422d21f8-95df-45d6-8187-de78a7ff6796	SE004E	3	I	f	CV118	f	2022-08-09 15:21:05.787919	2022-08-09 15:21:05.787919
80e31762-f31f-439b-ad7c-df3bfd42eca4	SE004E	3	W	f	CV118	f	2022-08-09 15:21:05.793641	2022-08-09 15:21:05.793641
c0e7432d-9c78-4151-83e6-2553802d1b56	SE004E	3	Z	f	CV118	f	2022-08-09 15:21:05.798937	2022-08-09 15:21:05.798937
5d0d442e-fd0a-4d71-bfb8-87bbef063017	SE004E	3	A	t	EF012	f	2022-08-09 15:21:05.804295	2022-08-09 15:21:05.804295
473fb8e5-c428-4350-aa07-3d8b5edcaeff	SE004E	3	D	t	EF012	f	2022-08-09 15:21:05.810263	2022-08-09 15:21:05.810263
0ca89793-ba22-479d-8d08-e190f5b6b4f4	SE004E	3	I	t	EF012	f	2022-08-09 15:21:05.815701	2022-08-09 15:21:05.815701
6811b5dc-1b13-437a-9a69-e1efe580a461	SE004E	3	W	t	EF012	f	2022-08-09 15:21:05.821364	2022-08-09 15:21:05.821364
da1c2af0-5951-4532-b168-4b00b2f0a1ef	SE004E	3	Z	t	EF012	f	2022-08-09 15:21:05.826738	2022-08-09 15:21:05.826738
e7fc475d-b946-44ae-831e-1dc0811bbe2b	SE004E	3	A	f	EF012	f	2022-08-09 15:21:05.832554	2022-08-09 15:21:05.832554
2cd5d9b7-9c28-4a8e-a29f-d7254d32c72c	SE004E	3	D	f	EF012	f	2022-08-09 15:21:05.838099	2022-08-09 15:21:05.838099
22610a77-6968-49e7-b643-d6e8710834ec	SE004E	3	I	f	EF012	f	2022-08-09 15:21:05.843718	2022-08-09 15:21:05.843718
b8aad078-d4f7-497d-b366-b1026948646a	SE004E	3	W	f	EF012	f	2022-08-09 15:21:05.850503	2022-08-09 15:21:05.850503
fc729893-6aa0-4452-b5e1-e4fa13f0bd22	SE004E	3	Z	f	EF012	f	2022-08-09 15:21:05.856937	2022-08-09 15:21:05.856937
969bf097-58b1-4bf0-b159-177a69b45df1	SE004E	3	A	t	EF022	f	2022-08-09 15:21:05.862632	2022-08-09 15:21:05.862632
2897c56b-f4d7-4773-a8a0-d93268fae739	SE004E	3	D	t	EF022	f	2022-08-09 15:21:05.868519	2022-08-09 15:21:05.868519
bdc0d668-992b-48a2-b2be-a19da05cc6cd	SE004E	3	I	t	EF022	f	2022-08-09 15:21:05.873957	2022-08-09 15:21:05.873957
749141c4-f8dd-421a-8821-fb033b5643e2	SE004E	3	W	t	EF022	f	2022-08-09 15:21:05.880585	2022-08-09 15:21:05.880585
118865fd-d0f2-4656-9cc6-41a27e78e321	SE004E	3	Z	t	EF022	f	2022-08-09 15:21:05.886492	2022-08-09 15:21:05.886492
bee9bf38-a984-48f4-b111-69369527888a	SE004E	3	A	f	EF022	f	2022-08-09 15:21:05.892317	2022-08-09 15:21:05.892317
2c607a86-8133-4721-8843-9b47737697f7	SE004E	3	D	f	EF022	f	2022-08-09 15:21:05.898097	2022-08-09 15:21:05.898097
da3de9d4-d3b1-4c3d-a001-38c28b2030b7	SE004E	3	I	f	EF022	f	2022-08-09 15:21:05.903808	2022-08-09 15:21:05.903808
efe79c1c-230c-4dcf-809c-7aae8d2892c8	SE004E	3	W	f	EF022	f	2022-08-09 15:21:05.910622	2022-08-09 15:21:05.910622
b024081b-92c1-4b7d-8305-33a4e8a73ce2	SE004E	3	Z	f	EF022	f	2022-08-09 15:21:05.91648	2022-08-09 15:21:05.91648
45f781a4-6a32-4500-964e-0bba393f1105	SE004E	3	A	t	EF025	f	2022-08-09 15:21:05.921732	2022-08-09 15:21:05.921732
da53b8b7-f57b-4516-98a3-7590b7fe9457	SE004E	3	D	t	EF025	f	2022-08-09 15:21:05.927441	2022-08-09 15:21:05.927441
6763a807-93cb-4400-8c09-d1e07668465b	SE004E	3	I	t	EF025	f	2022-08-09 15:21:05.933085	2022-08-09 15:21:05.933085
a244a4e3-9a3e-4f9f-92ee-14522823a9c8	SE004E	3	W	t	EF025	f	2022-08-09 15:21:05.939094	2022-08-09 15:21:05.939094
5ebe03e1-a12f-4c7d-99d7-27a042035d7c	SE004E	3	Z	t	EF025	f	2022-08-09 15:21:05.944909	2022-08-09 15:21:05.944909
41748ebc-3b89-429c-aa0c-8e9af3f702c4	SE004E	3	A	f	EF025	f	2022-08-09 15:21:05.951464	2022-08-09 15:21:05.951464
464313e4-b317-4c31-b07d-0d1f5bc281d0	SE004E	3	D	f	EF025	f	2022-08-09 15:21:05.957744	2022-08-09 15:21:05.957744
a60ccc3e-7268-4d8c-896e-702c92f21790	SE004E	3	I	f	EF025	f	2022-08-09 15:21:05.963145	2022-08-09 15:21:05.963145
c40293ee-7310-4b03-a50d-26104e76a29e	SE004E	3	W	f	EF025	f	2022-08-09 15:21:05.968929	2022-08-09 15:21:05.968929
77a91132-5538-46f4-ad3f-1fca61653109	SE004E	3	Z	f	EF025	f	2022-08-09 15:21:05.974329	2022-08-09 15:21:05.974329
0e46e736-c968-474a-8a1d-a475ef660e0d	SE004E	3	A	t	EF026	f	2022-08-09 15:21:05.980508	2022-08-09 15:21:05.980508
ee4842db-6889-477a-bd84-2579e29fcbb2	SE004E	3	D	t	EF026	f	2022-08-09 15:21:05.986209	2022-08-09 15:21:05.986209
019cfb5d-4e07-44f8-93ac-4f544fd51d3b	SE004E	3	I	t	EF026	f	2022-08-09 15:21:05.992032	2022-08-09 15:21:05.992032
635fa381-4a5f-4c24-bb3f-f5c32a04895a	SE004E	3	W	t	EF026	f	2022-08-09 15:21:05.997895	2022-08-09 15:21:05.997895
49c53926-3f66-464f-adf7-208811db9ae8	SE004E	3	Z	t	EF026	f	2022-08-09 15:21:06.003183	2022-08-09 15:21:06.003183
b9a7a7f9-f12d-4f5d-8699-889dce32ed04	SE004E	3	A	f	EF026	f	2022-08-09 15:21:06.008807	2022-08-09 15:21:06.008807
5bc85d1a-30dd-4ce7-b282-3d735ce11380	SE004E	3	D	f	EF026	f	2022-08-09 15:21:06.014421	2022-08-09 15:21:06.014421
087af789-d92d-43a7-8c9f-13d03fee226c	SE004E	3	I	f	EF026	f	2022-08-09 15:21:06.020073	2022-08-09 15:21:06.020073
0ed57b92-07b7-46d3-b20a-5a598ecd46d6	SE004E	3	W	f	EF026	f	2022-08-09 15:21:06.025656	2022-08-09 15:21:06.025656
bffb30bd-f40a-4594-9ecb-acfdd3b5af48	SE004E	3	Z	f	EF026	f	2022-08-09 15:21:06.031089	2022-08-09 15:21:06.031089
a14370a0-24b6-4752-9d68-69f1f3105fa3	SE004E	3	A	t	EF027	f	2022-08-09 15:21:06.036492	2022-08-09 15:21:06.036492
378040c8-6ab5-4f7b-9b30-ffcfd8c8ee0d	SE004E	3	D	t	EF027	f	2022-08-09 15:21:06.042142	2022-08-09 15:21:06.042142
c8efcd72-5a41-49c1-aad5-d6c7721ba377	SE004E	3	I	t	EF027	f	2022-08-09 15:21:06.047446	2022-08-09 15:21:06.047446
36e32862-bafd-445e-aed5-b66c54232170	SE004E	3	W	t	EF027	f	2022-08-09 15:21:06.052977	2022-08-09 15:21:06.052977
89a8adce-e4d0-4cca-89f7-e288b2e52aa7	SE004E	3	Z	t	EF027	f	2022-08-09 15:21:06.058493	2022-08-09 15:21:06.058493
06913480-a1ba-4ceb-ac4e-f5a14ea3df03	SE004E	3	A	f	EF027	f	2022-08-09 15:21:06.063724	2022-08-09 15:21:06.063724
66bcba03-cc2d-48da-aa0f-ec79653148c7	SE004E	3	D	f	EF027	f	2022-08-09 15:21:06.069657	2022-08-09 15:21:06.069657
12699dd4-e457-4f5a-abdf-69a56c03f0c2	SE004E	3	I	f	EF027	f	2022-08-09 15:21:06.074995	2022-08-09 15:21:06.074995
e0c71eeb-5fe1-4535-a7d7-f12357ef725d	SE004E	3	W	f	EF027	f	2022-08-09 15:21:06.081048	2022-08-09 15:21:06.081048
24a5c313-f95c-4f6f-947a-83b6b8681958	SE004E	3	Z	f	EF027	f	2022-08-09 15:21:06.0881	2022-08-09 15:21:06.0881
55aad27c-b3df-45e9-8150-a0ec9c8ceade	SE004E	3	A	t	FM049	f	2022-08-09 15:21:06.151857	2022-08-09 15:21:06.151857
85ae539e-9e85-4104-b6b1-165baec11e65	SE004E	3	D	t	FM049	f	2022-08-09 15:21:06.157373	2022-08-09 15:21:06.157373
1b7ab08d-4efb-4ca7-ac3a-7ee40bc1ac6b	SE004E	3	I	t	FM049	f	2022-08-09 15:21:06.162664	2022-08-09 15:21:06.162664
da13aba1-7948-40e4-9959-d8892004115e	SE004E	3	W	t	FM049	f	2022-08-09 15:21:06.168343	2022-08-09 15:21:06.168343
6bb918f4-990c-4b50-99e5-8d207ab69ba6	SE004E	3	Z	t	FM049	f	2022-08-09 15:21:06.173922	2022-08-09 15:21:06.173922
c5e5fae4-42a3-4616-a778-ccc890cbb62d	SE004E	3	A	f	FM049	f	2022-08-09 15:21:06.179901	2022-08-09 15:21:06.179901
0367b869-688a-4c5a-b66f-58d98b13a1dd	SE004E	3	D	f	FM049	f	2022-08-09 15:21:06.187328	2022-08-09 15:21:06.187328
a26d04e8-f47f-4d87-b219-1a18be6159c9	SE004E	3	I	f	FM049	f	2022-08-09 15:21:06.193028	2022-08-09 15:21:06.193028
4fbe3775-6ef0-4d9b-ad4c-69556198b6a2	SE004E	3	W	f	FM049	f	2022-08-09 15:21:06.198383	2022-08-09 15:21:06.198383
102bad80-daa1-4c8a-adc0-eee52ea20a17	SE004E	3	Z	f	FM049	f	2022-08-09 15:21:06.203929	2022-08-09 15:21:06.203929
79a48797-d5f0-42c4-bc68-81d29317c7df	SE004E	3	A	t	MC029	f	2022-08-09 15:21:06.209303	2022-08-09 15:21:06.209303
f2d9757d-3af9-4aae-a276-2f242a85e322	SE004E	3	D	t	MC029	f	2022-08-09 15:21:06.214931	2022-08-09 15:21:06.214931
2c269a6b-a7d9-42df-ac64-b7a7a752fb56	SE004E	3	I	t	MC029	f	2022-08-09 15:21:06.220257	2022-08-09 15:21:06.220257
4608ba5c-0b3b-4402-a315-3465e17f6062	SE004E	3	W	t	MC029	f	2022-08-09 15:21:06.225707	2022-08-09 15:21:06.225707
9c279c0b-55d1-4d82-b564-68b7567ff3af	SE004E	3	Z	t	MC029	f	2022-08-09 15:21:06.231285	2022-08-09 15:21:06.231285
80579a71-13b6-4a50-a5ae-7cb6bc660c22	SE004E	3	A	f	MC029	f	2022-08-09 15:21:06.236803	2022-08-09 15:21:06.236803
e80d2b40-4d21-4232-8dfe-5626e9ec7bed	SE004E	3	D	f	MC029	f	2022-08-09 15:21:06.24217	2022-08-09 15:21:06.24217
04c2f6b0-e81b-4926-9311-6dba7ff66954	SE004E	3	I	f	MC029	f	2022-08-09 15:21:06.247976	2022-08-09 15:21:06.247976
dbbf8d1e-53a8-4ac0-a79d-67c4346c410d	SE004E	3	W	f	MC029	f	2022-08-09 15:21:06.253391	2022-08-09 15:21:06.253391
b3f6885b-7fdf-429d-b318-3bb75a292543	SE004E	3	Z	f	MC029	f	2022-08-09 15:21:06.259042	2022-08-09 15:21:06.259042
e14055e9-5c5d-487b-9ea1-7359038ac2ed	SE004E	3	A	f	FM019	t	2022-08-09 15:21:06.122983	2022-08-09 15:21:06.26636
65c02474-8286-4054-be70-6e476bb979a3	SE004E	3	D	f	FM019	t	2022-08-09 15:21:06.129213	2022-08-09 15:21:06.2736
81c39e89-432c-474a-bebd-aa6071958468	SE004E	3	I	f	FM019	t	2022-08-09 15:21:06.135298	2022-08-09 15:21:06.280602
51eab593-8a14-4716-921d-42dfd6249ec2	SE004E	3	W	f	FM019	t	2022-08-09 15:21:06.140746	2022-08-09 15:21:06.287847
2747c488-dd1c-4dd6-bbc2-1d15b13ddc87	SE004E	3	Z	f	FM019	t	2022-08-09 15:21:06.14658	2022-08-09 15:21:06.295245
17b189c1-09c7-40d4-b753-98202f1081ad	SE004E	3	A	t	FM019	t	2022-08-09 15:21:06.093553	2022-08-09 15:21:06.302648
c5cb0a51-abdf-4b1e-a398-ec9c32fa2ec7	SE004E	3	D	t	FM019	t	2022-08-09 15:21:06.099309	2022-08-09 15:21:06.309577
2190be25-d915-4554-b61a-57527b3447da	SE004E	3	I	t	FM019	t	2022-08-09 15:21:06.104958	2022-08-09 15:21:06.317071
d9b070fc-26d3-4814-ab06-00b015141251	SE004E	3	W	t	FM019	t	2022-08-09 15:21:06.110422	2022-08-09 15:21:06.324524
8b947eac-abe4-4ca6-9ec6-d647b5cd861a	SE004E	3	Z	t	FM019	t	2022-08-09 15:21:06.116372	2022-08-09 15:21:06.331981
b4c7010c-7e92-4c5a-8d0c-39c35508b17c	SE007E	3	A	t	CV027	f	2022-08-09 15:21:06.337611	2022-08-09 15:21:06.337611
1961232f-43a3-429e-8c3d-91360731e7ec	SE007E	3	D	t	CV027	f	2022-08-09 15:21:06.34339	2022-08-09 15:21:06.34339
b557b817-e7c9-4884-a640-1198439d7dd4	SE007E	3	I	t	CV027	f	2022-08-09 15:21:06.350209	2022-08-09 15:21:06.350209
0568e2c2-1e15-4414-982e-39b99e0b7632	SE007E	3	W	t	CV027	f	2022-08-09 15:21:06.357254	2022-08-09 15:21:06.357254
fef1cc41-71db-42a1-9ed4-36429f8cac2d	SE007E	3	Z	t	CV027	f	2022-08-09 15:21:06.36315	2022-08-09 15:21:06.36315
c2f6ef54-b08c-451e-93d7-03fdfcbd840c	SE007E	3	A	f	CV027	f	2022-08-09 15:21:06.369686	2022-08-09 15:21:06.369686
a20a66ee-d47c-493b-953b-c3623d39c56d	SE007E	3	D	f	CV027	f	2022-08-09 15:21:06.375537	2022-08-09 15:21:06.375537
7c44d323-ad5f-4917-b9a2-e1b265b76fa8	SE007E	3	I	f	CV027	f	2022-08-09 15:21:06.381569	2022-08-09 15:21:06.381569
94c24d5e-4066-4db5-85f4-9ed18fabdf57	SE007E	3	W	f	CV027	f	2022-08-09 15:21:06.387553	2022-08-09 15:21:06.387553
af092fa8-a051-4ed6-8f99-8d69ecd591c9	SE007E	3	Z	f	CV027	f	2022-08-09 15:21:06.393581	2022-08-09 15:21:06.393581
370047b2-def1-417f-8364-f4086a0b3fdb	SE007E	3	A	t	CV118	f	2022-08-09 15:21:06.399009	2022-08-09 15:21:06.399009
253f69be-8cd0-4af1-99c9-64a3bf7032ac	SE007E	3	D	t	CV118	f	2022-08-09 15:21:06.404479	2022-08-09 15:21:06.404479
12fee4e7-9e15-48e9-bb2e-0ec26dadcb58	SE007E	3	I	t	CV118	f	2022-08-09 15:21:06.410155	2022-08-09 15:21:06.410155
d4e80beb-ff38-4ea9-8dfd-eb0457a17463	SE007E	3	W	t	CV118	f	2022-08-09 15:21:06.4158	2022-08-09 15:21:06.4158
112a0e99-b0d8-4837-aa65-6d754751ceff	SE007E	3	Z	t	CV118	f	2022-08-09 15:21:06.421265	2022-08-09 15:21:06.421265
9df1ff07-079e-449a-8532-fcf198ac3570	SE007E	3	A	f	CV118	f	2022-08-09 15:21:06.427054	2022-08-09 15:21:06.427054
286445a7-388c-4cce-b194-4357540293aa	SE007E	3	D	f	CV118	f	2022-08-09 15:21:06.432316	2022-08-09 15:21:06.432316
19d44ff7-eb33-46b0-bb6e-14dfac477b22	SE007E	3	I	f	CV118	f	2022-08-09 15:21:06.437759	2022-08-09 15:21:06.437759
aa7785a5-b965-4da5-a1b0-99b58fe1db8b	SE007E	3	W	f	CV118	f	2022-08-09 15:21:06.444008	2022-08-09 15:21:06.444008
5b8619a9-df86-4abc-83ab-0712d362469b	SE007E	3	Z	f	CV118	f	2022-08-09 15:21:06.44958	2022-08-09 15:21:06.44958
d84df6cb-7750-43d1-bc1e-fd5e85b907db	SE007E	3	A	t	EF012	f	2022-08-09 15:21:06.455196	2022-08-09 15:21:06.455196
0b5385f5-1098-45aa-aafa-485ea1e593d0	SE007E	3	D	t	EF012	f	2022-08-09 15:21:06.460489	2022-08-09 15:21:06.460489
7b986faf-c8c5-4b25-8b8a-9dd925f1fa8f	SE007E	3	I	t	EF012	f	2022-08-09 15:21:06.466062	2022-08-09 15:21:06.466062
2229d909-cd6b-44f9-ac37-142715f8e507	SE007E	3	W	t	EF012	f	2022-08-09 15:21:06.471981	2022-08-09 15:21:06.471981
748e90ec-67d5-498d-84ec-f14066474539	SE007E	3	Z	t	EF012	f	2022-08-09 15:21:06.47745	2022-08-09 15:21:06.47745
1bae5174-2962-4341-b9cb-56756ffcd808	SE007E	3	A	f	EF012	f	2022-08-09 15:21:06.483066	2022-08-09 15:21:06.483066
7c751824-4bd9-47cb-8d56-e4590e83fbb7	SE007E	3	D	f	EF012	f	2022-08-09 15:21:06.488677	2022-08-09 15:21:06.488677
f867e464-0161-40dc-a2a1-e0f8a081754d	SE007E	3	I	f	EF012	f	2022-08-09 15:21:06.494374	2022-08-09 15:21:06.494374
a73c442c-8abc-4727-a018-1c498a0e3ed0	SE007E	3	W	f	EF012	f	2022-08-09 15:21:06.499775	2022-08-09 15:21:06.499775
6445725e-1780-43da-b776-7a5c8ea60bdd	SE007E	3	Z	f	EF012	f	2022-08-09 15:21:06.505168	2022-08-09 15:21:06.505168
cfd8244b-7366-40ed-833a-3bdf44045c9e	SE007E	3	A	t	EF022	f	2022-08-09 15:21:06.512214	2022-08-09 15:21:06.512214
fe5655fe-a31c-4dea-8b16-089b4b15cdb0	SE007E	3	D	t	EF022	f	2022-08-09 15:21:06.517722	2022-08-09 15:21:06.517722
b3e0e5ff-3b91-4d66-b5bb-c601bc52cbf0	SE007E	3	I	t	EF022	f	2022-08-09 15:21:06.523633	2022-08-09 15:21:06.523633
af0d7d42-b289-49a3-be93-2425d4a8c75f	SE007E	3	W	t	EF022	f	2022-08-09 15:21:06.529586	2022-08-09 15:21:06.529586
6ee16fe2-adbc-453c-adcb-8aab4db4db20	SE007E	3	Z	t	EF022	f	2022-08-09 15:21:06.535091	2022-08-09 15:21:06.535091
9e704786-65f6-4dbc-8922-572360e43d32	SE007E	3	A	f	EF022	f	2022-08-09 15:21:06.540861	2022-08-09 15:21:06.540861
a5add70f-b670-4f2f-b4fc-cea7b7548177	SE007E	3	D	f	EF022	f	2022-08-09 15:21:06.546425	2022-08-09 15:21:06.546425
da90a275-db35-4100-8ff6-63a7ac6b690c	SE007E	3	I	f	EF022	f	2022-08-09 15:21:06.552602	2022-08-09 15:21:06.552602
aaf63bd4-2735-43bb-afe3-e5be99899b2a	SE007E	3	W	f	EF022	f	2022-08-09 15:21:06.558324	2022-08-09 15:21:06.558324
0d56ba09-5f18-4a53-8c53-b2b57e0c3fc8	SE007E	3	Z	f	EF022	f	2022-08-09 15:21:06.56418	2022-08-09 15:21:06.56418
4fb5b17e-3cf9-40a7-a01e-ee76567ac2b6	SE007E	3	A	t	EF025	f	2022-08-09 15:21:06.569577	2022-08-09 15:21:06.569577
2cfbfe28-7d25-4f93-b987-67903c40a9d7	SE007E	3	D	t	EF025	f	2022-08-09 15:21:06.57522	2022-08-09 15:21:06.57522
4d805a4b-0331-4ae9-8d49-5ca86118805b	SE007E	3	I	t	EF025	f	2022-08-09 15:21:06.580598	2022-08-09 15:21:06.580598
e410b098-e57e-4c51-8a90-5e6ffa7c5b01	SE007E	3	W	t	EF025	f	2022-08-09 15:21:06.586483	2022-08-09 15:21:06.586483
c710862c-cc48-40d1-94b6-996ae5458e84	SE007E	3	Z	t	EF025	f	2022-08-09 15:21:06.591773	2022-08-09 15:21:06.591773
889d9092-50e4-4c5d-885b-5dbd82aad49f	SE007E	3	A	f	EF025	f	2022-08-09 15:21:06.597486	2022-08-09 15:21:06.597486
4598634a-58ce-4a87-b4d1-7d11d89e6f83	SE007E	3	D	f	EF025	f	2022-08-09 15:21:06.602886	2022-08-09 15:21:06.602886
5a56e181-0141-4e43-a130-baaa8d0bf69e	SE007E	3	I	f	EF025	f	2022-08-09 15:21:06.608612	2022-08-09 15:21:06.608612
7fdcea77-3355-4c6d-a1a8-7bc966e95274	SE007E	3	W	f	EF025	f	2022-08-09 15:21:06.613947	2022-08-09 15:21:06.613947
799efe00-4fc3-49cc-a2b9-79878a049b8c	SE007E	3	Z	f	EF025	f	2022-08-09 15:21:06.619253	2022-08-09 15:21:06.619253
c2961487-9138-4f98-bc8e-c830d52afdf6	SE007E	3	A	t	EF026	f	2022-08-09 15:21:06.625011	2022-08-09 15:21:06.625011
12d3e510-a515-4135-9024-5f4d52f9fc36	SE007E	3	D	t	EF026	f	2022-08-09 15:21:06.630527	2022-08-09 15:21:06.630527
6e4db2fe-0211-411e-8873-e4f92fef5afb	SE007E	3	I	t	EF026	f	2022-08-09 15:21:06.636167	2022-08-09 15:21:06.636167
72bec8ac-137f-4540-9431-19003be490b0	SE007E	3	W	t	EF026	f	2022-08-09 15:21:06.64195	2022-08-09 15:21:06.64195
7b566c01-5df8-411d-a6c7-baf705a05369	SE007E	3	Z	t	EF026	f	2022-08-09 15:21:06.647191	2022-08-09 15:21:06.647191
6fd770fb-ccff-4a40-a82a-5eee608a42c9	SE007E	3	A	f	EF026	f	2022-08-09 15:21:06.653071	2022-08-09 15:21:06.653071
df250021-3c61-4cd4-a74b-d4a3dfd78db6	SE007E	3	D	f	EF026	f	2022-08-09 15:21:06.658397	2022-08-09 15:21:06.658397
48138978-ffeb-45f3-9c33-367334b7dbed	SE007E	3	I	f	EF026	f	2022-08-09 15:21:06.664071	2022-08-09 15:21:06.664071
58079483-1533-454c-9800-5875f7fb6574	SE007E	3	W	f	EF026	f	2022-08-09 15:21:06.669434	2022-08-09 15:21:06.669434
bb4fb67b-badd-4001-b5e4-e31c16b656c3	SE007E	3	Z	f	EF026	f	2022-08-09 15:21:06.675061	2022-08-09 15:21:06.675061
9398ef07-2f49-4693-98ed-2cb5e186582a	SE007E	3	A	t	EF027	f	2022-08-09 15:21:06.680908	2022-08-09 15:21:06.680908
e2bce8f7-b4a0-4569-8ff9-d37781d06f99	SE007E	3	D	t	EF027	f	2022-08-09 15:21:06.686181	2022-08-09 15:21:06.686181
c5c7abbb-5f49-4fbd-96ad-a5c9f2d8758d	SE007E	3	I	t	EF027	f	2022-08-09 15:21:06.691426	2022-08-09 15:21:06.691426
eb663c03-beaa-4425-9654-9e5f0aa1e2db	SE007E	3	W	t	EF027	f	2022-08-09 15:21:06.696966	2022-08-09 15:21:06.696966
0d043ac2-2d6b-4f48-ada8-995d2d5245d4	SE007E	3	Z	t	EF027	f	2022-08-09 15:21:06.702197	2022-08-09 15:21:06.702197
52205d41-6973-4868-883f-345723fd3c27	SE007E	3	A	f	EF027	f	2022-08-09 15:21:06.707881	2022-08-09 15:21:06.707881
d56731b4-37dd-47a7-8f3e-0b74314c1934	SE007E	3	D	f	EF027	f	2022-08-09 15:21:06.713263	2022-08-09 15:21:06.713263
268b09ec-3fdd-42f2-a058-2c87df63d8a2	SE007E	3	I	f	EF027	f	2022-08-09 15:21:06.718476	2022-08-09 15:21:06.718476
f33c7f8e-296a-4f08-97ed-9d916f34aa68	SE007E	3	W	f	EF027	f	2022-08-09 15:21:06.724188	2022-08-09 15:21:06.724188
926504f7-8ded-4642-8dc5-a958be275fa5	SE007E	3	Z	f	EF027	f	2022-08-09 15:21:06.729882	2022-08-09 15:21:06.729882
5ef7fabd-24cb-4c60-8c09-3da4cd4ed4fa	SE007E	3	A	t	FM049	f	2022-08-09 15:21:06.790205	2022-08-09 15:21:06.790205
16c6cde1-4c7e-44c4-9d43-2264fe361f79	SE007E	3	D	t	FM049	f	2022-08-09 15:21:06.795956	2022-08-09 15:21:06.795956
3e2fac03-ea34-4f1f-86a1-d19d3d4fd3a3	SE007E	3	I	t	FM049	f	2022-08-09 15:21:06.80136	2022-08-09 15:21:06.80136
00f77fd1-686c-458e-b758-40f4caa95984	SE007E	3	W	t	FM049	f	2022-08-09 15:21:06.806868	2022-08-09 15:21:06.806868
6b406d23-ea34-4877-908b-a81b38094ca3	SE007E	3	Z	t	FM049	f	2022-08-09 15:21:06.812362	2022-08-09 15:21:06.812362
9f69c14a-e924-473e-9233-691675c868a6	SE007E	3	A	f	FM049	f	2022-08-09 15:21:06.817937	2022-08-09 15:21:06.817937
395da84a-09dd-4d0c-a16f-0852e33833c8	SE007E	3	D	f	FM049	f	2022-08-09 15:21:06.823171	2022-08-09 15:21:06.823171
6488185e-2ae9-4c0c-95a1-a54d4895b3f8	SE007E	3	I	f	FM049	f	2022-08-09 15:21:06.828549	2022-08-09 15:21:06.828549
05ed2400-e1f4-4d5c-bb57-a79dc9637d21	SE007E	3	W	f	FM049	f	2022-08-09 15:21:06.835656	2022-08-09 15:21:06.835656
db186061-9e7f-4b6b-9ae8-92ef7ff73981	SE007E	3	Z	f	FM049	f	2022-08-09 15:21:06.841715	2022-08-09 15:21:06.841715
c4c4dfb1-00a8-4931-80c0-e3f115f190ad	SE007E	3	A	t	MC029	f	2022-08-09 15:21:06.847495	2022-08-09 15:21:06.847495
31ae1ca2-a3cd-45fd-85fd-0dc1b52b7fa3	SE007E	3	D	t	MC029	f	2022-08-09 15:21:06.853294	2022-08-09 15:21:06.853294
7546d667-c171-4a3f-8e83-4f8812825253	SE007E	3	I	t	MC029	f	2022-08-09 15:21:06.85886	2022-08-09 15:21:06.85886
478844bd-ebe0-4175-ab16-2d2a8f8c3885	SE007E	3	W	t	MC029	f	2022-08-09 15:21:06.864483	2022-08-09 15:21:06.864483
636e47a1-25bb-4731-8b1e-7de6bc74faca	SE007E	3	Z	t	MC029	f	2022-08-09 15:21:06.869948	2022-08-09 15:21:06.869948
98780122-28cd-4e73-a140-9439b0489881	SE007E	3	A	f	MC029	f	2022-08-09 15:21:06.875533	2022-08-09 15:21:06.875533
f50d1b98-c569-481f-bea0-a1d043b81450	SE007E	3	D	f	MC029	f	2022-08-09 15:21:06.881102	2022-08-09 15:21:06.881102
032d1f4b-c0c9-44ee-baaf-44ef1c1ec101	SE007E	3	I	f	MC029	f	2022-08-09 15:21:06.886835	2022-08-09 15:21:06.886835
7e5b3891-5210-45cf-ab93-34eb06ccf2a1	SE007E	3	W	f	MC029	f	2022-08-09 15:21:06.892369	2022-08-09 15:21:06.892369
542be215-b6c6-4e7c-aed3-d1ca5215ff91	SE007E	3	Z	f	MC029	f	2022-08-09 15:21:06.898067	2022-08-09 15:21:06.898067
92a88fec-42f3-4ca0-9389-c73768b03931	SE007E	3	A	f	FM019	t	2022-08-09 15:21:06.762463	2022-08-09 15:21:06.905453
854ee6c1-a08f-4dff-9e1e-8b136afcb1f2	SE007E	3	D	f	FM019	t	2022-08-09 15:21:06.768079	2022-08-09 15:21:06.912779
076acbb4-8527-41c0-95a9-cc4c20191872	SE007E	3	I	f	FM019	t	2022-08-09 15:21:06.773494	2022-08-09 15:21:06.919623
2fb63992-dee5-4e68-a3c3-775ee8a140ac	SE007E	3	W	f	FM019	t	2022-08-09 15:21:06.778955	2022-08-09 15:21:06.926698
644539ae-7adb-4c6e-8a5c-59c3e3be25ae	SE007E	3	Z	f	FM019	t	2022-08-09 15:21:06.784699	2022-08-09 15:21:06.933787
38229a0b-e22d-4290-8f5d-42f0054d6787	SE007E	3	A	t	FM019	t	2022-08-09 15:21:06.735315	2022-08-09 15:21:06.940899
94a42a41-c881-49f2-8adc-423571e78963	SE007E	3	D	t	FM019	t	2022-08-09 15:21:06.740947	2022-08-09 15:21:06.947794
c0e6a916-d2d0-4b07-9831-39f2de7cc182	SE007E	3	I	t	FM019	t	2022-08-09 15:21:06.746263	2022-08-09 15:21:06.955489
984335f5-698e-457e-bf3f-2c059ae6ac33	SE007E	3	W	t	FM019	t	2022-08-09 15:21:06.75161	2022-08-09 15:21:06.962813
7966c62e-f2c7-47f3-bb5e-a8694eead7fd	SE007E	3	Z	t	FM019	t	2022-08-09 15:21:06.757078	2022-08-09 15:21:06.969955
8c341ba3-3b7f-446d-acb6-e3d390bad8a5	SE008E	3	A	t	CV027	f	2022-08-09 15:21:06.975401	2022-08-09 15:21:06.975401
be5b1837-4c10-4fe0-9f36-c307d1d63343	SE008E	3	D	t	CV027	f	2022-08-09 15:21:06.981442	2022-08-09 15:21:06.981442
a9fb7971-90b0-4cc8-b84e-c2cdba0343e2	SE008E	3	I	t	CV027	f	2022-08-09 15:21:06.987214	2022-08-09 15:21:06.987214
b3320efe-0a43-4bab-a8de-17e4ee6f696b	SE008E	3	W	t	CV027	f	2022-08-09 15:21:06.992811	2022-08-09 15:21:06.992811
a1563dfc-f77a-4fbd-84c4-d4a50ee3f6e8	SE008E	3	Z	t	CV027	f	2022-08-09 15:21:06.998678	2022-08-09 15:21:06.998678
1acb79b2-de94-4cab-9406-bd967a0094c2	SE008E	3	A	f	CV027	f	2022-08-09 15:21:07.004089	2022-08-09 15:21:07.004089
673a5102-3563-4bb1-adb6-ac0a9a596b61	SE008E	3	D	f	CV027	f	2022-08-09 15:21:07.009396	2022-08-09 15:21:07.009396
acb63d7b-6234-404c-afdd-c0be3c7e5bb3	SE008E	3	I	f	CV027	f	2022-08-09 15:21:07.014902	2022-08-09 15:21:07.014902
e366cae2-0576-4e0f-b119-33505afb3160	SE008E	3	W	f	CV027	f	2022-08-09 15:21:07.020335	2022-08-09 15:21:07.020335
5572752f-6d08-4068-b081-2c20aaa30e4d	SE008E	3	Z	f	CV027	f	2022-08-09 15:21:07.025989	2022-08-09 15:21:07.025989
cd92abcc-76a6-4c0a-adbc-9d8e500a49b3	SE008E	3	A	t	CV118	f	2022-08-09 15:21:07.031522	2022-08-09 15:21:07.031522
b8ac77c0-431e-41d5-b249-d7bc8eecb95c	SE008E	3	D	t	CV118	f	2022-08-09 15:21:07.037083	2022-08-09 15:21:07.037083
76e6833d-2f26-4f58-a990-cbe7f390498a	SE008E	3	I	t	CV118	f	2022-08-09 15:21:07.044191	2022-08-09 15:21:07.044191
be5d21c7-a019-4e65-9c35-dde18215724a	SE008E	3	W	t	CV118	f	2022-08-09 15:21:07.050062	2022-08-09 15:21:07.050062
f88224e6-7824-4c5f-a425-6bac74233c55	SE008E	3	Z	t	CV118	f	2022-08-09 15:21:07.05573	2022-08-09 15:21:07.05573
9d15a6ec-706a-47ef-b19e-6f476f0b7887	SE008E	3	A	f	CV118	f	2022-08-09 15:21:07.061361	2022-08-09 15:21:07.061361
93948949-d48d-4488-8525-6c93870d37d7	SE008E	3	D	f	CV118	f	2022-08-09 15:21:07.066682	2022-08-09 15:21:07.066682
f3ef2a3f-c187-4982-bd62-d271c695c11f	SE008E	3	I	f	CV118	f	2022-08-09 15:21:07.072546	2022-08-09 15:21:07.072546
95e0522f-b188-4cf3-b34b-4e9efb775114	SE008E	3	W	f	CV118	f	2022-08-09 15:21:07.078077	2022-08-09 15:21:07.078077
42e4c12b-6db1-499d-a26e-e8fcb69f2bcb	SE008E	3	Z	f	CV118	f	2022-08-09 15:21:07.085853	2022-08-09 15:21:07.085853
36c786e7-4778-4668-85e3-7faecf30a1b4	SE008E	3	A	t	EF012	f	2022-08-09 15:21:07.092017	2022-08-09 15:21:07.092017
cb844c52-b3b5-4b8f-8416-8f6dc05f6351	SE008E	3	D	t	EF012	f	2022-08-09 15:21:07.097448	2022-08-09 15:21:07.097448
bab981c9-ce84-42d5-ab7d-e6114372ccb4	SE008E	3	I	t	EF012	f	2022-08-09 15:21:07.103317	2022-08-09 15:21:07.103317
174a648a-a1a5-4830-88fb-781e83897196	SE008E	3	W	t	EF012	f	2022-08-09 15:21:07.109321	2022-08-09 15:21:07.109321
a6ba393f-66bc-4cb1-a836-9bfc7fa46d08	SE008E	3	Z	t	EF012	f	2022-08-09 15:21:07.114678	2022-08-09 15:21:07.114678
f52cb637-7c87-4b1f-b600-798ee80001eb	SE008E	3	A	f	EF012	f	2022-08-09 15:21:07.120274	2022-08-09 15:21:07.120274
3a6e11cb-68e6-4a49-8102-fd14e068e7b5	SE008E	3	D	f	EF012	f	2022-08-09 15:21:07.125593	2022-08-09 15:21:07.125593
ea6fe8ec-942b-4dde-891c-f05d41a89ff4	SE008E	3	I	f	EF012	f	2022-08-09 15:21:07.131224	2022-08-09 15:21:07.131224
9f6474cc-6191-4e53-94dd-550f26098087	SE008E	3	W	f	EF012	f	2022-08-09 15:21:07.136661	2022-08-09 15:21:07.136661
7fa0a492-7692-4d0a-a2fe-f4494db0abb2	SE008E	3	Z	f	EF012	f	2022-08-09 15:21:07.142292	2022-08-09 15:21:07.142292
434d5d92-e30a-45e3-843d-2e8cfb74ee90	SE008E	3	A	t	EF022	f	2022-08-09 15:21:07.147589	2022-08-09 15:21:07.147589
66a84286-2a88-41e0-89da-09053eb9dec9	SE008E	3	D	t	EF022	f	2022-08-09 15:21:07.152977	2022-08-09 15:21:07.152977
3d156c7e-cb98-44fa-83a5-c467e8d09b1d	SE008E	3	I	t	EF022	f	2022-08-09 15:21:07.16034	2022-08-09 15:21:07.16034
6c06b0eb-e737-419a-a086-349b2bb012eb	SE008E	3	W	t	EF022	f	2022-08-09 15:21:07.166546	2022-08-09 15:21:07.166546
73af5d50-9dd4-4059-9a9b-70ea05e6bfa8	SE008E	3	Z	t	EF022	f	2022-08-09 15:21:07.172482	2022-08-09 15:21:07.172482
96aca761-59d4-41cf-a873-6bc3ba2cc54f	SE008E	3	A	f	EF022	f	2022-08-09 15:21:07.178514	2022-08-09 15:21:07.178514
2540fdeb-c432-44b7-93f4-41b4c446b3f3	SE008E	3	D	f	EF022	f	2022-08-09 15:21:07.184737	2022-08-09 15:21:07.184737
38724979-c23d-45a6-ae7e-122a117fb885	SE008E	3	I	f	EF022	f	2022-08-09 15:21:07.190485	2022-08-09 15:21:07.190485
8aa82a85-f6bd-408d-85cb-9eac795648d6	SE008E	3	W	f	EF022	f	2022-08-09 15:21:07.195808	2022-08-09 15:21:07.195808
1998ad1e-86ba-4c9e-b395-1ce42d97893a	SE008E	3	Z	f	EF022	f	2022-08-09 15:21:07.201373	2022-08-09 15:21:07.201373
f5a6a2b8-06a1-46a5-a8fc-2843411f09d3	SE008E	3	A	t	EF025	f	2022-08-09 15:21:07.206569	2022-08-09 15:21:07.206569
8110042f-7293-4292-a722-7554091df32d	SE008E	3	D	t	EF025	f	2022-08-09 15:21:07.212329	2022-08-09 15:21:07.212329
ca0fc9fc-f95a-4a36-a03f-cc5830cfa2ee	SE008E	3	I	t	EF025	f	2022-08-09 15:21:07.217616	2022-08-09 15:21:07.217616
e8e1569a-4489-4d80-b952-3d205a02b2e8	SE008E	3	W	t	EF025	f	2022-08-09 15:21:07.223181	2022-08-09 15:21:07.223181
86ac8139-2862-4dc9-8162-3f856ab96b36	SE008E	3	Z	t	EF025	f	2022-08-09 15:21:07.228554	2022-08-09 15:21:07.228554
5967d0cd-a13d-4c33-a075-3507b5138fec	SE008E	3	A	f	EF025	f	2022-08-09 15:21:07.234262	2022-08-09 15:21:07.234262
d71705be-dea3-48cf-abe2-d5c66d38344a	SE008E	3	D	f	EF025	f	2022-08-09 15:21:07.239698	2022-08-09 15:21:07.239698
d34d41a1-e88f-446d-a81e-7030d2c5227c	SE008E	3	I	f	EF025	f	2022-08-09 15:21:07.245563	2022-08-09 15:21:07.245563
f3215808-6c18-48c7-9205-cb20ca847fd4	SE008E	3	W	f	EF025	f	2022-08-09 15:21:07.25107	2022-08-09 15:21:07.25107
f214a470-9410-4f59-98a0-2e788cc68ecd	SE008E	3	Z	f	EF025	f	2022-08-09 15:21:07.256672	2022-08-09 15:21:07.256672
b0ddcbc2-3500-448d-a489-1e8b5daf3109	SE008E	3	A	t	EF026	f	2022-08-09 15:21:07.262207	2022-08-09 15:21:07.262207
7487c881-bf3b-4855-89cb-17473b72dc10	SE008E	3	D	t	EF026	f	2022-08-09 15:21:07.268322	2022-08-09 15:21:07.268322
f1958c18-c594-45a4-a7e1-549f2e693614	SE008E	3	I	t	EF026	f	2022-08-09 15:21:07.274191	2022-08-09 15:21:07.274191
2ff5b0fa-c837-441a-98f7-ea2ad594c7cb	SE008E	3	W	t	EF026	f	2022-08-09 15:21:07.279588	2022-08-09 15:21:07.279588
998a1238-1c43-4ed1-aac6-895d0fff3843	SE008E	3	Z	t	EF026	f	2022-08-09 15:21:07.28511	2022-08-09 15:21:07.28511
c95eeb92-acb4-492e-8629-1aa97f183258	SE008E	3	A	f	EF026	f	2022-08-09 15:21:07.29079	2022-08-09 15:21:07.29079
b207df50-8eed-4da6-8397-ea84cb88eb2e	SE008E	3	D	f	EF026	f	2022-08-09 15:21:07.296001	2022-08-09 15:21:07.296001
44640983-97c0-405b-8c22-8797c978cc70	SE008E	3	I	f	EF026	f	2022-08-09 15:21:07.301649	2022-08-09 15:21:07.301649
7ddd2ca1-07df-4502-8d39-c04542b65580	SE008E	3	W	f	EF026	f	2022-08-09 15:21:07.306979	2022-08-09 15:21:07.306979
9213aa5e-af6a-4901-b835-c0d01a01a808	SE008E	3	Z	f	EF026	f	2022-08-09 15:21:07.3127	2022-08-09 15:21:07.3127
294d9147-b171-4052-b166-596785e95665	SE008E	3	A	t	EF027	f	2022-08-09 15:21:07.318121	2022-08-09 15:21:07.318121
c4a88095-59c8-4c8b-a5d3-91d15b161ec5	SE008E	3	D	t	EF027	f	2022-08-09 15:21:07.32342	2022-08-09 15:21:07.32342
0370a3ac-68cc-4167-b01c-e7bebb1004d1	SE008E	3	I	t	EF027	f	2022-08-09 15:21:07.32922	2022-08-09 15:21:07.32922
6ab07ac5-264b-48fe-b42c-07b75864d6c2	SE008E	3	W	t	EF027	f	2022-08-09 15:21:07.334433	2022-08-09 15:21:07.334433
16497c26-a7ac-4a89-8ff2-17c29a921f2b	SE008E	3	Z	t	EF027	f	2022-08-09 15:21:07.339691	2022-08-09 15:21:07.339691
8f058172-01fd-4f67-a53d-533abee98084	SE008E	3	A	f	EF027	f	2022-08-09 15:21:07.34542	2022-08-09 15:21:07.34542
15a0f7f5-ffb0-4c89-a2cd-6884c37b57f1	SE008E	3	D	f	EF027	f	2022-08-09 15:21:07.353167	2022-08-09 15:21:07.353167
98dfc6a6-95b7-4d1e-a0ee-4df78f6b069f	SE008E	3	I	f	EF027	f	2022-08-09 15:21:07.359543	2022-08-09 15:21:07.359543
84300155-d1d2-4952-b0ad-94198a5a6a91	SE008E	3	W	f	EF027	f	2022-08-09 15:21:07.365575	2022-08-09 15:21:07.365575
13363cb1-fdf6-4a2b-875a-f7adfb2d1bfc	SE008E	3	Z	f	EF027	f	2022-08-09 15:21:07.371742	2022-08-09 15:21:07.371742
4b17b444-de7c-4ae4-8b5d-2116cbd87130	SE008E	3	A	t	FM049	f	2022-08-09 15:21:07.433909	2022-08-09 15:21:07.433909
7160e9c3-35ee-4862-bd2c-449b9a01c527	SE008E	3	D	t	FM049	f	2022-08-09 15:21:07.439549	2022-08-09 15:21:07.439549
745d79fb-173e-41a4-bca5-968c4657652c	SE008E	3	I	t	FM049	f	2022-08-09 15:21:07.444902	2022-08-09 15:21:07.444902
efe14b91-5174-4bd8-a35a-ea2fe369364a	SE008E	3	W	t	FM049	f	2022-08-09 15:21:07.450557	2022-08-09 15:21:07.450557
030ad646-e4b4-47a3-957c-3a24357da54e	SE008E	3	Z	t	FM049	f	2022-08-09 15:21:07.455896	2022-08-09 15:21:07.455896
0d499c08-8012-4fff-894d-8a10bce1d79a	SE008E	3	A	f	FM049	f	2022-08-09 15:21:07.461431	2022-08-09 15:21:07.461431
3e161710-83f0-4c00-8719-eaaca42b1498	SE008E	3	D	f	FM049	f	2022-08-09 15:21:07.466995	2022-08-09 15:21:07.466995
fbd4e112-4e5b-4284-b800-bb1bf82b9eb8	SE008E	3	I	f	FM049	f	2022-08-09 15:21:07.473005	2022-08-09 15:21:07.473005
0139fc37-fd81-4b5f-a333-c360f6186ee2	SE008E	3	W	f	FM049	f	2022-08-09 15:21:07.478444	2022-08-09 15:21:07.478444
1edb334c-7d58-4f1f-8956-30b4fb2f1902	SE008E	3	Z	f	FM049	f	2022-08-09 15:21:07.483932	2022-08-09 15:21:07.483932
4dcf5e18-7385-422a-ae08-b0e27a4584eb	SE008E	3	A	t	MC029	f	2022-08-09 15:21:07.491067	2022-08-09 15:21:07.491067
0b16f3a2-6d9d-4e39-863c-dbaa67e15fc4	SE008E	3	D	t	MC029	f	2022-08-09 15:21:07.496603	2022-08-09 15:21:07.496603
b74a8f42-2b0a-4812-9cbc-9f09e94442c6	SE008E	3	I	t	MC029	f	2022-08-09 15:21:07.502446	2022-08-09 15:21:07.502446
e52bf3e9-8380-4cd3-a216-7ad52db97cb1	SE008E	3	W	t	MC029	f	2022-08-09 15:21:07.508198	2022-08-09 15:21:07.508198
13c5aeb5-41bc-4c45-9b0d-31e33c74d296	SE008E	3	Z	t	MC029	f	2022-08-09 15:21:07.513714	2022-08-09 15:21:07.513714
62a7332d-40a8-4e72-a89f-0400be8993bf	SE008E	3	A	f	MC029	f	2022-08-09 15:21:07.519572	2022-08-09 15:21:07.519572
521c98ad-642f-40c8-82a9-9041547a5fac	SE008E	3	D	f	MC029	f	2022-08-09 15:21:07.524881	2022-08-09 15:21:07.524881
abded278-e8d3-4a79-b49c-22eb40d2722b	SE008E	3	I	f	MC029	f	2022-08-09 15:21:07.530838	2022-08-09 15:21:07.530838
4f08a256-57be-45b9-9ce1-c785a83720da	SE008E	3	W	f	MC029	f	2022-08-09 15:21:07.536284	2022-08-09 15:21:07.536284
35ba9d1a-88e9-4b97-83a5-4f82370f77aa	SE008E	3	Z	f	MC029	f	2022-08-09 15:21:07.541884	2022-08-09 15:21:07.541884
4f2aad75-2743-4974-8f2a-4225a5208d1d	SE008E	3	A	f	FM019	t	2022-08-09 15:21:07.406451	2022-08-09 15:21:07.549575
79fb1be7-833c-499c-973a-b0d9ab8a08b9	SE008E	3	D	f	FM019	t	2022-08-09 15:21:07.412017	2022-08-09 15:21:07.557066
9cfd6959-3ea2-44d0-94e4-59383c2c78b3	SE008E	3	I	f	FM019	t	2022-08-09 15:21:07.417488	2022-08-09 15:21:07.563965
16952850-99ee-413b-8745-f9a3e5b39cef	SE008E	3	W	f	FM019	t	2022-08-09 15:21:07.423228	2022-08-09 15:21:07.571686
e5b2c691-98b4-4096-9f81-a973c74ee3bd	SE008E	3	Z	f	FM019	t	2022-08-09 15:21:07.428504	2022-08-09 15:21:07.579259
15448a47-ca18-4b8f-a94d-19cf30c49502	SE008E	3	A	t	FM019	t	2022-08-09 15:21:07.377638	2022-08-09 15:21:07.586657
e1b050b6-d580-4d4c-ae70-9c1442690d59	SE008E	3	D	t	FM019	t	2022-08-09 15:21:07.383371	2022-08-09 15:21:07.593841
71a6ed3b-e7b9-4722-a1aa-621131ab9769	SE008E	3	I	t	FM019	t	2022-08-09 15:21:07.389524	2022-08-09 15:21:07.601061
aafca564-415c-46f2-8130-6d9a024ca179	SE008E	3	W	t	FM019	t	2022-08-09 15:21:07.395559	2022-08-09 15:21:07.60837
bb5693e7-3d87-4f30-893e-80521f6b876a	SE008E	3	Z	t	FM019	t	2022-08-09 15:21:07.401084	2022-08-09 15:21:07.615682
2d68ed63-0933-4e26-b76c-a0a99838aa36	SE013E	3	A	t	CV027	f	2022-08-09 15:21:07.621054	2022-08-09 15:21:07.621054
e62680cc-9201-404e-824f-3a1ff110fcd9	SE013E	3	D	t	CV027	f	2022-08-09 15:21:07.626727	2022-08-09 15:21:07.626727
a2245999-b530-410d-9b1b-d565cf63a8b8	SE013E	3	I	t	CV027	f	2022-08-09 15:21:07.632354	2022-08-09 15:21:07.632354
65199ae7-d995-41ac-a320-20406a7a81f7	SE013E	3	W	t	CV027	f	2022-08-09 15:21:07.638287	2022-08-09 15:21:07.638287
991bbfe6-5336-4632-bc27-981d17e41b03	SE013E	3	Z	t	CV027	f	2022-08-09 15:21:07.643793	2022-08-09 15:21:07.643793
1c4a6df5-2ca0-4292-8789-a9a641ce7d4a	SE013E	3	A	f	CV027	f	2022-08-09 15:21:07.649508	2022-08-09 15:21:07.649508
ea91f371-08ae-4b22-83b3-dacd1fd785fc	SE013E	3	D	f	CV027	f	2022-08-09 15:21:07.655326	2022-08-09 15:21:07.655326
2c649dba-4621-432a-ac1a-35b7752e4566	SE013E	3	I	f	CV027	f	2022-08-09 15:21:07.660621	2022-08-09 15:21:07.660621
c5e09d80-d010-4298-9201-3204088d50f1	SE013E	3	W	f	CV027	f	2022-08-09 15:21:07.666248	2022-08-09 15:21:07.666248
5a4a1b48-c73d-458b-a40d-37818e4d5c66	SE013E	3	Z	f	CV027	f	2022-08-09 15:21:07.672001	2022-08-09 15:21:07.672001
5a9f902d-0336-4072-b3d6-fbcedf6ab663	SE013E	3	A	t	CV118	f	2022-08-09 15:21:07.677293	2022-08-09 15:21:07.677293
6819a4aa-6df5-4151-ae6a-980223712b33	SE013E	3	D	t	CV118	f	2022-08-09 15:21:07.683218	2022-08-09 15:21:07.683218
0eb5b4eb-2283-439b-8e74-33af074afaa5	SE013E	3	I	t	CV118	f	2022-08-09 15:21:07.688671	2022-08-09 15:21:07.688671
9cc0d997-6312-4031-9d4e-8f52b8bdb04c	SE013E	3	W	t	CV118	f	2022-08-09 15:21:07.694166	2022-08-09 15:21:07.694166
5c0040da-30aa-439a-a441-f253eb59dba9	SE013E	3	Z	t	CV118	f	2022-08-09 15:21:07.699905	2022-08-09 15:21:07.699905
06b2f2be-9bf8-45dd-8a3c-2e0ee0a112e8	SE013E	3	A	f	CV118	f	2022-08-09 15:21:07.705153	2022-08-09 15:21:07.705153
7e76400d-4342-43b8-a6d8-5a96061964e6	SE013E	3	D	f	CV118	f	2022-08-09 15:21:07.710428	2022-08-09 15:21:07.710428
82e0ceee-a131-467b-9670-821a7a75eb31	SE013E	3	I	f	CV118	f	2022-08-09 15:21:07.716222	2022-08-09 15:21:07.716222
37662532-4ee5-4870-8516-d61d6e7e0636	SE013E	3	W	f	CV118	f	2022-08-09 15:21:07.722487	2022-08-09 15:21:07.722487
490a38a4-8439-4b1a-b03f-9249a35fbf63	SE013E	3	Z	f	CV118	f	2022-08-09 15:21:07.728637	2022-08-09 15:21:07.728637
d8b96159-b361-4316-80f1-96da8d879afa	SE013E	3	A	t	EF012	f	2022-08-09 15:21:07.734118	2022-08-09 15:21:07.734118
92c791f3-bc54-47be-a645-53ec210a9e37	SE013E	3	D	t	EF012	f	2022-08-09 15:21:07.739556	2022-08-09 15:21:07.739556
f9651502-3664-4720-af6b-5f91987287aa	SE013E	3	I	t	EF012	f	2022-08-09 15:21:07.745542	2022-08-09 15:21:07.745542
bb4dfc52-c255-43b1-9004-6ce78afbcdd4	SE013E	3	W	t	EF012	f	2022-08-09 15:21:07.750815	2022-08-09 15:21:07.750815
848426cb-3127-46d8-8b78-7c3e7e2e9567	SE013E	3	Z	t	EF012	f	2022-08-09 15:21:07.756231	2022-08-09 15:21:07.756231
328b32b5-6c07-457d-ac5e-78a999a5235d	SE013E	3	A	f	EF012	f	2022-08-09 15:21:07.76186	2022-08-09 15:21:07.76186
97f98431-b6bc-4536-8f7e-1f5c09f4f8a4	SE013E	3	D	f	EF012	f	2022-08-09 15:21:07.767119	2022-08-09 15:21:07.767119
fb4f4558-716e-4ff5-9a5a-d0604f33b830	SE013E	3	I	f	EF012	f	2022-08-09 15:21:07.772662	2022-08-09 15:21:07.772662
8d0f7c4e-09f8-41bb-b3cb-964edc81ecdd	SE013E	3	W	f	EF012	f	2022-08-09 15:21:07.779026	2022-08-09 15:21:07.779026
0bf2c512-b822-420b-b326-fe530e11959b	SE013E	3	Z	f	EF012	f	2022-08-09 15:21:07.785571	2022-08-09 15:21:07.785571
6875f0de-3954-4dd8-a512-0eec3c032246	SE013E	3	A	t	EF022	f	2022-08-09 15:21:07.791242	2022-08-09 15:21:07.791242
50ff5b5d-eb5a-4d02-a3e9-cf7be27ad2b8	SE013E	3	D	t	EF022	f	2022-08-09 15:21:07.797093	2022-08-09 15:21:07.797093
87eda196-35d1-4b0d-8310-a82234b91d9d	SE013E	3	I	t	EF022	f	2022-08-09 15:21:07.802487	2022-08-09 15:21:07.802487
d06e8e09-68a2-4ab3-9535-ccc37c15f9da	SE013E	3	W	t	EF022	f	2022-08-09 15:21:07.807743	2022-08-09 15:21:07.807743
4d88c4fa-1be8-4e52-826b-1b78aa01677d	SE013E	3	Z	t	EF022	f	2022-08-09 15:21:07.81448	2022-08-09 15:21:07.81448
7474540e-9b2a-446a-9013-99f376c7d040	SE013E	3	A	f	EF022	f	2022-08-09 15:21:07.82004	2022-08-09 15:21:07.82004
cd62168f-1db1-4ec4-816d-3a7229871f63	SE013E	3	D	f	EF022	f	2022-08-09 15:21:07.825927	2022-08-09 15:21:07.825927
dc761df0-2849-4cd6-8068-90c2c79ab7d8	SE013E	3	I	f	EF022	f	2022-08-09 15:21:07.831882	2022-08-09 15:21:07.831882
24c57b2c-4460-4178-b6f6-8a912f50cdf0	SE013E	3	W	f	EF022	f	2022-08-09 15:21:07.837328	2022-08-09 15:21:07.837328
cee35994-7042-4110-938c-c1d959b61e21	SE013E	3	Z	f	EF022	f	2022-08-09 15:21:07.843236	2022-08-09 15:21:07.843236
52f6dbfe-b286-4d25-8791-1daa91d05a34	SE013E	3	A	t	EF025	f	2022-08-09 15:21:07.848767	2022-08-09 15:21:07.848767
2e6149d0-db7e-49b7-bffe-0ad24f0a2b07	SE013E	3	D	t	EF025	f	2022-08-09 15:21:07.855562	2022-08-09 15:21:07.855562
4c9e2bf3-dee0-4186-abbc-0d791613ef69	SE013E	3	I	t	EF025	f	2022-08-09 15:21:07.862199	2022-08-09 15:21:07.862199
cfca57b2-54a1-4ebc-9a70-f723d6cf0a2e	SE013E	3	W	t	EF025	f	2022-08-09 15:21:07.868063	2022-08-09 15:21:07.868063
c763e630-d5d4-4838-9a55-091f40478439	SE013E	3	Z	t	EF025	f	2022-08-09 15:21:07.873615	2022-08-09 15:21:07.873615
3d45da38-4091-4986-9fce-1fde10ee9328	SE013E	3	A	f	EF025	f	2022-08-09 15:21:07.879363	2022-08-09 15:21:07.879363
e6a6ab38-8b56-46a4-a0b6-cc4a182f9798	SE013E	3	D	f	EF025	f	2022-08-09 15:21:07.885035	2022-08-09 15:21:07.885035
83f15a49-7d2b-4b36-a2c9-b26b12ba3a70	SE013E	3	I	f	EF025	f	2022-08-09 15:21:07.890823	2022-08-09 15:21:07.890823
cc838747-c13b-4a9e-8e03-6957b09bd761	SE013E	3	W	f	EF025	f	2022-08-09 15:21:07.896308	2022-08-09 15:21:07.896308
7439995c-5d58-4ae0-a2c5-7ff9ac1492ba	SE013E	3	Z	f	EF025	f	2022-08-09 15:21:07.902049	2022-08-09 15:21:07.902049
775f5bed-1f8e-4302-bc58-41724d02cc9e	SE013E	3	A	t	EF026	f	2022-08-09 15:21:07.907275	2022-08-09 15:21:07.907275
59fa7dfd-6bf3-45d3-84cc-6b99cbc9620d	SE013E	3	D	t	EF026	f	2022-08-09 15:21:07.912944	2022-08-09 15:21:07.912944
358ac19e-3e4c-4da4-a5bc-286e37ebf34f	SE013E	3	I	t	EF026	f	2022-08-09 15:21:07.918357	2022-08-09 15:21:07.918357
9506a75f-d343-475e-8141-5de3581bb640	SE013E	3	W	t	EF026	f	2022-08-09 15:21:07.923653	2022-08-09 15:21:07.923653
6cddfa5a-9ecb-450f-bb5f-0c03566efda4	SE013E	3	Z	t	EF026	f	2022-08-09 15:21:07.92932	2022-08-09 15:21:07.92932
bfff46f7-4ba8-43a3-81ab-d889e3a7aa44	SE013E	3	A	f	EF026	f	2022-08-09 15:21:07.934615	2022-08-09 15:21:07.934615
9f5dd05b-93bc-45da-9c26-0763fd9fc871	SE013E	3	D	f	EF026	f	2022-08-09 15:21:07.940045	2022-08-09 15:21:07.940045
159927d9-c35b-4ddf-96e4-515046db5e83	SE013E	3	I	f	EF026	f	2022-08-09 15:21:07.94571	2022-08-09 15:21:07.94571
1c0c9398-a17f-45d4-a1ee-4e3a32749c57	SE013E	3	W	f	EF026	f	2022-08-09 15:21:07.951074	2022-08-09 15:21:07.951074
f4cba975-caae-4beb-bbf5-5a7d9805d294	SE013E	3	Z	f	EF026	f	2022-08-09 15:21:07.957279	2022-08-09 15:21:07.957279
b1b743be-ba5e-4cd3-9318-1a9a56f42bce	SE013E	3	A	t	EF027	f	2022-08-09 15:21:07.963119	2022-08-09 15:21:07.963119
4a33cad4-ac93-4c1d-85c8-d75fe16e09a6	SE013E	3	D	t	EF027	f	2022-08-09 15:21:07.968786	2022-08-09 15:21:07.968786
b9ed2d9b-80c9-4a5f-a317-bcce94e7e642	SE013E	3	I	t	EF027	f	2022-08-09 15:21:07.974021	2022-08-09 15:21:07.974021
9f091d60-7bb6-474c-a4cd-b8a1c3128dbb	SE013E	3	W	t	EF027	f	2022-08-09 15:21:07.979746	2022-08-09 15:21:07.979746
45ab48e1-ff20-4dbc-85c1-ab26aa7b835a	SE013E	3	Z	t	EF027	f	2022-08-09 15:21:07.986495	2022-08-09 15:21:07.986495
6688ef74-b2e0-409b-802f-65e0bb4ed94b	SE013E	3	A	f	EF027	f	2022-08-09 15:21:07.992242	2022-08-09 15:21:07.992242
cabba432-3f4b-47e9-9383-dbb559afddbd	SE013E	3	D	f	EF027	f	2022-08-09 15:21:07.997617	2022-08-09 15:21:07.997617
fc848987-1717-4f74-8362-74d21f9b976f	SE013E	3	I	f	EF027	f	2022-08-09 15:21:08.003099	2022-08-09 15:21:08.003099
2c2a8ea8-eec9-489b-929f-0d5fdb545e0f	SE013E	3	W	f	EF027	f	2022-08-09 15:21:08.008505	2022-08-09 15:21:08.008505
f6d1d6fe-8a94-47b4-9939-43d2c6d39787	SE013E	3	Z	f	EF027	f	2022-08-09 15:21:08.014028	2022-08-09 15:21:08.014028
a119decc-ca67-46d2-bb53-a0c8bce37791	SE013E	3	A	t	FM049	f	2022-08-09 15:21:08.077552	2022-08-09 15:21:08.077552
8bfdad85-781b-44fe-a62f-47c922a8c8f0	SE013E	3	D	t	FM049	f	2022-08-09 15:21:08.105714	2022-08-09 15:21:08.105714
e712c8e7-b569-47d0-8b71-2c7c4111b321	SE013E	3	I	t	FM049	f	2022-08-09 15:21:08.135025	2022-08-09 15:21:08.135025
d0fb163a-617b-47c5-9aff-76397310ab6f	SE013E	3	W	t	FM049	f	2022-08-09 15:21:08.141539	2022-08-09 15:21:08.141539
a0c90e90-19ea-4ce8-9b44-17b7c9508533	SE013E	3	Z	t	FM049	f	2022-08-09 15:21:08.147365	2022-08-09 15:21:08.147365
66bdfaa9-0849-44d6-902a-f196153f8e6a	SE013E	3	A	f	FM049	f	2022-08-09 15:21:08.1531	2022-08-09 15:21:08.1531
6987cf25-b347-44fc-9bd7-57f8da439d1e	SE013E	3	D	f	FM049	f	2022-08-09 15:21:08.158718	2022-08-09 15:21:08.158718
03bb6f23-a380-4a4d-a435-06bd0e1bcab1	SE013E	3	I	f	FM049	f	2022-08-09 15:21:08.164594	2022-08-09 15:21:08.164594
4c8d6cbc-fcba-4d5c-ab0f-eee24f8c2007	SE013E	3	W	f	FM049	f	2022-08-09 15:21:08.1702	2022-08-09 15:21:08.1702
e56c7693-a24e-4b07-9cc7-024abb33c775	SE013E	3	Z	f	FM049	f	2022-08-09 15:21:08.176118	2022-08-09 15:21:08.176118
b37cb7d1-b6cc-4afa-9c4a-205246ad673b	SE013E	3	A	t	MC029	f	2022-08-09 15:21:08.181617	2022-08-09 15:21:08.181617
643db2f5-075b-491b-8005-00655d23978d	SE013E	3	D	t	MC029	f	2022-08-09 15:21:08.18699	2022-08-09 15:21:08.18699
5ec2fc3d-b0b8-4438-86e9-b7aa174e93f0	SE013E	3	I	t	MC029	f	2022-08-09 15:21:08.195263	2022-08-09 15:21:08.195263
8617c925-7937-4b7d-a83a-5447b4c1c794	SE013E	3	W	t	MC029	f	2022-08-09 15:21:08.201897	2022-08-09 15:21:08.201897
5f474e09-ddb3-42e7-a53e-74198e9aa84e	SE013E	3	Z	t	MC029	f	2022-08-09 15:21:08.2089	2022-08-09 15:21:08.2089
fd9fefe2-c571-4749-8dc3-d9712f87484e	SE013E	3	A	f	MC029	f	2022-08-09 15:21:08.216072	2022-08-09 15:21:08.216072
3381182a-3af9-444a-a5eb-25b942b0bd19	SE013E	3	D	f	MC029	f	2022-08-09 15:21:08.222589	2022-08-09 15:21:08.222589
43349182-c9a4-4a61-a2b5-039c254d932d	SE013E	3	I	f	MC029	f	2022-08-09 15:21:08.228492	2022-08-09 15:21:08.228492
3c65fd1d-ea52-4332-bdf5-0daca9aafdd8	SE013E	3	W	f	MC029	f	2022-08-09 15:21:08.234304	2022-08-09 15:21:08.234304
7b592c7d-d6a1-4c9d-b760-68af6d8c23c1	SE013E	3	Z	f	MC029	f	2022-08-09 15:21:08.24066	2022-08-09 15:21:08.24066
34f07af3-5d85-4ba5-a9ea-52f1d46268a3	SE013E	3	A	f	FM019	t	2022-08-09 15:21:08.046833	2022-08-09 15:21:08.248203
7fcce239-987f-4d40-8397-7d110b9c54ae	SE013E	3	D	f	FM019	t	2022-08-09 15:21:08.054997	2022-08-09 15:21:08.255669
5232340c-30fe-42ca-abe2-c24767623685	SE013E	3	I	f	FM019	t	2022-08-09 15:21:08.060814	2022-08-09 15:21:08.26266
faed4e2b-7a20-4ff7-87c3-cd16a57639cf	SE013E	3	W	f	FM019	t	2022-08-09 15:21:08.066523	2022-08-09 15:21:08.270715
9d5aa051-d5b6-4dc9-8619-3360492065fd	SE013E	3	Z	f	FM019	t	2022-08-09 15:21:08.071954	2022-08-09 15:21:08.278206
765327e0-7028-4229-8d88-411339309eba	SE013E	3	A	t	FM019	t	2022-08-09 15:21:08.019088	2022-08-09 15:21:08.285612
044173db-ddcc-465c-b295-5ac8ec325545	SE013E	3	D	t	FM019	t	2022-08-09 15:21:08.024556	2022-08-09 15:21:08.292823
5ccaa196-280d-435b-8d96-b3534f248512	SE013E	3	I	t	FM019	t	2022-08-09 15:21:08.030167	2022-08-09 15:21:08.300039
7eb1f930-d87c-487e-b7be-040839bb3340	SE013E	3	W	t	FM019	t	2022-08-09 15:21:08.035511	2022-08-09 15:21:08.307355
816bacf6-aa53-4da0-9fb1-b0aeed2b8a09	SE013E	3	Z	t	FM019	t	2022-08-09 15:21:08.04111	2022-08-09 15:21:08.314638
1b5d0ead-8edf-42f1-a14a-cd3bdf831124	SE014E	3	A	t	CV027	f	2022-08-09 15:21:08.319934	2022-08-09 15:21:08.319934
ea2a4ff5-0c7c-4b7d-892e-c24a35b429cf	SE014E	3	D	t	CV027	f	2022-08-09 15:21:08.325724	2022-08-09 15:21:08.325724
f48b5583-ee44-4e01-ac2b-47a7704f28e5	SE014E	3	I	t	CV027	f	2022-08-09 15:21:08.331139	2022-08-09 15:21:08.331139
6bd1dd26-ee8d-4b86-a85f-896a91ebefd1	SE014E	3	W	t	CV027	f	2022-08-09 15:21:08.33699	2022-08-09 15:21:08.33699
4b10068a-3f0e-485e-9fe6-e9cf5a344ccb	SE014E	3	Z	t	CV027	f	2022-08-09 15:21:08.342271	2022-08-09 15:21:08.342271
a58ca00b-83fa-4f85-ac4d-2a4f95866942	SE014E	3	A	f	CV027	f	2022-08-09 15:21:08.349246	2022-08-09 15:21:08.349246
e3f3e8e9-f1ec-41df-ba58-cadc01baf58c	SE014E	3	D	f	CV027	f	2022-08-09 15:21:08.3561	2022-08-09 15:21:08.3561
3fa07db2-bf78-4210-b815-5efb0ef1d7f4	SE014E	3	I	f	CV027	f	2022-08-09 15:21:08.362185	2022-08-09 15:21:08.362185
db27c954-0b34-4bba-b760-634fe99db228	SE014E	3	W	f	CV027	f	2022-08-09 15:21:08.369054	2022-08-09 15:21:08.369054
49a36b4b-e26c-41c5-a7b7-e308c60bbe0b	SE014E	3	Z	f	CV027	f	2022-08-09 15:21:08.375076	2022-08-09 15:21:08.375076
988795d3-e23a-4eff-9ded-9f7f93ec4ef7	SE014E	3	A	t	CV118	f	2022-08-09 15:21:08.380807	2022-08-09 15:21:08.380807
feda0209-1d45-4f39-872a-80b104884104	SE014E	3	D	t	CV118	f	2022-08-09 15:21:08.387207	2022-08-09 15:21:08.387207
631899ea-70b7-42dd-91ca-406b119ada9a	SE014E	3	I	t	CV118	f	2022-08-09 15:21:08.393288	2022-08-09 15:21:08.393288
b6495a39-e30e-440a-8d6b-2227012f9e23	SE014E	3	W	t	CV118	f	2022-08-09 15:21:08.399201	2022-08-09 15:21:08.399201
b3728dba-5985-48e7-b6ad-b5c65e4b5f18	SE014E	3	Z	t	CV118	f	2022-08-09 15:21:08.404824	2022-08-09 15:21:08.404824
00e9a4d7-90ef-4995-9534-1d4be69a45b5	SE014E	3	A	f	CV118	f	2022-08-09 15:21:08.410316	2022-08-09 15:21:08.410316
65d93e8a-8c5b-40d3-8b3f-8edffc1bd8b5	SE014E	3	D	f	CV118	f	2022-08-09 15:21:08.41605	2022-08-09 15:21:08.41605
99b9de9d-53e4-4964-85ac-2326e83c9cf0	SE014E	3	I	f	CV118	f	2022-08-09 15:21:08.421353	2022-08-09 15:21:08.421353
649f623f-11f5-415e-a2a7-f10cf1246330	SE014E	3	W	f	CV118	f	2022-08-09 15:21:08.427073	2022-08-09 15:21:08.427073
b20f09df-4b6f-4fa1-ad6b-c9b3450ac7e0	SE014E	3	Z	f	CV118	f	2022-08-09 15:21:08.432763	2022-08-09 15:21:08.432763
8c1db92d-1376-4e6e-b0c8-6fc29bcb5e12	SE014E	3	A	t	EF012	f	2022-08-09 15:21:08.438074	2022-08-09 15:21:08.438074
80c8e2f6-5ac3-43d3-8bd0-7a6811703e0b	SE014E	3	D	t	EF012	f	2022-08-09 15:21:08.443831	2022-08-09 15:21:08.443831
360e9464-b243-41dd-8f3c-ab0e54593383	SE014E	3	I	t	EF012	f	2022-08-09 15:21:08.449129	2022-08-09 15:21:08.449129
828c3caa-089a-4ba3-bcbe-f289e2fba5b2	SE014E	3	W	t	EF012	f	2022-08-09 15:21:08.454533	2022-08-09 15:21:08.454533
1f10dbaa-f9a9-4c06-bea1-64b8e77a3e82	SE014E	3	Z	t	EF012	f	2022-08-09 15:21:08.460172	2022-08-09 15:21:08.460172
6acfb1fa-1552-4676-89b8-590bef8207b2	SE014E	3	A	f	EF012	f	2022-08-09 15:21:08.465398	2022-08-09 15:21:08.465398
8464165c-fe1d-4b4c-ba8b-fd339341b833	SE014E	3	D	f	EF012	f	2022-08-09 15:21:08.470922	2022-08-09 15:21:08.470922
c7858b61-d43e-4756-8ceb-0919d3fcf248	SE014E	3	I	f	EF012	f	2022-08-09 15:21:08.476545	2022-08-09 15:21:08.476545
b2fc7280-ca1c-4a77-a299-9f6fae1c26a4	SE014E	3	W	f	EF012	f	2022-08-09 15:21:08.481879	2022-08-09 15:21:08.481879
014d48d4-f08e-4f48-960f-eddfeb5c21fa	SE014E	3	Z	f	EF012	f	2022-08-09 15:21:08.487604	2022-08-09 15:21:08.487604
a98f7496-3246-4d04-a674-9cdfb6b7e18c	SE014E	3	A	t	EF022	f	2022-08-09 15:21:08.492923	2022-08-09 15:21:08.492923
227111a2-8682-498b-9e1a-fb1f23f1f734	SE014E	3	D	t	EF022	f	2022-08-09 15:21:08.498489	2022-08-09 15:21:08.498489
d7c94d30-fdfb-4033-b77b-ad6c12a3f1c3	SE014E	3	I	t	EF022	f	2022-08-09 15:21:08.50422	2022-08-09 15:21:08.50422
ec4ae343-c6d2-4ac2-8c33-9ea6360cff19	SE014E	3	W	t	EF022	f	2022-08-09 15:21:08.510223	2022-08-09 15:21:08.510223
e236dca5-d991-48ab-97a3-241fc6db58ff	SE014E	3	Z	t	EF022	f	2022-08-09 15:21:08.515566	2022-08-09 15:21:08.515566
1c532f33-2e6b-4f65-884b-411183f8b00f	SE014E	3	A	f	EF022	f	2022-08-09 15:21:08.52074	2022-08-09 15:21:08.52074
cfc07877-5f55-4671-a4c1-cd18f8658dc9	SE014E	3	D	f	EF022	f	2022-08-09 15:21:08.527644	2022-08-09 15:21:08.527644
630d7fe5-2ac5-4356-bf9c-a555717c7033	SE014E	3	I	f	EF022	f	2022-08-09 15:21:08.533392	2022-08-09 15:21:08.533392
3c7862d3-be9a-4de3-84e9-c01caab20d93	SE014E	3	W	f	EF022	f	2022-08-09 15:21:08.539872	2022-08-09 15:21:08.539872
544c35d2-99d0-4dd0-be6c-2e33c64354d2	SE014E	3	Z	f	EF022	f	2022-08-09 15:21:08.546881	2022-08-09 15:21:08.546881
720d5083-eda0-47a9-a085-095ce85e07b9	SE014E	3	A	t	EF025	f	2022-08-09 15:21:08.552829	2022-08-09 15:21:08.552829
20284cf1-f358-4d3f-aae8-82836450ac62	SE014E	3	D	t	EF025	f	2022-08-09 15:21:08.558499	2022-08-09 15:21:08.558499
7b7301a2-a17f-40e2-b9d0-91f5582d7bbe	SE014E	3	I	t	EF025	f	2022-08-09 15:21:08.563883	2022-08-09 15:21:08.563883
bff6ac54-c9f9-4c46-9a6a-fb6647798570	SE014E	3	W	t	EF025	f	2022-08-09 15:21:08.56972	2022-08-09 15:21:08.56972
09123cf6-4999-4fee-bc0b-e98824a7d164	SE014E	3	Z	t	EF025	f	2022-08-09 15:21:08.575202	2022-08-09 15:21:08.575202
f8e6f4f6-19f7-4a19-917d-eb5dfe777b98	SE014E	3	A	f	EF025	f	2022-08-09 15:21:08.581041	2022-08-09 15:21:08.581041
4020454e-406c-43df-8b53-47bc7a00abc4	SE014E	3	D	f	EF025	f	2022-08-09 15:21:08.586529	2022-08-09 15:21:08.586529
5c099dab-5a08-4d00-bcb7-9c5fa055ef4d	SE014E	3	I	f	EF025	f	2022-08-09 15:21:08.592724	2022-08-09 15:21:08.592724
0894114f-14db-4fa7-893d-89482451a169	SE014E	3	W	f	EF025	f	2022-08-09 15:21:08.598398	2022-08-09 15:21:08.598398
fd3e9b7a-7459-4b23-9ad4-7a19c5d95534	SE014E	3	Z	f	EF025	f	2022-08-09 15:21:08.604271	2022-08-09 15:21:08.604271
ffd6584b-7c6f-4552-9912-5c5a25ddf667	SE014E	3	A	t	EF026	f	2022-08-09 15:21:08.609939	2022-08-09 15:21:08.609939
6871dc09-bfad-4c42-a166-2a60a592c207	SE014E	3	D	t	EF026	f	2022-08-09 15:21:08.615738	2022-08-09 15:21:08.615738
d2314004-3292-45b7-bbac-66acd1dc3046	SE014E	3	I	t	EF026	f	2022-08-09 15:21:08.621143	2022-08-09 15:21:08.621143
c01f7b65-e1c5-4136-bedf-d8a86840d818	SE014E	3	W	t	EF026	f	2022-08-09 15:21:08.626834	2022-08-09 15:21:08.626834
1d2e36fc-4f10-4ee8-ab49-3183339c919d	SE014E	3	Z	t	EF026	f	2022-08-09 15:21:08.63204	2022-08-09 15:21:08.63204
f421e8ac-c6c9-4985-a9d5-00c4b331f7f8	SE014E	3	A	f	EF026	f	2022-08-09 15:21:08.637195	2022-08-09 15:21:08.637195
7201a5ad-afc1-4ebb-862e-f3e7313ed042	SE014E	3	D	f	EF026	f	2022-08-09 15:21:08.643002	2022-08-09 15:21:08.643002
f052b691-4830-48f6-8e42-b01035f5245a	SE014E	3	I	f	EF026	f	2022-08-09 15:21:08.64848	2022-08-09 15:21:08.64848
92037ddc-48d3-4df1-be5d-d5a5e9c8a2e3	SE014E	3	W	f	EF026	f	2022-08-09 15:21:08.653933	2022-08-09 15:21:08.653933
a454ea8d-6467-47eb-89ca-da500e14f95f	SE014E	3	Z	f	EF026	f	2022-08-09 15:21:08.659838	2022-08-09 15:21:08.659838
0fdf75f2-cb73-40ab-8ee0-5bad2d7c5b2b	SE014E	3	A	t	EF027	f	2022-08-09 15:21:08.665641	2022-08-09 15:21:08.665641
41986862-2124-4fd7-a8ac-075a453a1f26	SE014E	3	D	t	EF027	f	2022-08-09 15:21:08.671063	2022-08-09 15:21:08.671063
463c3a60-eaa6-4132-b111-09ba13b7570b	SE014E	3	I	t	EF027	f	2022-08-09 15:21:08.676494	2022-08-09 15:21:08.676494
15b2792c-ea39-4c52-96f0-b7e40bb9e947	SE014E	3	W	t	EF027	f	2022-08-09 15:21:08.68209	2022-08-09 15:21:08.68209
cf4b21ec-9e65-48ed-91e6-9705c8f7df3f	SE014E	3	Z	t	EF027	f	2022-08-09 15:21:08.687464	2022-08-09 15:21:08.687464
b985d75b-963f-46f9-8210-043ccbf02a5b	SE014E	3	A	f	EF027	f	2022-08-09 15:21:08.692929	2022-08-09 15:21:08.692929
a347ab33-e1a2-4d43-84e4-8e82971ed576	SE014E	3	D	f	EF027	f	2022-08-09 15:21:08.698696	2022-08-09 15:21:08.698696
0786007d-258e-4d61-892f-83ae20022945	SE014E	3	I	f	EF027	f	2022-08-09 15:21:08.704056	2022-08-09 15:21:08.704056
5eb61fde-e656-4016-84b4-047867bf5f59	SE014E	3	W	f	EF027	f	2022-08-09 15:21:08.709717	2022-08-09 15:21:08.709717
9ce38b11-3459-465e-b662-e58de1001244	SE014E	3	Z	f	EF027	f	2022-08-09 15:21:08.715579	2022-08-09 15:21:08.715579
5e2b0c27-d537-41d8-ae3d-894fa96ea775	SE014E	3	A	t	FM049	f	2022-08-09 15:21:08.777976	2022-08-09 15:21:08.777976
53463109-9a7e-40a7-9c0f-e83be3e90c8d	SE014E	3	D	t	FM049	f	2022-08-09 15:21:08.78352	2022-08-09 15:21:08.78352
58669508-d8bf-4b4e-b2a3-0f680719ba57	SE014E	3	I	t	FM049	f	2022-08-09 15:21:08.789174	2022-08-09 15:21:08.789174
666b4e8f-cf83-416c-9618-74960e03d7d0	SE014E	3	W	t	FM049	f	2022-08-09 15:21:08.794576	2022-08-09 15:21:08.794576
87bc7dce-4fa7-42b9-aa36-b11cb7b59d4b	SE014E	3	Z	t	FM049	f	2022-08-09 15:21:08.799798	2022-08-09 15:21:08.799798
0af9d410-25ab-4397-9f82-1c52bec2450f	SE014E	3	A	f	FM049	f	2022-08-09 15:21:08.805441	2022-08-09 15:21:08.805441
8e2285d7-6669-447a-afee-8c5304eced77	SE014E	3	D	f	FM049	f	2022-08-09 15:21:08.811052	2022-08-09 15:21:08.811052
2fd20b01-111e-4f39-b5d6-99e74d7bcb32	SE014E	3	I	f	FM049	f	2022-08-09 15:21:08.816635	2022-08-09 15:21:08.816635
c79d2390-8fa5-436a-9e08-12153f2c5f57	SE014E	3	W	f	FM049	f	2022-08-09 15:21:08.822396	2022-08-09 15:21:08.822396
7468c00c-a7bb-490c-af1b-4abb948b002e	SE014E	3	Z	f	FM049	f	2022-08-09 15:21:08.828289	2022-08-09 15:21:08.828289
56e49689-d8dd-4ac2-bd0c-1ea78fae3700	SE014E	3	A	t	MC029	f	2022-08-09 15:21:08.83405	2022-08-09 15:21:08.83405
8ccc7e51-0577-4d61-ab54-75d025f16ab5	SE014E	3	D	t	MC029	f	2022-08-09 15:21:08.839892	2022-08-09 15:21:08.839892
07bc32cb-70e8-421f-a92a-b17c3c999953	SE014E	3	I	t	MC029	f	2022-08-09 15:21:08.845382	2022-08-09 15:21:08.845382
4e4fa300-cd0e-41a5-9210-ab55a46f3c75	SE014E	3	W	t	MC029	f	2022-08-09 15:21:08.850886	2022-08-09 15:21:08.850886
615b400d-3073-4cf0-aac9-784c8db4f667	SE014E	3	Z	t	MC029	f	2022-08-09 15:21:08.858166	2022-08-09 15:21:08.858166
5b1b5000-5406-4842-a0a6-21b61db187dd	SE014E	3	A	f	MC029	f	2022-08-09 15:21:08.86392	2022-08-09 15:21:08.86392
85b4e3d2-a1f7-48e4-949e-9743421c756f	SE014E	3	D	f	MC029	f	2022-08-09 15:21:08.871143	2022-08-09 15:21:08.871143
beacb047-1f29-48a1-aaf8-cba4e20b0720	SE014E	3	I	f	MC029	f	2022-08-09 15:21:08.877711	2022-08-09 15:21:08.877711
4ce3b728-9baa-4820-bb31-c035de894d4f	SE014E	3	W	f	MC029	f	2022-08-09 15:21:08.883778	2022-08-09 15:21:08.883778
376e60cf-ffb2-438b-9aad-5446c8f235c5	SE014E	3	Z	f	MC029	f	2022-08-09 15:21:08.889989	2022-08-09 15:21:08.889989
90631c56-fcb6-4a42-9864-827ef635c19a	SE014E	3	A	f	FM019	t	2022-08-09 15:21:08.750693	2022-08-09 15:21:08.898168
2cd527fa-f2ea-4776-af69-14ac7fe07d55	SE014E	3	D	f	FM019	t	2022-08-09 15:21:08.755926	2022-08-09 15:21:08.906457
81b21938-b4ec-4d01-8e55-be7012caf1d3	SE014E	3	I	f	FM019	t	2022-08-09 15:21:08.761764	2022-08-09 15:21:08.914358
b091d271-61ee-426c-9fae-718f4fda20a9	SE014E	3	W	f	FM019	t	2022-08-09 15:21:08.767046	2022-08-09 15:21:08.922546
9cbffe5a-1398-4c5d-a3b9-39ea1cf981cb	SE014E	3	Z	f	FM019	t	2022-08-09 15:21:08.772363	2022-08-09 15:21:08.930191
07b652f9-eda3-47b1-9cea-19dff8fa9b31	SE014E	3	A	t	FM019	t	2022-08-09 15:21:08.721549	2022-08-09 15:21:08.93695
b9da3630-dc5d-489c-a8b7-8bef0c6ee0e0	SE014E	3	D	t	FM019	t	2022-08-09 15:21:08.72755	2022-08-09 15:21:08.944031
1a05b220-5ed2-4d76-9f43-5fda2b2ba003	SE014E	3	I	t	FM019	t	2022-08-09 15:21:08.733774	2022-08-09 15:21:08.951859
0bede42e-34f3-45ea-a2a0-6169a57f9cf0	SE014E	3	W	t	FM019	t	2022-08-09 15:21:08.739526	2022-08-09 15:21:08.959662
3388d642-fe7b-4902-85f0-73a463a0cffd	SE014E	3	Z	t	FM019	t	2022-08-09 15:21:08.745355	2022-08-09 15:21:08.966881
4062e49c-342a-46f7-b7df-cd06fbbbd087	SE015E	3	A	t	CV027	f	2022-08-09 15:21:08.972655	2022-08-09 15:21:08.972655
518f0c4c-e0c0-4d8c-8213-bd50f957efe8	SE015E	3	D	t	CV027	f	2022-08-09 15:21:08.978316	2022-08-09 15:21:08.978316
b914c7eb-36ad-4e31-8aab-ade6db19e570	SE015E	3	I	t	CV027	f	2022-08-09 15:21:08.983613	2022-08-09 15:21:08.983613
e77ad03d-9c25-4aed-aa53-2a3f456285e0	SE015E	3	W	t	CV027	f	2022-08-09 15:21:08.989402	2022-08-09 15:21:08.989402
a1aec036-a58a-409c-b827-8badc57e1e8c	SE015E	3	Z	t	CV027	f	2022-08-09 15:21:08.995326	2022-08-09 15:21:08.995326
4656fcbb-394a-4907-9d28-bbbd0c4795e8	SE015E	3	A	f	CV027	f	2022-08-09 15:21:09.001391	2022-08-09 15:21:09.001391
963037f3-7b1d-4412-8f38-0dc2d5153e55	SE015E	3	D	f	CV027	f	2022-08-09 15:21:09.007285	2022-08-09 15:21:09.007285
afe5a3fc-8867-4de1-b06a-24d224cbfe1e	SE015E	3	I	f	CV027	f	2022-08-09 15:21:09.013553	2022-08-09 15:21:09.013553
250e1766-3828-41ce-be53-5390eed826d3	SE015E	3	W	f	CV027	f	2022-08-09 15:21:09.019698	2022-08-09 15:21:09.019698
633e5dd8-9bcf-4eb7-8214-7f0aeb677c46	SE015E	3	Z	f	CV027	f	2022-08-09 15:21:09.025449	2022-08-09 15:21:09.025449
1622e33a-bf5b-4785-b5c3-a69791422821	SE015E	3	A	t	CV118	f	2022-08-09 15:21:09.032174	2022-08-09 15:21:09.032174
56c7d3d6-57a4-4931-b637-a641fe03f5e8	SE015E	3	D	t	CV118	f	2022-08-09 15:21:09.037781	2022-08-09 15:21:09.037781
1773d298-0788-446a-9a76-0a0dced083d6	SE015E	3	I	t	CV118	f	2022-08-09 15:21:09.043818	2022-08-09 15:21:09.043818
1b0cd3ff-e2c9-4ffc-ba9a-f6807d172451	SE015E	3	W	t	CV118	f	2022-08-09 15:21:09.050195	2022-08-09 15:21:09.050195
1d260b54-9522-4244-be96-a5a06819fbfd	SE015E	3	Z	t	CV118	f	2022-08-09 15:21:09.055661	2022-08-09 15:21:09.055661
5712268e-bebb-47f3-897e-3ac4ccd22def	SE015E	3	A	f	CV118	f	2022-08-09 15:21:09.061357	2022-08-09 15:21:09.061357
39f3021d-6242-4690-b3a1-9773adb1feeb	SE015E	3	D	f	CV118	f	2022-08-09 15:21:09.067255	2022-08-09 15:21:09.067255
abccaff3-76d4-42c8-8cfe-ea4640b930bc	SE015E	3	I	f	CV118	f	2022-08-09 15:21:09.07304	2022-08-09 15:21:09.07304
30622538-ba8f-4882-81a3-98ab6bd339f5	SE015E	3	W	f	CV118	f	2022-08-09 15:21:09.079952	2022-08-09 15:21:09.079952
79b852a0-44c3-4a5a-996c-e87dc57dc128	SE015E	3	Z	f	CV118	f	2022-08-09 15:21:09.086943	2022-08-09 15:21:09.086943
a6b9466e-be10-46de-bc92-3e056db232b5	SE015E	3	A	t	EF012	f	2022-08-09 15:21:09.092092	2022-08-09 15:21:09.092092
1331afb4-5530-4edd-ad7f-160ec68f9fe8	SE015E	3	D	t	EF012	f	2022-08-09 15:21:09.098112	2022-08-09 15:21:09.098112
986f13fc-64fa-4ebc-8b88-2e1b734ad46d	SE015E	3	I	t	EF012	f	2022-08-09 15:21:09.104376	2022-08-09 15:21:09.104376
300943f3-60a3-4c2a-b7d1-178c1f3d1ba9	SE015E	3	W	t	EF012	f	2022-08-09 15:21:09.11072	2022-08-09 15:21:09.11072
2f5df719-6fb5-4024-abf6-fb3cf4359487	SE015E	3	Z	t	EF012	f	2022-08-09 15:21:09.116877	2022-08-09 15:21:09.116877
3aafadb7-9a40-4a97-b026-8ace532631cb	SE015E	3	A	f	EF012	f	2022-08-09 15:21:09.122693	2022-08-09 15:21:09.122693
d1771404-455c-4206-a57f-3ea22215153e	SE015E	3	D	f	EF012	f	2022-08-09 15:21:09.129035	2022-08-09 15:21:09.129035
73546edd-0a09-4483-894b-65aed2cbae6f	SE015E	3	I	f	EF012	f	2022-08-09 15:21:09.134585	2022-08-09 15:21:09.134585
118feef8-1863-44b4-a548-f5228dcd2ec3	SE015E	3	W	f	EF012	f	2022-08-09 15:21:09.140543	2022-08-09 15:21:09.140543
b1510e06-a43c-4eb8-9567-dc03b849789b	SE015E	3	Z	f	EF012	f	2022-08-09 15:21:09.146585	2022-08-09 15:21:09.146585
4ad785d6-926a-47f8-a06e-97e6143c1ff4	SE015E	3	A	t	EF022	f	2022-08-09 15:21:09.153086	2022-08-09 15:21:09.153086
3bb2e483-f1cd-4fbe-bcb3-79ae0dec70fa	SE015E	3	D	t	EF022	f	2022-08-09 15:21:09.160099	2022-08-09 15:21:09.160099
6c77a5af-59e8-44d4-979c-6cd5cdb18187	SE015E	3	I	t	EF022	f	2022-08-09 15:21:09.166108	2022-08-09 15:21:09.166108
5e767fda-6bee-418f-ad61-b16191422441	SE015E	3	W	t	EF022	f	2022-08-09 15:21:09.172229	2022-08-09 15:21:09.172229
df118b0a-589e-48d3-bc09-c2c0c2c07b75	SE015E	3	Z	t	EF022	f	2022-08-09 15:21:09.17959	2022-08-09 15:21:09.17959
682d7783-1925-431f-9677-08e46f05eb15	SE015E	3	A	f	EF022	f	2022-08-09 15:21:09.185726	2022-08-09 15:21:09.185726
14d9a882-6998-4b3d-a1b2-c98de3be640d	SE015E	3	D	f	EF022	f	2022-08-09 15:21:09.190961	2022-08-09 15:21:09.190961
f1c48a79-0e99-4d92-9fb2-a21dc0f78ed5	SE015E	3	I	f	EF022	f	2022-08-09 15:21:09.196035	2022-08-09 15:21:09.196035
46c6f75f-c393-43d2-a239-1d23d7f0fffc	SE015E	3	W	f	EF022	f	2022-08-09 15:21:09.203131	2022-08-09 15:21:09.203131
fd6ca1b3-6294-4b43-9bca-1845f4cb750d	SE015E	3	Z	f	EF022	f	2022-08-09 15:21:09.208886	2022-08-09 15:21:09.208886
9e5d3de7-971f-4330-9e98-c077cc893404	SE015E	3	A	t	EF025	f	2022-08-09 15:21:09.215082	2022-08-09 15:21:09.215082
bb225b13-a78c-4da8-bc5c-233a5bb15b3d	SE015E	3	D	t	EF025	f	2022-08-09 15:21:09.221104	2022-08-09 15:21:09.221104
027b829a-6c06-41fd-b3ee-1514b89db7d4	SE015E	3	I	t	EF025	f	2022-08-09 15:21:09.226394	2022-08-09 15:21:09.226394
4a91dc8d-669b-4a82-8257-5363b26b3b2f	SE015E	3	W	t	EF025	f	2022-08-09 15:21:09.232301	2022-08-09 15:21:09.232301
b7a30338-0111-4f0c-82d6-83267ca93a88	SE015E	3	Z	t	EF025	f	2022-08-09 15:21:09.237719	2022-08-09 15:21:09.237719
0185cce1-0b08-453b-98fc-51d00bd4980f	SE015E	3	A	f	EF025	f	2022-08-09 15:21:09.243691	2022-08-09 15:21:09.243691
2505475e-8c5d-4519-9bb3-707fdb07e5d8	SE015E	3	D	f	EF025	f	2022-08-09 15:21:09.249788	2022-08-09 15:21:09.249788
0bd41244-3745-47c2-ae64-2d4d5ae91959	SE015E	3	I	f	EF025	f	2022-08-09 15:21:09.256037	2022-08-09 15:21:09.256037
330efbd2-e846-4f74-bf0b-f54f59dae9ff	SE015E	3	W	f	EF025	f	2022-08-09 15:21:09.261978	2022-08-09 15:21:09.261978
9c98a45f-a439-48fd-a3ab-650bb8c56d67	SE015E	3	Z	f	EF025	f	2022-08-09 15:21:09.268308	2022-08-09 15:21:09.268308
b116b96b-3e93-42fd-adb3-f9d83430e3cb	SE015E	3	A	t	EF026	f	2022-08-09 15:21:09.274143	2022-08-09 15:21:09.274143
f752a209-2d66-4f48-b6fd-702fc45b1216	SE015E	3	D	t	EF026	f	2022-08-09 15:21:09.280623	2022-08-09 15:21:09.280623
3b3c0cf0-0452-427e-8fee-9f781a01feec	SE015E	3	I	t	EF026	f	2022-08-09 15:21:09.286775	2022-08-09 15:21:09.286775
6f05ea79-4f3b-45f2-85be-45c725250469	SE015E	3	W	t	EF026	f	2022-08-09 15:21:09.292812	2022-08-09 15:21:09.292812
9194acf9-ea60-4ce8-a1f0-2ef8cb0e88de	SE015E	3	Z	t	EF026	f	2022-08-09 15:21:09.298279	2022-08-09 15:21:09.298279
fd619359-b1ca-4c88-90b0-2e9a9acc2fb7	SE015E	3	A	f	EF026	f	2022-08-09 15:21:09.304585	2022-08-09 15:21:09.304585
8caf9bbf-ac0f-4f4b-859e-8c51756cfaea	SE015E	3	D	f	EF026	f	2022-08-09 15:21:09.310193	2022-08-09 15:21:09.310193
e431177d-7471-47d3-97f5-c4380289ef01	SE015E	3	I	f	EF026	f	2022-08-09 15:21:09.315779	2022-08-09 15:21:09.315779
7023c012-2fec-41d4-87bf-b21aef8b457c	SE015E	3	W	f	EF026	f	2022-08-09 15:21:09.32237	2022-08-09 15:21:09.32237
8f0d4fb0-3a03-43c1-81b2-cb10d31af23c	SE015E	3	Z	f	EF026	f	2022-08-09 15:21:09.328696	2022-08-09 15:21:09.328696
58461247-58d1-47aa-8598-aa3f60e0bc2f	SE015E	3	A	t	EF027	f	2022-08-09 15:21:09.334302	2022-08-09 15:21:09.334302
be329824-11fb-4506-a243-418bb720db7c	SE015E	3	D	t	EF027	f	2022-08-09 15:21:09.340263	2022-08-09 15:21:09.340263
ed07e837-1324-4d35-8c56-27d44bc2896c	SE015E	3	I	t	EF027	f	2022-08-09 15:21:09.34621	2022-08-09 15:21:09.34621
80775aca-2ffa-45a8-808e-bf938e7e21a6	SE015E	3	W	t	EF027	f	2022-08-09 15:21:09.353857	2022-08-09 15:21:09.353857
663856c7-593f-4b04-9160-a0009673fc8f	SE015E	3	Z	t	EF027	f	2022-08-09 15:21:09.35952	2022-08-09 15:21:09.35952
144c7084-f8a0-4b43-b77e-812f3846f15e	SE015E	3	A	f	EF027	f	2022-08-09 15:21:09.365395	2022-08-09 15:21:09.365395
32f63c26-966d-4013-9368-ce0290e8bf67	SE015E	3	D	f	EF027	f	2022-08-09 15:21:09.372615	2022-08-09 15:21:09.372615
8ac67471-a615-4c28-9a9d-7bd20c010d97	SE015E	3	I	f	EF027	f	2022-08-09 15:21:09.379584	2022-08-09 15:21:09.379584
4e9d0ea3-3984-4477-b0b2-85f800161b46	SE015E	3	W	f	EF027	f	2022-08-09 15:21:09.386549	2022-08-09 15:21:09.386549
1758cccc-5862-4862-bcd4-891438b88028	SE015E	3	Z	f	EF027	f	2022-08-09 15:21:09.391813	2022-08-09 15:21:09.391813
639293bb-6323-431d-be62-6f464ab918a2	SE015E	3	A	t	FM049	f	2022-08-09 15:21:09.457844	2022-08-09 15:21:09.457844
c427a743-0b35-415a-91f2-e8548f10986f	SE015E	3	D	t	FM049	f	2022-08-09 15:21:09.463717	2022-08-09 15:21:09.463717
44a2d9d4-bc74-462d-84c7-e31a2897ff74	SE015E	3	I	t	FM049	f	2022-08-09 15:21:09.469669	2022-08-09 15:21:09.469669
e825f5b9-680d-481c-ad68-716f69c5f585	SE015E	3	W	t	FM049	f	2022-08-09 15:21:09.475178	2022-08-09 15:21:09.475178
f66e214c-d5e4-4718-9823-7e5f07a03a3e	SE015E	3	Z	t	FM049	f	2022-08-09 15:21:09.481444	2022-08-09 15:21:09.481444
033c520f-c13f-4e51-9084-ea1967867d91	SE015E	3	A	f	FM049	f	2022-08-09 15:21:09.487456	2022-08-09 15:21:09.487456
35d6575d-bb32-43b8-b84c-0b91275a619a	SE015E	3	D	f	FM049	f	2022-08-09 15:21:09.4934	2022-08-09 15:21:09.4934
a452104c-4c24-4990-8dab-a2a6d502fba0	SE015E	3	I	f	FM049	f	2022-08-09 15:21:09.499665	2022-08-09 15:21:09.499665
6940c6d4-6c02-4a44-b171-bcad6421a1c8	SE015E	3	W	f	FM049	f	2022-08-09 15:21:09.50576	2022-08-09 15:21:09.50576
b1915e47-4176-44ac-bb74-29422fcbcba8	SE015E	3	Z	f	FM049	f	2022-08-09 15:21:09.51215	2022-08-09 15:21:09.51215
3a6065b0-e4b6-4c01-87a3-27f6af12de1b	SE015E	3	A	t	MC029	f	2022-08-09 15:21:09.518114	2022-08-09 15:21:09.518114
f9663b81-17ba-44fe-b03f-ca21dcd036b2	SE015E	3	D	t	MC029	f	2022-08-09 15:21:09.523977	2022-08-09 15:21:09.523977
431554f2-4cae-4309-a1b1-e517aee68ad5	SE015E	3	I	t	MC029	f	2022-08-09 15:21:09.529979	2022-08-09 15:21:09.529979
0a3b3b76-b32e-4b53-b197-286a8765801a	SE015E	3	W	t	MC029	f	2022-08-09 15:21:09.536148	2022-08-09 15:21:09.536148
add134b6-fb1b-4daa-a4ad-ac47ad954486	SE015E	3	Z	t	MC029	f	2022-08-09 15:21:09.541893	2022-08-09 15:21:09.541893
c5233545-5586-46ab-bafd-b55de594ac38	SE015E	3	A	f	MC029	f	2022-08-09 15:21:09.548117	2022-08-09 15:21:09.548117
eaf09b10-32d0-4cd6-8647-889792e5dcf2	SE015E	3	D	f	MC029	f	2022-08-09 15:21:09.555449	2022-08-09 15:21:09.555449
eabc7bee-7dbc-409f-959f-057a44efdb25	SE015E	3	I	f	MC029	f	2022-08-09 15:21:09.562555	2022-08-09 15:21:09.562555
3734e336-ce7f-4da9-a8b7-14fe3801380d	SE015E	3	W	f	MC029	f	2022-08-09 15:21:09.568734	2022-08-09 15:21:09.568734
cb65daaa-8099-49ba-84b6-32aae4057ec5	SE015E	3	Z	f	MC029	f	2022-08-09 15:21:09.574717	2022-08-09 15:21:09.574717
5a8eedbb-7bc4-4fc1-881a-51e1bd4a2079	SE015E	3	A	f	FM019	t	2022-08-09 15:21:09.427944	2022-08-09 15:21:09.584115
8204b4d1-6295-46c3-b35e-add8c966491c	SE015E	3	D	f	FM019	t	2022-08-09 15:21:09.43473	2022-08-09 15:21:09.591783
759d3a14-a9bc-495c-b7bd-6a30b51a5fe4	SE015E	3	I	f	FM019	t	2022-08-09 15:21:09.440422	2022-08-09 15:21:09.599531
13d852da-2357-4447-9613-0c1c582e6ff2	SE015E	3	W	f	FM019	t	2022-08-09 15:21:09.445869	2022-08-09 15:21:09.60808
1102f5dc-5930-4d44-abb2-1644338e7ab2	SE015E	3	Z	f	FM019	t	2022-08-09 15:21:09.451777	2022-08-09 15:21:09.614871
a85f6d2f-f52b-4a75-a407-631b9d7210de	SE015E	3	A	t	FM019	t	2022-08-09 15:21:09.397313	2022-08-09 15:21:09.62198
be7175cb-a1e7-4af6-a392-fe4d9c000fff	SE015E	3	D	t	FM019	t	2022-08-09 15:21:09.403871	2022-08-09 15:21:09.629586
6af980a2-63a4-4f8b-beb4-820780337c00	SE015E	3	I	t	FM019	t	2022-08-09 15:21:09.409897	2022-08-09 15:21:09.638785
7526efa1-6e42-4b68-8c91-33980506c9c1	SE015E	3	W	t	FM019	t	2022-08-09 15:21:09.415672	2022-08-09 15:21:09.646792
0bd383b9-d7f2-4970-82b4-e5e29123893e	SE015E	3	Z	t	FM019	t	2022-08-09 15:21:09.421338	2022-08-09 15:21:09.653814
b7125391-be88-4122-bd3c-aad67b676fc1	SE016E	3	A	t	CV027	f	2022-08-09 15:21:09.659246	2022-08-09 15:21:09.659246
bc73aca3-a775-4254-8d12-ed65ba2b46da	SE016E	3	D	t	CV027	f	2022-08-09 15:21:09.665126	2022-08-09 15:21:09.665126
4bb3d305-eac1-4836-ac8c-ca5d5a9070d1	SE016E	3	I	t	CV027	f	2022-08-09 15:21:09.671275	2022-08-09 15:21:09.671275
4c77f31e-9795-4b03-aaef-525106f9cc54	SE016E	3	W	t	CV027	f	2022-08-09 15:21:09.679077	2022-08-09 15:21:09.679077
63b475dd-8a91-4f6b-84e0-aa8729f137d8	SE016E	3	Z	t	CV027	f	2022-08-09 15:21:09.686756	2022-08-09 15:21:09.686756
ceb5cfb1-4f53-4e73-b4bb-695c2d032c28	SE016E	3	A	f	CV027	f	2022-08-09 15:21:09.692656	2022-08-09 15:21:09.692656
801bfad8-0529-41a6-aa18-5f8b95a5eb6d	SE016E	3	D	f	CV027	f	2022-08-09 15:21:09.697949	2022-08-09 15:21:09.697949
627f138f-5667-443f-842f-46c46d26d0c9	SE016E	3	I	f	CV027	f	2022-08-09 15:21:09.703477	2022-08-09 15:21:09.703477
cdc21d0b-0e91-4975-8c93-31d9bf398d72	SE016E	3	W	f	CV027	f	2022-08-09 15:21:09.70982	2022-08-09 15:21:09.70982
ece6e7db-7c4a-4eae-b964-9dd34cae40d4	SE016E	3	Z	f	CV027	f	2022-08-09 15:21:09.716145	2022-08-09 15:21:09.716145
59424556-acc7-457e-88c1-562eaa49aef3	SE016E	3	A	t	CV118	f	2022-08-09 15:21:09.721826	2022-08-09 15:21:09.721826
5913d8f6-69b0-462c-975d-ebb88d25c21a	SE016E	3	D	t	CV118	f	2022-08-09 15:21:09.727479	2022-08-09 15:21:09.727479
47abff32-e726-4291-b67e-e2826f9c2cdc	SE016E	3	I	t	CV118	f	2022-08-09 15:21:09.733298	2022-08-09 15:21:09.733298
ceb2207c-3252-41c7-8a24-ff6974121253	SE016E	3	W	t	CV118	f	2022-08-09 15:21:09.738642	2022-08-09 15:21:09.738642
87f40ab0-842f-41ba-914e-77198d92aa30	SE016E	3	Z	t	CV118	f	2022-08-09 15:21:09.744425	2022-08-09 15:21:09.744425
88689f29-becc-40d2-a932-91afa50460c9	SE016E	3	A	f	CV118	f	2022-08-09 15:21:09.750678	2022-08-09 15:21:09.750678
7f9c3e03-a521-4531-91ed-8f4a80b4d9d7	SE016E	3	D	f	CV118	f	2022-08-09 15:21:09.7559	2022-08-09 15:21:09.7559
09bb509d-5245-4601-811d-1bf20d9dea6d	SE016E	3	I	f	CV118	f	2022-08-09 15:21:09.761282	2022-08-09 15:21:09.761282
c26819fa-d56c-4d24-b5aa-ebc1f960c0dc	SE016E	3	W	f	CV118	f	2022-08-09 15:21:09.767248	2022-08-09 15:21:09.767248
912f87f1-aec8-4025-b6b1-c0d29a8d95c6	SE016E	3	Z	f	CV118	f	2022-08-09 15:21:09.773279	2022-08-09 15:21:09.773279
2d9a58ef-dbdb-4c3c-91a5-e56a6ddf08a2	SE016E	3	A	t	EF012	f	2022-08-09 15:21:09.780099	2022-08-09 15:21:09.780099
d295dce2-1c9e-4249-a9c8-beba2d7b3177	SE016E	3	D	t	EF012	f	2022-08-09 15:21:09.786226	2022-08-09 15:21:09.786226
f2932a20-1d9e-4868-ad43-ef947391e958	SE016E	3	I	t	EF012	f	2022-08-09 15:21:09.791758	2022-08-09 15:21:09.791758
b8eb489a-db4f-48dc-a65f-f3baf10b8856	SE016E	3	W	t	EF012	f	2022-08-09 15:21:09.797544	2022-08-09 15:21:09.797544
75b226c4-0fdf-4140-9bd0-496ecf75d3aa	SE016E	3	Z	t	EF012	f	2022-08-09 15:21:09.803081	2022-08-09 15:21:09.803081
f1289395-7780-451a-b3bd-5e7f8acec86d	SE016E	3	A	f	EF012	f	2022-08-09 15:21:09.808641	2022-08-09 15:21:09.808641
ca0afc14-946c-4c1d-a278-607af8c3efed	SE016E	3	D	f	EF012	f	2022-08-09 15:21:09.814091	2022-08-09 15:21:09.814091
c738f3e0-94f8-4d5a-8761-603278b7debc	SE016E	3	I	f	EF012	f	2022-08-09 15:21:09.819307	2022-08-09 15:21:09.819307
7d7f892f-3828-4aea-a26a-f4f171f6a917	SE016E	3	W	f	EF012	f	2022-08-09 15:21:09.825041	2022-08-09 15:21:09.825041
827194f3-fd4e-4253-b46e-37b5d233f805	SE016E	3	Z	f	EF012	f	2022-08-09 15:21:09.830216	2022-08-09 15:21:09.830216
a4fe4d5c-98f5-4a9d-bc4b-2ac782f04566	SE016E	3	A	t	EF022	f	2022-08-09 15:21:09.835561	2022-08-09 15:21:09.835561
81d2e7c1-b6b0-465d-93d7-46ac332b2b82	SE016E	3	D	t	EF022	f	2022-08-09 15:21:09.841449	2022-08-09 15:21:09.841449
b2ceaf46-f6fc-400c-a6a8-418d3857e653	SE016E	3	I	t	EF022	f	2022-08-09 15:21:09.84693	2022-08-09 15:21:09.84693
1cdead4b-9bf5-479a-a827-59509ce6a689	SE016E	3	W	t	EF022	f	2022-08-09 15:21:09.852502	2022-08-09 15:21:09.852502
c0e2f143-b1a0-4665-b911-5e1748edd04f	SE016E	3	Z	t	EF022	f	2022-08-09 15:21:09.857904	2022-08-09 15:21:09.857904
676bf761-d91d-4d78-af87-b288ebc0d584	SE016E	3	A	f	EF022	f	2022-08-09 15:21:09.863632	2022-08-09 15:21:09.863632
332bc6f6-6f84-481a-86fc-d31573804c76	SE016E	3	D	f	EF022	f	2022-08-09 15:21:09.868943	2022-08-09 15:21:09.868943
91b70348-5a3a-481a-b737-e13fcb25d584	SE016E	3	I	f	EF022	f	2022-08-09 15:21:09.874886	2022-08-09 15:21:09.874886
281233a3-c7b0-49c1-bac3-ec2f54f62a56	SE016E	3	W	f	EF022	f	2022-08-09 15:21:09.880332	2022-08-09 15:21:09.880332
c77c3c6e-f77a-4059-bebc-55df9b3b1b75	SE016E	3	Z	f	EF022	f	2022-08-09 15:21:09.885601	2022-08-09 15:21:09.885601
4a92c5ad-8407-488b-8f30-e68372013871	SE016E	3	A	t	EF025	f	2022-08-09 15:21:09.892312	2022-08-09 15:21:09.892312
f9447b72-d9d5-4af3-9e67-32e32dafa45b	SE016E	3	D	t	EF025	f	2022-08-09 15:21:09.898096	2022-08-09 15:21:09.898096
815b45a5-439c-4ce3-81d5-ab5c169df791	SE016E	3	I	t	EF025	f	2022-08-09 15:21:09.904051	2022-08-09 15:21:09.904051
db3f5cb6-21d9-452f-96d1-d0a714c38573	SE016E	3	W	t	EF025	f	2022-08-09 15:21:09.909808	2022-08-09 15:21:09.909808
f27eff0d-fd9f-4b32-a6a3-8d4824cb93ab	SE016E	3	Z	t	EF025	f	2022-08-09 15:21:09.915454	2022-08-09 15:21:09.915454
63111558-c7ce-40d5-b60c-9097ac4b7585	SE016E	3	A	f	EF025	f	2022-08-09 15:21:09.921539	2022-08-09 15:21:09.921539
c6ab3102-a68f-4081-98be-149c9ae18500	SE016E	3	D	f	EF025	f	2022-08-09 15:21:09.926923	2022-08-09 15:21:09.926923
1b4f8cdf-bfb4-4089-80a4-5b5e49f7c3c0	SE016E	3	I	f	EF025	f	2022-08-09 15:21:09.932921	2022-08-09 15:21:09.932921
4315ff74-d64d-474f-b96d-244059b6e18f	SE016E	3	W	f	EF025	f	2022-08-09 15:21:09.938203	2022-08-09 15:21:09.938203
96e40be8-28d1-486e-972b-d7423e1598fc	SE016E	3	Z	f	EF025	f	2022-08-09 15:21:09.944251	2022-08-09 15:21:09.944251
6dc6fe96-d5e6-4345-92ab-c950b03d282a	SE016E	3	A	t	EF026	f	2022-08-09 15:21:09.94966	2022-08-09 15:21:09.94966
1bf5be38-b50d-4822-96ad-d11121bfa3ed	SE016E	3	D	t	EF026	f	2022-08-09 15:21:09.955436	2022-08-09 15:21:09.955436
9ba921db-61f8-453f-a365-19d51e6f4327	SE016E	3	I	t	EF026	f	2022-08-09 15:21:09.960974	2022-08-09 15:21:09.960974
2b07f7cb-2d19-458a-8880-310a78abcfa9	SE016E	3	W	t	EF026	f	2022-08-09 15:21:09.966844	2022-08-09 15:21:09.966844
139df796-f779-405f-9148-0af7a255e099	SE016E	3	Z	t	EF026	f	2022-08-09 15:21:09.972171	2022-08-09 15:21:09.972171
df3a020d-7bdf-47cb-9acb-c04c77a9467a	SE016E	3	A	f	EF026	f	2022-08-09 15:21:09.977992	2022-08-09 15:21:09.977992
ddc86baf-2471-496d-84f0-e75b51e22d57	SE016E	3	D	f	EF026	f	2022-08-09 15:21:09.98403	2022-08-09 15:21:09.98403
33c342b7-6f77-4c90-a4d9-51df7645a6eb	SE016E	3	I	f	EF026	f	2022-08-09 15:21:09.990697	2022-08-09 15:21:09.990697
df53e988-51ee-466e-ab7c-5a06bd463c6c	SE016E	3	W	f	EF026	f	2022-08-09 15:21:09.996194	2022-08-09 15:21:09.996194
ed14698b-8851-4cf2-8306-8c8001cdab14	SE016E	3	Z	f	EF026	f	2022-08-09 15:21:10.001795	2022-08-09 15:21:10.001795
a9ba7d7e-8363-42b6-8179-2233d933679d	SE016E	3	A	t	EF027	f	2022-08-09 15:21:10.007513	2022-08-09 15:21:10.007513
0db994b3-e212-4b98-9de5-61d8efb71adb	SE016E	3	D	t	EF027	f	2022-08-09 15:21:10.012941	2022-08-09 15:21:10.012941
183ab105-0a22-4274-b1ec-d95e8f1b546c	SE016E	3	I	t	EF027	f	2022-08-09 15:21:10.018334	2022-08-09 15:21:10.018334
00f30d97-1716-4821-915e-bc010aea3ef7	SE016E	3	W	t	EF027	f	2022-08-09 15:21:10.023933	2022-08-09 15:21:10.023933
aac99306-6da7-4304-8120-12e26dda989d	SE016E	3	Z	t	EF027	f	2022-08-09 15:21:10.029363	2022-08-09 15:21:10.029363
a6298ac2-97ec-485f-9e88-baf301e291ab	SE016E	3	A	f	EF027	f	2022-08-09 15:21:10.035264	2022-08-09 15:21:10.035264
fae0a798-f8d6-4cb0-860b-8900412091d0	SE016E	3	D	f	EF027	f	2022-08-09 15:21:10.041175	2022-08-09 15:21:10.041175
660fdf7d-66c7-477a-816b-1d491db020ee	SE016E	3	I	f	EF027	f	2022-08-09 15:21:10.047408	2022-08-09 15:21:10.047408
1ac12f2e-a934-4f99-9da4-b817caecc59b	SE016E	3	W	f	EF027	f	2022-08-09 15:21:10.052951	2022-08-09 15:21:10.052951
436f8d7a-81ba-4ba9-af0a-d1aa0748c69e	SE016E	3	Z	f	EF027	f	2022-08-09 15:21:10.058354	2022-08-09 15:21:10.058354
552ebf20-420c-4828-9ae9-b472099d391c	SE016E	3	A	t	FM049	f	2022-08-09 15:21:10.12648	2022-08-09 15:21:10.12648
9b56bb9e-fa0b-496e-986c-a7b66cc40760	SE016E	3	D	t	FM049	f	2022-08-09 15:21:10.13434	2022-08-09 15:21:10.13434
ecb6caac-801f-47ad-b962-c167f35e8e4c	SE016E	3	I	t	FM049	f	2022-08-09 15:21:10.143239	2022-08-09 15:21:10.143239
28404e20-7744-4b37-8806-03961c40ab2f	SE016E	3	W	t	FM049	f	2022-08-09 15:21:10.149015	2022-08-09 15:21:10.149015
7613873f-171b-4137-af9d-728ed4cc0d23	SE016E	3	Z	t	FM049	f	2022-08-09 15:21:10.155215	2022-08-09 15:21:10.155215
74238b16-85f2-4a58-9619-7af3b158d59f	SE016E	3	A	f	FM049	f	2022-08-09 15:21:10.160894	2022-08-09 15:21:10.160894
8dc48cef-6f11-47ec-83a7-fcaf732737a8	SE016E	3	D	f	FM049	f	2022-08-09 15:21:10.166544	2022-08-09 15:21:10.166544
d714188a-a915-42ac-90e1-d35b7e15cdbb	SE016E	3	I	f	FM049	f	2022-08-09 15:21:10.17186	2022-08-09 15:21:10.17186
ee6c82f0-7fb7-4556-89df-bcaba517de3d	SE016E	3	W	f	FM049	f	2022-08-09 15:21:10.177925	2022-08-09 15:21:10.177925
6d56627a-e778-4876-86ef-0a8adc1dc600	SE016E	3	Z	f	FM049	f	2022-08-09 15:21:10.186007	2022-08-09 15:21:10.186007
e8d6a696-7479-459c-b786-e71458dc074b	SE016E	3	A	t	MC029	f	2022-08-09 15:21:10.192087	2022-08-09 15:21:10.192087
508f8645-c9ad-4a34-abf7-7414f1ea0b0e	SE016E	3	D	t	MC029	f	2022-08-09 15:21:10.198399	2022-08-09 15:21:10.198399
79442797-6ac0-4655-82a8-6dd4530f7a7c	SE016E	3	I	t	MC029	f	2022-08-09 15:21:10.203873	2022-08-09 15:21:10.203873
a27e0b71-c4b5-4685-8569-ee9da6494355	SE016E	3	W	t	MC029	f	2022-08-09 15:21:10.209728	2022-08-09 15:21:10.209728
320ad3db-4770-4f9b-ad3c-ae819e33a901	SE016E	3	Z	t	MC029	f	2022-08-09 15:21:10.215504	2022-08-09 15:21:10.215504
ede2c9aa-a55b-4ca8-8189-916aa3951438	SE016E	3	A	f	MC029	f	2022-08-09 15:21:10.221277	2022-08-09 15:21:10.221277
494f9e5e-1612-4113-9321-0fd9cbbbd8b7	SE016E	3	D	f	MC029	f	2022-08-09 15:21:10.22687	2022-08-09 15:21:10.22687
7de7cdc1-72f1-4845-a206-17118e7f65c2	SE016E	3	I	f	MC029	f	2022-08-09 15:21:10.232444	2022-08-09 15:21:10.232444
de6ad770-4ec9-418a-b92a-6128c61b7c2f	SE016E	3	W	f	MC029	f	2022-08-09 15:21:10.239865	2022-08-09 15:21:10.239865
16c9c441-12e3-44a5-8f9f-8dd36d82a8f2	SE016E	3	Z	f	MC029	f	2022-08-09 15:21:10.246622	2022-08-09 15:21:10.246622
97caa736-ac42-4a68-953f-0817f3d76951	SE016E	3	A	f	FM019	t	2022-08-09 15:21:10.098011	2022-08-09 15:21:10.253808
5600bf41-0abd-4393-b8e1-0065a9432e16	SE016E	3	D	f	FM019	t	2022-08-09 15:21:10.103716	2022-08-09 15:21:10.261439
d63f95bd-34c4-4aa3-873b-1e98fed4671a	SE016E	3	I	f	FM019	t	2022-08-09 15:21:10.10907	2022-08-09 15:21:10.268985
e2c3f749-2a01-43c6-b7f0-356a7bdf4a11	SE016E	3	W	f	FM019	t	2022-08-09 15:21:10.114979	2022-08-09 15:21:10.276537
d023510b-cf8b-428a-8351-64c7927cbc6f	SE016E	3	Z	f	FM019	t	2022-08-09 15:21:10.120528	2022-08-09 15:21:10.283726
0f2bd6ce-03c7-44f6-90c3-fd29717957d2	SE016E	3	A	t	FM019	t	2022-08-09 15:21:10.063945	2022-08-09 15:21:10.291458
b4a345ed-6510-4f64-9d2a-cede85777b21	SE016E	3	D	t	FM019	t	2022-08-09 15:21:10.069284	2022-08-09 15:21:10.298835
5162b069-2539-4af6-ad6f-f5cb4e17ffc9	SE016E	3	I	t	FM019	t	2022-08-09 15:21:10.074585	2022-08-09 15:21:10.306638
8df1aec5-501a-4d0e-9940-a3b53fe84ed1	SE016E	3	W	t	FM019	t	2022-08-09 15:21:10.08277	2022-08-09 15:21:10.315524
4ae8a45b-ad4f-4eed-af89-b8c28ab030e1	SE016E	3	Z	t	FM019	t	2022-08-09 15:21:10.089962	2022-08-09 15:21:10.323978
779be545-57bd-4f84-a5b6-eff7346ae6c0	SE096E	3	A	t	CV027	f	2022-08-09 15:21:10.329568	2022-08-09 15:21:10.329568
e7e7c7e6-a0ec-4887-9ddf-c6b9a8f2e7c9	SE096E	3	D	t	CV027	f	2022-08-09 15:21:10.335352	2022-08-09 15:21:10.335352
96283290-f5fc-436b-b950-8fb33a99d01f	SE096E	3	I	t	CV027	f	2022-08-09 15:21:10.340702	2022-08-09 15:21:10.340702
5a836270-7167-4463-91b9-aa6d7bc14c93	SE096E	3	W	t	CV027	f	2022-08-09 15:21:10.346257	2022-08-09 15:21:10.346257
0146c224-93a9-407d-bef1-19189beaa169	SE096E	3	Z	t	CV027	f	2022-08-09 15:21:10.353275	2022-08-09 15:21:10.353275
fdedee66-416f-4889-85ee-dff49510b7ce	SE096E	3	A	f	CV027	f	2022-08-09 15:21:10.359423	2022-08-09 15:21:10.359423
9ad8f92d-13c0-43ef-93e3-86fca439d9dc	SE096E	3	D	f	CV027	f	2022-08-09 15:21:10.365466	2022-08-09 15:21:10.365466
77c43be7-834a-41cc-b802-09ca2a68b10f	SE096E	3	I	f	CV027	f	2022-08-09 15:21:10.372025	2022-08-09 15:21:10.372025
49115070-97ce-41b5-8659-f68e00765a1e	SE096E	3	W	f	CV027	f	2022-08-09 15:21:10.377975	2022-08-09 15:21:10.377975
324aa644-01b6-4182-bf5a-3eb09c9f9fe4	SE096E	3	Z	f	CV027	f	2022-08-09 15:21:10.383893	2022-08-09 15:21:10.383893
e3fce1e1-a1ce-4763-8a68-95259089814e	SE096E	3	A	t	CV118	f	2022-08-09 15:21:10.389986	2022-08-09 15:21:10.389986
9324e1f6-a13f-4ae4-a35e-fb38b1d9f03c	SE096E	3	D	t	CV118	f	2022-08-09 15:21:10.395778	2022-08-09 15:21:10.395778
bad5bc34-cc0c-4196-9cb7-80020f69819a	SE096E	3	I	t	CV118	f	2022-08-09 15:21:10.401163	2022-08-09 15:21:10.401163
67ae6912-90f4-47d7-82cd-4f1c4aba07f2	SE096E	3	W	t	CV118	f	2022-08-09 15:21:10.406532	2022-08-09 15:21:10.406532
9f77462f-b9ea-4b45-97dd-c14be7f273d9	SE096E	3	Z	t	CV118	f	2022-08-09 15:21:10.412317	2022-08-09 15:21:10.412317
f459c791-1944-4326-921f-b6c40026706f	SE096E	3	A	f	CV118	f	2022-08-09 15:21:10.417829	2022-08-09 15:21:10.417829
f42e0af4-18cc-427a-b6d4-8413f9e5f1df	SE096E	3	D	f	CV118	f	2022-08-09 15:21:10.423138	2022-08-09 15:21:10.423138
4952a59b-05cc-44aa-a92d-7aba34cfb062	SE096E	3	I	f	CV118	f	2022-08-09 15:21:10.428691	2022-08-09 15:21:10.428691
cef6fd93-b553-498a-96d5-6d889d638ac1	SE096E	3	W	f	CV118	f	2022-08-09 15:21:10.434064	2022-08-09 15:21:10.434064
01fe5f92-d763-4da8-ba4c-be768bfeb705	SE096E	3	Z	f	CV118	f	2022-08-09 15:21:10.439771	2022-08-09 15:21:10.439771
53d55df6-2054-4851-a922-199be28c84e9	SE096E	3	A	t	EF012	f	2022-08-09 15:21:10.445062	2022-08-09 15:21:10.445062
2f29f09a-fd0d-4cee-85e0-604dfbe986cf	SE096E	3	D	t	EF012	f	2022-08-09 15:21:10.451813	2022-08-09 15:21:10.451813
1bed4cb7-ad0f-4e1a-9bbf-7aab0cb35991	SE096E	3	I	t	EF012	f	2022-08-09 15:21:10.458816	2022-08-09 15:21:10.458816
5fb503c1-adf6-4f43-970b-db2fc6b3f3d1	SE096E	3	W	t	EF012	f	2022-08-09 15:21:10.464683	2022-08-09 15:21:10.464683
f607abd1-0619-4cb9-bf26-fe319486540d	SE096E	3	Z	t	EF012	f	2022-08-09 15:21:10.469935	2022-08-09 15:21:10.469935
d6482756-c1c4-4444-8014-3d2dba94c761	SE096E	3	A	f	EF012	f	2022-08-09 15:21:10.475588	2022-08-09 15:21:10.475588
420636e4-f16d-4d96-a47b-f17e8fe57f19	SE096E	3	D	f	EF012	f	2022-08-09 15:21:10.481719	2022-08-09 15:21:10.481719
4ffd0b15-6f42-4dee-a85f-20a4eb102f09	SE096E	3	I	f	EF012	f	2022-08-09 15:21:10.487413	2022-08-09 15:21:10.487413
94199737-0690-49b3-bdb0-5bda24f73b22	SE096E	3	W	f	EF012	f	2022-08-09 15:21:10.492846	2022-08-09 15:21:10.492846
5339c6dc-f19a-47c9-9c50-3bc36ec7d834	SE096E	3	Z	f	EF012	f	2022-08-09 15:21:10.498037	2022-08-09 15:21:10.498037
aaa18465-8ff5-4ef3-8882-3ce982de1686	SE096E	3	A	t	EF022	f	2022-08-09 15:21:10.503623	2022-08-09 15:21:10.503623
9f1c31d9-b4ef-4297-aa33-9e69b9a0eba0	SE096E	3	D	t	EF022	f	2022-08-09 15:21:10.508864	2022-08-09 15:21:10.508864
301bd641-c963-4b57-a8dc-6a7086b42b4e	SE096E	3	I	t	EF022	f	2022-08-09 15:21:10.514014	2022-08-09 15:21:10.514014
85cf965a-424e-4f38-9f67-3bf1e213e7b0	SE096E	3	W	t	EF022	f	2022-08-09 15:21:10.519458	2022-08-09 15:21:10.519458
4a9b9de2-ad9b-4e7f-968d-3381beddee58	SE096E	3	Z	t	EF022	f	2022-08-09 15:21:10.524664	2022-08-09 15:21:10.524664
0fd4eee9-0501-4f86-8570-171d50b17fac	SE096E	3	A	f	EF022	f	2022-08-09 15:21:10.530287	2022-08-09 15:21:10.530287
1d081b36-ca04-4e3d-8205-6cf20d531a3f	SE096E	3	D	f	EF022	f	2022-08-09 15:21:10.535616	2022-08-09 15:21:10.535616
36d9e1a3-83a5-4ce7-a0e5-ffa4a2b32463	SE096E	3	I	f	EF022	f	2022-08-09 15:21:10.541406	2022-08-09 15:21:10.541406
10bc0564-78fe-45fe-8acd-89a911cb82ec	SE096E	3	W	f	EF022	f	2022-08-09 15:21:10.54682	2022-08-09 15:21:10.54682
91a8575c-0168-495c-91c3-de5f8116dd9a	SE096E	3	Z	f	EF022	f	2022-08-09 15:21:10.552438	2022-08-09 15:21:10.552438
ce1d22a8-9c5b-4884-895b-75fbe98d289c	SE096E	3	A	t	EF025	f	2022-08-09 15:21:10.557749	2022-08-09 15:21:10.557749
eb6183ad-c0c3-4573-96fe-585bb0a4eeeb	SE096E	3	D	t	EF025	f	2022-08-09 15:21:10.563251	2022-08-09 15:21:10.563251
ed5c1e87-308c-4cd8-bf15-3aec19ddb366	SE096E	3	I	t	EF025	f	2022-08-09 15:21:10.570227	2022-08-09 15:21:10.570227
bdbba9e1-97c9-4dbf-a315-32fce6e008ea	SE096E	3	W	t	EF025	f	2022-08-09 15:21:10.575781	2022-08-09 15:21:10.575781
24df5ff9-9cdc-4149-a639-87ebe0bbb3e3	SE096E	3	Z	t	EF025	f	2022-08-09 15:21:10.584813	2022-08-09 15:21:10.584813
7f3c2c3f-e5a3-4654-b1aa-5fe783acda3c	SE096E	3	A	f	EF025	f	2022-08-09 15:21:10.591626	2022-08-09 15:21:10.591626
e217f5f6-fd6c-470c-9e81-9dbaf89b376b	SE096E	3	D	f	EF025	f	2022-08-09 15:21:10.59758	2022-08-09 15:21:10.59758
70da9a44-eeb4-4023-b8a2-ae569ccaea50	SE096E	3	I	f	EF025	f	2022-08-09 15:21:10.605607	2022-08-09 15:21:10.605607
aa94ed26-18a4-4ae0-aed7-b3d532d8028b	SE096E	3	W	f	EF025	f	2022-08-09 15:21:10.612619	2022-08-09 15:21:10.612619
973c2f07-ad02-4676-bd8e-c7cb02fb5773	SE096E	3	Z	f	EF025	f	2022-08-09 15:21:10.618901	2022-08-09 15:21:10.618901
098c709e-e918-4d04-8ce0-ff3acea33d23	SE096E	3	A	t	EF026	f	2022-08-09 15:21:10.624506	2022-08-09 15:21:10.624506
7f451665-f1ec-47ed-9b8d-4f44767b6eea	SE096E	3	D	t	EF026	f	2022-08-09 15:21:10.631297	2022-08-09 15:21:10.631297
44e897c9-2161-4144-bcc0-37614d604b3b	SE096E	3	I	t	EF026	f	2022-08-09 15:21:10.657139	2022-08-09 15:21:10.657139
646208e0-0786-4694-9099-4e7753f53135	SE096E	3	W	t	EF026	f	2022-08-09 15:21:10.664035	2022-08-09 15:21:10.664035
ee804c1b-74fd-4735-a152-1e416ce695cb	SE096E	3	Z	t	EF026	f	2022-08-09 15:21:10.67088	2022-08-09 15:21:10.67088
b4ac2c7b-d09b-4cbb-b1b6-93e7121264f6	SE096E	3	A	f	EF026	f	2022-08-09 15:21:10.678097	2022-08-09 15:21:10.678097
7fba3f2c-f9f3-4915-a1aa-eac1c2c4449d	SE096E	3	D	f	EF026	f	2022-08-09 15:21:10.684089	2022-08-09 15:21:10.684089
f7b67716-9b32-4cc0-834f-039b79aea546	SE096E	3	I	f	EF026	f	2022-08-09 15:21:10.69009	2022-08-09 15:21:10.69009
d6c0affa-1fbd-4563-9f15-7768c0b4a342	SE096E	3	W	f	EF026	f	2022-08-09 15:21:10.69585	2022-08-09 15:21:10.69585
7de4ee9c-e31d-4b7b-b086-f4e10ab3e66d	SE096E	3	Z	f	EF026	f	2022-08-09 15:21:10.704277	2022-08-09 15:21:10.704277
d78f0ead-bab3-4305-ac75-7c1cb7b6b3a8	SE096E	3	A	t	EF027	f	2022-08-09 15:21:10.712423	2022-08-09 15:21:10.712423
a986f5e5-b951-45fd-9082-1d3f52969d89	SE096E	3	D	t	EF027	f	2022-08-09 15:21:10.722282	2022-08-09 15:21:10.722282
ea649a7e-ec88-4ee8-a6e4-b79cd3d611f3	SE096E	3	I	t	EF027	f	2022-08-09 15:21:10.736588	2022-08-09 15:21:10.736588
49b0db5a-6b26-4da6-bf14-419ab57e93ea	SE096E	3	W	t	EF027	f	2022-08-09 15:21:10.742609	2022-08-09 15:21:10.742609
68f9a822-9711-4d7e-9245-3f32630a9bd2	SE096E	3	Z	t	EF027	f	2022-08-09 15:21:10.748234	2022-08-09 15:21:10.748234
b084fc94-8a2a-4953-9679-407475bca526	SE096E	3	A	f	EF027	f	2022-08-09 15:21:10.754023	2022-08-09 15:21:10.754023
74fd0506-1ea7-4ce0-9564-c9afadca9213	SE096E	3	D	f	EF027	f	2022-08-09 15:21:10.759274	2022-08-09 15:21:10.759274
c34dea7a-95f2-4071-ba58-865710ffbdfe	SE096E	3	I	f	EF027	f	2022-08-09 15:21:10.765225	2022-08-09 15:21:10.765225
e2925e17-1a9f-4cf5-abb2-e2521cf73b93	SE096E	3	W	f	EF027	f	2022-08-09 15:21:10.770985	2022-08-09 15:21:10.770985
53ae5320-0daf-45ce-985e-e6ba178ff810	SE096E	3	Z	f	EF027	f	2022-08-09 15:21:10.77667	2022-08-09 15:21:10.77667
3f639a17-3382-4318-8bb4-4cb52f0c9ac3	SE096E	3	A	t	FM049	f	2022-08-09 15:21:10.838016	2022-08-09 15:21:10.838016
ce504f01-59d6-4d30-acb2-c7b01f28959e	SE096E	3	D	t	FM049	f	2022-08-09 15:21:10.84385	2022-08-09 15:21:10.84385
4d0a1fc3-1104-413f-bce5-04375888cab8	SE096E	3	I	t	FM049	f	2022-08-09 15:21:10.849558	2022-08-09 15:21:10.849558
7b372065-9391-4c45-8571-0190a0dc9bd3	SE096E	3	W	t	FM049	f	2022-08-09 15:21:10.855499	2022-08-09 15:21:10.855499
2106caed-52a8-4c49-b233-ea929105d4b7	SE096E	3	Z	t	FM049	f	2022-08-09 15:21:10.860924	2022-08-09 15:21:10.860924
6d16c8f1-70cb-49ef-abfe-befaeaabb756	SE096E	3	A	f	FM049	f	2022-08-09 15:21:10.866522	2022-08-09 15:21:10.866522
be425213-7783-42a3-8688-562a801ba1c5	SE096E	3	D	f	FM049	f	2022-08-09 15:21:10.87254	2022-08-09 15:21:10.87254
c4aba917-ff11-4f8f-b8a8-64dc84124369	SE096E	3	I	f	FM049	f	2022-08-09 15:21:10.878334	2022-08-09 15:21:10.878334
0c26f05b-2bbb-4d2c-b9db-4088d80d6996	SE096E	3	W	f	FM049	f	2022-08-09 15:21:10.884414	2022-08-09 15:21:10.884414
2526997a-3667-4be6-92f7-0071256d1100	SE096E	3	Z	f	FM049	f	2022-08-09 15:21:10.889849	2022-08-09 15:21:10.889849
76579789-49a5-49d9-a094-2422f5dc6ee6	SE096E	3	A	t	MC029	f	2022-08-09 15:21:10.895454	2022-08-09 15:21:10.895454
eddad04d-d6f2-464b-8cee-2cb79e3792b1	SE096E	3	D	t	MC029	f	2022-08-09 15:21:10.90106	2022-08-09 15:21:10.90106
a0a06352-c3f2-424d-aa8f-115d8766254f	SE096E	3	I	t	MC029	f	2022-08-09 15:21:10.906323	2022-08-09 15:21:10.906323
41b0080a-478a-4309-aaff-8530d7b371d4	SE096E	3	W	t	MC029	f	2022-08-09 15:21:10.911918	2022-08-09 15:21:10.911918
4dfc6fb0-a9fb-4ec3-8641-0023a17c40e6	SE096E	3	Z	t	MC029	f	2022-08-09 15:21:10.917291	2022-08-09 15:21:10.917291
2381e053-aaa6-4230-8856-c5c158d54353	SE096E	3	A	f	MC029	f	2022-08-09 15:21:10.922856	2022-08-09 15:21:10.922856
c223e6d3-e1f6-4482-8912-4baea3f9ab2a	SE096E	3	D	f	MC029	f	2022-08-09 15:21:10.928416	2022-08-09 15:21:10.928416
9ac87e99-5680-403f-b070-25fd325a0fd1	SE096E	3	I	f	MC029	f	2022-08-09 15:21:10.934087	2022-08-09 15:21:10.934087
12449736-fb5d-4b19-8695-b2d34694e8fe	SE096E	3	W	f	MC029	f	2022-08-09 15:21:10.940495	2022-08-09 15:21:10.940495
92dbaaf5-2f8a-45bc-827b-c951b1db5b74	SE096E	3	Z	f	MC029	f	2022-08-09 15:21:10.946573	2022-08-09 15:21:10.946573
f95e726f-1472-46fb-90b1-582af641e1ea	SE096E	3	A	f	FM019	t	2022-08-09 15:21:10.810249	2022-08-09 15:21:10.955628
6058b871-b780-4d40-a574-8541329e0762	SE096E	3	D	f	FM019	t	2022-08-09 15:21:10.815709	2022-08-09 15:21:10.963192
3acae02e-10ee-49c8-95c8-04216f492f02	SE096E	3	I	f	FM019	t	2022-08-09 15:21:10.821515	2022-08-09 15:21:10.970578
489a6633-205e-48da-98cc-e35d18ec72e3	SE096E	3	W	f	FM019	t	2022-08-09 15:21:10.826809	2022-08-09 15:21:10.978031
7d75d0b8-ceed-4890-9a37-6409b23bc838	SE096E	3	Z	f	FM019	t	2022-08-09 15:21:10.832163	2022-08-09 15:21:10.987091
8afb2f5a-6a52-4967-8831-53200caa2aef	SE096E	3	A	t	FM019	t	2022-08-09 15:21:10.781945	2022-08-09 15:21:10.996276
a2450e29-cdcc-4dd4-9662-8f4149995ce7	SE096E	3	D	t	FM019	t	2022-08-09 15:21:10.787239	2022-08-09 15:21:11.003981
e057929f-909d-4108-908a-d004a1067417	SE096E	3	I	t	FM019	t	2022-08-09 15:21:10.793575	2022-08-09 15:21:11.011334
5f58923b-7a09-444a-a717-f1dd28821ea7	SE096E	3	W	t	FM019	t	2022-08-09 15:21:10.798989	2022-08-09 15:21:11.018567
c29dc6b7-e419-444d-8c6c-f64b2f8f0762	SE096E	3	Z	t	FM019	t	2022-08-09 15:21:10.804604	2022-08-09 15:21:11.026221
709ea92f-689c-4b8e-8500-7e6960da4563	SE099E	3	A	t	CV027	f	2022-08-09 15:21:11.031869	2022-08-09 15:21:11.031869
ff6c0b44-9c2a-4cc0-a6fa-554eb85388e6	SE099E	3	D	t	CV027	f	2022-08-09 15:21:11.037734	2022-08-09 15:21:11.037734
d5c67bc1-64b6-4284-b659-f01ce6599fe8	SE099E	3	I	t	CV027	f	2022-08-09 15:21:11.043583	2022-08-09 15:21:11.043583
e392687a-eedf-47a4-ae38-10cf93787c26	SE099E	3	W	t	CV027	f	2022-08-09 15:21:11.050589	2022-08-09 15:21:11.050589
b84e4ca0-c0fb-4914-a51c-fb4c91013b6f	SE099E	3	Z	t	CV027	f	2022-08-09 15:21:11.056215	2022-08-09 15:21:11.056215
a2d6250a-bd63-4036-9d38-0a6b8f53b0a6	SE099E	3	A	f	CV027	f	2022-08-09 15:21:11.061857	2022-08-09 15:21:11.061857
ed55cf7e-fe30-4262-9ab5-ee4a30f31b27	SE099E	3	D	f	CV027	f	2022-08-09 15:21:11.068169	2022-08-09 15:21:11.068169
f931da59-5bfb-44ee-8fdf-4a29a3322ffe	SE099E	3	I	f	CV027	f	2022-08-09 15:21:11.074386	2022-08-09 15:21:11.074386
cb34eecf-54e3-40cf-bd2d-4cd113ccf76d	SE099E	3	W	f	CV027	f	2022-08-09 15:21:11.080889	2022-08-09 15:21:11.080889
e22fa036-02d0-4762-847f-ff1e5e4ba1ed	SE099E	3	Z	f	CV027	f	2022-08-09 15:21:11.087719	2022-08-09 15:21:11.087719
705f2ba3-49e8-44f5-b867-edefafedf4cf	SE099E	3	A	t	CV118	f	2022-08-09 15:21:11.09314	2022-08-09 15:21:11.09314
cee1972b-c2e2-4fd7-a3cd-f6f8efa74f29	SE099E	3	D	t	CV118	f	2022-08-09 15:21:11.098811	2022-08-09 15:21:11.098811
c21c8266-4138-4f26-a4a0-b7360b0fb05d	SE099E	3	I	t	CV118	f	2022-08-09 15:21:11.10437	2022-08-09 15:21:11.10437
87300fdf-2a3c-4ccd-89b8-29b62a668871	SE099E	3	W	t	CV118	f	2022-08-09 15:21:11.110293	2022-08-09 15:21:11.110293
7b61fb05-e63f-40b4-80d9-f21f1d851366	SE099E	3	Z	t	CV118	f	2022-08-09 15:21:11.115789	2022-08-09 15:21:11.115789
ee098aa2-eaa2-4729-990b-567ae1a21e03	SE099E	3	A	f	CV118	f	2022-08-09 15:21:11.121247	2022-08-09 15:21:11.121247
07b5d8ca-7c54-4ef1-b4ac-e282fe391a24	SE099E	3	D	f	CV118	f	2022-08-09 15:21:11.127009	2022-08-09 15:21:11.127009
004324b7-23eb-453c-ad84-18665902c93a	SE099E	3	I	f	CV118	f	2022-08-09 15:21:11.132301	2022-08-09 15:21:11.132301
875b3605-ac8d-4949-94e2-399772bb75a1	SE099E	3	W	f	CV118	f	2022-08-09 15:21:11.137795	2022-08-09 15:21:11.137795
ca67a6a2-daf3-4e8f-9e1e-a552279b8654	SE099E	3	Z	f	CV118	f	2022-08-09 15:21:11.14381	2022-08-09 15:21:11.14381
d50be7f9-2af8-49c1-b702-b7811bbc06d5	SE099E	3	A	t	EF012	f	2022-08-09 15:21:11.149248	2022-08-09 15:21:11.149248
d34b7455-2cf3-415d-b662-cdd35b28e0a1	SE099E	3	D	t	EF012	f	2022-08-09 15:21:11.154888	2022-08-09 15:21:11.154888
55fec4f6-4dee-497b-8b4c-8a6063970850	SE099E	3	I	t	EF012	f	2022-08-09 15:21:11.160211	2022-08-09 15:21:11.160211
c1857380-14ec-4aad-97a8-7cfd1418c679	SE099E	3	W	t	EF012	f	2022-08-09 15:21:11.165769	2022-08-09 15:21:11.165769
1c161f79-e267-4cc9-990b-0e100e8c1a2c	SE099E	3	Z	t	EF012	f	2022-08-09 15:21:11.172566	2022-08-09 15:21:11.172566
e299c9e7-77ad-4b74-8ec0-9c58e2efa39f	SE099E	3	A	f	EF012	f	2022-08-09 15:21:11.179705	2022-08-09 15:21:11.179705
683b575c-71c3-4766-a8d8-d3b3260400ec	SE099E	3	D	f	EF012	f	2022-08-09 15:21:11.186143	2022-08-09 15:21:11.186143
47420ad4-7ca7-48a5-b436-23fd4ffaf2a9	SE099E	3	I	f	EF012	f	2022-08-09 15:21:11.192288	2022-08-09 15:21:11.192288
ca1777a2-f9d9-43cb-b97d-97e5833d3ab5	SE099E	3	W	f	EF012	f	2022-08-09 15:21:11.197572	2022-08-09 15:21:11.197572
fc391711-494a-4046-bd4a-9f322787c117	SE099E	3	Z	f	EF012	f	2022-08-09 15:21:11.203061	2022-08-09 15:21:11.203061
e6031021-ab9f-4eae-8bae-48faa4ea530f	SE099E	3	A	t	EF022	f	2022-08-09 15:21:11.208329	2022-08-09 15:21:11.208329
80f90cb3-5333-40fe-92d7-ffc70bcb4874	SE099E	3	D	t	EF022	f	2022-08-09 15:21:11.213675	2022-08-09 15:21:11.213675
ce56f0f5-ef3c-4257-9a4a-03877f126e89	SE099E	3	I	t	EF022	f	2022-08-09 15:21:11.219663	2022-08-09 15:21:11.219663
6f56ac17-a247-4c18-bceb-1ad71bd465e0	SE099E	3	W	t	EF022	f	2022-08-09 15:21:11.225213	2022-08-09 15:21:11.225213
79954e75-6f8f-46d1-bc74-a96dd1a3b04d	SE099E	3	Z	t	EF022	f	2022-08-09 15:21:11.230821	2022-08-09 15:21:11.230821
b01a29ae-e222-4630-8998-4db33ee38584	SE099E	3	A	f	EF022	f	2022-08-09 15:21:11.236609	2022-08-09 15:21:11.236609
937dd483-4986-4261-b40c-2b8de6f56ec2	SE099E	3	D	f	EF022	f	2022-08-09 15:21:11.241971	2022-08-09 15:21:11.241971
aef6939b-76c5-466a-89cb-09af3729da65	SE099E	3	I	f	EF022	f	2022-08-09 15:21:11.247638	2022-08-09 15:21:11.247638
c87091ef-7d88-40bb-b512-20f1004ce97f	SE099E	3	W	f	EF022	f	2022-08-09 15:21:11.253132	2022-08-09 15:21:11.253132
2e78cf1d-34ee-4353-8f07-02de24354214	SE099E	3	Z	f	EF022	f	2022-08-09 15:21:11.25898	2022-08-09 15:21:11.25898
a708a441-263a-457c-9e1f-7773c4ba9f8b	SE099E	3	A	t	EF025	f	2022-08-09 15:21:11.264324	2022-08-09 15:21:11.264324
84dfac4d-a0f8-446e-add2-f1be87b3f66d	SE099E	3	D	t	EF025	f	2022-08-09 15:21:11.269975	2022-08-09 15:21:11.269975
06dabd65-5e23-4d1b-9c98-dede19af2be8	SE099E	3	I	t	EF025	f	2022-08-09 15:21:11.275431	2022-08-09 15:21:11.275431
15d23594-eeec-457f-9f08-2d010dee5d9c	SE099E	3	W	t	EF025	f	2022-08-09 15:21:11.280768	2022-08-09 15:21:11.280768
42375a82-de05-49b2-a77f-6a34c2cea2b6	SE099E	3	Z	t	EF025	f	2022-08-09 15:21:11.287727	2022-08-09 15:21:11.287727
a911dd9c-9f87-4bdc-b289-060cefbddf20	SE099E	3	A	f	EF025	f	2022-08-09 15:21:11.293271	2022-08-09 15:21:11.293271
3513c923-7ca6-47f8-9c91-53f9073eacda	SE099E	3	D	f	EF025	f	2022-08-09 15:21:11.299135	2022-08-09 15:21:11.299135
2ec10538-3438-49bb-a9f3-49c286a8492b	SE099E	3	I	f	EF025	f	2022-08-09 15:21:11.304937	2022-08-09 15:21:11.304937
2606c3e2-3684-421d-b266-2f19ee1ac574	SE099E	3	W	f	EF025	f	2022-08-09 15:21:11.310281	2022-08-09 15:21:11.310281
0290a7cf-0a84-4382-a4d6-a0ea20924a14	SE099E	3	Z	f	EF025	f	2022-08-09 15:21:11.316038	2022-08-09 15:21:11.316038
6d8fca04-f56c-4fff-8a30-a18c446935bc	SE099E	3	A	t	EF026	f	2022-08-09 15:21:11.32153	2022-08-09 15:21:11.32153
ec6b133f-cd52-4dbf-a73c-59c0df3cc401	SE099E	3	D	t	EF026	f	2022-08-09 15:21:11.327706	2022-08-09 15:21:11.327706
de340f4b-71bf-4305-aa5e-354b45d09ff5	SE099E	3	I	t	EF026	f	2022-08-09 15:21:11.333382	2022-08-09 15:21:11.333382
e1b98cdb-c895-4ef9-9e42-f2193bea1cd0	SE099E	3	W	t	EF026	f	2022-08-09 15:21:11.339205	2022-08-09 15:21:11.339205
ee072aac-086e-4d7e-9f17-08a98153c67a	SE099E	3	Z	t	EF026	f	2022-08-09 15:21:11.344774	2022-08-09 15:21:11.344774
32c67595-bba5-4ef0-9d91-16a0be7d2c18	SE099E	3	A	f	EF026	f	2022-08-09 15:21:11.351594	2022-08-09 15:21:11.351594
bb89957a-2d38-44c4-a3ac-e43adf599a0b	SE099E	3	D	f	EF026	f	2022-08-09 15:21:11.358353	2022-08-09 15:21:11.358353
f435b2ab-3468-446a-9831-86d6176a7233	SE099E	3	I	f	EF026	f	2022-08-09 15:21:11.364313	2022-08-09 15:21:11.364313
4b88bf3a-8e16-418c-8dce-b84ff509a2db	SE099E	3	W	f	EF026	f	2022-08-09 15:21:11.370633	2022-08-09 15:21:11.370633
4a9a03f1-4156-4187-9d08-9784752d05c1	SE099E	3	Z	f	EF026	f	2022-08-09 15:21:11.377147	2022-08-09 15:21:11.377147
0b6c6f5a-812d-46e2-acfa-672be6c08abc	SE099E	3	A	t	EF027	f	2022-08-09 15:21:11.38346	2022-08-09 15:21:11.38346
645d3077-ef9e-4ff6-bf8f-f00cbc1632b5	SE099E	3	D	t	EF027	f	2022-08-09 15:21:11.389749	2022-08-09 15:21:11.389749
c4c7eb2e-c5db-432b-8705-85fa4d206b07	SE099E	3	I	t	EF027	f	2022-08-09 15:21:11.395439	2022-08-09 15:21:11.395439
71c609fd-610e-463a-8149-b3c25545c57a	SE099E	3	W	t	EF027	f	2022-08-09 15:21:11.40123	2022-08-09 15:21:11.40123
fa8ae574-f93b-46f2-8108-bbe87b98db18	SE099E	3	Z	t	EF027	f	2022-08-09 15:21:11.407442	2022-08-09 15:21:11.407442
eb38204d-90eb-4db1-9806-7c2e865cb890	SE099E	3	A	f	EF027	f	2022-08-09 15:21:11.413105	2022-08-09 15:21:11.413105
6be120f0-2821-4cbd-ab4d-0d1a922f86e9	SE099E	3	D	f	EF027	f	2022-08-09 15:21:11.418702	2022-08-09 15:21:11.418702
97129bb7-1d1b-4f41-874b-9e744fa45f48	SE099E	3	I	f	EF027	f	2022-08-09 15:21:11.42474	2022-08-09 15:21:11.42474
ff7351e1-87bf-4925-9ae9-6d6a369d46a2	SE099E	3	W	f	EF027	f	2022-08-09 15:21:11.430812	2022-08-09 15:21:11.430812
115b7cb9-0775-405d-8560-5167cdb89a0d	SE099E	3	Z	f	EF027	f	2022-08-09 15:21:11.437003	2022-08-09 15:21:11.437003
4e1e1e7d-3145-4d35-a141-003b061db99a	SE099E	3	A	t	FM049	f	2022-08-09 15:21:11.498404	2022-08-09 15:21:11.498404
fc6b0d34-51b2-4a7f-a9bf-398483c2df60	SE099E	3	D	t	FM049	f	2022-08-09 15:21:11.503801	2022-08-09 15:21:11.503801
0dcc6b4e-cc33-4d2a-b868-b94a2b7f74d1	SE099E	3	I	t	FM049	f	2022-08-09 15:21:11.509843	2022-08-09 15:21:11.509843
a96393a5-aa21-401a-b624-5c139f47af8e	SE099E	3	W	t	FM049	f	2022-08-09 15:21:11.515359	2022-08-09 15:21:11.515359
1a20423a-a92d-43e5-9828-0d2e3d6d538c	SE099E	3	Z	t	FM049	f	2022-08-09 15:21:11.520891	2022-08-09 15:21:11.520891
0bb90143-bf95-4f94-bef6-917f6eacb356	SE099E	3	A	f	FM049	f	2022-08-09 15:21:11.526739	2022-08-09 15:21:11.526739
f26de5bd-6955-4ab1-8f17-f2af51a8daf5	SE099E	3	D	f	FM049	f	2022-08-09 15:21:11.532272	2022-08-09 15:21:11.532272
b4b55d94-62e6-4427-bd11-8bdd3aefd7ac	SE099E	3	I	f	FM049	f	2022-08-09 15:21:11.537639	2022-08-09 15:21:11.537639
f9d7fe4f-9e43-4c23-a233-3c0ff662c107	SE099E	3	W	f	FM049	f	2022-08-09 15:21:11.543332	2022-08-09 15:21:11.543332
ba127184-c913-4446-b2d1-3891b90995c4	SE099E	3	Z	f	FM049	f	2022-08-09 15:21:11.549033	2022-08-09 15:21:11.549033
20cb76c3-da2f-4b80-a9cf-0ea76edf342c	SE099E	3	A	t	MC029	f	2022-08-09 15:21:11.555216	2022-08-09 15:21:11.555216
f170a119-0eff-4e82-9028-24369231abb1	SE099E	3	D	t	MC029	f	2022-08-09 15:21:11.560616	2022-08-09 15:21:11.560616
bf7b5ad8-7f4b-4f8a-8258-4a65f4ee6e1e	SE099E	3	I	t	MC029	f	2022-08-09 15:21:11.566402	2022-08-09 15:21:11.566402
95f72235-8f8c-40d7-adf4-5fe6c8e012e5	SE099E	3	W	t	MC029	f	2022-08-09 15:21:11.572115	2022-08-09 15:21:11.572115
c413fc9b-011a-45d2-90b0-dbe2a1e31081	SE099E	3	Z	t	MC029	f	2022-08-09 15:21:11.577467	2022-08-09 15:21:11.577467
1b77253e-f926-4aae-abb8-1db69e270de9	SE099E	3	A	f	MC029	f	2022-08-09 15:21:11.583212	2022-08-09 15:21:11.583212
35ca0939-4891-4116-8974-a45b35e93964	SE099E	3	D	f	MC029	f	2022-08-09 15:21:11.588568	2022-08-09 15:21:11.588568
f919f023-7b63-4c92-b7ac-3323b4202d21	SE099E	3	I	f	MC029	f	2022-08-09 15:21:11.594156	2022-08-09 15:21:11.594156
36628d26-34fd-460c-b2af-51f789093d86	SE099E	3	W	f	MC029	f	2022-08-09 15:21:11.599611	2022-08-09 15:21:11.599611
bc6935a3-7820-424d-92ac-0f0d84f0e1d7	SE099E	3	Z	f	MC029	f	2022-08-09 15:21:11.605344	2022-08-09 15:21:11.605344
065e8886-48ee-4500-bdb9-516d6379e37c	SE099E	3	A	f	FM019	t	2022-08-09 15:21:11.47056	2022-08-09 15:21:11.612442
d0163361-7af6-44c7-949f-b246772d6323	SE099E	3	D	f	FM019	t	2022-08-09 15:21:11.475915	2022-08-09 15:21:11.620938
a4825672-8834-493b-a884-58a4ed7d124b	SE099E	3	I	f	FM019	t	2022-08-09 15:21:11.481614	2022-08-09 15:21:11.628791
56876b12-17bf-4577-87b3-c9a52fcc91fc	SE099E	3	W	f	FM019	t	2022-08-09 15:21:11.487072	2022-08-09 15:21:11.637765
e7e7cf0e-41c8-41a3-b686-8bc17a45aa72	SE099E	3	Z	f	FM019	t	2022-08-09 15:21:11.492778	2022-08-09 15:21:11.646366
32bb5989-0a5c-4640-a8a2-01380989b033	SE099E	3	A	t	FM019	t	2022-08-09 15:21:11.442392	2022-08-09 15:21:11.65394
9a634221-bebc-4475-975b-1d2dec13e3ca	SE099E	3	D	t	FM019	t	2022-08-09 15:21:11.448175	2022-08-09 15:21:11.661397
c0129c9e-2bf8-49bf-953f-9f46d0429d6b	SE099E	3	I	t	FM019	t	2022-08-09 15:21:11.453706	2022-08-09 15:21:11.669231
6caa5a70-d160-411e-8182-ab1855662303	SE099E	3	W	t	FM019	t	2022-08-09 15:21:11.459299	2022-08-09 15:21:11.676497
046f2a78-2c37-490e-982e-59cab052e133	SE099E	3	Z	t	FM019	t	2022-08-09 15:21:11.465135	2022-08-09 15:21:11.685004
e591233d-4807-4b99-90f3-c932b2d184ab	SE100E	3	A	t	CV027	f	2022-08-09 15:21:11.69042	2022-08-09 15:21:11.69042
aaaa4c7f-6eab-470c-a4bd-fb32d6942c26	SE100E	3	D	t	CV027	f	2022-08-09 15:21:11.696065	2022-08-09 15:21:11.696065
d9ff1560-afcb-412f-ad14-daf96d605c0f	SE100E	3	I	t	CV027	f	2022-08-09 15:21:11.701524	2022-08-09 15:21:11.701524
3432f5c3-1b1b-4bcb-a8ad-95cbda79dcf2	SE100E	3	W	t	CV027	f	2022-08-09 15:21:11.707496	2022-08-09 15:21:11.707496
85a47cf5-7c49-4d6f-8cd4-350b31e66954	SE100E	3	Z	t	CV027	f	2022-08-09 15:21:11.722778	2022-08-09 15:21:11.722778
ed615c62-3b4f-4e11-9b1a-211de5f4dda6	SE100E	3	A	f	CV027	f	2022-08-09 15:21:11.729007	2022-08-09 15:21:11.729007
0199b2f7-2f47-4034-a366-dc9e08dc0cff	SE100E	3	D	f	CV027	f	2022-08-09 15:21:11.734739	2022-08-09 15:21:11.734739
abe81f58-c7ac-4b49-8dbe-ffb7585976cc	SE100E	3	I	f	CV027	f	2022-08-09 15:21:11.740352	2022-08-09 15:21:11.740352
aea2b4f5-388b-4559-a687-71e35dc348f6	SE100E	3	W	f	CV027	f	2022-08-09 15:21:11.747292	2022-08-09 15:21:11.747292
fffc86e7-ff25-4560-a3e5-800a579d17fc	SE100E	3	Z	f	CV027	f	2022-08-09 15:21:11.753416	2022-08-09 15:21:11.753416
60fbed61-c299-4bbf-81ad-e9f08fcea379	SE100E	3	A	t	CV118	f	2022-08-09 15:21:11.758875	2022-08-09 15:21:11.758875
554f2d5a-41d4-4878-949c-8f41398e9478	SE100E	3	D	t	CV118	f	2022-08-09 15:21:11.764834	2022-08-09 15:21:11.764834
6097d012-4080-49c0-b9e4-a43c4e00d9b2	SE100E	3	I	t	CV118	f	2022-08-09 15:21:11.770446	2022-08-09 15:21:11.770446
68966271-3c9b-44e1-a74c-2cd705c06db6	SE100E	3	W	t	CV118	f	2022-08-09 15:21:11.776163	2022-08-09 15:21:11.776163
581cace7-8f79-4cf0-bdbe-ac942681826f	SE100E	3	Z	t	CV118	f	2022-08-09 15:21:11.781494	2022-08-09 15:21:11.781494
83bb5f86-3535-483f-87f1-e2d9deda5f8c	SE100E	3	A	f	CV118	f	2022-08-09 15:21:11.787208	2022-08-09 15:21:11.787208
959e2254-a6a7-4359-9abb-ec6846729e66	SE100E	3	D	f	CV118	f	2022-08-09 15:21:11.79248	2022-08-09 15:21:11.79248
a08ac6bc-9aa8-474d-8ac3-bb5115db4e30	SE100E	3	I	f	CV118	f	2022-08-09 15:21:11.797799	2022-08-09 15:21:11.797799
3ce15e3e-44b3-400b-988e-98e490621376	SE100E	3	W	f	CV118	f	2022-08-09 15:21:11.803478	2022-08-09 15:21:11.803478
a7b2300c-f50a-46fd-b6ac-17c44b489451	SE100E	3	Z	f	CV118	f	2022-08-09 15:21:11.808872	2022-08-09 15:21:11.808872
de3add14-6f1b-484f-a847-1eaaa5e1d258	SE100E	3	A	t	EF012	f	2022-08-09 15:21:11.814145	2022-08-09 15:21:11.814145
73cd5fb4-2219-4a3e-95de-4eaced017965	SE100E	3	D	t	EF012	f	2022-08-09 15:21:11.820209	2022-08-09 15:21:11.820209
ab186401-8dd8-4a8c-86c7-d95d70dc3de9	SE100E	3	I	t	EF012	f	2022-08-09 15:21:11.825426	2022-08-09 15:21:11.825426
4997ba9b-ca0a-43ba-93f2-c80c472d84ad	SE100E	3	W	t	EF012	f	2022-08-09 15:21:11.831063	2022-08-09 15:21:11.831063
d9201cb8-0511-42d6-b448-1a27c014a22b	SE100E	3	Z	t	EF012	f	2022-08-09 15:21:11.836425	2022-08-09 15:21:11.836425
4a497648-d203-4b0d-bf00-9aa447fce139	SE100E	3	A	f	EF012	f	2022-08-09 15:21:11.841744	2022-08-09 15:21:11.841744
26e16dc5-c6c3-429d-94fa-46ef7366b6b4	SE100E	3	D	f	EF012	f	2022-08-09 15:21:11.847809	2022-08-09 15:21:11.847809
00f7f671-6ee6-4d48-96bb-3e6c64f074ce	SE100E	3	I	f	EF012	f	2022-08-09 15:21:11.853321	2022-08-09 15:21:11.853321
31b35ac5-a00e-42de-92d8-0d09551f1fb2	SE100E	3	W	f	EF012	f	2022-08-09 15:21:11.858897	2022-08-09 15:21:11.858897
c223ea01-64d5-49c5-abe8-0b1896c5c000	SE100E	3	Z	f	EF012	f	2022-08-09 15:21:11.864729	2022-08-09 15:21:11.864729
94d6fa9a-69e1-4aba-80d6-a2356e0f73c0	SE100E	3	A	t	EF022	f	2022-08-09 15:21:11.870404	2022-08-09 15:21:11.870404
16e07ba8-64a5-44f1-adbf-70109ac51e12	SE100E	3	D	t	EF022	f	2022-08-09 15:21:11.876065	2022-08-09 15:21:11.876065
4ac513bf-1f5f-4b08-ab7a-ec17c97609a7	SE100E	3	I	t	EF022	f	2022-08-09 15:21:11.881339	2022-08-09 15:21:11.881339
009af681-904e-426c-8df7-fdf5a8b6ed63	SE100E	3	W	t	EF022	f	2022-08-09 15:21:11.886814	2022-08-09 15:21:11.886814
471c1b29-5080-4b91-87a1-c22588393e09	SE100E	3	Z	t	EF022	f	2022-08-09 15:21:11.89283	2022-08-09 15:21:11.89283
b913b9b4-fb8b-4289-bffb-0836f799b567	SE100E	3	A	f	EF022	f	2022-08-09 15:21:11.899422	2022-08-09 15:21:11.899422
cf1c3682-3f70-4e5a-9554-a1f7ae96ec88	SE100E	3	D	f	EF022	f	2022-08-09 15:21:11.905015	2022-08-09 15:21:11.905015
4f33930a-ff5f-4296-8dab-928f177aa1a4	SE100E	3	I	f	EF022	f	2022-08-09 15:21:11.910866	2022-08-09 15:21:11.910866
f13491ac-bb01-4623-a691-76cee3e75bef	SE100E	3	W	f	EF022	f	2022-08-09 15:21:11.916351	2022-08-09 15:21:11.916351
ecc41548-dca6-49e7-9277-b8e902bd0bad	SE100E	3	Z	f	EF022	f	2022-08-09 15:21:11.922104	2022-08-09 15:21:11.922104
d62a3c4b-164e-4b50-8443-ccfa5a20b727	SE100E	3	A	t	EF025	f	2022-08-09 15:21:11.927537	2022-08-09 15:21:11.927537
58f95493-aa85-470d-ba9b-4390b3ff44c8	SE100E	3	D	t	EF025	f	2022-08-09 15:21:11.933112	2022-08-09 15:21:11.933112
4c46f496-e820-4dd8-a79d-ffa2231229a4	SE100E	3	I	t	EF025	f	2022-08-09 15:21:11.938642	2022-08-09 15:21:11.938642
6c2567b4-1b69-42c5-8ea4-abbe91978904	SE100E	3	W	t	EF025	f	2022-08-09 15:21:11.944276	2022-08-09 15:21:11.944276
1845dbd2-3d2f-43b3-a5b9-9697ae160178	SE100E	3	Z	t	EF025	f	2022-08-09 15:21:11.949676	2022-08-09 15:21:11.949676
ac71dc51-6688-42ec-a788-084b7c233e21	SE100E	3	A	f	EF025	f	2022-08-09 15:21:11.954977	2022-08-09 15:21:11.954977
b64949e0-16a2-42fe-aef0-f24ffc587ada	SE100E	3	D	f	EF025	f	2022-08-09 15:21:11.961976	2022-08-09 15:21:11.961976
482fbba9-3c75-4465-abb3-b90c6b6a3dd6	SE100E	3	I	f	EF025	f	2022-08-09 15:21:11.967756	2022-08-09 15:21:11.967756
98f6a863-b66e-4874-8ec2-67f2416cdfa3	SE100E	3	W	f	EF025	f	2022-08-09 15:21:11.974201	2022-08-09 15:21:11.974201
5a95f670-2c22-4bc4-a4fe-f01ac0743d67	SE100E	3	Z	f	EF025	f	2022-08-09 15:21:11.980768	2022-08-09 15:21:11.980768
4cefbfe6-b6cf-49c7-9052-87257f3332fb	SE100E	3	A	t	EF026	f	2022-08-09 15:21:11.986949	2022-08-09 15:21:11.986949
a60c8dfa-7ec5-47dd-bdd4-4f6cfdf9a856	SE100E	3	D	t	EF026	f	2022-08-09 15:21:11.992836	2022-08-09 15:21:11.992836
98726428-2afd-4637-a0af-e457d2985650	SE100E	3	I	t	EF026	f	2022-08-09 15:21:11.99869	2022-08-09 15:21:11.99869
dfedd0f3-a621-46ab-8b2f-c72584d9e5a0	SE100E	3	W	t	EF026	f	2022-08-09 15:21:12.004465	2022-08-09 15:21:12.004465
b6360b29-a2c1-4dc5-8c6c-5e7ad5d87e4d	SE100E	3	Z	t	EF026	f	2022-08-09 15:21:12.009807	2022-08-09 15:21:12.009807
75fca104-d5af-42bb-9154-9eb3286fd653	SE100E	3	A	f	EF026	f	2022-08-09 15:21:12.015717	2022-08-09 15:21:12.015717
828b259e-4a6a-4e77-a033-5d894f74a69e	SE100E	3	D	f	EF026	f	2022-08-09 15:21:12.02126	2022-08-09 15:21:12.02126
cc87b689-dfaf-4f76-ac59-6dd3eb75a367	SE100E	3	I	f	EF026	f	2022-08-09 15:21:12.027801	2022-08-09 15:21:12.027801
36220695-3285-4fb1-b0d4-f615566a1bbb	SE100E	3	W	f	EF026	f	2022-08-09 15:21:12.034325	2022-08-09 15:21:12.034325
1f5319b2-7bc1-41a9-a1cf-50b51e8d74c4	SE100E	3	Z	f	EF026	f	2022-08-09 15:21:12.040506	2022-08-09 15:21:12.040506
e1ffd140-fccd-49f4-9a68-a5d32d7d051b	SE100E	3	A	t	EF027	f	2022-08-09 15:21:12.046236	2022-08-09 15:21:12.046236
c64e3f5b-0c49-45f0-a206-a504f1dabad9	SE100E	3	D	t	EF027	f	2022-08-09 15:21:12.051947	2022-08-09 15:21:12.051947
2285ed9d-125c-4fe5-bd6e-ca3eaa2414bf	SE100E	3	I	t	EF027	f	2022-08-09 15:21:12.057457	2022-08-09 15:21:12.057457
50aa0507-e21a-4b01-98af-bbe2068f19ab	SE100E	3	W	t	EF027	f	2022-08-09 15:21:12.06347	2022-08-09 15:21:12.06347
87d1df9d-cbc5-4ba6-a3ec-494106dd73a3	SE100E	3	Z	t	EF027	f	2022-08-09 15:21:12.069116	2022-08-09 15:21:12.069116
3d501503-b962-43b4-9adf-4ec6157c0d23	SE100E	3	A	f	EF027	f	2022-08-09 15:21:12.07464	2022-08-09 15:21:12.07464
81017e06-e8c4-45da-9a71-2465c8b37623	SE100E	3	D	f	EF027	f	2022-08-09 15:21:12.08229	2022-08-09 15:21:12.08229
fbae5bdb-b4c2-439c-a797-dff6469e107a	SE100E	3	I	f	EF027	f	2022-08-09 15:21:12.088265	2022-08-09 15:21:12.088265
cc55bbfe-8727-4992-88de-fb61e606fb06	SE100E	3	W	f	EF027	f	2022-08-09 15:21:12.094	2022-08-09 15:21:12.094
cf8c9988-1859-40db-bc6c-9498f8f99a95	SE100E	3	Z	f	EF027	f	2022-08-09 15:21:12.100197	2022-08-09 15:21:12.100197
2e923448-3d8e-4d36-b1c2-14c2a69354fa	SE100E	3	A	t	FM049	f	2022-08-09 15:21:12.162513	2022-08-09 15:21:12.162513
017f2a6f-1308-4b14-8aa7-73eca07e4807	SE100E	3	D	t	FM049	f	2022-08-09 15:21:12.168674	2022-08-09 15:21:12.168674
01f073be-1ea5-4015-8825-d5acda0b26b9	SE100E	3	I	t	FM049	f	2022-08-09 15:21:12.174396	2022-08-09 15:21:12.174396
da13e9cc-a54c-457e-b657-e351e87917aa	SE100E	3	W	t	FM049	f	2022-08-09 15:21:12.17996	2022-08-09 15:21:12.17996
dc488591-c3e2-4fc3-b25a-8adcbb029fba	SE100E	3	Z	t	FM049	f	2022-08-09 15:21:12.185683	2022-08-09 15:21:12.185683
7f0928aa-e0f7-4104-a379-4842ec7cf015	SE100E	3	A	f	FM049	f	2022-08-09 15:21:12.190929	2022-08-09 15:21:12.190929
0bf9f6ae-69fe-4321-891b-a401584d4a00	SE100E	3	D	f	FM049	f	2022-08-09 15:21:12.196316	2022-08-09 15:21:12.196316
3c9f9b2e-374a-4dde-931e-514f16dd393d	SE100E	3	I	f	FM049	f	2022-08-09 15:21:12.202538	2022-08-09 15:21:12.202538
e8bf491c-2c5e-4a5b-b65b-94354a964ae3	SE100E	3	W	f	FM049	f	2022-08-09 15:21:12.208045	2022-08-09 15:21:12.208045
b7772d8a-a68c-4581-863e-8dfbd49d30d6	SE100E	3	Z	f	FM049	f	2022-08-09 15:21:12.213331	2022-08-09 15:21:12.213331
25a8058e-a9db-403d-9713-3f5f4720c9c3	SE100E	3	A	t	MC029	f	2022-08-09 15:21:12.219205	2022-08-09 15:21:12.219205
f0d948ec-2a84-45dd-98c5-a383f0fe32a7	SE100E	3	D	t	MC029	f	2022-08-09 15:21:12.224624	2022-08-09 15:21:12.224624
74b3ae0b-07a3-4652-ab3d-009200c28e23	SE100E	3	I	t	MC029	f	2022-08-09 15:21:12.230293	2022-08-09 15:21:12.230293
6f3872fe-6916-476f-8453-a6dff86f9ceb	SE100E	3	W	t	MC029	f	2022-08-09 15:21:12.235764	2022-08-09 15:21:12.235764
5f955899-e3a2-425c-94a6-e347af70a2ba	SE100E	3	Z	t	MC029	f	2022-08-09 15:21:12.241181	2022-08-09 15:21:12.241181
ceaed945-18b0-41dc-87d0-9c3bddc00b6f	SE100E	3	A	f	MC029	f	2022-08-09 15:21:12.246846	2022-08-09 15:21:12.246846
14e444f5-6ef7-469a-9f06-7b01adc3e245	SE100E	3	D	f	MC029	f	2022-08-09 15:21:12.252315	2022-08-09 15:21:12.252315
d33789cc-ccb3-48c3-bf31-b51ce9b5bd40	SE100E	3	I	f	MC029	f	2022-08-09 15:21:12.25818	2022-08-09 15:21:12.25818
4a59abbc-e4e9-424b-8e42-55cc211c1f54	SE100E	3	W	f	MC029	f	2022-08-09 15:21:12.263592	2022-08-09 15:21:12.263592
d25447d1-1eb7-42cf-a5b1-71048204fa72	SE100E	3	Z	f	MC029	f	2022-08-09 15:21:12.269234	2022-08-09 15:21:12.269234
efe4b38a-7e5a-4943-abe0-8d6f78fd41f4	SE100E	3	A	f	FM019	t	2022-08-09 15:21:12.134355	2022-08-09 15:21:12.276658
7edc2d87-826c-4f5e-b4da-b09ee20e2a3e	SE100E	3	D	f	FM019	t	2022-08-09 15:21:12.140173	2022-08-09 15:21:12.283778
8a038c86-8da4-4223-a0c0-f6eda94d610d	SE100E	3	I	f	FM019	t	2022-08-09 15:21:12.145523	2022-08-09 15:21:12.290901
a75841b9-714d-4f66-9f2b-5cb24e8cd558	SE100E	3	W	f	FM019	t	2022-08-09 15:21:12.151496	2022-08-09 15:21:12.300057
e22cf46f-cc76-4339-bc1c-47b0443edf14	SE100E	3	Z	f	FM019	t	2022-08-09 15:21:12.15718	2022-08-09 15:21:12.307739
24526dda-5bc0-435c-8a2e-efa46bdd6671	SE100E	3	A	t	FM019	t	2022-08-09 15:21:12.105842	2022-08-09 15:21:12.31525
8be5abf6-cdbd-4fb6-a4dc-84c2e7a5ad92	SE100E	3	D	t	FM019	t	2022-08-09 15:21:12.111593	2022-08-09 15:21:12.322821
d8f0ed14-2db8-40d2-9a8e-e9a03ffcbf9f	SE100E	3	I	t	FM019	t	2022-08-09 15:21:12.117023	2022-08-09 15:21:12.330387
f10300c5-abfc-468f-ae14-86d3bf3993cb	SE100E	3	W	t	FM019	t	2022-08-09 15:21:12.122289	2022-08-09 15:21:12.337874
4206a538-1926-4962-8cbe-c0d41d351180	SE100E	3	Z	t	FM019	t	2022-08-09 15:21:12.128128	2022-08-09 15:21:12.346973
b22d972b-7266-45e9-af84-af451755ece0	SE101E	3	A	t	CV027	f	2022-08-09 15:21:12.35409	2022-08-09 15:21:12.35409
e75d7912-4f9a-4f36-8414-7975d2177e77	SE101E	3	D	t	CV027	f	2022-08-09 15:21:12.360748	2022-08-09 15:21:12.360748
4e4a66a9-5ccd-466d-a24a-8d3556001807	SE101E	3	I	t	CV027	f	2022-08-09 15:21:12.366723	2022-08-09 15:21:12.366723
04bed2a1-e983-4684-aa4c-9d3a62b82eba	SE101E	3	W	t	CV027	f	2022-08-09 15:21:12.373479	2022-08-09 15:21:12.373479
d7ac9f2d-004a-4b7f-89ae-4bd6db635dc1	SE101E	3	Z	t	CV027	f	2022-08-09 15:21:12.379165	2022-08-09 15:21:12.379165
4d0ad6a8-a2ad-4f9f-97a1-5e23d540c74b	SE101E	3	A	f	CV027	f	2022-08-09 15:21:12.385271	2022-08-09 15:21:12.385271
13112a08-e258-4665-aeb9-4c3830fdaca6	SE101E	3	D	f	CV027	f	2022-08-09 15:21:12.390788	2022-08-09 15:21:12.390788
bdb14749-52e8-4637-b8fb-764a574a1cf6	SE101E	3	I	f	CV027	f	2022-08-09 15:21:12.396256	2022-08-09 15:21:12.396256
80af8513-0e72-4d61-9373-4dda710a891a	SE101E	3	W	f	CV027	f	2022-08-09 15:21:12.402392	2022-08-09 15:21:12.402392
bec6392d-1591-4bf6-8dcd-4672bfb019e9	SE101E	3	Z	f	CV027	f	2022-08-09 15:21:12.408381	2022-08-09 15:21:12.408381
1339d49b-03ff-4005-973b-3634000ca699	SE101E	3	A	t	CV118	f	2022-08-09 15:21:12.414171	2022-08-09 15:21:12.414171
62923576-c6c2-4234-a544-73930780e965	SE101E	3	D	t	CV118	f	2022-08-09 15:21:12.419979	2022-08-09 15:21:12.419979
afb47eee-d785-4cac-9fba-10639856c0f7	SE101E	3	I	t	CV118	f	2022-08-09 15:21:12.425426	2022-08-09 15:21:12.425426
60190768-9c25-4ac5-aa97-975b6ffe13c5	SE101E	3	W	t	CV118	f	2022-08-09 15:21:12.431253	2022-08-09 15:21:12.431253
7d08f7c8-81d6-4b91-80bd-d39742674b7a	SE101E	3	Z	t	CV118	f	2022-08-09 15:21:12.436582	2022-08-09 15:21:12.436582
fa4f1b06-3e3c-43d5-85d2-e7d6d4705a5f	SE101E	3	A	f	CV118	f	2022-08-09 15:21:12.442287	2022-08-09 15:21:12.442287
73db7b66-49f4-49fc-98cf-b830642fb70f	SE101E	3	D	f	CV118	f	2022-08-09 15:21:12.447592	2022-08-09 15:21:12.447592
c23cc311-eeb4-4a2d-b832-450755d27dc6	SE101E	3	I	f	CV118	f	2022-08-09 15:21:12.452923	2022-08-09 15:21:12.452923
105edb54-af80-44b0-92a7-e1b8518cffd2	SE101E	3	W	f	CV118	f	2022-08-09 15:21:12.458569	2022-08-09 15:21:12.458569
4975138d-edde-4dc2-870a-3af883e3e399	SE101E	3	Z	f	CV118	f	2022-08-09 15:21:12.463892	2022-08-09 15:21:12.463892
7c51568d-5def-47b1-8f5f-788c716e41c5	SE101E	3	A	t	EF012	f	2022-08-09 15:21:12.47021	2022-08-09 15:21:12.47021
49039c39-e694-4616-b9bd-ae8b8ef0985c	SE101E	3	D	t	EF012	f	2022-08-09 15:21:12.475694	2022-08-09 15:21:12.475694
d2282a85-7f97-4ffc-8e5f-ffa5edf0dc0b	SE101E	3	I	t	EF012	f	2022-08-09 15:21:12.481161	2022-08-09 15:21:12.481161
50a14791-7826-4cfb-bb68-815ad11d88e0	SE101E	3	W	t	EF012	f	2022-08-09 15:21:12.486788	2022-08-09 15:21:12.486788
90b221ab-9270-4424-8afb-334707c4accb	SE101E	3	Z	t	EF012	f	2022-08-09 15:21:12.492174	2022-08-09 15:21:12.492174
39e19fc3-56fd-4a85-a646-8f715bf092a6	SE101E	3	A	f	EF012	f	2022-08-09 15:21:12.497973	2022-08-09 15:21:12.497973
5c16ac8d-0e79-4b98-804c-746387c09cd8	SE101E	3	D	f	EF012	f	2022-08-09 15:21:12.503369	2022-08-09 15:21:12.503369
c602983f-883f-4a68-87d9-0833872b7a12	SE101E	3	I	f	EF012	f	2022-08-09 15:21:12.509046	2022-08-09 15:21:12.509046
c83d1ae2-685a-4252-9d13-f5af6388c20c	SE101E	3	W	f	EF012	f	2022-08-09 15:21:12.514883	2022-08-09 15:21:12.514883
c53dd03b-eeeb-4883-90dc-394def19219e	SE101E	3	Z	f	EF012	f	2022-08-09 15:21:12.52023	2022-08-09 15:21:12.52023
3690315f-982a-4746-89ef-37e1a4994aff	SE101E	3	A	t	EF022	f	2022-08-09 15:21:12.525717	2022-08-09 15:21:12.525717
8a6353e3-7097-48b3-b842-7f9a72770737	SE101E	3	D	t	EF022	f	2022-08-09 15:21:12.531611	2022-08-09 15:21:12.531611
17d9ed98-d7f6-4c87-ae1e-a4c41d5ebd7d	SE101E	3	I	t	EF022	f	2022-08-09 15:21:12.537212	2022-08-09 15:21:12.537212
7af68ffa-f366-4723-be27-0925cd2af693	SE101E	3	W	t	EF022	f	2022-08-09 15:21:12.542626	2022-08-09 15:21:12.542626
4eee45f7-e51c-4ce9-8e16-c4c645d29491	SE101E	3	Z	t	EF022	f	2022-08-09 15:21:12.548359	2022-08-09 15:21:12.548359
b1c2b160-c979-4b16-ac21-c77e367c543a	SE101E	3	A	f	EF022	f	2022-08-09 15:21:12.553739	2022-08-09 15:21:12.553739
1181e634-c68c-4343-a119-eb1f3c9a760c	SE101E	3	D	f	EF022	f	2022-08-09 15:21:12.559202	2022-08-09 15:21:12.559202
ae0469d4-fac8-46a7-aa21-be31a45febaf	SE101E	3	I	f	EF022	f	2022-08-09 15:21:12.565231	2022-08-09 15:21:12.565231
cca01f10-7b20-465b-ae26-d0bba01c074f	SE101E	3	W	f	EF022	f	2022-08-09 15:21:12.570841	2022-08-09 15:21:12.570841
2e53cc34-8294-4feb-b5ea-33a29cc382ac	SE101E	3	Z	f	EF022	f	2022-08-09 15:21:12.576853	2022-08-09 15:21:12.576853
a7be5eb2-8415-48a8-82f8-f20e554c9a0d	SE101E	3	A	t	EF025	f	2022-08-09 15:21:12.584208	2022-08-09 15:21:12.584208
1febb167-ce9e-4350-8c1e-e23623f7955a	SE101E	3	D	t	EF025	f	2022-08-09 15:21:12.590227	2022-08-09 15:21:12.590227
6d21b859-a57a-45fd-80e5-60b3a7825d0d	SE101E	3	I	t	EF025	f	2022-08-09 15:21:12.595984	2022-08-09 15:21:12.595984
a0d882d5-8778-4f67-9045-0a49db9630a5	SE101E	3	W	t	EF025	f	2022-08-09 15:21:12.601978	2022-08-09 15:21:12.601978
9af16d6d-cc98-4033-a583-6647011409dd	SE101E	3	Z	t	EF025	f	2022-08-09 15:21:12.607851	2022-08-09 15:21:12.607851
c7574890-f126-45e3-acef-966146ad4507	SE101E	3	A	f	EF025	f	2022-08-09 15:21:12.613786	2022-08-09 15:21:12.613786
53762492-346c-4935-b6c2-4d10d4e41578	SE101E	3	D	f	EF025	f	2022-08-09 15:21:12.619268	2022-08-09 15:21:12.619268
eec5bfe4-cb73-44eb-8797-90af7d405ffa	SE101E	3	I	f	EF025	f	2022-08-09 15:21:12.624635	2022-08-09 15:21:12.624635
f43fee88-2d1c-4d25-9d5b-f97832521012	SE101E	3	W	f	EF025	f	2022-08-09 15:21:12.631465	2022-08-09 15:21:12.631465
aee7702c-34fd-4c6d-9344-e41598c832f2	SE101E	3	Z	f	EF025	f	2022-08-09 15:21:12.638288	2022-08-09 15:21:12.638288
cfc26971-4140-4c1c-b1da-645c50dca58e	SE101E	3	A	t	EF026	f	2022-08-09 15:21:12.645269	2022-08-09 15:21:12.645269
6fd2a1f8-ad02-4b7f-85ca-78ceeb7e756e	SE101E	3	D	t	EF026	f	2022-08-09 15:21:12.651445	2022-08-09 15:21:12.651445
97c05d33-ebf7-4323-969a-9112d1253933	SE101E	3	I	t	EF026	f	2022-08-09 15:21:12.65729	2022-08-09 15:21:12.65729
f3cb02b6-fc9c-4040-bd76-a821965a4dde	SE101E	3	W	t	EF026	f	2022-08-09 15:21:12.662968	2022-08-09 15:21:12.662968
de5c07b7-c275-42f6-974d-ae7fc2895ec9	SE101E	3	Z	t	EF026	f	2022-08-09 15:21:12.668891	2022-08-09 15:21:12.668891
1e73118c-deed-4b43-b369-dd2c0830489e	SE101E	3	A	f	EF026	f	2022-08-09 15:21:12.674859	2022-08-09 15:21:12.674859
badd8ce8-e6fc-4217-9b13-21e52adc050d	SE101E	3	D	f	EF026	f	2022-08-09 15:21:12.680389	2022-08-09 15:21:12.680389
269563ed-4b20-4007-8bae-5bc9a382852f	SE101E	3	I	f	EF026	f	2022-08-09 15:21:12.686186	2022-08-09 15:21:12.686186
9705fab7-07cc-410d-802d-011c8b879ae2	SE101E	3	W	f	EF026	f	2022-08-09 15:21:12.691595	2022-08-09 15:21:12.691595
d5fc0539-0b68-4311-907a-4379f477b915	SE101E	3	Z	f	EF026	f	2022-08-09 15:21:12.69725	2022-08-09 15:21:12.69725
c5d74dd0-2028-40da-a4ce-fe26e3374a36	SE101E	3	A	t	EF027	f	2022-08-09 15:21:12.702588	2022-08-09 15:21:12.702588
7d4f9628-236d-47cf-839a-54e71d912a2e	SE101E	3	D	t	EF027	f	2022-08-09 15:21:12.708034	2022-08-09 15:21:12.708034
e761b8e6-0549-4ada-8438-8116cadda8d8	SE101E	3	I	t	EF027	f	2022-08-09 15:21:12.713853	2022-08-09 15:21:12.713853
4de3d37c-08aa-4e2b-9a27-df33064471ee	SE101E	3	W	t	EF027	f	2022-08-09 15:21:12.719878	2022-08-09 15:21:12.719878
ed91be6f-48ef-4d97-97d2-834b8e81d190	SE101E	3	Z	t	EF027	f	2022-08-09 15:21:12.726031	2022-08-09 15:21:12.726031
0813d735-4818-4403-8422-fc96eec5c772	SE101E	3	A	f	EF027	f	2022-08-09 15:21:12.731858	2022-08-09 15:21:12.731858
a0c33418-e0b6-4ab9-b7cd-d6169b840af8	SE101E	3	D	f	EF027	f	2022-08-09 15:21:12.737746	2022-08-09 15:21:12.737746
96bc7b4c-70a7-4292-81cf-8eded426bd87	SE101E	3	I	f	EF027	f	2022-08-09 15:21:12.743234	2022-08-09 15:21:12.743234
ae17278a-7c78-490c-912e-0a9df9348f15	SE101E	3	W	f	EF027	f	2022-08-09 15:21:12.748686	2022-08-09 15:21:12.748686
7d271762-178f-49a5-bcd4-66382d4d4c2a	SE101E	3	Z	f	EF027	f	2022-08-09 15:21:12.754324	2022-08-09 15:21:12.754324
f2f135b6-e724-4246-b817-76b920f03f58	SE101E	3	A	t	FM049	f	2022-08-09 15:21:12.818511	2022-08-09 15:21:12.818511
644c3773-5d61-4023-bcb5-3b6938dfff77	SE101E	3	D	t	FM049	f	2022-08-09 15:21:12.824716	2022-08-09 15:21:12.824716
bcba891d-40e9-4bce-9c06-d1a26ce48011	SE101E	3	I	t	FM049	f	2022-08-09 15:21:12.830833	2022-08-09 15:21:12.830833
6f3bf59f-ee55-4b75-bba3-f05df29d392e	SE101E	3	W	t	FM049	f	2022-08-09 15:21:12.836682	2022-08-09 15:21:12.836682
113faf26-3fce-4ddc-8ee7-51ac4367352f	SE101E	3	Z	t	FM049	f	2022-08-09 15:21:12.842408	2022-08-09 15:21:12.842408
ebbd8772-bee4-4d8c-96f6-12ea0bd9cabe	SE101E	3	A	f	FM049	f	2022-08-09 15:21:12.848	2022-08-09 15:21:12.848
082a1422-17a6-4e77-ab66-9b50e9c69e6c	SE101E	3	D	f	FM049	f	2022-08-09 15:21:12.853517	2022-08-09 15:21:12.853517
c9e9ac0d-cfa8-4db2-951c-a7c9376fc448	SE101E	3	I	f	FM049	f	2022-08-09 15:21:12.859361	2022-08-09 15:21:12.859361
5ea15099-d627-4a66-b351-c46c2f55a1c8	SE101E	3	W	f	FM049	f	2022-08-09 15:21:12.864739	2022-08-09 15:21:12.864739
8ad8ec0b-6300-449c-a4ee-89e82bc896a2	SE101E	3	Z	f	FM049	f	2022-08-09 15:21:12.870607	2022-08-09 15:21:12.870607
0507a529-e0f7-4353-91c2-9de83331c9b3	SE101E	3	A	t	MC029	f	2022-08-09 15:21:12.876002	2022-08-09 15:21:12.876002
83af9fcc-17ca-4bef-a3fa-4c8d618211e0	SE101E	3	D	t	MC029	f	2022-08-09 15:21:12.881443	2022-08-09 15:21:12.881443
b7c4b905-0826-41f3-b1b1-84898266883b	SE101E	3	I	t	MC029	f	2022-08-09 15:21:12.887054	2022-08-09 15:21:12.887054
aa65af70-85c6-42e5-a323-1225837a17e3	SE101E	3	W	t	MC029	f	2022-08-09 15:21:12.892396	2022-08-09 15:21:12.892396
da142e42-033f-4c80-ac9b-04b6c9d77af8	SE101E	3	Z	t	MC029	f	2022-08-09 15:21:12.897787	2022-08-09 15:21:12.897787
7ef8b780-83fa-413b-a4a0-469c9ef95482	SE101E	3	A	f	MC029	f	2022-08-09 15:21:12.903577	2022-08-09 15:21:12.903577
aab10010-5213-445c-8fc3-36c697b1d46c	SE101E	3	D	f	MC029	f	2022-08-09 15:21:12.908875	2022-08-09 15:21:12.908875
f0db35e0-ee08-48ea-8307-89eb402f8f5a	SE101E	3	I	f	MC029	f	2022-08-09 15:21:12.914245	2022-08-09 15:21:12.914245
f44453f5-d161-43ad-841c-94651c9d260d	SE101E	3	W	f	MC029	f	2022-08-09 15:21:12.919982	2022-08-09 15:21:12.919982
83dafe57-a62f-429c-a2a2-8591586278f5	SE101E	3	Z	f	MC029	f	2022-08-09 15:21:12.925245	2022-08-09 15:21:12.925245
108a6854-301d-4c83-9701-91c2f193bcba	SE101E	3	A	f	FM019	t	2022-08-09 15:21:12.7877	2022-08-09 15:21:12.932599
4fbbde11-7cee-474c-9a10-357605ac1646	SE101E	3	D	f	FM019	t	2022-08-09 15:21:12.793522	2022-08-09 15:21:12.939857
da318efc-ad59-44d7-bfa3-279a1da8cb61	SE101E	3	I	f	FM019	t	2022-08-09 15:21:12.799293	2022-08-09 15:21:12.947189
25210666-271a-4846-9dc4-94e61d692ab7	SE101E	3	W	f	FM019	t	2022-08-09 15:21:12.805193	2022-08-09 15:21:12.954487
70dd9cfc-b113-4e70-8f4c-c529f5465238	SE101E	3	Z	f	FM019	t	2022-08-09 15:21:12.812115	2022-08-09 15:21:12.962955
eeb4478e-b604-4e0b-8562-d70df8f88e56	SE101E	3	A	t	FM019	t	2022-08-09 15:21:12.759832	2022-08-09 15:21:12.970948
7fcb02dd-b682-44dc-a190-3aa38c1182bd	SE101E	3	D	t	FM019	t	2022-08-09 15:21:12.765447	2022-08-09 15:21:12.978437
d731ee5a-87c0-4e2a-b479-660426b90226	SE101E	3	I	t	FM019	t	2022-08-09 15:21:12.770919	2022-08-09 15:21:12.985941
bb49c0e5-f67c-40ad-87bf-bf8d73d1fb3b	SE101E	3	W	t	FM019	t	2022-08-09 15:21:12.776411	2022-08-09 15:21:12.993486
b6f44379-2af1-48fa-9b90-76e15b7a524a	SE101E	3	Z	t	FM019	t	2022-08-09 15:21:12.782179	2022-08-09 15:21:13.001364
e7539d01-4b1a-419c-9bf3-048333154b8b	DA001	3	A	t	AA009	f	2022-08-09 15:21:13.006932	2022-08-09 15:21:13.006932
71706f05-8608-4e13-b7b5-518b1cc5e306	DA001	3	D	t	AA009	f	2022-08-09 15:21:13.012645	2022-08-09 15:21:13.012645
9733ef1b-3abf-4bd1-98b7-58e72015ab08	DA001	3	I	t	AA009	f	2022-08-09 15:21:13.017967	2022-08-09 15:21:13.017967
cbd43006-2b41-4fa4-8a39-b54bfe59db7b	DA001	3	W	t	AA009	f	2022-08-09 15:21:13.023773	2022-08-09 15:21:13.023773
29aa74d5-6ce7-40fc-bd9e-46600e48ef13	DA001	3	Z	t	AA009	f	2022-08-09 15:21:13.029127	2022-08-09 15:21:13.029127
29e31d7d-9969-4d21-8f12-a4c20f9fc02c	DA001	3	A	f	AA009	f	2022-08-09 15:21:13.034439	2022-08-09 15:21:13.034439
c249eab4-81ab-423c-8142-2e9896543c4e	DA001	3	D	f	AA009	f	2022-08-09 15:21:13.040047	2022-08-09 15:21:13.040047
2a7095d7-db9a-487a-9c44-e9edfcd61a9f	DA001	3	I	f	AA009	f	2022-08-09 15:21:13.045418	2022-08-09 15:21:13.045418
db8c6c82-f95f-4c29-a52a-87a8bb0d4e5c	DA001	3	W	f	AA009	f	2022-08-09 15:21:13.051066	2022-08-09 15:21:13.051066
dc8bc444-487c-4c36-8f5e-e57d9cd4a026	DA001	3	Z	f	AA009	f	2022-08-09 15:21:13.056371	2022-08-09 15:21:13.056371
2d8da677-0ad3-499e-9322-eac131ea8297	DA001	3	A	t	CV027	f	2022-08-09 15:21:13.097335	2022-08-09 15:21:13.097335
b2fe0f38-8ac3-48ef-a933-1d3d8e53bc98	DA001	3	D	t	CV027	f	2022-08-09 15:21:13.102868	2022-08-09 15:21:13.102868
0b682924-c0f2-4ee5-9cc9-670063f3bf58	DA001	3	I	t	CV027	f	2022-08-09 15:21:13.1087	2022-08-09 15:21:13.1087
2ab68ff6-ed5d-4a3e-b5db-b3a522b1a2fb	DA001	3	W	t	CV027	f	2022-08-09 15:21:13.114169	2022-08-09 15:21:13.114169
adbff99d-1c7a-4ec2-8a6d-165598e93887	DA001	3	Z	t	CV027	f	2022-08-09 15:21:13.119552	2022-08-09 15:21:13.119552
c89fe21d-1065-46f1-b02a-8b775639b273	DA001	3	A	f	CV027	f	2022-08-09 15:21:13.125285	2022-08-09 15:21:13.125285
940b1838-be6d-497e-899b-66b313cbe025	DA001	3	D	f	CV027	f	2022-08-09 15:21:13.130697	2022-08-09 15:21:13.130697
abb9bc07-5cc2-478c-a70d-4c7e5949721f	DA001	3	I	f	CV027	f	2022-08-09 15:21:13.13643	2022-08-09 15:21:13.13643
b2cec7c9-305e-41d9-9666-2a4a14c1c315	DA001	3	W	f	CV027	f	2022-08-09 15:21:13.142095	2022-08-09 15:21:13.142095
a0553bf6-3871-412d-b887-339f3a66be08	DA001	3	Z	f	CV027	f	2022-08-09 15:21:13.147435	2022-08-09 15:21:13.147435
07255aa4-5fef-410c-9afb-33a9edd1c930	DA001	3	A	t	CV079	f	2022-08-09 15:21:13.153203	2022-08-09 15:21:13.153203
50525584-881b-48af-a88b-fcbe29ad4201	DA001	3	D	t	CV079	f	2022-08-09 15:21:13.158568	2022-08-09 15:21:13.158568
259294f2-ae14-46d0-9990-12948be849fa	DA001	3	I	t	CV079	f	2022-08-09 15:21:13.163869	2022-08-09 15:21:13.163869
557fb354-c3a1-476c-bbb3-bd2628e8161a	DA001	3	W	t	CV079	f	2022-08-09 15:21:13.169647	2022-08-09 15:21:13.169647
605fe7bc-70b6-447d-9ada-d50b0b17ebb9	DA001	3	Z	t	CV079	f	2022-08-09 15:21:13.175148	2022-08-09 15:21:13.175148
ecece51d-60cd-482a-86b7-2ff3947bbe12	DA001	3	A	f	CV079	f	2022-08-09 15:21:13.181067	2022-08-09 15:21:13.181067
8a624bbb-6001-4d5e-aa90-0b7b0d3f5d62	DA001	3	D	f	CV079	f	2022-08-09 15:21:13.186595	2022-08-09 15:21:13.186595
ffbe8a80-c6a5-419d-ba55-2f63c0f17628	DA001	3	I	f	CV079	f	2022-08-09 15:21:13.191926	2022-08-09 15:21:13.191926
160e690e-e2e9-42e4-956b-a1bad8a60b82	DA001	3	W	f	CV079	f	2022-08-09 15:21:13.197765	2022-08-09 15:21:13.197765
c7acef48-9752-4d19-9c58-64e598e4b199	DA001	3	Z	f	CV079	f	2022-08-09 15:21:13.203219	2022-08-09 15:21:13.203219
40c8d272-aee5-405f-b9a6-a955f059aff5	DA001	3	D	t	CV117	f	2022-08-09 15:21:13.214461	2022-08-09 15:21:13.214461
256b2e6b-8cf2-4c6e-af53-688e7c279ad5	DA001	3	I	t	CV117	f	2022-08-09 15:21:13.219927	2022-08-09 15:21:13.219927
3c34fd89-c6d7-47dc-863e-bc878597d4ec	DA001	3	W	t	CV117	f	2022-08-09 15:21:13.225293	2022-08-09 15:21:13.225293
ae868577-a2ec-40a5-9c7b-00e2412a5abc	DA001	3	Z	t	CV117	f	2022-08-09 15:21:13.231535	2022-08-09 15:21:13.231535
5ced72a6-57e7-4669-b7c5-2ceec9eb26ae	DA001	3	A	f	CV117	f	2022-08-09 15:21:13.23704	2022-08-09 15:21:13.23704
c29e66d0-f719-4144-98f9-4f24e0e3c7e9	DA001	3	D	f	CV117	f	2022-08-09 15:21:13.242676	2022-08-09 15:21:13.242676
d64b41fb-e258-4448-a224-9f3bac37b592	DA001	3	I	f	CV117	f	2022-08-09 15:21:13.248513	2022-08-09 15:21:13.248513
dfc8265c-0940-4bc5-88b1-cb44db54610c	DA001	3	W	f	CV117	f	2022-08-09 15:21:13.254501	2022-08-09 15:21:13.254501
65ca6014-b671-4dd6-b865-7008a067481c	DA001	3	Z	f	CV117	f	2022-08-09 15:21:13.259863	2022-08-09 15:21:13.259863
f3a00a0d-e2d9-487b-b9d3-d94d12e5222c	DA001	3	A	t	CV118	f	2022-08-09 15:21:13.26541	2022-08-09 15:21:13.26541
f497e64e-9531-4c07-9173-358fe56d4117	DA001	3	A	f	CV118	f	2022-08-09 15:21:13.294698	2022-08-09 15:21:13.294698
542fc757-d81b-4f87-9f18-21db9ec003b1	DA001	3	D	f	CV118	f	2022-08-09 15:21:13.300831	2022-08-09 15:21:13.300831
fa49dcc2-9e70-40b6-bfd6-ce754a8ffd1f	DA001	3	I	f	CV118	f	2022-08-09 15:21:13.306849	2022-08-09 15:21:13.306849
e5299251-cea9-4482-86b1-4d6a14312a1f	DA001	3	W	f	CV118	f	2022-08-09 15:21:13.313053	2022-08-09 15:21:13.313053
fc090e11-c142-45e7-a25e-1b36f55b4507	DA001	3	Z	f	CV118	f	2022-08-09 15:21:13.318659	2022-08-09 15:21:13.318659
420a7377-dc0e-4d84-8432-decfdfb69a2d	DA001	3	A	t	FM054	f	2022-08-09 15:21:13.324465	2022-08-09 15:21:13.324465
ab1bf1e7-59e1-4445-b596-31c6a19ddab2	DA001	3	D	t	FM054	f	2022-08-09 15:21:13.330015	2022-08-09 15:21:13.330015
5daffd1a-f80b-4d57-8b47-29fde589c272	DA001	3	I	t	FM054	f	2022-08-09 15:21:13.335684	2022-08-09 15:21:13.335684
57119955-d8cd-49e4-afe5-975564f1e2b4	DA001	3	W	t	FM054	f	2022-08-09 15:21:13.34105	2022-08-09 15:21:13.34105
8f147ab9-1237-4add-bfdf-f18ff2a4d6c3	DA001	3	Z	t	FM054	f	2022-08-09 15:21:13.347525	2022-08-09 15:21:13.347525
6d9967e1-dd3d-46bd-8b54-555876a7f467	DA001	3	A	f	FM054	f	2022-08-09 15:21:13.354842	2022-08-09 15:21:13.354842
3a025cab-63fe-4042-8f68-ec26c97282e6	DA001	3	D	f	FM054	f	2022-08-09 15:21:13.361621	2022-08-09 15:21:13.361621
f4d3543e-019c-4992-b459-f12e0f81f836	DA001	3	I	f	FM054	f	2022-08-09 15:21:13.367783	2022-08-09 15:21:13.367783
4c458e92-df55-4c36-8ce8-d2b8d9cafa7f	DA001	3	W	f	FM054	f	2022-08-09 15:21:13.374117	2022-08-09 15:21:13.374117
bbc05ffd-5334-4faa-9bab-fadaea2fc0f7	DA001	3	Z	f	FM054	f	2022-08-09 15:21:13.380583	2022-08-09 15:21:13.380583
7e2afdf4-6118-4e6b-b660-dbe9ee421a55	DA001	3	A	f	AA019	t	2022-08-09 15:21:13.067908	2022-08-09 15:21:13.38823
e8f503e6-0e60-40c6-afeb-f38109cdff1f	DA001	3	D	f	AA019	t	2022-08-09 15:21:13.073524	2022-08-09 15:21:13.396432
44aae65e-482f-4f5e-90f9-43c8ce3add62	DA001	3	I	f	AA019	t	2022-08-09 15:21:13.079915	2022-08-09 15:21:13.404138
af324c6d-7208-4da7-a878-99e1db061636	DA001	3	W	f	AA019	t	2022-08-09 15:21:13.085825	2022-08-09 15:21:13.411333
b6a4f05f-94c0-4e0d-a601-e2a07a6222b1	DA001	3	Z	f	AA019	t	2022-08-09 15:21:13.091409	2022-08-09 15:21:13.418659
ed6a78e8-78fa-4608-bd9c-ae6b9439489d	DA001	3	A	t	CV117	t	2022-08-09 15:21:13.208827	2022-08-09 15:21:13.426082
9c0af183-701a-4a4b-9113-708d29e6a0ad	DA001	3	D	t	CV118	t	2022-08-09 15:21:13.270819	2022-08-09 15:21:13.432997
560de4c4-e9c9-4ca7-8d06-d8c98f39759f	DA001	3	I	t	CV118	t	2022-08-09 15:21:13.276134	2022-08-09 15:21:13.440327
2b237342-8e70-46a9-8501-db2aae9ba6cb	DA001	3	W	t	CV118	t	2022-08-09 15:21:13.281958	2022-08-09 15:21:13.447645
b62b366e-c4ee-4f35-98d6-1119931915ba	DA001	3	Z	t	CV118	t	2022-08-09 15:21:13.287384	2022-08-09 15:21:13.455023
8d1d6e9f-dedd-4950-bf92-f75b12967881	DA002	3	A	t	AA009	f	2022-08-09 15:21:13.460401	2022-08-09 15:21:13.460401
8a50577d-7c30-4221-ac28-872a861fbc65	DA002	3	D	t	AA009	f	2022-08-09 15:21:13.466177	2022-08-09 15:21:13.466177
d4665662-0175-455d-97c5-e79d0b1fe2c9	DA002	3	I	t	AA009	f	2022-08-09 15:21:13.471487	2022-08-09 15:21:13.471487
dbfe46be-72ce-4109-baa0-3fba19dc6e52	DA002	3	W	t	AA009	f	2022-08-09 15:21:13.476931	2022-08-09 15:21:13.476931
0a2c17b8-ef95-4299-ab8d-b08ed7532b33	DA002	3	Z	t	AA009	f	2022-08-09 15:21:13.482654	2022-08-09 15:21:13.482654
a8423b17-8b1a-4119-8548-02c7832b635a	DA002	3	A	f	AA009	f	2022-08-09 15:21:13.487915	2022-08-09 15:21:13.487915
15640d9d-7185-47ad-b5b0-6097197e4a22	DA002	3	D	f	AA009	f	2022-08-09 15:21:13.493515	2022-08-09 15:21:13.493515
25aaef81-baf6-4946-9d47-ab4c2b9dac91	DA002	3	I	f	AA009	f	2022-08-09 15:21:13.498906	2022-08-09 15:21:13.498906
a12f0d22-6ef0-4d86-b69b-696ab933937a	DA002	3	W	f	AA009	f	2022-08-09 15:21:13.504281	2022-08-09 15:21:13.504281
88285c82-f8af-4ca4-b87f-cfa460a72150	DA002	3	Z	f	AA009	f	2022-08-09 15:21:13.510127	2022-08-09 15:21:13.510127
9bae96d3-f202-4a3c-947b-ba5222794aa3	DA002	3	A	t	CV027	f	2022-08-09 15:21:13.548554	2022-08-09 15:21:13.548554
eab725f2-7731-40c0-9bdb-c5f5054472d2	DA002	3	D	t	CV027	f	2022-08-09 15:21:13.553974	2022-08-09 15:21:13.553974
bcc6580f-dd08-4d53-980b-f911d4527ad8	DA002	3	I	t	CV027	f	2022-08-09 15:21:13.560076	2022-08-09 15:21:13.560076
6d20ec74-b317-4173-9211-6fc091e95a7c	DA002	3	W	t	CV027	f	2022-08-09 15:21:13.565441	2022-08-09 15:21:13.565441
59e5deca-e2a6-4db3-9842-f56c54da0d6c	DA002	3	Z	t	CV027	f	2022-08-09 15:21:13.570774	2022-08-09 15:21:13.570774
eb8ffb01-5319-4ff3-bbe2-9b06620231f0	DA002	3	A	f	CV027	f	2022-08-09 15:21:13.576557	2022-08-09 15:21:13.576557
33173aaa-d865-4d28-99a6-9a21a20f1d89	DA002	3	D	f	CV027	f	2022-08-09 15:21:13.584243	2022-08-09 15:21:13.584243
6d68a733-4447-42d9-8f1a-7915bd1203a1	DA002	3	I	f	CV027	f	2022-08-09 15:21:13.590545	2022-08-09 15:21:13.590545
f686b049-bb3c-4cac-9e31-24ca58f4e0f7	DA002	3	W	f	CV027	f	2022-08-09 15:21:13.595846	2022-08-09 15:21:13.595846
0293a93f-189c-44f5-8da4-142ed0cedec8	DA002	3	Z	f	CV027	f	2022-08-09 15:21:13.601707	2022-08-09 15:21:13.601707
43840b26-92c8-41ef-a11b-18e2a0a21ece	DA002	3	A	t	CV079	f	2022-08-09 15:21:13.607408	2022-08-09 15:21:13.607408
181370dd-5590-4f58-a5ff-3507719cc939	DA002	3	D	t	CV079	f	2022-08-09 15:21:13.612919	2022-08-09 15:21:13.612919
d02643d2-6387-4d4a-b374-49c0b8df7672	DA002	3	I	t	CV079	f	2022-08-09 15:21:13.618573	2022-08-09 15:21:13.618573
dbe62eaa-60bf-48c9-97a8-941465c568ac	DA002	3	W	t	CV079	f	2022-08-09 15:21:13.623878	2022-08-09 15:21:13.623878
d41425a3-a7e7-45f5-9914-d60cf21fbaa3	DA002	3	Z	t	CV079	f	2022-08-09 15:21:13.630901	2022-08-09 15:21:13.630901
5c7298ea-b312-4d09-89b6-96a7fa2ec0d2	DA002	3	A	f	CV079	f	2022-08-09 15:21:13.636847	2022-08-09 15:21:13.636847
d913c683-fe64-40d5-bd79-027c01e3f3dc	DA002	3	D	f	CV079	f	2022-08-09 15:21:13.642301	2022-08-09 15:21:13.642301
f196e74f-af2e-4e40-8c74-6112ccd814da	DA002	3	I	f	CV079	f	2022-08-09 15:21:13.648178	2022-08-09 15:21:13.648178
294f8dd0-9962-4a0d-aa1c-a67f07f32f6e	DA002	3	W	f	CV079	f	2022-08-09 15:21:13.653674	2022-08-09 15:21:13.653674
1a82e998-deb3-4fb6-bc8a-1850ce1c310d	DA002	3	Z	f	CV079	f	2022-08-09 15:21:13.659593	2022-08-09 15:21:13.659593
e599bad4-58cd-47da-80b2-7922a3b75065	DA002	3	D	t	CV117	f	2022-08-09 15:21:13.671091	2022-08-09 15:21:13.671091
1cce2e71-fbed-46a2-8655-228a7fbe994f	DA002	3	I	t	CV117	f	2022-08-09 15:21:13.677055	2022-08-09 15:21:13.677055
7fa793da-afa2-4a02-b546-5bc49363d3f2	DA002	3	W	t	CV117	f	2022-08-09 15:21:13.682427	2022-08-09 15:21:13.682427
f553a334-7728-4e0d-b0ce-c1b015fc08f4	DA002	3	Z	t	CV117	f	2022-08-09 15:21:13.687894	2022-08-09 15:21:13.687894
28ed7534-0833-41e8-a483-76aa86f1b471	DA002	3	A	f	CV117	f	2022-08-09 15:21:13.693537	2022-08-09 15:21:13.693537
409e8c54-4245-4f01-944a-990d1ab74faf	DA002	3	D	f	CV117	f	2022-08-09 15:21:13.698967	2022-08-09 15:21:13.698967
45acd9e1-12d6-4725-8a2e-002e833e50f7	DA002	3	I	f	CV117	f	2022-08-09 15:21:13.705111	2022-08-09 15:21:13.705111
8bdb135b-4406-4eb2-b868-23df4029932a	DA002	3	W	f	CV117	f	2022-08-09 15:21:13.712076	2022-08-09 15:21:13.712076
13a61fba-809d-486d-b2fe-8148a3c55a0c	DA002	3	Z	f	CV117	f	2022-08-09 15:21:13.718529	2022-08-09 15:21:13.718529
7ca5e525-b7d7-4ea5-b730-dbc51cef4623	DA002	3	A	t	CV118	f	2022-08-09 15:21:13.724428	2022-08-09 15:21:13.724428
a9e66bc9-c86e-4854-a6ef-512654f03b99	DA002	3	A	f	CV118	f	2022-08-09 15:21:13.755397	2022-08-09 15:21:13.755397
132255f5-00d7-4860-a894-fad0ef4f8099	DA002	3	D	f	CV118	f	2022-08-09 15:21:13.76097	2022-08-09 15:21:13.76097
3dd65921-7b45-42a2-a462-2e650491d3b8	DA002	3	I	f	CV118	f	2022-08-09 15:21:13.766708	2022-08-09 15:21:13.766708
4244f782-952b-4e56-bcd3-e2e67498e5c9	DA002	3	W	f	CV118	f	2022-08-09 15:21:13.772094	2022-08-09 15:21:13.772094
8ed7e790-ba21-46f0-91d4-ffa167a5a0f7	DA002	3	Z	f	CV118	f	2022-08-09 15:21:13.777864	2022-08-09 15:21:13.777864
9206255c-cdf5-4da4-9498-02e266df336b	DA002	3	A	t	FM054	f	2022-08-09 15:21:13.783367	2022-08-09 15:21:13.783367
603cd8bc-79a7-490e-9301-18fe85eeccb9	DA002	3	D	t	FM054	f	2022-08-09 15:21:13.789118	2022-08-09 15:21:13.789118
b5f3d0ae-b816-4c0d-aaeb-c9e7ccc49188	DA002	3	I	t	FM054	f	2022-08-09 15:21:13.794504	2022-08-09 15:21:13.794504
a091ad8f-d7c4-4781-8c41-4b789ad53325	DA002	3	W	t	FM054	f	2022-08-09 15:21:13.799989	2022-08-09 15:21:13.799989
9b91fb60-b372-40e5-ad62-9781f7a6ede7	DA002	3	Z	t	FM054	f	2022-08-09 15:21:13.806202	2022-08-09 15:21:13.806202
934e4c58-7e19-4ab6-8473-9f087fa1c678	DA002	3	A	f	FM054	f	2022-08-09 15:21:13.811584	2022-08-09 15:21:13.811584
ff72428e-0277-452e-9251-e7cba2bb06b4	DA002	3	D	f	FM054	f	2022-08-09 15:21:13.816813	2022-08-09 15:21:13.816813
2b910a4d-95d3-40f8-8fe1-76676345af6f	DA002	3	I	f	FM054	f	2022-08-09 15:21:13.822521	2022-08-09 15:21:13.822521
955beece-5cb2-4016-9872-075929c24300	DA002	3	W	f	FM054	f	2022-08-09 15:21:13.827792	2022-08-09 15:21:13.827792
663f43db-13ee-4132-92f5-a31a1219006d	DA002	3	Z	f	FM054	f	2022-08-09 15:21:13.833433	2022-08-09 15:21:13.833433
11136314-1a18-49bb-95c6-d4bd4af91549	DA002	3	A	f	AA019	t	2022-08-09 15:21:13.519653	2022-08-09 15:21:13.840527
d39ca3b7-93b1-44dc-b2ea-7e4c60d6ca7c	DA002	3	D	f	AA019	t	2022-08-09 15:21:13.525067	2022-08-09 15:21:13.848094
1be708ff-f60e-4aa0-8402-0a7304ea7ac5	DA002	3	I	f	AA019	t	2022-08-09 15:21:13.531331	2022-08-09 15:21:13.855858
6f63d913-3ed4-4201-8264-80784502f4d6	DA002	3	W	f	AA019	t	2022-08-09 15:21:13.536958	2022-08-09 15:21:13.863036
0750d954-f7d8-448a-baee-1fb51525bf61	DA002	3	Z	f	AA019	t	2022-08-09 15:21:13.542421	2022-08-09 15:21:13.870486
dc4b9490-47a5-4455-8792-51e04d1d878b	DA002	3	A	t	CV117	t	2022-08-09 15:21:13.665066	2022-08-09 15:21:13.877775
d72101ce-8619-4ba5-99c8-8a395c6f8eb1	DA002	3	D	t	CV118	t	2022-08-09 15:21:13.730614	2022-08-09 15:21:13.885112
961eaac6-8a81-4726-9227-0472c37ec39e	DA002	3	I	t	CV118	t	2022-08-09 15:21:13.736692	2022-08-09 15:21:13.892048
2d7b48c3-c424-426f-8b41-0a37e97fe28f	DA002	3	W	t	CV118	t	2022-08-09 15:21:13.743098	2022-08-09 15:21:13.899534
9daa158a-1051-441f-9235-1019a8b1fa03	DA002	3	Z	t	CV118	t	2022-08-09 15:21:13.749522	2022-08-09 15:21:13.906793
69af5cd6-1cbc-44a8-bb83-c5d891fb5ca4	DA003	3	A	t	AA009	f	2022-08-09 15:21:13.912061	2022-08-09 15:21:13.912061
cdccb113-76ba-4554-8a05-cd6ba0500cdb	DA003	3	D	t	AA009	f	2022-08-09 15:21:13.917722	2022-08-09 15:21:13.917722
683e44b4-1669-4b1e-8be4-2532e74d7b11	DA003	3	I	t	AA009	f	2022-08-09 15:21:13.92303	2022-08-09 15:21:13.92303
19339839-54e6-4ca3-8ecc-0b38156587cf	DA003	3	W	t	AA009	f	2022-08-09 15:21:13.928601	2022-08-09 15:21:13.928601
59e5d367-5d7a-43e7-a02c-6d14ff826c4f	DA003	3	Z	t	AA009	f	2022-08-09 15:21:13.934209	2022-08-09 15:21:13.934209
c3d926a4-4ee9-4e13-9fec-1a28c8da4e91	DA003	3	A	f	AA009	f	2022-08-09 15:21:13.939964	2022-08-09 15:21:13.939964
af5f10d2-6def-4c7f-954c-d8d6c3b12495	DA003	3	D	f	AA009	f	2022-08-09 15:21:13.945331	2022-08-09 15:21:13.945331
1d398bc9-a8c3-4d50-9f55-b7ab37d1232c	DA003	3	I	f	AA009	f	2022-08-09 15:21:13.950714	2022-08-09 15:21:13.950714
629c0cba-908e-4440-903e-b65cd377bd56	DA003	3	W	f	AA009	f	2022-08-09 15:21:13.957395	2022-08-09 15:21:13.957395
de8164fc-a424-4141-ba63-48f8b8837a18	DA003	3	Z	f	AA009	f	2022-08-09 15:21:13.963002	2022-08-09 15:21:13.963002
dc554eac-d2a3-41d4-b984-330356247f24	DA003	3	A	t	CV027	f	2022-08-09 15:21:14.002085	2022-08-09 15:21:14.002085
258cad2f-0869-4ee6-9477-213a7a839cf3	DA003	3	D	t	CV027	f	2022-08-09 15:21:14.008214	2022-08-09 15:21:14.008214
abd53c29-cbf3-4b31-aecb-9aac1c422296	DA003	3	I	t	CV027	f	2022-08-09 15:21:14.013684	2022-08-09 15:21:14.013684
ff6240fc-5fe9-4d91-9f1f-f2374e3e3839	DA003	3	W	t	CV027	f	2022-08-09 15:21:14.0194	2022-08-09 15:21:14.0194
e9e2fb8c-db5b-4d10-a615-8e284971c2a5	DA003	3	Z	t	CV027	f	2022-08-09 15:21:14.024699	2022-08-09 15:21:14.024699
a6886ac7-e881-445d-a2e7-5f17b94b0a93	DA003	3	A	f	CV027	f	2022-08-09 15:21:14.030078	2022-08-09 15:21:14.030078
0ea4ae6f-3904-4ae1-85de-ad80169f43b9	DA003	3	D	f	CV027	f	2022-08-09 15:21:14.035801	2022-08-09 15:21:14.035801
205b5568-b1ec-4c4d-813b-2967186712f0	DA003	3	I	f	CV027	f	2022-08-09 15:21:14.041903	2022-08-09 15:21:14.041903
02322a78-5bf2-4527-a614-9606cc754f5e	DA003	3	W	f	CV027	f	2022-08-09 15:21:14.048327	2022-08-09 15:21:14.048327
b429f4fc-3970-46ce-ae65-603f8b95fd4b	DA003	3	Z	f	CV027	f	2022-08-09 15:21:14.054102	2022-08-09 15:21:14.054102
12de870e-f7c4-4808-b363-45060419068a	DA003	3	A	t	CV079	f	2022-08-09 15:21:14.059806	2022-08-09 15:21:14.059806
b904fe97-28fc-4cce-8abd-3a84568368e1	DA003	3	D	t	CV079	f	2022-08-09 15:21:14.065246	2022-08-09 15:21:14.065246
af0b6f79-a4af-42cf-83d4-a541f2e635df	DA003	3	I	t	CV079	f	2022-08-09 15:21:14.071649	2022-08-09 15:21:14.071649
7e9a4417-c200-4375-8edf-37fa80a801e0	DA003	3	W	t	CV079	f	2022-08-09 15:21:14.078517	2022-08-09 15:21:14.078517
00725a00-e45e-4bf3-9720-f6c3d9231d7f	DA003	3	Z	t	CV079	f	2022-08-09 15:21:14.083942	2022-08-09 15:21:14.083942
875781fd-5b56-40af-a85e-188b3c19de19	DA003	3	A	f	CV079	f	2022-08-09 15:21:14.089309	2022-08-09 15:21:14.089309
61d9020a-b551-42c8-82ae-357f323ffbfb	DA003	3	D	f	CV079	f	2022-08-09 15:21:14.094974	2022-08-09 15:21:14.094974
feba157d-cd01-4702-b0b7-9043b42d33c1	DA003	3	I	f	CV079	f	2022-08-09 15:21:14.100733	2022-08-09 15:21:14.100733
6f4c9173-dbed-40f2-9dd4-fc57b6d3c6bd	DA003	3	W	f	CV079	f	2022-08-09 15:21:14.107316	2022-08-09 15:21:14.107316
f3887f5f-3adf-4338-b9d6-6bdb3d3a9a7c	DA003	3	Z	f	CV079	f	2022-08-09 15:21:14.113044	2022-08-09 15:21:14.113044
417c1d54-4856-4533-9d55-b40dd518fb1e	DA003	3	D	t	CV117	f	2022-08-09 15:21:14.125314	2022-08-09 15:21:14.125314
195efd1e-b699-41d3-9593-013cb36705dc	DA003	3	I	t	CV117	f	2022-08-09 15:21:14.131071	2022-08-09 15:21:14.131071
9af9d5d6-0a9d-49d6-8510-b05542d42158	DA003	3	W	t	CV117	f	2022-08-09 15:21:14.136848	2022-08-09 15:21:14.136848
cbf03c98-dbf9-491a-a741-2f163dc78824	DA003	3	Z	t	CV117	f	2022-08-09 15:21:14.142242	2022-08-09 15:21:14.142242
9e532e7e-9a0a-45e6-bc70-437de6ae6b3b	DA003	3	A	f	CV117	f	2022-08-09 15:21:14.147915	2022-08-09 15:21:14.147915
9cd1052f-996b-4bdf-9910-5842b704cbd8	DA003	3	D	f	CV117	f	2022-08-09 15:21:14.153615	2022-08-09 15:21:14.153615
90c682c6-30b7-4e8f-a90a-93ce87815643	DA003	3	I	f	CV117	f	2022-08-09 15:21:14.159312	2022-08-09 15:21:14.159312
4bbc9fc0-a834-458c-aa27-95e1140340b1	DA003	3	W	f	CV117	f	2022-08-09 15:21:14.164881	2022-08-09 15:21:14.164881
da6d8c08-d1c5-47f5-9852-c82e230ed2bd	DA003	3	Z	f	CV117	f	2022-08-09 15:21:14.170482	2022-08-09 15:21:14.170482
1d0eb26f-955c-4f84-a060-4f3a6f51c6c8	DA003	3	A	t	CV118	f	2022-08-09 15:21:14.175982	2022-08-09 15:21:14.175982
3aba0b32-61b3-4fad-9dbc-e49a6948421b	DA003	3	A	f	CV118	f	2022-08-09 15:21:14.205664	2022-08-09 15:21:14.205664
33e26e2b-8666-44b1-9412-4bb9b5cfa997	DA003	3	D	f	CV118	f	2022-08-09 15:21:14.211436	2022-08-09 15:21:14.211436
d77597bd-ac8c-4b84-8610-0f7ec3ae09eb	DA003	3	I	f	CV118	f	2022-08-09 15:21:14.216981	2022-08-09 15:21:14.216981
a1955ef2-6c65-4d3e-8494-5f0611aa5612	DA003	3	W	f	CV118	f	2022-08-09 15:21:14.222183	2022-08-09 15:21:14.222183
9da4a782-6895-48f9-9ac7-ce2487262f51	DA003	3	Z	f	CV118	f	2022-08-09 15:21:14.228248	2022-08-09 15:21:14.228248
009a8c1d-4a8c-4b3f-893b-10401595c3d9	DA003	3	A	t	FM054	f	2022-08-09 15:21:14.233681	2022-08-09 15:21:14.233681
91dea98a-d18f-464a-b047-7badf54336fd	DA003	3	D	t	FM054	f	2022-08-09 15:21:14.23898	2022-08-09 15:21:14.23898
816ac3c3-7490-46fa-a944-89d525a93224	DA003	3	I	t	FM054	f	2022-08-09 15:21:14.244547	2022-08-09 15:21:14.244547
592b9de6-2434-4e16-88cc-b8357164f7f1	DA003	3	W	t	FM054	f	2022-08-09 15:21:14.250091	2022-08-09 15:21:14.250091
ee768a12-5ead-455a-8985-6a00f85398be	DA003	3	Z	t	FM054	f	2022-08-09 15:21:14.25621	2022-08-09 15:21:14.25621
9fef69dd-7b8b-496e-9c7e-10cc8786b8cf	DA003	3	A	f	FM054	f	2022-08-09 15:21:14.261615	2022-08-09 15:21:14.261615
4189a980-f26b-4375-88b2-a65279827e87	DA003	3	D	f	FM054	f	2022-08-09 15:21:14.267383	2022-08-09 15:21:14.267383
29035c17-cf2a-49cb-b345-98bf45385c7f	DA003	3	I	f	FM054	f	2022-08-09 15:21:14.272883	2022-08-09 15:21:14.272883
a928f15f-5c64-478a-b483-d585b574fc43	DA003	3	W	f	FM054	f	2022-08-09 15:21:14.278506	2022-08-09 15:21:14.278506
99f4173d-3268-4a83-a65a-19a16eed9c06	DA003	3	Z	f	FM054	f	2022-08-09 15:21:14.284082	2022-08-09 15:21:14.284082
13590305-7b7c-4db2-b5df-4659de7eddae	DA003	3	A	f	AA019	t	2022-08-09 15:21:13.972901	2022-08-09 15:21:14.293229
7c49ab79-dbe3-4418-afba-7636adb880eb	DA003	3	D	f	AA019	t	2022-08-09 15:21:13.978756	2022-08-09 15:21:14.300822
13effca6-9b3f-4cb2-9c4c-8809435e342d	DA003	3	I	f	AA019	t	2022-08-09 15:21:13.984652	2022-08-09 15:21:14.308116
95329055-3394-4772-a918-0da6f700e8ad	DA003	3	W	f	AA019	t	2022-08-09 15:21:13.990588	2022-08-09 15:21:14.31553
f8984cc3-7221-46c8-bc54-5be5add5e9cb	DA003	3	Z	f	AA019	t	2022-08-09 15:21:13.996503	2022-08-09 15:21:14.322949
d974c0ee-d286-439a-bef5-453e9c3073ea	DA003	3	A	t	CV117	t	2022-08-09 15:21:14.1189	2022-08-09 15:21:14.33054
8db2038d-7eb5-4a21-98b4-118d62a06576	DA003	3	D	t	CV118	t	2022-08-09 15:21:14.182023	2022-08-09 15:21:14.338032
2ea02251-6ef9-442a-873c-83e545af2958	DA003	3	I	t	CV118	t	2022-08-09 15:21:14.188196	2022-08-09 15:21:14.345662
5d15946d-a169-4e62-8e04-506baf821a09	DA003	3	W	t	CV118	t	2022-08-09 15:21:14.193953	2022-08-09 15:21:14.354337
46cf5162-5558-43a6-bac0-9c6aaa7415c9	DA003	3	Z	t	CV118	t	2022-08-09 15:21:14.199984	2022-08-09 15:21:14.362588
33f62d4a-c677-40d5-bc9d-cd2c3ee241a9	DA004	3	A	t	AA009	f	2022-08-09 15:21:14.369429	2022-08-09 15:21:14.369429
09c27fd3-0683-4287-892b-2484d602ca9a	DA004	3	D	t	AA009	f	2022-08-09 15:21:14.375906	2022-08-09 15:21:14.375906
2130129a-f1b3-4fc8-b7fb-979eef264e3f	DA004	3	I	t	AA009	f	2022-08-09 15:21:14.382354	2022-08-09 15:21:14.382354
f7297d81-4f87-49b0-b2f4-df9d837b7877	DA004	3	W	t	AA009	f	2022-08-09 15:21:14.387855	2022-08-09 15:21:14.387855
324a6e42-39f5-4072-9701-4f8a87cc6caa	DA004	3	Z	t	AA009	f	2022-08-09 15:21:14.394419	2022-08-09 15:21:14.394419
6874b946-f5f9-4c2b-adcb-17facce346df	DA004	3	A	f	AA009	f	2022-08-09 15:21:14.400311	2022-08-09 15:21:14.400311
1839da4a-c644-4077-9173-e79c6d640614	DA004	3	D	f	AA009	f	2022-08-09 15:21:14.405948	2022-08-09 15:21:14.405948
21570b70-dda9-4bd0-9b9b-b438066a11c2	DA004	3	I	f	AA009	f	2022-08-09 15:21:14.412669	2022-08-09 15:21:14.412669
2d81e3c8-392c-4b40-a7e4-a7ffc0016eb0	DA004	3	W	f	AA009	f	2022-08-09 15:21:14.418403	2022-08-09 15:21:14.418403
27468dd3-03db-41cc-98bf-4f15ce45efaf	DA004	3	Z	f	AA009	f	2022-08-09 15:21:14.424218	2022-08-09 15:21:14.424218
fcd59b0f-f55a-46aa-8a14-3bd037dc79df	DA004	3	A	t	CV027	f	2022-08-09 15:21:14.463445	2022-08-09 15:21:14.463445
04fa29cf-3394-4888-9d78-a9be97e89c78	DA004	3	D	t	CV027	f	2022-08-09 15:21:14.468708	2022-08-09 15:21:14.468708
c71d6959-6f3e-4978-a452-a545071051a7	DA004	3	I	t	CV027	f	2022-08-09 15:21:14.474343	2022-08-09 15:21:14.474343
bed791de-f825-4f5b-ab79-449114fe13d5	DA004	3	W	t	CV027	f	2022-08-09 15:21:14.479695	2022-08-09 15:21:14.479695
9ce4da81-4133-4b2d-bcdb-0b1a5caf19e2	DA004	3	Z	t	CV027	f	2022-08-09 15:21:14.485224	2022-08-09 15:21:14.485224
e2fc7ecf-4f4e-4178-b055-6153c50c34e2	DA004	3	A	f	CV027	f	2022-08-09 15:21:14.490627	2022-08-09 15:21:14.490627
c7a7823e-0829-47ec-bb5e-b96748db2364	DA004	3	D	f	CV027	f	2022-08-09 15:21:14.495911	2022-08-09 15:21:14.495911
44b854bf-3340-4bfb-a1c0-2e0d384cd6c1	DA004	3	I	f	CV027	f	2022-08-09 15:21:14.501805	2022-08-09 15:21:14.501805
acb949f1-6f79-480a-b6c7-c94ff091723e	DA004	3	W	f	CV027	f	2022-08-09 15:21:14.507459	2022-08-09 15:21:14.507459
a2d9718d-4bbc-4338-8194-6be4c34cc2b0	DA004	3	Z	f	CV027	f	2022-08-09 15:21:14.513529	2022-08-09 15:21:14.513529
ea10991d-cc0a-4239-ab73-0726f92f3add	DA004	3	A	t	CV079	f	2022-08-09 15:21:14.519173	2022-08-09 15:21:14.519173
043478ff-49b9-4882-9a2b-5ec60f3ef45e	DA004	3	D	t	CV079	f	2022-08-09 15:21:14.524948	2022-08-09 15:21:14.524948
978b23fd-b9c9-470d-aeb3-03af06cef9f2	DA004	3	I	t	CV079	f	2022-08-09 15:21:14.530924	2022-08-09 15:21:14.530924
b8cb12de-d32c-4774-8ec9-dbec7d309f5a	DA004	3	W	t	CV079	f	2022-08-09 15:21:14.536461	2022-08-09 15:21:14.536461
b097f081-ee7e-4d4e-849f-64cf48f045af	DA004	3	Z	t	CV079	f	2022-08-09 15:21:14.54185	2022-08-09 15:21:14.54185
f976175b-6d59-4979-a570-574a50e97df2	DA004	3	A	f	CV079	f	2022-08-09 15:21:14.547755	2022-08-09 15:21:14.547755
d07052cd-1368-410a-877a-e774d6a5a724	DA004	3	D	f	CV079	f	2022-08-09 15:21:14.553768	2022-08-09 15:21:14.553768
c0fb1536-7dd4-4ef2-99dd-962ccb0cc79e	DA004	3	I	f	CV079	f	2022-08-09 15:21:14.559482	2022-08-09 15:21:14.559482
a187ab7f-726b-46f0-9e48-e3b7927a6ba6	DA004	3	W	f	CV079	f	2022-08-09 15:21:14.565258	2022-08-09 15:21:14.565258
07b8def0-71ac-402c-9b43-2bbb4cf5aefa	DA004	3	Z	f	CV079	f	2022-08-09 15:21:14.570659	2022-08-09 15:21:14.570659
e805adb9-b677-4e51-8dff-9a72b0af2100	DA004	3	D	t	CV117	f	2022-08-09 15:21:14.584327	2022-08-09 15:21:14.584327
b1892217-8749-4775-b6e5-7e34ee94bb74	DA004	3	I	t	CV117	f	2022-08-09 15:21:14.590568	2022-08-09 15:21:14.590568
fd8097ea-82ae-4cef-bf99-a818d6fbed21	DA004	3	W	t	CV117	f	2022-08-09 15:21:14.596151	2022-08-09 15:21:14.596151
4efae508-2c1b-48b5-8581-aa3028bda522	DA004	3	Z	t	CV117	f	2022-08-09 15:21:14.602124	2022-08-09 15:21:14.602124
be917538-bc8d-42c8-ab1f-8859d17e5f3f	DA004	3	A	f	CV117	f	2022-08-09 15:21:14.60805	2022-08-09 15:21:14.60805
4a0e118c-5613-4299-9ea9-8ea48223f62d	DA004	3	D	f	CV117	f	2022-08-09 15:21:14.613783	2022-08-09 15:21:14.613783
54d3535a-ffd1-4099-8c04-3acbb70f9b85	DA004	3	I	f	CV117	f	2022-08-09 15:21:14.619905	2022-08-09 15:21:14.619905
7a4c1625-ddc9-4b85-a99d-198b80e0b7ad	DA004	3	W	f	CV117	f	2022-08-09 15:21:14.625302	2022-08-09 15:21:14.625302
0f921188-8b78-4fa1-b512-8a2001279379	DA004	3	Z	f	CV117	f	2022-08-09 15:21:14.632412	2022-08-09 15:21:14.632412
608d9e9d-0a45-4913-ace7-15877d2ef299	DA004	3	A	t	CV118	f	2022-08-09 15:21:14.637976	2022-08-09 15:21:14.637976
48b8aa2a-6369-4fe3-a7c1-9e6eaedcc06f	DA004	3	A	f	CV118	f	2022-08-09 15:21:14.667995	2022-08-09 15:21:14.667995
c47723d1-3f57-482b-934f-542408171cd1	DA004	3	D	f	CV118	f	2022-08-09 15:21:14.67373	2022-08-09 15:21:14.67373
2aa2a3f5-3927-4315-9a05-a2bb09a99f20	DA004	3	I	f	CV118	f	2022-08-09 15:21:14.679105	2022-08-09 15:21:14.679105
1f0ced72-28ef-41dc-9e3e-3f28f7232f83	DA004	3	W	f	CV118	f	2022-08-09 15:21:14.684755	2022-08-09 15:21:14.684755
87d766a3-1770-4d16-97e3-d347a6ed7728	DA004	3	Z	f	CV118	f	2022-08-09 15:21:14.690166	2022-08-09 15:21:14.690166
46ddb8c5-e1b6-489d-97ce-f9af67652397	DA004	3	A	t	FM054	f	2022-08-09 15:21:14.695908	2022-08-09 15:21:14.695908
1049262c-9003-4152-8864-18cf04189c09	DA004	3	D	t	FM054	f	2022-08-09 15:21:14.701273	2022-08-09 15:21:14.701273
7fa489d7-317c-4cfe-bcbc-9d57ff6b9c17	DA004	3	I	t	FM054	f	2022-08-09 15:21:14.707231	2022-08-09 15:21:14.707231
1a106772-38ef-478e-b270-f80548e4c516	DA004	3	W	t	FM054	f	2022-08-09 15:21:14.712688	2022-08-09 15:21:14.712688
da6d1f65-3ca5-41ee-a4a7-2314f5aadb0f	DA004	3	Z	t	FM054	f	2022-08-09 15:21:14.71827	2022-08-09 15:21:14.71827
83f71a8e-32f7-4fa8-81ad-6f418c999e86	DA004	3	A	f	FM054	f	2022-08-09 15:21:14.723719	2022-08-09 15:21:14.723719
736f42ce-f58e-4937-af5c-04a0bd8d66c9	DA004	3	D	f	FM054	f	2022-08-09 15:21:14.729339	2022-08-09 15:21:14.729339
aefe5f59-fe53-423b-8292-134d01a6f5f7	DA004	3	I	f	FM054	f	2022-08-09 15:21:14.735145	2022-08-09 15:21:14.735145
a0ca705c-07fd-465e-b58f-bb87c2095aa7	DA004	3	W	f	FM054	f	2022-08-09 15:21:14.740454	2022-08-09 15:21:14.740454
615cf8c3-9206-4947-ba58-2a3d82b10765	DA004	3	Z	f	FM054	f	2022-08-09 15:21:14.746042	2022-08-09 15:21:14.746042
79724aab-f640-4f59-b43a-743dadd5ef13	DA004	3	A	f	AA019	t	2022-08-09 15:21:14.435049	2022-08-09 15:21:14.753366
f2441e5d-1424-41f5-8e75-0de72000a394	DA004	3	D	f	AA019	t	2022-08-09 15:21:14.441187	2022-08-09 15:21:14.760703
9037a9a4-e324-490c-aa04-251e63340954	DA004	3	I	f	AA019	t	2022-08-09 15:21:14.446811	2022-08-09 15:21:14.768136
6befc982-9d66-4a94-a4e3-f970a09513bf	DA004	3	W	f	AA019	t	2022-08-09 15:21:14.452328	2022-08-09 15:21:14.77548
527e3b2f-6798-45ac-a5e3-73957e960e0c	DA004	3	Z	f	AA019	t	2022-08-09 15:21:14.458083	2022-08-09 15:21:14.782532
035f01a4-0528-4493-a8c1-c66a01b40c4c	DA004	3	A	t	CV117	t	2022-08-09 15:21:14.576525	2022-08-09 15:21:14.790046
a1c56a85-ee1d-4d58-838a-b53c837272ab	DA004	3	D	t	CV118	t	2022-08-09 15:21:14.644747	2022-08-09 15:21:14.797464
fba0cb95-2fe0-44f1-8737-dcc7a68f2ac0	DA004	3	I	t	CV118	t	2022-08-09 15:21:14.650978	2022-08-09 15:21:14.804696
9ab858e3-c2d2-4a78-8d54-07423685c4bb	DA004	3	W	t	CV118	t	2022-08-09 15:21:14.656736	2022-08-09 15:21:14.811996
079f591b-be12-4397-ad52-d583234bd696	DA004	3	Z	t	CV118	t	2022-08-09 15:21:14.662522	2022-08-09 15:21:14.819273
109ac373-c542-4d7c-87ba-197049dd9749	DA005	3	A	t	AA009	f	2022-08-09 15:21:14.825883	2022-08-09 15:21:14.825883
8be03202-a086-4cfc-9ef6-90b82932a14a	DA005	3	D	t	AA009	f	2022-08-09 15:21:14.832778	2022-08-09 15:21:14.832778
a9692de1-d5b9-452b-b90a-5781b7edbe4c	DA005	3	I	t	AA009	f	2022-08-09 15:21:14.838333	2022-08-09 15:21:14.838333
540c1022-0c3a-43d8-8ebb-b80a49587849	DA005	3	W	t	AA009	f	2022-08-09 15:21:14.844293	2022-08-09 15:21:14.844293
1460ef28-8769-4513-9178-84cb6157b7ef	DA005	3	Z	t	AA009	f	2022-08-09 15:21:14.850009	2022-08-09 15:21:14.850009
3ea1af30-6ef0-47ef-9086-316d85756147	DA005	3	A	f	AA009	f	2022-08-09 15:21:14.855565	2022-08-09 15:21:14.855565
3114560e-fc30-4e0a-9f6f-674048a3aa2f	DA005	3	D	f	AA009	f	2022-08-09 15:21:14.861532	2022-08-09 15:21:14.861532
d8bb1817-b1c6-46fd-991a-aeefdab3f6bf	DA005	3	I	f	AA009	f	2022-08-09 15:21:14.867121	2022-08-09 15:21:14.867121
f9e967c2-17ef-4019-a62c-602391fd7da5	DA005	3	W	f	AA009	f	2022-08-09 15:21:14.872441	2022-08-09 15:21:14.872441
d2b63fee-6cbe-4915-902b-d39b7bef275c	DA005	3	Z	f	AA009	f	2022-08-09 15:21:14.878742	2022-08-09 15:21:14.878742
a1c5589d-55b2-4cbf-8dce-f924c0e4705f	DA005	3	A	t	CV027	f	2022-08-09 15:21:14.91723	2022-08-09 15:21:14.91723
cec07468-c87c-4ac1-a986-375af3b91db9	DA005	3	D	t	CV027	f	2022-08-09 15:21:14.922809	2022-08-09 15:21:14.922809
1bd9d480-4105-4f10-b4aa-ca7fe225f031	DA005	3	I	t	CV027	f	2022-08-09 15:21:14.928232	2022-08-09 15:21:14.928232
1f172b36-2e90-4daf-9ec0-15c230e52bd5	DA005	3	W	t	CV027	f	2022-08-09 15:21:14.933898	2022-08-09 15:21:14.933898
2c1fcd1b-e784-45e8-b185-426abc67afc9	DA005	3	Z	t	CV027	f	2022-08-09 15:21:14.939331	2022-08-09 15:21:14.939331
678905c4-b75b-4b7d-93c8-80ef86dba6a4	DA005	3	A	f	CV027	f	2022-08-09 15:21:14.945282	2022-08-09 15:21:14.945282
d4c04b87-0056-4311-901b-b0e9d46bfcca	DA005	3	D	f	CV027	f	2022-08-09 15:21:14.951098	2022-08-09 15:21:14.951098
34d75da3-f26b-41fc-9554-c4f348ab6424	DA005	3	I	f	CV027	f	2022-08-09 15:21:14.956435	2022-08-09 15:21:14.956435
b19d11b7-890e-4825-a390-98bd5222c07d	DA005	3	W	f	CV027	f	2022-08-09 15:21:14.96321	2022-08-09 15:21:14.96321
ace6ef09-7759-4d3b-a7a8-784492d918da	DA005	3	Z	f	CV027	f	2022-08-09 15:21:14.969201	2022-08-09 15:21:14.969201
23f9d7c4-dd43-4cc8-8bca-18ed19ad3725	DA005	3	A	t	CV079	f	2022-08-09 15:21:14.974731	2022-08-09 15:21:14.974731
aed13f2d-63c6-40b2-8a39-2063715f0d28	DA005	3	D	t	CV079	f	2022-08-09 15:21:14.980635	2022-08-09 15:21:14.980635
19cdccf2-1b44-4076-95c2-f01d60817a04	DA005	3	I	t	CV079	f	2022-08-09 15:21:14.98608	2022-08-09 15:21:14.98608
54da6917-83dc-4f59-bc8f-277f8b983022	DA005	3	W	t	CV079	f	2022-08-09 15:21:14.992328	2022-08-09 15:21:14.992328
06972a5a-90d5-49b0-ae41-9e180f975502	DA005	3	Z	t	CV079	f	2022-08-09 15:21:14.997838	2022-08-09 15:21:14.997838
3f3341e3-78ed-45a0-95ea-b27f906bbbdd	DA005	3	A	f	CV079	f	2022-08-09 15:21:15.003584	2022-08-09 15:21:15.003584
83400652-4122-4ad1-918a-591f3a754100	DA005	3	D	f	CV079	f	2022-08-09 15:21:15.009649	2022-08-09 15:21:15.009649
abfba355-4091-4d21-bdd8-d42d2578c03e	DA005	3	I	f	CV079	f	2022-08-09 15:21:15.01512	2022-08-09 15:21:15.01512
7029b2e3-4261-4c74-ab1e-656f82b698ba	DA005	3	W	f	CV079	f	2022-08-09 15:21:15.020804	2022-08-09 15:21:15.020804
24785c7e-53bf-4f49-8a5f-500b709232fc	DA005	3	Z	f	CV079	f	2022-08-09 15:21:15.026378	2022-08-09 15:21:15.026378
4c50cec3-b720-4b3e-9ba2-54302724bd7a	DA005	3	D	t	CV117	f	2022-08-09 15:21:15.038131	2022-08-09 15:21:15.038131
dd6e0f31-5052-49ae-922e-ae5192d00059	DA005	3	I	t	CV117	f	2022-08-09 15:21:15.043472	2022-08-09 15:21:15.043472
e68f45bd-c451-45b2-a87b-abb81ddd29bd	DA005	3	W	t	CV117	f	2022-08-09 15:21:15.049277	2022-08-09 15:21:15.049277
aa79948f-6224-49aa-af51-82b176237abb	DA005	3	Z	t	CV117	f	2022-08-09 15:21:15.054893	2022-08-09 15:21:15.054893
9aec3373-2efc-4549-af9e-a1d34881f6c8	DA005	3	A	f	CV117	f	2022-08-09 15:21:15.060742	2022-08-09 15:21:15.060742
4c0cafdb-284a-4604-adee-c05c2b9d4b89	DA005	3	D	f	CV117	f	2022-08-09 15:21:15.066238	2022-08-09 15:21:15.066238
82da5b75-2d16-47c0-976f-f6899fc0fe13	DA005	3	I	f	CV117	f	2022-08-09 15:21:15.071912	2022-08-09 15:21:15.071912
1c5fd634-9a8b-4b7e-8a5d-b7df2a923145	DA005	3	W	f	CV117	f	2022-08-09 15:21:15.078182	2022-08-09 15:21:15.078182
ff5e608e-0039-4f5d-9373-7ed58921aaa8	DA005	3	Z	f	CV117	f	2022-08-09 15:21:15.083748	2022-08-09 15:21:15.083748
2a647dc0-0c8d-442f-813a-fea5f9c3b11e	DA005	3	A	t	CV118	f	2022-08-09 15:21:15.089181	2022-08-09 15:21:15.089181
53118812-2a3b-4545-9104-56d192ff518b	DA005	3	A	f	CV118	f	2022-08-09 15:21:15.119249	2022-08-09 15:21:15.119249
5fdc00c1-0e88-45ec-b4e7-1d55e43056f4	DA005	3	D	f	CV118	f	2022-08-09 15:21:15.126355	2022-08-09 15:21:15.126355
add4b6df-32ab-4276-a41a-321628e0d4a3	DA005	3	I	f	CV118	f	2022-08-09 15:21:15.133464	2022-08-09 15:21:15.133464
becf4036-0685-426b-908a-943996c24b6d	DA005	3	W	f	CV118	f	2022-08-09 15:21:15.140443	2022-08-09 15:21:15.140443
559fc690-0bc9-461b-a6de-e77f0ec7bdf7	DA005	3	Z	f	CV118	f	2022-08-09 15:21:15.146985	2022-08-09 15:21:15.146985
c19cfd00-9d5e-4464-a16d-e8eed7a32fc4	DA005	3	A	t	FM054	f	2022-08-09 15:21:15.152563	2022-08-09 15:21:15.152563
43ddab74-8a39-4601-9951-88593f20ce33	DA005	3	D	t	FM054	f	2022-08-09 15:21:15.158399	2022-08-09 15:21:15.158399
4a5a04e3-8e25-4337-9c0d-657ada1e5d82	DA005	3	I	t	FM054	f	2022-08-09 15:21:15.163719	2022-08-09 15:21:15.163719
697bcf50-6a2d-49a2-ab49-b57096a4f4d5	DA005	3	W	t	FM054	f	2022-08-09 15:21:15.169479	2022-08-09 15:21:15.169479
42767269-7cfe-403b-b081-f2cf71c36a65	DA005	3	Z	t	FM054	f	2022-08-09 15:21:15.174998	2022-08-09 15:21:15.174998
40929da7-e02b-4ec8-9b12-a5e334c065cc	DA005	3	A	f	FM054	f	2022-08-09 15:21:15.180383	2022-08-09 15:21:15.180383
2fb454f2-9658-499e-a75e-11cafd4d0c85	DA005	3	D	f	FM054	f	2022-08-09 15:21:15.186139	2022-08-09 15:21:15.186139
cda9512e-eaac-46a5-96ca-a1f18c63583f	DA005	3	I	f	FM054	f	2022-08-09 15:21:15.191681	2022-08-09 15:21:15.191681
8e74b848-d848-487f-83a9-093c8b782343	DA005	3	W	f	FM054	f	2022-08-09 15:21:15.197699	2022-08-09 15:21:15.197699
0226d873-3600-4afe-8e25-fe3ed78afd43	DA005	3	Z	f	FM054	f	2022-08-09 15:21:15.20341	2022-08-09 15:21:15.20341
9f2c2724-c914-40e4-a882-34d66c02fde2	DA005	3	A	f	AA019	t	2022-08-09 15:21:14.889232	2022-08-09 15:21:15.210422
4b7fd1fe-f6bc-40b4-979e-17b467700e2b	DA005	3	D	f	AA019	t	2022-08-09 15:21:14.895187	2022-08-09 15:21:15.21782
995244a6-5ab6-480f-8f6e-bbc0b6dd3314	DA005	3	I	f	AA019	t	2022-08-09 15:21:14.900582	2022-08-09 15:21:15.225231
e97c13d0-09ba-4776-a6cf-85f16e5772a8	DA005	3	W	f	AA019	t	2022-08-09 15:21:14.906111	2022-08-09 15:21:15.232829
138dfd29-4a0f-4b2b-a70d-f11fbf32de4a	DA005	3	Z	f	AA019	t	2022-08-09 15:21:14.911806	2022-08-09 15:21:15.240145
cd06e199-e4e7-4239-9f7c-3cbf39355d9d	DA005	3	A	t	CV117	t	2022-08-09 15:21:15.03239	2022-08-09 15:21:15.247442
95d546b8-d658-4173-8695-f9f30409193e	DA005	3	D	t	CV118	t	2022-08-09 15:21:15.095673	2022-08-09 15:21:15.254843
0bbf28ed-e189-4ddb-b82c-f12613f16329	DA005	3	I	t	CV118	t	2022-08-09 15:21:15.101477	2022-08-09 15:21:15.26235
890db2f8-5eff-40f6-aa61-61b3870db047	DA005	3	W	t	CV118	t	2022-08-09 15:21:15.107423	2022-08-09 15:21:15.269817
f137b9d9-09d0-4dd3-b72e-70f1ec7028d8	DA005	3	Z	t	CV118	t	2022-08-09 15:21:15.112819	2022-08-09 15:21:15.277044
b00fbdc7-8653-494e-af0f-6a4ef8f777a1	DA006	3	A	t	AA009	f	2022-08-09 15:21:15.282412	2022-08-09 15:21:15.282412
4dbce8c1-7b20-4cb4-a079-cd096706d0a2	DA006	3	D	t	AA009	f	2022-08-09 15:21:15.288265	2022-08-09 15:21:15.288265
3db62cf8-3f87-4b6e-96b2-a44de7e4349a	DA006	3	I	t	AA009	f	2022-08-09 15:21:15.296815	2022-08-09 15:21:15.296815
2c44024a-5dd9-4ba0-8831-16081c8460af	DA006	3	W	t	AA009	f	2022-08-09 15:21:15.302848	2022-08-09 15:21:15.302848
bde18926-ae43-4138-802e-7270e006b39e	DA006	3	Z	t	AA009	f	2022-08-09 15:21:15.309029	2022-08-09 15:21:15.309029
9e22ce86-c028-4968-83ed-2f8ebd2fc6fd	DA006	3	A	f	AA009	f	2022-08-09 15:21:15.314853	2022-08-09 15:21:15.314853
d7ee84ce-f083-45d3-892f-6e5da829f07a	DA006	3	D	f	AA009	f	2022-08-09 15:21:15.320312	2022-08-09 15:21:15.320312
b5de77b9-97e5-4d33-ac52-c65bf5cf071a	DA006	3	I	f	AA009	f	2022-08-09 15:21:15.326336	2022-08-09 15:21:15.326336
4d6de76b-f757-4e40-98e7-2e21aae39d9d	DA006	3	W	f	AA009	f	2022-08-09 15:21:15.3328	2022-08-09 15:21:15.3328
afe058d8-7d8e-4305-a2e7-a4b284de9ab5	DA006	3	Z	f	AA009	f	2022-08-09 15:21:15.338545	2022-08-09 15:21:15.338545
c81d34b5-3604-4099-b973-126d4205ee7e	DA006	3	A	t	CV027	f	2022-08-09 15:21:15.381777	2022-08-09 15:21:15.381777
7e2df740-5e23-4bd2-a95b-a69fdaff64fe	DA006	3	D	t	CV027	f	2022-08-09 15:21:15.387336	2022-08-09 15:21:15.387336
11634d4d-2430-4b8e-83ef-d70441d95d76	DA006	3	I	t	CV027	f	2022-08-09 15:21:15.393582	2022-08-09 15:21:15.393582
a95f8dc2-a788-4328-be55-84a63de8e74a	DA006	3	W	t	CV027	f	2022-08-09 15:21:15.399318	2022-08-09 15:21:15.399318
d9ec8254-8958-45ad-a297-18bfcfce8fcf	DA006	3	Z	t	CV027	f	2022-08-09 15:21:15.405077	2022-08-09 15:21:15.405077
702497e4-8ae0-4b52-b059-0ad2c834420c	DA006	3	A	f	CV027	f	2022-08-09 15:21:15.410774	2022-08-09 15:21:15.410774
276696a5-6cf3-463c-b15b-afa739c71ebd	DA006	3	D	f	CV027	f	2022-08-09 15:21:15.416499	2022-08-09 15:21:15.416499
35601596-ef8f-4cc8-a0eb-6924a7fe2e22	DA006	3	I	f	CV027	f	2022-08-09 15:21:15.422208	2022-08-09 15:21:15.422208
11fac78e-ef74-4bf9-a77a-646dbfc99340	DA006	3	W	f	CV027	f	2022-08-09 15:21:15.427916	2022-08-09 15:21:15.427916
b5aa7784-4191-46d5-8b30-989e193bb308	DA006	3	Z	f	CV027	f	2022-08-09 15:21:15.433777	2022-08-09 15:21:15.433777
a4d1954a-34c8-49ad-a759-70f50bfa6fd1	DA006	3	A	t	CV079	f	2022-08-09 15:21:15.439483	2022-08-09 15:21:15.439483
37a57456-1b9f-4d80-a388-47a35725bde4	DA006	3	D	t	CV079	f	2022-08-09 15:21:15.444752	2022-08-09 15:21:15.444752
bff76010-ecab-4d34-9808-89465169d8a2	DA006	3	I	t	CV079	f	2022-08-09 15:21:15.450709	2022-08-09 15:21:15.450709
0333d64a-9b75-42ca-a435-840e2e8d5e48	DA006	3	W	t	CV079	f	2022-08-09 15:21:15.456387	2022-08-09 15:21:15.456387
ead5966d-4eef-4cba-9549-99afd5e81a29	DA006	3	Z	t	CV079	f	2022-08-09 15:21:15.46233	2022-08-09 15:21:15.46233
6cea5750-9664-4d7f-9864-eb367c2ad6d6	DA006	3	A	f	CV079	f	2022-08-09 15:21:15.468022	2022-08-09 15:21:15.468022
7dbd60f7-3fd9-4efd-b62e-83bd20a20d3e	DA006	3	D	f	CV079	f	2022-08-09 15:21:15.473555	2022-08-09 15:21:15.473555
cb7e040c-95ff-4fcd-8b8c-480e46c5928a	DA006	3	I	f	CV079	f	2022-08-09 15:21:15.479258	2022-08-09 15:21:15.479258
da31de62-89e6-4562-b11e-6538c64a7532	DA006	3	W	f	CV079	f	2022-08-09 15:21:15.484792	2022-08-09 15:21:15.484792
eb524068-fa7c-4b86-9a2b-fd9c8637703f	DA006	3	Z	f	CV079	f	2022-08-09 15:21:15.490482	2022-08-09 15:21:15.490482
411ccc39-ce14-4587-bfc7-c06452f93378	DA006	3	D	t	CV117	f	2022-08-09 15:21:15.501363	2022-08-09 15:21:15.501363
d852c93d-2e8c-4242-b9dc-b2f83eb969ad	DA006	3	I	t	CV117	f	2022-08-09 15:21:15.507195	2022-08-09 15:21:15.507195
b997e785-9bf7-41c3-b30b-81a2eec53c7d	DA006	3	W	t	CV117	f	2022-08-09 15:21:15.512654	2022-08-09 15:21:15.512654
5d672a36-d1db-4c43-b833-3d885f948dfb	DA006	3	Z	t	CV117	f	2022-08-09 15:21:15.518252	2022-08-09 15:21:15.518252
2eb7f06f-80e5-4c1b-97e8-ea95674dffea	DA006	3	A	f	CV117	f	2022-08-09 15:21:15.523964	2022-08-09 15:21:15.523964
5dacf713-ac03-4d75-9316-dfbd8f75d34f	DA006	3	D	f	CV117	f	2022-08-09 15:21:15.529392	2022-08-09 15:21:15.529392
d939ecd2-5a2e-491f-a548-6aa5e78e171d	DA006	3	I	f	CV117	f	2022-08-09 15:21:15.534999	2022-08-09 15:21:15.534999
f13cc45c-48fa-4237-805c-3987023cb9f8	DA006	3	W	f	CV117	f	2022-08-09 15:21:15.541412	2022-08-09 15:21:15.541412
25a7d8b3-4ede-4865-a0a9-62651aeb2cb4	DA006	3	Z	f	CV117	f	2022-08-09 15:21:15.547318	2022-08-09 15:21:15.547318
c73fa0b6-7e05-4d02-9bbb-40b4bd3c6382	DA006	3	A	t	CV118	f	2022-08-09 15:21:15.552873	2022-08-09 15:21:15.552873
3dacdac7-3ffd-4e38-b69d-49c1cbfe1063	DA006	3	A	f	CV118	f	2022-08-09 15:21:15.582807	2022-08-09 15:21:15.582807
b85f7e20-6574-4eb3-9866-2f132c9fe965	DA006	3	D	f	CV118	f	2022-08-09 15:21:15.588744	2022-08-09 15:21:15.588744
496139e3-5616-4238-8777-4009de6ba6b8	DA006	3	I	f	CV118	f	2022-08-09 15:21:15.594316	2022-08-09 15:21:15.594316
af5b174e-1f29-4c12-a252-f98ad1e8eea2	DA006	3	W	f	CV118	f	2022-08-09 15:21:15.600158	2022-08-09 15:21:15.600158
0905b90e-1da6-4403-b61c-c505128c0067	DA006	3	Z	f	CV118	f	2022-08-09 15:21:15.605695	2022-08-09 15:21:15.605695
03409040-95ce-4d1b-8ba5-d41db4a3ba81	DA006	3	A	t	FM054	f	2022-08-09 15:21:15.611596	2022-08-09 15:21:15.611596
541b3e4d-5e0e-42b5-b7e4-b893e2a6275b	DA006	3	D	t	FM054	f	2022-08-09 15:21:15.617047	2022-08-09 15:21:15.617047
31e8b06c-3906-4b85-9b9b-43d559829a05	DA006	3	I	t	FM054	f	2022-08-09 15:21:15.623019	2022-08-09 15:21:15.623019
956a1218-0946-44a5-8014-98a11b7930ea	DA006	3	W	t	FM054	f	2022-08-09 15:21:15.628517	2022-08-09 15:21:15.628517
ab14eac5-55d4-4627-8967-d5da0d09ed2a	DA006	3	Z	t	FM054	f	2022-08-09 15:21:15.635725	2022-08-09 15:21:15.635725
f36b001c-8402-4b2b-8100-63b13008514b	DA006	3	A	f	FM054	f	2022-08-09 15:21:15.641317	2022-08-09 15:21:15.641317
0e8e8d75-1859-4d1a-aa06-27d5d0826b82	DA006	3	D	f	FM054	f	2022-08-09 15:21:15.647307	2022-08-09 15:21:15.647307
44d8164f-914a-4360-a273-baf9d71adcd7	DA006	3	I	f	FM054	f	2022-08-09 15:21:15.652747	2022-08-09 15:21:15.652747
81f260ef-ab29-4bc2-bfcd-55687323a18d	DA006	3	W	f	FM054	f	2022-08-09 15:21:15.658617	2022-08-09 15:21:15.658617
0352998d-43f2-4c8e-a3a8-c25422165f89	DA006	3	Z	f	FM054	f	2022-08-09 15:21:15.664076	2022-08-09 15:21:15.664076
b84eec83-996d-4546-8cbf-4e75ae2dcd87	DA006	3	A	f	AA019	t	2022-08-09 15:21:15.349935	2022-08-09 15:21:15.672043
6b34b1f9-2794-4176-b5cb-01d9b16ae6df	DA006	3	D	f	AA019	t	2022-08-09 15:21:15.356264	2022-08-09 15:21:15.679987
b2cd3400-565e-4058-a145-657c3e5afa14	DA006	3	I	f	AA019	t	2022-08-09 15:21:15.363209	2022-08-09 15:21:15.687445
d614d696-5958-4910-bc59-1b4e9dcce318	DA006	3	W	f	AA019	t	2022-08-09 15:21:15.369448	2022-08-09 15:21:15.694874
e0aa9fa6-dbba-418e-94dd-1fb9ec63ddc6	DA006	3	Z	f	AA019	t	2022-08-09 15:21:15.375574	2022-08-09 15:21:15.702259
cd32be2b-7305-410a-b5ae-82226573b701	DA006	3	A	t	CV117	t	2022-08-09 15:21:15.495912	2022-08-09 15:21:15.710469
bb443343-5b93-4eb9-9e0b-eefa0271a7fc	DA006	3	D	t	CV118	t	2022-08-09 15:21:15.558099	2022-08-09 15:21:15.718369
1fa210a6-e620-42ba-bc4d-076329bdc6be	DA006	3	I	t	CV118	t	2022-08-09 15:21:15.563614	2022-08-09 15:21:15.725699
f88678c5-19d2-48e1-ad10-8a9656ecefba	DA006	3	W	t	CV118	t	2022-08-09 15:21:15.569555	2022-08-09 15:21:15.732726
87c25e04-5d9d-4bb6-ab1f-7ae508f62455	DA006	3	Z	t	CV118	t	2022-08-09 15:21:15.575216	2022-08-09 15:21:15.740165
313b091e-8904-4a70-92c2-718e3ef32e44	DA007	3	A	t	AA009	f	2022-08-09 15:21:15.745737	2022-08-09 15:21:15.745737
a05b59e8-7ebe-4744-b970-7a646f87add7	DA007	3	D	t	AA009	f	2022-08-09 15:21:15.751618	2022-08-09 15:21:15.751618
d8d82872-c837-4d00-8cd2-d862d467919c	DA007	3	I	t	AA009	f	2022-08-09 15:21:15.757087	2022-08-09 15:21:15.757087
0baeda1c-c837-4cdc-90cc-cd233fd3c5c7	DA007	3	W	t	AA009	f	2022-08-09 15:21:15.762954	2022-08-09 15:21:15.762954
9bd7fef8-a185-4c8a-9d44-609f68a42832	DA007	3	Z	t	AA009	f	2022-08-09 15:21:15.768268	2022-08-09 15:21:15.768268
176a79c1-66d5-4b26-bb0b-5d4e360393ff	DA007	3	A	f	AA009	f	2022-08-09 15:21:15.773482	2022-08-09 15:21:15.773482
76e88791-3533-45fe-b1ba-203871c0bfc7	DA007	3	D	f	AA009	f	2022-08-09 15:21:15.779448	2022-08-09 15:21:15.779448
f7953886-a86d-44d5-9b2d-fd715f67243b	DA007	3	I	f	AA009	f	2022-08-09 15:21:15.785717	2022-08-09 15:21:15.785717
ef8c3dbb-2fb0-4280-a49b-99828b8b9e61	DA007	3	W	f	AA009	f	2022-08-09 15:21:15.791499	2022-08-09 15:21:15.791499
ae97033e-e2e3-4026-a859-7cf12297bd87	DA007	3	Z	f	AA009	f	2022-08-09 15:21:15.796953	2022-08-09 15:21:15.796953
39c70597-d83e-4ccb-a197-04d137562dac	DA007	3	A	t	CV027	f	2022-08-09 15:21:15.834342	2022-08-09 15:21:15.834342
d186663e-356e-4877-9763-a32a03a4c224	DA007	3	D	t	CV027	f	2022-08-09 15:21:15.839979	2022-08-09 15:21:15.839979
dbbf0ffc-62f9-4b94-b065-c277138931a0	DA007	3	I	t	CV027	f	2022-08-09 15:21:15.845309	2022-08-09 15:21:15.845309
b01d5321-13a5-4031-beef-3ce10d5ffd3a	DA007	3	W	t	CV027	f	2022-08-09 15:21:15.851065	2022-08-09 15:21:15.851065
48134877-0ee7-44f4-94af-15be554dae65	DA007	3	Z	t	CV027	f	2022-08-09 15:21:15.856836	2022-08-09 15:21:15.856836
973cbbd5-a756-4c74-bc19-44cd230d3032	DA007	3	A	f	CV027	f	2022-08-09 15:21:15.862506	2022-08-09 15:21:15.862506
d3786f52-e95d-4aa8-a564-19cfa6468eb6	DA007	3	D	f	CV027	f	2022-08-09 15:21:15.868252	2022-08-09 15:21:15.868252
367799a5-8120-4793-ae34-986070f9b8f3	DA007	3	I	f	CV027	f	2022-08-09 15:21:15.873694	2022-08-09 15:21:15.873694
2328143d-3521-4fb5-8d58-6af3893519e9	DA007	3	W	f	CV027	f	2022-08-09 15:21:15.879073	2022-08-09 15:21:15.879073
b93ec8f8-544d-49d4-a125-b7d6003a26ed	DA007	3	Z	f	CV027	f	2022-08-09 15:21:15.88488	2022-08-09 15:21:15.88488
1f210013-788c-4ea8-a5f7-75fee803ee5b	DA007	3	A	t	CV079	f	2022-08-09 15:21:15.89024	2022-08-09 15:21:15.89024
b342924f-a610-44c9-8ff4-3c7071d44fa0	DA007	3	D	t	CV079	f	2022-08-09 15:21:15.895735	2022-08-09 15:21:15.895735
41b8dfca-8ae3-4960-823b-fb0453a75ef5	DA007	3	I	t	CV079	f	2022-08-09 15:21:15.901938	2022-08-09 15:21:15.901938
82c3d42f-769f-42f0-853f-633f157c36c4	DA007	3	W	t	CV079	f	2022-08-09 15:21:15.907298	2022-08-09 15:21:15.907298
8551cd2c-1242-48be-a77c-bc48fe2d3d1a	DA007	3	Z	t	CV079	f	2022-08-09 15:21:15.913079	2022-08-09 15:21:15.913079
9083035b-ec74-4013-8fee-7f5131c17673	DA007	3	A	f	CV079	f	2022-08-09 15:21:15.918532	2022-08-09 15:21:15.918532
36fea931-6b74-4bbe-aad2-f3ee009758c9	DA007	3	D	f	CV079	f	2022-08-09 15:21:15.924092	2022-08-09 15:21:15.924092
8c41b570-51b1-4493-b9c8-7a60012a89d1	DA007	3	I	f	CV079	f	2022-08-09 15:21:15.929408	2022-08-09 15:21:15.929408
c1102743-37e1-4818-ac22-17ee2c7b3efe	DA007	3	W	f	CV079	f	2022-08-09 15:21:15.934937	2022-08-09 15:21:15.934937
1685da5f-ad58-4993-94f5-dbcc8a35ff9a	DA007	3	Z	f	CV079	f	2022-08-09 15:21:15.940151	2022-08-09 15:21:15.940151
3110b5ab-bc03-4360-9e63-c95583f66b3a	DA007	3	D	t	CV117	f	2022-08-09 15:21:15.951121	2022-08-09 15:21:15.951121
658e0257-578b-4d3a-96ba-15e0f2e8f21b	DA007	3	I	t	CV117	f	2022-08-09 15:21:15.956459	2022-08-09 15:21:15.956459
97e4a3ca-88e9-4bde-bdda-ec0e5182e9d0	DA007	3	W	t	CV117	f	2022-08-09 15:21:15.963199	2022-08-09 15:21:15.963199
a2f75a6b-c91e-45c9-bff1-c6844d59d71d	DA007	3	Z	t	CV117	f	2022-08-09 15:21:15.969076	2022-08-09 15:21:15.969076
dad65ce1-78e0-4ea6-b7ae-dce1884c6db0	DA007	3	A	f	CV117	f	2022-08-09 15:21:15.974893	2022-08-09 15:21:15.974893
c09486bf-45c8-4fb3-a5a9-7b578090a718	DA007	3	D	f	CV117	f	2022-08-09 15:21:15.9807	2022-08-09 15:21:15.9807
1a9d6a50-ef87-431d-88d1-ad392ca6bcca	DA007	3	I	f	CV117	f	2022-08-09 15:21:15.986218	2022-08-09 15:21:15.986218
9561a417-34b1-4de0-81f0-0a647e60f1b3	DA007	3	W	f	CV117	f	2022-08-09 15:21:15.992299	2022-08-09 15:21:15.992299
c5c5c11f-5db9-429a-93cd-da20f3cb62d4	DA007	3	Z	f	CV117	f	2022-08-09 15:21:15.997728	2022-08-09 15:21:15.997728
a7a39596-bc3a-4aa2-8673-3a53f4bf9e33	DA007	3	A	t	CV118	f	2022-08-09 15:21:16.003609	2022-08-09 15:21:16.003609
090c4727-59ed-4471-8753-8cf3cb270051	DA007	3	A	f	CV118	f	2022-08-09 15:21:16.03173	2022-08-09 15:21:16.03173
40e268e1-d810-4e2a-a0b1-1ac3c1ea6f7b	DA007	3	D	f	CV118	f	2022-08-09 15:21:16.037684	2022-08-09 15:21:16.037684
f8a831ee-2177-4d4e-8881-0bec2c7e6510	DA007	3	I	f	CV118	f	2022-08-09 15:21:16.042938	2022-08-09 15:21:16.042938
21441dfd-2244-4e20-a24e-aa7b2ce89693	DA007	3	W	f	CV118	f	2022-08-09 15:21:16.048566	2022-08-09 15:21:16.048566
68f841ff-d861-4e3b-b49f-bb1ead527939	DA007	3	Z	f	CV118	f	2022-08-09 15:21:16.053816	2022-08-09 15:21:16.053816
62373b25-eb8a-4435-a3e9-3d81f9a3b722	DA007	3	A	t	FM054	f	2022-08-09 15:21:16.059288	2022-08-09 15:21:16.059288
2516c114-47b8-4774-a099-3310a9e21da9	DA007	3	D	t	FM054	f	2022-08-09 15:21:16.065418	2022-08-09 15:21:16.065418
d9cac537-d5c5-40a3-90d7-c26a7c6c9f34	DA007	3	I	t	FM054	f	2022-08-09 15:21:16.071131	2022-08-09 15:21:16.071131
279ee658-5be8-48df-bc59-bede6a4be90c	DA007	3	W	t	FM054	f	2022-08-09 15:21:16.07644	2022-08-09 15:21:16.07644
02c8b6f4-6b67-4c51-92f2-fd495a1dd102	DA007	3	Z	t	FM054	f	2022-08-09 15:21:16.083967	2022-08-09 15:21:16.083967
96a7f685-75b2-45fb-9ba6-b400711db465	DA007	3	A	f	FM054	f	2022-08-09 15:21:16.089662	2022-08-09 15:21:16.089662
c77cbb2f-0cba-4f51-a582-e76e52c6a266	DA007	3	D	f	FM054	f	2022-08-09 15:21:16.095573	2022-08-09 15:21:16.095573
688ec67d-01b2-415a-9c6e-00591d009099	DA007	3	I	f	FM054	f	2022-08-09 15:21:16.101114	2022-08-09 15:21:16.101114
4be7d942-6a51-4535-bd01-226ad2879573	DA007	3	W	f	FM054	f	2022-08-09 15:21:16.106896	2022-08-09 15:21:16.106896
6c9bced8-0820-465b-9dd6-9327f8ea704a	DA007	3	Z	f	FM054	f	2022-08-09 15:21:16.112461	2022-08-09 15:21:16.112461
ec7b8fb1-eb2a-4fbc-ba81-e1468ad94d96	DA007	3	A	f	AA019	t	2022-08-09 15:21:15.806509	2022-08-09 15:21:16.119838
ca4c5d75-33a1-4d67-9824-d9fba7530f61	DA007	3	D	f	AA019	t	2022-08-09 15:21:15.812189	2022-08-09 15:21:16.1269
3d740878-4de5-45a6-854b-61a60f0d564b	DA007	3	I	f	AA019	t	2022-08-09 15:21:15.817622	2022-08-09 15:21:16.134164
d3c23b92-65aa-4cfb-adf2-a69b23a3022c	DA007	3	W	f	AA019	t	2022-08-09 15:21:15.823417	2022-08-09 15:21:16.141305
3090fa4a-94ae-48b3-8ca5-98ff6a30f34b	DA007	3	Z	f	AA019	t	2022-08-09 15:21:15.828793	2022-08-09 15:21:16.148413
6a6e3cf2-4214-46b8-8d0b-35f61c130061	DA007	3	A	t	CV117	t	2022-08-09 15:21:15.945467	2022-08-09 15:21:16.155676
dc6f134a-6c38-4e92-9ccc-a8ebda7a2164	DA007	3	D	t	CV118	t	2022-08-09 15:21:16.009068	2022-08-09 15:21:16.1627
6f508030-706f-4b88-83a9-475853492050	DA007	3	I	t	CV118	t	2022-08-09 15:21:16.014677	2022-08-09 15:21:16.169816
4b687280-c3ae-4750-97ca-352a633c6acf	DA007	3	W	t	CV118	t	2022-08-09 15:21:16.020033	2022-08-09 15:21:16.177137
dcf5cd4f-7ad9-4cda-9112-0e80b513da4f	DA007	3	Z	t	CV118	t	2022-08-09 15:21:16.025631	2022-08-09 15:21:16.184187
f0502aca-775c-4fe4-80b5-d43b26285820	DA020	3	A	t	AA009	f	2022-08-09 15:21:16.189965	2022-08-09 15:21:16.189965
8b1eb6e8-feef-4919-8dbc-cfcfbf656a43	DA020	3	D	t	AA009	f	2022-08-09 15:21:16.195478	2022-08-09 15:21:16.195478
61cfbc8f-688d-42e5-9f43-f2764749c684	DA020	3	I	t	AA009	f	2022-08-09 15:21:16.200836	2022-08-09 15:21:16.200836
ea4f3d7a-db35-4cb8-a020-1716323a00fd	DA020	3	W	t	AA009	f	2022-08-09 15:21:16.206524	2022-08-09 15:21:16.206524
3e2001f7-841b-4ecc-be50-3ae2a4444ca9	DA020	3	Z	t	AA009	f	2022-08-09 15:21:16.211808	2022-08-09 15:21:16.211808
33c06304-a7ff-46c8-a3e5-a29c0ef1ba00	DA020	3	A	f	AA009	f	2022-08-09 15:21:16.217401	2022-08-09 15:21:16.217401
24a0bf08-69ad-4d1a-a6ad-1c2118d5d7ea	DA020	3	D	f	AA009	f	2022-08-09 15:21:16.222756	2022-08-09 15:21:16.222756
cb8faf20-5a8f-4802-a807-bb992c13e1f1	DA020	3	I	f	AA009	f	2022-08-09 15:21:16.228208	2022-08-09 15:21:16.228208
50ca60e5-9c64-4b11-ba29-96087207519b	DA020	3	W	f	AA009	f	2022-08-09 15:21:16.234531	2022-08-09 15:21:16.234531
4a6bcbfa-e94c-489f-8d65-339b13540964	DA020	3	Z	f	AA009	f	2022-08-09 15:21:16.240245	2022-08-09 15:21:16.240245
6b26ae83-d15c-4045-810b-287e81fc61ca	DA020	3	A	t	CV027	f	2022-08-09 15:21:16.278905	2022-08-09 15:21:16.278905
8d9559a0-a4f8-4db0-bfd6-215d59db77a1	DA020	3	D	t	CV027	f	2022-08-09 15:21:16.284253	2022-08-09 15:21:16.284253
671a2102-c1dd-4915-816e-ee440e44bcd0	DA020	3	I	t	CV027	f	2022-08-09 15:21:16.291242	2022-08-09 15:21:16.291242
e7a62c13-dfff-4cb8-b626-945e0abc9407	DA020	3	W	t	CV027	f	2022-08-09 15:21:16.297416	2022-08-09 15:21:16.297416
79615abb-0c46-4c4a-b68f-66a05d2b9cfe	DA020	3	Z	t	CV027	f	2022-08-09 15:21:16.302941	2022-08-09 15:21:16.302941
c6216089-716d-421f-9e89-cf7de0b91cf1	DA020	3	A	f	CV027	f	2022-08-09 15:21:16.308875	2022-08-09 15:21:16.308875
1f188399-11e9-4091-bdd9-df04ed92880d	DA020	3	D	f	CV027	f	2022-08-09 15:21:16.31468	2022-08-09 15:21:16.31468
d38634d5-569d-4e0e-8da8-c8aa9752b5f7	DA020	3	I	f	CV027	f	2022-08-09 15:21:16.320861	2022-08-09 15:21:16.320861
74fa0eef-37a7-4c84-81ed-d84da707b18d	DA020	3	W	f	CV027	f	2022-08-09 15:21:16.326836	2022-08-09 15:21:16.326836
7866d454-2ac7-42bb-9418-4620d1e71533	DA020	3	Z	f	CV027	f	2022-08-09 15:21:16.333455	2022-08-09 15:21:16.333455
79408fa9-73ef-41f4-b24f-f4a35ad4bdee	DA020	3	A	t	CV079	f	2022-08-09 15:21:16.33915	2022-08-09 15:21:16.33915
d7a736e4-5341-49cf-b0ca-4cafb34a13ca	DA020	3	D	t	CV079	f	2022-08-09 15:21:16.344846	2022-08-09 15:21:16.344846
feccdaad-204b-4e87-8c94-4ad6903fc175	DA020	3	I	t	CV079	f	2022-08-09 15:21:16.351587	2022-08-09 15:21:16.351587
0daaa715-0a29-47af-acd8-7ecd5642a4ec	DA020	3	W	t	CV079	f	2022-08-09 15:21:16.357495	2022-08-09 15:21:16.357495
6ed846f8-5297-4ecc-96ce-bb0bec517ebc	DA020	3	Z	t	CV079	f	2022-08-09 15:21:16.36357	2022-08-09 15:21:16.36357
9d3be722-ece6-4190-9c32-5208ebda3d10	DA020	3	A	f	CV079	f	2022-08-09 15:21:16.370019	2022-08-09 15:21:16.370019
f5714b00-9914-45c9-acbc-e1c3d48d2904	DA020	3	D	f	CV079	f	2022-08-09 15:21:16.376371	2022-08-09 15:21:16.376371
f9529491-61f9-4f5d-904d-9ca5a5d27af5	DA020	3	I	f	CV079	f	2022-08-09 15:21:16.38241	2022-08-09 15:21:16.38241
304a89d5-d828-49b5-aa84-fd7152e81ee2	DA020	3	W	f	CV079	f	2022-08-09 15:21:16.387961	2022-08-09 15:21:16.387961
268e3c81-1fde-4e66-a130-315955a3fe54	DA020	3	Z	f	CV079	f	2022-08-09 15:21:16.39421	2022-08-09 15:21:16.39421
e94c414c-a8b4-47c0-831e-68f62f718176	DA020	3	D	t	CV117	f	2022-08-09 15:21:16.405294	2022-08-09 15:21:16.405294
74b329fe-0a91-4db9-a2fd-56b1d52843db	DA020	3	I	t	CV117	f	2022-08-09 15:21:16.411126	2022-08-09 15:21:16.411126
c18bce5f-9098-4618-a32d-4811ed679a9d	DA020	3	W	t	CV117	f	2022-08-09 15:21:16.416489	2022-08-09 15:21:16.416489
894bbdf3-2126-41d3-9d00-5958d5b0ea7b	DA020	3	Z	t	CV117	f	2022-08-09 15:21:16.421835	2022-08-09 15:21:16.421835
965f4be1-fe15-412d-b9dc-424fe4010a0f	DA020	3	A	f	CV117	f	2022-08-09 15:21:16.427694	2022-08-09 15:21:16.427694
9a035462-f2a9-452d-aeca-6b954924c5ad	DA020	3	D	f	CV117	f	2022-08-09 15:21:16.433137	2022-08-09 15:21:16.433137
e1e48303-8a1d-4786-bea3-8ff7349efd65	DA020	3	I	f	CV117	f	2022-08-09 15:21:16.439422	2022-08-09 15:21:16.439422
7312748c-59be-47a2-86fd-8669da083ad3	DA020	3	W	f	CV117	f	2022-08-09 15:21:16.444944	2022-08-09 15:21:16.444944
9d79b2cc-1454-4d8a-a97f-6ec06c59b840	DA020	3	Z	f	CV117	f	2022-08-09 15:21:16.450984	2022-08-09 15:21:16.450984
77a42154-5e30-4a01-be7c-71e17736e69d	DA020	3	A	t	CV118	f	2022-08-09 15:21:16.45635	2022-08-09 15:21:16.45635
80b38f99-ee65-4199-b11a-f0bfce7464dd	DA020	3	A	f	CV118	f	2022-08-09 15:21:16.483878	2022-08-09 15:21:16.483878
758e5397-08c6-4e8f-8560-c1a266397d51	DA020	3	D	f	CV118	f	2022-08-09 15:21:16.489366	2022-08-09 15:21:16.489366
9a71398b-b688-4eab-b255-e3246d437f74	DA020	3	I	f	CV118	f	2022-08-09 15:21:16.495101	2022-08-09 15:21:16.495101
bdb6bb4f-0839-43c5-9bc7-8dd0d8a221f5	DA020	3	W	f	CV118	f	2022-08-09 15:21:16.500339	2022-08-09 15:21:16.500339
2edca3bf-8820-4b04-acb1-baa2e5ef04a6	DA020	3	Z	f	CV118	f	2022-08-09 15:21:16.505632	2022-08-09 15:21:16.505632
a6cfadd5-4205-489b-b62c-58eff0703ffa	DA020	3	A	t	FM054	f	2022-08-09 15:21:16.511531	2022-08-09 15:21:16.511531
7b370e33-f1bc-46a8-8fc3-ad368403cb8e	DA020	3	D	t	FM054	f	2022-08-09 15:21:16.517113	2022-08-09 15:21:16.517113
02222037-0172-44b1-ae71-27024b08dc8b	DA020	3	I	t	FM054	f	2022-08-09 15:21:16.522399	2022-08-09 15:21:16.522399
c1178535-c249-4dbe-ba59-ee61943b1b5e	DA020	3	W	t	FM054	f	2022-08-09 15:21:16.528016	2022-08-09 15:21:16.528016
edf9a9fb-10b9-4a51-b8d6-b458fa32a548	DA020	3	Z	t	FM054	f	2022-08-09 15:21:16.533597	2022-08-09 15:21:16.533597
7ed50466-06f1-482d-89c6-e181d15d32e4	DA020	3	A	f	FM054	f	2022-08-09 15:21:16.539007	2022-08-09 15:21:16.539007
021d6119-6a53-4cb2-a6d8-f75c7ae1e2e1	DA020	3	D	f	FM054	f	2022-08-09 15:21:16.544652	2022-08-09 15:21:16.544652
bd4a069f-13a6-4cd6-b6c2-a8957222d570	DA020	3	I	f	FM054	f	2022-08-09 15:21:16.550031	2022-08-09 15:21:16.550031
9a642f65-cc79-423f-8d02-d5fc3fdad796	DA020	3	W	f	FM054	f	2022-08-09 15:21:16.556047	2022-08-09 15:21:16.556047
ad530709-77da-4120-8e83-cebd7e62f41c	DA020	3	Z	f	FM054	f	2022-08-09 15:21:16.561508	2022-08-09 15:21:16.561508
9c1afd58-475c-4031-b85a-09d1e3a89d63	DA020	3	A	f	AA019	t	2022-08-09 15:21:16.250152	2022-08-09 15:21:16.568709
a826aed0-8ed7-4415-b901-d5adf77040af	DA020	3	D	f	AA019	t	2022-08-09 15:21:16.255595	2022-08-09 15:21:16.575875
600a383b-3d71-468e-99ff-7e54cec166a2	DA020	3	I	f	AA019	t	2022-08-09 15:21:16.261321	2022-08-09 15:21:16.584819
a0cb4174-3a53-4f86-a2ca-84dfe608e047	DA020	3	W	f	AA019	t	2022-08-09 15:21:16.266943	2022-08-09 15:21:16.592549
4b5e644e-cc53-43a2-9590-31d4b48ff732	DA020	3	Z	f	AA019	t	2022-08-09 15:21:16.272825	2022-08-09 15:21:16.600037
cb112d97-f9f7-4888-969b-893ddc12356f	DA020	3	A	t	CV117	t	2022-08-09 15:21:16.399857	2022-08-09 15:21:16.607316
3e5f7cc4-679e-44e1-af3b-44efe612b6c7	DA020	3	D	t	CV118	t	2022-08-09 15:21:16.461951	2022-08-09 15:21:16.614709
00ea5887-338f-4cf7-a09b-e90ae0b3818b	DA020	3	I	t	CV118	t	2022-08-09 15:21:16.467583	2022-08-09 15:21:16.623351
a78773a3-8ca7-4453-b4d4-a1880d18f208	DA020	3	W	t	CV118	t	2022-08-09 15:21:16.472896	2022-08-09 15:21:16.630878
4a6af573-886d-45d0-8e5d-aad756263dcc	DA020	3	Z	t	CV118	t	2022-08-09 15:21:16.478306	2022-08-09 15:21:16.638266
\.


--
-- Data for Name: proceeding_type_service_levels; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.proceeding_type_service_levels (id, proceeding_type_id, service_level_id, proceeding_default, created_at, updated_at) FROM stdin;
9b076025-5bba-4797-84d4-b41742a4c2a5	b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	4935523e-8066-43ff-858d-18895742ad8e	t	2022-08-09 15:00:34.487214	2022-08-09 15:00:34.487214
e1c09d9c-77fd-4770-a99f-29768d27124d	891f647c-4c41-43aa-9869-a339422c263b	4935523e-8066-43ff-858d-18895742ad8e	t	2022-08-09 15:00:34.539529	2022-08-09 15:00:34.539529
ad76c7a7-9e16-4b59-992b-d2d0b2afd674	284b2853-a988-4962-8b0f-bf3ba47a8737	4935523e-8066-43ff-858d-18895742ad8e	t	2022-08-09 15:00:34.547628	2022-08-09 15:00:34.547628
d11cba91-43e9-4dc9-804d-69d1761b955c	09976e47-459c-4028-9ba4-bec984b54519	4935523e-8066-43ff-858d-18895742ad8e	t	2022-08-09 15:00:34.554897	2022-08-09 15:00:34.554897
b6d435ac-86ca-40cc-858e-8482d2127b8e	11fb5a94-45e4-4688-9fad-d4db494df0eb	4935523e-8066-43ff-858d-18895742ad8e	t	2022-08-09 15:00:34.561756	2022-08-09 15:00:34.561756
665f440a-96a8-4d7e-a579-d051b19d5bce	d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	4935523e-8066-43ff-858d-18895742ad8e	t	2022-08-09 15:00:34.568964	2022-08-09 15:00:34.568964
d5518abb-0d22-4963-a073-380331aa4c2c	3a437cd4-778f-4325-98dd-f79638a3907a	4935523e-8066-43ff-858d-18895742ad8e	t	2022-08-09 15:00:34.57541	2022-08-09 15:00:34.57541
812513f4-7c3a-42cc-a099-a462ecdcd0c7	c7f19bf7-a918-440b-bdd9-abd0ed19b692	4935523e-8066-43ff-858d-18895742ad8e	t	2022-08-09 15:00:34.582118	2022-08-09 15:00:34.582118
c49ab451-4dc4-41cd-a1b9-fac15d66dac8	98f3b2c9-0a72-48ba-be77-11c93b9818ad	4935523e-8066-43ff-858d-18895742ad8e	f	2022-08-09 15:00:34.589007	2022-08-09 15:00:34.589007
6db2a461-0eb3-4273-a7f8-13eba657cb9e	a0d435d2-2c7f-4812-9492-7593835180f6	4935523e-8066-43ff-858d-18895742ad8e	f	2022-08-09 15:00:34.595409	2022-08-09 15:00:34.595409
08914ed1-cdcf-4025-af00-06ea44aa05f6	e136ecbb-ec9d-42df-804f-2a363bb13e96	4935523e-8066-43ff-858d-18895742ad8e	f	2022-08-09 15:00:34.601904	2022-08-09 15:00:34.601904
3c31ff10-8da5-4c51-981c-0ab4575e8035	fec79071-885c-40e2-aad0-d98d5591aad5	4935523e-8066-43ff-858d-18895742ad8e	f	2022-08-09 15:00:34.607979	2022-08-09 15:00:34.607979
a4a1b973-f5d3-4990-8b17-c156ce4a05aa	98f3b2c9-0a72-48ba-be77-11c93b9818ad	4d4c7713-03dd-45b7-9ea3-f9d4d596fd29	t	2022-08-09 15:00:34.614348	2022-08-09 15:00:34.614348
4d2ba445-9113-405d-91a9-41017d519c7a	a0d435d2-2c7f-4812-9492-7593835180f6	4d4c7713-03dd-45b7-9ea3-f9d4d596fd29	t	2022-08-09 15:00:34.620812	2022-08-09 15:00:34.620812
e6b27797-7f0d-4269-98f2-c2426ac55222	e136ecbb-ec9d-42df-804f-2a363bb13e96	4d4c7713-03dd-45b7-9ea3-f9d4d596fd29	t	2022-08-09 15:00:34.626844	2022-08-09 15:00:34.626844
3655aecf-8042-43f8-8008-d72b18cedc9e	fec79071-885c-40e2-aad0-d98d5591aad5	4d4c7713-03dd-45b7-9ea3-f9d4d596fd29	t	2022-08-09 15:00:34.633209	2022-08-09 15:00:34.633209
\.


--
-- Data for Name: proceeding_types; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.proceeding_types (id, ccms_code, meaning, description, matter_type_id, created_at, updated_at, additional_search_terms, textsearchable, name, full_s8_only) FROM stdin;
e6566f52-365d-44be-9b20-0043885ea857	SE003A	Prohibited Steps Order-Appeal-S8	to be represented on an application for a prohibited steps order.  Appeals only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.075467	2022-08-09 15:00:31.075467	\N	'8':22C 'appeal':5A,18 'applic':12 'children':20C 'famili':19B 'order':4A,17 'order-appeal-s8':3A 'prohibit':1A,15 'repres':9 's8':6A 'se003a':23 'section':21C 'step':2A,16	prohibited_steps_order_appeal_s8	t
1b89d9f4-164a-4bce-9556-2d55b98f3394	SE003E	Prohibited Steps Order-Enforcement-S8	to be represented on an application for a prohibited steps order.  Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.080492	2022-08-09 15:00:31.080492	\N	'8':22C 'applic':12 'children':20C 'enforc':5A,18 'famili':19B 'order':4A,17 'order-enforcement-s8':3A 'prohibit':1A,15 'repres':9 's8':6A 'se003e':23 'section':21C 'step':2A,16	prohibited_steps_order_enforcement_s8	t
a0d435d2-2c7f-4812-9492-7593835180f6	SE004	Specific Issue Order	to be represented on an application for a specific issue order.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.085519	2022-08-09 15:00:31.085519	\N	'8':18C 'applic':9 'children':16C 'famili':15B 'issu':2A,13 'order':3A,14 'repres':6 'se004':19 'section':17C 'specif':1A,12	specified_issue_order_s8	f
93b8a259-e8f4-4cbf-8b02-db1b124acb9b	SE004A	Specific Issue Order-Appeal-S8	to be represented on an application for a specific issue order.  Appeals only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.090339	2022-08-09 15:00:31.090339	\N	'8':22C 'appeal':5A,18 'applic':12 'children':20C 'famili':19B 'issu':2A,16 'order':4A,17 'order-appeal-s8':3A 'repres':9 's8':6A 'se004a':23 'section':21C 'specif':1A,15	speciied_issue_order_s8_appeal	t
242c777d-484e-4185-b0a5-d34a4d01e631	SE004E	Specific Issue Order-Enforcement-S8	to be represented on an application for a specific issue order.  Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.095292	2022-08-09 15:00:31.095292	\N	'8':22C 'applic':12 'children':20C 'enforc':5A,18 'famili':19B 'issu':2A,16 'order':4A,17 'order-enforcement-s8':3A 'repres':9 's8':6A 'se004e':23 'section':21C 'specif':1A,15	speciied_issue_order_s8_enforcement	t
3003821e-6c36-4bae-a030-28977e3ceec7	SE007	Vary/Discharge Prohib Steps Order-S8	to be represented on an application to vary or discharge a prohibited steps order.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.10036	2022-08-09 15:00:31.10036	\N	'8':24C 'applic':12 'children':22C 'discharg':16 'famili':21B 'order':5A,20 'order-s8':4A 'prohib':2A 'prohibit':18 'repres':9 's8':6A 'se007':25 'section':23C 'step':3A,19 'vari':14 'vary/discharge':1A	vary_discharge_prohib_steps_s8	t
4ba11b67-7501-4878-b1f5-e8ac9740e276	SE007A	Vary/Discharge Prohib Steps Order-Appeal-S8	to be represented on an application to vary or discharge a prohibited steps order.  Appeals only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.105416	2022-08-09 15:00:31.105416	\N	'8':26C 'appeal':6A,22 'applic':13 'children':24C 'discharg':17 'famili':23B 'order':5A,21 'order-appeal-s8':4A 'prohib':2A 'prohibit':19 'repres':10 's8':7A 'se007a':27 'section':25C 'step':3A,20 'vari':15 'vary/discharge':1A	vary_discharge_prohib_steps_s8_appeal	t
7b16ca9d-c51e-40f2-ac01-aa88584a0cef	SE007E	Vary/Discharge Prohib Steps Order-Enforcement-S8	to be represented on an application to vary or discharge a prohibited steps order.  Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.110371	2022-08-09 15:00:31.110371	\N	'8':26C 'applic':13 'children':24C 'discharg':17 'enforc':6A,22 'famili':23B 'order':5A,21 'order-enforcement-s8':4A 'prohib':2A 'prohibit':19 'repres':10 's8':7A 'se007e':27 'section':25C 'step':3A,20 'vari':15 'vary/discharge':1A	vary_discharge_prohib_steps_s8_enforcement	t
1c260b2e-7c4d-4d98-8807-ccd0851e49e2	SE008	Vary/Discharge Specific Issues Ord-S8	to be represented on an application to vary or discharge a specific issue order.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.115342	2022-08-09 15:00:31.115342	\N	'8':24C 'applic':12 'children':22C 'discharg':16 'famili':21B 'issu':3A,19 'ord':5A 'ord-s8':4A 'order':20 'repres':9 's8':6A 'se008':25 'section':23C 'specif':2A,18 'vari':14 'vary/discharge':1A	vary_discharge_specific_issues_s8	t
9f349ce4-aa9f-4773-a243-caaa9d3f6530	SE008A	Vary/Discharge Specific Issues Ord-Appeal-S8	to be represented on an application to vary or discharge a specific issue order.  Appeals only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.120192	2022-08-09 15:00:31.120192	\N	'8':26C 'appeal':6A,22 'applic':13 'children':24C 'discharg':17 'famili':23B 'issu':3A,20 'ord':5A 'ord-appeal-s8':4A 'order':21 'repres':10 's8':7A 'se008a':27 'section':25C 'specif':2A,19 'vari':15 'vary/discharge':1A	vary_discharge_specific_issues_s8_appeal	t
1aafdaa0-1547-4c30-824f-7a5b3e0af6d6	SE008E	Vary/Discharge Specific Issues Ord-Enforcement-S8	to be represented on an application to vary or discharge a specific issue order.  Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.125037	2022-08-09 15:00:31.125037	\N	'8':26C 'applic':13 'children':24C 'discharg':17 'enforc':6A,22 'famili':23B 'issu':3A,20 'ord':5A 'ord-enforcement-s8':4A 'order':21 'repres':10 's8':7A 'se008e':27 'section':25C 'specif':2A,19 'vari':15 'vary/discharge':1A	vary_discharge_specific_issues_s8_enforcement	t
e136ecbb-ec9d-42df-804f-2a363bb13e96	SE013	Child arrangements order (contact)	to be represented on an application for a child arrangements order-who the child(ren) spend time with.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.129979	2022-08-09 15:00:31.129979	cao	'8':27C 'applic':10 'arrang':2A,14 'cao':23 'child':1A,13,19 'children':25C 'contact':4A 'famili':24B 'order':3A,16 'order-who':15 'ren':20 'repres':7 'se013':28 'section':26C 'spend':21 'time':22	child_arrangements_order_contact	f
bc3a4e66-235e-4dd4-81fd-1f820b0d556f	SE013A	CAO contact-Appeal	to be represented on an application for a child arrangements order-who the child(ren) spend time with. Appeals only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.135031	2022-08-09 15:00:31.135031	\N	'8':28C 'appeal':4A,24 'applic':10 'arrang':14 'cao':1A 'child':13,19 'children':26C 'contact':3A 'contact-app':2A 'famili':25B 'order':16 'order-who':15 'ren':20 'repres':7 'se013a':29 'section':27C 'spend':21 'time':22	cao_contact_appeal	t
6ea70541-495b-4007-9cb3-f53881163378	SE013E	CAO contact-Enforcement	to be represented on an application for a child arrangements order-who the child(ren) spend time with. Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.140596	2022-08-09 15:00:31.140596	\N	'8':28C 'applic':10 'arrang':14 'cao':1A 'child':13,19 'children':26C 'contact':3A 'contact-enforc':2A 'enforc':4A,24 'famili':25B 'order':16 'order-who':15 'ren':20 'repres':7 'se013e':29 'section':27C 'spend':21 'time':22	cao_contact_appeal	t
fec79071-885c-40e2-aad0-d98d5591aad5	SE014	Child arrangements order (residence)	to be represented on an application for a child arrangements order –where the child(ren) will live	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.146163	2022-08-09 15:00:31.146163	cao	'8':26C 'applic':10 'arrang':2A,14 'cao':22 'child':1A,13,18 'children':24C 'famili':23B 'live':21 'order':3A,15 'ren':19 'repres':7 'resid':4A 'se014':27 'section':25C	child_arrangements_order_residence	f
642ea1ca-dde9-4b14-b21b-c5559b732c5d	SE014A	CAO residence-Appeal	to be represented on an application for a child arrangements order –where the child(ren) will live. Appeals only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.152075	2022-08-09 15:00:31.152075	\N	'8':26C 'appeal':4A,22 'applic':10 'arrang':14 'cao':1A 'child':13,18 'children':24C 'famili':23B 'live':21 'order':15 'ren':19 'repres':7 'resid':3A 'residence-app':2A 'se014a':27 'section':25C	cao_residence_appeal	t
b17d6e8e-21bb-4393-8d4f-d98f2ff0864f	DA001	Inherent jurisdiction high court injunction	to be represented on an application for an injunction, order or declaration under the inherent jurisdiction of the court.	2a8e4621-8d2c-4d74-815c-89f5879a5038	2022-08-09 15:00:30.983706	2022-08-09 15:00:30.983706	\N	'abus':27C 'applic':11 'court':4A,24 'da001':28 'declar':17 'domest':26C 'famili':25B 'high':3A 'inher':1A,20 'injunct':5A,14 'jurisdict':2A,21 'order':15 'repres':8	inherent_jurisdiction_high_court_injunction	f
891f647c-4c41-43aa-9869-a339422c263b	DA002	Variation or discharge under section 5 protection from harassment act 1997	to be represented on an application to vary or discharge an order under section 5 Protection from Harassment Act 1997 where the parties are associated persons (as defined by Part IV Family Law Act 1996).	2a8e4621-8d2c-4d74-815c-89f5879a5038	2022-08-09 15:00:31.032677	2022-08-09 15:00:31.032677	\N	'1996':46 '1997':11A,31 '5':6A,26 'abus':49C 'act':10A,30,45 'applic':17 'associ':36 'da002':50 'defin':39 'discharg':3A,21 'domest':48C 'famili':43,47B 'harass':9A,29 'iv':42 'law':44 'order':23 'part':41 'parti':34 'person':37 'protect':7A,27 'repres':14 'section':5A,25 'vari':19 'variat':1A	variation_or_discharge_under_section_protection_from_harassment_act	f
284b2853-a988-4962-8b0f-bf3ba47a8737	DA003	Harassment - injunction	to be represented in an action for an injunction under section 3 Protection from Harassment Act 1997.	2a8e4621-8d2c-4d74-815c-89f5879a5038	2022-08-09 15:00:31.038995	2022-08-09 15:00:31.038995	\N	'1997':19 '3':14 'abus':22C 'act':18 'action':8 'da003':23 'domest':21C 'famili':20B 'harass':1A,17 'injunct':2A,11 'protect':15 'repres':5 'section':13	harassment_injunction	f
09976e47-459c-4028-9ba4-bec984b54519	DA004	Non-molestation order	to be represented on an application for a non-molestation order.	2a8e4621-8d2c-4d74-815c-89f5879a5038	2022-08-09 15:00:31.044303	2022-08-09 15:00:31.044303	harassment,injunction	'abus':21C 'applic':10 'da004':22 'domest':20C 'famili':19B 'harass':17 'injunct':18 'molest':3A,15 'non':2A,14 'non-molest':1A,13 'order':4A,16 'repres':7	nonmolestation_order	f
11fb5a94-45e4-4688-9fad-d4db494df0eb	DA005	Occupation order	to be represented on an application for an occupation order.	2a8e4621-8d2c-4d74-815c-89f5879a5038	2022-08-09 15:00:31.049666	2022-08-09 15:00:31.049666	\N	'abus':15C 'applic':8 'da005':16 'domest':14C 'famili':13B 'occup':1A,11 'order':2A,12 'repres':5	occupation_order	f
d9f9a19a-8896-4f2e-a9d1-bd55c2ba2626	DA006	Extend, variation or discharge - Part IV	to be represented on an application to extend, vary or discharge an order under Part IV Family Law Act 1996	2a8e4621-8d2c-4d74-815c-89f5879a5038	2022-08-09 15:00:31.054662	2022-08-09 15:00:31.054662	\N	'1996':26 'abus':29C 'act':25 'applic':12 'da006':30 'discharg':4A,17 'domest':28C 'extend':1A,14 'famili':23,27B 'iv':6A,22 'law':24 'order':19 'part':5A,21 'repres':9 'vari':15 'variat':2A	extend_variation_or_discharge_part_iv	f
3a437cd4-778f-4325-98dd-f79638a3907a	DA007	Forced marriage protection order	to be represented on an application for a forced marriage protection order	2a8e4621-8d2c-4d74-815c-89f5879a5038	2022-08-09 15:00:31.059615	2022-08-09 15:00:31.059615	\N	'abus':19C 'applic':10 'da007':20 'domest':18C 'famili':17B 'forc':1A,13 'marriag':2A,14 'order':4A,16 'protect':3A,15 'repres':7	forced_marriage_protection_order	f
b9f9d637-e8fd-4279-a3f3-edb9e42435cf	SE014E	CAO residence-Enforcement	to be represented on an application for a child arrangements order –where the child(ren) will live. Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.157593	2022-08-09 15:00:31.157593	\N	'8':26C 'applic':10 'arrang':14 'cao':1A 'child':13,18 'children':24C 'enforc':4A,22 'famili':23B 'live':21 'order':15 'ren':19 'repres':7 'resid':3A 'residence-enforc':2A 'se014e':27 'section':25C	cao_residence_enforcement	t
62c7df02-ad44-4947-bb4c-d1c2cc330cbf	SE015	Vary CAO contact	to be represented on an application to vary/discharge a child arrangements order-who the child(ren) spend time with.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.162959	2022-08-09 15:00:31.162959	\N	'8':26C 'applic':9 'arrang':14 'cao':2A 'child':13,19 'children':24C 'contact':3A 'famili':23B 'order':16 'order-who':15 'ren':20 'repres':6 'se015':27 'section':25C 'spend':21 'time':22 'vari':1A 'vary/discharge':11	vary_cao_contact	t
f23bc8d5-ff27-4b1d-8761-de7b24b00638	SE015A	Vary CAO contact-Appeal	to be represented on an application to vary/discharge a child arrangements order-who the child(ren) spend time with. Appeals only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.168038	2022-08-09 15:00:31.168038	\N	'8':30C 'appeal':5A,26 'applic':11 'arrang':16 'cao':2A 'child':15,21 'children':28C 'contact':4A 'contact-app':3A 'famili':27B 'order':18 'order-who':17 'ren':22 'repres':8 'se015a':31 'section':29C 'spend':23 'time':24 'vari':1A 'vary/discharge':13	vary_cao_contact_appeal	t
13150d8f-3d86-4fb7-85e9-d4656d5f0b43	SE015E	Vary CAO contact-Enforcement	to be represented on an application to vary/discharge a child arrangements order-who the child(ren) spend time with. Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.173082	2022-08-09 15:00:31.173082	\N	'8':30C 'applic':11 'arrang':16 'cao':2A 'child':15,21 'children':28C 'contact':4A 'contact-enforc':3A 'enforc':5A,26 'famili':27B 'order':18 'order-who':17 'ren':22 'repres':8 'se015e':31 'section':29C 'spend':23 'time':24 'vari':1A 'vary/discharge':13	vary_cao_contact_enforcement	t
82d4b5a2-6eda-4ab1-bd7a-fbb9abe59252	SE016	Vary CAO residence	to be represented on an application to vary or discharge a child arrangements order –where the child(ren) will live.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.178126	2022-08-09 15:00:31.178126	\N	'8':27C 'applic':9 'arrang':16 'cao':2A 'child':15,20 'children':25C 'discharg':13 'famili':24B 'live':23 'order':17 'ren':21 'repres':6 'resid':3A 'se016':28 'section':26C 'vari':1A,11	vary_cao_residence	t
9d34fbd4-f65a-4280-942d-ed78ec9eef91	SE016A	Vary CAO residence-Appeal	to be represented on an application to vary or discharge a child arrangements order –where the child(ren) will live. Appeals only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.183042	2022-08-09 15:00:31.183042	\N	'8':30C 'appeal':5A,26 'applic':11 'arrang':18 'cao':2A 'child':17,22 'children':28C 'discharg':15 'famili':27B 'live':25 'order':19 'ren':23 'repres':8 'resid':4A 'residence-app':3A 'se016a':31 'section':29C 'vari':1A,13	vary_cao_redidence_appeal	t
932cd99c-6c7f-48c6-adde-8708426a94d1	SE016E	Vary CAO residence-Enforcement	to be represented on an application to vary or discharge a child arrangements order –where the child(ren) will live. Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.191162	2022-08-09 15:00:31.191162	\N	'8':30C 'applic':11 'arrang':18 'cao':2A 'child':17,22 'children':28C 'discharg':15 'enforc':5A,26 'famili':27B 'live':25 'order':19 'ren':23 'repres':8 'resid':4A 'residence-enforc':3A 'se016e':31 'section':29C 'vari':1A,13	vary_cao_residence_enforcement	t
c3fca1ab-78a2-47e6-9319-b714a8aab8d1	SE095	Enforcement order 11J-S8	to be represented on an application for an enforcement order under section 11J Children Act 1989.  Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.197164	2022-08-09 15:00:31.197164	\N	'11j':4A,18 '11j-s8':3A '1989':21 '8':26C 'act':20 'applic':11 'children':19,24C 'enforc':1A,14,22 'famili':23B 'order':2A,15 'repres':8 's8':5A 'se095':27 'section':17,25C	enforcement_order_11j_s8	t
2cf3f771-83a3-4ed1-ade8-4fc70e062e56	SE095A	Enforcement order-Appeal-S8	to be represented on an application for an enforcement order under section 11J Children Act 1989.  Appeals only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.202117	2022-08-09 15:00:31.202117	\N	'11j':18 '1989':21 '8':26C 'act':20 'appeal':4A,22 'applic':11 'children':19,24C 'enforc':1A,14 'famili':23B 'order':3A,15 'order-appeal-s8':2A 'repres':8 's8':5A 'se095a':27 'section':17,25C	enforcement_order_11j_s8_appeal	t
d7101381-a15b-4b07-82bf-acf551c1a183	SE096E	Enforcement order+c’tal-S8	to be represented on an application for committal and for an enforcement order under section 11J Children Act 1989. Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.207457	2022-08-09 15:00:31.207457	\N	'11j':22 '1989':25 '8':30C 'act':24 'applic':12 'c':3A 'children':23,28C 'committ':14 'enforc':1A,18,26 'famili':27B 'order':2A,19 'repres':9 's8':6A 'se096e':31 'section':21,29C 'tal':5A 'tal-s8':4A	enforcement_committal_order	t
d9da15fd-8f19-4be2-b724-457411ef5383	SE097	Revocation enforcement-S8	to be represented on an application for the revocation of an enforcement order under section 11J and Schedule A1 Children Act 1989.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.212729	2022-08-09 15:00:31.212729	\N	'11j':20 '1989':26 '8':30C 'a1':23 'act':25 'applic':10 'children':24,28C 'enforc':3A,16 'enforcement-s8':2A 'famili':27B 'order':17 'repres':7 'revoc':1A,13 's8':4A 'schedul':22 'se097':31 'section':19,29C	revocation_enforcement_s8	t
8b76526c-5407-422e-8b37-41f5ea18adab	SE097A	Revocation enforcement-Appeal-S8	to be represented on an application for the revocation of an enforcement order under section 11J and Schedule A1 Children Act 1989.  Appeals only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.217767	2022-08-09 15:00:31.217767	\N	'11j':21 '1989':27 '8':32C 'a1':24 'act':26 'appeal':4A,28 'applic':11 'children':25,30C 'enforc':3A,17 'enforcement-appeal-s8':2A 'famili':29B 'order':18 'repres':8 'revoc':1A,14 's8':5A 'schedul':23 'se097a':33 'section':20,31C	revocation_enforcement_appeal_s8	t
c7f19bf7-a918-440b-bdd9-abd0ed19b692	DA020	FGM Protection Order	To be represented on an application for a Female Genital Mutilation Protection Order under the Female Genital Mutilation Act.	2a8e4621-8d2c-4d74-815c-89f5879a5038	2022-08-09 15:00:31.064715	2022-08-09 15:00:31.064715	\N	'abus':25C 'act':22 'applic':9 'da020':26 'domest':24C 'famili':23B 'femal':12,19 'fgm':1A 'genit':13,20 'mutil':14,21 'order':3A,16 'protect':2A,15 'repres':6	fgm_protection_order	f
98f3b2c9-0a72-48ba-be77-11c93b9818ad	SE003	Prohibited steps order	to be represented on an application for a prohibited steps order.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.07059	2022-08-09 15:00:31.07059	\N	'8':18C 'applic':9 'children':16C 'famili':15B 'order':3A,14 'prohibit':1A,12 'repres':6 'se003':19 'section':17C 'step':2A,13	prohibited_steps_order_s8	f
ce3eea37-0292-4432-ab88-26664e2f9426	SE099E	Amd enforcement-breach-S8	to be represented on an application, following breach, for an amendment to an enforcement order or for a further enforcement order under section 11J and Schedule A1 Children Act 1989.  Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.222838	2022-08-09 15:00:31.222838	\N	'11j':29 '1989':35 '8':40C 'a1':32 'act':34 'amd':1A 'amend':16 'applic':11 'breach':4A,13 'children':33,38C 'enforc':3A,19,25,36 'enforcement-breach-s8':2A 'famili':37B 'follow':12 'order':20,26 'repres':8 's8':5A 'schedul':31 'se099e':41 'section':28,39C	amd_enforcement_breach	t
0f28c43e-446e-431e-ba16-88263409c389	SE100E	Breach enforcement-S8	to be represented on an application, following breach, for an amendment to an enforcement order or for a further enforcement order under section 11J and Schedule A1 Children Act 1989.  Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.228005	2022-08-09 15:00:31.228005	\N	'11j':28 '1989':34 '8':39C 'a1':31 'act':33 'amend':15 'applic':10 'breach':1A,12 'children':32,37C 'enforc':3A,18,24,35 'enforcement-s8':2A 'famili':36B 'follow':11 'order':19,25 'repres':7 's8':4A 'schedul':30 'se100e':40 'section':27,38C	breach_enforcement_s8	t
0c173901-79f4-4077-a277-aff0352b05e2	SE101A	Compensation-Appeal-S8	to be represented on an application for compensation for financial loss under section 11O Children Act 1989.  Appeals only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.233106	2022-08-09 15:00:31.233106	\N	'11o':18 '1989':21 '8':26C 'act':20 'appeal':3A,22 'applic':10 'children':19,24C 'compens':2A,12 'compensation-appeal-s8':1A 'famili':23B 'financi':14 'loss':15 'repres':7 's8':4A 'se101a':27 'section':17,25C	compensation_appeal_s8	t
5d1656b5-a45d-4746-b986-6633cefa543f	SE101E	Compensation-Enforcement-S8	to be represented on an application for compensation for financial loss under section 11O Children Act 1989.  Enforcement only.	c4155d62-ece9-4cbe-ab10-51905253ddb5	2022-08-09 15:00:31.238364	2022-08-09 15:00:31.238364	\N	'11o':18 '1989':21 '8':26C 'act':20 'applic':10 'children':19,24C 'compens':2A,12 'compensation-enforcement-s8':1A 'enforc':3A,22 'famili':23B 'financi':14 'loss':15 'repres':7 's8':4A 'se101e':27 'section':17,25C	compensation_enforcement_s8	t
\.


--
-- Data for Name: request_histories; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.request_histories (id, request_method, request_id, endpoint, remote_ip, request_payload, response_status, response_payload, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.schema_migrations (version) FROM stdin;
20220804112224
20210325170720
20210325174044
20210325182433
20210329110536
20210329150054
20210405101611
20210930074336
20211005101913
20211005102214
20211006102824
20211006152408
20211130102438
20220504083530
20220504121754
20220707101059
20220713120142
20220713135652
20220726071615
20220726141406
20220728101235
20220804111406
\.


--
-- Data for Name: scope_limitation_user_inputs; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.scope_limitation_user_inputs (id, scope_limitation_id, scope_user_input_id, created_at, updated_at) FROM stdin;
48	ef06b4f0-e516-4c75-8936-95bf178237c3	40485049-1d81-4246-bbf7-5ca3c4cc6ca3	2022-08-09 15:20:32.66945	2022-08-09 15:20:32.66945
49	a074289e-1327-4f68-9a12-276d4ae3c685	40485049-1d81-4246-bbf7-5ca3c4cc6ca3	2022-08-09 15:20:32.674515	2022-08-09 15:20:32.674515
50	b3faa52b-79d0-4005-9457-d0b5b2ca2d26	40485049-1d81-4246-bbf7-5ca3c4cc6ca3	2022-08-09 15:20:32.678859	2022-08-09 15:20:32.678859
51	5ccf61d6-2696-4c26-aef7-a02b0566f8ee	1fd27ded-7c7c-4d51-9c58-37d3b9a49194	2022-08-09 15:20:32.683206	2022-08-09 15:20:32.683206
52	ec29d23a-752b-4a40-87c6-8c35eb5f018b	1fd27ded-7c7c-4d51-9c58-37d3b9a49194	2022-08-09 15:20:32.687307	2022-08-09 15:20:32.687307
53	b66547dd-00c9-48fc-b4c1-c078f2bebd5f	1fd27ded-7c7c-4d51-9c58-37d3b9a49194	2022-08-09 15:20:32.691254	2022-08-09 15:20:32.691254
54	ac56fe5e-3a06-457e-8fd7-f60411f32b8e	1fd27ded-7c7c-4d51-9c58-37d3b9a49194	2022-08-09 15:20:32.695311	2022-08-09 15:20:32.695311
55	f935637f-cd87-4018-921c-eefa7761a529	1fd27ded-7c7c-4d51-9c58-37d3b9a49194	2022-08-09 15:20:32.699156	2022-08-09 15:20:32.699156
56	1630120b-a5fb-46de-b680-62650c7e7fec	1fd27ded-7c7c-4d51-9c58-37d3b9a49194	2022-08-09 15:20:32.703072	2022-08-09 15:20:32.703072
57	70840334-c433-45b7-a736-079dbd2a0a3a	1fd27ded-7c7c-4d51-9c58-37d3b9a49194	2022-08-09 15:20:32.707085	2022-08-09 15:20:32.707085
58	dc3509f3-534b-485e-82a2-0f0e616e1d6e	1fd27ded-7c7c-4d51-9c58-37d3b9a49194	2022-08-09 15:20:32.711731	2022-08-09 15:20:32.711731
\.


--
-- Data for Name: scope_limitations; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.scope_limitations (id, code, meaning, description, substantive, delegated_functions, created_at, updated_at) FROM stdin;
731b0c53-1e5c-4216-afcb-838c3794116e	AA009	Warrant of arrest FLA	As to an order under Part IV Family Law Act 1996 limited to an application for the issue of a warrant of arrest.	t	t	2022-08-09 15:00:33.59854	2022-08-09 15:00:33.59854
0e03e1af-7497-4f06-b79d-49bd8e24d3b8	AA019	Injunction FLA-to final hearing	As to proceedings under Part IV Family Law Act 1996 limited to all steps up to and including obtaining and serving a final order and in the event of breach leading to the exercise of a power of arrest to representation on the consideration of the breach by the court (but excluding applying for a warrant of arrest, if not attached, and representation in contempt proceedings).	t	f	2022-08-09 15:00:33.601728	2022-08-09 15:00:33.601728
c00576f7-f269-42dd-9801-d9f6ff62e588	AA028	Interim Order (Emergency only) FGM	As to an application under the Female Genital Mutilation Act 2003 limited to all steps necessary to apply for an interim order where application is made without notice to include representation on the return date.	t	t	2022-08-09 15:00:33.603944	2022-08-09 15:00:33.603944
805e622b-de1e-4837-8d44-976f39612e82	AA029	Hearing (Emergency only) FGM	As to application under the Female Genital Mutilation Act 2003 limited to all steps up to and including the hearing on [date]	t	t	2022-08-09 15:00:33.606166	2022-08-09 15:00:33.606166
df5677c5-6d28-45f0-ba7a-737fcdd652ef	AA030	Injunction-FGM-to final hearing	As to proceedings under the Female Genital Mutilation Act 2003 limited to all steps up to and including obtaining and service a final order and in the event of breach leading to the exercise of a power of arrest to representation on the consideration of the breach by the court (but excluding applying for a warrant of arrest, if not attached, and representation in contempt proceedings).	t	f	2022-08-09 15:00:33.608099	2022-08-09 15:00:33.608099
f90f58dc-2766-4fcf-899c-bd6cc01e0c7b	AA031	Vary/dscg/rvke FGM Protection Order	As to an order under Female Genital Mutilation Act 2003 limited to an application to extend/vary or discharge.	t	t	2022-08-09 15:00:33.610334	2022-08-09 15:00:33.610334
2849a47a-5f47-489f-b255-d7fa0b7587cf	AA032	Overseas applicant-FGMPO	Limited where the applicant is overseas, to their return to the jurisdiction and thereafter a solicitor's report.	t	t	2022-08-09 15:00:33.612197	2022-08-09 15:00:33.612197
16c95330-c26c-4f9b-bd23-3f4be5a7a46e	APL07	Appeal-paper app for perm	Limited to making an application for permission to appeal on the papers, including preparation of an appellant's notice and a skeleton argument.	t	t	2022-08-09 15:00:33.614315	2022-08-09 15:00:33.614315
c8472093-6e5e-4602-a419-ada6e74c88f8	APL09	High Court-final hearing (resp)	Limited to representation as respondent on an appeal to the High Court, up to and including the final hearing of the appeal.	t	t	2022-08-09 15:00:33.616357	2022-08-09 15:00:33.616357
e4aa97b5-264e-4fef-8c51-70cd549b7be0	APL11	High Court-Counsel's Opinion (resp)	Limited to representation as respondent on an appeal to the High Court, limited to obtaining Counsel's Opinion on the merits of defending the appeal.	t	t	2022-08-09 15:00:33.618536	2022-08-09 15:00:33.618536
5ccf61d6-2696-4c26-aef7-a02b0566f8ee	APL13	High Court-limited steps (resp)	Limited to representation as respondent on an appeal to the High Court, limited to	t	t	2022-08-09 15:00:33.620374	2022-08-09 15:00:33.620374
ee14f6a8-885e-4a5f-b441-e4405042d665	APL15	Court of Appeal-Counsel's Opinion (Resp)	Limited to representation as respondent on an appeal to the Court of Appeal, limited to obtaining Counsel's Opinion on the merits of defending the appeal.	t	t	2022-08-09 15:00:33.622507	2022-08-09 15:00:33.622507
0eed2204-9e62-4a73-899e-9f762d79a1fc	APL16	Court of Appeal-paper app for perm	Limited to representation on an appeal to the Court of Appeal, limited to making an application for permission to appeal on the papers, including preparation of an appellant's notice and skeleton argument.	t	t	2022-08-09 15:00:33.624304	2022-08-09 15:00:33.624304
5978bc39-8559-436c-a1e7-a698134ae276	APL18	Court of Appeal-oral app for perm (resp)	Limited to representation as respondent on an appeal to the Court of Appeal, limited to all steps up to and including the hearing of an application for permission to appeal.	t	t	2022-08-09 15:00:33.626417	2022-08-09 15:00:33.626417
ec29d23a-752b-4a40-87c6-8c35eb5f018b	APL20	Court of Appeal-limited steps (resp)	Limited to representation as respondent on an appeal to the Court of Appeal, limited to	t	t	2022-08-09 15:00:33.62854	2022-08-09 15:00:33.62854
eca5ecb1-2691-419e-a436-453df8465ec0	APL22	Court of Appeal-final hearing (resp)	Limited to representation as respondent on an appeal to the Court of Appeal, up to and including the final hearing of the appeal.	t	t	2022-08-09 15:00:33.630357	2022-08-09 15:00:33.630357
1ac569e1-d55b-4dbd-95d8-acf64e8b9117	APL27	Judge from DJ-Counsel's Opinion (resp)	Limited to representation as respondent on an appeal to the Judge against a decision of the District Judge or Master, limited to obtaining Counsel's Opinion on the merits of defending the appeal.	t	t	2022-08-09 15:00:33.632448	2022-08-09 15:00:33.632448
b66547dd-00c9-48fc-b4c1-c078f2bebd5f	APL29	Judge from DJ-limited steps (resp)	Limited to representation as respondent on an appeal to the Judge against a decision of the District Judge or Master, limited to	t	t	2022-08-09 15:00:33.634244	2022-08-09 15:00:33.634244
a1930798-c673-4e58-a204-610098f05c4b	APL31	Judge from DJ-final hearing (resp)	Limited to representation as respondent on an appeal to the Judge against a decision of the District Judge or Master, up to and including the final hearing of the appeal.	t	t	2022-08-09 15:00:33.636348	2022-08-09 15:00:33.636348
aa9ade8d-99e8-4c8f-ab05-9c527f49e834	APL48	High Court-final hearing	Limited to representation on an appeal to the High Court, up to and including the final hearing of the appeal.	t	t	2022-08-09 15:00:33.638179	2022-08-09 15:00:33.638179
1540e968-3cde-41e2-a61e-652b286ace3f	APL49	High Court-Counsel's Opinion	Limited to representation on an appeal to the High Court, limited to obtaining Counsel's Opinion on the merits of an appeal.	t	t	2022-08-09 15:00:33.640266	2022-08-09 15:00:33.640266
ac56fe5e-3a06-457e-8fd7-f60411f32b8e	APL50	High Court-limited steps	Limited to representation on an appeal to the High Court, limited to	t	t	2022-08-09 15:00:33.642125	2022-08-09 15:00:33.642125
a43752e4-c723-45a8-a954-5c9045c8c1ca	APL51	Court of Appeal-Counsel's Opinion	Limited to representation on an appeal to the Court of Appeal, limited to obtaining Counsel's Opinion on the merits of an appeal.	t	t	2022-08-09 15:00:33.644334	2022-08-09 15:00:33.644334
89016c4c-fad4-46e6-83f4-7898c2027b94	APL52	Court of Appeal-oral app for perm	Limited to representation on an appeal to the Court of Appeal, limited to all steps up to and including the hearing of an application for permission to appeal.	t	t	2022-08-09 15:00:33.646197	2022-08-09 15:00:33.646197
f935637f-cd87-4018-921c-eefa7761a529	APL53	Court of Appeal-limited steps	Limited to representation on an appeal to the Court of Appeal limited to	t	t	2022-08-09 15:00:33.648345	2022-08-09 15:00:33.648345
675393df-4d68-43aa-b23b-b2c11ee843fb	APL54	Court of Appeal-final hearing	Limited to representation on an appeal to the Court of Appeal, up to and including the final hearing of the appeal.	t	t	2022-08-09 15:00:33.650205	2022-08-09 15:00:33.650205
e7f7c068-ace8-424f-b5aa-e9335ab5c431	APL55	Judge from DJ-Counsel's Opinion	Limited to representation on an appeal to the Judge against a decision of the District Judge or Master, limited to obtaining Counsel's Opinion on the merits of an appeal.	t	t	2022-08-09 15:00:33.652356	2022-08-09 15:00:33.652356
1630120b-a5fb-46de-b680-62650c7e7fec	APL56	Judge from DJ-limited steps	Limited to representation on an appeal to the Judge against a decision of the District Judge or Master, limited to	t	t	2022-08-09 15:00:33.654178	2022-08-09 15:00:33.654178
b5034727-0124-4cac-8cc7-a753163f58d1	APL57	Judge from DJ-final hearing	Limited to representation on an appeal to the Judge against a decision of the District Judge or Master, up to and including the final hearing of the appeal.	t	t	2022-08-09 15:00:33.656316	2022-08-09 15:00:33.656316
6d6dd068-4949-40ab-a3b4-f35ed714f5e2	APL65	Appeal family court-C opinion (App)	Limited to representation as an appellant on an appeal in the family court LIMITED to obtaining Counsel’s opinion on the merits of an appeal.	t	t	2022-08-09 15:00:33.65821	2022-08-09 15:00:33.65821
2a947bce-cbdc-403e-83e3-956e847c6d27	APL66	Appeal family court-C opinion (Resp)	Limited to representation as respondent on an appeal in the family court LIMITED to obtaining counsel’s opinion on the merits of defending the appeal.	t	t	2022-08-09 15:00:33.66038	2022-08-09 15:00:33.66038
70840334-c433-45b7-a736-079dbd2a0a3a	APL67	Appeal family crt-limited steps (App)	Llimited to be represented as appellant on an appeal in the family court LIMITED TO	t	t	2022-08-09 15:00:33.662556	2022-08-09 15:00:33.662556
dc3509f3-534b-485e-82a2-0f0e616e1d6e	APL68	Appeal family crt-limited steps (Resp)	Limited to be represented as respondent to an appeal in the family court, LIMITED TO	t	t	2022-08-09 15:00:33.664998	2022-08-09 15:00:33.664998
070a2063-159e-4d8f-bea8-6548a97f354d	APL69	Appeal family crt-final hearing (App)	Limited to representation as appellant on an appeal in the family court, up to and including the final hearing of the appeal.	t	t	2022-08-09 15:00:33.667301	2022-08-09 15:00:33.667301
8c7089e7-3849-4382-a0c0-cab91ae4dde2	APL70	Appeal family crt-final hearing (Rep)	Limited to representation on an appeal in the family court, up to an including the final hearing of the appeal.	t	t	2022-08-09 15:00:33.669184	2022-08-09 15:00:33.669184
a074289e-1327-4f68-9a12-276d4ae3c685	CV027	Hearing/Adjournment	Limited to all steps (including any adjournment thereof) up to and including the hearing on	t	t	2022-08-09 15:00:33.671283	2022-08-09 15:00:33.671283
b3faa52b-79d0-4005-9457-d0b5b2ca2d26	CV079	Counsel's Opinion	Limited to obtaining external Counsel's Opinion or the opinion of an external solicitor with higher court advocacy rights on the information already available.	t	t	2022-08-09 15:00:33.673078	2022-08-09 15:00:33.673078
fd4283df-ae72-484b-9fac-d07f63fd7cb8	CV117	Interim order inc. return date	Limited to all steps necessary to apply for an interim order; where application is made without notice to include representation on the return date.	t	t	2022-08-09 15:00:33.675312	2022-08-09 15:00:33.675312
ef06b4f0-e516-4c75-8936-95bf178237c3	CV118	Hearing	Limited to all steps up to and including the hearing on [see additional limitation notes]	t	t	2022-08-09 15:00:33.67722	2022-08-09 15:00:33.67722
170781bb-e733-43d6-9a20-37f9a19994ef	CV128	Counsel's opinion-merits, quantum, and cost benefit	Limited to obtaining counsel's opinion or the opinion of an external solicitor with higher court advocacy rights particularly in regard to the merits, quantum, and cost benefit of the action.	t	t	2022-08-09 15:00:33.679157	2022-08-09 15:00:33.679157
06afe393-62fc-43ca-8b82-5b25d01da00b	CV129	Counsel's opinion-merits	Limited to obtaining counsel's opinion or the opinion of an external solicitor with higher court advocacy rights particularly in regard to the merits of the case.	t	t	2022-08-09 15:00:33.685341	2022-08-09 15:00:33.685341
46f5bc94-1488-4c9f-95db-75e8d8c71781	EF012	Attachment of earnings order	Limited to an application for enforcement by way of an attachment of earnings order.	t	t	2022-08-09 15:00:33.687275	2022-08-09 15:00:33.687275
b752b20e-e050-4d78-bf69-3fa606c1ffe6	EF022	Further committal application	Limited to a further application for enforcement by way of committal for breach of an order or undertaking.	t	t	2022-08-09 15:00:33.689624	2022-08-09 15:00:33.689624
14df5dca-944c-4831-98c3-928f03e1b557	EF025	Committal-breach of order	Limited to an application for enforcement by way of committal for breach of an order or undertaking.	t	t	2022-08-09 15:00:33.691875	2022-08-09 15:00:33.691875
06e3d857-6293-4315-b3d5-4d71be4a45a0	EF026	Purge Contempt	Limited to an application to purge contempt and representation on purging contempt order.	t	t	2022-08-09 15:00:33.693811	2022-08-09 15:00:33.693811
d67dd702-3f11-4e5d-81a5-4d715a7f9bfd	EF027	Enforce contact order	Limited to enforcement of a contact order under Section 11J Children Act 1989	t	t	2022-08-09 15:00:33.696016	2022-08-09 15:00:33.696016
719ec421-4af3-4de2-be59-3cfa33d650b5	FM004	CAFCASS report	Limited to all steps up to and including the Children and Family Reporter's Report and thereafter a solicitor's report.	t	t	2022-08-09 15:00:33.697928	2022-08-09 15:00:33.697928
d316c8d2-b8ef-42b0-a431-e2f816c0ff7d	FM007	Blood Tests or DNA Tests	Limited to all steps up to and including the obtaining of blood tests or DNA tests and thereafter a solicitor's report.	t	t	2022-08-09 15:00:33.700121	2022-08-09 15:00:33.700121
5ac7e37e-3213-4310-a622-5644ac4908cb	FM015	Section 37 Report	Limited to a section 37 report only.	t	t	2022-08-09 15:00:33.702383	2022-08-09 15:00:33.702383
23a9c604-efaf-49de-9ccf-b4147da4a9f7	FM019	Exchange of Evidence	Limited to all steps up to and including the exchange of evidence (including any welfare officer's/guardian ad litem's report) and directions appointments but not including a final contested hearing and thereafter to a solicitors report (or if so advised a Counsel's opinion) on the issues and prospects of success.	t	t	2022-08-09 15:00:33.70429	2022-08-09 15:00:33.70429
41d57420-f226-4820-92c6-affbac529cb8	FM039	Final hearing(CAFCASS rept)priv law only	Limited to all steps up to and including the final hearing save in the event of a Court and Family Reporter's/Children's Guardian's report unfavourable to the client, in which case the certificate is thereafter limited to a Solicitor's report or, if the Solicitor so advises, external Counsel's opinion or the opinion of an external solicitor with higher court advocacy rights on the merits of the matter continuing on a contested basis.	t	t	2022-08-09 15:00:33.706494	2022-08-09 15:00:33.706494
8746a320-9089-4730-9599-500dfc177417	FM049	Hearing-children	Limited to all steps up to and including trial/final hearing and any action necessary to implement (but not enforce) the judgment or order.	t	t	2022-08-09 15:00:33.708811	2022-08-09 15:00:33.708811
fa374848-082d-456e-beb0-96c7679e17fa	FM054	Overseas applicant (forced marriage)	Limited where the applicant is overseas, to their return to the jurisdiction and thereafter a solicitor's report	t	t	2022-08-09 15:00:33.710677	2022-08-09 15:00:33.710677
2a4e032b-5b1c-4835-8897-8a49f0eb4f0e	FM059	FHH Children	Limited to Family Help (Higher) and to all steps necessary to negotiate and conclude a settlement. To include the issue of proceedings and representation in those proceedings save in relation to or at a contested final hearing.	t	f	2022-08-09 15:00:33.712879	2022-08-09 15:00:33.712879
9161a7f7-e44f-49af-9eeb-e77954903d40	FM062	Final hearing	Limited to all steps up to and including final hearing and any action necessary to implement (but not enforce) the order.	t	f	2022-08-09 15:00:33.714742	2022-08-09 15:00:33.714742
86e10222-600f-4493-a5ab-b6cfbe54a796	MC029	Further Directions/Liberty to apply	Limited to an application for further directions pursuant to a provision allowing liberty to apply including steps to negotiate any settlement and complying with further directions.	t	t	2022-08-09 15:00:33.716937	2022-08-09 15:00:33.716937
\.


--
-- Data for Name: scope_user_inputs; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.scope_user_inputs (id, input_name, input_type, mandatory, created_at, updated_at) FROM stdin;
40485049-1d81-4246-bbf7-5ca3c4cc6ca3	hearing_date	date	t	2022-08-09 15:20:32.576667	2022-08-09 15:20:32.576667
1fd27ded-7c7c-4d51-9c58-37d3b9a49194	limitation_note	text	t	2022-08-09 15:20:32.582093	2022-08-09 15:20:32.582093
\.


--
-- Data for Name: service_levels; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.service_levels (id, level, name, stage, created_at, updated_at) FROM stdin;
4935523e-8066-43ff-858d-18895742ad8e	3	Full Representation	8	2022-08-09 15:00:34.417512	2022-08-09 15:00:34.417512
4d4c7713-03dd-45b7-9ea3-f9d4d596fd29	1	Family Help (Higher)	1	2022-08-09 15:00:34.462697	2022-08-09 15:00:34.462697
\.


--
-- Data for Name: task_dependencies; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.task_dependencies (id, merits_task_id, dependency_id, created_at, updated_at) FROM stdin;
4	812d924b-d17a-4c0b-bcb9-e1e62accb335	35f7f31e-655b-4ed7-8dc2-fa4d9a1a5e72	2022-08-09 15:20:32.48821	2022-08-09 15:20:32.48821
\.


--
-- Data for Name: threshold_waivers; Type: TABLE DATA; Schema: public; Owner: stephenrichards
--

COPY public.threshold_waivers (id, client_involvement_type_id, matter_type_id, gross_income_upper, disposable_income_upper, capital_upper, created_at, updated_at) FROM stdin;
1	3a5a1cf6-00fe-4b81-b271-440998421d92	2a8e4621-8d2c-4d74-815c-89f5879a5038	t	t	t	2022-08-09 15:00:34.76758	2022-08-09 15:00:34.788647
\.


--
-- Name: request_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stephenrichards
--

SELECT pg_catalog.setval('public.request_histories_id_seq', 18, true);


--
-- Name: scope_limitation_user_inputs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stephenrichards
--

SELECT pg_catalog.setval('public.scope_limitation_user_inputs_id_seq', 58, true);


--
-- Name: task_dependencies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stephenrichards
--

SELECT pg_catalog.setval('public.task_dependencies_id_seq', 4, true);


--
-- Name: threshold_waivers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stephenrichards
--

SELECT pg_catalog.setval('public.threshold_waivers_id_seq', 1, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: client_involvement_types client_involvement_types_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.client_involvement_types
    ADD CONSTRAINT client_involvement_types_pkey PRIMARY KEY (id);


--
-- Name: default_cost_limitations default_cost_limitations_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.default_cost_limitations
    ADD CONSTRAINT default_cost_limitations_pkey PRIMARY KEY (id);


--
-- Name: matter_types matter_types_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.matter_types
    ADD CONSTRAINT matter_types_pkey PRIMARY KEY (id);


--
-- Name: merits_tasks merits_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.merits_tasks
    ADD CONSTRAINT merits_tasks_pkey PRIMARY KEY (id);


--
-- Name: proceeding_type_merits_tasks proceeding_type_merits_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.proceeding_type_merits_tasks
    ADD CONSTRAINT proceeding_type_merits_tasks_pkey PRIMARY KEY (id);


--
-- Name: proceeding_type_scope_limitations proceeding_type_scope_limitations_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.proceeding_type_scope_limitations
    ADD CONSTRAINT proceeding_type_scope_limitations_pkey PRIMARY KEY (id);


--
-- Name: proceeding_type_scopes proceeding_type_scopes_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.proceeding_type_scopes
    ADD CONSTRAINT proceeding_type_scopes_pkey PRIMARY KEY (id);


--
-- Name: proceeding_type_service_levels proceeding_type_service_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.proceeding_type_service_levels
    ADD CONSTRAINT proceeding_type_service_levels_pkey PRIMARY KEY (id);


--
-- Name: proceeding_types proceeding_types_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.proceeding_types
    ADD CONSTRAINT proceeding_types_pkey PRIMARY KEY (id);


--
-- Name: request_histories request_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.request_histories
    ADD CONSTRAINT request_histories_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: scope_limitation_user_inputs scope_limitation_user_inputs_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.scope_limitation_user_inputs
    ADD CONSTRAINT scope_limitation_user_inputs_pkey PRIMARY KEY (id);


--
-- Name: scope_limitations scope_limitations_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.scope_limitations
    ADD CONSTRAINT scope_limitations_pkey PRIMARY KEY (id);


--
-- Name: scope_user_inputs scope_user_inputs_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.scope_user_inputs
    ADD CONSTRAINT scope_user_inputs_pkey PRIMARY KEY (id);


--
-- Name: service_levels service_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.service_levels
    ADD CONSTRAINT service_levels_pkey PRIMARY KEY (id);


--
-- Name: task_dependencies task_dependencies_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.task_dependencies
    ADD CONSTRAINT task_dependencies_pkey PRIMARY KEY (id);


--
-- Name: threshold_waivers threshold_waivers_pkey; Type: CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.threshold_waivers
    ADD CONSTRAINT threshold_waivers_pkey PRIMARY KEY (id);


--
-- Name: index_default_cost_limitations_on_proceeding_type_id; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX index_default_cost_limitations_on_proceeding_type_id ON public.default_cost_limitations USING btree (proceeding_type_id);


--
-- Name: index_default_cost_limitations_unique_on_cost_date_and_type; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE UNIQUE INDEX index_default_cost_limitations_unique_on_cost_date_and_type ON public.default_cost_limitations USING btree (proceeding_type_id, cost_type, start_date);


--
-- Name: index_matter_types_on_name; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE UNIQUE INDEX index_matter_types_on_name ON public.matter_types USING btree (name);


--
-- Name: index_proceeding_type_merits_tasks_on_proceeding_type_id; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX index_proceeding_type_merits_tasks_on_proceeding_type_id ON public.proceeding_type_merits_tasks USING btree (proceeding_type_id);


--
-- Name: index_proceeding_type_scope_limitations_on_proceeding_type_id; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX index_proceeding_type_scope_limitations_on_proceeding_type_id ON public.proceeding_type_scope_limitations USING btree (proceeding_type_id);


--
-- Name: index_proceeding_type_scope_limitations_on_scope_limitation_id; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX index_proceeding_type_scope_limitations_on_scope_limitation_id ON public.proceeding_type_scope_limitations USING btree (scope_limitation_id);


--
-- Name: index_proceeding_type_service_levels_on_proceeding_type_id; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX index_proceeding_type_service_levels_on_proceeding_type_id ON public.proceeding_type_service_levels USING btree (proceeding_type_id);


--
-- Name: index_proceeding_type_service_levels_on_service_level_id; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX index_proceeding_type_service_levels_on_service_level_id ON public.proceeding_type_service_levels USING btree (service_level_id);


--
-- Name: index_proceedings_scopes_unique_delegated_default; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE UNIQUE INDEX index_proceedings_scopes_unique_delegated_default ON public.proceeding_type_scope_limitations USING btree (proceeding_type_id, delegated_functions_default) WHERE (delegated_functions_default = true);


--
-- Name: index_proceedings_scopes_unique_on_ids; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE UNIQUE INDEX index_proceedings_scopes_unique_on_ids ON public.proceeding_type_scope_limitations USING btree (proceeding_type_id, scope_limitation_id);


--
-- Name: index_proceedings_scopes_unique_substantive_default; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE UNIQUE INDEX index_proceedings_scopes_unique_substantive_default ON public.proceeding_type_scope_limitations USING btree (proceeding_type_id, substantive_default) WHERE (substantive_default = true);


--
-- Name: index_proceedings_service_levels_unique_default; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE UNIQUE INDEX index_proceedings_service_levels_unique_default ON public.proceeding_type_service_levels USING btree (proceeding_type_id, proceeding_default) WHERE (proceeding_default = true);


--
-- Name: index_proceedings_service_levels_unique_on_ids; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE UNIQUE INDEX index_proceedings_service_levels_unique_on_ids ON public.proceeding_type_service_levels USING btree (proceeding_type_id, service_level_id);


--
-- Name: index_scope_limitation_user_inputs_on_scope_limitation_id; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX index_scope_limitation_user_inputs_on_scope_limitation_id ON public.scope_limitation_user_inputs USING btree (scope_limitation_id);


--
-- Name: index_scope_limitation_user_inputs_on_scope_user_input_id; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX index_scope_limitation_user_inputs_on_scope_user_input_id ON public.scope_limitation_user_inputs USING btree (scope_user_input_id);


--
-- Name: index_scope_limitations_on_code; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX index_scope_limitations_on_code ON public.scope_limitations USING btree (code);


--
-- Name: index_scope_user_inputs_on_input_name; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE UNIQUE INDEX index_scope_user_inputs_on_input_name ON public.scope_user_inputs USING btree (input_name);


--
-- Name: index_service_levels_unique_on_level; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE UNIQUE INDEX index_service_levels_unique_on_level ON public.service_levels USING btree (level);


--
-- Name: index_threshold_waivers_on_client_involvement_and_matter_types; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE UNIQUE INDEX index_threshold_waivers_on_client_involvement_and_matter_types ON public.threshold_waivers USING btree (client_involvement_type_id, matter_type_id);


--
-- Name: index_threshold_waivers_on_client_involvement_type_id; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX index_threshold_waivers_on_client_involvement_type_id ON public.threshold_waivers USING btree (client_involvement_type_id);


--
-- Name: index_threshold_waivers_on_matter_type_id; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX index_threshold_waivers_on_matter_type_id ON public.threshold_waivers USING btree (matter_type_id);


--
-- Name: pt_sl_cit_df_idx; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX pt_sl_cit_df_idx ON public.proceeding_type_scopes USING btree (proceeding_type_ccms_code, service_level, client_involvement_type_code, df_used);


--
-- Name: textsearch_idx; Type: INDEX; Schema: public; Owner: stephenrichards
--

CREATE INDEX textsearch_idx ON public.proceeding_types USING gin (textsearchable);


--
-- Name: threshold_waivers fk_rails_1b8d6e0a4f; Type: FK CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.threshold_waivers
    ADD CONSTRAINT fk_rails_1b8d6e0a4f FOREIGN KEY (client_involvement_type_id) REFERENCES public.client_involvement_types(id);


--
-- Name: proceeding_type_service_levels fk_rails_37fa388bf2; Type: FK CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.proceeding_type_service_levels
    ADD CONSTRAINT fk_rails_37fa388bf2 FOREIGN KEY (service_level_id) REFERENCES public.service_levels(id);


--
-- Name: proceeding_type_scope_limitations fk_rails_53a706d311; Type: FK CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.proceeding_type_scope_limitations
    ADD CONSTRAINT fk_rails_53a706d311 FOREIGN KEY (scope_limitation_id) REFERENCES public.scope_limitations(id);


--
-- Name: proceeding_type_service_levels fk_rails_79fb889b85; Type: FK CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.proceeding_type_service_levels
    ADD CONSTRAINT fk_rails_79fb889b85 FOREIGN KEY (proceeding_type_id) REFERENCES public.proceeding_types(id);


--
-- Name: default_cost_limitations fk_rails_c42d332697; Type: FK CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.default_cost_limitations
    ADD CONSTRAINT fk_rails_c42d332697 FOREIGN KEY (proceeding_type_id) REFERENCES public.proceeding_types(id);


--
-- Name: threshold_waivers fk_rails_dce3a6252f; Type: FK CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.threshold_waivers
    ADD CONSTRAINT fk_rails_dce3a6252f FOREIGN KEY (matter_type_id) REFERENCES public.matter_types(id);


--
-- Name: proceeding_type_scope_limitations fk_rails_f3012603ed; Type: FK CONSTRAINT; Schema: public; Owner: stephenrichards
--

ALTER TABLE ONLY public.proceeding_type_scope_limitations
    ADD CONSTRAINT fk_rails_f3012603ed FOREIGN KEY (proceeding_type_id) REFERENCES public.proceeding_types(id);


--
-- PostgreSQL database dump complete
--

