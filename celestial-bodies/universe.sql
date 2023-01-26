--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: cluster; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.cluster (
    cluster_id integer NOT NULL,
    name character varying(32) NOT NULL,
    mass_in_bsm numeric(9,3) NOT NULL,
    diameter_in_mly numeric(9,3) NOT NULL,
    year_discovered_ce integer,
    citation text
);


ALTER TABLE public.cluster OWNER TO freecodecamp;

--
-- Name: cluster_cluster_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.cluster_cluster_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cluster_cluster_id_seq OWNER TO freecodecamp;

--
-- Name: cluster_cluster_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.cluster_cluster_id_seq OWNED BY public.cluster.cluster_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    cluster_id integer NOT NULL,
    galaxy_id integer NOT NULL,
    name character varying(32) NOT NULL,
    galaxy_shape character varying(32) NOT NULL,
    mass_in_bsm numeric(9,3) NOT NULL,
    diameter_in_tly numeric(9,3) NOT NULL,
    year_discovered_ce integer,
    citation text
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    planet_id integer NOT NULL,
    moon_id integer NOT NULL,
    name character varying(32) NOT NULL,
    moon_type character varying(32) NOT NULL,
    mass_in_nsm numeric(9,3) NOT NULL,
    diameter_in_tkm numeric(9,3) NOT NULL,
    year_discovered_ce integer,
    citation text
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    star_id integer NOT NULL,
    planet_id integer NOT NULL,
    name character varying(32) NOT NULL,
    planet_type character varying(32) NOT NULL,
    mass_in_usm numeric(9,3) NOT NULL,
    diameter_in_tkm numeric(9,3) NOT NULL,
    has_water boolean NOT NULL,
    has_oxygen boolean NOT NULL,
    has_life boolean,
    year_discovered_ce integer,
    citation text
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    galaxy_id integer NOT NULL,
    star_id integer NOT NULL,
    name character varying(32) NOT NULL,
    star_type character varying(32) NOT NULL,
    mass_in_sm numeric(9,3) NOT NULL,
    diameter_in_mkm numeric(9,3) NOT NULL,
    colour character varying(32) NOT NULL,
    year_discovered_ce integer,
    citation text
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: cluster cluster_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.cluster ALTER COLUMN cluster_id SET DEFAULT nextval('public.cluster_cluster_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: cluster; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.cluster VALUES (1, 'Floretta', 2000.000, 10.000, 1902, 'K. Riggs, L. Wayde, Quarterly Astrophysical Bulletin, 128, 166, (1902).');
INSERT INTO public.cluster VALUES (2, 'Lorenna', 2980.000, 10.000, 755, 'L. U. Sirafumi, Observations from the Top of Mount Asari, translated by N. Anise, (Wrightmill Publishers, 1799).');
INSERT INTO public.cluster VALUES (3, 'Cerclerra', 840.000, 10.000, 758, 'K. K. Yukari, Compendium of Heavenly Motions, translated by M. Irwin, (Storyhill University Press, 1785).');


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 1, 'Melvoria', 'Spiral', 1500.000, 87.400, NULL, NULL);
INSERT INTO public.galaxy VALUES (1, 2, 'Rosaccaea', 'Spiral', 1500.000, 87.400, NULL, NULL);
INSERT INTO public.galaxy VALUES (2, 3, 'Inspisidum', 'Spiral', 1500.000, 87.400, NULL, NULL);
INSERT INTO public.galaxy VALUES (2, 4, 'Compass', 'Bar', 1500.000, 87.400, NULL, NULL);
INSERT INTO public.galaxy VALUES (3, 5, 'Ignimim', 'Bar', 1500.000, 87.400, NULL, NULL);
INSERT INTO public.galaxy VALUES (3, 6, 'Chorohill', 'Irregular', 1500.000, 87.400, NULL, NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 1, 'Lunum', 'Satellite Planet', 37.000, 3.476, NULL, NULL);
INSERT INTO public.moon VALUES (2, 2, 'Cox', 'Round Rocky', 22.000, 2.770, 1343, 'C. L. Yu, The Harmony of Celestial Beings, translated by L. Argo-Imari, (Fussilight Press, 1791).');
INSERT INTO public.moon VALUES (2, 3, 'Argent', 'Round Rocky', 19.000, 2.350, 1768, 'R. M. R. Lumen, Proceedings of the Academy of New Peyder, 2, 37, (1768).');
INSERT INTO public.moon VALUES (2, 4, 'Alloy', 'Round Rocky', 15.000, 2.020, 1768, 'R. M. R. Lumen, Proceedings of the Academy of New Peyder, 2, 37, (1768).');
INSERT INTO public.moon VALUES (3, 5, 'Encyclidas', 'Round Rocky', 17.000, 2.400, 1792, 'D. Thena, K. Linseed, Quarterly Astrophysical Bulletin, 18, 12, (1792).');
INSERT INTO public.moon VALUES (3, 6, 'Oberon', 'Round Rocky', 18.000, 2.400, 1792, 'D. Thena, K. Linseed, Quarterly Astrophysical Bulletin, 18, 12, (1792).');
INSERT INTO public.moon VALUES (3, 7, 'Cardsas', 'Irregular', 11.000, 1.700, 1792, 'D. Thena, K. Linseed, Quarterly Astrophysical Bulletin, 18, 12, (1792).');
INSERT INTO public.moon VALUES (3, 8, 'Omporen', 'Irregular', 10.000, 1.400, 1792, 'D. Thena, K. Linseed, Quarterly Astrophysical Bulletin, 18, 12, (1792).');
INSERT INTO public.moon VALUES (4, 9, 'Ludin', 'Round Rocky', 15.000, 2.000, 1788, 'T. Holly, K. Somer, R. Andre, Proceedings of the National Institute of Physicists, 21, 121, (1788).');
INSERT INTO public.moon VALUES (4, 10, 'Almond', 'Round Rocky', 17.000, 2.200, 1788, 'T. Holly, K. Somer, R. Andre, Proceedings of the National Institute of Physicists, 21, 121, (1788).');
INSERT INTO public.moon VALUES (5, 11, 'Ira', 'Round Rocky', 19.000, 2.500, 1821, 'K. Linseed, V. Hayhn, T. D. Yu, Proceedings of the Academy of New Peyder, 55, 41, (1821).');
INSERT INTO public.moon VALUES (5, 12, 'Rememvar', 'Round Rocky', 17.000, 2.100, 1821, 'K. Linseed, V. Hayhn, T. D. Yu, Proceedings of the Academy of New Peyder, 55, 41, (1821).');
INSERT INTO public.moon VALUES (5, 13, 'Siren', 'Round Rocky', 19.000, 2.400, 1821, 'K. Linseed, V. Hayhn, T. D. Yu, Proceedings of the Academy of New Peyder, 55, 41, (1821).');
INSERT INTO public.moon VALUES (5, 14, 'Eumon', 'Irregular', 10.000, 1.200, 1901, 'L. May, K. Jamal, K. Jared, P. Mayu, Astronomy Letters, 139, 233, (1901).');
INSERT INTO public.moon VALUES (6, 15, 'Soplicle', 'Round Rocky', 15.000, 2.000, 1823, 'K. Linseed, D. Hopenri, T. D. Yu, Quarterly Astrophysical Bulletin, 49, 244, (1823).');
INSERT INTO public.moon VALUES (6, 16, 'Tracta', 'Round Rocky', 26.000, 3.000, 1823, 'K. Linseed, D. Hopenri, T. D. Yu, Quarterly Astrophysical Bulletin, 49, 244, (1823).');
INSERT INTO public.moon VALUES (6, 17, 'Miner', 'Irregular', 11.000, 1.300, 1901, 'L. May, K. Jamal, K. Jared, P. Mayu, Astronomy Letters, 139, 233, (1901).');
INSERT INTO public.moon VALUES (6, 18, 'Etch', 'Irregular', 8.000, 1.000, 1901, 'L. May, K. Jamal, K. Jared, P. Mayu, Astronomy Letters, 139, 233, (1901).');
INSERT INTO public.moon VALUES (7, 19, 'Sunrin', 'Irregular', 7.000, 0.900, 1904, 'L. May, K. Jared, P. Mayu, Proceedings of the National Institute of Physicists, 137, 9, (1904).');
INSERT INTO public.moon VALUES (7, 20, 'Okara', 'Irregular', 8.000, 0.900, 1904, 'L. May, K. Jared, P. Mayu, Proceedings of the National Institute of Physicists, 137, 9, (1904).');


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 1, 'Terrum', 'Rocky', 3.000, 12.756, true, true, true, NULL, NULL);
INSERT INTO public.planet VALUES (1, 2, 'Era', 'Rocky', 2.200, 10.900, false, false, false, NULL, NULL);
INSERT INTO public.planet VALUES (1, 3, 'Ornum', 'Rocky', 1.000, 3.000, false, false, false, NULL, NULL);
INSERT INTO public.planet VALUES (1, 4, 'Sophos', 'Rocky', 4.000, 17.500, true, false, false, NULL, NULL);
INSERT INTO public.planet VALUES (1, 5, 'Heidi', 'Gas', 43.000, 51.000, false, false, false, 687, 'R. Kakahomu, Third Quarterly Report of the Imperial Shrine in the Ninth Year of the Sorami Era, translated by K. Orbricht, (Ium University Press, 1823).');
INSERT INTO public.planet VALUES (1, 6, 'Casa', 'Gas', 66.000, 57.000, false, false, false, NULL, NULL);
INSERT INTO public.planet VALUES (1, 7, 'Liaison', 'Dwarf', 0.460, 6.500, false, false, false, 1893, 'A. Gallides, W. B. Yi, P. P. Shang-Wu, Royal Transactions Series P, 61, 65, (1893).');
INSERT INTO public.planet VALUES (2, 8, 'Search', 'Gas', 45.000, 51.000, false, false, NULL, 1932, 'L. Halla, R. Ingen, R. Holand, Quarterly Astrophysical Bulletin, 158, 76, (1932).');
INSERT INTO public.planet VALUES (2, 9, 'Sen Major', 'Gas', 87.000, 60.000, false, false, NULL, 1932, 'L. Halla, R. Ingen, R. Holand, Quarterly Astrophysical Bulletin, 158, 76, (1932).');
INSERT INTO public.planet VALUES (2, 10, 'Sen Minor', 'Gas', 62.000, 55.000, false, false, NULL, 1932, 'L. Halla, R. Ingen, R. Holand, Quarterly Astrophysical Bulletin, 158, 76, (1932).');
INSERT INTO public.planet VALUES (3, 11, 'Teren Turn', 'Rocky', 2.700, 12.000, true, false, NULL, 1951, 'K. Agen, C. Al-Istafar, I. C. Ruo, K. C. Ren, I. Johnson, ICA Proceedings B: Planatery Science, 44, 428, (1951).');
INSERT INTO public.planet VALUES (3, 12, 'Teren Tide', 'Gas', 37.000, 45.000, true, false, NULL, 1951, 'K. Agen, C. Al-Istafar, I. C. Ruo, K. C. Ren, I. Johnson, ICA Proceedings B: Planatery Science, 44, 428, (1951).');
INSERT INTO public.planet VALUES (4, 13, 'Sora C132', 'Rocky', 5.000, 14.000, true, false, NULL, 1973, 'C. Rokka, Et Al, Natural Science, 182, 34, (1973).');
INSERT INTO public.planet VALUES (4, 14, 'Sora C135', 'Rocky', 5.500, 15.000, true, true, NULL, 1973, 'C. Rokka, Et Al, Natural Science, 182, 34, (1973).');
INSERT INTO public.planet VALUES (5, 15, 'Corpus Reid', 'Gas', 23.000, 31.000, true, false, NULL, 1974, 'A. Lowry, Et Al, Astronomy Letters, 212, 46, (1974).');
INSERT INTO public.planet VALUES (6, 16, 'Corpus Alda', 'Gas', 31.000, 36.000, true, true, NULL, 1976, 'S. Ximpa, Et Al, Royal Transactions Series P, 144, 165, (1976).');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 1, 'Hibiscus', 'G2V', 1.000, 1.390, 'White', NULL, NULL);
INSERT INTO public.star VALUES (1, 2, 'Cacao', 'G5V', 0.740, 0.980, 'Light Orange', 442, 'Y. C. Ko, Sixty-Seventh Report of the Royal Astrological Division to Emperor Yuanfeng, translated by N. Anise, (Wrightmill Publishers, 1797)');
INSERT INTO public.star VALUES (2, 3, 'White Rose', 'A0Ia', 29.000, 830.000, 'Bluish White', NULL, NULL);
INSERT INTO public.star VALUES (2, 4, 'Dewberry', 'B1II', 2.600, 4.900, 'Blue', 442, 'Y. C. Ko, Sixty-Seventh Report of the Royal Astrological Division to Emperor Yuanfeng, translated by N. Anise, (Wrightmill Publishers, 1797)');
INSERT INTO public.star VALUES (3, 5, 'Torteria', 'O0Ia', 55.000, 2600.000, 'White', 755, 'L. U. Sirafumi, Observations from the Top of Mount Asari, translated by N. Anise, (Wrightmill Publishers, 1799).');
INSERT INTO public.star VALUES (6, 6, 'May Wren', 'A1V', 35.000, 1000.000, 'White', NULL, NULL);


--
-- Name: cluster_cluster_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.cluster_cluster_id_seq', 3, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 16, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: cluster cluster_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.cluster
    ADD CONSTRAINT cluster_name_key UNIQUE (name);


--
-- Name: cluster cluster_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.cluster
    ADD CONSTRAINT cluster_pkey PRIMARY KEY (cluster_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy galaxy_cluster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_cluster_id_fkey FOREIGN KEY (cluster_id) REFERENCES public.cluster(cluster_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

