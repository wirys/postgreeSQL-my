--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.1
-- Dumped by pg_dump version 9.4.1
-- Started on 2016-10-14 18:50:38

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 190 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2109 (class 0 OID 0)
-- Dependencies: 190
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 204 (class 1255 OID 16750)
-- Name: getperiod(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getperiod() RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
	return CAST(DATE_PART('YEAR', CURRENT_DATE) AS TEXT) || getSemester();
END
$$;


ALTER FUNCTION public.getperiod() OWNER TO postgres;

--
-- TOC entry 203 (class 1255 OID 16749)
-- Name: getsemester(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getsemester() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	semestre INT;
BEGIN
	case when date_part('month', CURRENT_DATE) between 1 and 6
	--case when date_part('month', /*cast('01/01/2014' as date)*/) between 1 and 6
		then semestre := 1;
		else semestre := 2;
	end case;
	return semestre;
END
$$;


ALTER FUNCTION public.getsemester() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 187 (class 1259 OID 17240)
-- Name: _matricula; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE _matricula (
    row_number bigint,
    cd_alu integer,
    cd_turma integer
);


ALTER TABLE _matricula OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 16777)
-- Name: aluno; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE aluno (
    cd_alu integer NOT NULL,
    orientador_alu integer NOT NULL,
    pnm_alu character varying(15) NOT NULL,
    mnm_alu character varying(50),
    unm_alu character varying(15) NOT NULL,
    email_alu character varying(40) NOT NULL,
    gen_alu character(1) NOT NULL,
    CONSTRAINT ck01_gen_alu_m_ou_f CHECK (((gen_alu = 'M'::bpchar) OR (gen_alu = 'F'::bpchar)))
);


ALTER TABLE aluno OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 16775)
-- Name: aluno_cd_alu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE aluno_cd_alu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE aluno_cd_alu_seq OWNER TO postgres;

--
-- TOC entry 2110 (class 0 OID 0)
-- Dependencies: 178
-- Name: aluno_cd_alu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE aluno_cd_alu_seq OWNED BY aluno.cd_alu;


--
-- TOC entry 183 (class 1259 OID 16802)
-- Name: curso; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE curso (
    cd_curso integer NOT NULL,
    cd_dpto smallint NOT NULL,
    nm_curso character varying(100) NOT NULL,
    desc_curso character varying(500),
    ch_curso smallint NOT NULL
);


ALTER TABLE curso OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 16800)
-- Name: curso_cd_curso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE curso_cd_curso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE curso_cd_curso_seq OWNER TO postgres;

--
-- TOC entry 2111 (class 0 OID 0)
-- Dependencies: 182
-- Name: curso_cd_curso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE curso_cd_curso_seq OWNED BY curso.cd_curso;


--
-- TOC entry 189 (class 1259 OID 56255)
-- Name: departamento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE departamento (
    cd_dpto integer NOT NULL,
    cd_escola smallint NOT NULL,
    coord_dpto integer NOT NULL,
    nm_dpto character varying(40)
);


ALTER TABLE departamento OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 56253)
-- Name: departamento_cd_dpto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE departamento_cd_dpto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE departamento_cd_dpto_seq OWNER TO postgres;

--
-- TOC entry 2112 (class 0 OID 0)
-- Dependencies: 188
-- Name: departamento_cd_dpto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE departamento_cd_dpto_seq OWNED BY departamento.cd_dpto;


--
-- TOC entry 181 (class 1259 OID 16786)
-- Name: escola; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE escola (
    cd_escola integer NOT NULL,
    diretor_escola integer NOT NULL,
    nm_escola character varying(50)
);


ALTER TABLE escola OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 16784)
-- Name: escola_cd_escola_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE escola_cd_escola_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE escola_cd_escola_seq OWNER TO postgres;

--
-- TOC entry 2113 (class 0 OID 0)
-- Dependencies: 180
-- Name: escola_cd_escola_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE escola_cd_escola_seq OWNED BY escola.cd_escola;


--
-- TOC entry 186 (class 1259 OID 16821)
-- Name: matricula; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE matricula (
    cd_alu integer NOT NULL,
    cd_turma integer NOT NULL,
    dt_matr date NOT NULL
);


ALTER TABLE matricula OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 16753)
-- Name: predio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE predio (
    cd_predio integer NOT NULL,
    nm_predio character varying(30),
    local_predio character varying(250)
);


ALTER TABLE predio OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 16751)
-- Name: predio_cd_predio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE predio_cd_predio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE predio_cd_predio_seq OWNER TO postgres;

--
-- TOC entry 2114 (class 0 OID 0)
-- Dependencies: 172
-- Name: predio_cd_predio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE predio_cd_predio_seq OWNED BY predio.cd_predio;


--
-- TOC entry 177 (class 1259 OID 16769)
-- Name: professor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE professor (
    cd_prof integer NOT NULL,
    dpto_prof smallint NOT NULL,
    pnm_prof character varying(15) NOT NULL,
    mnm_prof character varying(30),
    unm_prof character varying(15) NOT NULL,
    esp_prof character varying(40) NOT NULL,
    email_prof character varying(30) NOT NULL,
    salario_prof numeric(7,2) DEFAULT 1300
);


ALTER TABLE professor OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 16767)
-- Name: professor_cd_prof_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE professor_cd_prof_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE professor_cd_prof_seq OWNER TO postgres;

--
-- TOC entry 2115 (class 0 OID 0)
-- Dependencies: 176
-- Name: professor_cd_prof_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE professor_cd_prof_seq OWNED BY professor.cd_prof;


--
-- TOC entry 175 (class 1259 OID 16761)
-- Name: sala; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sala (
    cd_sala integer NOT NULL,
    cd_predio smallint NOT NULL,
    tipo_sala character varying(100) NOT NULL,
    cap_sala smallint NOT NULL
);


ALTER TABLE sala OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 16759)
-- Name: sala_cd_sala_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sala_cd_sala_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sala_cd_sala_seq OWNER TO postgres;

--
-- TOC entry 2116 (class 0 OID 0)
-- Dependencies: 174
-- Name: sala_cd_sala_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sala_cd_sala_seq OWNED BY sala.cd_sala;


--
-- TOC entry 185 (class 1259 OID 16813)
-- Name: turma; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE turma (
    cd_turma integer NOT NULL,
    nmdisc_turma character varying(60) NOT NULL,
    dtcriacao_turma date DEFAULT now(),
    semestre_turma character(5) DEFAULT getperiod() NOT NULL,
    cd_prof integer NOT NULL,
    cd_curso integer NOT NULL,
    cd_sala integer NOT NULL
);


ALTER TABLE turma OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 16811)
-- Name: turma_cd_turma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE turma_cd_turma_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE turma_cd_turma_seq OWNER TO postgres;

--
-- TOC entry 2117 (class 0 OID 0)
-- Dependencies: 184
-- Name: turma_cd_turma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE turma_cd_turma_seq OWNED BY turma.cd_turma;


--
-- TOC entry 1938 (class 2604 OID 16780)
-- Name: cd_alu; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aluno ALTER COLUMN cd_alu SET DEFAULT nextval('aluno_cd_alu_seq'::regclass);


--
-- TOC entry 1941 (class 2604 OID 16805)
-- Name: cd_curso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY curso ALTER COLUMN cd_curso SET DEFAULT nextval('curso_cd_curso_seq'::regclass);


--
-- TOC entry 1945 (class 2604 OID 56258)
-- Name: cd_dpto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departamento ALTER COLUMN cd_dpto SET DEFAULT nextval('departamento_cd_dpto_seq'::regclass);


--
-- TOC entry 1940 (class 2604 OID 16789)
-- Name: cd_escola; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY escola ALTER COLUMN cd_escola SET DEFAULT nextval('escola_cd_escola_seq'::regclass);


--
-- TOC entry 1934 (class 2604 OID 16756)
-- Name: cd_predio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY predio ALTER COLUMN cd_predio SET DEFAULT nextval('predio_cd_predio_seq'::regclass);


--
-- TOC entry 1936 (class 2604 OID 16772)
-- Name: cd_prof; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY professor ALTER COLUMN cd_prof SET DEFAULT nextval('professor_cd_prof_seq'::regclass);


--
-- TOC entry 1935 (class 2604 OID 16764)
-- Name: cd_sala; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sala ALTER COLUMN cd_sala SET DEFAULT nextval('sala_cd_sala_seq'::regclass);


--
-- TOC entry 1942 (class 2604 OID 16816)
-- Name: cd_turma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY turma ALTER COLUMN cd_turma SET DEFAULT nextval('turma_cd_turma_seq'::regclass);


