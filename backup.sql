--
-- PostgreSQL database dump
--

\restrict v6R9PbAVFc1ldshbefv40oTu5l6td3k3U9JFocaYvItohUnHLegfNtVC1AI9H2u

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: card_photos; Type: TABLE; Schema: public; Owner: yugioh
--

CREATE TABLE public.card_photos (
    id integer NOT NULL,
    card_id integer NOT NULL,
    filename character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    user_id integer
);


ALTER TABLE public.card_photos OWNER TO yugioh;

--
-- Name: card_photos_id_seq; Type: SEQUENCE; Schema: public; Owner: yugioh
--

CREATE SEQUENCE public.card_photos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_photos_id_seq OWNER TO yugioh;

--
-- Name: card_photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugioh
--

ALTER SEQUENCE public.card_photos_id_seq OWNED BY public.card_photos.id;


--
-- Name: card_sets; Type: TABLE; Schema: public; Owner: yugioh
--

CREATE TABLE public.card_sets (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(255) NOT NULL,
    order_index integer NOT NULL
);


ALTER TABLE public.card_sets OWNER TO yugioh;

--
-- Name: card_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: yugioh
--

CREATE SEQUENCE public.card_sets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_sets_id_seq OWNER TO yugioh;

--
-- Name: card_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugioh
--

ALTER SEQUENCE public.card_sets_id_seq OWNED BY public.card_sets.id;


--
-- Name: cards; Type: TABLE; Schema: public; Owner: yugioh
--

CREATE TABLE public.cards (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    card_code character varying(20) NOT NULL,
    set_id integer NOT NULL,
    wiki_url character varying(500),
    passcode integer
);


ALTER TABLE public.cards OWNER TO yugioh;

--
-- Name: cards_id_seq; Type: SEQUENCE; Schema: public; Owner: yugioh
--

CREATE SEQUENCE public.cards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cards_id_seq OWNER TO yugioh;

--
-- Name: cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugioh
--

ALTER SEQUENCE public.cards_id_seq OWNED BY public.cards.id;


--
-- Name: collection; Type: TABLE; Schema: public; Owner: yugioh
--

CREATE TABLE public.collection (
    id integer NOT NULL,
    card_id integer NOT NULL,
    owned boolean DEFAULT false NOT NULL,
    edition smallint,
    condition smallint,
    is_ultimate boolean DEFAULT false NOT NULL,
    notes character varying(1000),
    user_id integer,
    language smallint
);


ALTER TABLE public.collection OWNER TO yugioh;

--
-- Name: collection_id_seq; Type: SEQUENCE; Schema: public; Owner: yugioh
--

CREATE SEQUENCE public.collection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collection_id_seq OWNER TO yugioh;

--
-- Name: collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugioh
--

ALTER SEQUENCE public.collection_id_seq OWNED BY public.collection.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: yugioh
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO yugioh;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: yugioh
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO yugioh;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugioh
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: card_photos id; Type: DEFAULT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.card_photos ALTER COLUMN id SET DEFAULT nextval('public.card_photos_id_seq'::regclass);


--
-- Name: card_sets id; Type: DEFAULT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.card_sets ALTER COLUMN id SET DEFAULT nextval('public.card_sets_id_seq'::regclass);


--
-- Name: cards id; Type: DEFAULT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.cards ALTER COLUMN id SET DEFAULT nextval('public.cards_id_seq'::regclass);


