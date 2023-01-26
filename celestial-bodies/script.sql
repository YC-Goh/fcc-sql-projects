
CREATE DATABASE universe;

\c universe

CREATE TABLE cluster (
    cluster_id SERIAL PRIMARY KEY, 
    name VARCHAR(32) UNIQUE NOT NULL, 
    mass_in_bsm NUMERIC(9,3) NOT NULL, 
    diameter_in_mly NUMERIC(9,3) NOT NULL, 
    year_discovered_ce INT, 
    citation TEXT
);

CREATE TABLE galaxy (
    cluster_id INT NOT NULL REFERENCES cluster (cluster_id), 
    galaxy_id SERIAL PRIMARY KEY, 
    name VARCHAR(32) UNIQUE NOT NULL, 
    galaxy_shape VARCHAR(32) NOT NULL, 
    mass_in_bsm NUMERIC(9,3) NOT NULL, 
    diameter_in_tly NUMERIC(9,3) NOT NULL, 
    year_discovered_ce INT, 
    citation TEXT
);

CREATE TABLE star (
    galaxy_id INT NOT NULL REFERENCES galaxy (galaxy_id), 
    star_id SERIAL PRIMARY KEY, 
    name VARCHAR(32) UNIQUE NOT NULL, 
    star_type VARCHAR(32) NOT NULL, 
    mass_in_sm NUMERIC(9,3) NOT NULL, 
    diameter_in_mkm NUMERIC(9,3) NOT NULL, 
    colour VARCHAR(32) NOT NULL, 
    year_discovered_ce INT, 
    citation TEXT
);

CREATE TABLE planet (
    star_id INT NOT NULL REFERENCES star (star_id), 
    planet_id SERIAL PRIMARY KEY, 
    name VARCHAR(32) UNIQUE NOT NULL, 
    planet_type VARCHAR(32) NOT NULL, 
    mass_in_usm NUMERIC(9,3) NOT NULL, 
    diameter_in_tkm NUMERIC(9,3) NOT NULL, 
    has_water BOOLEAN NOT NULL, 
    has_oxygen BOOLEAN NOT NULL, 
    has_life BOOLEAN, 
    year_discovered_ce INT, 
    citation TEXT
);

CREATE TABLE moon (
    planet_id INT NOT NULL REFERENCES planet (planet_id), 
    moon_id SERIAL PRIMARY KEY, 
    name VARCHAR(32) UNIQUE NOT NULL, 
    moon_type VARCHAR(32) NOT NULL, 
    mass_in_nsm NUMERIC(9,3) NOT NULL, 
    diameter_in_tkm NUMERIC(9,3) NOT NULL, 
    year_discovered_ce INT, 
    citation TEXT
);

INSERT INTO cluster (name, mass_in_bsm, diameter_in_mly, year_discovered_ce, citation)
VALUES
    ('Floretta', 2000, 10, 1902, 'K. Riggs, L. Wayde, Quarterly Astrophysical Bulletin, 128, 166, (1902).'),
    ('Lorenna', 2980, 10, 755, 'L. U. Sirafumi, Observations from the Top of Mount Asari, translated by N. Anise, (Wrightmill Publishers, 1799).'),
    ('Cerclerra', 840, 10, 758, 'K. K. Yukari, Compendium of Heavenly Motions, translated by M. Irwin, (Storyhill University Press, 1785).')
;

INSERT INTO galaxy (cluster_id, name, galaxy_shape, mass_in_bsm, diameter_in_tly, year_discovered_ce, citation)
VALUES
    (1, 'Melvoria', 'Spiral', 1500, 87.4, NULL, NULL),
    (1, 'Rosaccaea', 'Spiral', 1500, 87.4, NULL, NULL),
    (2, 'Inspisidum', 'Spiral', 1500, 87.4, NULL, NULL),
    (2, 'Compass', 'Bar', 1500, 87.4, NULL, NULL),
    (3, 'Ignimim', 'Bar', 1500, 87.4, NULL, NULL),
    (3, 'Chorohill', 'Irregular', 1500, 87.4, NULL, NULL)
;