--
-- TOC entry 2099 (class 0 OID 17240)
-- Dependencies: 187
-- Data for Name: _matricula; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY _matricula (row_number, cd_alu, cd_turma) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	2	1
8	2	2
9	2	3
10	2	4
11	2	5
12	2	6
13	3	1
14	3	2
15	3	3
16	3	4
17	3	5
18	3	6
19	4	1
20	4	2
21	4	3
22	4	4
23	4	5
24	4	6
25	5	1
26	5	2
27	5	3
28	5	4
29	5	5
30	5	6
31	6	1
32	6	2
33	6	3
34	6	4
35	6	5
36	6	6
37	7	1
38	7	2
39	7	3
40	7	4
41	7	5
42	7	6
43	8	1
44	8	2
45	8	3
46	8	4
47	8	5
48	8	6
49	9	1
50	9	2
51	9	3
52	9	4
53	9	5
54	9	6
55	10	1
56	10	2
57	10	3
58	10	4
59	10	5
60	10	6
61	11	1
62	11	2
63	11	3
64	11	4
65	11	5
66	11	6
67	12	1
68	12	2
69	12	3
70	12	4
71	12	5
72	12	6
73	13	1
74	13	2
75	13	3
76	13	4
77	13	5
78	13	6
79	14	1
80	14	2
81	14	3
82	14	4
83	14	5
84	14	6
85	15	1
86	15	2
87	15	3
88	15	4
89	15	5
90	15	6
91	16	1
92	16	2
93	16	3
94	16	4
95	16	5
96	16	6
97	17	1
98	17	2
99	17	3
100	17	4
101	17	5
102	17	6
103	18	1
104	18	2
105	18	3
106	18	4
107	18	5
108	18	6
109	19	1
110	19	2
111	19	3
112	19	4
113	19	5
114	19	6
115	20	1
116	20	2
117	20	3
118	20	4
119	20	5
120	20	6
121	21	1
122	21	2
123	21	3
124	21	4
125	21	5
126	21	6
127	22	1
128	22	2
129	22	3
130	22	4
131	22	5
132	22	6
133	23	1
134	23	2
135	23	3
136	23	4
137	23	5
138	23	6
139	24	1
140	24	2
141	24	3
142	24	4
143	24	5
144	24	6
145	25	1
146	25	2
147	25	3
148	25	4
149	25	5
150	25	6
151	26	1
152	26	2
153	26	3
154	26	4
155	26	5
156	26	6
157	27	1
158	27	2
159	27	3
160	27	4
161	27	5
162	27	6
163	28	1
164	28	2
165	28	3
166	28	4
167	28	5
168	28	6
169	29	1
170	29	2
171	29	3
172	29	4
173	29	5
174	29	6
175	30	1
176	30	2
177	30	3
178	30	4
179	30	5
180	30	6
181	31	1
182	31	2
183	31	3
184	31	4
185	31	5
186	31	6
187	32	1
188	32	2
189	32	3
190	32	4
191	32	5
192	32	6
193	33	1
194	33	2
195	33	3
196	33	4
197	33	5
198	33	6
199	34	1
200	34	2
201	34	3
202	34	4
203	34	5
204	34	6
205	35	1
206	35	2
207	35	3
208	35	4
209	35	5
210	35	6
211	36	1
212	36	2
213	36	3
214	36	4
215	36	5
216	36	6
217	37	1
218	37	2
219	37	3
220	37	4
221	37	5
222	37	6
223	38	1
224	38	2
225	38	3
226	38	4
227	38	5
228	38	6
229	39	1
230	39	2
231	39	3
232	39	4
233	39	5
234	39	6
235	40	1
236	40	2
237	40	3
238	40	4
239	40	5
240	40	6
241	41	7
242	41	8
243	41	9
244	41	10
245	41	11
246	42	7
247	42	8
248	42	9
249	42	10
250	42	11
251	43	7
252	43	8
253	43	9
254	43	10
255	43	11
256	44	7
257	44	8
258	44	9
259	44	10
260	44	11
261	45	7
262	45	8
263	45	9
264	45	10
265	45	11
266	46	7
267	46	8
268	46	9
269	46	10
270	46	11
271	47	7
272	47	8
273	47	9
274	47	10
275	47	11
276	48	7
277	48	8
278	48	9
279	48	10
280	48	11
281	49	7
282	49	8
283	49	9
284	49	10
285	49	11
286	50	7
287	50	8
288	50	9
289	50	10
290	50	11
291	51	7
292	51	8
293	51	9
294	51	10
295	51	11
296	52	7
297	52	8
298	52	9
299	52	10
300	52	11
301	53	7
302	53	8
303	53	9
304	53	10
305	53	11
306	54	7
307	54	8
308	54	9
309	54	10
310	54	11
311	55	7
312	55	8
313	55	9
314	55	10
315	55	11
316	56	7
317	56	8
318	56	9
319	56	10
320	56	11
321	57	7
322	57	8
323	57	9
324	57	10
325	57	11
326	58	7
327	58	8
328	58	9
329	58	10
330	58	11
331	59	7
332	59	8
333	59	9
334	59	10
335	59	11
336	60	7
337	60	8
338	60	9
339	60	10
340	60	11
341	61	7
342	61	8
343	61	9
344	61	10
345	61	11
346	62	7
347	62	8
348	62	9
349	62	10
350	62	11
351	63	7
352	63	8
353	63	9
354	63	10
355	63	11
356	64	7
357	64	8
358	64	9
359	64	10
360	64	11
361	65	7
362	65	8
363	65	9
364	65	10
365	65	11
366	66	7
367	66	8
368	66	9
369	66	10
370	66	11
371	67	7
372	67	8
373	67	9
374	67	10
375	67	11
376	68	7
377	68	8
378	68	9
379	68	10
380	68	11
381	69	7
382	69	8
383	69	9
384	69	10
385	69	11
386	70	7
387	70	8
388	70	9
389	70	10
390	70	11
391	71	7
392	71	8
393	71	9
394	71	10
395	71	11
396	72	7
397	72	8
398	72	9
399	72	10
400	72	11
401	73	7
402	73	8
403	73	9
404	73	10
405	73	11
406	74	7
407	74	8
408	74	9
409	74	10
410	74	11
411	75	7
412	75	8
413	75	9
414	75	10
415	75	11
416	76	7
417	76	8
418	76	9
419	76	10
420	76	11
421	77	7
422	77	8
423	77	9
424	77	10
425	77	11
426	78	7
427	78	8
428	78	9
429	78	10
430	78	11
431	79	7
432	79	8
433	79	9
434	79	10
435	79	11
436	80	7
437	80	8
438	80	9
439	80	10
440	80	11
441	81	12
442	81	13
443	81	14
444	81	15
445	81	16
446	82	12
447	82	13
448	82	14
449	82	15
450	82	16
451	83	12
452	83	13
453	83	14
454	83	15
455	83	16
456	84	12
457	84	13
458	84	14
459	84	15
460	84	16
461	85	12
462	85	13
463	85	14
464	85	15
465	85	16
466	86	12
467	86	13
468	86	14
469	86	15
470	86	16
471	87	12
472	87	13
473	87	14
474	87	15
475	87	16
476	88	12
477	88	13
478	88	14
479	88	15
480	88	16
481	89	12
482	89	13
483	89	14
484	89	15
485	89	16
486	90	12
487	90	13
488	90	14
489	90	15
490	90	16
491	91	12
492	91	13
493	91	14
494	91	15
495	91	16
496	92	12
497	92	13
498	92	14
499	92	15
500	92	16
501	93	12
502	93	13
503	93	14
504	93	15
505	93	16
506	94	12
507	94	13
508	94	14
509	94	15
510	94	16
511	95	12
512	95	13
513	95	14
514	95	15
515	95	16
516	96	12
517	96	13
518	96	14
519	96	15
520	96	16
521	97	12
522	97	13
523	97	14
524	97	15
525	97	16
526	98	12
527	98	13
528	98	14
529	98	15
530	98	16
531	99	12
532	99	13
533	99	14
534	99	15
535	99	16
536	100	12
537	100	13
538	100	14
539	100	15
540	100	16
541	101	12
542	101	13
543	101	14
544	101	15
545	101	16
546	102	12
547	102	13
548	102	14
549	102	15
550	102	16
551	103	12
552	103	13
553	103	14
554	103	15
555	103	16
556	104	12
557	104	13
558	104	14
559	104	15
560	104	16
561	105	12
562	105	13
563	105	14
564	105	15
565	105	16
566	106	12
567	106	13
568	106	14
569	106	15
570	106	16
571	107	12
572	107	13
573	107	14
574	107	15
575	107	16
576	108	12
577	108	13
578	108	14
579	108	15
580	108	16
581	109	12
582	109	13
583	109	14
584	109	15
585	109	16
586	110	12
587	110	13
588	110	14
589	110	15
590	110	16
591	111	12
592	111	13
593	111	14
594	111	15
595	111	16
596	112	12
597	112	13
598	112	14
599	112	15
600	112	16
601	113	12
602	113	13
603	113	14
604	113	15
605	113	16
606	114	12
607	114	13
608	114	14
609	114	15
610	114	16
611	115	12
612	115	13
613	115	14
614	115	15
615	115	16
616	116	12
617	116	13
618	116	14
619	116	15
620	116	16
621	117	12
622	117	13
623	117	14
624	117	15
625	117	16
626	118	12
627	118	13
628	118	14
629	118	15
630	118	16
631	119	12
632	119	13
633	119	14
634	119	15
635	119	16
636	120	12
637	120	13
638	120	14
639	120	15
640	120	16
641	121	17
642	121	18
643	121	19
644	121	20
645	121	21
646	122	17
647	122	18
648	122	19
649	122	20
650	122	21
651	123	17
652	123	18
653	123	19
654	123	20
655	123	21
656	124	17
657	124	18
658	124	19
659	124	20
660	124	21
661	125	17
662	125	18
663	125	19
664	125	20
665	125	21
666	126	17
667	126	18
668	126	19
669	126	20
670	126	21
671	127	17
672	127	18
673	127	19
674	127	20
675	127	21
676	128	17
677	128	18
678	128	19
679	128	20
680	128	21
681	129	17
682	129	18
683	129	19
684	129	20
685	129	21
686	130	17
687	130	18
688	130	19
689	130	20
690	130	21
691	131	17
692	131	18
693	131	19
694	131	20
695	131	21
696	132	17
697	132	18
698	132	19
699	132	20
700	132	21
701	133	17
702	133	18
703	133	19
704	133	20
705	133	21
706	134	17
707	134	18
708	134	19
709	134	20
710	134	21
711	135	17
712	135	18
713	135	19
714	135	20
715	135	21
716	136	17
717	136	18
718	136	19
719	136	20
720	136	21
721	137	17
722	137	18
723	137	19
724	137	20
725	137	21
726	138	17
727	138	18
728	138	19
729	138	20
730	138	21
731	139	17
732	139	18
733	139	19
734	139	20
735	139	21
736	140	17
737	140	18
738	140	19
739	140	20
740	140	21
741	141	17
742	141	18
743	141	19
744	141	20
745	141	21
746	142	17
747	142	18
748	142	19
749	142	20
750	142	21
751	143	17
752	143	18
753	143	19
754	143	20
755	143	21
756	144	17
757	144	18
758	144	19
759	144	20
760	144	21
761	145	17
762	145	18
763	145	19
764	145	20
765	145	21
766	146	17
767	146	18
768	146	19
769	146	20
770	146	21
771	147	17
772	147	18
773	147	19
774	147	20
775	147	21
776	148	17
777	148	18
778	148	19
779	148	20
780	148	21
781	149	17
782	149	18
783	149	19
784	149	20
785	149	21
786	150	17
787	150	18
788	150	19
789	150	20
790	150	21
791	151	17
792	151	18
793	151	19
794	151	20
795	151	21
796	152	17
797	152	18
798	152	19
799	152	20
800	152	21
801	153	17
802	153	18
803	153	19
804	153	20
805	153	21
806	154	17
807	154	18
808	154	19
809	154	20
810	154	21
811	155	17
812	155	18
813	155	19
814	155	20
815	155	21
816	156	17
817	156	18
818	156	19
819	156	20
820	156	21
821	157	17
822	157	18
823	157	19
824	157	20
825	157	21
826	158	17
827	158	18
828	158	19
829	158	20
830	158	21
831	159	17
832	159	18
833	159	19
834	159	20
835	159	21
836	160	17
837	160	18
838	160	19
839	160	20
840	160	21
\.