--
-- Name: collection id; Type: DEFAULT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.collection ALTER COLUMN id SET DEFAULT nextval('public.collection_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: card_photos; Type: TABLE DATA; Schema: public; Owner: yugioh
--

COPY public.card_photos (id, card_id, filename, created_at, user_id) FROM stdin;
\.


--
-- Data for Name: card_sets; Type: TABLE DATA; Schema: public; Owner: yugioh
--

COPY public.card_sets (id, code, name, order_index) FROM stdin;
1	LOB	Legend of Blue Eyes White Dragon	1
2	MRD	Metal Raiders	2
3	SRL	Spell Ruler	3
4	PSV	Pharaoh Servant	4
5	LON	Labyrinth of Nightmare	5
6	LOD	Legacy of Darkness	6
7	PGD	Pharaonic Guardian	7
8	MFC	Magician Force	8
9	DCR	Dark Crisis	9
10	IOC	Invasion of Chaos	10
11	AST	Ancient Sanctuary	11
12	SOD	Soul of the Duelist	12
13	RDS	Rise of Destiny	13
14	FET	Flaming Eternity	14
15	TLM	The Lost Millennium	15
\.


--
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: yugioh
--

COPY public.cards (id, name, card_code, set_id, wiki_url, passcode) FROM stdin;
9	Insecto básico	LOB-EN008	1	https://yugipedia.com/wiki/Insecto_básico	89091579
42	Colmillos de bestia	LOB-EN041	1	https://yugipedia.com/wiki/Colmillos_de_bestia	46009906
65	Guerrero castor	LOB-EN064	1	https://yugipedia.com/wiki/Guerrero_castor	32452818
44	El libro de las artes secretas	LOB-EN043	1	https://yugipedia.com/wiki/El_libro_de_las_artes_secretas	91595718
8	Guardián Celta	LOB-EN007	1	https://yugipedia.com/wiki/Guardián_Celta	91152256
16	Charubin, el Caballero del Fuego	LOB-EN015	1	https://yugipedia.com/wiki/Charubin,_el_Caballero_del_Fuego	37421579
67	Maldición del Dragón	LOB-EN066	1	https://yugipedia.com/wiki/Maldición_del_Dragón	28279543
12	Gris oscuro	LOB-EN011	1	https://yugipedia.com/wiki/Gris_oscuro	9159938
53	Agujero oscuro	LOB-EN052	1	https://yugipedia.com/wiki/Agujero_oscuro	53129443
21	El Rey Oscuro del Abismo	LOB-EN020	1	https://yugipedia.com/wiki/El_Rey_Oscuro_del_Abismo	53375573
6	Mago Oscuro	LOB-EN005	1	https://yugipedia.com/wiki/Mago_Oscuro	36996508
20	Dragón de Fuego Oscuro	LOB-EN019	1	https://yugipedia.com/wiki/Dragón_de_Fuego_Oscuro	17881964
32	Dissolverock	LOB-EN031	1	https://yugipedia.com/wiki/Dissolverock	40826495
22	Reflexión del demonio #2	LOB-EN021	1	https://yugipedia.com/wiki/Reflexión_del_demonio_#2	2863439
19	Hierba de fuego	LOB-EN018	1	https://yugipedia.com/wiki/Hierba_de_fuego	53293545
58	Fisura	LOB-EN057	1	https://yugipedia.com/wiki/Fisura	66788016
30	Fantasma de llamas	LOB-EN029	1	https://yugipedia.com/wiki/Fantasma_de_llamas	58528964
17	Manipulador de llamas	LOB-EN016	1	https://yugipedia.com/wiki/Manipulador_de_llamas	34460851
4	Espadachín de llamas	LOB-EN003	1	https://yugipedia.com/wiki/Espadachín_de_llamas	45231177
47	Bosque	LOB-EN046	1	https://yugipedia.com/wiki/Bosque	87430998
23	Fusionista	LOB-EN022	1	https://yugipedia.com/wiki/Fusionista	1641882
7	Gaia, la caballero feroz	LOB-EN006	1	https://yugipedia.com/wiki/Gaia,_la_caballero_feroz	6368038
69	Soldado Gigante de Piedra	LOB-EN068	1	https://yugipedia.com/wiki/Soldado_Gigante_de_Piedra	13039848
66	Negruzco sepulturero	LOB-EN065	1	https://yugipedia.com/wiki/Negruzco_sepulturero	82542267
35	Rey Fantasma Verde	LOB-EN034	1	https://yugipedia.com/wiki/Rey_Fantasma_Verde	22910685
57	Hinotama	LOB-EN056	1	https://yugipedia.com/wiki/Hinotama	46130346
27	Alma de Hinotama	LOB-EN026	1	https://yugipedia.com/wiki/Alma_de_Hinotama	96851799
3	Gigante Hitotsu-Me	LOB-EN002	1	https://yugipedia.com/wiki/Gigante_Hitotsu-Me	76184692
68	Guerrero Karbonala	LOB-EN067	1	https://yugipedia.com/wiki/Guerrero_Karbonala	54541900
37	El Rey de la Niebla	LOB-EN036	1	https://yugipedia.com/wiki/El_Rey_de_la_Niebla	84686841
40	Kurama	LOB-EN039	1	https://yugipedia.com/wiki/Kurama	85705804
41	Espada legendaria	LOB-EN040	1	https://yugipedia.com/wiki/Espada_legendaria	61854111
10	Cementerio de Mamuts	LOB-EN009	1	https://yugipedia.com/wiki/Cementerio_de_Mamuts	40374923
39	Masaki, el espadachín legendario	LOB-EN038	1	https://yugipedia.com/wiki/Masaki,_el_espadachín_legendario	44287299
18	Huevo de monstruo	LOB-EN017	1	https://yugipedia.com/wiki/Huevo_de_monstruo	36121917
49	Montaña	LOB-EN048	1	https://yugipedia.com/wiki/Montaña	50913601
63	Elfo místico	LOB-EN062	1	https://yugipedia.com/wiki/Elfo_místico	15025844
38	Oveja Mística #2	LOB-EN037	1	https://yugipedia.com/wiki/Oveja_Mística_#2	83464209
14	Nemuriko	LOB-EN013	1	https://yugipedia.com/wiki/Nemuriko	90963488
26	Pequeño ángel	LOB-EN025	1	https://yugipedia.com/wiki/Pequeño_ángel	38142739
25	Pequeño Dragón	LOB-EN024	1	https://yugipedia.com/wiki/Pequeño_Dragón	75356564
60	Polimerización	LOB-EN059	1	https://yugipedia.com/wiki/Polimerización	24094653
54	Raigeki	LOB-EN053	1	https://yugipedia.com/wiki/Raigeki	12580477
36	Rayos y temperatura	LOB-EN035	1	https://yugipedia.com/wiki/Rayos_y_temperatura	85309439
72	El segador de las cartas	LOB-EN071	1	https://yugipedia.com/wiki/El_segador_de_las_cartas	33066139
55	Medicina Roja	LOB-EN054	1	https://yugipedia.com/wiki/Medicina_Roja	38199696
71	Dragón Negro de Ojos Rojos	LOB-EN070	1	https://yugipedia.com/wiki/Dragón_Negro_de_Ojos_Rojos	74677422
61	Quitar trampa	LOB-EN060	1	https://yugipedia.com/wiki/Quitar_trampa	51482758
33	Agua de raíz	LOB-EN032	1	https://yugipedia.com/wiki/Agua_de_raíz	39004808
11	Colmillo de Plata	LOB-EN010	1	https://yugipedia.com/wiki/Colmillo_de_Plata	90357090
5	Sirviente de la calavera	LOB-EN004	1	https://yugipedia.com/wiki/Sirviente_de_la_calavera	32274490
50	Sogen	LOB-EN049	1	https://yugipedia.com/wiki/Sogen	86318356
56	Chispas	LOB-EN055	1	https://yugipedia.com/wiki/Chispas	76103675
15	La decimotercera tumba	LOB-EN014	1	https://yugipedia.com/wiki/La_decimotercera_tumba	32864
59	Agujero de Trampa	LOB-EN058	1	https://yugipedia.com/wiki/Agujero_de_Trampa	4206964
1	Dragón de tres cuernos	LOB-EN000	1	https://yugipedia.com/wiki/Dragón_de_tres_cuernos	39111158
13	El juicio de la pesadilla	LOB-EN012	1	https://yugipedia.com/wiki/El_juicio_de_la_pesadilla	77827521
24	Tortuga Tigre	LOB-EN023	1	https://yugipedia.com/wiki/Tortuga_Tigre	37313348
31	Doble boca Darkruler	LOB-EN030	1	https://yugipedia.com/wiki/Doble_boca_Darkruler	57305373
62	Ataque de dos frentes	LOB-EN061	1	https://yugipedia.com/wiki/Ataque_de_dos_frentes	83887306
64	Tyhone	LOB-EN063	1	https://yugipedia.com/wiki/Tyhone	72842870
51	Umi	LOB-EN050	1	https://yugipedia.com/wiki/Umi	22702055
70	Uraby	LOB-EN069	1	https://yugipedia.com/wiki/Uraby	1784619
43	Cristal violeta	LOB-EN042	1	https://yugipedia.com/wiki/Cristal_violeta	15052462
48	Tierra baldía	LOB-EN047	1	https://yugipedia.com/wiki/Tierra_baldía	23424603
52	Yami	LOB-EN051	1	https://yugipedia.com/wiki/Yami	59197169
107	Ninja armado	LOB-EN106	1	https://yugipedia.com/wiki/Ninja_armado	9076207
89	Energía oscura	LOB-EN088	1	https://yugipedia.com/wiki/Energía_oscura	4614116
115	Espinas del Mundo Oscuro	LOB-EN114	1	https://yugipedia.com/wiki/Espinas_del_Mundo_Oscuro	43500484
93	Tesoro del Dragón	LOB-EN092	1	https://yugipedia.com/wiki/Tesoro_del_Dragón	1435851
87	La Dragonesa, la Caballera Malvada	LOB-EN086	1	https://yugipedia.com/wiki/La_Dragonesa,_la_Caballera_Malvada	70681994
116	Lagarto babeante	LOB-EN115	1	https://yugipedia.com/wiki/Lagarto_babeante	16353197
85	Sirena encantadora	LOB-EN084	1	https://yugipedia.com/wiki/Sirena_encantadora	75376965
94	Látigo eléctrico	LOB-EN093	1	https://yugipedia.com/wiki/Látigo_eléctrico	37820550
125	Exodia, la Prohibida	LOB-EN124	1	https://yugipedia.com/wiki/Exodia,_la_Prohibida	33396948
101	Llama final	LOB-EN100	1	https://yugipedia.com/wiki/Llama_final	73134081
86	Fireyarou	LOB-EN085	1	https://yugipedia.com/wiki/Fireyarou	71407486
108	Flor Lobo	LOB-EN107	1	https://yugipedia.com/wiki/Flor_Lobo	95952802
82	Panda frenético	LOB-EN081	1	https://yugipedia.com/wiki/Panda_frenético	98818516
126	Gaia, la Campeona Dragón	LOB-EN125	1	https://yugipedia.com/wiki/Gaia,_la_Campeona_Dragón	66889139
100	El remedio secreto del duende	LOB-EN099	1	https://yugipedia.com/wiki/El_remedio_secreto_del_duende	11868825
111	Hane-Hane	LOB-EN110	1	https://yugipedia.com/wiki/Hane-Hane	7089711
75	Armadura dura	LOB-EN074	1	https://yugipedia.com/wiki/Armadura_dura	20060230
83	Kumootoko	LOB-EN082	1	https://yugipedia.com/wiki/Kumootoko	56283725
74	Larvas	LOB-EN073	1	https://yugipedia.com/wiki/Larvas	94675535
90	Armadura de cañón láser	LOB-EN089	1	https://yugipedia.com/wiki/Armadura_de_cañón_láser	77007920
124	El brazo izquierdo del Prohibido	LOB-EN123	1	https://yugipedia.com/wiki/El_brazo_izquierdo_del_Prohibido	7902349
114	Dragón menor	LOB-EN113	1	https://yugipedia.com/wiki/Dragón_menor	55444629
77	Guerrero M #1	LOB-EN076	1	https://yugipedia.com/wiki/Guerrero_M_#1	56342351
78	Guerrero M n.° 2	LOB-EN077	1	https://yugipedia.com/wiki/Guerrero_M_n.°_2	92731455
97	Fábrica de conversión de máquinas	LOB-EN096	1	https://yugipedia.com/wiki/Fábrica_de_conversión_de_máquinas	25769732
76	Devorador de hombres	LOB-EN075	1	https://yugipedia.com/wiki/Devorador_de_hombres	93553943
109	Bicho devorador de hombres	LOB-EN108	1	https://yugipedia.com/wiki/Bicho_devorador_de_hombres	54652250
84	Meda Bat	LOB-EN083	1	https://yugipedia.com/wiki/Meda_Bat	76211194
103	Dragón de Metal	LOB-EN102	1	https://yugipedia.com/wiki/Dragón_de_Metal	9293977
112	Misairuzame	LOB-EN111	1	https://yugipedia.com/wiki/Misairuzame	33178416
119	Monstruo Renacido	LOB-EN118	1	https://yugipedia.com/wiki/Monstruo_Renacido	83764718
95	Luna Mística	LOB-EN094	1	https://yugipedia.com/wiki/Luna_Mística	36607978
88	Dragón Escudo de un Ojo	LOB-EN087	1	https://yugipedia.com/wiki/Dragón_Escudo_de_un_Ojo	33064647
120	Olla de la Avaricia	LOB-EN119	1	https://yugipedia.com/wiki/Olla_de_la_Avaricia	55144522
123	El brazo derecho del Prohibido	LOB-EN122	1	https://yugipedia.com/wiki/El_brazo_derecho_del_Prohibido	70903634
98	Aumenta la temperatura corporal	LOB-EN097	1	https://yugipedia.com/wiki/Aumenta_la_temperatura_corporal	51267887
110	Piedra arenisca	LOB-EN109	1	https://yugipedia.com/wiki/Piedra_arenisca	73051941
92	Arco y flecha de plata	LOB-EN091	1	https://yugipedia.com/wiki/Arco_y_flecha_de_plata	1557499
106	Cráneo pájaro rojo	LOB-EN105	1	https://yugipedia.com/wiki/Cráneo_pájaro_rojo	10202894
104	Spike Seadra	LOB-EN103	1	https://yugipedia.com/wiki/Spike_Seadra	85326399
79	El espíritu del arpa	LOB-EN078	1	https://yugipedia.com/wiki/El_espíritu_del_arpa	80770678
113	Gruta del Ogro de Acero n.° 1	LOB-EN112	1	https://yugipedia.com/wiki/Gruta_del_Ogro_de_Acero_n.°_1	29172562
96	Detener la defensa	LOB-EN095	1	https://yugipedia.com/wiki/Detener_la_defensa	63102017
118	Caballero súcubo	LOB-EN117	1	https://yugipedia.com/wiki/Caballero_súcubo	55291359
102	Espadas de Luz Reveladora	LOB-EN101	1	https://yugipedia.com/wiki/Espadas_de_Luz_Reveladora	72302403
81	Terra la Terrible	LOB-EN080	1	https://yugipedia.com/wiki/Terra_la_Terrible	63308047
105	La Bestia de la Trampa	LOB-EN104	1	https://yugipedia.com/wiki/La_Bestia_de_la_Trampa	45042329
91	Gérmenes viles	LOB-EN090	1	https://yugipedia.com/wiki/Gérmenes_viles	39774685
73	Fantasma ingenioso	LOB-EN072	1	https://yugipedia.com/wiki/Fantasma_ingenioso	36304921
132	Armored Lizard	MRD-EN005	2	https://yugipedia.com/wiki/MRD-EN005	15480588
140	Armored Zombie	MRD-EN013	2	https://yugipedia.com/wiki/MRD-EN013	20277860
139	Crawling Dragon	MRD-EN012	2	https://yugipedia.com/wiki/MRD-EN012	67494157
138	Cocoon of Evolution	MRD-EN011	2	https://yugipedia.com/wiki/MRD-EN011	40240595
142	Doma The Angel of Silence	MRD-EN015	2	https://yugipedia.com/wiki/MRD-EN015	16972957
128	Feral Imp	MRD-EN001	2	https://yugipedia.com/wiki/MRD-EN001	41392891
127	Gate Guardian	MRD-EN000	2	https://yugipedia.com/wiki/MRD-EN000	25833572
135	Harpie Lady	MRD-EN008	2	https://yugipedia.com/wiki/MRD-EN008	76812113
133	Killer Needle	MRD-EN006	2	https://yugipedia.com/wiki/MRD-EN006	88979991
137	Kojikocy	MRD-EN010	2	https://yugipedia.com/wiki/MRD-EN010	1184620
134	Larvae Moth	MRD-EN007	2	https://yugipedia.com/wiki/MRD-EN007	87756343
141	Mask of Darkness	MRD-EN014	2	https://yugipedia.com/wiki/MRD-EN014	28933734
131	Rock Ogre Grotto #1	MRD-EN004	2	https://yugipedia.com/wiki/MRD-EN004	68846917
130	Summoned Skull	MRD-EN003	2	https://yugipedia.com/wiki/MRD-EN003	70781052
143	White Magical Hat	MRD-EN016	2	https://yugipedia.com/wiki/MRD-EN016	15150365
129	Winged Dragon, Guardian of the Fortress #1	MRD-EN002	2	https://yugipedia.com/wiki/MRD-EN002	87796900
177	Ancient Lizard Warrior	MRD-EN050	2	https://yugipedia.com/wiki/MRD-EN050	43230671
188	Baby Dragon	MRD-EN061	2	https://yugipedia.com/wiki/MRD-EN061	88819587
191	Battle Steer	MRD-EN064	2	https://yugipedia.com/wiki/MRD-EN064	18246479
220	Bickuribox	MRD-EN093	2	https://yugipedia.com/wiki/MRD-EN093	25655502
144	Big Eye	MRD-EN017	2	https://yugipedia.com/wiki/MRD-EN017	16768387
145	B. Skull Dragon	MRD-EN018	2	https://yugipedia.com/wiki/MRD-EN018	11901678
189	Blackland Fire Dragon	MRD-EN062	2	https://yugipedia.com/wiki/MRD-EN062	87564352
161	Blast Juggler	MRD-EN034	2	https://yugipedia.com/wiki/MRD-EN034	70138455
166	Bottom Dweller	MRD-EN039	2	https://yugipedia.com/wiki/MRD-EN039	81386177
200	Castle of Dark Illusions	MRD-EN073	2	https://yugipedia.com/wiki/MRD-EN073	62121
202	Catapult Turtle	MRD-EN075	2	https://yugipedia.com/wiki/MRD-EN075	95727991
187	Change of Heart	MRD-EN060	2	https://yugipedia.com/wiki/MRD-EN060	4031928
205	Crass Clown	MRD-EN078	2	https://yugipedia.com/wiki/MRD-EN078	93889755
167	Destroyer Golem	MRD-EN040	2	https://yugipedia.com/wiki/MRD-EN040	73481154
180	Disk Magician	MRD-EN053	2	https://yugipedia.com/wiki/MRD-EN053	76446915
194	Dragon Piper	MRD-EN067	2	https://yugipedia.com/wiki/MRD-EN067	55763552
207	Dream Clown	MRD-EN080	2	https://yugipedia.com/wiki/MRD-EN080	13215230
175	Electric Lizard	MRD-EN048	2	https://yugipedia.com/wiki/MRD-EN048	55875323
151	Elegant Egotist	MRD-EN024	2	https://yugipedia.com/wiki/MRD-EN024	90219263
173	Empress Judge	MRD-EN046	2	https://yugipedia.com/wiki/MRD-EN046	15237615
183	Fake Trap	MRD-EN056	2	https://yugipedia.com/wiki/MRD-EN056	3027001
221	Giltia the D. Knight	MRD-EN094	2	https://yugipedia.com/wiki/MRD-EN094	51828629
197	Great Moth	MRD-EN070	2	https://yugipedia.com/wiki/MRD-EN070	14141448
210	Guardian of the Labyrinth	MRD-EN083	2	https://yugipedia.com/wiki/MRD-EN083	89272878
182	Hibikime	MRD-EN055	2	https://yugipedia.com/wiki/MRD-EN055	64501875
176	Hunter Spider	MRD-EN049	2	https://yugipedia.com/wiki/MRD-EN049	80141480
181	Hyosube	MRD-EN054	2	https://yugipedia.com/wiki/MRD-EN054	2118022
195	Illusionist Faceless Mage	MRD-EN068	2	https://yugipedia.com/wiki/MRD-EN068	28546905
199	Jellyfish	MRD-EN072	2	https://yugipedia.com/wiki/MRD-EN072	14851496
162	Jinzo #7	MRD-EN035	2	https://yugipedia.com/wiki/MRD-EN035	32809211
216	Jirai Gumo	MRD-EN089	2	https://yugipedia.com/wiki/MRD-EN089	94773007
168	Kaminari Attack	MRD-EN041	2	https://yugipedia.com/wiki/MRD-EN041	9653271
153	Kazejin	MRD-EN026	2	https://yugipedia.com/wiki/MRD-EN026	62340868
201	King of Yamimakai	MRD-EN074	2	https://yugipedia.com/wiki/MRD-EN074	69455834
198	Kuriboh	MRD-EN071	2	https://yugipedia.com/wiki/MRD-EN071	40640057
218	Labyrinth Tank	MRD-EN091	2	https://yugipedia.com/wiki/MRD-EN091	99551425
158	Leghul	MRD-EN031	2	https://yugipedia.com/wiki/MRD-EN031	12472242
160	Leogun	MRD-EN033	2	https://yugipedia.com/wiki/MRD-EN033	10538007
163	Magician of Faith	MRD-EN036	2	https://yugipedia.com/wiki/MRD-EN036	31560081
146	Masked Sorcerer	MRD-EN019	2	https://yugipedia.com/wiki/MRD-EN019	10189126
171	Mega Thunderball	MRD-EN044	2	https://yugipedia.com/wiki/MRD-EN044	21817254
170	Morinphen	MRD-EN043	2	https://yugipedia.com/wiki/MRD-EN043	55784832
203	Mystic Horseman	MRD-EN076	2	https://yugipedia.com/wiki/MRD-EN076	68516705
155	Mystic Lamp	MRD-EN028	2	https://yugipedia.com/wiki/MRD-EN028	98049915
157	Ocubeam	MRD-EN030	2	https://yugipedia.com/wiki/MRD-EN030	86088138
159	Ooguchi	MRD-EN032	2	https://yugipedia.com/wiki/MRD-EN032	58861941
150	Petit Moth	MRD-EN023	2	https://yugipedia.com/wiki/MRD-EN023	58192742
211	Prevent Rat	MRD-EN084	2	https://yugipedia.com/wiki/MRD-EN084	549481
213	Princess of Tsurugi	MRD-EN086	2	https://yugipedia.com/wiki/MRD-EN086	51371017
214	Protector of the Throne	MRD-EN087	2	https://yugipedia.com/wiki/MRD-EN087	10071456
206	Pumpking the King of Ghosts	MRD-EN079	2	https://yugipedia.com/wiki/MRD-EN079	29155212
178	Queen's Double	MRD-EN051	2	https://yugipedia.com/wiki/MRD-EN051	5901497
204	Rabid Horseman	MRD-EN077	2	https://yugipedia.com/wiki/MRD-EN077	94905343
169	Rainbow Flower	MRD-EN042	2	https://yugipedia.com/wiki/MRD-EN042	21347810
147	Roaring Ocean Snake	MRD-EN020	2	https://yugipedia.com/wiki/MRD-EN020	19066538
219	Ryu-Kishin Powered	MRD-EN092	2	https://yugipedia.com/wiki/MRD-EN092	24611934
152	Sanga of the Thunder	MRD-EN025	2	https://yugipedia.com/wiki/MRD-EN025	25955164
196	Sangan	MRD-EN069	2	https://yugipedia.com/wiki/MRD-EN069	26202165
217	Shadow Ghoul	MRD-EN090	2	https://yugipedia.com/wiki/MRD-EN090	30778711
185	Soul Release	MRD-EN058	2	https://yugipedia.com/wiki/MRD-EN058	5758500
156	Steel Scorpion	MRD-EN029	2	https://yugipedia.com/wiki/MRD-EN029	13599884
154	Suijin	MRD-EN027	2	https://yugipedia.com/wiki/MRD-EN027	98434877
190	Swamp Battleguard	MRD-EN063	2	https://yugipedia.com/wiki/MRD-EN063	40453765
208	Tainted Wisdom	MRD-EN081	2	https://yugipedia.com/wiki/MRD-EN081	28725004
186	The Cheerful Coffin	MRD-EN059	2	https://yugipedia.com/wiki/MRD-EN059	41142615
212	The Little Swordsman of Aile	MRD-EN085	2	https://yugipedia.com/wiki/MRD-EN085	25109950
192	Time Wizard	MRD-EN065	2	https://yugipedia.com/wiki/MRD-EN065	71625222
172	Tongyo	MRD-EN045	2	https://yugipedia.com/wiki/MRD-EN045	69572024
215	Tremendous Fire	MRD-EN088	2	https://yugipedia.com/wiki/MRD-EN088	46918794
179	Trent	MRD-EN052	2	https://yugipedia.com/wiki/MRD-EN052	78780140
148	Water Omotics	MRD-EN021	2	https://yugipedia.com/wiki/MRD-EN021	2483611
253	Barrel Dragon	MRD-EN126	2	https://yugipedia.com/wiki/MRD-EN126	81480460
245	Bladefly	MRD-EN118	2	https://yugipedia.com/wiki/MRD-EN118	28470714
260	Block Attack	MRD-EN133	2	https://yugipedia.com/wiki/MRD-EN133	25880422
233	Cannon Soldier	MRD-EN106	2	https://yugipedia.com/wiki/MRD-EN106	11384280
232	Cyber Saurus	MRD-EN105	2	https://yugipedia.com/wiki/MRD-EN105	89112729
240	Dark Elf	MRD-EN113	2	https://yugipedia.com/wiki/MRD-EN113	21417692
238	Flame Cerebrus	MRD-EN111	2	https://yugipedia.com/wiki/MRD-EN111	60862676
252	Garnecia Elefantis	MRD-EN125	2	https://yugipedia.com/wiki/MRD-EN125	49888191
263	Germ Infection	MRD-EN136	2	https://yugipedia.com/wiki/MRD-EN136	24668830
251	Gazelle the King of Mythical Beasts	MRD-EN124	2	https://yugipedia.com/wiki/MRD-EN124	5818798
223	Giga-Tech Wolf	MRD-EN096	2	https://yugipedia.com/wiki/MRD-EN096	8471389
269	Heavy Storm	MRD-EN142	2	https://yugipedia.com/wiki/MRD-EN142	19613556
257	Horn of Heaven	MRD-EN130	2	https://yugipedia.com/wiki/MRD-EN130	98069388
229	Hoshiningen	MRD-EN102	2	https://yugipedia.com/wiki/MRD-EN102	67629977
228	Insect Soldiers of the Sky	MRD-EN101	2	https://yugipedia.com/wiki/MRD-EN101	7019529
246	Lady of Faith	MRD-EN119	2	https://yugipedia.com/wiki/MRD-EN119	17358176
242	Lava Battleguard	MRD-EN115	2	https://yugipedia.com/wiki/MRD-EN115	20394040
244	Little Chimera	MRD-EN117	2	https://yugipedia.com/wiki/MRD-EN117	68658728
255	Magic Jammer	MRD-EN128	2	https://yugipedia.com/wiki/MRD-EN128	77414722
237	Milus Radiant	MRD-EN110	2	https://yugipedia.com/wiki/MRD-EN110	7489323
265	Mirror Force	MRD-EN138	2	https://yugipedia.com/wiki/MRD-EN138	44095762
234	Muka Muka	MRD-EN107	2	https://yugipedia.com/wiki/MRD-EN107	46657337
241	Mushroom Man #2	MRD-EN114	2	https://yugipedia.com/wiki/MRD-EN114	93900406
230	Musician King	MRD-EN103	2	https://yugipedia.com/wiki/MRD-EN103	56907389
239	Niwatori	MRD-EN112	2	https://yugipedia.com/wiki/MRD-EN112	7805359
264	Paralyzing Potion	MRD-EN137	2	https://yugipedia.com/wiki/MRD-EN137	50152549
227	Punished Eagle	MRD-EN100	2	https://yugipedia.com/wiki/MRD-EN100	74703140
266	Ring of Magnetism	MRD-EN139	2	https://yugipedia.com/wiki/MRD-EN139	20436034
262	Robbin' Goblin	MRD-EN135	2	https://yugipedia.com/wiki/MRD-EN135	88279736
256	Seven Tools of the Bandit	MRD-EN129	2	https://yugipedia.com/wiki/MRD-EN129	3819470
267	Share the Pain	MRD-EN140	2	https://yugipedia.com/wiki/MRD-EN140	56830749
258	Shield & Sword	MRD-EN131	2	https://yugipedia.com/wiki/MRD-EN131	52097679
250	Skull Knight	MRD-EN123	2	https://yugipedia.com/wiki/MRD-EN123	2504891
236	Star Boy	MRD-EN109	2	https://yugipedia.com/wiki/MRD-EN109	8201910
268	Stim-Pack	MRD-EN141	2	https://yugipedia.com/wiki/MRD-EN141	83225447
259	Sword of Deep-Seated	MRD-EN132	2	https://yugipedia.com/wiki/MRD-EN132	98495314
235	The Bistro Butcher	MRD-EN108	2	https://yugipedia.com/wiki/MRD-EN108	71107816
226	The Immortal of Thunder	MRD-EN099	2	https://yugipedia.com/wiki/MRD-EN099	84926738
261	The Unhappy Maiden	MRD-EN134	2	https://yugipedia.com/wiki/MRD-EN134	51275027
270	Thousand Dragon	MRD-EN143	2	https://yugipedia.com/wiki/MRD-EN143	41462083
224	Thunder Dragon	MRD-EN097	2	https://yugipedia.com/wiki/MRD-EN097	31786629
247	Twin-Headed Thunder Dragon	MRD-EN120	2	https://yugipedia.com/wiki/MRD-EN120	54752875
243	Witch of the Black Forest	MRD-EN116	2	https://yugipedia.com/wiki/MRD-EN116	78010363
248	Witch's Apprentice	MRD-EN121	2	https://yugipedia.com/wiki/MRD-EN121	80741828
231	Yado Karu	MRD-EN104	2	https://yugipedia.com/wiki/MRD-EN104	29380133
281	Ameba	SRL-EN010	3	https://yugipedia.com/wiki/SRL-EN010	95174353
273	Axe of Despair	SRL-EN002	3	https://yugipedia.com/wiki/SRL-EN002	40619825
274	Black Pendant	SRL-EN003	3	https://yugipedia.com/wiki/SRL-EN003	65169794
271	Blue-Eyes Toon Dragon	SRL-EN000	3	https://yugipedia.com/wiki/SRL-EN000	53183600
290	Dark Witch	SRL-EN019	3	https://yugipedia.com/wiki/SRL-EN019	35565537
279	Electric Snake	SRL-EN008	3	https://yugipedia.com/wiki/SRL-EN008	11324436
285	Fire Kraken	SRL-EN014	3	https://yugipedia.com/wiki/SRL-EN014	46534755
293	Giant Turtle Who Feeds on Flames	SRL-EN022	3	https://yugipedia.com/wiki/SRL-EN022	96981563
287	Griggle	SRL-EN016	3	https://yugipedia.com/wiki/SRL-EN016	95744531
284	Guardian of the Throne Room	SRL-EN013	3	https://yugipedia.com/wiki/SRL-EN013	47879985
296	High Tide Gyojin	SRL-EN025	3	https://yugipedia.com/wiki/SRL-EN025	54579801
295	Hiro's Shadow Scout	SRL-EN024	3	https://yugipedia.com/wiki/SRL-EN024	81863068
275	Horn of Light	SRL-EN004	3	https://yugipedia.com/wiki/SRL-EN004	38552107
297	Invader of the Throne	SRL-EN026	3	https://yugipedia.com/wiki/SRL-EN026	3056267
283	Maha Vailo	SRL-EN012	3	https://yugipedia.com/wiki/SRL-EN012	93013676
276	Malevolent Nuzzler	SRL-EN005	3	https://yugipedia.com/wiki/SRL-EN005	99597615
292	Mechanical Snail	SRL-EN021	3	https://yugipedia.com/wiki/SRL-EN021	34442949
278	Metal Fish	SRL-EN007	3	https://yugipedia.com/wiki/SRL-EN007	55998462
286	Minar	SRL-EN015	3	https://yugipedia.com/wiki/SRL-EN015	32539892
282	Peacock	SRL-EN011	3	https://yugipedia.com/wiki/SRL-EN011	20624263
272	Penguin Knight	SRL-EN001	3	https://yugipedia.com/wiki/SRL-EN001	36039163
280	Queen Bird	SRL-EN009	3	https://yugipedia.com/wiki/SRL-EN009	73081602
277	Spellbinding Circle	SRL-EN006	3	https://yugipedia.com/wiki/SRL-EN006	18807108
288	Tyhone #2	SRL-EN017	3	https://yugipedia.com/wiki/SRL-EN017	56789759
291	Weather Report	SRL-EN020	3	https://yugipedia.com/wiki/SRL-EN020	72053645
298	Whiptail Crow	SRL-EN027	3	https://yugipedia.com/wiki/SRL-EN027	91996584
322	Black Illusion Ritual	SRL-EN051	3	https://yugipedia.com/wiki/SRL-EN051	41426869
360	Boar Soldier	SRL-EN089	3	https://yugipedia.com/wiki/SRL-EN089	21340051
363	Ceremonial Bell	SRL-EN092	3	https://yugipedia.com/wiki/SRL-EN092	20228463
317	Chain Energy	SRL-EN046	3	https://yugipedia.com/wiki/SRL-EN046	79323590
333	Commencement Dance	SRL-EN062	3	https://yugipedia.com/wiki/SRL-EN062	43417563
309	Confiscation	SRL-EN038	3	https://yugipedia.com/wiki/SRL-EN038	17375316
340	Crab Turtle	SRL-EN069	3	https://yugipedia.com/wiki/SRL-EN069	91782219
303	Curse of Fiend	SRL-EN032	3	https://yugipedia.com/wiki/SRL-EN032	12470447
348	Cyber Jar	SRL-EN077	3	https://yugipedia.com/wiki/SRL-EN077	34124316
355	Dark Zebra	SRL-EN084	3	https://yugipedia.com/wiki/SRL-EN084	59784896
311	Darkness Approaches	SRL-EN040	3	https://yugipedia.com/wiki/SRL-EN040	80168720
310	Delinquent Duo	SRL-EN039	3	https://yugipedia.com/wiki/SRL-EN039	44763025
336	Eatgaboon	SRL-EN065	3	https://yugipedia.com/wiki/SRL-EN065	42578427
331	Eternal Rest	SRL-EN060	3	https://yugipedia.com/wiki/SRL-EN060	95051344
312	Fairy's Hand Mirror	SRL-EN041	3	https://yugipedia.com/wiki/SRL-EN041	17653779
306	Final Destiny	SRL-EN035	3	https://yugipedia.com/wiki/SRL-EN035	18591904
362	Flying Kamakiri #1	SRL-EN091	3	https://yugipedia.com/wiki/SRL-EN091	84834865
367	Gaia Power	SRL-EN096	3	https://yugipedia.com/wiki/SRL-EN096	56594520
356	Giant Germ	SRL-EN085	3	https://yugipedia.com/wiki/SRL-EN085	95178994
350	Giant Rat	SRL-EN079	3	https://yugipedia.com/wiki/SRL-EN079	97017120
319	Giant Trunade	SRL-EN048	3	https://yugipedia.com/wiki/SRL-EN048	42703248
302	Gravekeeper's Servant	SRL-EN031	3	https://yugipedia.com/wiki/SRL-EN031	16762927
334	Hamburger Recipe	SRL-EN063	3	https://yugipedia.com/wiki/SRL-EN063	80811661
325	Horn of the Unicorn	SRL-EN054	3	https://yugipedia.com/wiki/SRL-EN054	64047146
335	House of Adhesive Tape	SRL-EN064	3	https://yugipedia.com/wiki/SRL-EN064	15083728
339	Hungry Burger	SRL-EN068	3	https://yugipedia.com/wiki/SRL-EN068	30243636
346	Hyozanryu	SRL-EN075	3	https://yugipedia.com/wiki/SRL-EN075	62397231
354	Karate Man	SRL-EN083	3	https://yugipedia.com/wiki/SRL-EN083	23289281
366	Kotodama	SRL-EN095	3	https://yugipedia.com/wiki/SRL-EN095	19406822
326	Labyrinth Wall	SRL-EN055	3	https://yugipedia.com/wiki/SRL-EN055	67284908
371	Luminous Spark	SRL-EN100	3	https://yugipedia.com/wiki/SRL-EN100	81777047
330	Magical Labyrinth	SRL-EN059	3	https://yugipedia.com/wiki/SRL-EN059	64389297
342	Manga Ryu-Ran	SRL-EN071	3	https://yugipedia.com/wiki/SRL-EN071	38369349
332	Megamorph	SRL-EN061	3	https://yugipedia.com/wiki/SRL-EN061	22046459
373	Messenger of Peace	SRL-EN102	3	https://yugipedia.com/wiki/SRL-EN102	44656491
369	Molten Destruction	SRL-EN098	3	https://yugipedia.com/wiki/SRL-EN098	19384334
361	Mother Grizzly	SRL-EN090	3	https://yugipedia.com/wiki/SRL-EN090	57839750
372	Mystic Plasma Zone	SRL-EN101	3	https://yugipedia.com/wiki/SRL-EN101	18161786
365	Mystic Tomato	SRL-EN094	3	https://yugipedia.com/wiki/SRL-EN094	83011277
357	Nimble Momonga	SRL-EN086	3	https://yugipedia.com/wiki/SRL-EN086	22567609
323	Octoberser	SRL-EN052	3	https://yugipedia.com/wiki/SRL-EN052	74637266
320	Painful Choice	SRL-EN049	3	https://yugipedia.com/wiki/SRL-EN049	74191942
338	Performance of Sword	SRL-EN067	3	https://yugipedia.com/wiki/SRL-EN067	4849037
324	Psychic Kappa	SRL-EN053	3	https://yugipedia.com/wiki/SRL-EN053	7892180
301	Red Archery Girl	SRL-EN030	3	https://yugipedia.com/wiki/SRL-EN030	65570596
300	Relinquished	SRL-EN029	3	https://yugipedia.com/wiki/SRL-EN029	64631466
370	Rising Air Current	SRL-EN099	3	https://yugipedia.com/wiki/SRL-EN099	45778932
314	Rush Recklessly	SRL-EN043	3	https://yugipedia.com/wiki/SRL-EN043	70046172
341	Ryu-Ran	SRL-EN070	3	https://yugipedia.com/wiki/SRL-EN070	2964201
351	Senju of the Thousand Hands	SRL-EN080	3	https://yugipedia.com/wiki/SRL-EN080	23401839
374	Serpent Night Dragon	SRL-EN103	3	https://yugipedia.com/wiki/SRL-EN103	66516792
359	Shining Angel	SRL-EN088	3	https://yugipedia.com/wiki/SRL-EN088	95956346
321	Snake Fang	SRL-EN050	3	https://yugipedia.com/wiki/SRL-EN050	596051
307	Snatch Steal	SRL-EN036	3	https://yugipedia.com/wiki/SRL-EN036	45986603
364	Sonic Bird	SRL-EN093	3	https://yugipedia.com/wiki/SRL-EN093	57617178
358	Spear Cretin	SRL-EN087	3	https://yugipedia.com/wiki/SRL-EN087	58551308
329	Stone Ogre Grotto	SRL-EN058	3	https://yugipedia.com/wiki/SRL-EN058	15023985
313	Tailor of the Fickle	SRL-EN042	3	https://yugipedia.com/wiki/SRL-EN042	43641473
316	The Forceful Sentry	SRL-EN045	3	https://yugipedia.com/wiki/SRL-EN045	42829885
315	The Reliable Guardian	SRL-EN044	3	https://yugipedia.com/wiki/SRL-EN044	16430187
305	Toll	SRL-EN034	3	https://yugipedia.com/wiki/SRL-EN034	82003859
344	Toon Summoned Skull	SRL-EN073	3	https://yugipedia.com/wiki/SRL-EN073	91842653
347	Toon World	SRL-EN076	3	https://yugipedia.com/wiki/SRL-EN076	15259703
337	Turtle Oath	SRL-EN066	3	https://yugipedia.com/wiki/SRL-EN066	76806714
328	Twin Long Rods #2	SRL-EN057	3	https://yugipedia.com/wiki/SRL-EN057	29692206
352	UFO Turtle	SRL-EN081	3	https://yugipedia.com/wiki/SRL-EN081	60806437
368	Umiiruka	SRL-EN097	3	https://yugipedia.com/wiki/SRL-EN097	82999629
304	Upstart Goblin	SRL-EN033	3	https://yugipedia.com/wiki/SRL-EN033	70368879
327	Wall Shadow	SRL-EN056	3	https://yugipedia.com/wiki/SRL-EN056	63162310
375	Jinzo	PSV-EN000	4	https://yugipedia.com/wiki/PSV-EN000	77585513
399	Appropriate	PSV-EN024	4	https://yugipedia.com/wiki/PSV-EN024	48539234
429	Attack and Receive	PSV-EN054	4	https://yugipedia.com/wiki/PSV-EN054	63689843
403	Backup Soldier	PSV-EN028	4	https://yugipedia.com/wiki/PSV-EN028	36280194
432	Bubonic Vermin	PSV-EN057	4	https://yugipedia.com/wiki/PSV-EN057	6104968
436	Burning Land	PSV-EN061	4	https://yugipedia.com/wiki/PSV-EN061	24294108
425	Buster Blader	PSV-EN050	4	https://yugipedia.com/wiki/PSV-EN050	78193831
387	Call of the Haunted	PSV-EN012	4	https://yugipedia.com/wiki/PSV-EN012	97077563
405	Ceasefire	PSV-EN030	4	https://yugipedia.com/wiki/PSV-EN030	36468556
381	Chain Destruction	PSV-EN006	4	https://yugipedia.com/wiki/PSV-EN006	1248895
437	Cold Wave	PSV-EN062	4	https://yugipedia.com/wiki/PSV-EN062	60682203
422	Cyber Falcon	PSV-EN047	4	https://yugipedia.com/wiki/PSV-EN047	30655537
433	Dark Bat	PSV-EN058	4	https://yugipedia.com/wiki/PSV-EN058	67049542
420	Darkfire Soldier #2	PSV-EN045	4	https://yugipedia.com/wiki/PSV-EN045	78861134
454	Deepsea Warrior	PSV-EN079	4	https://yugipedia.com/wiki/PSV-EN079	24128274
444	Dimensionhole	PSV-EN069	4	https://yugipedia.com/wiki/PSV-EN069	22959079
401	DNA Surgery	PSV-EN026	4	https://yugipedia.com/wiki/PSV-EN026	74701381
453	Drill Bug	PSV-EN078	4	https://yugipedia.com/wiki/PSV-EN078	88733579
393	Driving Snow	PSV-EN018	4	https://yugipedia.com/wiki/PSV-EN018	473469
386	Dust Tornado	PSV-EN011	4	https://yugipedia.com/wiki/PSV-EN011	60082869
389	Earthshaker	PSV-EN014	4	https://yugipedia.com/wiki/PSV-EN014	60866277
390	Enchanted Javelin	PSV-EN015	4	https://yugipedia.com/wiki/PSV-EN015	96355986
438	Fairy Meteor Crush	PSV-EN063	4	https://yugipedia.com/wiki/PSV-EN063	97687912
416	Flame Champion	PSV-EN041	4	https://yugipedia.com/wiki/PSV-EN041	42599677
423	Flying Kamakiri #2	PSV-EN048	4	https://yugipedia.com/wiki/PSV-EN048	3134241
428	Gamble	PSV-EN053	4	https://yugipedia.com/wiki/PSV-EN053	37313786
383	Graverobber	PSV-EN008	4	https://yugipedia.com/wiki/PSV-EN008	61705417
384	Gift of the Mystical Elf	PSV-EN009	4	https://yugipedia.com/wiki/PSV-EN009	98299011
448	Gravity Bind	PSV-EN073	4	https://yugipedia.com/wiki/PSV-EN073	85742772
445	Ground Collapse	PSV-EN070	4	https://yugipedia.com/wiki/PSV-EN070	90502999
392	Gust	PSV-EN017	4	https://yugipedia.com/wiki/PSV-EN017	73079365
447	Infinite Dismissal	PSV-EN072	4	https://yugipedia.com/wiki/PSV-EN072	54109233
443	Insect Imitation	PSV-EN068	4	https://yugipedia.com/wiki/PSV-EN068	96965364
413	Inspection	PSV-EN038	4	https://yugipedia.com/wiki/PSV-EN038	16227556
406	Light of Intervention	PSV-EN031	4	https://yugipedia.com/wiki/PSV-EN031	62867251
421	Kiseitai	PSV-EN046	4	https://yugipedia.com/wiki/PSV-EN046	4266839
380	Lightforce Sword	PSV-EN005	4	https://yugipedia.com/wiki/PSV-EN005	49587034
439	Limiter Removal	PSV-EN064	4	https://yugipedia.com/wiki/PSV-EN064	23171610
446	Magic Drain	PSV-EN071	4	https://yugipedia.com/wiki/PSV-EN071	59344077
404	Major Riot	PSV-EN029	4	https://yugipedia.com/wiki/PSV-EN029	9074847
397	Metal Detector	PSV-EN022	4	https://yugipedia.com/wiki/PSV-EN022	75646520
426	Michizure	PSV-EN051	4	https://yugipedia.com/wiki/PSV-EN051	37580756
391	Mirror Wall	PSV-EN016	4	https://yugipedia.com/wiki/PSV-EN016	22359980
427	Minor Goblin Official	PSV-EN052	4	https://yugipedia.com/wiki/PSV-EN052	1918087
441	Monster Recovery	PSV-EN066	4	https://yugipedia.com/wiki/PSV-EN066	93108433
415	Morphing Jar #2	PSV-EN040	4	https://yugipedia.com/wiki/PSV-EN040	79106360
419	Mr. Volcano	PSV-EN044	4	https://yugipedia.com/wiki/PSV-EN044	31477025
396	Mystic Probe	PSV-EN021	4	https://yugipedia.com/wiki/PSV-EN021	49251811
409	Nobleman of Crossout	PSV-EN034	4	https://yugipedia.com/wiki/PSV-EN034	71044499
398	Numinous Healer	PSV-EN023	4	https://yugipedia.com/wiki/PSV-EN023	2130625
434	Oni Tank T-34	PSV-EN059	4	https://yugipedia.com/wiki/PSV-EN059	66927994
435	Overdrive	PSV-EN060	4	https://yugipedia.com/wiki/PSV-EN060	2311603
378	Parasite Paracide	PSV-EN003	4	https://yugipedia.com/wiki/PSV-EN003	27911549
412	Premature Burial	PSV-EN037	4	https://yugipedia.com/wiki/PSV-EN037	70828912
414	Prohibition	PSV-EN039	4	https://yugipedia.com/wiki/PSV-EN039	43711255
440	Rain of Mercy	PSV-EN065	4	https://yugipedia.com/wiki/PSV-EN065	66719324
407	Respect Play	PSV-EN032	4	https://yugipedia.com/wiki/PSV-EN032	8951260
450	Shadow of Eyes	PSV-EN075	4	https://yugipedia.com/wiki/PSV-EN075	58621589
442	Shift	PSV-EN067	4	https://yugipedia.com/wiki/PSV-EN067	59560625
431	Skull Invitation	PSV-EN056	4	https://yugipedia.com/wiki/PSV-EN056	98139712
424	Sky Scout	PSV-EN049	4	https://yugipedia.com/wiki/PSV-EN049	30532390
388	Solomon's Lawbook	PSV-EN013	4	https://yugipedia.com/wiki/PSV-EN013	23471572
430	Solemn Wishes	PSV-EN055	4	https://yugipedia.com/wiki/PSV-EN055	35346968
451	The Legendary Fisherman	PSV-EN076	4	https://yugipedia.com/wiki/PSV-EN076	3643300
385	The Eye of Truth	PSV-EN010	4	https://yugipedia.com/wiki/PSV-EN010	34694160
402	The Regulation of Tribe	PSV-EN027	4	https://yugipedia.com/wiki/PSV-EN027	296499
411	The Shallow Grave	PSV-EN036	4	https://yugipedia.com/wiki/PSV-EN036	43434803
377	Three-Headed Geedo	PSV-EN002	4	https://yugipedia.com/wiki/PSV-EN002	78423643
417	Twin-Headed Fire Dragon	PSV-EN042	4	https://yugipedia.com/wiki/PSV-EN042	78984772
382	Time Seal	PSV-EN007	4	https://yugipedia.com/wiki/PSV-EN007	35316708
449	Type Zero Magic Crusher	PSV-EN074	4	https://yugipedia.com/wiki/PSV-EN074	21237481
395	World Suppression	PSV-EN020	4	https://yugipedia.com/wiki/PSV-EN020	12253117
478	Beast of Talwar	PSV-EN103	4	https://yugipedia.com/wiki/PSV-EN103	11761845
455	Bite Shoes	PSV-EN080	4	https://yugipedia.com/wiki/PSV-EN080	50122883
474	Dokuroyaiba	PSV-EN099	4	https://yugipedia.com/wiki/PSV-EN099	30325729
462	Bombardment Beetle	PSV-EN087	4	https://yugipedia.com/wiki/PSV-EN087	57409948
476	Gearfried the Iron Knight	PSV-EN101	4	https://yugipedia.com/wiki/PSV-EN101	423705
460	Girochin Kuwagata	PSV-EN085	4	https://yugipedia.com/wiki/PSV-EN085	84620194
469	Goblin Attack Force	PSV-EN094	4	https://yugipedia.com/wiki/PSV-EN094	78658564
461	Hayabusa Knight	PSV-EN086	4	https://yugipedia.com/wiki/PSV-EN086	21015833
464	Gradius	PSV-EN089	4	https://yugipedia.com/wiki/PSV-EN089	10992251
479	Imperial Order	PSV-EN104	4	https://yugipedia.com/wiki/PSV-EN104	61740673
477	Insect Barrier	PSV-EN102	4	https://yugipedia.com/wiki/PSV-EN102	23615409
457	Invitation to a Dark Sleep	PSV-EN082	4	https://yugipedia.com/wiki/PSV-EN082	52675689
472	Science Soldier	PSV-EN097	4	https://yugipedia.com/wiki/PSV-EN097	67532912
470	Island Turtle	PSV-EN095	4	https://yugipedia.com/wiki/PSV-EN095	4042268
467	Skull Mariner	PSV-EN092	4	https://yugipedia.com/wiki/PSV-EN092	5265750
473	Souls of the Forgotten	PSV-EN098	4	https://yugipedia.com/wiki/PSV-EN098	4920010
456	Spikebot	PSV-EN081	4	https://yugipedia.com/wiki/PSV-EN081	87511987
468	The All-Seeing White Tiger	PSV-EN093	4	https://yugipedia.com/wiki/PSV-EN093	32269855
475	The Fiend Megacyber	PSV-EN100	4	https://yugipedia.com/wiki/PSV-EN100	66362965
459	Thousand-Eyes Restrict	PSV-EN084	4	https://yugipedia.com/wiki/PSV-EN084	63519819
458	Thousand-Eyes Idol	PSV-EN083	4	https://yugipedia.com/wiki/PSV-EN083	27125110
465	Red-Moon Baby	PSV-EN090	4	https://yugipedia.com/wiki/PSV-EN090	56387350
471	Wingweaver	PSV-EN096	4	https://yugipedia.com/wiki/PSV-EN096	31447217
512	Amazoness Archer	LON-EN032	5	https://yugipedia.com/wiki/LON-EN032	91869203
488	Amphibian Beast	LON-EN008	5	https://yugipedia.com/wiki/LON-EN008	67371383
523	Bio-Mage	LON-EN043	5	https://yugipedia.com/wiki/LON-EN043	58696829
513	Crimson Sentry	LON-EN033	5	https://yugipedia.com/wiki/LON-EN033	28358902
494	Chosen One	LON-EN014	5	https://yugipedia.com/wiki/LON-EN014	21888494
521	Cure Mermaid	LON-EN041	5	https://yugipedia.com/wiki/LON-EN041	85802526
518	Dancing Fairy	LON-EN038	5	https://yugipedia.com/wiki/LON-EN038	90925163
496	Curse of the Masked Beast	LON-EN016	5	https://yugipedia.com/wiki/LON-EN016	94377247
526	Marie the Fallen One	LON-EN046	5	https://yugipedia.com/wiki/LON-EN046	57579381
520	Empress Mantis	LON-EN040	5	https://yugipedia.com/wiki/LON-EN040	58818411
519	Fairy Guardian	LON-EN039	5	https://yugipedia.com/wiki/LON-EN039	22419772
504	Fairy Box	LON-EN024	5	https://yugipedia.com/wiki/LON-EN024	21598948
514	Fire Princess	LON-EN034	5	https://yugipedia.com/wiki/LON-EN034	64752646
516	Fire Sorcerer	LON-EN036	5	https://yugipedia.com/wiki/LON-EN036	27132350
487	Flying Fish	LON-EN007	5	https://yugipedia.com/wiki/LON-EN007	31987274
490	Gadget Soldier	LON-EN010	5	https://yugipedia.com/wiki/LON-EN010	86281779
480	Gemini Elf	LON-EN000	5	https://yugipedia.com/wiki/LON-EN000	69140098
522	Hysteric Fairy	LON-EN042	5	https://yugipedia.com/wiki/LON-EN042	21297224
483	Humanoid Slime	LON-EN003	5	https://yugipedia.com/wiki/LON-EN003	46821314
485	Humanoid Worm Drake	LON-EN005	5	https://yugipedia.com/wiki/LON-EN005	5600127
507	Infinite Cards	LON-EN027	5	https://yugipedia.com/wiki/LON-EN027	94163677
506	Jam Breeding Machine	LON-EN026	5	https://yugipedia.com/wiki/LON-EN026	21770260
527	Jar of Greed	LON-EN047	5	https://yugipedia.com/wiki/LON-EN047	83968380
508	Jam Defender	LON-EN028	5	https://yugipedia.com/wiki/LON-EN028	21558682
515	Lady Assailant of Flames	LON-EN035	5	https://yugipedia.com/wiki/LON-EN035	90147755
510	Lady Panther	LON-EN030	5	https://yugipedia.com/wiki/LON-EN030	38480590
502	Lightning Blade	LON-EN022	5	https://yugipedia.com/wiki/LON-EN022	55226821
530	Mage Power	LON-EN050	5	https://yugipedia.com/wiki/LON-EN050	83746708
500	Mask of Brutality	LON-EN020	5	https://yugipedia.com/wiki/LON-EN020	82432018
498	Mask of Restrict	LON-EN018	5	https://yugipedia.com/wiki/LON-EN018	29549364
499	Mask of the Accursed	LON-EN019	5	https://yugipedia.com/wiki/LON-EN019	56948373
492	Melchid the Four-Face Beast	LON-EN012	5	https://yugipedia.com/wiki/LON-EN012	86569121
495	Mask of Weakness	LON-EN015	5	https://yugipedia.com/wiki/LON-EN015	57882509
493	Nuvia the Wicked	LON-EN013	5	https://yugipedia.com/wiki/LON-EN013	12953226
501	Return of the Doomed	LON-EN021	5	https://yugipedia.com/wiki/LON-EN021	19827717
486	Revival Jam	LON-EN006	5	https://yugipedia.com/wiki/LON-EN006	31709826
528	Scroll of Bewitchment	LON-EN048	5	https://yugipedia.com/wiki/LON-EN048	10352095
489	Shining Abyss	LON-EN009	5	https://yugipedia.com/wiki/LON-EN009	87303357
517	Spirit of the Breeze	LON-EN037	5	https://yugipedia.com/wiki/LON-EN037	53530069
525	St. Joan	LON-EN045	5	https://yugipedia.com/wiki/LON-EN045	21175632
524	The Forgiving Maiden	LON-EN044	5	https://yugipedia.com/wiki/LON-EN044	84080938
481	The Masked Beast	LON-EN001	5	https://yugipedia.com/wiki/LON-EN001	49064413
511	The Unfriendly Amazon	LON-EN031	5	https://yugipedia.com/wiki/LON-EN031	65475294
505	Torrential Tribute	LON-EN025	5	https://yugipedia.com/wiki/LON-EN025	53582587
503	Tornado Wall	LON-EN023	5	https://yugipedia.com/wiki/LON-EN023	18605135
529	United We Stand	LON-EN049	5	https://yugipedia.com/wiki/LON-EN049	56747793
484	Worm Drake	LON-EN004	5	https://yugipedia.com/wiki/LON-EN004	73216412
576	Bait Doll	LON-EN096	5	https://yugipedia.com/wiki/LON-EN096	7165085
544	Bazoo the Soul-Eater	LON-EN064	5	https://yugipedia.com/wiki/LON-EN064	40133511
566	Blind Destruction	LON-EN086	5	https://yugipedia.com/wiki/LON-EN086	32015116
537	Boneheimer	LON-EN057	5	https://yugipedia.com/wiki/LON-EN057	98456117
545	Dark Necrofear	LON-EN065	5	https://yugipedia.com/wiki/LON-EN065	31829185
558	Collected Power	LON-EN078	5	https://yugipedia.com/wiki/LON-EN078	7565547
559	Dark Spirit of the Silent	LON-EN079	5	https://yugipedia.com/wiki/LON-EN079	93599951
577	De-Fusion	LON-EN097	5	https://yugipedia.com/wiki/LON-EN097	95286165
564	Deal of Phantom	LON-EN084	5	https://yugipedia.com/wiki/LON-EN084	69122763
568	Destiny Board	LON-EN088	5	https://yugipedia.com/wiki/LON-EN088	94212438
565	Destruction Punch	LON-EN085	5	https://yugipedia.com/wiki/LON-EN085	5616412
581	Dragonic Attack	LON-EN101	5	https://yugipedia.com/wiki/LON-EN101	32437102
553	Dreamsprite	LON-EN073	5	https://yugipedia.com/wiki/LON-EN073	8687195
579	Ekibyo Drakmord	LON-EN099	5	https://yugipedia.com/wiki/LON-EN099	69954399
535	Earthbound Spirit	LON-EN055	5	https://yugipedia.com/wiki/LON-EN055	67105242
538	Flame Dancer	LON-EN058	5	https://yugipedia.com/wiki/LON-EN058	12883044
550	Garuda the Wind Spirit	LON-EN070	5	https://yugipedia.com/wiki/LON-EN070	12800777
578	Fusion Gate	LON-EN098	5	https://yugipedia.com/wiki/LON-EN098	33550694
551	Gilasaurus	LON-EN071	5	https://yugipedia.com/wiki/LON-EN071	45894482
534	Headless Knight	LON-EN054	5	https://yugipedia.com/wiki/LON-EN054	5434080
541	Jowgen the Spiritualist	LON-EN061	5	https://yugipedia.com/wiki/LON-EN061	41855169
542	Kycoo the Ghost Destroyer	LON-EN062	5	https://yugipedia.com/wiki/LON-EN062	88240808
540	Lightning Conger	LON-EN060	5	https://yugipedia.com/wiki/LON-EN060	27671321
584	Magic Cylinder	LON-EN104	5	https://yugipedia.com/wiki/LON-EN104	62279055
556	Maryokutai	LON-EN076	5	https://yugipedia.com/wiki/LON-EN076	71466592
580	Miracle Dig	LON-EN100	5	https://yugipedia.com/wiki/LON-EN100	6343408
531	Offerings to the Doomed	LON-EN051	5	https://yugipedia.com/wiki/LON-EN051	19230407
561	Riryoku Field	LON-EN081	5	https://yugipedia.com/wiki/LON-EN081	70344351
560	Royal Command	LON-EN080	5	https://yugipedia.com/wiki/LON-EN080	33950246
562	Skull Lair	LON-EN082	5	https://yugipedia.com/wiki/LON-EN082	6733059
546	Soul of Purity and Light	LON-EN066	5	https://yugipedia.com/wiki/LON-EN066	77527210
539	Spherous Lady	LON-EN059	5	https://yugipedia.com/wiki/LON-EN059	52121290
582	Spirit Elimination	LON-EN102	5	https://yugipedia.com/wiki/LON-EN102	69832741
571	Spirit Message A	LON-EN091	5	https://yugipedia.com/wiki/LON-EN091	94772232
572	Spirit Message L	LON-EN092	5	https://yugipedia.com/wiki/LON-EN092	30170981
570	Spirit Message N	LON-EN090	5	https://yugipedia.com/wiki/LON-EN090	67287533
547	Spirit of Flames	LON-EN067	5	https://yugipedia.com/wiki/LON-EN067	13522325
574	Spiritualism	LON-EN094	5	https://yugipedia.com/wiki/LON-EN094	15866454
543	Summoner of Illusions	LON-EN063	5	https://yugipedia.com/wiki/LON-EN063	14644902
573	The Dark Door	LON-EN093	5	https://yugipedia.com/wiki/LON-EN093	30606547
555	Supply	LON-EN075	5	https://yugipedia.com/wiki/LON-EN075	44072894
536	The Earl of Demise	LON-EN056	5	https://yugipedia.com/wiki/LON-EN056	66989694
567	The Emperor's Holiday	LON-EN087	5	https://yugipedia.com/wiki/LON-EN087	68400115
533	The Gross Ghost of Fled Dreams	LON-EN053	5	https://yugipedia.com/wiki/LON-EN053	68049471
532	The Portrait's Secret	LON-EN052	5	https://yugipedia.com/wiki/LON-EN052	32541773
549	The Rock Spirit	LON-EN069	5	https://yugipedia.com/wiki/LON-EN069	76305638
552	Tornado Bird	LON-EN072	5	https://yugipedia.com/wiki/LON-EN072	71283180
554	Zombyra the Dark	LON-EN074	5	https://yugipedia.com/wiki/LON-EN074	88472456
583	Vengeful Bog Spirit	LON-EN103	5	https://yugipedia.com/wiki/LON-EN103	95220856
595	Bark of Dark Ruler	LOD-EN010	6	https://yugipedia.com/wiki/LOD-EN010	41925941
587	Dark Balter the Terrible	LOD-EN002	6	https://yugipedia.com/wiki/LOD-EN002	80071763
586	Dark Ruler Ha Des	LOD-EN001	6	https://yugipedia.com/wiki/LOD-EN001	53982768
600	Double Snare	LOD-EN015	6	https://yugipedia.com/wiki/LOD-EN015	3682106
596	Fatal Abacus	LOD-EN011	6	https://yugipedia.com/wiki/LOD-EN011	77910045
601	Freed the Matchless General	LOD-EN016	6	https://yugipedia.com/wiki/LOD-EN016	49681811
588	Lesser Fiend	LOD-EN003	6	https://yugipedia.com/wiki/LOD-EN003	16475472
597	Life Absorbing Machine	LOD-EN012	6	https://yugipedia.com/wiki/LOD-EN012	14318794
603	Marauding Captain	LOD-EN018	6	https://yugipedia.com/wiki/LOD-EN018	2460565
606	Mysterious Guard	LOD-EN021	6	https://yugipedia.com/wiki/LOD-EN021	1347977
594	Opticlops	LOD-EN009	6	https://yugipedia.com/wiki/LOD-EN009	14531242
589	Possessed Dark Soul	LOD-EN004	6	https://yugipedia.com/wiki/LOD-EN004	52860176
604	Ryu Senshi	LOD-EN019	6	https://yugipedia.com/wiki/LOD-EN019	49868263
591	Skull Knight #2	LOD-EN006	6	https://yugipedia.com/wiki/LOD-EN006	15653824
599	Soul Demolition	LOD-EN014	6	https://yugipedia.com/wiki/LOD-EN014	76297408
598	The Puppet Magic of Dark Ruler	LOD-EN013	6	https://yugipedia.com/wiki/LOD-EN013	40703393
602	Throwstone Unit	LOD-EN017	6	https://yugipedia.com/wiki/LOD-EN017	76075810
593	Twin-Headed Wolf	LOD-EN008	6	https://yugipedia.com/wiki/LOD-EN008	88132637
605	Warrior Dai Grepher	LOD-EN020	6	https://yugipedia.com/wiki/LOD-EN020	75953262
590	Winged Minion	LOD-EN005	6	https://yugipedia.com/wiki/LOD-EN005	89258225
585	Yata-Garasu	LOD-EN000	6	https://yugipedia.com/wiki/LOD-EN000	3078576
663	A Legendary Ocean	LOD-EN078	6	https://yugipedia.com/wiki/LOD-EN078	295517
629	A Wingbeat of Giant Dragon	LOD-EN044	6	https://yugipedia.com/wiki/LOD-EN044	28596933
671	After the Struggle	LOD-EN086	6	https://yugipedia.com/wiki/LOD-EN086	25345186
647	Airknight Parshath	LOD-EN062	6	https://yugipedia.com/wiki/LOD-EN062	18036057
656	Asura Priest	LOD-EN071	6	https://yugipedia.com/wiki/LOD-EN071	2134346
678	Bad Reaction to Simochi	LOD-EN093	6	https://yugipedia.com/wiki/LOD-EN093	40633297
673	Blast with Chain	LOD-EN088	6	https://yugipedia.com/wiki/LOD-EN088	98239899
677	Bottomless Trap Hole	LOD-EN092	6	https://yugipedia.com/wiki/LOD-EN092	29401950
675	Bubble Crash	LOD-EN090	6	https://yugipedia.com/wiki/LOD-EN090	61622107
634	Burst Breath	LOD-EN049	6	https://yugipedia.com/wiki/LOD-EN049	80163754
669	Convulsion of Nature	LOD-EN084	6	https://yugipedia.com/wiki/LOD-EN084	62966332
625	Cave Dragon	LOD-EN040	6	https://yugipedia.com/wiki/LOD-EN040	93220472
666	Creature Swap	LOD-EN081	6	https://yugipedia.com/wiki/LOD-EN081	31036355
611	Dragon Manipulator	LOD-EN026	6	https://yugipedia.com/wiki/LOD-EN026	63018132
674	Disappear	LOD-EN089	6	https://yugipedia.com/wiki/LOD-EN089	24623598
630	Dragon's Gunfire	LOD-EN045	6	https://yugipedia.com/wiki/LOD-EN045	55991637
682	Drop Off	LOD-EN097	6	https://yugipedia.com/wiki/LOD-EN097	55773067
618	Emergency Provisions	LOD-EN033	6	https://yugipedia.com/wiki/LOD-EN033	53046408
608	Exiled Force	LOD-EN023	6	https://yugipedia.com/wiki/LOD-EN023	74131780
660	Fengsheng Mirror	LOD-EN075	6	https://yugipedia.com/wiki/LOD-EN075	37406863
641	Fiber Jar	LOD-EN056	6	https://yugipedia.com/wiki/LOD-EN056	78706415
624	Fiend Skull Dragon	LOD-EN039	6	https://yugipedia.com/wiki/LOD-EN039	66235877
607	Frontier Wiseman	LOD-EN022	6	https://yugipedia.com/wiki/LOD-EN022	38742075
657	Fushi No Tori	LOD-EN072	6	https://yugipedia.com/wiki/LOD-EN072	38538445
664	Fusion Sword Murasame Blade	LOD-EN079	6	https://yugipedia.com/wiki/LOD-EN079	37684215
645	Gradius' Option	LOD-EN060	6	https://yugipedia.com/wiki/LOD-EN060	14291024
626	Gray Wing	LOD-EN041	6	https://yugipedia.com/wiki/LOD-EN041	29618570
655	Hino-Kagu-Tsuchi	LOD-EN070	6	https://yugipedia.com/wiki/LOD-EN070	75745607
653	Great Long Nose	LOD-EN068	6	https://yugipedia.com/wiki/LOD-EN068	2356994
623	Lizard Soldier	LOD-EN038	6	https://yugipedia.com/wiki/LOD-EN038	20831168
650	Inaba White Rabbit	LOD-EN065	6	https://yugipedia.com/wiki/LOD-EN065	77084837
635	Luster Dragon	LOD-EN050	6	https://yugipedia.com/wiki/LOD-EN050	17658803
672	Magic Reflector	LOD-EN087	6	https://yugipedia.com/wiki/LOD-EN087	61844784
681	Nutrient Z	LOD-EN096	6	https://yugipedia.com/wiki/LOD-EN096	29389368
649	Maharaghi	LOD-EN064	6	https://yugipedia.com/wiki/LOD-EN064	40695128
679	Ominous Fortunetelling	LOD-EN094	6	https://yugipedia.com/wiki/LOD-EN094	56995655
654	Otohime	LOD-EN069	6	https://yugipedia.com/wiki/LOD-EN069	39751093
643	Patrician of Darkness	LOD-EN058	6	https://yugipedia.com/wiki/LOD-EN058	19153634
616	Ready for Intercepting	LOD-EN031	6	https://yugipedia.com/wiki/LOD-EN031	31785398
613	Reinforcement of the Army	LOD-EN028	6	https://yugipedia.com/wiki/LOD-EN028	32807846
639	Robolady	LOD-EN054	6	https://yugipedia.com/wiki/LOD-EN054	92421852
636	Robotic Knight	LOD-EN051	6	https://yugipedia.com/wiki/LOD-EN051	44203504
640	Roboyarou	LOD-EN055	6	https://yugipedia.com/wiki/LOD-EN055	38916461
676	Royal Oppression	LOD-EN091	6	https://yugipedia.com/wiki/LOD-EN091	93016201
668	Second Coin Toss	LOD-EN083	6	https://yugipedia.com/wiki/LOD-EN083	36562627
642	Serpentine Princess	LOD-EN057	6	https://yugipedia.com/wiki/LOD-EN057	71829750
620	Spear Dragon	LOD-EN035	6	https://yugipedia.com/wiki/LOD-EN035	31553716
665	Smoke Grenade of the Thief	LOD-EN080	6	https://yugipedia.com/wiki/LOD-EN080	63789924
621	Spirit Ryu	LOD-EN036	6	https://yugipedia.com/wiki/LOD-EN036	67957315
680	Spirit's Invitation	LOD-EN095	6	https://yugipedia.com/wiki/LOD-EN095	92394653
667	Spiritual Energy Settle Machine	LOD-EN082	6	https://yugipedia.com/wiki/LOD-EN082	99173029
661	Spring of Rebirth	LOD-EN076	6	https://yugipedia.com/wiki/LOD-EN076	94425169
631	Stamping Destruction	LOD-EN046	6	https://yugipedia.com/wiki/LOD-EN046	81385346
632	Super Rejuvenation	LOD-EN047	6	https://yugipedia.com/wiki/LOD-EN047	27770341
658	Super Robolady	LOD-EN073	6	https://yugipedia.com/wiki/LOD-EN073	75923050
659	Super Roboyarou	LOD-EN074	6	https://yugipedia.com/wiki/LOD-EN074	1412158
651	Susa Soldier	LOD-EN066	6	https://yugipedia.com/wiki/LOD-EN066	40473581
622	The Dragon Dwelling in the Cave	LOD-EN037	6	https://yugipedia.com/wiki/LOD-EN037	93346024
628	The Dragon's Bead	LOD-EN043	6	https://yugipedia.com/wiki/LOD-EN043	92408984
609	The Hunter with 7 Weapons	LOD-EN024	6	https://yugipedia.com/wiki/LOD-EN024	1525329
638	The Illusory Gentleman	LOD-EN053	6	https://yugipedia.com/wiki/LOD-EN053	83764996
670	The Secret of the Bandit	LOD-EN085	6	https://yugipedia.com/wiki/LOD-EN085	99351431
615	The Warrior Returning Alive	LOD-EN030	6	https://yugipedia.com/wiki/LOD-EN030	95281259
644	Thunder Nyan Nyan	LOD-EN059	6	https://yugipedia.com/wiki/LOD-EN059	70797118
627	Troop Dragon	LOD-EN042	6	https://yugipedia.com/wiki/LOD-EN042	55013285
648	Twin-Headed Behemoth	LOD-EN063	6	https://yugipedia.com/wiki/LOD-EN063	43586926
619	Tyrant Dragon	LOD-EN034	6	https://yugipedia.com/wiki/LOD-EN034	94568601
637	Wolf Axwielder	LOD-EN052	6	https://yugipedia.com/wiki/LOD-EN052	56369281
646	Woodland Sprite	LOD-EN061	6	https://yugipedia.com/wiki/LOD-EN061	6979239
652	Yamata Dragon	LOD-EN067	6	https://yugipedia.com/wiki/LOD-EN067	76862289
684	Last Turn	LOD-EN099	6	https://yugipedia.com/wiki/LOD-EN099	28566710
710	8-Claws Scorpion	PGD-024	7	https://yugipedia.com/wiki/PGD-024	14261867
756	A Cat of Ill Omen	PGD-070	7	https://yugipedia.com/wiki/PGD-070	24140059
754	A Man with Wdjat	PGD-068	7	https://yugipedia.com/wiki/PGD-068	51351302
759	An Owl of Luck	PGD-073	7	https://yugipedia.com/wiki/PGD-073	23927567
693	Arsenal Bug	PGD-007	7	https://yugipedia.com/wiki/PGD-007	42364374
691	Birdface	PGD-005	7	https://yugipedia.com/wiki/PGD-005	45547649
719	Book of Life	PGD-033	7	https://yugipedia.com/wiki/PGD-033	2204140
721	Book of Moon	PGD-035	7	https://yugipedia.com/wiki/PGD-035	14087893
720	Book of Taiyou	PGD-034	7	https://yugipedia.com/wiki/PGD-034	38699854
729	Bottomless Shifting Sand	PGD-043	7	https://yugipedia.com/wiki/PGD-043	76532077
724	Call of the Mummy	PGD-038	7	https://yugipedia.com/wiki/PGD-038	4861205
760	Charm of Shabti	PGD-074	7	https://yugipedia.com/wiki/PGD-074	50412166
761	Cobra Jar	PGD-075	7	https://yugipedia.com/wiki/PGD-075	86801871
730	Curse of Royal	PGD-044	7	https://yugipedia.com/wiki/PGD-044	2926176
733	Dark Coffin	PGD-047	7	https://yugipedia.com/wiki/PGD-047	1804528
703	Dark Dust Spirit	PGD-017	7	https://yugipedia.com/wiki/PGD-017	89111398
742	Dark Jeroid	PGD-056	7	https://yugipedia.com/wiki/PGD-056	90980792
714	Dark Scorpion Burglars	PGD-028	7	https://yugipedia.com/wiki/PGD-028	40933924
716	Des Lacooda	PGD-030	7	https://yugipedia.com/wiki/PGD-030	2326738
713	Dice Jar	PGD-027	7	https://yugipedia.com/wiki/PGD-027	3549275
715	Don Zaloog	PGD-029	7	https://yugipedia.com/wiki/PGD-029	76922029
717	Fushioh Richie	PGD-031	7	https://yugipedia.com/wiki/PGD-031	39711336
709	Giant Axe Mummy	PGD-023	7	https://yugipedia.com/wiki/PGD-023	78266168
753	Gravekeeper's Assailant	PGD-067	7	https://yugipedia.com/wiki/PGD-067	25262697
752	Gravekeeper's Cannonholder	PGD-066	7	https://yugipedia.com/wiki/PGD-066	99877698
751	Gravekeeper's Chief	PGD-065	7	https://yugipedia.com/wiki/PGD-065	62473983
746	Gravekeeper's Curse	PGD-060	7	https://yugipedia.com/wiki/PGD-060	50712728
747	Gravekeeper's Guard	PGD-061	7	https://yugipedia.com/wiki/PGD-061	37101832
748	Gravekeeper's Spear Soldier	PGD-062	7	https://yugipedia.com/wiki/PGD-062	63695531
745	Gravekeeper's Spy	PGD-059	7	https://yugipedia.com/wiki/PGD-059	24317029
749	Gravekeeper's Vassal	PGD-063	7	https://yugipedia.com/wiki/PGD-063	99690140
706	Great Dezard	PGD-020	7	https://yugipedia.com/wiki/PGD-020	88989706
711	Guardian Sphinx	PGD-025	7	https://yugipedia.com/wiki/PGD-025	40659562
744	Helpoemer	PGD-058	7	https://yugipedia.com/wiki/PGD-058	76052811
741	Inpachi	PGD-055	7	https://yugipedia.com/wiki/PGD-055	97923414
695	Jowls of Dark Demise	PGD-009	7	https://yugipedia.com/wiki/PGD-009	5257687
740	Kabazauls	PGD-054	7	https://yugipedia.com/wiki/PGD-054	51934376
690	King Tiger Wanghu	PGD-004	7	https://yugipedia.com/wiki/PGD-004	83986578
692	Kryuel	PGD-006	7	https://yugipedia.com/wiki/PGD-006	82642348
694	Maiden of the Aqua	PGD-008	7	https://yugipedia.com/wiki/PGD-008	17214465
739	Master Kyonshee	PGD-053	7	https://yugipedia.com/wiki/PGD-053	24530661
722	Mirage of Nightmare	PGD-036	7	https://yugipedia.com/wiki/PGD-036	41482598
699	Moisture Creature	PGD-013	7	https://yugipedia.com/wiki/PGD-013	75285069
687	Molten Behemoth	PGD-001	7	https://yugipedia.com/wiki/PGD-001	17192817
697	Mucus Yolk	PGD-011	7	https://yugipedia.com/wiki/PGD-011	70307656
731	Needle Ceiling	PGD-045	7	https://yugipedia.com/wiki/PGD-045	38411870
734	Needle Wall	PGD-048	7	https://yugipedia.com/wiki/PGD-048	38299233
743	Newdoria	PGD-057	7	https://yugipedia.com/wiki/PGD-057	4335645
763	Nightmare Horse	PGD-077	7	https://yugipedia.com/wiki/PGD-077	59290628
728	Ordeal of a Traveler	PGD-042	7	https://yugipedia.com/wiki/PGD-042	39537362
738	Pharaoh's Treasure	PGD-052	7	https://yugipedia.com/wiki/PGD-052	63571750
702	Poison Mummy	PGD-016	7	https://yugipedia.com/wiki/PGD-016	43716289
726	Pyramid Energy	PGD-040	7	https://yugipedia.com/wiki/PGD-040	76754619
712	Pyramid Turtle	PGD-026	7	https://yugipedia.com/wiki/PGD-026	77044671
736	Pyro Clock of Destiny	PGD-050	7	https://yugipedia.com/wiki/PGD-050	1082946
764	Reaper on the Nightmare	PGD-078	7	https://yugipedia.com/wiki/PGD-078	85684223
737	Reckless Greed	PGD-051	7	https://yugipedia.com/wiki/PGD-051	37576645
686	Ring of Destruction	PGD-000	7	https://yugipedia.com/wiki/PGD-000	83555666
704	Royal Keeper	PGD-018	7	https://yugipedia.com/wiki/PGD-018	16509093
701	Sasuke Samurai	PGD-015	7	https://yugipedia.com/wiki/PGD-015	16222645
698	Servant of Catabolism	PGD-012	7	https://yugipedia.com/wiki/PGD-012	2792265
688	Shapesnatch	PGD-002	7	https://yugipedia.com/wiki/PGD-002	4035199
689	Souleater	PGD-003	7	https://yugipedia.com/wiki/PGD-003	31242786
762	Spirit Reaper	PGD-076	7	https://yugipedia.com/wiki/PGD-076	23205979
732	Statue of the Wicked	PGD-046	7	https://yugipedia.com/wiki/PGD-046	65810489
708	Swarm of Locusts	PGD-022	7	https://yugipedia.com/wiki/PGD-022	41872150
707	Swarm of Scarabs	PGD-021	7	https://yugipedia.com/wiki/PGD-021	15383415
696	Timeater	PGD-010	7	https://yugipedia.com/wiki/PGD-010	44913552
725	Timidity	PGD-039	7	https://yugipedia.com/wiki/PGD-039	40350910
735	Trap Dustshoot	PGD-049	7	https://yugipedia.com/wiki/PGD-049	64697231
727	Tutan Mask	PGD-041	7	https://yugipedia.com/wiki/PGD-041	3149764
705	Wandering Mummy	PGD-019	7	https://yugipedia.com/wiki/PGD-019	42994702
758	Winged Sage Falcos	PGD-072	7	https://yugipedia.com/wiki/PGD-072	87523462
757	Yomi Ship	PGD-071	7	https://yugipedia.com/wiki/PGD-071	51534754
771	Buster Rancher	PGD-085	7	https://yugipedia.com/wiki/PGD-085	84740193
789	Byser Shock	PGD-103	7	https://yugipedia.com/wiki/PGD-103	17597059
766	Card Shuffle	PGD-080	7	https://yugipedia.com/wiki/PGD-080	12183332
779	Coffin Seller	PGD-093	7	https://yugipedia.com/wiki/PGD-093	65830223
780	Curse of Aging	PGD-094	7	https://yugipedia.com/wiki/PGD-094	41398771
788	D. Tribe	PGD-102	7	https://yugipedia.com/wiki/PGD-102	2833249
765	Dark Designator	PGD-079	7	https://yugipedia.com/wiki/PGD-079	78053598
768	Dark Room of Nightmare	PGD-082	7	https://yugipedia.com/wiki/PGD-082	85562745
773	Dark Snake Syndrome	PGD-087	7	https://yugipedia.com/wiki/PGD-087	47233801
769	Different Dimension Capsule	PGD-083	7	https://yugipedia.com/wiki/PGD-083	11961740
784	Disturbance Strategy	PGD-098	7	https://yugipedia.com/wiki/PGD-098	77561728
772	Hieroglyph Lithograph	PGD-086	7	https://yugipedia.com/wiki/PGD-086	10248192
793	Lava Golem	PGD-107	7	https://yugipedia.com/wiki/PGD-107	102380
776	Metamorphosis	PGD-090	7	https://yugipedia.com/wiki/PGD-090	46411259
783	Narrow Pass	PGD-097	7	https://yugipedia.com/wiki/PGD-097	40172183
770	Necrovalley	PGD-084	7	https://yugipedia.com/wiki/PGD-084	47355498
787	Non Aggression Area	PGD-101	7	https://yugipedia.com/wiki/PGD-101	76848240
790	Question	PGD-104	7	https://yugipedia.com/wiki/PGD-104	38723936
782	Raigeki Break	PGD-096	7	https://yugipedia.com/wiki/PGD-096	4178474
767	Reasoning	PGD-081	7	https://yugipedia.com/wiki/PGD-081	58577036
778	Reversal Quiz	PGD-092	7	https://yugipedia.com/wiki/PGD-092	5990062
786	Rite of Spirit	PGD-100	7	https://yugipedia.com/wiki/PGD-100	30450531
791	Rope of Life	PGD-105	7	https://yugipedia.com/wiki/PGD-105	93382620
777	Royal Tribute	PGD-091	7	https://yugipedia.com/wiki/PGD-091	72405967
774	Terraforming	PGD-088	7	https://yugipedia.com/wiki/PGD-088	73628505
785	Trap of Board Eraser	PGD-099	7	https://yugipedia.com/wiki/PGD-099	3055837
844	Adhesion Trap Hole	MFC-050	8	https://yugipedia.com/wiki/MFC-050	62325062
828	Ante	MFC-034	8	https://yugipedia.com/wiki/MFC-034	34236961
810	Burning Beast	MFC-016	8	https://yugipedia.com/wiki/MFC-016	59364406
824	Combination Attack	MFC-030	8	https://yugipedia.com/wiki/MFC-030	8964854
813	D.D. Crazy Beast	MFC-019	8	https://yugipedia.com/wiki/MFC-019	48148828
801	Dark Blade	MFC-007	8	https://yugipedia.com/wiki/MFC-007	11321183
829	Dark Core	MFC-035	8	https://yugipedia.com/wiki/MFC-035	70231910
794	Dark Magician Girl	MFC-000	8	https://yugipedia.com/wiki/MFC-000	38033121
804	Decayed Commander	MFC-010	8	https://yugipedia.com/wiki/MFC-010	10209545
823	Demotion	MFC-029	8	https://yugipedia.com/wiki/MFC-029	72575145
809	Des Dendle	MFC-015	8	https://yugipedia.com/wiki/MFC-015	12965761
817	Dimension Jar	MFC-023	8	https://yugipedia.com/wiki/MFC-023	73414375
843	Formation Union	MFC-049	8	https://yugipedia.com/wiki/MFC-049	26931058
811	Freezing Beast	MFC-017	8	https://yugipedia.com/wiki/MFC-017	85359414
806	Giant Orc	MFC-012	8	https://yugipedia.com/wiki/MFC-012	73698349
818	Great Phantom Thief	MFC-024	8	https://yugipedia.com/wiki/MFC-024	10809984
816	Helping Robo For Combat	MFC-022	8	https://yugipedia.com/wiki/MFC-022	47025270
835	Huge Revolution	MFC-041	8	https://yugipedia.com/wiki/MFC-041	65396880
825	Kaiser Colosseum	MFC-031	8	https://yugipedia.com/wiki/MFC-031	35059553
803	Kiryu	MFC-009	8	https://yugipedia.com/wiki/MFC-009	84814897
832	Kishido Spirit	MFC-038	8	https://yugipedia.com/wiki/MFC-038	60519422
831	Metalsilver Armor	MFC-037	8	https://yugipedia.com/wiki/MFC-037	33114323
838	Meteorain	MFC-044	8	https://yugipedia.com/wiki/MFC-044	64274292
815	Neko Mane King	MFC-021	8	https://yugipedia.com/wiki/MFC-021	11021521
796	Oppressed People	MFC-002	8	https://yugipedia.com/wiki/MFC-002	58538870
795	People Running About	MFC-001	8	https://yugipedia.com/wiki/MFC-001	12143771
841	Physical Double	MFC-047	8	https://yugipedia.com/wiki/MFC-047	63442604
839	Pineapple Blast	MFC-045	8	https://yugipedia.com/wiki/MFC-045	90669991
802	Pitch-Dark Dragon	MFC-008	8	https://yugipedia.com/wiki/MFC-008	47415292
827	Poison of the Old Man	MFC-033	8	https://yugipedia.com/wiki/MFC-033	8842266
830	Raregold Armor	MFC-036	8	https://yugipedia.com/wiki/MFC-036	7625614
842	Rivalry of Warlords	MFC-048	8	https://yugipedia.com/wiki/MFC-048	90846359
819	Roulette Barrel	MFC-025	8	https://yugipedia.com/wiki/MFC-025	46303688
807	Second Goblin	MFC-013	8	https://yugipedia.com/wiki/MFC-013	19086954
840	Secret Barrel	MFC-046	8	https://yugipedia.com/wiki/MFC-046	27053506
814	Spell Canceller	MFC-020	8	https://yugipedia.com/wiki/MFC-020	84636823
837	Spell Shield Type-8	MFC-043	8	https://yugipedia.com/wiki/MFC-043	38275183
836	Thunder of Ruler	MFC-042	8	https://yugipedia.com/wiki/MFC-042	91781589
833	Tribute Doll	MFC-039	8	https://yugipedia.com/wiki/MFC-039	2903036
812	Union Rider	MFC-018	8	https://yugipedia.com/wiki/MFC-018	11743119
808	Vampire Orchis	MFC-014	8	https://yugipedia.com/wiki/MFC-014	46571052
834	Wave-Motion Cannon	MFC-040	8	https://yugipedia.com/wiki/MFC-040	38992735
821	White Dragon Ritual	MFC-027	8	https://yugipedia.com/wiki/MFC-027	9786492
798	X-Head Cannon	MFC-004	8	https://yugipedia.com/wiki/MFC-004	62651957
845	XY-Dragon Cannon	MFC-051	8	https://yugipedia.com/wiki/MFC-051	2111707
846	XYZ-Dragon Cannon	MFC-052	8	https://yugipedia.com/wiki/MFC-052	91998119
799	Y-Dragon Head	MFC-005	8	https://yugipedia.com/wiki/MFC-005	65622692
800	Z-Metal Tank	MFC-006	8	https://yugipedia.com/wiki/MFC-006	64500000
805	Zombie Tiger	MFC-011	8	https://yugipedia.com/wiki/MFC-011	47693640
890	Amazoness Archers	MFC-096	8	https://yugipedia.com/wiki/MFC-096	67987611
854	Amazoness Fighter	MFC-060	8	https://yugipedia.com/wiki/MFC-060	55821894
853	Amazoness Paladin	MFC-059	8	https://yugipedia.com/wiki/MFC-059	47480070
878	Amazoness Spellcaster	MFC-084	8	https://yugipedia.com/wiki/MFC-084	81325903
855	Amazoness Swords Woman	MFC-061	8	https://yugipedia.com/wiki/MFC-061	94004268
857	Amazoness Tiger	MFC-063	8	https://yugipedia.com/wiki/MFC-063	10979723
897	Anti-Spell	MFC-103	8	https://yugipedia.com/wiki/MFC-103	53112492
860	Apprentice Magician	MFC-066	8	https://yugipedia.com/wiki/MFC-066	9156135
869	Armor Exe	MFC-075	8	https://yugipedia.com/wiki/MFC-075	7180418
880	Big Bang Shot	MFC-086	8	https://yugipedia.com/wiki/MFC-086	61127349
865	Breaker the Magical Warrior	MFC-071	8	https://yugipedia.com/wiki/MFC-071	71413901
875	Cat's Ear Tribe	MFC-081	8	https://yugipedia.com/wiki/MFC-081	95841282
862	Chaos Command Magician	MFC-068	8	https://yugipedia.com/wiki/MFC-068	72630549
877	Dark Cat with White Tail	MFC-083	8	https://yugipedia.com/wiki/MFC-083	8634636
899	Dark Paladin	MFC-105	8	https://yugipedia.com/wiki/MFC-105	98502113
872	Cliff the Trap Remover	MFC-078	8	https://yugipedia.com/wiki/MFC-078	6967870
871	Des Koala	MFC-077	8	https://yugipedia.com/wiki/MFC-077	69579761
901	Diffusion Wave-Motion	MFC-107	8	https://yugipedia.com/wiki/MFC-107	87880531
896	Disarmament	MFC-102	8	https://yugipedia.com/wiki/MFC-102	20727787
900	Double Spell	MFC-106	8	https://yugipedia.com/wiki/MFC-106	24096228
891	Dramatic Rescue	MFC-097	8	https://yugipedia.com/wiki/MFC-097	80193355
884	Emblem of Dragon Destroyer	MFC-090	8	https://yugipedia.com/wiki/MFC-090	6390406
892	Exhausting Spell	MFC-098	8	https://yugipedia.com/wiki/MFC-098	95451366
881	Gather Your Mind	MFC-087	8	https://yugipedia.com/wiki/MFC-087	7512044
849	Great Angus	MFC-055	8	https://yugipedia.com/wiki/MFC-055	11813953
893	Hidden Book of Spell	MFC-099	8	https://yugipedia.com/wiki/MFC-099	21840375
885	Jar Robber	MFC-091	8	https://yugipedia.com/wiki/MFC-091	33784505
874	Koitsu	MFC-080	8	https://yugipedia.com/wiki/MFC-080	69456283
863	Magical Marionette	MFC-069	8	https://yugipedia.com/wiki/MFC-069	8034697
873	Magical Merchant	MFC-079	8	https://yugipedia.com/wiki/MFC-079	32362575
866	Magical Plant Mandragola	MFC-072	8	https://yugipedia.com/wiki/MFC-072	7802006
867	Magical Scientist	MFC-073	8	https://yugipedia.com/wiki/MFC-073	34206604
882	Mass Driver	MFC-088	8	https://yugipedia.com/wiki/MFC-088	34906152
888	Mega Ton Magical Cannon	MFC-094	8	https://yugipedia.com/wiki/MFC-094	32062913
894	Miracle Restoring	MFC-100	8	https://yugipedia.com/wiki/MFC-100	68334074
886	My Body as a Shield	MFC-092	8	https://yugipedia.com/wiki/MFC-092	69279219
889	Pitch-Black Power Stone	MFC-095	8	https://yugipedia.com/wiki/MFC-095	34029630
864	Pixie Knight	MFC-070	8	https://yugipedia.com/wiki/MFC-070	35429292
895	Remove Brainwashing	MFC-101	8	https://yugipedia.com/wiki/MFC-101	94739788
868	Royal Magical Library	MFC-074	8	https://yugipedia.com/wiki/MFC-074	70791313
883	Senri Eye	MFC-089	8	https://yugipedia.com/wiki/MFC-089	60391791
859	Skilled Dark Magician	MFC-065	8	https://yugipedia.com/wiki/MFC-065	73752131
858	Skilled White Magician	MFC-064	8	https://yugipedia.com/wiki/MFC-064	46363422
851	Sonic Duck	MFC-057	8	https://yugipedia.com/wiki/MFC-057	84696266
887	Pigeonholing Books of Spell	MFC-093	8	https://yugipedia.com/wiki/MFC-093	96677818
898	The Spell Absorbing Life	MFC-104	8	https://yugipedia.com/wiki/MFC-104	99517131
870	Tribe-Infecting Virus	MFC-076	8	https://yugipedia.com/wiki/MFC-076	33184167
876	Ultimate Obedient Fiend	MFC-082	8	https://yugipedia.com/wiki/MFC-082	32240937
847	XZ-Tank Cannon	MFC-053	8	https://yugipedia.com/wiki/MFC-053	99724761
848	YZ-Tank Dragon	MFC-054	8	https://yugipedia.com/wiki/MFC-054	25119460
905	Acrobat Monkey	DCR-EN003	9	https://yugipedia.com/wiki/DCR-EN003	47372349
903	Battle Footballer	DCR-EN001	9	https://yugipedia.com/wiki/DCR-EN001	48094997
921	Berserk Dragon	DCR-EN019	9	https://yugipedia.com/wiki/DCR-EN019	85605684
924	Blindly Loyal Goblin	DCR-EN022	9	https://yugipedia.com/wiki/DCR-EN022	35215622
919	Dark Flare Knight	DCR-EN017	9	https://yugipedia.com/wiki/DCR-EN017	13722870
913	Cyber Raider	DCR-EN011	9	https://yugipedia.com/wiki/DCR-EN011	39978267
916	Des Feral Imp	DCR-EN014	9	https://yugipedia.com/wiki/DCR-EN014	81985784
917	Different Dimension Dragon	DCR-EN015	9	https://yugipedia.com/wiki/DCR-EN015	50939127
925	Despair from the Dark	DCR-EN023	9	https://yugipedia.com/wiki/DCR-EN023	71200730
922	Exodia Necross	DCR-EN020	9	https://yugipedia.com/wiki/DCR-EN020	12600382
910	Guardian Baou	DCR-EN008	9	https://yugipedia.com/wiki/DCR-EN008	73544866
908	Guardian Ceal	DCR-EN006	9	https://yugipedia.com/wiki/DCR-EN006	10755153
907	Guardian Elma	DCR-EN005	9	https://yugipedia.com/wiki/DCR-EN005	74367458
911	Guardian Kay'est	DCR-EN009	9	https://yugipedia.com/wiki/DCR-EN009	9633505
912	Guardian Tryce	DCR-EN010	9	https://yugipedia.com/wiki/DCR-EN010	46037213
923	Gyaku-Gire Panda	DCR-EN021	9	https://yugipedia.com/wiki/DCR-EN021	9817927
915	Little-Winguard	DCR-EN013	9	https://yugipedia.com/wiki/DCR-EN013	90790253
920	Mirage Knight	DCR-EN018	9	https://yugipedia.com/wiki/DCR-EN018	49217579
904	Nin-Ken Dog	DCR-EN002	9	https://yugipedia.com/wiki/DCR-EN002	11987744
914	Reflect Bounder	DCR-EN012	9	https://yugipedia.com/wiki/DCR-EN012	2851070
918	Shinato, King of a Higher Plane	DCR-EN016	9	https://yugipedia.com/wiki/DCR-EN016	86327225
902	Vampire Lord	DCR-EN000	9	https://yugipedia.com/wiki/DCR-EN000	53839837
982	Agido	DCR-EN080	9	https://yugipedia.com/wiki/DCR-EN080	16135253
997	Altar for Tribute	DCR-EN095	9	https://yugipedia.com/wiki/DCR-EN095	21070956
959	Archfiend Soldier	DCR-EN057	9	https://yugipedia.com/wiki/DCR-EN057	49881766
950	Arsenal Robber	DCR-EN048	9	https://yugipedia.com/wiki/DCR-EN048	55348096
999	Battle-Scarred	DCR-EN097	9	https://yugipedia.com/wiki/DCR-EN097	94463200
934	Butterfly Dagger - Elma	DCR-EN032	9	https://yugipedia.com/wiki/DCR-EN032	69243953
992	Cestus of Dagla	DCR-EN090	9	https://yugipedia.com/wiki/DCR-EN090	28106077
991	Checkmate	DCR-EN089	9	https://yugipedia.com/wiki/DCR-EN089	69313735
933	Contract with Exodia	DCR-EN031	9	https://yugipedia.com/wiki/DCR-EN031	33244944
988	Contract with the Abyss	DCR-EN086	9	https://yugipedia.com/wiki/DCR-EN086	69035382
989	Contract with the Dark Master	DCR-EN087	9	https://yugipedia.com/wiki/DCR-EN087	96420087
955	Cost Down	DCR-EN053	9	https://yugipedia.com/wiki/DCR-EN053	23265313
957	D.D. Trainer	DCR-EN055	9	https://yugipedia.com/wiki/DCR-EN055	86498013
929	D.D. Warrior Lady	DCR-EN027	9	https://yugipedia.com/wiki/DCR-EN027	7572887
984	Dark Master - Zorc	DCR-EN082	9	https://yugipedia.com/wiki/DCR-EN082	97642679
928	Dark Scorpion - Chick the Yellow	DCR-EN026	9	https://yugipedia.com/wiki/DCR-EN026	61587183
962	Dark Scorpion - Gorg the Strong	DCR-EN060	9	https://yugipedia.com/wiki/DCR-EN060	48768179
971	Darkbishop Archfiend	DCR-EN069	9	https://yugipedia.com/wiki/DCR-EN069	35798491
972	Desrook Archfiend	DCR-EN070	9	https://yugipedia.com/wiki/DCR-EN070	72192100
946	Different Dimension Gate	DCR-EN044	9	https://yugipedia.com/wiki/DCR-EN044	56460688
986	Dragged Down into the Grave	DCR-EN084	9	https://yugipedia.com/wiki/DCR-EN084	16435215
942	Fairy of the Spring	DCR-EN040	9	https://yugipedia.com/wiki/DCR-EN040	20188127
927	Fear from the Dark	DCR-EN025	9	https://yugipedia.com/wiki/DCR-EN025	34193084
990	Falling Down	DCR-EN088	9	https://yugipedia.com/wiki/DCR-EN088	32919136
947	Final Attack Orders	DCR-EN045	9	https://yugipedia.com/wiki/DCR-EN045	52503575
993	Final Countdown	DCR-EN091	9	https://yugipedia.com/wiki/DCR-EN091	95308449
998	Frozen Soul	DCR-EN096	9	https://yugipedia.com/wiki/DCR-EN096	57069605
956	Gagagigo	DCR-EN054	9	https://yugipedia.com/wiki/DCR-EN054	49003308
967	Goblin of Greed	DCR-EN065	9	https://yugipedia.com/wiki/DCR-EN065	425934
936	Gravity Axe - Grarl	DCR-EN034	9	https://yugipedia.com/wiki/DCR-EN034	32022366
965	Great Maju Garzett	DCR-EN063	9	https://yugipedia.com/wiki/DCR-EN063	47942531
973	Infernalqueen Archfiend	DCR-EN071	9	https://yugipedia.com/wiki/DCR-EN071	8581705
954	Interdimensional Matter Transporter	DCR-EN052	9	https://yugipedia.com/wiki/DCR-EN052	36261276
966	Iron Blacksmith Kotetsu	DCR-EN064	9	https://yugipedia.com/wiki/DCR-EN064	73431236
953	Kaiser Glider	DCR-EN051	9	https://yugipedia.com/wiki/DCR-EN051	52824910
980	Kelbek	DCR-EN078	9	https://yugipedia.com/wiki/DCR-EN078	54878498
979	Keldo	DCR-EN077	9	https://yugipedia.com/wiki/DCR-EN077	80441106
983	Legendary Flame Lord	DCR-EN081	9	https://yugipedia.com/wiki/DCR-EN081	60258960
926	Maju Garzett	DCR-EN024	9	https://yugipedia.com/wiki/DCR-EN024	8794435
968	Mefist the Infernal General	DCR-EN066	9	https://yugipedia.com/wiki/DCR-EN066	46820049
976	Metallizing Parasite - Lunatite	DCR-EN074	9	https://yugipedia.com/wiki/DCR-EN074	7369217
944	Morale Boost	DCR-EN042	9	https://yugipedia.com/wiki/DCR-EN042	93671934
978	Mudora	DCR-EN076	9	https://yugipedia.com/wiki/DCR-EN076	82108372
945	Non-Spellcasting Area	DCR-EN043	9	https://yugipedia.com/wiki/DCR-EN043	20065549
958	Ojama Green	DCR-EN056	9	https://yugipedia.com/wiki/DCR-EN056	12482652
960	Pandemonium Watchbear	DCR-EN058	9	https://yugipedia.com/wiki/DCR-EN058	75375465
949	Ojama Trio	DCR-EN047	9	https://yugipedia.com/wiki/DCR-EN047	29843091
964	Outstanding Dog Marron	DCR-EN062	9	https://yugipedia.com/wiki/DCR-EN062	11548522
996	Pandemonium	DCR-EN094	9	https://yugipedia.com/wiki/DCR-EN094	94585852
940	Precious Cards from Beyond	DCR-EN038	9	https://yugipedia.com/wiki/DCR-EN038	68304813
952	Really Eternal Rest	DCR-EN050	9	https://yugipedia.com/wiki/DCR-EN050	28121403
938	Rod of Silence - Kay'est	DCR-EN036	9	https://yugipedia.com/wiki/DCR-EN036	95515060
941	Rod of the Mind's Eye	DCR-EN039	9	https://yugipedia.com/wiki/DCR-EN039	94793422
961	Sasuke Samurai 2	DCR-EN059	9	https://yugipedia.com/wiki/DCR-EN059	11760174
970	Shadowknight Archfiend	DCR-EN068	9	https://yugipedia.com/wiki/DCR-EN068	9603356
931	Shinato's Ark	DCR-EN029	9	https://yugipedia.com/wiki/DCR-EN029	60365591
951	Skill Drain	DCR-EN049	9	https://yugipedia.com/wiki/DCR-EN049	82732705
975	Skull Archfiend of Lightning	DCR-EN073	9	https://yugipedia.com/wiki/DCR-EN073	61370518
985	Spell Reproduction	DCR-EN083	9	https://yugipedia.com/wiki/DCR-EN083	29228529
948	Staunch Defender	DCR-EN046	9	https://yugipedia.com/wiki/DCR-EN046	92854392
974	Terrorking Archfiend	DCR-EN072	9	https://yugipedia.com/wiki/DCR-EN072	35975813
930	Thousand Needles	DCR-EN028	9	https://yugipedia.com/wiki/DCR-EN028	33977496
943	Token Thanksgiving	DCR-EN041	9	https://yugipedia.com/wiki/DCR-EN041	57182235
977	Tsukuyomi	DCR-EN075	9	https://yugipedia.com/wiki/DCR-EN075	34853266
939	Twin Swords of Flashing Light - Tryce	DCR-EN037	9	https://yugipedia.com/wiki/DCR-EN037	21900719
969	Vilepawn Archfiend	DCR-EN067	9	https://yugipedia.com/wiki/DCR-EN067	73219648
937	Wicked-Breaking Flamberge - Baou	DCR-EN035	9	https://yugipedia.com/wiki/DCR-EN035	68427465
981	Zolga	DCR-EN079	9	https://yugipedia.com/wiki/DCR-EN079	16268841
1077	Sacred Crane	IOC-EN069	10	https://yugipedia.com/wiki/IOC-EN069	30914564
1000	Dark Scorpion Combination	DCR-EN098	9	https://yugipedia.com/wiki/DCR-EN098	20858318
1007	Judgment of Anubis	DCR-EN105	9	https://yugipedia.com/wiki/DCR-EN105	55256016
1002	Dice Re-Roll	DCR-EN100	9	https://yugipedia.com/wiki/DCR-EN100	83241722
1005	Ray of Hope	DCR-EN103	9	https://yugipedia.com/wiki/DCR-EN103	82529174
1004	Sakuretsu Armor	DCR-EN102	9	https://yugipedia.com/wiki/DCR-EN102	56120475
1003	Spell Vanishing	DCR-EN101	9	https://yugipedia.com/wiki/DCR-EN101	29735721
1021	Berserk Gorilla	IOC-EN013	10	https://yugipedia.com/wiki/IOC-EN013	39168895
1055	Big Burn	IOC-EN047	10	https://yugipedia.com/wiki/IOC-EN047	95472621
1012	Big Koala	IOC-EN004	10	https://yugipedia.com/wiki/IOC-EN004	42129512
1033	Black Luster Soldier - Envoy of the Beginning	IOC-EN025	10	https://yugipedia.com/wiki/IOC-EN025	72989439
1056	Blasting the Ruins	IOC-EN048	10	https://yugipedia.com/wiki/IOC-EN048	21466326
1069	Blazing Inpachi	IOC-EN061	10	https://yugipedia.com/wiki/IOC-EN061	5464695
1070	Burning Algae	IOC-EN062	10	https://yugipedia.com/wiki/IOC-EN062	41859700
1037	Bowganian	IOC-EN029	10	https://yugipedia.com/wiki/IOC-EN029	52090844
1060	Chain Disappearance	IOC-EN052	10	https://yugipedia.com/wiki/IOC-EN052	57139487
1044	Chaos End	IOC-EN036	10	https://yugipedia.com/wiki/IOC-EN036	61044390
1046	Chaos Greed	IOC-EN038	10	https://yugipedia.com/wiki/IOC-EN038	97439308
1025	Chaos Necromancer	IOC-EN017	10	https://yugipedia.com/wiki/IOC-EN017	1434352
1031	Chaos Sorcerer	IOC-EN023	10	https://yugipedia.com/wiki/IOC-EN023	9596126
1026	Chaosrider Gustaph	IOC-EN018	10	https://yugipedia.com/wiki/IOC-EN018	47829960
1018	Chopman the Desperate Outlaw	IOC-EN010	10	https://yugipedia.com/wiki/IOC-EN010	40884383
1023	Coach Goblin	IOC-EN015	10	https://yugipedia.com/wiki/IOC-EN015	42541548
1014	Crimson Ninja	IOC-EN006	10	https://yugipedia.com/wiki/IOC-EN006	14618326
1057	Cursed Seal of the Forbidden Spell	IOC-EN049	10	https://yugipedia.com/wiki/IOC-EN049	58851034
1048	D.D. Borderline	IOC-EN040	10	https://yugipedia.com/wiki/IOC-EN040	60912752
1047	D.D. Designator	IOC-EN039	10	https://yugipedia.com/wiki/IOC-EN039	33423043
1020	D.D. Scout Plane	IOC-EN012	10	https://yugipedia.com/wiki/IOC-EN012	3773196
1062	Dark Mirror Force	IOC-EN054	10	https://yugipedia.com/wiki/IOC-EN054	20522190
1013	Des Kangaroo	IOC-EN005	10	https://yugipedia.com/wiki/IOC-EN005	78613627
1034	Drillago	IOC-EN026	10	https://yugipedia.com/wiki/IOC-EN026	99050989
1052	Dimension Distortion	IOC-EN044	10	https://yugipedia.com/wiki/IOC-EN044	95194279
1063	Energy Drain	IOC-EN055	10	https://yugipedia.com/wiki/IOC-EN055	56916805
1028	Fenrir	IOC-EN020	10	https://yugipedia.com/wiki/IOC-EN020	218704
1022	Freed the Brave Wanderer	IOC-EN014	10	https://yugipedia.com/wiki/IOC-EN014	16556849
1039	Fuhma Shuriken	IOC-EN031	10	https://yugipedia.com/wiki/IOC-EN031	9373534
1016	Gale Lizard	IOC-EN008	10	https://yugipedia.com/wiki/IOC-EN008	77491079
1029	Gigantes	IOC-EN021	10	https://yugipedia.com/wiki/IOC-EN021	47606319
1064	Giga Gagagigo	IOC-EN056	10	https://yugipedia.com/wiki/IOC-EN056	43793530
1074	Gora Turtle of Illusion	IOC-EN066	10	https://yugipedia.com/wiki/IOC-EN066	42868711
1032	Gren Maju Da Eiza	IOC-EN024	10	https://yugipedia.com/wiki/IOC-EN024	36584821
1038	Granadora	IOC-EN030	10	https://yugipedia.com/wiki/IOC-EN030	13944422
1027	Inferno	IOC-EN019	10	https://yugipedia.com/wiki/IOC-EN019	74823665
1040	Heart of the Underdog	IOC-EN032	10	https://yugipedia.com/wiki/IOC-EN032	35762283
1035	Lekunga	IOC-EN027	10	https://yugipedia.com/wiki/IOC-EN027	62543393
1065	Mad Dog of Darkness	IOC-EN057	10	https://yugipedia.com/wiki/IOC-EN057	79182538
1075	Manticore of Darkness	IOC-EN067	10	https://yugipedia.com/wiki/IOC-EN067	77121851
1072	Molten Zombie	IOC-EN064	10	https://yugipedia.com/wiki/IOC-EN064	4732017
1066	Neo Bug	IOC-EN058	10	https://yugipedia.com/wiki/IOC-EN058	16587243
1010	Ojama Black	IOC-EN002	10	https://yugipedia.com/wiki/IOC-EN002	79335209
1009	Ojama Yellow	IOC-EN001	10	https://yugipedia.com/wiki/IOC-EN001	42941100
1042	Ojama Delta Hurricane!!	IOC-EN034	10	https://yugipedia.com/wiki/IOC-EN034	8251996
1050	Primal Seed	IOC-EN042	10	https://yugipedia.com/wiki/IOC-EN042	23701465
1049	Recycle	IOC-EN041	10	https://yugipedia.com/wiki/IOC-EN041	96316857
1053	Reload	IOC-EN045	10	https://yugipedia.com/wiki/IOC-EN045	22589918
1019	Sasuke Samurai #3	IOC-EN011	10	https://yugipedia.com/wiki/IOC-EN011	77379481
1030	Silpheed	IOC-EN022	10	https://yugipedia.com/wiki/IOC-EN022	73001017
1054	Soul Absorption	IOC-EN046	10	https://yugipedia.com/wiki/IOC-EN046	68073522
1011	Soul Tiger	IOC-EN003	10	https://yugipedia.com/wiki/IOC-EN003	15734813
1059	Spatial Collapse	IOC-EN051	10	https://yugipedia.com/wiki/IOC-EN051	20644748
1076	Stealth Bird	IOC-EN068	10	https://yugipedia.com/wiki/IOC-EN068	3510565
1017	Spirit of the Pot of Greed	IOC-EN009	10	https://yugipedia.com/wiki/IOC-EN009	4896788
1015	Strike Ninja	IOC-EN007	10	https://yugipedia.com/wiki/IOC-EN007	41006930
1068	Terrorking Salmon	IOC-EN060	10	https://yugipedia.com/wiki/IOC-EN060	78060096
1043	Stumbling	IOC-EN035	10	https://yugipedia.com/wiki/IOC-EN035	34646691
1071	The Thing in the Crater	IOC-EN063	10	https://yugipedia.com/wiki/IOC-EN063	78243409
1051	Thunder Crash	IOC-EN043	10	https://yugipedia.com/wiki/IOC-EN043	69196160
1058	Tower of Babel	IOC-EN050	10	https://yugipedia.com/wiki/IOC-EN050	94256039
1041	Wild Nature's Release	IOC-EN033	10	https://yugipedia.com/wiki/IOC-EN033	61166988
1045	Yellow Luster Shield	IOC-EN037	10	https://yugipedia.com/wiki/IOC-EN037	4542651
1024	Witch Doctor of Chaos	IOC-EN016	10	https://yugipedia.com/wiki/IOC-EN016	75946257
1061	Zero Gravity	IOC-EN053	10	https://yugipedia.com/wiki/IOC-EN053	83133491
1080	Balloon Lizard	IOC-EN072	10	https://yugipedia.com/wiki/IOC-EN072	39892082
1084	Anti-Aircraft Flower	IOC-EN076	10	https://yugipedia.com/wiki/IOC-EN076	65064143
1115	Begone, Knave!	IOC-EN107	10	https://yugipedia.com/wiki/IOC-EN107	20374520
1083	Black Tyranno	IOC-EN075	10	https://yugipedia.com/wiki/IOC-EN075	38670435
1111	Compulsory Evacuation Device	IOC-EN103	10	https://yugipedia.com/wiki/IOC-EN103	94192409
1093	Cannonball Spear Shellfish	IOC-EN085	10	https://yugipedia.com/wiki/IOC-EN085	95614612
1114	Curse of Darkness	IOC-EN106	10	https://yugipedia.com/wiki/IOC-EN106	84970821
1081	Dark Driceratops	IOC-EN073	10	https://yugipedia.com/wiki/IOC-EN073	65287621
1103	Dedication through Light and Darkness	IOC-EN095	10	https://yugipedia.com/wiki/IOC-EN095	69542930
1109	Destruction Ring	IOC-EN101	10	https://yugipedia.com/wiki/IOC-EN101	21219755
1102	Dimension Fusion	IOC-EN094	10	https://yugipedia.com/wiki/IOC-EN094	23557835
1116	DNA Transplant	IOC-EN108	10	https://yugipedia.com/wiki/IOC-EN108	56769674
1079	Don Turtle	IOC-EN071	10	https://yugipedia.com/wiki/IOC-EN071	3493978
1110	Fiend's Hand Mirror	IOC-EN102	10	https://yugipedia.com/wiki/IOC-EN102	58607704
1107	Earth Chant	IOC-EN099	10	https://yugipedia.com/wiki/IOC-EN099	59820352
1097	Getsu Fuhma	IOC-EN089	10	https://yugipedia.com/wiki/IOC-EN089	21887179
1099	Gryphon's Feather Duster	IOC-EN091	10	https://yugipedia.com/wiki/IOC-EN091	34370473
1095	Guardian Angel Joan	IOC-EN087	10	https://yugipedia.com/wiki/IOC-EN087	68007326
1082	Hyper Hammerhead	IOC-EN074	10	https://yugipedia.com/wiki/IOC-EN074	2671330
1088	Insect Princess	IOC-EN080	10	https://yugipedia.com/wiki/IOC-EN080	37957847
1119	Invader of Darkness	IOC-EN111	10	https://yugipedia.com/wiki/IOC-EN111	56647086
1108	Jade Insect Whistle	IOC-EN100	10	https://yugipedia.com/wiki/IOC-EN100	95214051
1091	Levia-Dragon - Daedalus	IOC-EN083	10	https://yugipedia.com/wiki/IOC-EN083	37721209
1094	Mataza the Zapper	IOC-EN086	10	https://yugipedia.com/wiki/IOC-EN086	22609617
1096	Manju of the Ten Thousand Hands	IOC-EN088	10	https://yugipedia.com/wiki/IOC-EN088	95492061
1106	Multiplication of Ants	IOC-EN098	10	https://yugipedia.com/wiki/IOC-EN098	22493811
1092	Orca Mega-Fortress of Darkness	IOC-EN084	10	https://yugipedia.com/wiki/IOC-EN084	63120904
1117	Robbin' Zombie	IOC-EN109	10	https://yugipedia.com/wiki/IOC-EN109	83258273
1086	Pinch Hopper	IOC-EN078	10	https://yugipedia.com/wiki/IOC-EN078	26185991
1098	Ryu Kokki	IOC-EN090	10	https://yugipedia.com/wiki/IOC-EN090	57281778
1104	Salvage	IOC-EN096	10	https://yugipedia.com/wiki/IOC-EN096	96947648
1100	Stray Lambs	IOC-EN092	10	https://yugipedia.com/wiki/IOC-EN092	60764581
1113	Self-Destruct Button	IOC-EN105	10	https://yugipedia.com/wiki/IOC-EN105	57585212
1087	Skull-Mark Ladybug	IOC-EN079	10	https://yugipedia.com/wiki/IOC-EN079	64306248
1101	Smashing Ground	IOC-EN093	10	https://yugipedia.com/wiki/IOC-EN093	97169186
1118	Trap Jammer	IOC-EN110	10	https://yugipedia.com/wiki/IOC-EN110	19252988
1090	Torpedo Fish	IOC-EN082	10	https://yugipedia.com/wiki/IOC-EN082	90337190
1105	Ultra Evolution Pill	IOC-EN097	10	https://yugipedia.com/wiki/IOC-EN097	22431243
1149	Arcane Archer of the Forest	AST-029	11	https://yugipedia.com/wiki/AST-029	55001420
1154	Archlord Zerato	AST-034	11	https://yugipedia.com/wiki/AST-034	18378582
1144	Atomic Firefly	AST-024	11	https://yugipedia.com/wiki/AST-024	87340664
1142	Blowback Dragon	AST-022	11	https://yugipedia.com/wiki/AST-022	25551951
1148	Disc Fighter	AST-028	11	https://yugipedia.com/wiki/AST-028	19612721
1138	Gear Golem the Moving Fortress	AST-018	11	https://yugipedia.com/wiki/AST-018	30190809
1151	Goblin King	AST-031	11	https://yugipedia.com/wiki/AST-031	18590133
1121	Gogiga Gagagigo	AST-001	11	https://yugipedia.com/wiki/AST-001	39674352
1139	KA-2 Des Scissors	AST-019	11	https://yugipedia.com/wiki/AST-019	52768103
1150	Lady Ninja Yae	AST-030	11	https://yugipedia.com/wiki/AST-030	82005435
1137	Legendary Jujitsu Master	AST-017	11	https://yugipedia.com/wiki/AST-017	25773409
1145	Mermaid Knight	AST-025	11	https://yugipedia.com/wiki/AST-025	24435369
1125	Metal Armored Bug	AST-005	11	https://yugipedia.com/wiki/AST-005	65957473
1124	Mystical Shine Ball	AST-004	11	https://yugipedia.com/wiki/AST-004	39552864
1140	Needle Burrower	AST-020	11	https://yugipedia.com/wiki/AST-020	98162242
1146	Piranha Army	AST-026	11	https://yugipedia.com/wiki/AST-026	50823978
1135	Rocket Jumper	AST-015	11	https://yugipedia.com/wiki/AST-015	53890795
1152	Solar Flare Dragon	AST-032	11	https://yugipedia.com/wiki/AST-032	45985838
1141	Sonic Jammer	AST-021	11	https://yugipedia.com/wiki/AST-021	84550200
1131	Soul-Absorbing Bone Tower	AST-011	11	https://yugipedia.com/wiki/AST-011	63012333
1134	Stone Statue of the Aztecs	AST-014	11	https://yugipedia.com/wiki/AST-014	31812496
1128	The Agent of Creation - Venus	AST-008	11	https://yugipedia.com/wiki/AST-008	64734921
1129	The Agent of Force - Mars	AST-009	11	https://yugipedia.com/wiki/AST-009	91123920
1126	The Agent of Judgment - Saturn	AST-006	11	https://yugipedia.com/wiki/AST-006	91345518
1127	The Agent of Wisdom - Mercury	AST-007	11	https://yugipedia.com/wiki/AST-007	38730226
1120	The End of Anubis	AST-000	11	https://yugipedia.com/wiki/AST-000	65403020
1132	The Kick Man	AST-012	11	https://yugipedia.com/wiki/AST-012	90407382
1130	The Unhappy Girl	AST-010	11	https://yugipedia.com/wiki/AST-010	27618634
1133	Vampire Lady	AST-013	11	https://yugipedia.com/wiki/AST-013	26495087
1122	Warrior of Zera	AST-002	11	https://yugipedia.com/wiki/AST-002	66073051
1153	White Magician Pikeru	AST-033	11	https://yugipedia.com/wiki/AST-033	81383947
1143	Zaborg the Thunder Monarch	AST-023	11	https://yugipedia.com/wiki/AST-023	51945556
1211	7	AST-091	11	https://yugipedia.com/wiki/AST-091	67048711
1192	Absorbing Kid from the Sky	AST-072	11	https://yugipedia.com/wiki/AST-072	49771608
1160	Amplifier	AST-040	11	https://yugipedia.com/wiki/AST-040	303660
1175	Armor Break	AST-055	11	https://yugipedia.com/wiki/AST-055	79649195
1166	Backfire	AST-046	11	https://yugipedia.com/wiki/AST-046	82705573
1173	Beckoning Light	AST-053	11	https://yugipedia.com/wiki/AST-053	16255442
1210	Blessings of the Nile	AST-090	11	https://yugipedia.com/wiki/AST-090	30653113
1158	Burst Stream of Destruction	AST-038	11	https://yugipedia.com/wiki/AST-038	17655904
1225	Curse of Anubis	AST-105	11	https://yugipedia.com/wiki/AST-105	66742250
1215	Dark Magic Attack	AST-095	11	https://yugipedia.com/wiki/AST-095	2314238
1216	Delta Attacker	AST-096	11	https://yugipedia.com/wiki/AST-096	39719977
1227	Des Counterblow	AST-107	11	https://yugipedia.com/wiki/AST-107	39131963
1226	Desert Sunlight	AST-106	11	https://yugipedia.com/wiki/AST-106	93747864
1188	Desertapir	AST-068	11	https://yugipedia.com/wiki/AST-068	13409151
1222	Dora of Fate	AST-102	11	https://yugipedia.com/wiki/AST-102	67464807
1198	Double Coston	AST-078	11	https://yugipedia.com/wiki/AST-078	44436472
1174	Draining Shield	AST-054	11	https://yugipedia.com/wiki/AST-054	43250041
1207	Dust Barrier	AST-087	11	https://yugipedia.com/wiki/AST-087	31476755
1193	Elephant Statue of Blessing	AST-073	11	https://yugipedia.com/wiki/AST-073	85166216
1194	Elephant Statue of Disaster	AST-074	11	https://yugipedia.com/wiki/AST-074	12160911
1196	Emissary of the Afterlife	AST-076	11	https://yugipedia.com/wiki/AST-076	75043725
1203	Emissary of the Oasis	AST-083	11	https://yugipedia.com/wiki/AST-083	6103294
1213	Enchanting Fitting Room	AST-093	11	https://yugipedia.com/wiki/AST-093	30531525
1157	Enemy Controller	AST-037	11	https://yugipedia.com/wiki/AST-037	98045062
1179	Fiend Scorpion	AST-059	11	https://yugipedia.com/wiki/AST-059	26566878
1191	Ghost Knight of Jackal	AST-071	11	https://yugipedia.com/wiki/AST-071	13386503
1176	Gigobyte	AST-056	11	https://yugipedia.com/wiki/AST-056	53776525
1165	Goblin Thief	AST-045	11	https://yugipedia.com/wiki/AST-045	45311864
1197	Grave Protector	AST-077	11	https://yugipedia.com/wiki/AST-077	11448373
1223	Judgment of the Desert	AST-103	11	https://yugipedia.com/wiki/AST-103	4869446
1202	King of the Swamp	AST-082	11	https://yugipedia.com/wiki/AST-082	79109599
1178	Kozaky	AST-058	11	https://yugipedia.com/wiki/AST-058	99171160
1228	Labyrinth of Nightmare	AST-108	11	https://yugipedia.com/wiki/AST-108	66526672
1187	Legacy Hunter	AST-067	11	https://yugipedia.com/wiki/AST-067	87010442
1212	Level Limit - Area B	AST-092	11	https://yugipedia.com/wiki/AST-092	3136426
1168	Light of Judgment	AST-048	11	https://yugipedia.com/wiki/AST-048	44595286
1201	Man-Thro' Tro'	AST-081	11	https://yugipedia.com/wiki/AST-081	43714890
1231	Mazera DeVille	AST-111	11	https://yugipedia.com/wiki/AST-111	6133894
1167	Micro Ray	AST-047	11	https://yugipedia.com/wiki/AST-047	18190572
1177	Mokey Mokey	AST-057	11	https://yugipedia.com/wiki/AST-057	27288416
1159	Monster Gate	AST-039	11	https://yugipedia.com/wiki/AST-039	43040603
1156	Mystik Wok	AST-036	11	https://yugipedia.com/wiki/AST-036	80161395
1200	Night Assailant	AST-080	11	https://yugipedia.com/wiki/AST-080	16226786
1186	Nubian Guard	AST-066	11	https://yugipedia.com/wiki/AST-066	51616747
1155	Opti-Camouflage Armor	AST-035	11	https://yugipedia.com/wiki/AST-035	44762290
1205	Order to Charge	AST-085	11	https://yugipedia.com/wiki/AST-085	78986941
1230	Order to Smash	AST-110	11	https://yugipedia.com/wiki/AST-110	39019325
1180	Pharaoh's Servant	AST-060	11	https://yugipedia.com/wiki/AST-060	52550973
1181	Pharaonic Protector	AST-061	11	https://yugipedia.com/wiki/AST-061	89959682
1185	Protector of the Sanctuary	AST-065	11	https://yugipedia.com/wiki/AST-065	24221739
1199	Regenerating Mummy	AST-079	11	https://yugipedia.com/wiki/AST-079	70821187
1189	Sand Gambler	AST-069	11	https://yugipedia.com/wiki/AST-069	50593156
1171	Solar Ray	AST-051	11	https://yugipedia.com/wiki/AST-051	44472639
1229	Soul Resurrection	AST-109	11	https://yugipedia.com/wiki/AST-109	92924317
1208	Soul Reversal	AST-088	11	https://yugipedia.com/wiki/AST-088	78864369
1204	Special Hurricane	AST-084	11	https://yugipedia.com/wiki/AST-084	42598242
1209	Spell Economics	AST-089	11	https://yugipedia.com/wiki/AST-089	4259068
1195	Spirit Caller	AST-075	11	https://yugipedia.com/wiki/AST-075	48659020
1206	Sword of the Soul-Eater	AST-086	11	https://yugipedia.com/wiki/AST-086	5371656
1169	Talisman of Spell Sealing	AST-049	11	https://yugipedia.com/wiki/AST-049	71983925
1164	Talisman of Trap Sealing	AST-044	11	https://yugipedia.com/wiki/AST-044	19312169
1221	The First Sarcophagus	AST-101	11	https://yugipedia.com/wiki/AST-101	31076103
1214	The Law of the Normal	AST-094	11	https://yugipedia.com/wiki/AST-094	66926224
1162	The Sanctuary in the Sky	AST-042	11	https://yugipedia.com/wiki/AST-042	56433456
1220	The Second Sarcophagus	AST-100	11	https://yugipedia.com/wiki/AST-100	4081094
1219	The Third Sarcophagus	AST-099	11	https://yugipedia.com/wiki/AST-099	78697395
1183	Theban Nightmare	AST-063	11	https://yugipedia.com/wiki/AST-063	51838385
1217	Thousand Energy	AST-097	11	https://yugipedia.com/wiki/AST-097	5703682
1218	Triangle Power	AST-098	11	https://yugipedia.com/wiki/AST-098	32298781
1170	Wall of Revealing Light	AST-050	11	https://yugipedia.com/wiki/AST-050	17078030
1161	Weapon Change	AST-041	11	https://yugipedia.com/wiki/AST-041	10035717
1233	Neo Aqua Madoor	SOD-EN002	12	https://yugipedia.com/wiki/SOD-EN002	49563947
1232	Charcoal Inpachi	SOD-EN001	12	https://yugipedia.com/wiki/SOD-EN001	13179332
1234	Skull Dog Marron	SOD-EN003	12	https://yugipedia.com/wiki/SOD-EN003	86652646
1244	Armed Dragon LV3	SOD-EN013	12	https://yugipedia.com/wiki/SOD-EN013	980973
1271	Abyssal Designator	SOD-EN040	12	https://yugipedia.com/wiki/SOD-EN040	89801755
1277	Big Wave Small Wave	SOD-EN046	12	https://yugipedia.com/wiki/SOD-EN046	51562916
1245	Armed Dragon LV5	SOD-EN014	12	https://yugipedia.com/wiki/SOD-EN014	46384672
1246	Armed Dragon LV7	SOD-EN015	12	https://yugipedia.com/wiki/SOD-EN015	73879377
1248	Red-Eyes B. Chick	SOD-EN017	12	https://yugipedia.com/wiki/SOD-EN017	36262024
1268	Dark Factory of Mass Production	SOD-EN037	12	https://yugipedia.com/wiki/SOD-EN037	90928333
1240	Dark Mimic LV1	SOD-EN009	12	https://yugipedia.com/wiki/SOD-EN009	74713516
1254	Element Dragon	SOD-EN023	12	https://yugipedia.com/wiki/SOD-EN023	30314994
1241	Dark Mimic LV3	SOD-EN010	12	https://yugipedia.com/wiki/SOD-EN010	1102515
1274	Ectoplasmer	SOD-EN043	12	https://yugipedia.com/wiki/SOD-EN043	97342942
1255	Element Soldier	SOD-EN024	12	https://yugipedia.com/wiki/SOD-EN024	66712593
1262	Enraged Muka Muka	SOD-EN031	12	https://yugipedia.com/wiki/SOD-EN031	91862578
1284	Enervating Mist	SOD-EN053	12	https://yugipedia.com/wiki/SOD-EN053	26022485
1278	Fusion Weapon	SOD-EN047	12	https://yugipedia.com/wiki/SOD-EN047	27967615
1235	Goblin Calligrapher	SOD-EN004	12	https://yugipedia.com/wiki/SOD-EN004	12057781
1263	Hade-Hane	SOD-EN032	12	https://yugipedia.com/wiki/SOD-EN032	28357177
1289	Gorgon's Eye	SOD-EN058	12	https://yugipedia.com/wiki/SOD-EN058	52648457
1286	Greed	SOD-EN055	12	https://yugipedia.com/wiki/SOD-EN055	89405199
1247	Horus' Servant	SOD-EN016	12	https://yugipedia.com/wiki/SOD-EN016	9264485
1269	Hammer Shot	SOD-EN038	12	https://yugipedia.com/wiki/SOD-EN038	26412047
1285	Heavy Slump	SOD-EN054	12	https://yugipedia.com/wiki/SOD-EN054	52417194
1237	Horus the Black Flame Dragon LV4	SOD-EN006	12	https://yugipedia.com/wiki/SOD-EN006	75830094
1238	Horus the Black Flame Dragon LV6	SOD-EN007	12	https://yugipedia.com/wiki/SOD-EN007	11224103
1239	Horus the Black Flame Dragon LV8	SOD-EN008	12	https://yugipedia.com/wiki/SOD-EN008	48229808
1256	Howling Insect	SOD-EN025	12	https://yugipedia.com/wiki/SOD-EN025	93107608
1272	Level Up!	SOD-EN041	12	https://yugipedia.com/wiki/SOD-EN041	25290459
1273	Inferno Fire Blast	SOD-EN042	12	https://yugipedia.com/wiki/SOD-EN042	52684508
1249	Malice Doll of Demise	SOD-EN018	12	https://yugipedia.com/wiki/SOD-EN018	72657739
1257	Masked Dragon	SOD-EN026	12	https://yugipedia.com/wiki/SOD-EN026	39191307
1261	Nobleman-Eater Bug	SOD-EN030	12	https://yugipedia.com/wiki/SOD-EN030	65878864
1266	Master of Oz	SOD-EN035	12	https://yugipedia.com/wiki/SOD-EN035	27134689
1287	Mind Crush	SOD-EN056	12	https://yugipedia.com/wiki/SOD-EN056	15800838
1270	Mind Wipe	SOD-EN039	12	https://yugipedia.com/wiki/SOD-EN039	52817046
1253	Mobius the Frost Monarch	SOD-EN022	12	https://yugipedia.com/wiki/SOD-EN022	4929256
1288	Null and Void	SOD-EN057	12	https://yugipedia.com/wiki/SOD-EN057	80863132
1242	Mystic Swordsman LV2	SOD-EN011	12	https://yugipedia.com/wiki/SOD-EN011	47507260
1243	Mystic Swordsman LV4	SOD-EN012	12	https://yugipedia.com/wiki/SOD-EN012	74591968
1250	Ninja Grandmaster Sasuke	SOD-EN019	12	https://yugipedia.com/wiki/SOD-EN019	4041838
1283	Ninjitsu Art of Decoy	SOD-EN052	12	https://yugipedia.com/wiki/SOD-EN052	89628781
1267	Sanwitch	SOD-EN036	12	https://yugipedia.com/wiki/SOD-EN036	53539634
1265	Ojama King	SOD-EN034	12	https://yugipedia.com/wiki/SOD-EN034	90140980
1264	Penumbral Soldier Lady	SOD-EN033	12	https://yugipedia.com/wiki/SOD-EN033	64751286
1279	Ritual Weapon	SOD-EN048	12	https://yugipedia.com/wiki/SOD-EN048	54351224
1260	The Trojan Horse	SOD-EN029	12	https://yugipedia.com/wiki/SOD-EN029	38479725
1282	Spirit Barrier	SOD-EN051	12	https://yugipedia.com/wiki/SOD-EN051	53239672
1280	Taunt	SOD-EN049	12	https://yugipedia.com/wiki/SOD-EN049	90740329
1275	The Graveyard in the Fourth Dimension	SOD-EN044	12	https://yugipedia.com/wiki/SOD-EN044	88089103
1252	Ultimate Baseball Kid	SOD-EN021	12	https://yugipedia.com/wiki/SOD-EN021	67934141
1276	Two-Man Cell Battle	SOD-EN045	12	https://yugipedia.com/wiki/SOD-EN045	25578802
1259	Unshaven Angler	SOD-EN028	12	https://yugipedia.com/wiki/SOD-EN028	92084010
1236	Ultimate Insect LV1	SOD-EN005	12	https://yugipedia.com/wiki/SOD-EN005	49441499
1294	Bokoichi the Freightening Car	RDS-EN003	13	https://yugipedia.com/wiki/RDS-EN003	8715625
1304	Element Magician	RDS-EN013	13	https://yugipedia.com/wiki/RDS-EN013	65260293
1305	Element Saurus	RDS-EN014	13	https://yugipedia.com/wiki/RDS-EN014	92755808
1295	Harpie Girl	RDS-EN004	13	https://yugipedia.com/wiki/RDS-EN004	34100324
1309	Harpie Lady 2	RDS-EN018	13	https://yugipedia.com/wiki/RDS-EN018	27927359
1310	Harpie Lady 3	RDS-EN019	13	https://yugipedia.com/wiki/RDS-EN019	54415063
1302	Heavy Mech Support Platform	RDS-EN011	13	https://yugipedia.com/wiki/RDS-EN011	23265594
1293	Mighty Guard	RDS-EN002	13	https://yugipedia.com/wiki/RDS-EN002	62327910
1301	Nightmare Penguin	RDS-EN010	13	https://yugipedia.com/wiki/RDS-EN010	81306586
1299	Mystic Swordsman LV6	RDS-EN008	13	https://yugipedia.com/wiki/RDS-EN008	60482781
1297	The Creator Incarnate	RDS-EN006	13	https://yugipedia.com/wiki/RDS-EN006	97093037
1303	Perfect Machine King	RDS-EN012	13	https://yugipedia.com/wiki/RDS-EN012	18891691
1307	Sasuke Samurai #4	RDS-EN016	13	https://yugipedia.com/wiki/RDS-EN016	64538655
1300	Silent Swordsman LV3	RDS-EN009	13	https://yugipedia.com/wiki/RDS-EN009	1995985
1296	The Creator	RDS-EN005	13	https://yugipedia.com/wiki/RDS-EN005	61505339
1292	Woodborg Inpachi	RDS-EN001	13	https://yugipedia.com/wiki/RDS-EN001	35322812
1298	Ultimate Insect LV3	RDS-EN007	13	https://yugipedia.com/wiki/RDS-EN007	34088136
1350	Astral Barrier	RDS-EN059	13	https://yugipedia.com/wiki/RDS-EN059	37053871
1337	Ballista of Rampart Smashing	RDS-EN046	13	https://yugipedia.com/wiki/RDS-EN046	242146
1321	Big Core	RDS-EN030	13	https://yugipedia.com/wiki/RDS-EN030	14148099
1335	Back to Square One	RDS-EN044	13	https://yugipedia.com/wiki/RDS-EN044	47453433
1316	Creeping Doom Manta	RDS-EN025	13	https://yugipedia.com/wiki/RDS-EN025	52571838
1347	Chain Burst	RDS-EN056	13	https://yugipedia.com/wiki/RDS-EN056	48276469
1313	Eagle Eye	RDS-EN022	13	https://yugipedia.com/wiki/RDS-EN022	53693416
1326	Dark Blade the Dragon Knight	RDS-EN035	13	https://yugipedia.com/wiki/RDS-EN035	86805855
1323	Dekoichi the Battlechanted Locomotive	RDS-EN032	13	https://yugipedia.com/wiki/RDS-EN032	87621407
1341	Divine Wrath	RDS-EN050	13	https://yugipedia.com/wiki/RDS-EN050	49010598
1320	Fox Fire	RDS-EN029	13	https://yugipedia.com/wiki/RDS-EN029	88753985
1333	Flint	RDS-EN042	13	https://yugipedia.com/wiki/RDS-EN042	75560629
1329	Harpies' Hunting Ground	RDS-EN038	13	https://yugipedia.com/wiki/RDS-EN038	75782277
1344	Fruits of Kozaky's Studies	RDS-EN053	13	https://yugipedia.com/wiki/RDS-EN053	49998907
1346	Fuh-Rin-Ka-Zan	RDS-EN055	13	https://yugipedia.com/wiki/RDS-EN055	1781310
1319	Gaia Soul the Combustible Collective	RDS-EN028	13	https://yugipedia.com/wiki/RDS-EN028	51355346
1325	Homunculus the Alchemic Being	RDS-EN034	13	https://yugipedia.com/wiki/RDS-EN034	40410110
1315	Invasion of Flames	RDS-EN024	13	https://yugipedia.com/wiki/RDS-EN024	26082229
1339	Malice Dispersion	RDS-EN048	13	https://yugipedia.com/wiki/RDS-EN048	13626450
1338	Lighten the Load	RDS-EN047	13	https://yugipedia.com/wiki/RDS-EN047	37231841
1332	Machine Duplication	RDS-EN041	13	https://yugipedia.com/wiki/RDS-EN041	63995093
1318	Mirage Dragon	RDS-EN027	13	https://yugipedia.com/wiki/RDS-EN027	15960641
1345	Mind Haxorz	RDS-EN054	13	https://yugipedia.com/wiki/RDS-EN054	75392615
1327	Mokey Mokey King	RDS-EN036	13	https://yugipedia.com/wiki/RDS-EN036	13803864
1317	Pitch-Black Warwolf	RDS-EN026	13	https://yugipedia.com/wiki/RDS-EN026	88975532
1334	Mokey Mokey Smackdown	RDS-EN043	13	https://yugipedia.com/wiki/RDS-EN043	1965724
1336	Monster Reincarnation	RDS-EN045	13	https://yugipedia.com/wiki/RDS-EN045	74848038
1331	Necklace of Command	RDS-EN040	13	https://yugipedia.com/wiki/RDS-EN040	48576971
1311	Raging Flame Sprite	RDS-EN020	13	https://yugipedia.com/wiki/RDS-EN020	90810762
1349	Spell Purification	RDS-EN058	13	https://yugipedia.com/wiki/RDS-EN058	1669772
1343	Rare Metalmorph	RDS-EN052	13	https://yugipedia.com/wiki/RDS-EN052	12503902
1328	Serial Spell	RDS-EN037	13	https://yugipedia.com/wiki/RDS-EN037	49398568
1314	Tactical Espionage Expert	RDS-EN023	13	https://yugipedia.com/wiki/RDS-EN023	89698120
1377	Abare Ushioni	FET-EN026	14	https://yugipedia.com/wiki/FET-EN026	89718302
1312	Thestalos the Firestorm Monarch	RDS-EN021	13	https://yugipedia.com/wiki/RDS-EN021	26205777
1340	Tragedy	RDS-EN049	13	https://yugipedia.com/wiki/RDS-EN049	35686188
1330	Triangle Ecstasy Spark	RDS-EN039	13	https://yugipedia.com/wiki/RDS-EN039	12181376
1342	Xing Zhen Hu	RDS-EN051	13	https://yugipedia.com/wiki/RDS-EN051	76515293
1374	Armed Samurai - Ben Kei	FET-EN023	14	https://yugipedia.com/wiki/FET-EN023	84430950
1369	Blade Rabbit	FET-EN018	14	https://yugipedia.com/wiki/FET-EN018	58268433
1365	Behemoth the King of All Animals	FET-EN014	14	https://yugipedia.com/wiki/FET-EN014	22996376
1366	Big-Tusked Mammoth	FET-EN015	14	https://yugipedia.com/wiki/FET-EN015	59380081
1364	Catnipped Kitty	FET-EN013	14	https://yugipedia.com/wiki/FET-EN013	96501677
1371	Blast Magician	FET-EN020	14	https://yugipedia.com/wiki/FET-EN020	21051146
1354	Chu-Ske the Mouse Fighter	FET-EN003	14	https://yugipedia.com/wiki/FET-EN003	8508055
1372	Chiron the Mage	FET-EN021	14	https://yugipedia.com/wiki/FET-EN021	16956455
1353	Divine Dragon Ragnarok	FET-EN002	14	https://yugipedia.com/wiki/FET-EN002	62113340
1362	Element Doom	FET-EN011	14	https://yugipedia.com/wiki/FET-EN011	23118924
1361	Element Valkyrie	FET-EN010	14	https://yugipedia.com/wiki/FET-EN010	97623219
1383	Firebird	FET-EN032	14	https://yugipedia.com/wiki/FET-EN032	87473172
1382	Flame Ruler	FET-EN031	14	https://yugipedia.com/wiki/FET-EN031	41089128
1376	Golem Sentry	FET-EN025	14	https://yugipedia.com/wiki/FET-EN025	52323207
1373	Gearfried the Swordmaster	FET-EN022	14	https://yugipedia.com/wiki/FET-EN022	57046845
1357	Hand of Nephthys	FET-EN006	14	https://yugipedia.com/wiki/FET-EN006	98446407
1360	Granmarg the Rock Monarch	FET-EN009	14	https://yugipedia.com/wiki/FET-EN009	60229110
1368	Hyena	FET-EN017	14	https://yugipedia.com/wiki/FET-EN017	22873798
1355	Insect Knight	FET-EN004	14	https://yugipedia.com/wiki/FET-EN004	35052053
1367	Kangaroo Champ	FET-EN016	14	https://yugipedia.com/wiki/FET-EN016	95789089
1363	Maji-Gire Panda	FET-EN012	14	https://yugipedia.com/wiki/FET-EN012	60102563
1384	Rescue Cat	FET-EN033	14	https://yugipedia.com/wiki/FET-EN033	14878871
1352	Space Mambo	FET-EN001	14	https://yugipedia.com/wiki/FET-EN001	36119641
1356	Sacred Phoenix of Nephthys	FET-EN005	14	https://yugipedia.com/wiki/FET-EN005	61441708
1375	Shadowslayer	FET-EN024	14	https://yugipedia.com/wiki/FET-EN024	20939559
1359	Silent Swordsman LV5	FET-EN008	14	https://yugipedia.com/wiki/FET-EN008	74388798
1379	The Dark - Hex-Sealed Fusion	FET-EN028	14	https://yugipedia.com/wiki/FET-EN028	52101615
1380	The Earth - Hex-Sealed Fusion	FET-EN029	14	https://yugipedia.com/wiki/FET-EN029	88696724
1378	The Light - Hex-Sealed Fusion	FET-EN027	14	https://yugipedia.com/wiki/FET-EN027	15717011
1381	Whirlwind Prodigy	FET-EN030	14	https://yugipedia.com/wiki/FET-EN030	15090429
1396	Centrifugal Field	FET-EN045	14	https://yugipedia.com/wiki/FET-EN045	1801154
1407	Assault on GHQ	FET-EN056	14	https://yugipedia.com/wiki/FET-EN056	62633180
1408	D.D. Dynamite	FET-EN057	14	https://yugipedia.com/wiki/FET-EN057	8628798
1400	Cross Counter	FET-EN049	14	https://yugipedia.com/wiki/FET-EN049	37083210
1410	Elemental Burst	FET-EN059	14	https://yugipedia.com/wiki/FET-EN059	61411502
1409	Deck Devastation Virus	FET-EN058	14	https://yugipedia.com/wiki/FET-EN058	35027493
1397	Fulfillment of the Contract	FET-EN046	14	https://yugipedia.com/wiki/FET-EN046	48206762
1411	Forced Ceasefire	FET-EN060	14	https://yugipedia.com/wiki/FET-EN060	97806240
1405	Good Goblin Housekeeping	FET-EN054	14	https://yugipedia.com/wiki/FET-EN054	9744376
1386	Gatling Dragon	FET-EN035	14	https://yugipedia.com/wiki/FET-EN035	87751584
1389	Poison Fangs	FET-EN038	14	https://yugipedia.com/wiki/FET-EN038	76539047
1387	King Dragun	FET-EN036	14	https://yugipedia.com/wiki/FET-EN036	13756293
1391	Lightning Vortex	FET-EN040	14	https://yugipedia.com/wiki/FET-EN040	69162969
1392	Meteor of Destruction	FET-EN041	14	https://yugipedia.com/wiki/FET-EN041	33767325
1402	Penalty Game!	FET-EN051	14	https://yugipedia.com/wiki/FET-EN051	967928
1401	Pole Position	FET-EN050	14	https://yugipedia.com/wiki/FET-EN050	73578229
1398	Re-Fusion	FET-EN047	14	https://yugipedia.com/wiki/FET-EN047	74694807
1395	Release Restraint	FET-EN044	14	https://yugipedia.com/wiki/FET-EN044	75417459
1399	The Big March of Animals	FET-EN048	14	https://yugipedia.com/wiki/FET-EN048	1689516
1390	Spell Absorption	FET-EN039	14	https://yugipedia.com/wiki/FET-EN039	51481927
1394	Spiral Spear Strike	FET-EN043	14	https://yugipedia.com/wiki/FET-EN043	49328340
1393	Swords of Concealing Light	FET-EN042	14	https://yugipedia.com/wiki/FET-EN042	12923641
1403	Threatening Roar	FET-EN052	14	https://yugipedia.com/wiki/FET-EN052	36361633
1419	Ancient Gear Soldier	TLM-EN008	15	https://yugipedia.com/wiki/TLM-EN008	56094445
1418	Ancient Gear Beast	TLM-EN007	15	https://yugipedia.com/wiki/TLM-EN007	10509340
1417	Ancient Gear Golem	TLM-EN006	15	https://yugipedia.com/wiki/TLM-EN006	83104731
1437	Aussa the Earth Charmer	TLM-EN026	15	https://yugipedia.com/wiki/TLM-EN026	37970940
1452	Battery Charger	TLM-EN041	15	https://yugipedia.com/wiki/TLM-EN041	61181383
1441	Batteryman AA	TLM-EN030	15	https://yugipedia.com/wiki/TLM-EN030	63142001
1442	Des Wombat	TLM-EN031	15	https://yugipedia.com/wiki/TLM-EN031	9637706
1448	Card of Sanctity	TLM-EN037	15	https://yugipedia.com/wiki/TLM-EN037	42664989
1424	Criosphinx	TLM-EN013	15	https://yugipedia.com/wiki/TLM-EN013	18654201
1434	D.D. Survivor	TLM-EN023	15	https://yugipedia.com/wiki/TLM-EN023	48092532
1454	Doriado's Blessing	TLM-EN043	15	https://yugipedia.com/wiki/TLM-EN043	23965037
1451	Double Attack	TLM-EN040	15	https://yugipedia.com/wiki/TLM-EN040	34187685
1427	Dummy Golem	TLM-EN016	15	https://yugipedia.com/wiki/TLM-EN016	13532663
1412	Elemental Hero Avian	TLM-EN001	15	https://yugipedia.com/wiki/TLM-EN001	21844577
1414	Elemental Hero Clayman	TLM-EN003	15	https://yugipedia.com/wiki/TLM-EN003	84327329
1415	Elemental Hero Sparkman	TLM-EN004	15	https://yugipedia.com/wiki/TLM-EN004	20721928
1446	Elemental Hero Flame Wingman	TLM-EN035	15	https://yugipedia.com/wiki/TLM-EN035	35809262
1438	Eria the Water Charmer	TLM-EN027	15	https://yugipedia.com/wiki/TLM-EN027	74364659
1447	Elemental Hero Thunder Giant	TLM-EN036	15	https://yugipedia.com/wiki/TLM-EN036	61204971
1445	Elemental Mistress Doriado	TLM-EN034	15	https://yugipedia.com/wiki/TLM-EN034	99414168
1455	Final Ritual of the Ancients	TLM-EN044	15	https://yugipedia.com/wiki/TLM-EN044	60369732
1450	Gift of the Martyr	TLM-EN039	15	https://yugipedia.com/wiki/TLM-EN039	98792570
1432	Guardian Statue	TLM-EN021	15	https://yugipedia.com/wiki/TLM-EN021	75209824
1428	Grave Ohja	TLM-EN017	15	https://yugipedia.com/wiki/TLM-EN017	40937767
1459	Impenetrable Formation	TLM-EN048	15	https://yugipedia.com/wiki/TLM-EN048	96631852
1460	Hero Signal	TLM-EN049	15	https://yugipedia.com/wiki/TLM-EN049	22020907
1423	Hieracosphinx	TLM-EN012	15	https://yugipedia.com/wiki/TLM-EN012	82260502
1453	Kaminote Blow	TLM-EN042	15	https://yugipedia.com/wiki/TLM-EN042	97570038
1443	King of the Skull Servants	TLM-EN032	15	https://yugipedia.com/wiki/TLM-EN032	36021814
1422	Lost Guardian	TLM-EN011	15	https://yugipedia.com/wiki/TLM-EN011	45871897
1456	Legendary Black Belt	TLM-EN045	15	https://yugipedia.com/wiki/TLM-EN045	96458440
1433	Medusa Worm	TLM-EN022	15	https://yugipedia.com/wiki/TLM-EN022	2694423
1431	Master Monk	TLM-EN020	15	https://yugipedia.com/wiki/TLM-EN020	49814180
1429	Mine Golem	TLM-EN018	15	https://yugipedia.com/wiki/TLM-EN018	76321376
1426	Megarock Dragon	TLM-EN015	15	https://yugipedia.com/wiki/TLM-EN015	71544954
1435	Mid Shield Gardna	TLM-EN024	15	https://yugipedia.com/wiki/TLM-EN024	75487237
1420	Millennium Scorpion	TLM-EN009	15	https://yugipedia.com/wiki/TLM-EN009	82482194
1430	Monk Fighter	TLM-EN019	15	https://yugipedia.com/wiki/TLM-EN019	3810071
1461	Pikeru's Second Sight	TLM-EN050	15	https://yugipedia.com/wiki/TLM-EN050	58015506
1457	Nitro Unit	TLM-EN046	15	https://yugipedia.com/wiki/TLM-EN046	23842445
1458	Shifting Shadows	TLM-EN047	15	https://yugipedia.com/wiki/TLM-EN047	59237154
1444	Reshef the Dark Being	TLM-EN033	15	https://yugipedia.com/wiki/TLM-EN033	62420419
1436	White Ninja	TLM-EN025	15	https://yugipedia.com/wiki/TLM-EN025	1571945
1421	Ultimate Insect LV7	TLM-EN010	15	https://yugipedia.com/wiki/TLM-EN010	19877898
1440	Wynn the Wind Charmer	TLM-EN029	15	https://yugipedia.com/wiki/TLM-EN029	37744402
1416	Winged Kuriboh	TLM-EN005	15	https://yugipedia.com/wiki/TLM-EN005	57116034
28	Aqua Madoor	LOB-EN027	1	https://yugipedia.com/wiki/Aqua_Madoor	85639257
80	Armal	LOB-EN079	1	https://yugipedia.com/wiki/Armal	53153481
117	Estrella de mar blindada	LOB-EN116	1	https://yugipedia.com/wiki/Estrella_de_mar_blindada	17535588
2	Dragón Blanco de Ojos Azules	LOB-EN001	1	https://yugipedia.com/wiki/Dragón_Blanco_de_Ojos_Azules	89631139
46	Tarro de captura de dragones	LOB-EN045	1	https://yugipedia.com/wiki/Tarro_de_captura_de_dragones	50045299
99	Sigue el viento	LOB-EN098	1	https://yugipedia.com/wiki/Sigue_el_viento	98252586
29	Kagemusha de la Llama Azul	LOB-EN028	1	https://yugipedia.com/wiki/Kagemusha_de_la_Llama_Azul	15401633
122	La pierna izquierda del Prohibido	LOB-EN121	1	https://yugipedia.com/wiki/La_pierna_izquierda_del_Prohibido	44519536
45	El poder de Kaishin	LOB-EN044	1	https://yugipedia.com/wiki/El_poder_de_Kaishin	77027445
121	La pierna derecha del prohibido	LOB-EN120	1	https://yugipedia.com/wiki/La_pierna_derecha_del_prohibido	8124921
34	El furioso rey del mar	LOB-EN033	1	https://yugipedia.com/wiki/El_furioso_rey_del_mar	18710707
225	7 Colored Fish	MRD-EN098	2	https://yugipedia.com/wiki/MRD-EN098	23771716
209	Ancient Brain	MRD-EN082	2	https://yugipedia.com/wiki/MRD-EN082	42431843
164	Ancient Elf	MRD-EN037	2	https://yugipedia.com/wiki/MRD-EN037	93221206
249	Blue-Winged Crown	MRD-EN122	2	https://yugipedia.com/wiki/MRD-EN122	41396436
165	Deepsea Shark	MRD-EN038	2	https://yugipedia.com/wiki/MRD-EN038	28593363
149	Ground Attacker Bugroth	MRD-EN022	2	https://yugipedia.com/wiki/MRD-EN022	58314394
136	Harpie Lady Sisters	MRD-EN009	2	https://yugipedia.com/wiki/MRD-EN009	12206212
222	Launcher Spider	MRD-EN095	2	https://yugipedia.com/wiki/MRD-EN095	87322377
174	Pale Beast	MRD-EN047	2	https://yugipedia.com/wiki/MRD-EN047	21263083
193	Saggi the Dark Clown	MRD-EN066	2	https://yugipedia.com/wiki/MRD-EN066	66602787
254	Solemn Judgment	MRD-EN127	2	https://yugipedia.com/wiki/MRD-EN127	41420027
184	Tribute to the Doomed	MRD-EN057	2	https://yugipedia.com/wiki/MRD-EN057	79759861
289	Ancient One of the Deep Forest	SRL-EN018	3	https://yugipedia.com/wiki/SRL-EN018	14015067
349	Banisher of the Light	SRL-EN078	3	https://yugipedia.com/wiki/SRL-EN078	61528025
308	Chorus of Sanctuary	SRL-EN037	3	https://yugipedia.com/wiki/SRL-EN037	81380218
353	Flash Assailant	SRL-EN082	3	https://yugipedia.com/wiki/SRL-EN082	96890582
345	Jigen Bakudan	SRL-EN074	3	https://yugipedia.com/wiki/SRL-EN074	90020065
294	Liquid Beast	SRL-EN023	3	https://yugipedia.com/wiki/SRL-EN023	93108297
318	Mystical Space Typhoon	SRL-EN047	3	https://yugipedia.com/wiki/SRL-EN047	5318639
299	Slot Machine	SRL-EN028	3	https://yugipedia.com/wiki/SRL-EN028	3797883
343	Toon Mermaid	SRL-EN072	3	https://yugipedia.com/wiki/SRL-EN072	65458948
463	4-Starred Ladybug of Doom	PSV-EN088	4	https://yugipedia.com/wiki/PSV-EN088	83994646
379	7 Completed	PSV-EN004	4	https://yugipedia.com/wiki/PSV-EN004	86198326
394	Armored Glass	PSV-EN019	4	https://yugipedia.com/wiki/PSV-EN019	36868108
418	Darkfire Soldier #1	PSV-EN043	4	https://yugipedia.com/wiki/PSV-EN043	5388481
400	Forced Requisition	PSV-EN025	4	https://yugipedia.com/wiki/PSV-EN025	74923978
466	Mad Sword Beast	PSV-EN091	4	https://yugipedia.com/wiki/PSV-EN091	79870141
408	Magical Hats	PSV-EN033	4	https://yugipedia.com/wiki/PSV-EN033	81210420
410	Nobleman of Extermination	PSV-EN035	4	https://yugipedia.com/wiki/PSV-EN035	17449108
376	Steel Ogre Grotto #2	PSV-EN001	4	https://yugipedia.com/wiki/PSV-EN001	90908427
452	Sword Hunter	PSV-EN077	4	https://yugipedia.com/wiki/PSV-EN077	51345461
548	Aqua Spirit	LON-EN068	5	https://yugipedia.com/wiki/LON-EN068	40916023
509	Card of Safe Return	LON-EN029	5	https://yugipedia.com/wiki/LON-EN029	57953380
575	Cyclon Laser	LON-EN095	5	https://yugipedia.com/wiki/LON-EN095	5494820
491	Grand Tiki Elder	LON-EN011	5	https://yugipedia.com/wiki/LON-EN011	13676474
563	Graverobber's Retribution	LON-EN083	5	https://yugipedia.com/wiki/LON-EN083	33737664
497	Mask of Dispel	LON-EN017	5	https://yugipedia.com/wiki/LON-EN017	20765952
569	Spirit Message I	LON-EN089	5	https://yugipedia.com/wiki/LON-EN089	31893528
482	Swordsman of Landstar	LON-EN002	5	https://yugipedia.com/wiki/LON-EN002	3573512
557	The Last Warrior from Another Planet	LON-EN077	5	https://yugipedia.com/wiki/LON-EN077	86099788
617	A Feint Plan	LOD-EN032	6	https://yugipedia.com/wiki/LOD-EN032	68170903
614	Array of Revealing Light	LOD-EN029	6	https://yugipedia.com/wiki/LOD-EN029	69296555
633	Dragon's Rage	LOD-EN048	6	https://yugipedia.com/wiki/LOD-EN048	54178050
683	Fiend Comedian	LOD-EN098	6	https://yugipedia.com/wiki/LOD-EN098	81172176
662	Heart of Clear Water	LOD-EN077	6	https://yugipedia.com/wiki/LOD-EN077	64801562
685	Injection Fairy Lily	LOD-EN100	6	https://yugipedia.com/wiki/LOD-EN100	79575620
592	Ryu-Kishin Clown	LOD-EN007	6	https://yugipedia.com/wiki/LOD-EN007	42647539
610	Shadow Tamer	LOD-EN025	6	https://yugipedia.com/wiki/LOD-EN025	37620434
612	The A. Forces	LOD-EN027	6	https://yugipedia.com/wiki/LOD-EN027	403847
1467	Grave Lure	TLM-EN056	15	https://yugipedia.com/wiki/TLM-EN056	57270476
1465	Level Conversion Lab	TLM-EN054	15	https://yugipedia.com/wiki/TLM-EN054	84397023
1463	Kozaky's Self-Destruct Button	TLM-EN052	15	https://yugipedia.com/wiki/TLM-EN052	21908319
1471	Lone Wolf	TLM-EN060	15	https://yugipedia.com/wiki/TLM-EN060	82452993
1462	Minefield Eruption	TLM-EN051	15	https://yugipedia.com/wiki/TLM-EN051	85519211
1464	Mispolymerization	TLM-EN053	15	https://yugipedia.com/wiki/TLM-EN053	58392024
1466	Rock Bombardment	TLM-EN055	15	https://yugipedia.com/wiki/TLM-EN055	20781762
1470	Royal Surrender	TLM-EN059	15	https://yugipedia.com/wiki/TLM-EN059	56058888
1469	Spell-Stopping Statute	TLM-EN058	15	https://yugipedia.com/wiki/TLM-EN058	10069180
1468	Token Feastevil	TLM-EN057	15	https://yugipedia.com/wiki/TLM-EN057	83675475
775	Banner of Courage	PGD-089	7	https://yugipedia.com/wiki/PGD-089	10012614
781	Barrel Behind the Door	PGD-095	7	https://yugipedia.com/wiki/PGD-095	78783370
718	Cobraman Sakuzy	PGD-032	7	https://yugipedia.com/wiki/PGD-032	75109441
700	Gora Turtle	PGD-014	7	https://yugipedia.com/wiki/PGD-014	80233946
750	Gravekeeper's Watcher	PGD-064	7	https://yugipedia.com/wiki/PGD-064	26084285
755	Mystical Knight of Jackal	PGD-069	7	https://yugipedia.com/wiki/PGD-069	98745000
792	Nightmare Wheel	PGD-106	7	https://yugipedia.com/wiki/PGD-106	54704216
723	Secret Pass to the Treasures	PGD-037	7	https://yugipedia.com/wiki/PGD-037	77876207
850	Aitsu	MFC-056	8	https://yugipedia.com/wiki/MFC-056	48202661
856	Amazoness Blowpiper	MFC-062	8	https://yugipedia.com/wiki/MFC-062	73574678
826	Autonomous Action Unit	MFC-032	8	https://yugipedia.com/wiki/MFC-032	71453557
879	Continuous Destruction Punch	MFC-085	8	https://yugipedia.com/wiki/MFC-085	68057622
822	Frontline Base	MFC-028	8	https://yugipedia.com/wiki/MFC-028	46181000
852	Luster Dragon	MFC-058	8	https://yugipedia.com/wiki/MFC-058	11091375
861	Old Vindictive Magician	MFC-067	8	https://yugipedia.com/wiki/MFC-067	45141844
820	Paladin of White Dragon	MFC-026	8	https://yugipedia.com/wiki/MFC-026	73398797
797	United Resistance	MFC-003	8	https://yugipedia.com/wiki/MFC-003	85936485
932	A Deal with Dark Ruler	DCR-EN030	9	https://yugipedia.com/wiki/DCR-EN030	6850209
994	Archfiend's Oath	DCR-EN092	9	https://yugipedia.com/wiki/DCR-EN092	22796548
1001	Archfiend's Roar	DCR-EN099	9	https://yugipedia.com/wiki/DCR-EN099	56246017
906	Arsenal Summoner	DCR-EN004	9	https://yugipedia.com/wiki/DCR-EN004	85489096
1006	Blast Held by a Tribute	DCR-EN104	9	https://yugipedia.com/wiki/DCR-EN104	89041555
963	Dark Scorpion - Meanae the Thorn	DCR-EN061	9	https://yugipedia.com/wiki/DCR-EN061	74153887
909	Guardian Grarl	DCR-EN007	9	https://yugipedia.com/wiki/DCR-EN007	47150851
987	Incandescent Ordeal	DCR-EN085	9	https://yugipedia.com/wiki/DCR-EN085	33031674
995	Mustering of the Dark Scorpions	DCR-EN093	9	https://yugipedia.com/wiki/DCR-EN093	68191243
935	Shooting Star Bow - Ceal	DCR-EN033	9	https://yugipedia.com/wiki/DCR-EN033	95638658
1112	A Hero Emerges	IOC-EN104	10	https://yugipedia.com/wiki/IOC-EN104	21597117
1089	Amphibious Bugroth MK-3	IOC-EN081	10	https://yugipedia.com/wiki/IOC-EN081	64342551
1008	Chaos Emperor Dragon	IOC-EN000	10	https://yugipedia.com/wiki/IOC-EN000	82301904
1073	Dark Magician of Chaos	IOC-EN065	10	https://yugipedia.com/wiki/IOC-EN065	40737112
1078	Enraged Battle Ox	IOC-EN070	10	https://yugipedia.com/wiki/IOC-EN070	76909279
1036	Lord Poison	IOC-EN028	10	https://yugipedia.com/wiki/IOC-EN028	40320754
1085	Prickle Fairy	IOC-EN077	10	https://yugipedia.com/wiki/IOC-EN077	91559748
1067	Sea Serpent Warrior of Darkness	IOC-EN059	10	https://yugipedia.com/wiki/IOC-EN059	42071342
1190	3-Hump Lacooda	AST-070	11	https://yugipedia.com/wiki/AST-070	86988864
1184	Aswan Apparition	AST-064	11	https://yugipedia.com/wiki/AST-064	88236094
1136	Avatar of The Pot	AST-016	11	https://yugipedia.com/wiki/AST-016	99284890
1163	Earthquake	AST-043	11	https://yugipedia.com/wiki/AST-043	82828051
1224	Human-Wave Tactics	AST-104	11	https://yugipedia.com/wiki/AST-104	30353551
1172	Ninjitsu Art of Transformation	AST-052	11	https://yugipedia.com/wiki/AST-052	70861343
1123	Sealmaster Meisei	AST-003	11	https://yugipedia.com/wiki/AST-003	2468169
1182	Spirit of the Pharaoh	AST-062	11	https://yugipedia.com/wiki/AST-062	25343280
1147	Two Thousand Needles	AST-027	11	https://yugipedia.com/wiki/AST-027	83228073
1281	Absolute End	SOD-EN050	12	https://yugipedia.com/wiki/SOD-EN050	27744077
1290	Cemetery Bomb	SOD-EN059	12	https://yugipedia.com/wiki/SOD-EN059	51394546
1291	Hallowed Life Barrier	SOD-EN060	12	https://yugipedia.com/wiki/SOD-EN060	88789641
1258	Mind on Air	SOD-EN027	12	https://yugipedia.com/wiki/SOD-EN027	66690411
1251	Rafflesia Seduction	SOD-EN020	12	https://yugipedia.com/wiki/SOD-EN020	31440542
1324	A-Team: Trap Disposal Unit	RDS-EN033	13	https://yugipedia.com/wiki/RDS-EN033	13026402
1351	Covering Fire	RDS-EN060	13	https://yugipedia.com/wiki/RDS-EN060	74458486
1322	Fusilier Dragon, the Dual-Mode Beast	RDS-EN031	13	https://yugipedia.com/wiki/RDS-EN031	51632798
1308	Harpie Lady 1	RDS-EN017	13	https://yugipedia.com/wiki/RDS-EN017	91932350
1348	Pikeru's Circle of Enchantment	RDS-EN057	13	https://yugipedia.com/wiki/RDS-EN057	74270067
1306	Roc from the Valley of Haze	RDS-EN015	13	https://yugipedia.com/wiki/RDS-EN015	28143906
1388	A Feather of the Phoenix	FET-EN037	14	https://yugipedia.com/wiki/FET-EN037	49140998
1406	Beast Soul Swap	FET-EN055	14	https://yugipedia.com/wiki/FET-EN055	35149085
1385	Brain Jacker	FET-EN034	14	https://yugipedia.com/wiki/FET-EN034	40267580
1370	Mecha-Dog Marron	FET-EN019	14	https://yugipedia.com/wiki/FET-EN019	94667532
1404	Phoenix Wing Wind Blast	FET-EN053	14	https://yugipedia.com/wiki/FET-EN053	63356631
1358	Ultimate Insect LV5	FET-EN007	14	https://yugipedia.com/wiki/FET-EN007	34830502
1449	Brain Control	TLM-EN038	15	https://yugipedia.com/wiki/TLM-EN038	87910978
1413	Elemental Hero Burstinatrix	TLM-EN002	15	https://yugipedia.com/wiki/TLM-EN002	58932616
1439	Hiita the Fire Charmer	TLM-EN028	15	https://yugipedia.com/wiki/TLM-EN028	759393
1425	Moai Interceptor Cannons	TLM-EN014	15	https://yugipedia.com/wiki/TLM-EN014	45159319
\.


--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: yugioh
--

COPY public.collection (id, card_id, owned, edition, condition, is_ultimate, notes, user_id, language) FROM stdin;
33	33	t	2	2	f	\N	2	\N
1	1	f	\N	\N	f	\N	2	\N
10	10	f	\N	\N	f	\N	2	\N
11	11	f	\N	\N	f	\N	2	\N
12	12	f	\N	\N	f	\N	2	\N
13	13	f	\N	\N	f	\N	2	\N
14	14	f	\N	\N	f	\N	2	\N
15	15	f	\N	\N	f	\N	2	\N
16	16	f	\N	\N	f	\N	2	\N
17	17	t	2	1	f	\N	2	\N
18	18	f	\N	\N	f	\N	2	\N
19	19	t	2	1	f	\N	2	\N
20	20	f	\N	\N	f	\N	2	\N
21	21	f	\N	\N	f	\N	2	\N
22	22	f	\N	\N	f	\N	2	\N
23	23	f	\N	\N	f	\N	2	\N
24	24	f	\N	\N	f	\N	2	\N
25	25	f	\N	\N	f	\N	2	\N
26	26	f	\N	\N	f	\N	2	\N
27	27	f	\N	\N	f	\N	2	\N
28	28	f	\N	\N	f	\N	2	\N
29	29	f	\N	\N	f	\N	2	\N
30	30	f	\N	\N	f	\N	2	\N
31	31	f	\N	\N	f	\N	2	\N
32	32	f	\N	\N	f	\N	2	\N
34	34	f	\N	\N	f	\N	2	\N
35	35	t	2	1	f	\N	2	\N
36	36	f	\N	\N	f	\N	2	\N
38	38	f	\N	\N	f	\N	2	\N
39	39	f	\N	\N	f	\N	2	\N
40	40	f	\N	\N	f	\N	2	\N
41	41	f	\N	\N	f	\N	2	\N
42	42	f	\N	\N	f	\N	2	\N
43	43	f	\N	\N	f	\N	2	\N
44	44	f	\N	\N	f	\N	2	\N
45	45	f	\N	\N	f	\N	2	\N
46	46	f	\N	\N	f	\N	2	\N
47	47	f	\N	\N	f	\N	2	\N
48	48	t	2	1	f	\N	2	\N
49	49	f	\N	\N	f	\N	2	\N
51	51	f	\N	\N	f	\N	2	\N
52	52	f	\N	\N	f	\N	2	\N
53	53	f	\N	\N	f	\N	2	\N
54	54	t	2	1	f	\N	2	\N
57	57	t	2	1	f	\N	2	\N
58	58	f	\N	\N	f	\N	2	\N
59	59	f	\N	\N	f	\N	2	\N
60	60	f	\N	\N	f	\N	2	\N
61	61	f	\N	\N	f	\N	2	\N
62	62	t	2	2	f	\N	2	\N
63	63	f	\N	\N	f	\N	2	\N
64	64	f	\N	\N	f	\N	2	\N
65	65	f	\N	\N	f	\N	2	\N
66	66	f	\N	\N	f	\N	2	\N
67	67	f	\N	\N	f	\N	2	\N
68	68	t	1	1	f	\N	2	\N
69	69	f	\N	\N	f	\N	2	\N
70	70	f	\N	\N	f	\N	2	\N
71	71	f	\N	\N	f	\N	2	\N
72	72	f	\N	\N	f	\N	2	\N
73	73	f	\N	\N	f	\N	2	\N
74	74	f	\N	\N	f	\N	2	\N
75	75	t	2	1	f	\N	2	\N
76	76	t	2	2	f	\N	2	\N
77	77	f	\N	\N	f	\N	2	\N
78	78	f	\N	\N	f	\N	2	\N
79	79	f	\N	\N	f	\N	2	\N
80	80	t	2	1	f	\N	2	\N
81	81	f	\N	\N	f	\N	2	\N
82	82	f	\N	\N	f	\N	2	\N
83	83	f	\N	\N	f	\N	2	\N
84	84	f	\N	\N	f	\N	2	\N
85	85	f	\N	\N	f	\N	2	\N
86	86	f	\N	\N	f	\N	2	\N
87	87	f	\N	\N	f	\N	2	\N
88	88	f	\N	\N	f	\N	2	\N
89	89	f	\N	\N	f	\N	2	\N
90	90	f	\N	\N	f	\N	2	\N
91	91	f	\N	\N	f	\N	2	\N
92	92	f	\N	\N	f	\N	2	\N
93	93	f	\N	\N	f	\N	2	\N
94	94	f	\N	\N	f	\N	2	\N
95	95	f	\N	\N	f	\N	2	\N
96	96	f	\N	\N	f	\N	2	\N
97	97	t	1	1	f	\N	2	\N
98	98	f	\N	\N	f	\N	2	\N
100	100	f	\N	\N	f	\N	2	\N
101	101	t	2	1	f	\N	2	\N
102	102	f	\N	\N	f	\N	2	\N
104	104	f	\N	\N	f	\N	2	\N
106	106	f	\N	\N	f	\N	2	\N
107	107	f	\N	\N	f	\N	2	\N
108	108	f	\N	\N	f	\N	2	\N
109	109	f	\N	\N	f	\N	2	\N
110	110	t	2	1	f	\N	2	\N
111	111	f	\N	\N	f	\N	2	\N
112	112	f	\N	\N	f	\N	2	\N
113	113	f	\N	\N	f	\N	2	\N
114	114	f	\N	\N	f	\N	2	\N
115	115	t	2	1	f	\N	2	\N
116	116	f	\N	\N	f	\N	2	\N
117	117	f	\N	\N	f	\N	2	\N
118	118	f	\N	\N	f	\N	2	\N
119	119	t	2	1	f	\N	2	\N
120	120	t	1	1	f	\N	2	\N
121	121	f	\N	\N	f	\N	2	\N
122	122	f	\N	\N	f	\N	2	\N
123	123	f	\N	\N	f	\N	2	\N
124	124	f	\N	\N	f	\N	2	\N
125	125	f	\N	\N	f	\N	2	\N
126	126	f	\N	\N	f	\N	2	\N
127	127	t	2	1	f	\N	2	\N
128	128	f	\N	\N	f	\N	2	\N
129	129	f	\N	\N	f	\N	2	\N
130	130	f	\N	\N	f	\N	2	\N
131	131	f	\N	\N	f	\N	2	\N
132	132	t	2	1	f	\N	2	\N
133	133	t	2	1	f	\N	2	\N
134	134	f	\N	\N	f	\N	2	\N
136	136	f	\N	\N	f	\N	2	\N
138	138	f	\N	\N	f	\N	2	\N
139	139	f	\N	\N	f	\N	2	\N
140	140	f	\N	\N	f	\N	2	\N
141	141	t	1	1	f	\N	2	\N
142	142	f	\N	\N	f	\N	2	\N
143	143	f	\N	\N	f	\N	2	\N
144	144	t	2	1	f	\N	2	\N
145	145	f	\N	\N	f	\N	2	\N
146	146	t	2	1	f	\N	2	\N
147	147	f	\N	\N	f	\N	2	\N
148	148	f	\N	\N	f	\N	2	\N
150	150	f	\N	\N	f	\N	2	\N
151	151	f	\N	\N	f	\N	2	\N
152	152	t	2	1	f	\N	2	\N
153	153	t	2	2	f	\N	2	\N
154	154	f	\N	\N	f	\N	2	\N
155	155	f	\N	\N	f	\N	2	\N
156	156	f	\N	\N	f	\N	2	\N
157	157	f	\N	\N	f	\N	2	\N
37	37	t	2	2	f	\N	2	\N
50	50	t	1	1	f	\N	2	\N
55	55	f	1	1	f	\N	2	\N
56	56	t	1	1	f	\N	2	\N
99	99	t	2	1	f	\N	2	\N
103	103	t	2	2	f	\N	2	\N
105	105	t	2	1	f	\N	2	\N
135	135	t	1	2	f	\N	2	\N
137	137	t	1	1	f	\N	2	\N
149	149	t	2	1	f	\N	2	\N
165	165	t	2	1	f	\N	2	\N
158	158	f	\N	\N	f	\N	2	\N
159	159	f	\N	\N	f	\N	2	\N
160	160	f	\N	\N	f	\N	2	\N
161	161	t	2	2	f	\N	2	\N
162	162	f	\N	\N	f	\N	2	\N
163	163	t	2	1	f	\N	2	\N
164	164	f	\N	\N	f	\N	2	\N
166	166	f	\N	\N	f	\N	2	\N
167	167	f	\N	\N	f	\N	2	\N
168	168	f	\N	\N	f	\N	2	\N
169	169	t	1	1	f	\N	2	\N
170	170	f	\N	\N	f	\N	2	\N
171	171	t	2	2	f	\N	2	\N
172	172	t	2	2	f	\N	2	\N
173	173	f	\N	\N	f	\N	2	\N
174	174	t	1	1	f	\N	2	\N
175	175	f	\N	\N	f	\N	2	\N
176	176	f	\N	\N	f	\N	2	\N
177	177	f	\N	\N	f	\N	2	\N
178	178	f	\N	\N	f	\N	2	\N
179	179	t	1	1	f	\N	2	\N
180	180	f	\N	\N	f	\N	2	\N
181	181	f	\N	\N	f	\N	2	\N
182	182	f	\N	\N	f	\N	2	\N
183	183	f	\N	\N	f	\N	2	\N
184	184	t	1	1	f	\N	2	\N
185	185	f	\N	\N	f	\N	2	\N
186	186	t	2	1	f	\N	2	\N
187	187	f	\N	\N	f	\N	2	\N
188	188	f	\N	\N	f	\N	2	\N
189	189	f	\N	\N	f	\N	2	\N
190	190	f	\N	\N	f	\N	2	\N
191	191	f	\N	\N	f	\N	2	\N
192	192	f	\N	\N	f	\N	2	\N
193	193	f	\N	\N	f	\N	2	\N
194	194	f	\N	\N	f	\N	2	\N
195	195	f	\N	\N	f	\N	2	\N
196	196	t	2	2	f	\N	2	\N
197	197	f	\N	\N	f	\N	2	\N
198	198	t	2	1	f	\N	2	\N
199	199	t	2	2	f	\N	2	\N
200	200	f	\N	\N	f	\N	2	\N
201	201	f	\N	\N	f	\N	2	\N
202	202	f	\N	\N	f	\N	2	\N
203	203	f	\N	\N	f	\N	2	\N
204	204	f	\N	\N	f	\N	2	\N
207	207	f	\N	\N	f	\N	2	\N
208	208	t	2	1	f	\N	2	\N
209	209	f	\N	\N	f	\N	2	\N
211	211	f	\N	\N	f	\N	2	\N
212	212	f	\N	\N	f	\N	2	\N
213	213	f	\N	\N	f	\N	2	\N
214	214	f	\N	\N	f	\N	2	\N
215	215	f	\N	\N	f	\N	2	\N
216	216	f	\N	\N	f	\N	2	\N
217	217	f	\N	\N	f	\N	2	\N
219	219	f	\N	\N	f	\N	2	\N
220	220	f	\N	\N	f	\N	2	\N
221	221	f	\N	\N	f	\N	2	\N
223	223	f	\N	\N	f	\N	2	\N
224	224	f	\N	\N	f	\N	2	\N
225	225	f	\N	\N	f	\N	2	\N
226	226	t	2	1	f	\N	2	\N
227	227	f	\N	\N	f	\N	2	\N
228	228	f	\N	\N	f	\N	2	\N
229	229	f	\N	\N	f	\N	2	\N
230	230	f	\N	\N	f	\N	2	\N
231	231	f	\N	\N	f	\N	2	\N
232	232	f	\N	\N	f	\N	2	\N
233	233	f	\N	\N	f	\N	2	\N
234	234	f	\N	\N	f	\N	2	\N
235	235	f	\N	\N	f	\N	2	\N
237	237	f	\N	\N	f	\N	2	\N
238	238	f	\N	\N	f	\N	2	\N
239	239	f	\N	\N	f	\N	2	\N
240	240	f	\N	\N	f	\N	2	\N
241	241	f	\N	\N	f	\N	2	\N
243	243	f	\N	\N	f	\N	2	\N
244	244	f	\N	\N	f	\N	2	\N
245	245	t	2	1	f	\N	2	\N
246	246	f	\N	\N	f	\N	2	\N
247	247	t	2	1	f	\N	2	\N
248	248	f	\N	\N	f	\N	2	\N
249	249	t	2	1	f	\N	2	\N
251	251	f	\N	\N	f	\N	2	\N
252	252	f	\N	\N	f	\N	2	\N
253	253	f	\N	\N	f	\N	2	\N
254	254	f	\N	\N	f	\N	2	\N
255	255	t	2	1	f	\N	2	\N
256	256	t	2	2	f	\N	2	\N
257	257	t	2	1	f	\N	2	\N
258	258	f	\N	\N	f	\N	2	\N
259	259	f	\N	\N	f	\N	2	\N
260	260	f	\N	\N	f	\N	2	\N
261	261	f	\N	\N	f	\N	2	\N
262	262	t	2	1	f	\N	2	\N
263	263	f	\N	\N	f	\N	2	\N
264	264	f	\N	\N	f	\N	2	\N
265	265	f	\N	\N	f	\N	2	\N
266	266	f	\N	\N	f	\N	2	\N
267	267	t	2	2	f	\N	2	\N
268	268	f	\N	\N	f	\N	2	\N
269	269	t	2	1	f	\N	2	\N
270	270	t	2	1	f	\N	2	\N
271	271	f	\N	\N	f	\N	2	\N
272	272	t	2	1	f	\N	2	\N
273	273	t	2	1	f	\N	2	\N
274	274	t	1	1	f	\N	2	\N
275	275	f	\N	\N	f	\N	2	\N
277	277	f	\N	\N	f	\N	2	\N
278	278	t	2	1	f	\N	2	\N
279	279	f	\N	\N	f	\N	2	\N
280	280	t	2	1	f	\N	2	\N
281	281	t	2	1	f	\N	2	\N
282	282	f	\N	\N	f	\N	2	\N
283	283	t	2	1	f	\N	2	\N
284	284	t	2	2	f	\N	2	\N
285	285	f	\N	\N	f	\N	2	\N
287	287	t	2	1	f	\N	2	\N
288	288	f	\N	\N	f	\N	2	\N
289	289	f	\N	\N	f	\N	2	\N
290	290	f	\N	\N	f	\N	2	\N
291	291	t	2	1	f	\N	2	\N
292	292	t	2	1	f	\N	2	\N
293	293	f	\N	\N	f	\N	2	\N
294	294	f	\N	\N	f	\N	2	\N
295	295	f	\N	\N	f	\N	2	\N
296	296	f	\N	\N	f	\N	2	\N
297	297	f	\N	\N	f	\N	2	\N
298	298	f	\N	\N	f	\N	2	\N
299	299	t	2	1	f	\N	2	\N
300	300	f	\N	\N	f	\N	2	\N
301	301	f	\N	\N	f	\N	2	\N
302	302	t	2	1	f	\N	2	\N
303	303	f	\N	\N	f	\N	2	\N
304	304	t	2	1	f	\N	2	\N
305	305	f	\N	\N	f	\N	2	\N
306	306	f	\N	\N	f	\N	2	\N
307	307	t	2	1	f	\N	2	\N
205	205	t	1	1	f	\N	2	\N
206	206	t	2	1	f	\N	2	\N
210	210	t	1	1	f	\N	2	\N
218	218	t	2	1	f	\N	2	\N
236	236	t	1	1	f	\N	2	\N
242	242	t	2	1	f	\N	2	\N
250	250	t	2	1	f	\N	2	\N
276	276	t	2	2	f	\N	2	\N
308	308	t	2	1	f	\N	2	\N
309	309	t	2	2	f	\N	2	\N
310	310	t	2	1	f	\N	2	\N
311	311	f	\N	\N	f	\N	2	\N
312	312	t	2	2	f	\N	2	\N
313	313	t	1	1	f	\N	2	\N
314	314	t	2	1	f	\N	2	\N
315	315	t	1	1	f	\N	2	\N
316	316	t	2	1	f	\N	2	\N
317	317	f	\N	\N	f	\N	2	\N
318	318	t	2	1	f	\N	2	\N
319	319	f	\N	\N	f	\N	2	\N
320	320	t	1	1	f	\N	2	\N
321	321	f	\N	\N	f	\N	2	\N
322	322	f	\N	\N	f	\N	2	\N
323	323	f	\N	\N	f	\N	2	\N
326	326	f	\N	\N	f	\N	2	\N
327	327	f	\N	\N	f	\N	2	\N
329	329	t	2	1	f	\N	2	\N
330	330	f	\N	\N	f	\N	2	\N
331	331	f	\N	\N	f	\N	2	\N
332	332	t	2	1	f	\N	2	\N
334	334	f	\N	\N	f	\N	2	\N
336	336	f	\N	\N	f	\N	2	\N
338	338	t	2	1	f	\N	2	\N
339	339	f	\N	\N	f	\N	2	\N
340	340	f	\N	\N	f	\N	2	\N
341	341	f	\N	\N	f	\N	2	\N
342	342	f	\N	\N	f	\N	2	\N
343	343	f	\N	\N	f	\N	2	\N
344	344	t	2	1	f	\N	2	\N
346	346	f	\N	\N	f	\N	2	\N
347	347	f	\N	\N	f	\N	2	\N
348	348	t	2	1	f	\N	2	\N
349	349	f	\N	\N	f	\N	2	\N
350	350	f	\N	\N	f	\N	2	\N
351	351	t	2	1	f	\N	2	\N
352	352	f	\N	\N	f	\N	2	\N
353	353	t	2	1	f	\N	2	\N
354	354	f	\N	\N	f	\N	2	\N
355	355	f	\N	\N	f	\N	2	\N
356	356	f	\N	\N	f	\N	2	\N
357	357	f	\N	\N	f	\N	2	\N
359	359	t	2	1	f	\N	2	\N
360	360	t	2	1	f	\N	2	\N
361	361	f	\N	\N	f	\N	2	\N
362	362	f	\N	\N	f	\N	2	\N
363	363	t	2	1	f	\N	2	\N
364	364	t	1	1	f	\N	2	\N
365	365	f	\N	\N	f	\N	2	\N
366	366	f	\N	\N	f	\N	2	\N
367	367	f	\N	\N	f	\N	2	\N
368	368	f	\N	\N	f	\N	2	\N
369	369	f	\N	\N	f	\N	2	\N
370	370	f	\N	\N	f	\N	2	\N
371	371	f	\N	\N	f	\N	2	\N
372	372	f	\N	\N	f	\N	2	\N
373	373	t	1	1	f	\N	2	\N
374	374	f	\N	\N	f	\N	2	\N
375	375	f	\N	\N	f	\N	2	\N
376	376	t	2	2	f	\N	2	\N
377	377	f	\N	\N	f	\N	2	\N
378	378	f	\N	\N	f	\N	2	\N
379	379	t	2	1	f	\N	2	\N
380	380	t	2	1	f	\N	2	\N
381	381	f	\N	\N	f	\N	2	\N
383	383	t	2	1	f	\N	2	\N
384	384	t	2	1	f	\N	2	\N
385	385	t	1	1	f	\N	2	\N
386	386	t	2	1	f	\N	2	\N
387	387	f	\N	\N	f	\N	2	\N
388	388	f	\N	\N	f	\N	2	\N
389	389	t	2	1	f	\N	2	\N
390	390	f	\N	\N	f	\N	2	\N
391	391	t	2	1	f	\N	2	\N
392	392	f	\N	\N	f	\N	2	\N
393	393	f	\N	\N	f	\N	2	\N
395	395	f	\N	\N	f	\N	2	\N
396	396	t	2	1	f	\N	2	\N
397	397	f	\N	\N	f	\N	2	\N
398	398	f	\N	\N	f	\N	2	\N
399	399	t	2	1	f	\N	2	\N
400	400	t	2	2	f	\N	2	\N
401	401	f	\N	\N	f	\N	2	\N
402	402	f	\N	\N	f	\N	2	\N
403	403	t	1	1	f	\N	2	\N
404	404	f	\N	\N	f	\N	2	\N
405	405	t	2	1	f	\N	2	\N
406	406	t	2	2	f	\N	2	\N
407	407	f	\N	\N	f	\N	2	\N
408	408	f	\N	\N	f	\N	2	\N
409	409	t	2	2	f	\N	2	\N
410	410	t	2	2	f	\N	2	\N
411	411	t	2	1	f	\N	2	\N
412	412	t	2	1	f	\N	2	\N
413	413	f	\N	\N	f	\N	2	\N
414	414	f	\N	\N	f	\N	2	\N
415	415	f	\N	\N	f	\N	2	\N
416	416	f	\N	\N	f	\N	2	\N
417	417	f	\N	\N	f	\N	2	\N
418	418	f	\N	\N	f	\N	2	\N
419	419	f	\N	\N	f	\N	2	\N
420	420	t	2	1	f	\N	2	\N
421	421	f	\N	\N	f	\N	2	\N
423	423	f	\N	\N	f	\N	2	\N
424	424	f	\N	\N	f	\N	2	\N
425	425	t	2	1	f	\N	2	\N
426	426	f	\N	\N	f	\N	2	\N
427	427	f	\N	\N	f	\N	2	\N
428	428	t	2	1	f	\N	2	\N
429	429	f	\N	\N	f	\N	2	\N
430	430	f	\N	\N	f	\N	2	\N
431	431	f	\N	\N	f	\N	2	\N
432	432	f	\N	\N	f	\N	2	\N
434	434	f	\N	\N	f	\N	2	\N
435	435	f	\N	\N	f	\N	2	\N
436	436	f	\N	\N	f	\N	2	\N
437	437	t	2	1	f	\N	2	\N
438	438	t	2	1	f	\N	2	\N
439	439	t	2	1	f	\N	2	\N
440	440	f	\N	\N	f	\N	2	\N
441	441	t	2	1	f	\N	2	\N
442	442	f	\N	\N	f	\N	2	\N
443	443	f	\N	\N	f	\N	2	\N
444	444	f	\N	\N	f	\N	2	\N
445	445	t	2	1	f	\N	2	\N
446	446	f	\N	\N	f	\N	2	\N
447	447	f	\N	\N	f	\N	2	\N
448	448	t	2	1	f	\N	2	\N
450	450	f	\N	\N	f	\N	2	\N
451	451	t	2	1	f	\N	2	\N
452	452	f	\N	\N	f	\N	2	\N
453	453	f	\N	\N	f	\N	2	\N
454	454	t	2	1	f	\N	2	\N
455	455	f	\N	\N	f	\N	2	\N
456	456	f	\N	\N	f	\N	2	\N
328	328	t	2	1	f	\N	2	\N
333	333	t	2	1	f	\N	2	\N
335	335	t	2	2	f	\N	2	\N
337	337	t	2	1	f	\N	2	\N
358	358	t	1	1	f	\N	2	\N
382	382	t	2	1	f	\N	2	\N
394	394	t	1	1	f	\N	2	\N
422	422	t	2	1	f	\N	2	\N
449	449	t	1	1	f	\N	2	\N
457	457	t	2	1	f	\N	2	\N
458	458	f	\N	\N	f	\N	2	\N
459	459	f	\N	\N	f	\N	2	\N
461	461	f	\N	\N	f	\N	2	\N
462	462	f	\N	\N	f	\N	2	\N
463	463	f	\N	\N	f	\N	2	\N
464	464	f	\N	\N	f	\N	2	\N
465	465	f	\N	\N	f	\N	2	\N
466	466	t	2	2	f	\N	2	\N
468	468	f	\N	\N	f	\N	2	\N
470	470	t	2	1	f	\N	2	\N
473	473	f	\N	\N	f	\N	2	\N
474	474	t	2	1	f	\N	2	\N
475	475	t	2	1	f	\N	2	\N
476	476	f	\N	\N	f	\N	2	\N
477	477	t	2	2	f	\N	2	\N
478	478	t	2	2	f	\N	2	\N
479	479	f	\N	\N	f	\N	2	\N
480	480	t	2	1	f	\N	2	\N
481	481	t	2	1	f	\N	2	\N
482	482	f	\N	\N	f	\N	2	\N
483	483	f	\N	\N	f	\N	2	\N
484	484	f	\N	\N	f	\N	2	\N
485	485	f	\N	\N	f	\N	2	\N
486	486	f	\N	\N	f	\N	2	\N
487	487	f	\N	\N	f	\N	2	\N
488	488	t	2	1	f	\N	2	\N
489	489	f	\N	\N	f	\N	2	\N
490	490	f	\N	\N	f	\N	2	\N
491	491	f	\N	\N	f	\N	2	\N
492	492	f	\N	\N	f	\N	2	\N
493	493	f	\N	\N	f	\N	2	\N
494	494	f	\N	\N	f	\N	2	\N
495	495	f	\N	\N	f	\N	2	\N
496	496	f	\N	\N	f	\N	2	\N
497	497	t	2	1	f	\N	2	\N
498	498	f	\N	\N	f	\N	2	\N
499	499	t	2	1	f	\N	2	\N
500	500	t	2	1	f	\N	2	\N
501	501	f	\N	\N	f	\N	2	\N
502	502	f	\N	\N	f	\N	2	\N
503	503	f	\N	\N	f	\N	2	\N
504	504	f	\N	\N	f	\N	2	\N
505	505	t	2	1	f	\N	2	\N
507	507	f	\N	\N	f	\N	2	\N
508	508	f	\N	\N	f	\N	2	\N
509	509	t	2	1	f	\N	2	\N
510	510	f	\N	\N	f	\N	2	\N
512	512	f	\N	\N	f	\N	2	\N
513	513	t	1	1	f	\N	2	\N
514	514	f	\N	\N	f	\N	2	\N
515	515	t	1	1	f	\N	2	\N
518	518	f	\N	\N	f	\N	2	\N
519	519	t	1	1	f	\N	2	\N
520	520	f	\N	\N	f	\N	2	\N
521	521	f	\N	\N	f	\N	2	\N
522	522	t	2	1	f	\N	2	\N
524	524	f	\N	\N	f	\N	2	\N
525	525	f	\N	\N	f	\N	2	\N
526	526	f	\N	\N	f	\N	2	\N
528	528	f	\N	\N	f	\N	2	\N
529	529	t	2	1	f	\N	2	\N
530	530	f	\N	\N	f	\N	2	\N
531	531	f	\N	\N	f	\N	2	\N
532	532	f	\N	\N	f	\N	2	\N
533	533	f	\N	\N	f	\N	2	\N
534	534	t	2	1	f	\N	2	\N
535	535	f	\N	\N	f	\N	2	\N
536	536	f	\N	\N	f	\N	2	\N
539	539	f	\N	\N	f	\N	2	\N
540	540	f	\N	\N	f	\N	2	\N
541	541	f	\N	\N	f	\N	2	\N
542	542	t	2	1	f	\N	2	\N
543	543	t	2	1	f	\N	2	\N
544	544	t	2	1	f	\N	2	\N
545	545	f	\N	\N	f	\N	2	\N
546	546	t	2	1	f	\N	2	\N
547	547	t	2	1	f	\N	2	\N
548	548	f	\N	\N	f	\N	2	\N
549	549	f	\N	\N	f	\N	2	\N
550	550	f	\N	\N	f	\N	2	\N
551	551	f	\N	\N	f	\N	2	\N
552	552	f	\N	\N	f	\N	2	\N
553	553	t	2	1	f	\N	2	\N
554	554	f	\N	\N	f	\N	2	\N
555	555	f	\N	\N	f	\N	2	\N
556	556	f	\N	\N	f	\N	2	\N
557	557	f	\N	\N	f	\N	2	\N
558	558	f	\N	\N	f	\N	2	\N
559	559	t	1	1	f	\N	2	\N
560	560	t	2	1	f	\N	2	\N
561	561	t	2	1	f	\N	2	\N
562	562	f	\N	\N	f	\N	2	\N
563	563	f	\N	\N	f	\N	2	\N
564	564	f	\N	\N	f	\N	2	\N
565	565	f	\N	\N	f	\N	2	\N
566	566	t	2	1	f	\N	2	\N
567	567	f	\N	\N	f	\N	2	\N
568	568	t	2	1	f	\N	2	\N
569	569	f	\N	\N	f	\N	2	\N
570	570	f	\N	\N	f	\N	2	\N
571	571	f	\N	\N	f	\N	2	\N
572	572	f	\N	\N	f	\N	2	\N
573	573	f	\N	\N	f	\N	2	\N
574	574	f	\N	\N	f	\N	2	\N
575	575	f	\N	\N	f	\N	2	\N
576	576	t	2	1	f	\N	2	\N
577	577	f	\N	\N	f	\N	2	\N
578	578	t	2	1	f	\N	2	\N
579	579	t	2	1	f	\N	2	\N
580	580	f	\N	\N	f	\N	2	\N
581	581	t	2	1	f	\N	2	\N
582	582	f	\N	\N	f	\N	2	\N
583	583	t	2	1	f	\N	2	\N
584	584	t	1	1	f	\N	2	\N
585	585	f	\N	\N	f	\N	2	\N
586	586	f	\N	\N	f	\N	2	\N
587	587	f	\N	\N	f	\N	2	\N
588	588	f	\N	\N	f	\N	2	\N
590	590	f	\N	\N	f	\N	2	\N
591	591	t	2	1	f	\N	2	\N
592	592	f	\N	\N	f	\N	2	\N
594	594	t	2	1	f	\N	2	\N
595	595	f	\N	\N	f	\N	2	\N
596	596	f	\N	\N	f	\N	2	\N
597	597	t	2	1	f	\N	2	\N
598	598	t	2	1	f	\N	2	\N
599	599	f	\N	\N	f	\N	2	\N
600	600	t	1	1	f	\N	2	\N
601	601	f	\N	\N	f	\N	2	\N
602	602	t	1	1	f	\N	2	\N
603	603	f	\N	\N	f	\N	2	\N
604	604	t	1	1	f	\N	2	\N
605	605	f	\N	\N	f	\N	2	\N
467	467	t	2	1	f	\N	2	\N
469	469	t	1	1	f	Error de imprenta	2	\N
471	471	t	2	1	f	\N	2	\N
506	506	t	2	2	f	\N	2	\N
511	511	t	1	1	f	\N	2	\N
516	516	t	1	1	f	\N	2	\N
517	517	t	1	1	f	\N	2	\N
527	527	t	1	1	f	\N	2	\N
537	537	t	1	1	f	\N	2	\N
538	538	t	1	1	f	\N	2	\N
589	589	t	2	1	f	\N	2	\N
606	606	f	\N	\N	f	\N	2	\N
607	607	t	2	1	f	\N	2	\N
608	608	t	1	1	f	\N	2	\N
609	609	t	2	1	f	\N	2	\N
610	610	t	2	1	f	\N	2	\N
611	611	t	2	1	f	\N	2	\N
612	612	f	\N	\N	f	\N	2	\N
613	613	t	2	2	f	\N	2	\N
614	614	f	\N	\N	f	\N	2	\N
615	615	t	2	1	f	\N	2	\N
616	616	t	2	2	f	\N	2	\N
618	618	f	\N	\N	f	\N	2	\N
619	619	f	\N	\N	f	\N	2	\N
620	620	t	1	1	f	\N	2	\N
621	621	t	2	2	f	\N	2	\N
622	622	f	\N	\N	f	\N	2	\N
623	623	f	\N	\N	f	\N	2	\N
624	624	t	2	1	f	\N	2	\N
626	626	t	2	1	f	\N	2	\N
627	627	f	\N	\N	f	\N	2	\N
628	628	f	\N	\N	f	\N	2	\N
629	629	t	1	1	f	\N	2	\N
630	630	f	\N	\N	f	\N	2	\N
631	631	t	2	1	f	\N	2	\N
632	632	t	2	1	f	\N	2	\N
633	633	t	2	2	f	\N	2	\N
634	634	f	\N	\N	f	\N	2	\N
635	635	f	\N	\N	f	\N	2	\N
636	636	t	2	1	f	\N	2	\N
637	637	f	\N	\N	f	\N	2	\N
638	638	t	2	1	f	\N	2	\N
639	639	f	\N	\N	f	\N	2	\N
640	640	t	1	1	f	\N	2	\N
641	641	t	2	1	f	\N	2	\N
642	642	t	1	1	f	\N	2	\N
643	643	f	\N	\N	f	\N	2	\N
644	644	t	2	1	f	\N	2	\N
646	646	t	2	1	f	\N	2	\N
647	647	t	2	1	f	\N	2	\N
648	648	t	1	1	f	\N	2	\N
649	649	f	\N	\N	f	\N	2	\N
650	650	t	2	1	f	\N	2	\N
651	651	f	\N	\N	f	\N	2	\N
652	652	f	\N	\N	f	\N	2	\N
653	653	f	\N	\N	f	\N	2	\N
654	654	f	\N	\N	f	\N	2	\N
655	655	t	1	2	f	\N	2	\N
656	656	f	\N	\N	f	\N	2	\N
657	657	t	2	2	f	\N	2	\N
658	658	f	\N	\N	f	\N	2	\N
659	659	f	\N	\N	f	\N	2	\N
660	660	f	\N	\N	f	\N	2	\N
661	661	f	\N	\N	f	\N	2	\N
662	662	t	2	1	f	\N	2	\N
663	663	t	2	1	f	\N	2	\N
664	664	f	\N	\N	f	\N	2	\N
666	666	f	\N	\N	f	\N	2	\N
667	667	f	\N	\N	f	\N	2	\N
668	668	t	2	1	f	\N	2	\N
669	669	t	2	1	f	\N	2	\N
670	670	f	\N	\N	f	\N	2	\N
671	671	t	2	1	f	\N	2	\N
672	672	f	\N	\N	f	\N	2	\N
673	673	f	\N	\N	f	\N	2	\N
674	674	f	\N	\N	f	\N	2	\N
675	675	f	\N	\N	f	\N	2	\N
677	677	f	\N	\N	f	\N	2	\N
678	678	t	1	1	f	\N	2	\N
679	679	f	\N	\N	f	\N	2	\N
680	680	t	1	1	f	\N	2	\N
681	681	f	\N	\N	f	\N	2	\N
682	682	t	2	1	f	\N	2	\N
683	683	t	2	1	f	\N	2	\N
684	684	t	2	1	f	\N	2	\N
685	685	t	2	1	f	\N	2	\N
686	686	t	2	1	f	\N	2	\N
687	687	f	\N	\N	f	\N	2	\N
689	689	f	\N	\N	f	\N	2	\N
690	690	f	\N	\N	f	\N	2	\N
691	691	t	2	1	f	\N	2	\N
692	692	f	\N	\N	f	\N	2	\N
693	693	t	2	1	f	\N	2	\N
694	694	f	\N	\N	f	\N	2	\N
695	695	f	\N	\N	f	\N	2	\N
696	696	f	\N	\N	f	\N	2	\N
697	697	f	\N	\N	f	\N	2	\N
698	698	t	2	1	f	\N	2	\N
699	699	t	2	1	f	\N	2	\N
700	700	t	2	1	f	\N	2	\N
701	701	f	\N	\N	f	\N	2	\N
702	702	f	\N	\N	f	\N	2	\N
703	703	t	2	1	f	\N	2	\N
705	705	f	\N	\N	f	\N	2	\N
706	706	f	\N	\N	f	\N	2	\N
707	707	t	2	1	f	\N	2	\N
708	708	f	\N	\N	f	\N	2	\N
709	709	t	2	2	f	\N	2	\N
710	710	f	\N	\N	f	\N	2	\N
711	711	t	2	1	f	\N	2	\N
712	712	f	\N	\N	f	\N	2	\N
713	713	f	\N	\N	f	\N	2	\N
714	714	f	\N	\N	f	\N	2	\N
715	715	t	1	1	f	\N	2	\N
716	716	t	1	1	f	\N	2	\N
717	717	t	2	1	f	\N	2	\N
719	719	f	\N	\N	f	\N	2	\N
720	720	t	2	1	f	\N	2	\N
721	721	f	\N	\N	f	\N	2	\N
722	722	t	2	1	f	\N	2	\N
723	723	t	2	1	f	\N	2	\N
724	724	f	\N	\N	f	\N	2	\N
725	725	t	2	1	f	\N	2	\N
726	726	t	2	1	f	\N	2	\N
727	727	f	\N	\N	f	\N	2	\N
728	728	t	2	1	f	\N	2	\N
729	729	f	\N	\N	f	\N	2	\N
730	730	t	2	1	f	\N	2	\N
731	731	f	\N	\N	f	\N	2	\N
732	732	f	\N	\N	f	\N	2	\N
733	733	f	\N	\N	f	\N	2	\N
734	734	f	\N	\N	f	\N	2	\N
735	735	t	2	1	f	\N	2	\N
736	736	f	\N	\N	f	\N	2	\N
737	737	f	\N	\N	f	\N	2	\N
738	738	f	\N	\N	f	\N	2	\N
739	739	f	\N	\N	f	\N	2	\N
740	740	f	\N	\N	f	\N	2	\N
741	741	t	2	1	f	\N	2	\N
742	742	t	1	1	f	\N	2	\N
743	743	f	\N	\N	f	\N	2	\N
744	744	f	\N	\N	f	\N	2	\N
745	745	f	\N	\N	f	\N	2	\N
746	746	f	\N	\N	f	\N	2	\N
747	747	t	2	1	f	\N	2	\N
748	748	f	\N	\N	f	\N	2	\N
749	749	t	2	1	f	\N	2	\N
750	750	f	\N	\N	f	\N	2	\N
751	751	f	\N	\N	f	\N	2	\N
752	752	t	2	1	f	\N	2	\N
645	645	t	2	1	f	\N	2	\N
665	665	t	1	1	f	\N	2	\N
676	676	t	2	1	f	\N	2	\N
688	688	t	2	1	f	\N	2	\N
718	718	t	2	1	f	\N	2	\N
753	753	t	2	1	f	\N	2	\N
754	754	f	\N	\N	f	\N	2	\N
755	755	f	\N	\N	f	\N	2	\N
756	756	f	\N	\N	f	\N	2	\N
757	757	t	2	1	f	\N	2	\N
758	758	f	\N	\N	f	\N	2	\N
759	759	f	\N	\N	f	\N	2	\N
760	760	t	2	1	f	\N	2	\N
761	761	f	\N	\N	f	\N	2	\N
762	762	f	\N	\N	f	\N	2	\N
763	763	f	\N	\N	f	\N	2	\N
764	764	f	\N	\N	f	\N	2	\N
765	765	f	\N	\N	f	\N	2	\N
766	766	f	\N	\N	f	\N	2	\N
767	767	f	\N	\N	f	\N	2	\N
768	768	f	\N	\N	f	\N	2	\N
769	769	t	2	1	f	\N	2	\N
770	770	t	2	1	f	\N	2	\N
772	772	t	2	2	f	\N	2	\N
773	773	t	2	1	f	\N	2	\N
774	774	t	1	1	f	\N	2	\N
775	775	t	1	1	f	\N	2	\N
776	776	t	2	1	f	\N	2	\N
777	777	t	1	1	f	\N	2	\N
778	778	f	\N	\N	f	\N	2	\N
779	779	f	\N	\N	f	\N	2	\N
780	780	t	1	1	f	\N	2	\N
781	781	t	1	1	f	\N	2	\N
782	782	f	\N	\N	f	\N	2	\N
783	783	f	\N	\N	f	\N	2	\N
784	784	f	\N	\N	f	\N	2	\N
785	785	f	\N	\N	f	\N	2	\N
786	786	t	1	1	f	\N	2	\N
787	787	f	\N	\N	f	\N	2	\N
788	788	f	\N	\N	f	\N	2	\N
789	789	f	\N	\N	f	\N	2	\N
790	790	f	\N	\N	f	\N	2	\N
791	791	f	\N	\N	f	\N	2	\N
792	792	t	1	1	f	\N	2	\N
793	793	t	2	1	f	\N	2	\N
794	794	t	1	1	f	\N	2	\N
796	796	f	\N	\N	f	\N	2	\N
797	797	t	2	1	f	\N	2	\N
798	798	f	\N	\N	f	\N	2	\N
799	799	f	\N	\N	f	\N	2	\N
800	800	t	2	2	f	\N	2	\N
801	801	f	\N	\N	f	\N	2	\N
802	802	t	2	1	f	\N	2	\N
803	803	f	\N	\N	f	\N	2	\N
804	804	f	\N	\N	f	\N	2	\N
805	805	f	\N	\N	f	\N	2	\N
806	806	t	2	1	f	\N	2	\N
807	807	f	\N	\N	f	\N	2	\N
808	808	t	2	1	f	\N	2	\N
809	809	t	2	1	f	\N	2	\N
810	810	f	\N	\N	f	\N	2	\N
812	812	t	2	1	f	\N	2	\N
813	813	f	\N	\N	f	\N	2	\N
814	814	t	2	1	f	\N	2	\N
815	815	t	2	1	f	\N	2	\N
816	816	f	\N	\N	f	\N	2	\N
817	817	f	\N	\N	f	\N	2	\N
818	818	f	\N	\N	f	\N	2	\N
819	819	t	2	1	f	\N	2	\N
820	820	f	\N	\N	f	\N	2	\N
821	821	f	\N	\N	f	\N	2	\N
823	823	f	\N	\N	f	\N	2	\N
824	824	f	\N	\N	f	\N	2	\N
825	825	t	2	1	f	\N	2	\N
826	826	f	\N	\N	f	\N	2	\N
827	827	f	\N	\N	f	\N	2	\N
828	828	f	\N	\N	f	\N	2	\N
830	830	t	2	2	f	\N	2	\N
831	831	f	\N	\N	f	\N	2	\N
833	833	f	\N	\N	f	\N	2	\N
834	834	f	\N	\N	f	\N	2	\N
835	835	f	\N	\N	f	\N	2	\N
836	836	t	2	1	f	\N	2	\N
837	837	f	\N	\N	f	\N	2	\N
838	838	f	\N	\N	f	\N	2	\N
839	839	t	2	1	f	\N	2	\N
840	840	f	\N	\N	f	\N	2	\N
842	842	f	\N	\N	f	\N	2	\N
843	843	f	\N	\N	f	\N	2	\N
844	844	f	\N	\N	f	\N	2	\N
845	845	f	\N	\N	f	\N	2	\N
846	846	f	\N	\N	f	\N	2	\N
847	847	f	\N	\N	f	\N	2	\N
848	848	f	\N	\N	f	\N	2	\N
849	849	f	\N	\N	f	\N	2	\N
850	850	f	\N	\N	f	\N	2	\N
852	852	f	\N	\N	f	\N	2	\N
853	853	f	\N	\N	f	\N	2	\N
854	854	f	\N	\N	f	\N	2	\N
855	855	t	2	1	f	\N	2	\N
857	857	f	\N	\N	f	\N	2	\N
858	858	f	\N	\N	f	\N	2	\N
859	859	f	\N	\N	f	\N	2	\N
860	860	f	\N	\N	f	\N	2	\N
861	861	t	1	1	f	\N	2	\N
862	862	f	\N	\N	f	\N	2	\N
863	863	f	\N	\N	f	\N	2	\N
864	864	f	\N	\N	f	\N	2	\N
865	865	f	\N	\N	f	\N	2	\N
867	867	t	2	1	f	\N	2	\N
869	869	f	\N	\N	f	\N	2	\N
870	870	t	2	1	f	\N	2	\N
871	871	t	2	2	f	\N	2	\N
872	872	f	\N	\N	f	\N	2	\N
873	873	f	\N	\N	f	\N	2	\N
874	874	f	\N	\N	f	\N	2	\N
875	875	t	2	1	f	\N	2	\N
876	876	f	\N	\N	f	\N	2	\N
877	877	t	1	1	f	\N	2	\N
880	880	f	\N	\N	f	\N	2	\N
881	881	t	2	1	f	\N	2	\N
882	882	t	2	1	f	\N	2	\N
883	883	f	\N	\N	f	\N	2	\N
884	884	f	\N	\N	f	\N	2	\N
885	885	t	2	1	f	\N	2	\N
886	886	f	\N	\N	f	\N	2	\N
887	887	t	2	1	f	\N	2	\N
888	888	f	\N	\N	f	\N	2	\N
889	889	f	\N	\N	f	\N	2	\N
890	890	f	\N	\N	f	\N	2	\N
891	891	f	\N	\N	f	\N	2	\N
892	892	f	\N	\N	f	\N	2	\N
893	893	f	\N	\N	f	\N	2	\N
894	894	f	\N	\N	f	\N	2	\N
895	895	f	\N	\N	f	\N	2	\N
897	897	f	\N	\N	f	\N	2	\N
899	899	t	2	1	f	\N	2	\N
900	900	f	\N	\N	f	\N	2	\N
901	901	t	2	1	f	\N	2	\N
902	902	f	\N	\N	f	\N	2	\N
795	795	t	2	1	f	\N	2	\N
822	822	t	2	1	f	\N	2	\N
829	829	t	2	1	f	\N	2	\N
832	832	t	1	2	f	\N	2	\N
841	841	t	2	1	f	\N	2	\N
856	856	t	2	1	f	\N	2	\N
866	866	t	2	1	f	\N	2	\N
868	868	t	2	1	f	\N	2	\N
878	878	t	2	1	f	\N	2	\N
896	896	t	2	1	f	\N	2	\N
898	898	t	2	1	f	\N	2	\N
904	904	f	\N	\N	f	\N	2	\N
905	905	f	\N	\N	f	\N	2	\N
906	906	t	2	1	f	\N	2	\N
907	907	t	2	1	f	\N	2	\N
908	908	f	\N	\N	f	\N	2	\N
909	909	f	\N	\N	f	\N	2	\N
910	910	f	\N	\N	f	\N	2	\N
911	911	f	\N	\N	f	\N	2	\N
912	912	f	\N	\N	f	\N	2	\N
913	913	f	\N	\N	f	\N	2	\N
914	914	t	2	1	f	\N	2	\N
915	915	f	\N	\N	f	\N	2	\N
916	916	f	\N	\N	f	\N	2	\N
917	917	f	\N	\N	f	\N	2	\N
918	918	f	\N	\N	f	\N	2	\N
919	919	t	2	1	f	\N	2	\N
920	920	f	\N	\N	f	\N	2	\N
921	921	f	\N	\N	f	\N	2	\N
922	922	t	2	1	f	\N	2	\N
923	923	f	\N	\N	f	\N	2	\N
925	925	f	\N	\N	f	\N	2	\N
926	926	f	\N	\N	f	\N	2	\N
927	927	f	\N	\N	f	\N	2	\N
928	928	t	2	1	f	\N	2	\N
929	929	t	2	1	f	\N	2	\N
930	930	t	2	1	f	\N	2	\N
931	931	f	\N	\N	f	\N	2	\N
932	932	f	\N	\N	f	\N	2	\N
933	933	f	\N	\N	f	\N	2	\N
934	934	t	2	1	f	\N	2	\N
935	935	f	\N	\N	f	\N	2	\N
936	936	f	\N	\N	f	\N	2	\N
937	937	f	\N	\N	f	\N	2	\N
938	938	f	\N	\N	f	\N	2	\N
939	939	f	\N	\N	f	\N	2	\N
940	940	f	\N	\N	f	\N	2	\N
941	941	t	2	1	f	\N	2	\N
942	942	f	\N	\N	f	\N	2	\N
943	943	t	2	1	f	\N	2	\N
944	944	f	\N	\N	f	\N	2	\N
945	945	f	\N	\N	f	\N	2	\N
946	946	t	2	1	f	\N	2	\N
947	947	t	2	1	f	\N	2	\N
948	948	t	2	1	f	\N	2	\N
949	949	t	2	1	f	\N	2	\N
950	950	t	2	1	f	\N	2	\N
951	951	f	\N	\N	f	\N	2	\N
952	952	t	2	2	f	\N	2	\N
953	953	f	\N	\N	f	\N	2	\N
954	954	f	\N	\N	f	\N	2	\N
955	955	t	2	1	f	\N	2	\N
957	957	t	2	2	f	\N	2	\N
958	958	f	\N	\N	f	\N	2	\N
959	959	f	\N	\N	f	\N	2	\N
960	960	f	\N	\N	f	\N	2	\N
961	961	t	2	2	f	\N	2	\N
962	962	f	\N	\N	f	\N	2	\N
963	963	f	\N	\N	f	\N	2	\N
964	964	f	\N	\N	f	\N	2	\N
965	965	t	2	1	f	\N	2	\N
966	966	f	\N	\N	f	\N	2	\N
967	967	t	2	1	f	\N	2	\N
968	968	f	\N	\N	f	\N	2	\N
969	969	f	\N	\N	f	\N	2	\N
970	970	f	\N	\N	f	\N	2	\N
971	971	f	\N	\N	f	\N	2	\N
972	972	f	\N	\N	f	\N	2	\N
973	973	f	\N	\N	f	\N	2	\N
974	974	f	\N	\N	f	\N	2	\N
975	975	t	2	1	f	\N	2	\N
976	976	f	\N	\N	f	\N	2	\N
977	977	t	2	1	f	\N	2	\N
978	978	f	\N	\N	f	\N	2	\N
980	980	t	2	1	f	\N	2	\N
981	981	t	2	1	f	\N	2	\N
982	982	f	\N	\N	f	\N	2	\N
983	983	f	\N	\N	f	\N	2	\N
984	984	t	2	1	f	\N	2	\N
985	985	t	2	1	f	\N	2	\N
986	986	t	2	1	f	\N	2	\N
987	987	f	\N	\N	f	\N	2	\N
988	988	f	\N	\N	f	\N	2	\N
989	989	f	\N	\N	f	\N	2	\N
990	990	f	\N	\N	f	\N	2	\N
991	991	f	\N	\N	f	\N	2	\N
992	992	t	2	1	f	\N	2	\N
993	993	f	\N	\N	f	\N	2	\N
995	995	t	2	1	f	\N	2	\N
997	997	f	\N	\N	f	\N	2	\N
998	998	t	2	1	f	\N	2	\N
999	999	f	\N	\N	f	\N	2	\N
1000	1000	f	\N	\N	f	\N	2	\N
1002	1002	f	\N	\N	f	\N	2	\N
1003	1003	f	\N	\N	f	\N	2	\N
1004	1004	t	2	1	f	\N	2	\N
1005	1005	t	2	1	f	\N	2	\N
1006	1006	f	\N	\N	f	\N	2	\N
1007	1007	f	\N	\N	f	\N	2	\N
1008	1008	t	1	1	f	\N	2	\N
1010	1010	f	\N	\N	f	\N	2	\N
1013	1013	t	2	1	f	\N	2	\N
1015	1015	f	\N	\N	f	\N	2	\N
1017	1017	f	\N	\N	f	\N	2	\N
1018	1018	f	\N	\N	f	\N	2	\N
1019	1019	t	2	1	f	\N	2	\N
1020	1020	f	\N	\N	f	\N	2	\N
1021	1021	t	2	1	f	\N	2	\N
1022	1022	f	\N	\N	f	\N	2	\N
1023	1023	t	2	1	f	\N	2	\N
1024	1024	f	\N	\N	f	\N	2	\N
1025	1025	f	\N	\N	f	\N	2	\N
1026	1026	t	2	1	f	\N	2	\N
1028	1028	t	2	1	f	\N	2	\N
1029	1029	t	1	1	f	\N	2	\N
1031	1031	t	2	1	f	\N	2	\N
1032	1032	t	1	1	f	\N	2	\N
1033	1033	t	1	1	f	\N	2	\N
1034	1034	f	\N	\N	f	\N	2	\N
1035	1035	t	2	1	f	\N	2	\N
1036	1036	f	\N	\N	f	\N	2	\N
1037	1037	t	2	1	f	\N	2	\N
1040	1040	f	\N	\N	f	\N	2	\N
1041	1041	t	2	1	f	\N	2	\N
1042	1042	f	\N	\N	f	\N	2	\N
1043	1043	f	\N	\N	f	\N	2	\N
1045	1045	f	\N	\N	f	\N	2	\N
1046	1046	f	\N	\N	f	\N	2	\N
1047	1047	f	\N	\N	f	\N	2	\N
1048	1048	f	\N	\N	f	\N	2	\N
1049	1049	t	2	1	f	\N	2	\N
1050	1050	t	2	1	f	\N	2	\N
924	924	t	2	1	f	\N	2	\N
979	979	t	2	1	f	\N	2	\N
994	994	t	2	1	f	\N	2	\N
996	996	t	2	1	f	\N	2	\N
1001	1001	t	2	1	f	\N	2	\N
1011	1011	t	2	1	f	\N	2	\N
1012	1012	t	2	1	f	\N	2	\N
1014	1014	t	2	1	f	\N	2	\N
1016	1016	t	2	1	f	\N	2	\N
1030	1030	t	2	1	f	\N	2	\N
1038	1038	t	2	1	f	\N	2	\N
1039	1039	t	2	1	f	\N	2	\N
1044	1044	t	2	1	f	\N	2	\N
3	3	f	\N	\N	f	\N	2	\N
4	4	f	\N	\N	f	\N	2	\N
6	6	f	\N	\N	f	\N	2	\N
7	7	f	\N	\N	f	\N	2	\N
8	8	f	\N	\N	f	\N	2	\N
1052	1052	f	\N	\N	f	\N	2	\N
1053	1053	t	2	1	f	\N	2	\N
1054	1054	f	\N	\N	f	\N	2	\N
1055	1055	f	\N	\N	f	\N	2	\N
1056	1056	t	2	1	f	\N	2	\N
1057	1057	t	2	1	f	\N	2	\N
1059	1059	t	2	1	f	\N	2	\N
1060	1060	f	\N	\N	f	\N	2	\N
1061	1061	t	2	1	f	\N	2	\N
1062	1062	f	\N	\N	f	\N	2	\N
1063	1063	t	2	1	f	\N	2	\N
1064	1064	f	\N	\N	f	\N	2	\N
1065	1065	f	\N	\N	f	\N	2	\N
1066	1066	t	2	1	f	\N	2	\N
1068	1068	t	2	1	f	\N	2	\N
1069	1069	t	2	1	f	\N	2	\N
1070	1070	t	2	1	f	\N	2	\N
1071	1071	f	\N	\N	f	\N	2	\N
1072	1072	t	2	1	f	\N	2	\N
1073	1073	f	\N	\N	f	\N	2	\N
1074	1074	f	\N	\N	f	\N	2	\N
1075	1075	f	\N	\N	f	\N	2	\N
1076	1076	t	2	2	f	\N	2	\N
1077	1077	f	\N	\N	f	\N	2	\N
1078	1078	f	\N	\N	f	\N	2	\N
1079	1079	t	2	1	f	\N	2	\N
1080	1080	f	\N	\N	f	\N	2	\N
1081	1081	t	2	1	f	\N	2	\N
1082	1082	t	2	1	f	\N	2	\N
1083	1083	f	\N	\N	f	\N	2	\N
1084	1084	t	2	1	f	\N	2	\N
1085	1085	t	2	1	f	\N	2	\N
1086	1086	f	\N	\N	f	\N	2	\N
1087	1087	f	\N	\N	f	\N	2	\N
1088	1088	t	2	1	f	\N	2	\N
1090	1090	f	\N	\N	f	\N	2	\N
1091	1091	f	\N	\N	f	\N	2	\N
1092	1092	f	\N	\N	f	\N	2	\N
1093	1093	f	\N	\N	f	\N	2	\N
1094	1094	f	\N	\N	f	\N	2	\N
1095	1095	f	\N	\N	f	\N	2	\N
1097	1097	f	\N	\N	f	\N	2	\N
1100	1100	f	\N	\N	f	\N	2	\N
1101	1101	f	\N	\N	f	\N	2	\N
1102	1102	t	2	1	f	\N	2	\N
1103	1103	t	2	1	f	\N	2	\N
1105	1105	f	\N	\N	f	\N	2	\N
1107	1107	f	\N	\N	f	\N	2	\N
1108	1108	t	2	1	f	\N	2	\N
1109	1109	f	\N	\N	f	\N	2	\N
1110	1110	f	\N	\N	f	\N	2	\N
1111	1111	f	\N	\N	f	\N	2	\N
1112	1112	t	1	1	f	\N	2	\N
1113	1113	t	2	1	f	\N	2	\N
1114	1114	t	2	1	f	\N	2	\N
1115	1115	t	1	1	f	\N	2	\N
1116	1116	f	\N	\N	f	\N	2	\N
1117	1117	t	1	1	f	\N	2	\N
1118	1118	f	\N	\N	f	\N	2	\N
1119	1119	f	\N	\N	f	\N	2	\N
1121	1121	f	\N	\N	f	\N	2	\N
1122	1122	f	\N	\N	f	\N	2	\N
1123	1123	t	2	1	f	\N	2	\N
1124	1124	f	\N	\N	f	\N	2	\N
1126	1126	t	2	2	f	\N	2	\N
1127	1127	t	2	1	f	\N	2	\N
1128	1128	t	2	1	f	\N	2	\N
1129	1129	f	\N	\N	f	\N	2	\N
1130	1130	f	\N	\N	f	\N	2	\N
1133	1133	f	\N	\N	f	\N	2	\N
1138	1138	t	2	1	f	\N	2	\N
1139	1139	t	2	1	f	\N	2	\N
1140	1140	f	\N	\N	f	\N	2	\N
1142	1142	t	1	1	f	\N	2	\N
1143	1143	t	2	1	f	\N	2	\N
1144	1144	f	\N	\N	f	\N	2	\N
1146	1146	t	2	1	f	\N	2	\N
1147	1147	f	\N	\N	f	\N	2	\N
1148	1148	f	\N	\N	f	\N	2	\N
1150	1150	t	1	1	f	\N	2	\N
1152	1152	f	\N	\N	f	\N	2	\N
1153	1153	f	\N	\N	f	\N	2	\N
1154	1154	f	\N	\N	f	\N	2	\N
1155	1155	f	\N	\N	f	\N	2	\N
1157	1157	f	\N	\N	f	\N	2	\N
1158	1158	f	\N	\N	f	\N	2	\N
1159	1159	t	1	1	f	\N	2	\N
1160	1160	t	2	1	f	\N	2	\N
1164	1164	f	\N	\N	f	\N	2	\N
1166	1166	f	\N	\N	f	\N	2	\N
1167	1167	f	\N	\N	f	\N	2	\N
1168	1168	f	\N	\N	f	\N	2	\N
1170	1170	t	1	1	f	\N	2	\N
1174	1174	f	\N	\N	f	\N	2	\N
1175	1175	f	\N	\N	f	\N	2	\N
1176	1176	f	\N	\N	f	\N	2	\N
1177	1177	f	\N	\N	f	\N	2	\N
1178	1178	f	\N	\N	f	\N	2	\N
1179	1179	f	\N	\N	f	\N	2	\N
1181	1181	f	\N	\N	f	\N	2	\N
1183	1183	f	\N	\N	f	\N	2	\N
1184	1184	t	2	1	f	\N	2	\N
5	5	t	2	2	f	\N	2	\N
9	9	t	2	2	f	\N	2	\N
222	222	t	2	1	f	\N	2	\N
286	286	t	2	1	f	\N	2	\N
324	324	t	2	1	f	\N	2	\N
325	325	t	2	1	f	\N	2	\N
345	345	t	2	2	f	\N	2	\N
433	433	t	2	1	f	\N	2	\N
460	460	t	1	1	f	\N	2	\N
472	472	t	1	1	f	\N	2	\N
1058	1058	t	2	1	f	\N	2	\N
1089	1089	t	2	1	f	\N	2	\N
1098	1098	t	2	1	f	\N	2	\N
1096	1096	t	2	1	f	\N	2	\N
1099	1099	t	2	1	f	\N	2	\N
1106	1106	t	2	1	f	\N	2	\N
1120	1120	t	1	2	f	\N	2	\N
1125	1125	t	1	1	f	\N	2	\N
1131	1131	t	2	1	f	\N	2	\N
1134	1134	t	2	1	f	\N	2	\N
1135	1135	t	1	1	f	\N	2	\N
1141	1141	t	1	1	f	\N	2	\N
1136	1136	t	1	1	f	\N	2	\N
1145	1145	t	2	1	f	\N	2	\N
1149	1149	t	2	1	f	\N	2	\N
1151	1151	t	2	1	f	\N	2	\N
1156	1156	t	1	1	f	\N	2	\N
1162	1162	t	2	1	f	\N	2	\N
1163	1163	t	1	1	f	\N	2	\N
1165	1165	t	2	2	f	\N	2	\N
1169	1169	t	2	1	f	\N	2	\N
1172	1172	t	1	1	f	\N	2	\N
1173	1173	t	1	1	f	\N	2	\N
1180	1180	t	1	1	f	\N	2	\N
1182	1182	t	1	1	f	\N	2	\N
523	523	t	1	1	f	\N	2	\N
593	593	t	2	1	f	\N	2	\N
617	617	t	2	1	f	\N	2	\N
625	625	t	2	1	f	\N	2	\N
704	704	t	2	1	f	\N	2	\N
771	771	t	2	1	f	\N	2	\N
811	811	t	2	1	f	\N	2	\N
851	851	t	2	1	f	\N	2	\N
879	879	t	2	1	f	\N	2	\N
903	903	t	2	1	f	\N	2	\N
956	956	t	2	1	f	\N	2	\N
1009	1009	t	2	1	f	\N	2	\N
1027	1027	t	2	1	f	\N	2	\N
1051	1051	t	2	1	f	\N	2	\N
1067	1067	t	2	1	f	\N	2	\N
1104	1104	t	2	1	f	\N	2	\N
1132	1132	t	2	1	f	\N	2	\N
1137	1137	t	1	1	f	\N	2	\N
1161	1161	t	2	1	f	\N	2	\N
1171	1171	t	1	1	f	\N	2	\N
1216	1216	t	1	1	f	\N	2	\N
1230	1230	t	2	1	f	\N	2	\N
1259	1259	t	1	1	f	\N	2	\N
1269	1269	t	2	1	t	\N	2	\N
1292	1292	t	2	1	f	\N	2	\N
1314	1314	t	1	1	f	\N	2	\N
1332	1332	t	1	1	f	\N	2	\N
1189	1189	t	1	1	f	\N	2	\N
1192	1192	t	1	1	f	\N	2	\N
1193	1193	t	1	1	f	\N	2	\N
1199	1199	t	2	1	f	\N	2	\N
1202	1202	t	1	1	f	\N	2	\N
1203	1203	t	2	1	f	\N	2	\N
1206	1206	t	2	1	f	\N	2	\N
1211	1211	t	2	1	f	\N	2	\N
1213	1213	t	1	1	f	\N	2	\N
1185	1185	t	2	1	f	\N	2	\N
1186	1186	f	\N	\N	f	\N	2	\N
1187	1187	f	\N	\N	f	\N	2	\N
1188	1188	f	\N	\N	f	\N	2	\N
1190	1190	t	1	1	f	\N	2	\N
1191	1191	f	\N	\N	f	\N	2	\N
1194	1194	f	\N	\N	f	\N	2	\N
1195	1195	t	2	1	f	\N	2	\N
1196	1196	f	\N	\N	f	\N	2	\N
1197	1197	f	\N	\N	f	\N	2	\N
1198	1198	f	\N	\N	f	\N	2	\N
1200	1200	t	1	1	f	\N	2	\N
1201	1201	f	\N	\N	f	\N	2	\N
1204	1204	t	2	1	f	\N	2	\N
1205	1205	f	\N	\N	f	\N	2	\N
1207	1207	f	\N	\N	f	\N	2	\N
1208	1208	f	\N	\N	f	\N	2	\N
1209	1209	t	1	1	f	\N	2	\N
1210	1210	f	\N	\N	f	\N	2	\N
1212	1212	t	2	1	f	\N	2	\N
1214	1214	t	2	1	f	\N	2	\N
1215	1215	f	\N	\N	f	\N	2	\N
1217	1217	f	\N	\N	f	\N	2	\N
1218	1218	f	\N	\N	f	\N	2	\N
1219	1219	f	\N	\N	f	\N	2	\N
1220	1220	f	\N	\N	f	\N	2	\N
1221	1221	f	\N	\N	f	\N	2	\N
1223	1223	t	2	2	f	\N	2	\N
1224	1224	f	\N	\N	f	\N	2	\N
1225	1225	f	\N	\N	f	\N	2	\N
1226	1226	f	\N	\N	f	\N	2	\N
1227	1227	f	\N	\N	f	\N	2	\N
1228	1228	t	2	2	f	\N	2	\N
1229	1229	f	\N	\N	f	\N	2	\N
1231	1231	t	2	1	f	\N	2	\N
1232	1232	t	2	1	f	\N	2	\N
1236	1236	f	\N	\N	f	\N	2	\N
1237	1237	t	2	1	f	\N	2	\N
1238	1238	t	2	1	f	\N	2	\N
1239	1239	t	1	1	f	\N	2	\N
1240	1240	t	2	1	f	\N	2	\N
1241	1241	t	2	1	t	\N	2	\N
1242	1242	f	\N	\N	f	\N	2	\N
1243	1243	f	\N	\N	f	\N	2	\N
1244	1244	f	\N	\N	f	\N	2	\N
1245	1245	t	1	1	t	\N	2	\N
1246	1246	t	2	1	f	\N	2	\N
1247	1247	t	2	2	f	\N	2	\N
1248	1248	f	\N	\N	f	\N	2	\N
1249	1249	t	2	1	f	\N	2	\N
1250	1250	f	\N	\N	f	\N	2	\N
1251	1251	t	2	1	f	\N	2	\N
1252	1252	f	\N	\N	f	\N	2	\N
1253	1253	t	2	1	f	\N	2	\N
1254	1254	f	\N	\N	f	\N	2	\N
1256	1256	t	1	1	f	\N	2	\N
1257	1257	t	1	1	f	\N	2	\N
1258	1258	t	2	1	f	\N	2	\N
1261	1261	t	2	2	f	\N	2	\N
1262	1262	f	\N	\N	f	\N	2	\N
1263	1263	t	2	1	f	\N	2	\N
1264	1264	f	\N	\N	f	\N	2	\N
1265	1265	f	\N	\N	f	\N	2	\N
1270	1270	f	\N	\N	f	\N	2	\N
1271	1271	t	1	2	f	\N	2	\N
1272	1272	t	2	1	f	\N	2	\N
1273	1273	f	\N	\N	f	\N	2	\N
1274	1274	t	1	1	t	\N	2	\N
1275	1275	f	\N	\N	f	\N	2	\N
1276	1276	t	1	1	f	\N	2	\N
1278	1278	f	\N	\N	f	\N	2	\N
1280	1280	t	1	1	f	\N	2	\N
1281	1281	t	2	1	f	\N	2	\N
1282	1282	f	\N	\N	f	\N	2	\N
1283	1283	f	\N	\N	f	\N	2	\N
1284	1284	f	\N	\N	f	\N	2	\N
1285	1285	t	1	1	f	\N	2	\N
1286	1286	t	1	1	t	\N	2	\N
1287	1287	t	1	1	f	\N	2	\N
1288	1288	f	\N	\N	f	\N	2	\N
1290	1290	t	1	1	f	\N	2	\N
1294	1294	t	1	1	f	\N	2	\N
1295	1295	t	1	1	f	\N	2	\N
1296	1296	f	\N	\N	f	\N	2	\N
1297	1297	t	1	1	f	\N	2	\N
1298	1298	f	\N	\N	f	\N	2	\N
1299	1299	t	1	1	f	\N	2	\N
1300	1300	t	2	1	f	\N	2	\N
1301	1301	t	1	1	f	\N	2	\N
1304	1304	t	1	1	f	\N	2	\N
1306	1306	t	1	1	f	\N	2	\N
1307	1307	f	\N	\N	f	\N	2	\N
1308	1308	f	\N	\N	f	\N	2	\N
1309	1309	t	1	1	f	\N	2	\N
1310	1310	t	1	1	f	\N	2	\N
1311	1311	t	2	1	f	\N	2	\N
1312	1312	f	\N	\N	f	\N	2	\N
1313	1313	t	2	1	f	\N	2	\N
1315	1315	t	1	1	f	\N	2	\N
1316	1316	t	1	1	f	\N	2	\N
1317	1317	t	1	1	f	\N	2	\N
1318	1318	t	1	1	f	\N	2	\N
1319	1319	f	\N	\N	f	\N	2	\N
1320	1320	t	1	1	f	\N	2	\N
1322	1322	t	2	1	f	\N	2	\N
1323	1323	t	1	1	f	\N	2	\N
1324	1324	f	\N	\N	f	\N	2	\N
1325	1325	t	1	1	f	\N	2	\N
1326	1326	f	\N	\N	f	\N	2	\N
1329	1329	t	1	1	f	\N	2	\N
1331	1331	t	1	1	f	\N	2	\N
1333	1333	f	\N	\N	f	\N	2	\N
1334	1334	t	2	1	f	\N	2	\N
1335	1335	t	1	1	f	\N	2	\N
1336	1336	t	1	1	f	\N	2	\N
1337	1337	t	1	1	f	\N	2	\N
1340	1340	t	1	1	f	\N	2	\N
1341	1341	t	1	1	f	\N	2	\N
1342	1342	t	1	1	f	\N	2	\N
1343	1343	t	1	1	t	\N	2	\N
1344	1344	t	1	1	f	\N	2	\N
1346	1346	t	1	1	f	\N	2	\N
1347	1347	t	2	1	f	\N	2	\N
1348	1348	t	1	1	f	\N	2	\N
1350	1350	t	1	1	f	\N	2	\N
1351	1351	t	1	1	f	\N	2	\N
1352	1352	f	\N	\N	f	\N	2	\N
1353	1353	f	\N	\N	f	\N	2	\N
1354	1354	f	\N	\N	f	\N	2	\N
1355	1355	t	2	1	f	\N	2	\N
1356	1356	t	2	1	t	\N	2	\N
1357	1357	t	1	1	f	\N	2	\N
1358	1358	f	\N	\N	f	\N	2	\N
1359	1359	f	\N	\N	f	\N	2	\N
1222	1222	t	1	1	f	\N	2	\N
1233	1233	t	2	1	f	\N	2	\N
1234	1234	t	2	1	f	\N	2	\N
1235	1235	t	2	1	f	\N	2	\N
1255	1255	t	1	1	f	\N	2	\N
1260	1260	t	2	1	f	\N	2	\N
1266	1266	t	2	1	f	\N	2	\N
1267	1267	t	2	1	f	\N	2	\N
1268	1268	t	2	1	f	\N	2	\N
1277	1277	t	2	1	f	\N	2	\N
1279	1279	t	2	2	f	\N	2	\N
1289	1289	t	1	1	f	\N	2	\N
1291	1291	t	1	1	f	\N	2	\N
1293	1293	t	1	1	f	\N	2	\N
1302	1302	t	1	1	f	\N	2	\N
1303	1303	t	1	1	f	\N	2	\N
1305	1305	t	1	1	f	\N	2	\N
1321	1321	t	2	1	f	\N	2	\N
1327	1327	t	1	1	f	\N	2	\N
1328	1328	t	1	1	f	\N	2	\N
1330	1330	t	1	1	f	\N	2	\N
1338	1338	t	1	1	f	\N	2	\N
1339	1339	t	1	1	f	\N	2	\N
1349	1349	t	2	1	f	\N	2	\N
1345	1345	t	1	1	f	\N	2	\N
1360	1360	t	2	1	f	\N	2	\N
1361	1361	f	\N	\N	f	\N	2	\N
1362	1362	f	\N	\N	f	\N	2	\N
1363	1363	f	\N	\N	f	\N	2	\N
1364	1364	f	\N	\N	f	\N	2	\N
1365	1365	f	\N	\N	f	\N	2	\N
1366	1366	f	\N	\N	f	\N	2	\N
1368	1368	t	1	1	f	\N	2	\N
1371	1371	f	\N	\N	f	\N	2	\N
1372	1372	f	\N	\N	f	\N	2	\N
1374	1374	f	\N	\N	f	\N	2	\N
1375	1375	f	\N	\N	f	\N	2	\N
1376	1376	f	\N	\N	f	\N	2	\N
1378	1378	f	\N	\N	f	\N	2	\N
1379	1379	f	\N	\N	f	\N	2	\N
1380	1380	f	\N	\N	f	\N	2	\N
1381	1381	f	\N	\N	f	\N	2	\N
1382	1382	f	\N	\N	f	\N	2	\N
1383	1383	f	\N	\N	f	\N	2	\N
1384	1384	f	\N	\N	f	\N	2	\N
1385	1385	t	2	1	f	\N	2	\N
1386	1386	t	2	1	f	\N	2	\N
1387	1387	f	\N	\N	f	\N	2	\N
1388	1388	t	2	1	f	\N	2	\N
1389	1389	f	\N	\N	f	\N	2	\N
1390	1390	f	\N	\N	f	\N	2	\N
1391	1391	f	\N	\N	f	\N	2	\N
1392	1392	f	\N	\N	f	\N	2	\N
1393	1393	f	\N	\N	f	\N	2	\N
1394	1394	f	\N	\N	f	\N	2	\N
1395	1395	f	\N	\N	f	\N	2	\N
1398	1398	f	\N	\N	f	\N	2	\N
1399	1399	t	2	1	f	\N	2	\N
1400	1400	f	\N	\N	f	\N	2	\N
1401	1401	t	1	1	f	\N	2	\N
1402	1402	f	\N	\N	f	\N	2	\N
1403	1403	f	\N	\N	f	\N	2	\N
1404	1404	f	\N	\N	f	\N	2	\N
1405	1405	f	\N	\N	f	\N	2	\N
1406	1406	f	\N	\N	f	\N	2	\N
1407	1407	f	\N	\N	f	\N	2	\N
1408	1408	f	\N	\N	f	\N	2	\N
1409	1409	f	\N	\N	f	\N	2	\N
1410	1410	f	\N	\N	f	\N	2	\N
1411	1411	f	\N	\N	f	\N	2	\N
1412	1412	f	\N	\N	f	\N	2	\N
1413	1413	f	\N	\N	f	\N	2	\N
1414	1414	f	\N	\N	f	\N	2	\N
1415	1415	f	\N	\N	f	\N	2	\N
1416	1416	f	\N	\N	f	\N	2	\N
1417	1417	f	\N	\N	f	\N	2	\N
1418	1418	f	\N	\N	f	\N	2	\N
1419	1419	t	2	1	f	\N	2	\N
1420	1420	f	\N	\N	f	\N	2	\N
1421	1421	t	2	1	f	\N	2	\N
1422	1422	f	\N	\N	f	\N	2	\N
1423	1423	f	\N	\N	f	\N	2	\N
1424	1424	f	\N	\N	f	\N	2	\N
1425	1425	f	\N	\N	f	\N	2	\N
1426	1426	f	\N	\N	f	\N	2	\N
1427	1427	f	\N	\N	f	\N	2	\N
1428	1428	f	\N	\N	f	\N	2	\N
1429	1429	t	1	1	f	\N	2	\N
1430	1430	f	\N	\N	f	\N	2	\N
1431	1431	t	1	1	t	\N	2	\N
1432	1432	f	\N	\N	f	\N	2	\N
1433	1433	f	\N	\N	f	\N	2	\N
1434	1434	t	1	1	f	\N	2	\N
1435	1435	f	\N	\N	f	\N	2	\N
1436	1436	f	\N	\N	f	\N	2	\N
1437	1437	f	\N	\N	f	\N	2	\N
1438	1438	f	\N	\N	f	\N	2	\N
1439	1439	t	1	1	f	\N	2	\N
1440	1440	t	1	1	f	\N	2	\N
1441	1441	t	1	1	f	\N	2	\N
1442	1442	t	1	1	f	\N	2	\N
1443	1443	t	1	1	f	\N	2	\N
1444	1444	f	\N	\N	f	\N	2	\N
1445	1445	t	2	1	t	\N	2	\N
1446	1446	f	\N	\N	f	\N	2	\N
1447	1447	f	\N	\N	f	\N	2	\N
1448	1448	t	1	1	f	\N	2	\N
1449	1449	f	\N	\N	f	\N	2	\N
1450	1450	f	\N	\N	f	\N	2	\N
1451	1451	f	\N	\N	f	\N	2	\N
1452	1452	t	1	1	f	\N	2	\N
1453	1453	t	1	1	f	\N	2	\N
1454	1454	t	1	1	f	\N	2	\N
1455	1455	t	1	1	f	\N	2	\N
1456	1456	t	1	2	f	\N	2	\N
1457	1457	f	\N	\N	f	\N	2	\N
1458	1458	f	\N	\N	f	\N	2	\N
1459	1459	t	1	1	f	\N	2	\N
1460	1460	f	\N	\N	f	\N	2	\N
1461	1461	t	1	1	f	\N	2	\N
1462	1462	t	1	1	f	\N	2	\N
1463	1463	f	\N	\N	f	\N	2	\N
1464	1464	t	1	1	f	\N	2	\N
1465	1465	f	\N	\N	f	\N	2	\N
1467	1467	f	\N	\N	f	\N	2	\N
1468	1468	f	\N	\N	f	\N	2	\N
1469	1469	f	\N	\N	f	\N	2	\N
1470	1470	f	\N	\N	f	\N	2	\N
1471	1471	f	\N	\N	f	\N	2	\N
2	2	t	1	1	f	\N	2	\N
1367	1367	t	2	1	f	\N	2	\N
1369	1369	t	1	1	f	\N	2	\N
1370	1370	t	1	1	f	\N	2	\N
1373	1373	t	2	1	f	\N	2	\N
1377	1377	t	1	1	f	\N	2	\N
1397	1397	t	1	1	f	\N	2	\N
1396	1396	t	1	1	f	\N	2	\N
1466	1466	t	1	1	f	\N	2	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: yugioh
--

COPY public.users (id, email, password_hash, name, created_at) FROM stdin;
1	default@yugioh.local	PLACEHOLDER_NOT_USABLE	Default User	2026-03-24 02:28:53.200825
2	jammkk@gmail.com	$2b$12$ucCg7Ihx9FFTiBE6F1C/Au6jYlfj90kNu8G.mduC3RfxzHbYHi5K.	jammkk	2026-03-24 02:38:04.78388
\.


--
-- Name: card_photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugioh
--

SELECT pg_catalog.setval('public.card_photos_id_seq', 1, false);


--
-- Name: card_sets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugioh
--

SELECT pg_catalog.setval('public.card_sets_id_seq', 15, true);


--
-- Name: cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugioh
--

SELECT pg_catalog.setval('public.cards_id_seq', 1471, true);


--
-- Name: collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugioh
--

SELECT pg_catalog.setval('public.collection_id_seq', 1471, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugioh
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: card_photos card_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.card_photos
    ADD CONSTRAINT card_photos_pkey PRIMARY KEY (id);


--
-- Name: card_sets card_sets_code_key; Type: CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.card_sets
    ADD CONSTRAINT card_sets_code_key UNIQUE (code);


--
-- Name: card_sets card_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.card_sets
    ADD CONSTRAINT card_sets_pkey PRIMARY KEY (id);


--
-- Name: cards cards_card_code_key; Type: CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_card_code_key UNIQUE (card_code);


--
-- Name: cards cards_pkey; Type: CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);


--
-- Name: collection collection_card_user_unique; Type: CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_card_user_unique UNIQUE (card_id, user_id);


--
-- Name: collection collection_pkey; Type: CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: card_photos card_photos_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.card_photos
    ADD CONSTRAINT card_photos_card_id_fkey FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: card_photos card_photos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.card_photos
    ADD CONSTRAINT card_photos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: cards cards_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_set_id_fkey FOREIGN KEY (set_id) REFERENCES public.card_sets(id);


--
-- Name: collection collection_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_card_id_fkey FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: collection collection_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yugioh
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict v6R9PbAVFc1ldshbefv40oTu5l6td3k3U9JFocaYvItohUnHLegfNtVC1AI9H2u