INSERT INTO star (galaxy_id, name, star_type, mass_in_sm, diameter_in_mkm, colour, year_discovered_ce, citation)
VALUES
    (1, 'Hibiscus', 'G2V', 1, 1.39, 'White', NULL, NULL),
    (1, 'Cacao', 'G5V', 0.74, 0.98, 'Light Orange', 442, 'Y. C. Ko, Sixty-Seventh Report of the Royal Astrological Division to Emperor Yuanfeng, translated by N. Anise, (Wrightmill Publishers, 1797)'),
    (2, 'White Rose', 'A0Ia', 29, 830, 'Bluish White', NULL, NULL),
    (2, 'Dewberry', 'B1II', 2.6, 4.9, 'Blue', 442, 'Y. C. Ko, Sixty-Seventh Report of the Royal Astrological Division to Emperor Yuanfeng, translated by N. Anise, (Wrightmill Publishers, 1797)'),
    (3, 'Torteria', 'O0Ia', 55, 2600, 'White', 755, 'L. U. Sirafumi, Observations from the Top of Mount Asari, translated by N. Anise, (Wrightmill Publishers, 1799).'),
    (6, 'May Wren', 'A1V', 35, 1000, 'White', NULL, NULL)
;

INSERT INTO planet (star_id, name, planet_type, mass_in_usm, diameter_in_tkm, has_water, has_oxygen, has_life, year_discovered_ce, citation)
VALUES
    (1, 'Terrum', 'Rocky', 3, 12.756, TRUE, TRUE, TRUE, NULL, NULL),
    (1, 'Era', 'Rocky', 2.2, 10.9, FALSE, FALSE, FALSE, NULL, NULL),
    (1, 'Ornum', 'Rocky', 1, 3, FALSE, FALSE, FALSE, NULL, NULL),
    (1, 'Sophos', 'Rocky', 4, 17.5, TRUE, FALSE, FALSE, NULL, NULL),
    (1, 'Heidi', 'Gas', 43, 51, FALSE, FALSE, FALSE, 687, 'R. Kakahomu, Third Quarterly Report of the Imperial Shrine in the Ninth Year of the Sorami Era, translated by K. Orbricht, (Ium University Press, 1823).'),
    (1, 'Casa', 'Gas', 66, 57, FALSE, FALSE, FALSE, NULL, NULL),
    (1, 'Liaison', 'Dwarf', .46, 6.5, FALSE, FALSE, FALSE, 1893, 'A. Gallides, W. B. Yi, P. P. Shang-Wu, Royal Transactions Series P, 61, 65, (1893).'),
    (2, 'Search', 'Gas', 45, 51, FALSE, FALSE, NULL, 1932, 'L. Halla, R. Ingen, R. Holand, Quarterly Astrophysical Bulletin, 158, 76, (1932).'),
    (2, 'Sen Major', 'Gas', 87, 60, FALSE, FALSE, NULL, 1932, 'L. Halla, R. Ingen, R. Holand, Quarterly Astrophysical Bulletin, 158, 76, (1932).'),
    (2, 'Sen Minor', 'Gas', 62, 55, FALSE, FALSE, NULL, 1932, 'L. Halla, R. Ingen, R. Holand, Quarterly Astrophysical Bulletin, 158, 76, (1932).'),
    (3, 'Teren Turn', 'Rocky', 2.7, 12, TRUE, FALSE, NULL, 1951, 'K. Agen, C. Al-Istafar, I. C. Ruo, K. C. Ren, I. Johnson, ICA Proceedings B: Planatery Science, 44, 428, (1951).'),
    (3, 'Teren Tide', 'Gas', 37, 45, TRUE, FALSE, NULL, 1951, 'K. Agen, C. Al-Istafar, I. C. Ruo, K. C. Ren, I. Johnson, ICA Proceedings B: Planatery Science, 44, 428, (1951).'),
    (4, 'Sora C132', 'Rocky', 5, 14, TRUE, FALSE, NULL, 1973, 'C. Rokka, Et Al, Natural Science, 182, 34, (1973).'),
    (4, 'Sora C135', 'Rocky', 5.5, 15, TRUE, TRUE, NULL, 1973, 'C. Rokka, Et Al, Natural Science, 182, 34, (1973).'),
    (5, 'Corpus Reid', 'Gas', 23, 31, TRUE, FALSE, NULL, 1974, 'A. Lowry, Et Al, Astronomy Letters, 212, 46, (1974).'),
    (6, 'Corpus Alda', 'Gas', 31, 36, TRUE, TRUE, NULL, 1976, 'S. Ximpa, Et Al, Royal Transactions Series P, 144, 165, (1976).')