--
-- TOC entry 2091 (class 0 OID 16777)
-- Dependencies: 179
-- Data for Name: aluno; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY aluno (cd_alu, orientador_alu, pnm_alu, mnm_alu, unm_alu, email_alu, gen_alu) FROM stdin;
1	1	Acácia	Maria Cardoso	Santos	acacia.santos@gmail.com	F
2	3	Adailton	Martins	Silva	adailton.silva@hotmail.com	M
3	4	Adelmar	Carneiro	Vilela	adelmar.vilela@yahoo.com	M
4	5	Adenilsa	Joana Da Silva	Aguiar	adenilsa.aguiar@globo.com	F
5	6	Adriana	Dos Santos Carneiro	Rodrigues	adriana.rodrigues@gmail.com	F
6	7	Adriana	Marques	Fernandes	adriana.fernandes@outlook.com	F
7	8	Adriane	Feitosa	Valadares	adriane.valadares@hotmail.com	F
8	9	Alba	De Oliveira	Lemos	alba.lemos@yahoo.com	F
9	10	Alcimara	Vitorino Pereira	Martins	alcimara.martins@globo.com	F
10	11	Alcione	Paula	Figueiredo	alcione.figueiredo@gmail.com	F
11	12	Alessandra	Santos	De Almeida	alessandra.dealmeida@outlook.com	F
12	13	Alexandra	Roveni	Rhoden	alexandra.rhoden@hotmail.com	F
13	14	Alice	Avelar	Gonçalves	alice.goncalves@yahoo.com	F
14	15	Aline	Elena Sacramento	Santos	aline.santos@globo.com	F
15	16	Aline	Gonçalves	De Moraes	aline.demoraes@gmail.com	F
16	17	Amanda	Do Nascimento Correia	De Morais	amanda.demorais@outlook.com	F
17	18	Ana	Carla De Freitas	Caldas	ana.caldas@hotmail.com	F
18	19	Ana	Carolina	Chiavari	ana.chiavari@yahoo.com	F
19	20	Ana	Cleide Sarmento	Da Silva	ana.dasilva@globo.com	F
20	21	Ana	Cristina Da Costa	Advincula	ana.advincula@gmail.com	F
21	22	Ana	Cristina De Sousa E	Silva	ana.silva@outlook.com	F
22	23	Ana	Eloisa De Freitas	Ribeiro	ana.ribeiro@hotmail.com	F
23	24	Ana	Karina Dias	Cavlacante	ana.cavlacante@yahoo.com	F
24	25	Ana	Lúcia Farias	Pessôa	ana.pessoa@globo.com	F
25	26	Ana	Maria Arruda	Dias	ana.dias@gmail.com	F
26	27	Ana	Maria Vendramini	Kauling	ana.kauling@outlook.com	F
27	28	Ana	Paula Carneiro	Carvalho	ana.carvalho@hotmail.com	F
28	29	Ana	Paula Da Luz	Bianchini	ana.bianchini@yahoo.com	F
29	30	Ana	Paula Marques	Dos Santos	ana.dossantos@globo.com	F
30	31	Andrea	Nunes Mello	Porto	andrea.porto@gmail.com	F
31	32	Andréia	De Conto	Garbin	andreia.garbin@outlook.com	F
32	33	Andréia	Francesli Negri	Reis	andreia.reis@hotmail.com	F
33	34	Angela	Maria	Salvador	angela.salvador@yahoo.com	F
34	35	Antonio	Nunes	De Oliveira	antonio.deoliveira@globo.com	M
35	36	Arlene	Alves Pena	De Pinho	arlene.depinho@ \tgmail.com	F
36	37	Audir	Antonio	Cominetti	audir.cominetti@outlook.com	M
37	38	Augusto	Lira	Da Rocha	augusto.darocha@hotmail.com	M
38	39	Caio	Leonedas	De Barros	caio.debarros@yahoo.com	M
39	40	Camila	De Farias	Dantas	camila.dantas@globo.com	F
40	41	Carla	Denise	Scheremeta	carla.scheremeta@gmail.com	F
41	42	Carla	\N	Grellmann	carla.grellmann@outlook.com	F
42	43	Carla	Wanessa Rodrigues	Polli	carla.polli@hotmail.com	F
43	44	Carlo	Endrigo Bueno	Nunes	carlo.nunes@yahoo.com	M
44	45	Carmen	Regina Becker Silva	Gregorut	carmen.gregorut@globo.com	F
45	46	Carmen	Suely Villa	Real	carmen.real@gmail.com	F
46	47	Carolina	Teru	Matsui	carolina.matsui@outlook.com	F
47	48	Celia	Maria Ane	De Freitas	celia.defreitas@hotmail.com	F
48	49	Celso	Luiz	Rubio	celso.rubio@yahoo.com	M
49	50	Christiane	De Oliveira	Goveia	christiane.goveia@globo.com	F
50	51	Cícero	Dedice De Góes	Junior	cicero.junior@gmail.com	M
51	52	Cinthia	Yukico	Dos Santos	cinthia.dossantos@outlook.com	F
52	53	Cíntia	Mara De Araújo	Sousa	cintia.sousa@hotmail.com	F
53	54	Clair	\N	Da Silva	clair.dasilva@yahoo.com	M
54	55	Clatione	Almeida	De Magalhães	clatione.demagalhaes@globo.com	F
55	56	Cláudia	Rosana Firmino Macêdo	Moura	claudia.moura@gmail.com	F
56	57	Clayton	Ribeiro	França	clayton.franca@outlook.com	M
57	58	Clodoaldo	Cardoso Araujo	Mendes	clodoaldo.mendes@hotmail.com	M
58	59	Cristiane	Da Conceição	De Barros	cristiane.debarros@ \tyahoo.com	F
59	60	Cristina	Pereira	Da Silva	cristina.dasilva@globo.com	F
60	61	Cynthia	Sims Belleza	Vieira	cynthia.vieira@gmail.com	F
61	62	Daniela	Buosi	Rohlfs	daniela.rohlfs@outlook.com	F
62	1	Daniela	Cabral Pizzi	Teixeira	daniela.teixeira@hotmail.com	F
63	2	Daniela	Maria Da Silva	Amorim	daniela.amorim@yahoo.com	F
64	3	Daniele	\N	Akemi Arita	daniele.akemi arita@globo.com	F
65	4	Danielle	Ferreira	Da Silva	danielle.dasilva@gmail.com	F
66	5	Dany	Luiz	Da Silva	dany.dasilva@outlook.com	M
67	6	Denise	Cristina Silva	De Oliveira	denise.deoliveira@hotmail.com	M
68	7	Denise	Filippi	Ferreira	denise.ferreira@yahoo.com	M
69	8	Denise	Ilé	Fauro	denise.fauro@globo.com	M
70	9	Diego	Rocha Braga	De Araújo	diego.dearaujo@gmail.com	F
71	10	Dinea	Ignacio	Gonçalves	dinea.goncalves@outlook.com	M
72	11	Dione	Da Conceição	Miranda	dione.miranda@hotmail.com	M
73	12	Edilene	Coelho Peres	Pinto	edilene.pinto@yahoo.com	F
74	13	Edna	Alencar Da Silva	Oliveira	edna.oliveira@globo.com	F
75	14	Eduardo	Dias	Abreu	eduardo.abreu@gmail.com	M
76	15	Eduardo	Fernando	De Souza	eduardo.desouza@outlook.com	M
77	16	Eduardo	Lordelo	Pedreira	eduardo.pedreira@hotmail.com	M
78	17	Egiane	Natália Faria	Sena	egiane.sena@yahoo.com	F
79	18	Elaine	Terezinha Costa	Santa	elaine.santa@globo.com	F
80	19	Elizabeth	Aparecida De Souza Marques Da Silva	Benitez	elizabeth.benitez@gmail.com	F
81	20	Emanuel	Stenio	Zorzal	emanuel.zorzal@outlook.com	M
82	21	Emmanuel	Da Silva	Bronze	emmanuel.bronze@hotmail.com	M
83	22	Erica	Luciana Lago	De Carvalho	erica.decarvalho@yahoo.com	F
84	23	Ester	\N	Dainovskas	ester.dainovskas@globo.com	F
85	24	Eudênia	Maria Marques	De Lima	eudenia.delima@gmail.com	F
86	25	Eva	Maristane Rodrigues	Müller	eva.müller@outlook.com	F
87	26	Evani	Lopes Meirelles	Siqueira	evani.siqueira@hotmail.com	F
88	27	Fabiana	Paula Santos	De Araujo	fabiana.dearaujo@yahoo.com	F
89	28	Fábio	Germano Nóbrega Pachêco	Mendes	fabio.mendes@globo.com	M
90	29	Fabricio	Pagani	Possamai	fabricio.possamai@gmail.com	M
91	30	Felipe	Ribeiro	Mateini	felipe.mateini@outlook.com	M
92	31	Fernando	De Britto	Seródio	fernando.serodio@hotmail.com	M
93	32	Fernando	Marques	Henriques	fernando.henriques@yahoo.com	M
94	33	Flávia	Gonzaga	Serafim	flavia.serafim@globo.com	F
95	34	Flavia	Prado	Corrallo	flavia.corrallo@gmail.com	F
96	35	Francinete	Da Conceição Amorim	Do Carmo	francinete.do carmo@outlook.com	F
97	36	Francisco	Alves	Guimarães	francisco.guimaraes@hotmail.com	M
98	37	Francy	Maria Da Costa	Corrêa	francy.correa@yahoo.com	F
99	38	Gabriel	Pitanga	Soneghet	gabriel.soneghet@globo.com	M
100	39	Geani	Gomes De Souza	Barroso	geani.barroso@gmail.com	F
101	40	Gina	Camilo	De Oliveira	gina.deoliveira@outlook.com	F
102	41	Glauce	Araújo Ideião	Lins	glauce.lins@hotmail.com	F
103	42	Glaucia	Maria Reis	De Norões	glaucia.denoroes@yahoo.com	F
104	43	Gleide	Nogueira	Moraes	gleide.moraes@globo.com	F
105	44	Grasiele	Aparecida Thomaz Da Silva	Ribeiro	grasiele.ribeiro@gmail.com	F
106	45	Graziela	\N	Largura	graziela.largura@outlook.com	F
107	46	Guilherme	De Andrade	Ruela	guilherme.ruela@hotmail.com	M
108	47	Heidiany	Medim	Da Mota	heidiany.damota@yahoo.com	F
109	48	Heliana	Carneiro	De Moraes	heliana.demoraes@globo.com	F
110	49	Hemerson	Stenio Negreiro De Almeida	Manoel	hemerson.manoel@gmail.com	M
111	50	Iara	Marinho Santiago	Duarte	iara.duarte@outlook.com	F
112	51	Iêda	Cristina Da Silva	Moura	ieda.moura@hotmail.com	F
113	52	Imeide	Pinheiro	Dos Santos	imeide.dossantos@yahoo.com	F
114	53	Inês	Assis	Dos Anjos	ines.dosanjos@globo.com	F
115	54	Isabela	Albertina Barreiros	Luclktenberg	isabela.luclktenberg@gmail.com	F
116	55	Isabella	Maria Moreira Cavalcanti	Silva	isabella.silva@outlook.com	F
117	56	Ismenia	Veronica	Barbosa	ismenia.barbosa@hotmail.com	F
118	57	Ivanilda	\N	Mendes	ivanilda.mendes@yahoo.com	F
119	58	Izadora	Rodrigues	De Andrade	izadora.deandrade@globo.com	F
120	59	Jamyle	Calencio	Grigoletto	jamyle.grigoletto@gmail.com	F
121	60	Janaina	\N	Sallas	janaina.sallas@outlook.com	F
122	61	Janice	\N	Massoni	janice.massoni@hotmail.com	F
123	62	Jeancarlo	\N	Menegon	jeancarlo.menegon@yahoo.com	M
124	1	Jeane	Leide Targino	Moreira	jeane.moreira@globo.com	F
125	2	Joaquim	Francisco De Lima	Montes	joaquim.montes@gmail.com	M
126	3	Joathan	Laurindo Barroso	Gamborgi	joathan.gamborgi@outlook.com	M
127	4	Jociene	Santana	Pimentel	jociene.pimentel@hotmail.com	F
128	5	Jorge	Luiz Bostelmann	De Oliveira	jorge.deoliveira@yahoo.com	M
129	6	José	Braz Damas	Padilha	jose.padilha@globo.com	M
130	7	José	Carlos Guarlott	De Carvalho	jose.decarvalho@gmail.com	M
131	8	José	Carlos Moschin	Santo	jose.santo@outlook.com	M
132	9	José	Délcio	Steinbach	jose.steinbach@hotmail.com	M
133	10	Jose	Eduardo Pereira	Gonzalez	jose.gonzalez@yahoo.com	M
134	11	José	Eloir	Do Nascimento	jose.do nascimento@globo.com	M
135	12	José	Guilherme Goulart	Bustamante	jose.bustamante@gmail.com	M
136	13	José	Luiz Nishihara	Pinto	jose.pinto@outlook.com	M
137	14	Jose	Maria Campos	Prestes	jose.prestes@hotmail.com	M
138	15	José	Naum De Mesquita	Chagas	jose.chagas@yahoo.com	M
139	16	Josileny	De Lima	Barbosa	josileny.barbosa@globo.com	F
140	17	Juciela	Brum Soares	De Morais	juciela.demorais@gmail.com	F
141	18	Juliana	Carvalho	Rodrigues	juliana.rodrigues@outlook.com	F
142	19	Juliana	Lima	De Oliveira	juliana.deoliveira@hotmail.com	F
143	20	Juliane	Cristina Costa	Oliveira	juliane.oliveira@yahoo.com	F
144	21	Julio	César De Jesus Guterres	Costa	julio.costa@globo.com	M
145	22	Káthya	Daniella Figueiredo	Melo	kathya.melo@gmail.com	F
146	23	Katia	Regina Bastos	Okada	katia.okada@outlook.com	F
147	24	Kenia	Alberton	Morgan	kenia.morgan@hotmail.com	F
148	25	Keyla	Roberta	Libanio	keyla.libanio@yahoo.com	F
149	26	Laurina	Setsuko	Tanabe	laurina.tanabe@ \tglobo.com	F
150	27	Leila	Machado	Condé	leila.conde@gmail.com	F
151	28	Lenora	Catharina	Martins	lenora.martins@outlook.com	F
152	29	Lídia	Miwako Kimura	Feriani	lidia.feriani@hotmail.com	F
153	30	Ligia	Lechner Da Silva	Domingos	ligia.domingos@yahoo.com	F
154	31	Lilian	Elisa Arão	Antonio	lilian.antonio@globo.com	F
155	32	Lorhanna	Carolina Gonçalves	De Amorim	lorhanna.deamorim@gmail.com	F
156	33	Lourdes	Gege Alves	Teófilo	lourdes.teofilo@outlook.com	F
157	34	Lucas	Queiroz Dos Santos	Silva	lucas.silva@hotmail.com	M
158	35	Lúcia	Isabel	De Araújo	lucia.dearaujo@yahoo.com	F
159	36	Lucia	Maria Da Silva	Alencar	lucia.alencar@globo.com	F
160	37	Luciana	Da Silva	Bastos	luciana.bastos@ \tgmail.com	F
161	38	Luciana	De Assis	Amorim	luciana.amorim@outlook.com	F
162	39	Luciana	\N	Kolm	luciana.kolm@hotmail.com	F
163	40	Luciana	Morais	Saucedo	luciana.saucedo@yahoo.com	F
164	41	Lucimar	Cristina Pimenta	Maia	lucimar.maia@globo.com	F
165	42	Luís	Antonio Alves	Rodrigues	luis.rodrigues@gmail.com	M
166	43	Luiz	Fernando Da Silva	Torres	luiz.torres@ \toutlook.com	M
167	44	Macedonia	Pinto	Dos Santos	macedonia.dossantos@hotmail.com	F
168	45	Marcelo	De Almeida	Cesar	marcelo.cesar@yahoo.com	M
169	46	Marcelo	Jostmeier	Vallandro	marcelo.vallandro@globo.com	M
170	47	Márcia	Aparecida Silva	Ribeirão	marcia.ribeirao@gmail.com	F
171	48	Marcia	Maria De Lima	Ferreira	marcia.ferreira@outlook.com	F
172	49	Márcia	Maria Oliveira	Silva	marcia.silva@hotmail.com	F
173	50	Márcia	Pinheiro	Dos Santos	marcia.dossantos@yahoo.com	F
174	51	Marcio	Heitor Stelmo	Da Silva	marcio.dasilva@globo.com	M
175	52	Marcos	Jonathan Lino	Dos Santos	marcos.dossantos@gmail.com	M
176	53	Margarete	Soares	De Oliveira	margarete.deoliveira@outlook.com	F
177	54	Maria	Angelica	Weber	maria.weber@hotmail.com	F
178	55	Maria	Aparecida De Jesus	Hernandes	maria.hernandes@yahoo.com	F
179	56	Maria	Auxiliadora Azevedo	Granjeiro	maria.granjeiro@globo.com	F
180	57	Maria	Auxiliadora Vieira	Caldas	maria.caldas@gmail.com	F
181	58	Maria	Clara Santos	Mayrink	maria.mayrink@outlook.com	F
182	59	Maria	Cleide Da Silva	Lima	maria.lima@hotmail.com	F
183	60	Maria	Concheta	Ambrosecchia	maria.ambrosecchia@yahoo.com	F
184	61	Maria	Cristina Abrão Aued	Perin	maria.perin@globo.com	F
185	62	Maria	Cristina Flores	Soares	maria.soares@gmail.com	F
186	1	Maria	Das Graças Honório Ramos	Amado	maria.amado@outlook.com	F
187	2	Maria	Das Graças Washington Casimiro	Carreteiro	maria.carreteiro@hotmail.com	F
188	3	Maria	De Lourdes	Steinle	maria.steinle@yahoo.com	F
189	4	Maria	Do Carmo	De Lima	maria.delima@globo.com	F
190	5	Maria	Eloiza Pereira Leite	Ramos	maria.ramos@gmail.com	F
191	6	Maria	Genilda	Da Silva	maria.dasilva@outlook.com	F
192	7	Maria	Glória	Vicente	maria.vicente@hotmail.com	F
193	8	Maria	Isabel Silva	Guilherme	maria.guilherme@yahoo.com	F
194	9	Maria	Izabel Dos Santos	Nogueira	maria.nogueira@globo.com	F
195	10	Maria	José	Baiochi	maria.baiochi@gmail.com	F
196	11	Maria	José Barbosa	Sá Souza	maria.sasouza@outlook.com	F
197	12	Maria	Jovita Reis	Yamauchi	maria.yamauchi@hotmail.com	F
198	13	Maria	Luiza	Da Silva	maria.dasilva@yahoo.com	F
199	14	Maria	Paula Do Amaral	Zaitune	maria.zaitune@globo.com	F
200	15	Maria	Regina Abrão	De Toledo	maria.detoledo@gmail.com	F
201	16	Mariana	\N	Schneider	mariana.schneider@outlook.com	F
202	17	Mariele	Porto Carneiro	Leão	mariele.leao@hotmail.com	F
203	18	Mariely	Helena Barbosa	Daniel	mariely.daniel@yahoo.com	F
204	19	Marilia	Reichelt	Barbosa	marilia.barbosa@globo.com	F
205	20	Mariline	Da Costa	Luz	mariline.luz@gmail.com	F
206	21	Marina	Favrim	Gasparini	marina.gasparini@outlook.com	F
207	22	Martha	Maria	Dos Santos	martha.dossantos@hotmail.com	F
208	23	Mauren	Lopes	De Carvalho	mauren.decarvalho@yahoo.com	F
209	24	Maurício	Roberto	Barone	mauricio.barone@globo.com	M
210	25	Melania	De Paulo Cariello	Hoelz	melania.hoelz@gmail.com	F
211	26	Meryelve	Aparecida Santos	Negreiros	meryelve.negreiros@outlook.com	F
212	27	Michael	Laurence Zini	Lise	michael.lise@hotmail.com	M
213	28	Mirian	Silveira	Cacilhas	mirian.cacilhas@yahoo.com	F
214	29	Misaki	Machado	Lira	misaki.lira@globo.com	M
215	30	Moisés	Mugnaini Nicoletto	Cornélio	moises.cornelio@gmail.com	M
216	31	Nara	Pedrosa	Arruda	nara.arruda@outlook.com	F
217	32	Nara	Rubia Borges	Da Silva	nara.dasilva@hotmail.com	F
218	33	Nara	Rubia Ferreira Grande	De Paula	nara.depaula@yahoo.com	F
219	34	Natecia	Monteiro	Santos	natecia.santos@globo.com	F
220	35	Neiff	Carlos	Pereira	neiff.pereira@gmail.com	M
221	36	Nínive	Camillo	De Figueiredo	ninive.defigueiredo@outlook.com	M
222	37	Olivio	Volmir	Saggin	olivio.saggin@hotmail.com	M
223	38	Oséias	Domingues	Cândido	oseias.candido@yahoo.com	M
224	39	Otacília	Machado De Oliveira	Sousa	otacilia.sousa@globo.com	F
225	40	Otoniel	Rodrigues	Silva	otoniel.silva@gmail.com	M
226	41	Pablo	Sebastian Tavares	Amaral	pablo.amaral@outlook.com	M
227	42	Pâmella	De Castro	Duarte	pâmella.duarte@hotmail.com	F
228	43	Patricia	Michelly Santos	Lima	patricia.lima@yahoo.com	F
229	44	Patricia	Moccini	Lopes	patricia.lopes@globo.com	F
230	45	Paula	Albuquerque	Alves	paula.alves@gmail.com	F
231	46	Paula	Therezo	Canazarro	paula.canazarro@outlook.com	F
232	47	Paula	Verônica Morais Lima	Silva	paula.silva@hotmail.com	F
233	48	Paulo	Victor Dantas De Souza	Mattos	paulo.mattos@yahoo.com	M
234	49	Perillo	José Sabino	Nunes	perillo.nunes@globo.com	M
235	50	Priscila	Alonso	De Oliveira	priscila.deoliveira@gmail.com	F
236	51	Priscilla	Valler	Dos Santos	priscilla.dossantos@outlook.com	F
237	52	Raquel	Gallinella	Martins	raquel.martins@hotmail.com	F
238	53	Raquel	Heloisa Heluy	Novaes	raquel.novaes@yahoo.com	F
239	54	Regina	Paula De Souza	Freitas	regina.freitas@globo.com	F
240	55	Reinaldo	Coelho Medeiros	Junior	reinaldo.junior@gmail.com	M
241	56	Rejane	Rosso	Dal Pont	rejane.dal pont@outlook.com	F
242	57	Renata	Cezar	Do Amaral	renata.do amaral@ \thotmail.com	F
243	58	Renata	Pena	Santos	renata.santos@yahoo.com	F
244	59	Ricardo	Dias	Erguelles	ricardo.erguelles@globo.com	M
245	60	Ricardo	Kerti Mangabeira	Albernaz	ricardo.albernaz@gmail.com	M
246	61	Ricardo	Vieira	Araujo	ricardo.araujo@outlook.com	M
247	62	Roberto	Carlos	Da Silva	roberto.dasilva@hotmail.com	M
248	1	Roberto	Cunha	Carvalho	roberto.carvalho@yahoo.com	M
249	2	Roberto	Deway Guimarães	Pereira	roberto.pereira@globo.com	M
250	3	Roberto	Dos Santos	De Jesus	roberto.dejesus@gmail.com	M
251	4	Roberto	\N	Nogueira	roberto.nogueira@outlook.com	M
252	5	Rodrigo	Otávio Pereira Sayago	Soares	rodrigo.soares@hotmail.com	M
253	6	Rodrigo	\N	Romão	rodrigo.romao@yahoo.com	M
254	7	Rogério	Louzada	Abreu	rogerio.abreu@globo.com	M
255	8	Rosa	Cândida Martins	De Almeida	rosa.dealmeida@gmail.com	F
256	9	Rosa	Maria Cripa	Moreno	rosa.moreno@outlook.com	F
257	10	Rosa	Virginia Saito	Di Tullio	rosa.di tullio@hotmail.com	F
258	11	Rosana	\N	Cunha	rosana.cunha@yahoo.com	F
259	12	Rosana	Vicente	Velucci	rosana.velucci@globo.com	F
260	13	Rosane	Aline Dos Reis	Pedreira	rosane.pedreira@gmail.com	F
261	14	Rosangela	Da Silva	Neto	rosangela.neto@outlook.com	F
262	15	Rosi	Elaine Silva Alcantara	De Oliveira	rosi.deoliveira@hotmail.com	F
263	16	Rosiane	Maciel	Batista	rosiane.batista@yahoo.com	F
264	17	Samantha	Kelly Vieira	Mendes	samantha.mendes@globo.com	F
265	18	Sara	De Alencar	Ciaccio	sara.ciaccio@gmail.com	F
266	19	Sara	Jane Soares Zeni	Condas	sara.condas@outlook.com	F
267	20	Saulo	Tadeu Branco	Ramos	saulo.ramos@hotmail.com	M
268	21	Sérgio	Luís De Oliveira	Silva	sergio.silva@yahoo.com	M
269	22	Shirley	Lopes	Dias	shirley.dias@globo.com	F
270	23	Silene	Miranda	Lima	silene.lima@gmail.com	F
271	24	Silmara	Martins	De Freitas	silmara.defreitas@outlook.com	F
272	25	Sílvia	Medeiros	Thaler	silvia.thaler@hotmail.com	F
273	26	Silvia	Regina Aires Camara	Paschoalli	silvia.paschoalli@yahoo.com	F
274	27	Simone	Lisboa Dos Santos	Da Silva	simone.dasilva@globo.com	F
275	28	Sinara	Cristina	De Moraes	sinara.demoraes@gmail.com	F
276	29	Sineide	Maria Araujo	De Oliveira	sineide.deoliveira@outlook.com	F
277	30	Sonia	Maria Levy	Alvarez	sonia.alvarez@hotmail.com	F
278	31	Sueli	Preidum De Almeida	Coutinho	sueli.coutinho@yahoo.com	F
279	32	Sueli	Scotelaro	Porto	sueli.porto@globo.com	F
280	33	Suzimeiri	Brigatti Alavarse	Carone	suzimeiri.carone@gmail.com	F
281	34	Tatiana	\N	Carstens	tatiana.carstens@outlook.com	F
282	35	Ubiratam	Lopes	Correia	ubiratam.correia@hotmail.com	M
283	36	Uliana	Borges	De Figueiredo	uliana.defigueiredo@yahoo.com	F
284	37	Ullannes	Passos	Rios	ullannes.rios@globo.com	F
285	38	Vagner	Cesar Souza	Barros	vagner.barros@gmail.com	M
286	39	Vanessa	Maria Pereira	Pires	vanessa.pires@outlook.com	F
287	40	Varnise	\N	Kipper	varnise.kipper@hotmail.com	F
288	41	Victor	Pagnosi	Pacheco	victor.pacheco@yahoo.com	M
289	42	Virgínia	Prado Schiavon	Ramos	virginia.ramos@globo.com	F
290	43	Virgínia	Venturim	Silva	virginia.silva@gmail.com	F
291	44	Viviane	De Lima	Nunes	viviane.nunes@outlook.com	F
292	45	Walderlei	\N	Santanna	walderlei.santanna@hotmail.com	M
293	46	Wander	Da Silva	Guerreiro	wander.guerreiro@yahoo.com	M
294	47	Wander	Raymundo	De Campos	wander.decampos@globo.com	M
295	48	Wellington	Da Costa	Silva	wellington.silva@gmail.com	M
296	49	Wender	Antonio	De Oliveira	wender.deoliveira@outlook.com	M
297	50	Wilhma	Alves Castro	Montes	wilhma.montes@hotmail.com	F
298	51	Wilma	Bastos Souza	De Souza	wilma.desouza@yahoo.com	F
299	52	Zenara	Campos	Dos Santos	zenara.dossantos@globo.com	F
300	1	Jhonatan	Czar	Santos	jhonczar@gmail.com	M
\.