;

INSERT INTO moon (planet_id, name, moon_type, mass_in_nsm, diameter_in_tkm, year_discovered_ce, citation)
VALUES
    (1, 'Lunum', 'Satellite Planet', 37, 3.476, NULL, NULL),
    (2, 'Cox', 'Round Rocky', 22, 2.77, 1343, 'C. L. Yu, The Harmony of Celestial Beings, translated by L. Argo-Imari, (Fussilight Press, 1791).'),
    (2, 'Argent', 'Round Rocky', 19, 2.35, 1768, 'R. M. R. Lumen, Proceedings of the Academy of New Peyder, 2, 37, (1768).'),
    (2, 'Alloy', 'Round Rocky', 15, 2.02, 1768, 'R. M. R. Lumen, Proceedings of the Academy of New Peyder, 2, 37, (1768).'),
    (3, 'Encyclidas', 'Round Rocky', 17, 2.4, 1792, 'D. Thena, K. Linseed, Quarterly Astrophysical Bulletin, 18, 12, (1792).'),
    (3, 'Oberon', 'Round Rocky', 18, 2.4, 1792, 'D. Thena, K. Linseed, Quarterly Astrophysical Bulletin, 18, 12, (1792).'),
    (3, 'Cardsas', 'Irregular', 11, 1.7, 1792, 'D. Thena, K. Linseed, Quarterly Astrophysical Bulletin, 18, 12, (1792).'),
    (3, 'Omporen', 'Irregular', 10, 1.4, 1792, 'D. Thena, K. Linseed, Quarterly Astrophysical Bulletin, 18, 12, (1792).'),
    (4, 'Ludin', 'Round Rocky', 15, 2, 1788, 'T. Holly, K. Somer, R. Andre, Proceedings of the National Institute of Physicists, 21, 121, (1788).'),
    (4, 'Almond', 'Round Rocky', 17, 2.2, 1788, 'T. Holly, K. Somer, R. Andre, Proceedings of the National Institute of Physicists, 21, 121, (1788).'),
    (5, 'Ira', 'Round Rocky', 19, 2.5, 1821, 'K. Linseed, V. Hayhn, T. D. Yu, Proceedings of the Academy of New Peyder, 55, 41, (1821).'),
    (5, 'Rememvar', 'Round Rocky', 17, 2.1, 1821, 'K. Linseed, V. Hayhn, T. D. Yu, Proceedings of the Academy of New Peyder, 55, 41, (1821).'),
    (5, 'Siren', 'Round Rocky', 19, 2.4, 1821, 'K. Linseed, V. Hayhn, T. D. Yu, Proceedings of the Academy of New Peyder, 55, 41, (1821).'),
    (5, 'Eumon', 'Irregular', 10, 1.2, 1901, 'L. May, K. Jamal, K. Jared, P. Mayu, Astronomy Letters, 139, 233, (1901).'),
    (6, 'Soplicle', 'Round Rocky', 15, 2, 1823, 'K. Linseed, D. Hopenri, T. D. Yu, Quarterly Astrophysical Bulletin, 49, 244, (1823).'),
    (6, 'Tracta', 'Round Rocky', 26, 3, 1823, 'K. Linseed, D. Hopenri, T. D. Yu, Quarterly Astrophysical Bulletin, 49, 244, (1823).'),
    (6, 'Miner', 'Irregular', 11, 1.3, 1901, 'L. May, K. Jamal, K. Jared, P. Mayu, Astronomy Letters, 139, 233, (1901).'),
    (6, 'Etch', 'Irregular', 8, 1, 1901, 'L. May, K. Jamal, K. Jared, P. Mayu, Astronomy Letters, 139, 233, (1901).'),
    (7, 'Sunrin', 'Irregular', 7, .9, 1904, 'L. May, K. Jared, P. Mayu, Proceedings of the National Institute of Physicists, 137, 9, (1904).'),
    (7, 'Okara', 'Irregular', 8, .9, 1904, 'L. May, K. Jared, P. Mayu, Proceedings of the National Institute of Physicists, 137, 9, (1904).')
;