--
-- TOC entry 2118 (class 0 OID 0)
-- Dependencies: 178
-- Name: aluno_cd_alu_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('aluno_cd_alu_seq', 300, true);


--
-- TOC entry 2095 (class 0 OID 16802)
-- Dependencies: 183
-- Data for Name: curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY curso (cd_curso, cd_dpto, nm_curso, desc_curso, ch_curso) FROM stdin;
1	1	Licenciatura em Matemática	\N	2700
2	2	Licenciatura em Informática	\N	2700
3	2	Bacharelado em Sistemas de Informação	\N	3000
4	3	Bacharelado em Engenharia Minas	\N	3000
5	4	Bacharelado em Engenharia Mecânica	\N	3000
6	2	Técnico em Informática Integrado ao Ensino Médio	\N	3650
7	2	Técnico em Informática Concomitante	\N	1200
8	4	Técnico em Eletromecânica Integrado ao Ensino Médio	\N	3600
\.


--
-- TOC entry 2119 (class 0 OID 0)
-- Dependencies: 182
-- Name: curso_cd_curso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('curso_cd_curso_seq', 5, true);


--
-- TOC entry 2101 (class 0 OID 56255)
-- Dependencies: 189
-- Data for Name: departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY departamento (cd_dpto, cd_escola, coord_dpto, nm_dpto) FROM stdin;
1	3	1	Matemática
2	3	5	Informática
3	3	6	Mineração
4	3	10	Mecânica
\.


--
-- TOC entry 2120 (class 0 OID 0)
-- Dependencies: 188
-- Name: departamento_cd_dpto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('departamento_cd_dpto_seq', 4, true);


--
-- TOC entry 2093 (class 0 OID 16786)
-- Dependencies: 181
-- Data for Name: escola; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY escola (cd_escola, diretor_escola, nm_escola) FROM stdin;
1	1	SESI
2	2	CELP
3	3	IFES
4	4	GUIMARÃES ROSA
5	5	CIAC
\.


--
-- TOC entry 2121 (class 0 OID 0)
-- Dependencies: 180
-- Name: escola_cd_escola_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('escola_cd_escola_seq', 5, true);


--
-- TOC entry 2098 (class 0 OID 16821)
-- Dependencies: 186
-- Data for Name: matricula; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY matricula (cd_alu, cd_turma, dt_matr) FROM stdin;
1	1	2014-07-06
2	1	2014-07-07
3	1	2014-07-01
4	1	2014-07-05
5	1	2014-07-05
6	1	2014-07-05
7	1	2014-07-01
8	1	2014-07-02
9	1	2014-07-04
10	1	2014-07-05
11	1	2014-07-05
12	1	2014-07-05
13	1	2014-07-04
14	1	2014-07-05
15	1	2014-07-03
16	1	2014-07-01
17	1	2014-07-06
18	1	2014-07-01
19	1	2014-07-05
20	1	2014-07-02
21	1	2014-07-01
22	1	2014-07-04
23	1	2014-07-07
24	1	2014-07-07
25	1	2014-07-07
26	1	2014-07-03
27	1	2014-07-02
28	1	2014-07-06
29	1	2014-07-05
30	1	2014-07-04
31	1	2014-07-06
32	1	2014-07-02
33	1	2014-07-05
34	1	2014-07-01
35	1	2014-07-07
36	1	2014-07-01
37	1	2014-07-06
38	1	2014-07-04
39	1	2014-07-03
40	1	2014-07-04
1	2	2014-07-02
2	2	2014-07-02
3	2	2014-07-05
4	2	2014-07-02
5	2	2014-07-05
6	2	2014-07-07
7	2	2014-07-07
8	2	2014-07-01
9	2	2014-07-01
10	2	2014-07-03
11	2	2014-07-03
12	2	2014-07-04
13	2	2014-07-06
14	2	2014-07-07
15	2	2014-07-05
16	2	2014-07-01
17	2	2014-07-07
18	2	2014-07-02
19	2	2014-07-03
20	2	2014-07-07
21	2	2014-07-01
22	2	2014-07-03
23	2	2014-07-06
24	2	2014-07-03
25	2	2014-07-01
26	2	2014-07-02
27	2	2014-07-07
28	2	2014-07-04
29	2	2014-07-03
30	2	2014-07-03
31	2	2014-07-06
32	2	2014-07-03
33	2	2014-07-07
34	2	2014-07-01
35	2	2014-07-01
36	2	2014-07-04
37	2	2014-07-05
38	2	2014-07-04
39	2	2014-07-01
40	2	2014-07-02
1	3	2014-07-02
2	3	2014-07-01
3	3	2014-07-07
4	3	2014-07-04
5	3	2014-07-07
6	3	2014-07-03
7	3	2014-07-05
8	3	2014-07-07
9	3	2014-07-05
10	3	2014-07-04
11	3	2014-07-07
12	3	2014-07-02
13	3	2014-07-04
14	3	2014-07-02
15	3	2014-07-02
16	3	2014-07-07
17	3	2014-07-04
18	3	2014-07-02
19	3	2014-07-07
20	3	2014-07-02
21	3	2014-07-06
22	3	2014-07-01
23	3	2014-07-02
24	3	2014-07-01
25	3	2014-07-07
26	3	2014-07-01
27	3	2014-07-01
28	3	2014-07-01
29	3	2014-07-01
30	3	2014-07-06
31	3	2014-07-05
32	3	2014-07-05
33	3	2014-07-06
34	3	2014-07-05
35	3	2014-07-02
36	3	2014-07-05
37	3	2014-07-04
38	3	2014-07-04
39	3	2014-07-04
40	3	2014-07-04
1	4	2014-07-01
2	4	2014-07-06
3	4	2014-07-07
4	4	2014-07-05
5	4	2014-07-04
6	4	2014-07-03
7	4	2014-07-05
8	4	2014-07-07
9	4	2014-07-06
10	4	2014-07-07
11	4	2014-07-03
12	4	2014-07-06
13	4	2014-07-07
14	4	2014-07-07
15	4	2014-07-03
16	4	2014-07-05
17	4	2014-07-07
18	4	2014-07-04
19	4	2014-07-06
20	4	2014-07-02
21	4	2014-07-02
22	4	2014-07-07
23	4	2014-07-06
24	4	2014-07-01
25	4	2014-07-02
26	4	2014-07-05
27	4	2014-07-01
28	4	2014-07-03
29	4	2014-07-06
30	4	2014-07-01
31	4	2014-07-06
32	4	2014-07-05
33	4	2014-07-05
34	4	2014-07-04
35	4	2014-07-05
36	4	2014-07-03
37	4	2014-07-01
38	4	2014-07-02
39	4	2014-07-04
40	4	2014-07-05
1	5	2014-07-07
2	5	2014-07-06
3	5	2014-07-04
4	5	2014-07-06
5	5	2014-07-07
6	5	2014-07-07
7	5	2014-07-02
8	5	2014-07-04
9	5	2014-07-07
10	5	2014-07-03
11	5	2014-07-04
12	5	2014-07-05
13	5	2014-07-06
14	5	2014-07-04
15	5	2014-07-02
16	5	2014-07-04
17	5	2014-07-02
18	5	2014-07-03
19	5	2014-07-01
20	5	2014-07-05
21	5	2014-07-07
22	5	2014-07-05
23	5	2014-07-02
24	5	2014-07-02
25	5	2014-07-04
26	5	2014-07-03
27	5	2014-07-02
28	5	2014-07-04
29	5	2014-07-03
30	5	2014-07-07
31	5	2014-07-01
32	5	2014-07-05
33	5	2014-07-01
34	5	2014-07-02
35	5	2014-07-07
36	5	2014-07-06
37	5	2014-07-01
38	5	2014-07-06
39	5	2014-07-06
40	5	2014-07-06
1	6	2014-07-03
2	6	2014-07-04
3	6	2014-07-06
4	6	2014-07-06
5	6	2014-07-07
6	6	2014-07-06
7	6	2014-07-06
8	6	2014-07-01
9	6	2014-07-03
10	6	2014-07-01
11	6	2014-07-01
12	6	2014-07-03
13	6	2014-07-05
14	6	2014-07-05
15	6	2014-07-04
16	6	2014-07-03
17	6	2014-07-07
18	6	2014-07-01
19	6	2014-07-02
20	6	2014-07-07
21	6	2014-07-03
22	6	2014-07-02
23	6	2014-07-03
24	6	2014-07-02
25	6	2014-07-05
26	6	2014-07-01
27	6	2014-07-06
28	6	2014-07-04
29	6	2014-07-05
30	6	2014-07-04
31	6	2014-07-04
32	6	2014-07-03
33	6	2014-07-01
34	6	2014-07-03
35	6	2014-07-06
36	6	2014-07-03
37	6	2014-07-01
38	6	2014-07-06
39	6	2014-07-04
40	6	2014-07-02
41	7	2014-07-06
42	7	2014-07-06
43	7	2014-07-06
44	7	2014-07-01
45	7	2014-07-02
46	7	2014-07-04
47	7	2014-07-06
48	7	2014-07-06
49	7	2014-07-01
50	7	2014-07-02
51	7	2014-07-01
52	7	2014-07-07
53	7	2014-07-05
54	7	2014-07-05
55	7	2014-07-01
56	7	2014-07-04
57	7	2014-07-05
58	7	2014-07-06
59	7	2014-07-01
60	7	2014-07-04
61	7	2014-07-06
62	7	2014-07-06
63	7	2014-07-01
64	7	2014-07-02
65	7	2014-07-07
66	7	2014-07-06
67	7	2014-07-01
68	7	2014-07-03
69	7	2014-07-01
70	7	2014-07-01
71	7	2014-07-06
72	7	2014-07-05
73	7	2014-07-05
74	7	2014-07-05
75	7	2014-07-02
76	7	2014-07-02
77	7	2014-07-04
78	7	2014-07-01
79	7	2014-07-04
80	7	2014-07-01
41	8	2014-07-07
42	8	2014-07-06
43	8	2014-07-03
44	8	2014-07-04
45	8	2014-07-05
46	8	2014-07-06
47	8	2014-07-04
48	8	2014-07-04
49	8	2014-07-04
50	8	2014-07-01
51	8	2014-07-02
52	8	2014-07-02
53	8	2014-07-01
54	8	2014-07-04
55	8	2014-07-02
56	8	2014-07-02
57	8	2014-07-04
58	8	2014-07-02
59	8	2014-07-01
60	8	2014-07-06
61	8	2014-07-06
62	8	2014-07-06
63	8	2014-07-07
64	8	2014-07-03
65	8	2014-07-04
66	8	2014-07-05
67	8	2014-07-01
68	8	2014-07-05
69	8	2014-07-05
70	8	2014-07-03
71	8	2014-07-02
72	8	2014-07-06
73	8	2014-07-05
74	8	2014-07-03
75	8	2014-07-06
76	8	2014-07-02
77	8	2014-07-07
78	8	2014-07-05
79	8	2014-07-02
80	8	2014-07-02
41	9	2014-07-05
42	9	2014-07-02
43	9	2014-07-05
44	9	2014-07-06
45	9	2014-07-04
46	9	2014-07-03
47	9	2014-07-07
48	9	2014-07-02
49	9	2014-07-07
50	9	2014-07-06
51	9	2014-07-04
52	9	2014-07-02
53	9	2014-07-01
54	9	2014-07-04
55	9	2014-07-02
56	9	2014-07-07
57	9	2014-07-05
58	9	2014-07-05
59	9	2014-07-06
60	9	2014-07-06
61	9	2014-07-07
62	9	2014-07-04
63	9	2014-07-03
64	9	2014-07-05
65	9	2014-07-01
66	9	2014-07-07
67	9	2014-07-07
68	9	2014-07-04
69	9	2014-07-01
70	9	2014-07-05
71	9	2014-07-03
72	9	2014-07-06
73	9	2014-07-05
74	9	2014-07-07
75	9	2014-07-02
76	9	2014-07-01
77	9	2014-07-07
78	9	2014-07-07
79	9	2014-07-04
80	9	2014-07-02
41	10	2014-07-05
42	10	2014-07-01
43	10	2014-07-06
44	10	2014-07-04
45	10	2014-07-04
46	10	2014-07-07
47	10	2014-07-07
48	10	2014-07-01
49	10	2014-07-01
50	10	2014-07-02
51	10	2014-07-02
52	10	2014-07-01
53	10	2014-07-02
54	10	2014-07-02
55	10	2014-07-06
56	10	2014-07-03
57	10	2014-07-04
58	10	2014-07-04
59	10	2014-07-07
60	10	2014-07-04
61	10	2014-07-02
62	10	2014-07-07
63	10	2014-07-03
64	10	2014-07-05
65	10	2014-07-05
66	10	2014-07-02
67	10	2014-07-05
68	10	2014-07-02
69	10	2014-07-01
70	10	2014-07-05
71	10	2014-07-07
72	10	2014-07-01
73	10	2014-07-02
74	10	2014-07-05
75	10	2014-07-07
76	10	2014-07-07
77	10	2014-07-07
78	10	2014-07-02
79	10	2014-07-04
80	10	2014-07-02
41	11	2014-07-06
42	11	2014-07-06
43	11	2014-07-04
44	11	2014-07-01
45	11	2014-07-04
46	11	2014-07-05
47	11	2014-07-04
48	11	2014-07-07
49	11	2014-07-02
50	11	2014-07-04
51	11	2014-07-07
52	11	2014-07-07
53	11	2014-07-02
54	11	2014-07-02
55	11	2014-07-07
56	11	2014-07-06
57	11	2014-07-02
58	11	2014-07-06
59	11	2014-07-07
60	11	2014-07-04
61	11	2014-07-04
62	11	2014-07-07
63	11	2014-07-02
64	11	2014-07-03
65	11	2014-07-02
66	11	2014-07-07
67	11	2014-07-02
68	11	2014-07-07
69	11	2014-07-05
70	11	2014-07-07
71	11	2014-07-01
72	11	2014-07-06
73	11	2014-07-07
74	11	2014-07-01
75	11	2014-07-01
76	11	2014-07-06
77	11	2014-07-01
78	11	2014-07-04
79	11	2014-07-02
80	11	2014-07-07
81	12	2014-07-03
82	12	2014-07-05
83	12	2014-07-05
84	12	2014-07-04
85	12	2014-07-03
86	12	2014-07-07
87	12	2014-07-03
88	12	2014-07-07
89	12	2014-07-01
90	12	2014-07-01
91	12	2014-07-04
92	12	2014-07-06
93	12	2014-07-05
94	12	2014-07-01
95	12	2014-07-05
96	12	2014-07-03
97	12	2014-07-06
98	12	2014-07-03
99	12	2014-07-06
100	12	2014-07-03
101	12	2014-07-02
102	12	2014-07-03
103	12	2014-07-03
104	12	2014-07-04
105	12	2014-07-04
106	12	2014-07-03
107	12	2014-07-04
108	12	2014-07-03
109	12	2014-07-05
110	12	2014-07-03
111	12	2014-07-03
112	12	2014-07-07
113	12	2014-07-03
114	12	2014-07-04
115	12	2014-07-06
116	12	2014-07-03
117	12	2014-07-06
118	12	2014-07-07
119	12	2014-07-02
120	12	2014-07-03
81	13	2014-07-03
82	13	2014-07-05
83	13	2014-07-05
84	13	2014-07-06
85	13	2014-07-05
86	13	2014-07-03
87	13	2014-07-06
88	13	2014-07-02
89	13	2014-07-04
90	13	2014-07-02
91	13	2014-07-05
92	13	2014-07-04
93	13	2014-07-06
94	13	2014-07-02
95	13	2014-07-04
96	13	2014-07-02
97	13	2014-07-06
98	13	2014-07-03
99	13	2014-07-07
100	13	2014-07-01
101	13	2014-07-04
102	13	2014-07-02
103	13	2014-07-05
104	13	2014-07-07
105	13	2014-07-05
106	13	2014-07-01
107	13	2014-07-03
108	13	2014-07-01
109	13	2014-07-04
110	13	2014-07-05
111	13	2014-07-04
112	13	2014-07-04
113	13	2014-07-01
114	13	2014-07-07
115	13	2014-07-06
116	13	2014-07-03
117	13	2014-07-04
118	13	2014-07-01
119	13	2014-07-05
120	13	2014-07-02
81	14	2014-07-02
82	14	2014-07-03
83	14	2014-07-03
84	14	2014-07-07
85	14	2014-07-05
86	14	2014-07-07
87	14	2014-07-01
88	14	2014-07-04
89	14	2014-07-01
90	14	2014-07-03
91	14	2014-07-07
92	14	2014-07-05
93	14	2014-07-07
94	14	2014-07-07
95	14	2014-07-07
96	14	2014-07-03
97	14	2014-07-06
98	14	2014-07-05
99	14	2014-07-06
100	14	2014-07-02
101	14	2014-07-04
102	14	2014-07-06
103	14	2014-07-04
104	14	2014-07-05
105	14	2014-07-04
106	14	2014-07-07
107	14	2014-07-05
108	14	2014-07-03
109	14	2014-07-03
110	14	2014-07-05
111	14	2014-07-02
112	14	2014-07-03
113	14	2014-07-07
114	14	2014-07-01
115	14	2014-07-01
116	14	2014-07-02
117	14	2014-07-04
118	14	2014-07-04
119	14	2014-07-02
120	14	2014-07-02
81	15	2014-07-03
82	15	2014-07-02
83	15	2014-07-02
84	15	2014-07-06
85	15	2014-07-03
86	15	2014-07-06
87	15	2014-07-05
88	15	2014-07-02
89	15	2014-07-06
90	15	2014-07-05
91	15	2014-07-04
92	15	2014-07-07
93	15	2014-07-04
94	15	2014-07-07
95	15	2014-07-01
96	15	2014-07-04
97	15	2014-07-05
98	15	2014-07-05
99	15	2014-07-03
100	15	2014-07-05
101	15	2014-07-02
102	15	2014-07-04
103	15	2014-07-02
104	15	2014-07-07
105	15	2014-07-02
106	15	2014-07-02
107	15	2014-07-03
108	15	2014-07-03
109	15	2014-07-07
110	15	2014-07-05
111	15	2014-07-02
112	15	2014-07-06
113	15	2014-07-04
114	15	2014-07-03
115	15	2014-07-05
116	15	2014-07-03
117	15	2014-07-03
118	15	2014-07-03
119	15	2014-07-05
120	15	2014-07-05
81	16	2014-07-01
82	16	2014-07-07
83	16	2014-07-02
84	16	2014-07-07
85	16	2014-07-02
86	16	2014-07-03
87	16	2014-07-01
88	16	2014-07-06
89	16	2014-07-01
90	16	2014-07-04
91	16	2014-07-06
92	16	2014-07-06
93	16	2014-07-07
94	16	2014-07-06
95	16	2014-07-05
96	16	2014-07-05
97	16	2014-07-06
98	16	2014-07-04
99	16	2014-07-06
100	16	2014-07-07
101	16	2014-07-07
102	16	2014-07-03
103	16	2014-07-06
104	16	2014-07-06
105	16	2014-07-07
106	16	2014-07-01
107	16	2014-07-02
108	16	2014-07-05
109	16	2014-07-06
110	16	2014-07-07
111	16	2014-07-04
112	16	2014-07-02
113	16	2014-07-07
114	16	2014-07-03
115	16	2014-07-06
116	16	2014-07-01
117	16	2014-07-01
118	16	2014-07-05
119	16	2014-07-06
120	16	2014-07-05
121	17	2014-07-02
122	17	2014-07-06
123	17	2014-07-07
124	17	2014-07-03
125	17	2014-07-03
126	17	2014-07-02
127	17	2014-07-01
128	17	2014-07-07
129	17	2014-07-01
130	17	2014-07-07
131	17	2014-07-04
132	17	2014-07-07
133	17	2014-07-03
134	17	2014-07-01
135	17	2014-07-06
136	17	2014-07-06
137	17	2014-07-04
138	17	2014-07-02
139	17	2014-07-07
140	17	2014-07-05
141	17	2014-07-06
142	17	2014-07-01
143	17	2014-07-05
144	17	2014-07-01
145	17	2014-07-01
146	17	2014-07-07
147	17	2014-07-04
148	17	2014-07-03
149	17	2014-07-02
150	17	2014-07-05
151	17	2014-07-02
152	17	2014-07-03
153	17	2014-07-06
154	17	2014-07-06
155	17	2014-07-01
156	17	2014-07-04
157	17	2014-07-04
158	17	2014-07-01
159	17	2014-07-07
160	17	2014-07-07
121	18	2014-07-06
122	18	2014-07-01
123	18	2014-07-03
124	18	2014-07-05
125	18	2014-07-05
126	18	2014-07-02
127	18	2014-07-07
128	18	2014-07-03
129	18	2014-07-06
130	18	2014-07-02
131	18	2014-07-01
132	18	2014-07-05
133	18	2014-07-07
134	18	2014-07-01
135	18	2014-07-04
136	18	2014-07-02
137	18	2014-07-07
138	18	2014-07-06
139	18	2014-07-02
140	18	2014-07-07
141	18	2014-07-02
142	18	2014-07-06
143	18	2014-07-06
144	18	2014-07-07
145	18	2014-07-04
146	18	2014-07-07
147	18	2014-07-05
148	18	2014-07-07
149	18	2014-07-07
150	18	2014-07-07
151	18	2014-07-01
152	18	2014-07-02
153	18	2014-07-06
154	18	2014-07-07
155	18	2014-07-06
156	18	2014-07-01
157	18	2014-07-06
158	18	2014-07-06
159	18	2014-07-02
160	18	2014-07-05
121	19	2014-07-03
122	19	2014-07-03
123	19	2014-07-02
124	19	2014-07-07
125	19	2014-07-03
126	19	2014-07-05
127	19	2014-07-04
128	19	2014-07-03
129	19	2014-07-02
130	19	2014-07-05
131	19	2014-07-01
132	19	2014-07-01
133	19	2014-07-07
134	19	2014-07-06
135	19	2014-07-05
136	19	2014-07-05
137	19	2014-07-07
138	19	2014-07-07
139	19	2014-07-05
140	19	2014-07-02
141	19	2014-07-02
142	19	2014-07-04
143	19	2014-07-03
144	19	2014-07-04
145	19	2014-07-06
146	19	2014-07-03
147	19	2014-07-05
148	19	2014-07-02
149	19	2014-07-03
150	19	2014-07-01
151	19	2014-07-01
152	19	2014-07-01
153	19	2014-07-01
154	19	2014-07-07
155	19	2014-07-04
156	19	2014-07-04
157	19	2014-07-07
158	19	2014-07-07
159	19	2014-07-01
160	19	2014-07-06
121	20	2014-07-05
122	20	2014-07-05
123	20	2014-07-06
124	20	2014-07-01
125	20	2014-07-07
126	20	2014-07-02
127	20	2014-07-04
128	20	2014-07-02
129	20	2014-07-06
130	20	2014-07-05
131	20	2014-07-03
132	20	2014-07-01
133	20	2014-07-02
134	20	2014-07-03
135	20	2014-07-02
136	20	2014-07-07
137	20	2014-07-05
138	20	2014-07-01
139	20	2014-07-05
140	20	2014-07-04
141	20	2014-07-03
142	20	2014-07-07
143	20	2014-07-07
144	20	2014-07-01
145	20	2014-07-01
146	20	2014-07-06
147	20	2014-07-03
148	20	2014-07-06
149	20	2014-07-06
150	20	2014-07-01
151	20	2014-07-06
152	20	2014-07-01
153	20	2014-07-04
154	20	2014-07-05
155	20	2014-07-05
156	20	2014-07-03
157	20	2014-07-01
158	20	2014-07-03
159	20	2014-07-02
160	20	2014-07-05
121	21	2014-07-06
122	21	2014-07-04
123	21	2014-07-07
124	21	2014-07-03
125	21	2014-07-04
126	21	2014-07-01
127	21	2014-07-03
128	21	2014-07-01
129	21	2014-07-07
130	21	2014-07-07
131	21	2014-07-03
132	21	2014-07-03
133	21	2014-07-01
134	21	2014-07-06
135	21	2014-07-02
136	21	2014-07-04
137	21	2014-07-02
138	21	2014-07-07
139	21	2014-07-01
140	21	2014-07-03
141	21	2014-07-05
142	21	2014-07-07
143	21	2014-07-04
144	21	2014-07-05
145	21	2014-07-07
146	21	2014-07-05
147	21	2014-07-06
148	21	2014-07-04
149	21	2014-07-01
150	21	2014-07-03
151	21	2014-07-04
152	21	2014-07-05
153	21	2014-07-04
154	21	2014-07-02
155	21	2014-07-02
156	21	2014-07-05
157	21	2014-07-02
158	21	2014-07-05
159	21	2014-07-05
160	21	2014-07-02
\.


--
-- TOC entry 2085 (class 0 OID 16753)
-- Dependencies: 173
-- Data for Name: predio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY predio (cd_predio, nm_predio, local_predio) FROM stdin;
1	Predio 01	Bloco A
2	Predio 02	Bloco A
3	Predio 03	Bloco A
4	Predio 04	Bloco A
5	Predio 05	Bloco B
6	Predio 06	Bloco B
7	Predio 07	Bloco B
8	Predio 08	Bloco B
9	Predio 09	Bloco C
10	Predio 10	Bloco C
11	Predio 11	Bloco C
12	Predio 12	Bloco C
\.


--
-- TOC entry 2122 (class 0 OID 0)
-- Dependencies: 172
-- Name: predio_cd_predio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('predio_cd_predio_seq', 12, true);


--
-- TOC entry 2089 (class 0 OID 16769)
-- Dependencies: 177
-- Data for Name: professor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY professor (cd_prof, dpto_prof, pnm_prof, mnm_prof, unm_prof, esp_prof, email_prof, salario_prof) FROM stdin;
1	1	Eliseu	Da Silva	Costa	Matemática	eliseucosta@hotmail.com	1625.00
2	1	Messias	Casagrande	Filho	Biologia	messiasfilho@hotmail.com	3250.00
3	2	Diego	Santos	Matos	Física	diegomatos@hotmail.com	2437.50
4	2	Eliane	Ximenes	De Assis	Química	elianeximenes@hotmail.com	3250.00
5	2	Rafael	Pinheiro	Machado	Programação	rafaelmachado@hotmail.com	2031.25
6	3	José	Soares	Silva	Geografia	jose_gnt@gmail.com	3879.55
7	4	João	Pedro	Machado	Física	joaomachado@gmail.com	2843.75
8	4	Ana	Machado	Moreira	Portugues	anamachadinho@gmail.com	3250.00
9	4	Maria	Inácio	Castro	Química	castro.maria@gmail.com	3656.25
10	4	Julia	Horsth	Frare	Filosofia	jujufrare@gmail.com	4062.50
11	1	Maria	Cristina	Rangel	Programação	crangel@outlook.com	1300.00
12	2	Maria	Cláudia Silva	Boeres	Programação	boeres@hotmail.com	1300.00
13	3	José	Gonçalves	Ferreira	Geologia	zegonc@outlook.com	1300.00
14	4	Alexandre	\N	Amaral	Eletrônica	amaral@hotmail.com	1300.00
15	1	Edimar	\N	Vargas	Álgebra Linear	edimar.vargas@outlook.com	1300.00
16	2	Helbert	Ramanhole	De Vargas	Bando De Dados	ramanhole@outlook.com	1300.00
17	3	Roberta	Rufino	Felix	Lavra	rfelix@outlook.com	1300.00
18	3	Delmir	Vargas	Automação	Mineralogia	delmirv@outlook.com	1300.00
19	1	Guilherme	Fossi	Nascimento	Aritmética	gfossi@outlook.com	1300.00
20	2	Carlos	Magno Ramos	Oliveira	Análise De Sistemas	oliveira@outlook.com	1300.00
21	3	Theo	Goulart Bravo Santos	Pinheiro	Empreendedorismo	tpinheiro@outlook.com	1300.00
22	4	Gilson	Barbosa	São Teago	Automação	gilsonb@outlook.com	1300.00
23	1	Arildisson	Nunes	Ribeiro	Cálculo Numérico	aribeiro@outlook.com	1300.00
24	2	Natalia	Ferraz Thome	De Azevedo	Bando De Dados	deazevedo@outlook.com	1300.00
25	3	Keila	Brito	Vargas	Geomorfologia	kvargas@outlook.com	1300.00
26	4	Natalia	Fagundes	Coelho	Mecânica dos Sólidos	ncoelho@outlook.com	1300.00
27	1	Maira	Goulart Gomes	Martins	Geometria Analítica	mmartins@outlook.com	1300.00
28	2	Julio	Francisco Valiati	Marin	Redes	jmarin@outlook.com	1300.00
29	3	Maria	Luiza Leal Domingos	Guimaraes	Geoprocessamento	mguimaraes@outlook.com	1300.00
30	4	Alberto	Luciano	Carmassi	Fundição e Soldagem	acarmassi@hotmail.com	1300.00
31	1	Vanessa	Moreira	Osorio	Cálculo Diferencial	vosorio@hotmail.com	1300.00
32	2	Fabricia	Benda	De Oliveira	Desenvolvimento Web	fabriciab@hotmail.com	1300.00
33	3	Claudia	Regina Da Rocha	Oliveira	Hidrogeologia	coliveira@hotmail.com	1300.00
34	4	Luciano	Da Costa	Dias	Motores	luciano.dias@hotmail.com	1300.00
35	1	Elaine	Azevedo Nazario	Emerick	Geometria	eliane.emerick@hotmail.com	1300.00
36	2	Felicio	Gomes	Corteletti	Desenvolvimento Web	feliciano.gomes@hotmail.com	1300.00
37	3	Tharso	Dominisini	Fernandes	Automação	tharso.fernandes@hotmail.com	1300.00
38	4	Diana	Paula Diogo	Correia	Mecânica dos Materiais	diana.correa@hotmail.com	1300.00
39	1	Leticia	Ricieri	Bastos	Automação	leticia.bastos@hotmail.com	1300.00
40	2	Werickson	Madjer Sandes	Silva	Montagem e Manutenção de Computadores	wsilva@hotmail.com	1300.00
41	3	Welison	Carlos Loiola	Ribeiro	Automação	wribeiro@hotmail.com	1300.00
42	4	Wisley	Braga	Curty	Matemática Básica	wcurty@hotmail.com	1300.00
43	1	Raisa	Maria De Arruda	Martins	Matemática Financeira	rmatins@hotmail.com	1300.00
44	2	Sidney	De Oliveira	Regini	Matemática	sidney.regini@hotmail.com	1300.00
45	3	Luana	Barbosa	Laurindo	Química	luana.laurindo@yahoo.com	1300.00
46	4	Samira	Carneiro Gomes	D Almeida	Ciência dos Materiais	samira.dalmeida@yahoo.com	1300.00
47	1	Gessica	Gazolla	Teixeira	Probabilidade e Estatística	gessicat@yahoo.com	1300.00
48	2	Tiago	Sousa	Mota	Otimização	tmota@yahoo.com	1300.00
49	3	Leonard	Campos Avellar	Machado	Biologia	leonard.machado@yahoo.com	1300.00
50	4	Caio	Cesar Soares	Biancardi	Física	caio.biancardi@yahoo.com	1300.00
51	1	Lorena	Contarini	Machado	Física	lorena.machado@yahoo.com	1300.00
52	2	Kamila	Brison	Crico	Análise de Sistemas	kamila.crico@yahoo.com	1300.00
53	3	Juliana	Guadalupe Souza	Belmondes	Geoquímica	jbelmondes@yahoo.com	1300.00
54	4	Franklin	Willian Peixoto	Sofiati	Eletrônica	franklin.sofiati@yahoo.com	1300.00
55	1	Beatriz	Gueler	Dalvi	Psicologia	beatriz.dalvi@yahoo.com	1300.00
56	2	Pamella	Figueiredo	Andolfi	Banco de Dados	pandolfi@yahoo.com	1300.00
57	3	Tarcisio	Avila	Dos Santos	Lavra	dossantos@yahoo.com	1300.00
58	4	Eduardo	Gomes	Kaiser	Fundição e Soldagem	kaiser@yahoo.com	1300.00
59	1	Meridiana	Mendonca	De Freitas	Teoria dos Grafos	mdefreitas@yahoo.com	1300.00
60	2	Lukas	Souza	Felisberto	Programação	lukas.souza@yahoo.com	1300.00
61	3	Renato	Nolasco	Da Rocha 	Desmonte de Rocha	darocha@yahoo.com	1300.00
62	4	Romilda	Maria Barbosa	Laurindo	Cálculo	rlaurindo@globo.com	1300.00
\.


--
-- TOC entry 2123 (class 0 OID 0)
-- Dependencies: 176
-- Name: professor_cd_prof_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('professor_cd_prof_seq', 62, true);


--
-- TOC entry 2087 (class 0 OID 16761)
-- Dependencies: 175
-- Data for Name: sala; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sala (cd_sala, cd_predio, tipo_sala, cap_sala) FROM stdin;
1	1	Direção Geral	5
2	1	Direção de Ensino	5
3	1	Direção de Pesquisa e Extensão	15
4	1	Coordenadoria de Registros Acadêmicos	10
5	1	Coordenadoria de Apoio ao Ensino	10
6	1	NAPNE	10
7	1	Serviço Social	10
8	1	Enfermatira	15
9	1	Recursos Humanos	15
10	1	Protocolo	5
11	1	Sanitários Exclusivo para Servidoras	5
12	1	Sanitários Exclusivo para Servidores	5
13	2	Coordenadoria de Informática	15
14	2	Coordenadoria de Eletromecânica	15
15	2	Coordenadoria de Mineração	15
16	2	Colegiado de Engenharia de Minas	15
17	2	Colegiado de Engenharia de Mecânica	15
18	2	Colegiado de Licenciatura em Informática	15
19	2	Colegiado de Licenciatura em Matemática	15
20	2	Colegiado de Sistemas de Informação	15
21	2	Sanitários Exclusivo para Servidoras	5
22	2	Sanitários Exclusivo para Servidores	5
23	3	Laboratório de Química	40
24	3	Laboratório de Matemática	40
25	3	Laboratório de Física	40
26	3	Laboratório de Informática - Pesquisa e Trabalhos Acadêmicos	20
27	3	Laboratório de Informática - Desenvolvimento de Sistemas	20
28	3	Laboratório de Informática - Montagem e Manutenção	20
29	3	Laboratório de Informática - Redes	20
30	3	Laboratório de Informática - Otimização e Computação de Alto Desempanho	5
31	3	Sanitários - Mulheres	10
32	3	Sanitários - Homens	10
33	4	Sala de aula - Primeiro Ano de Eletromecanica	40
34	4	Sala de aula - Segundo Ano de Eletromecanica	40
35	4	Sala de aula - Terceiro Ano de Eletromecanica	40
36	4	Sala de aula - Quarto Ano de Eletromecanica	40
37	4	Sala de aula - Primeiro Ano de Mineração	40
38	4	Sala de aula - Segundo Ano de Mineração	40
39	4	Sala de aula - Terceiro Ano de Mineração	40
40	4	Sala de aula - Quarto Ano de Mineração	40
41	4	Sanitários - Mulheres	10
42	4	Sanitários - Homens	10
43	5	Sala de aula - Primeiro Ano de Informática	40
44	5	Sala de aula - Segundo Ano de Informática	40
45	5	Sala de aula - Terceiro Ano de Informática	40
46	5	Sala de aula - Quarto Ano de Informática	40
47	5	Biblioteca	100
48	5	Sanitários - Mulheres	10
49	5	Sanitários - Homens	10
50	6	Sala de Xadrez	15
51	6	Grêmio Estudantil	20
52	6	Sala de aula - Primeiro/Segundo Módulo de Engenharia de Minas	40
53	6	Sala de aula - Terceiro/Quarto Módulo de Engenharia de Minas	40
54	6	Sala de aula - Quinto/Sexto Módulo de Engenharia de Minas	40
55	6	Sala de aula - Sétimo/Oitavo Módulo de Engenharia de Minas	40
56	6	Sala de aula - Nono/Décimo Módulo de Engenharia de Minas	40
57	6	Laboratório de Rochas	40
58	6	Sanitários - Mulheres	10
59	6	Sanitários - Homens	10
60	7	Sala de aula - Primeiro/Segundo Módulo de Engenharia de Mecânica	40
61	7	Sala de aula - Terceiro/Quarto Módulo de Engenharia de Mecânica	40
62	7	Sala de aula - Quinto/Sexto Módulo de Engenharia de Mecânica	40
63	7	Sala de aula - Sétimo/Oitavo Módulo de Engenharia de Mecânica	40
64	7	Sala de aula - Nono/Décimo Módulo de Engenharia de Mecânica	40
65	7	Laboratório de Automação	40
66	7	Sanitários - Mulheres	10
67	7	Sanitários - Homens	10
68	8	Sala de aula - Primeiro/Segundo Módulo de Sistemas de Informação	40
69	8	Sala de aula - Terceiro/Quarto Módulo de Sistemas de Informação	40
70	8	Sala de aula - Quinto/Sexto Módulo de Sistemas de Informação	40
71	8	Sala de aula - Sétimo/Oitavo Módulo de Sistemas de Informação	40
72	8	Sala de aula - Re-oferta de Disciplinas	40
73	9	Sala de aula - Re-oferta de Disciplinas	40
74	8	Sanitários - Mulheres	10
75	8	Sanitários - Homens	10
76	9	Sala de aula - Primeiro/Segundo Módulo de Licenciatura em Matemática	40
77	9	Sala de aula - Terceiro/Quarto Módulo de Licenciatura em Matemática	40
78	9	Sala de aula - Quinto/Sexto Módulo de Licenciatura em Matemática	40
79	9	Sala de aula - Sétimo/Oitavo Módulo de Licenciatura em Matemática	40
80	9	Sala de aula - Re-oferta de Disciplinas	40
81	9	Sala de aula - Re-oferta de Disciplinas	40
82	9	Sanitários - Mulheres	10
83	9	Sanitários - Homens	10
84	10	Sala de aula - Atendimento ao aluno	40
85	10	Sala de aula - Atendimento ao aluno	40
86	10	Sala de aula - Re-oferta de Disciplinas	40
87	10	Sala de aula - Re-oferta de Disciplinas	40
88	10	Sala de aula - Atendimento ao aluno	40
89	10	Sala de aula - Atendimento ao aluno	40
90	10	Sala de aula - Re-oferta de Disciplinas	40
91	10	Sala de aula - Re-oferta de Disciplinas	40
92	10	Sanitários - Mulheres	10
93	10	Sanitários - Homens	10
94	11	Refeitorio	500
95	11	Cantina	40
96	11	Reprografia	40
97	12	Suprimentos	40
98	12	Vestiário Masculino	40
99	12	Vestiário Feminino	40
100	12	Centro de Vivência dos Servidores	50
\.


--
-- TOC entry 2124 (class 0 OID 0)
-- Dependencies: 174
-- Name: sala_cd_sala_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sala_cd_sala_seq', 100, true);


--
-- TOC entry 2097 (class 0 OID 16813)
-- Dependencies: 185
-- Data for Name: turma; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY turma (cd_turma, nmdisc_turma, dtcriacao_turma, semestre_turma, cd_prof, cd_curso, cd_sala) FROM stdin;
1	Cálculo I	2015-10-30	20152	44	3	68
2	Lógica	2015-10-30	20152	5	3	68
3	Programação I	2015-10-30	20152	12	3	68
4	Fundamentos de Sistemas da Informação	2015-10-30	20152	20	3	68
5	Metodologia da Pesquisa	2015-10-30	20152	48	3	68
6	Comunicação Empresarial	2015-10-30	20152	52	3	68
7	Sistemas Operacionais	2015-10-30	20152	40	3	69
8	Teoria Geral de Sistemas	2015-10-30	20152	24	3	69
9	Administração Financeira	2015-10-30	20152	56	3	69
10	Estrutura de Dados	2015-10-30	20152	60	3	69
11	Probabilidade e Estatística	2015-10-30	20152	44	3	69
12	Banco de Dados I	2015-10-30	20152	16	3	70
13	Engenharia de Software	2015-10-30	20152	32	3	70
14	Projeto de Sistemas	2015-10-30	20152	20	3	70
15	Serviçoes de Redes para Internet	2015-10-30	20152	28	3	70
16	Programação Orientada a Objetos II	2015-10-30	20152	12	3	70
17	Laboratório de Engenharia Software	2015-10-30	20152	20	3	71
18	Projeto de Diplomação I	2015-10-30	20152	32	3	71
19	Comércio Eletrônico	2015-10-30	20152	36	3	71
20	Gestão de Sistemas de Informação	2015-10-30	20152	20	3	71
21	Desenvolvimento Web	2015-10-30	20152	32	3	71
\.


--
-- TOC entry 2125 (class 0 OID 0)
-- Dependencies: 184
-- Name: turma_cd_turma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('turma_cd_turma_seq', 21, true);


--
-- TOC entry 1953 (class 2606 OID 16783)
-- Name: pk_aluno; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY aluno
    ADD CONSTRAINT pk_aluno PRIMARY KEY (cd_alu);


--
-- TOC entry 1957 (class 2606 OID 16810)
-- Name: pk_curso; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY curso
    ADD CONSTRAINT pk_curso PRIMARY KEY (cd_curso);


--
-- TOC entry 1963 (class 2606 OID 56260)
-- Name: pk_departamento; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY departamento
    ADD CONSTRAINT pk_departamento PRIMARY KEY (cd_dpto);


--
-- TOC entry 1955 (class 2606 OID 16791)
-- Name: pk_escola; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY escola
    ADD CONSTRAINT pk_escola PRIMARY KEY (cd_escola);


--
-- TOC entry 1961 (class 2606 OID 16825)
-- Name: pk_matricula; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY matricula
    ADD CONSTRAINT pk_matricula PRIMARY KEY (cd_alu, cd_turma);


--
-- TOC entry 1947 (class 2606 OID 16758)
-- Name: pk_predio; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY predio
    ADD CONSTRAINT pk_predio PRIMARY KEY (cd_predio);


--
-- TOC entry 1951 (class 2606 OID 16774)
-- Name: pk_professor; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY professor
    ADD CONSTRAINT pk_professor PRIMARY KEY (cd_prof);


--
-- TOC entry 1949 (class 2606 OID 16766)
-- Name: pk_sala; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sala
    ADD CONSTRAINT pk_sala PRIMARY KEY (cd_sala);


--
-- TOC entry 1959 (class 2606 OID 16820)
-- Name: pk_turma; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY turma
    ADD CONSTRAINT pk_turma PRIMARY KEY (cd_turma);


--
-- TOC entry 1966 (class 2606 OID 16836)
-- Name: fk01_aluno_professor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aluno
    ADD CONSTRAINT fk01_aluno_professor FOREIGN KEY (orientador_alu) REFERENCES professor(cd_prof);


--
-- TOC entry 1967 (class 2606 OID 16841)
-- Name: fk01_escola_professor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY escola
    ADD CONSTRAINT fk01_escola_professor FOREIGN KEY (diretor_escola) REFERENCES professor(cd_prof);


--
-- TOC entry 1971 (class 2606 OID 16876)
-- Name: fk01_matricula_aluno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY matricula
    ADD CONSTRAINT fk01_matricula_aluno FOREIGN KEY (cd_alu) REFERENCES aluno(cd_alu);


--
-- TOC entry 1972 (class 2606 OID 16881)
-- Name: fk01_matricula_turma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY matricula
    ADD CONSTRAINT fk01_matricula_turma FOREIGN KEY (cd_turma) REFERENCES turma(cd_turma);


--
-- TOC entry 1964 (class 2606 OID 16826)
-- Name: fk01_sala_predio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sala
    ADD CONSTRAINT fk01_sala_predio FOREIGN KEY (cd_predio) REFERENCES predio(cd_predio);


--
-- TOC entry 1968 (class 2606 OID 16861)
-- Name: fk01_turma_curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY turma
    ADD CONSTRAINT fk01_turma_curso FOREIGN KEY (cd_curso) REFERENCES curso(cd_curso);


--
-- TOC entry 1969 (class 2606 OID 16866)
-- Name: fk01_turma_professor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY turma
    ADD CONSTRAINT fk01_turma_professor FOREIGN KEY (cd_prof) REFERENCES professor(cd_prof);


--
-- TOC entry 1970 (class 2606 OID 16871)
-- Name: fk01_turma_sala; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY turma
    ADD CONSTRAINT fk01_turma_sala FOREIGN KEY (cd_sala) REFERENCES sala(cd_sala);


--
-- TOC entry 1973 (class 2606 OID 56261)
-- Name: fk_departamento_escola; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departamento
    ADD CONSTRAINT fk_departamento_escola FOREIGN KEY (cd_escola) REFERENCES escola(cd_escola);


--
-- TOC entry 1974 (class 2606 OID 56266)
-- Name: fk_departamento_professor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departamento
    ADD CONSTRAINT fk_departamento_professor FOREIGN KEY (coord_dpto) REFERENCES professor(cd_prof);


--
-- TOC entry 1965 (class 2606 OID 56271)
-- Name: fk_professor_departamento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY professor
    ADD CONSTRAINT fk_professor_departamento FOREIGN KEY (dpto_prof) REFERENCES departamento(cd_dpto);


--
-- TOC entry 2108 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-10-14 18:50:40

--
-- PostgreSQL database dump complete
--
select *
from professor as p;


select p.salario_prof
from professor as p
where p.pnm_prof = 'José';

select *
from professor as p
where p.dpto_prof = 3;

select p.pnm_prof, p.mnm_prof, p.unm_prof, d.cd_dpto,d.nm_dpto
from professor as p, departamento as d
where 

select *
from professor as p, departamento as d
where p.dpto_prof= d.cd_dpto;


select p.cd_prof,p.pnm_prof,p.unm_prof
from professor as p, departamento as d
where p.cd_prof= d.coord_dpto;

select *
from professor as p, departamento as d
where d.cd_dpto = dpto_prof and d.nm_dpto ='Informática';

select count(p.pnm_prof)
from professor as p
where 
-- Quando  não e especificado apresenta a pk e o nome
select d.cd_dpto, d.nm_dpto, count(*)
from curso as c, departamento as d
where c.cd_dpto = d.cd_dpto --expressao padrão de juncao
group by d.cd_dpto
-- quando utilizar na função de agregacao colocar os nomes do select no group by;
select * from departamento, curso

select d.cd_dpto,d.nm_dpto, sum(p.salario_prof)
from departamento as d, professor as p
where d.cd_dpto = p.dpto_prof
group by d.cd_dpto,d.nm_dpto
having sum(p.salario_prof)>22000;

select*
from professor



-- Lista 2
select t.cd_turma,t.nmdisc_turma,p.cd_prof, p.pnm_prof,p.unm_prof
from turma as t, professor as p
where t.cd_prof = p.cd_prof
