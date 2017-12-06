-- Schema: draanks

-- DROP SCHEMA draanks;

CREATE SCHEMA draanks
  AUTHORIZATION postgres;

-- Sequence: draanks.category_id_seq

-- DROP SEQUENCE draanks.category_id_seq;

CREATE SEQUENCE draanks.category_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE draanks.category_id_seq
  OWNER TO postgres;

-- Sequence: draanks.ingredient_id_seq

-- DROP SEQUENCE draanks.ingredient_id_seq;

CREATE SEQUENCE draanks.ingredient_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE draanks.ingredient_id_seq
  OWNER TO postgres;

-- Sequence: draanks.measure_id_seq

-- DROP SEQUENCE draanks.measure_id_seq;

CREATE SEQUENCE draanks.measure_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE draanks.measure_id_seq
  OWNER TO postgres;


-- Sequence: draanks.members_id_seq

-- DROP SEQUENCE draanks.members_id_seq;

CREATE SEQUENCE draanks.members_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE draanks.members_id_seq
  OWNER TO postgres;

-- Sequence: draanks.recipeingredient_id_seq

-- DROP SEQUENCE draanks.recipeingredient_id_seq;

CREATE SEQUENCE draanks.recipeingredient_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE draanks.recipeingredient_id_seq
  OWNER TO postgres;

-- Sequence: draanks.recipes_id_seq

-- DROP SEQUENCE draanks.recipes_id_seq;

CREATE SEQUENCE draanks.recipes_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE draanks.recipes_id_seq
  OWNER TO postgres;

-- Table: draanks.bitters

-- DROP TABLE draanks.bitters;

CREATE TABLE draanks.bitters
(
  id integer,
  name text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE draanks.bitters
  OWNER TO postgres;

-- Table: draanks.category

-- DROP TABLE draanks.category;

CREATE TABLE draanks.category
(
  id integer NOT NULL DEFAULT nextval('draanks.category_id_seq'::regclass),
  name text,
  CONSTRAINT category_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE draanks.category
  OWNER TO postgres;


-- Table: draanks.ingredient

-- DROP TABLE draanks.ingredient;

CREATE TABLE draanks.ingredient
(
  id integer NOT NULL DEFAULT nextval('draanks.ingredient_id_seq'::regclass),
  name text,
  CONSTRAINT ingredient_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE draanks.ingredient
  OWNER TO postgres;

-- Table: draanks.measure

-- DROP TABLE draanks.measure;

CREATE TABLE draanks.measure
(
  id integer NOT NULL DEFAULT nextval('draanks.measure_id_seq'::regclass),
  name text NOT NULL,
  plural boolean,
  CONSTRAINT measure_pkey PRIMARY KEY (id, name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE draanks.measure
  OWNER TO postgres;


-- Table: draanks.members

-- DROP TABLE draanks.members;

CREATE TABLE draanks.members
(
  id integer NOT NULL DEFAULT nextval('draanks.members_id_seq'::regclass),
  name_first text,
  name_last text,
  name_business text,
  occupation text, -- looking for president, CFO, CEO, lead dishwasher, head honcho
  email text,
  phone_main text,
  phone_secondary text,
  member_since date DEFAULT now(),
  active boolean DEFAULT true,
  comments text,
  onlineid text,
  password text,
  pword_type integer, -- is  the password is permanent (1)  or temporary (0)?
  member_type integer, -- regularUser = 0; admin = 1
  CONSTRAINT members_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE draanks.members
  OWNER TO postgres;
COMMENT ON COLUMN draanks.members.occupation IS 'looking for president, CFO, CEO, lead dishwasher, head honcho';
COMMENT ON COLUMN draanks.members.pword_type IS 'is  the password is permanent (1)  or temporary (0)?';
COMMENT ON COLUMN draanks.members.member_type IS 'regularUser = 0; admin = 1';

-- Table: draanks.recipe

-- DROP TABLE draanks.recipe;

CREATE TABLE draanks.recipe
(
  name text,
  description text,
  portions integer,
  id integer NOT NULL DEFAULT nextval('draanks.recipes_id_seq'::regclass),
  instructions text,
  bittersid integer,
  categoryid integer,
  CONSTRAINT recipe_pkey PRIMARY KEY (id),
  CONSTRAINT fk_category FOREIGN KEY (categoryid)
      REFERENCES draanks.category (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE draanks.recipe
  OWNER TO postgres;

-- Table: draanks.recipeingredient

-- DROP TABLE draanks.recipeingredient;

CREATE TABLE draanks.recipeingredient
(
  id integer NOT NULL DEFAULT nextval('draanks.recipeingredient_id_seq'::regclass),
  recipeid integer,
  ingredientid integer,
  quantity text,
  measureid integer,
  sequence integer,
  CONSTRAINT recipeingredient_pkey PRIMARY KEY (id),
  CONSTRAINT ingredient_fk FOREIGN KEY (ingredientid)
      REFERENCES draanks.ingredient (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE draanks.recipeingredient
  OWNER TO postgres;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.1
-- Dumped by pg_dump version 9.3.1
-- Started on 2017-12-05 16:19:02 PST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = draanks, pg_catalog;

--
-- TOC entry 2385 (class 0 OID 42889)
-- Dependencies: 210
-- Data for Name: bitters; Type: TABLE DATA; Schema: draanks; Owner: postgres
--

INSERT INTO draanks.bitters (id, name) VALUES (1, 'Pendelton Whiskey');
INSERT INTO draanks.bitters (id, name) VALUES (2, 'Sweet Vermouth');
INSERT INTO draanks.bitters (id, name) VALUES (3, 'Whiskey Bitters');
INSERT INTO draanks.bitters (id, name) VALUES (4, 'Angostura Bitters');
INSERT INTO draanks.bitters (id, name) VALUES (6, 'Bada Bing Cherries');
INSERT INTO draanks.bitters (id, name) VALUES (7, 'Applejack');
INSERT INTO draanks.bitters (id, name) VALUES (8, 'Rye Whiskey');
INSERT INTO draanks.bitters (id, name) VALUES (9, 'Islay Scotch');
INSERT INTO draanks.bitters (id, name) VALUES (10, 'Yellow Chartreuse');
INSERT INTO draanks.bitters (id, name) VALUES (11, 'B&B');
INSERT INTO draanks.bitters (id, name) VALUES (12, 'Lemon Juice');
INSERT INTO draanks.bitters (id, name) VALUES (13, 'St. Germain');
INSERT INTO draanks.bitters (id, name) VALUES (14, 'Grapefruit Juice');
INSERT INTO draanks.bitters (id, name) VALUES (15, 'Jalapeño Syrup');
INSERT INTO draanks.bitters (id, name) VALUES (16, 'Vodka');
INSERT INTO draanks.bitters (id, name) VALUES (17, 'Bada Bing Cherry Juice');
INSERT INTO draanks.bitters (id, name) VALUES (5, 'Peychaud''s Bitters');
INSERT INTO draanks.bitters (id, name) VALUES (18, 'Countreau');
INSERT INTO draanks.bitters (id, name) VALUES (19, 'Gin');
INSERT INTO draanks.bitters (id, name) VALUES (20, 'Egg Whites');
INSERT INTO draanks.bitters (id, name) VALUES (21, 'Egg White');
INSERT INTO draanks.bitters (id, name) VALUES (22, 'Pink Grapefruit Juice');
INSERT INTO draanks.bitters (id, name) VALUES (24, 'Clove');
INSERT INTO draanks.bitters (id, name) VALUES (25, 'Lemon Peel');
INSERT INTO draanks.bitters (id, name) VALUES (26, 'Brandy');
INSERT INTO draanks.bitters (id, name) VALUES (27, 'Hot Water');
INSERT INTO draanks.bitters (id, name) VALUES (28, 'Maraschino Liqueur');
INSERT INTO draanks.bitters (id, name) VALUES (29, 'Lime Juice');
INSERT INTO draanks.bitters (id, name) VALUES (45, 'Bada Bing Cherry');
INSERT INTO draanks.bitters (id, name) VALUES (30, 'Liquor 43');
INSERT INTO draanks.bitters (id, name) VALUES (31, 'Pear Whiskey');
INSERT INTO draanks.bitters (id, name) VALUES (32, 'Chai Syrup');
INSERT INTO draanks.bitters (id, name) VALUES (33, 'Grapefruit Bitters');
INSERT INTO draanks.bitters (id, name) VALUES (34, 'Cherry Heering');
INSERT INTO draanks.bitters (id, name) VALUES (35, 'Chocolate Bitters');
INSERT INTO draanks.bitters (id, name) VALUES (46, 'Ramazzotti');
INSERT INTO draanks.bitters (id, name) VALUES (36, 'Grenadine');
INSERT INTO draanks.bitters (id, name) VALUES (37, 'Orange Juice');
INSERT INTO draanks.bitters (id, name) VALUES (38, 'Dry Vermouth');
INSERT INTO draanks.bitters (id, name) VALUES (47, 'Campari');
INSERT INTO draanks.bitters (id, name) VALUES (39, 'Blood Orange Juice');
INSERT INTO draanks.bitters (id, name) VALUES (40, 'Simple Syrup');
INSERT INTO draanks.bitters (id, name) VALUES (41, 'Sugar');
INSERT INTO draanks.bitters (id, name) VALUES (48, 'Orange Bitters');
INSERT INTO draanks.bitters (id, name) VALUES (42, 'Bourbon');
INSERT INTO draanks.bitters (id, name) VALUES (43, 'Averna Amaro');
INSERT INTO draanks.bitters (id, name) VALUES (44, 'Old Forester Bourbon');
INSERT INTO draanks.bitters (id, name) VALUES (64, 'Ancho Reyes Ancho Chili Liquor');
INSERT INTO draanks.bitters (id, name) VALUES (49, 'Amaro Nonino');
INSERT INTO draanks.bitters (id, name) VALUES (50, 'Carpano Antica');
INSERT INTO draanks.bitters (id, name) VALUES (51, 'Aperol');
INSERT INTO draanks.bitters (id, name) VALUES (52, 'Punt e Mes');
INSERT INTO draanks.bitters (id, name) VALUES (53, 'Cocchi Americano');
INSERT INTO draanks.bitters (id, name) VALUES (54, 'Lillet Blanc');
INSERT INTO draanks.bitters (id, name) VALUES (55, 'Bonal');
INSERT INTO draanks.bitters (id, name) VALUES (56, 'Orange Twist Garnish');
INSERT INTO draanks.bitters (id, name) VALUES (57, 'Grapefruit Twist Garnish');
INSERT INTO draanks.bitters (id, name) VALUES (58, 'Lemon Twist Garnish');
INSERT INTO draanks.bitters (id, name) VALUES (65, 'Orchard Apricot Liquor');
INSERT INTO draanks.bitters (id, name) VALUES (23, 'Orange Curaçao');
INSERT INTO draanks.bitters (id, name) VALUES (59, 'Benedictine');
INSERT INTO draanks.bitters (id, name) VALUES (60, 'Cognac');
INSERT INTO draanks.bitters (id, name) VALUES (61, 'Cardamaro');
INSERT INTO draanks.bitters (id, name) VALUES (63, 'Whiskey');
INSERT INTO draanks.bitters (id, name) VALUES (66, 'Pernod');
INSERT INTO draanks.bitters (id, name) VALUES (67, 'Cocchi Rosa');
INSERT INTO draanks.bitters (id, name) VALUES (68, 'Hardshore Gin');
INSERT INTO draanks.bitters (id, name) VALUES (69, 'Luxardo Bitter Bianco');
INSERT INTO draanks.bitters (id, name) VALUES (70, 'Doulin White Vermouth');


--
-- TOC entry 2386 (class 0 OID 42895)
-- Dependencies: 211
-- Data for Name: category; Type: TABLE DATA; Schema: draanks; Owner: postgres
--

INSERT INTO draanks.category (id, name) VALUES (1, 'Bourbon');
INSERT INTO draanks.category (id, name) VALUES (2, 'Gin');
INSERT INTO draanks.category (id, name) VALUES (3, 'Vodka');
INSERT INTO draanks.category (id, name) VALUES (4, 'Rum');
INSERT INTO draanks.category (id, name) VALUES (5, 'Whiskey');
INSERT INTO draanks.category (id, name) VALUES (6, 'Rye');
INSERT INTO draanks.category (id, name) VALUES (7, 'Brandy');
INSERT INTO draanks.category (id, name) VALUES (8, 'Negroni');
INSERT INTO draanks.category (id, name) VALUES (9, 'Manhattan');
INSERT INTO draanks.category (id, name) VALUES (10, 'Sour');
INSERT INTO draanks.category (id, name) VALUES (11, 'Classic');
INSERT INTO draanks.category (id, name) VALUES (94, 'Punch');
INSERT INTO draanks.category (id, name) VALUES (12, 'Highball');
INSERT INTO draanks.category (id, name) VALUES (109, 'Scotch');
INSERT INTO draanks.category (id, name) VALUES (110, 'Mezcal');


--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 220
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: draanks; Owner: postgres
--

SELECT pg_catalog.setval('draanks.category_id_seq', 110, true);


--
-- TOC entry 2387 (class 0 OID 42904)
-- Dependencies: 212
-- Data for Name: ingredient; Type: TABLE DATA; Schema: draanks; Owner: postgres
--

INSERT INTO draanks.ingredient (id, name) VALUES (1, 'Pendelton Whiskey');
INSERT INTO draanks.ingredient (id, name) VALUES (2, 'Sweet Vermouth');
INSERT INTO draanks.ingredient (id, name) VALUES (3, 'Whiskey Bitters');
INSERT INTO draanks.ingredient (id, name) VALUES (4, 'Angostura Bitters');
INSERT INTO draanks.ingredient (id, name) VALUES (6, 'Bada Bing Cherries');
INSERT INTO draanks.ingredient (id, name) VALUES (7, 'Applejack');
INSERT INTO draanks.ingredient (id, name) VALUES (8, 'Rye Whiskey');
INSERT INTO draanks.ingredient (id, name) VALUES (9, 'Islay Scotch');
INSERT INTO draanks.ingredient (id, name) VALUES (10, 'Yellow Chartreuse');
INSERT INTO draanks.ingredient (id, name) VALUES (11, 'B&B');
INSERT INTO draanks.ingredient (id, name) VALUES (12, 'Lemon Juice');
INSERT INTO draanks.ingredient (id, name) VALUES (13, 'St. Germain');
INSERT INTO draanks.ingredient (id, name) VALUES (14, 'Grapefruit Juice');
INSERT INTO draanks.ingredient (id, name) VALUES (15, 'Jalapeño Syrup');
INSERT INTO draanks.ingredient (id, name) VALUES (16, 'Vodka');
INSERT INTO draanks.ingredient (id, name) VALUES (17, 'Bada Bing Cherry Juice');
INSERT INTO draanks.ingredient (id, name) VALUES (5, 'Peychaud''s Bitters');
INSERT INTO draanks.ingredient (id, name) VALUES (18, 'Countreau');
INSERT INTO draanks.ingredient (id, name) VALUES (19, 'Gin');
INSERT INTO draanks.ingredient (id, name) VALUES (20, 'Egg Whites');
INSERT INTO draanks.ingredient (id, name) VALUES (21, 'Egg White');
INSERT INTO draanks.ingredient (id, name) VALUES (22, 'Pink Grapefruit Juice');
INSERT INTO draanks.ingredient (id, name) VALUES (24, 'Clove');
INSERT INTO draanks.ingredient (id, name) VALUES (25, 'Lemon Peel');
INSERT INTO draanks.ingredient (id, name) VALUES (26, 'Brandy');
INSERT INTO draanks.ingredient (id, name) VALUES (27, 'Hot Water');
INSERT INTO draanks.ingredient (id, name) VALUES (28, 'Maraschino Liqueur');
INSERT INTO draanks.ingredient (id, name) VALUES (29, 'Lime Juice');
INSERT INTO draanks.ingredient (id, name) VALUES (45, 'Bada Bing Cherry');
INSERT INTO draanks.ingredient (id, name) VALUES (30, 'Liquor 43');
INSERT INTO draanks.ingredient (id, name) VALUES (31, 'Pear Whiskey');
INSERT INTO draanks.ingredient (id, name) VALUES (32, 'Chai Syrup');
INSERT INTO draanks.ingredient (id, name) VALUES (33, 'Grapefruit Bitters');
INSERT INTO draanks.ingredient (id, name) VALUES (34, 'Cherry Heering');
INSERT INTO draanks.ingredient (id, name) VALUES (35, 'Chocolate Bitters');
INSERT INTO draanks.ingredient (id, name) VALUES (46, 'Ramazzotti');
INSERT INTO draanks.ingredient (id, name) VALUES (36, 'Grenadine');
INSERT INTO draanks.ingredient (id, name) VALUES (37, 'Orange Juice');
INSERT INTO draanks.ingredient (id, name) VALUES (38, 'Dry Vermouth');
INSERT INTO draanks.ingredient (id, name) VALUES (47, 'Campari');
INSERT INTO draanks.ingredient (id, name) VALUES (39, 'Blood Orange Juice');
INSERT INTO draanks.ingredient (id, name) VALUES (40, 'Simple Syrup');
INSERT INTO draanks.ingredient (id, name) VALUES (41, 'Sugar');
INSERT INTO draanks.ingredient (id, name) VALUES (48, 'Orange Bitters');
INSERT INTO draanks.ingredient (id, name) VALUES (42, 'Bourbon');
INSERT INTO draanks.ingredient (id, name) VALUES (43, 'Averna Amaro');
INSERT INTO draanks.ingredient (id, name) VALUES (44, 'Old Forester Bourbon');
INSERT INTO draanks.ingredient (id, name) VALUES (49, 'Amaro Nonino');
INSERT INTO draanks.ingredient (id, name) VALUES (50, 'Carpano Antica');
INSERT INTO draanks.ingredient (id, name) VALUES (51, 'Aperol');
INSERT INTO draanks.ingredient (id, name) VALUES (52, 'Punt e Mes');
INSERT INTO draanks.ingredient (id, name) VALUES (53, 'Cocchi Americano');
INSERT INTO draanks.ingredient (id, name) VALUES (54, 'Lillet Blanc');
INSERT INTO draanks.ingredient (id, name) VALUES (55, 'Bonal');
INSERT INTO draanks.ingredient (id, name) VALUES (56, 'Orange Twist Garnish');
INSERT INTO draanks.ingredient (id, name) VALUES (57, 'Grapefruit Twist Garnish');
INSERT INTO draanks.ingredient (id, name) VALUES (58, 'Lemon Twist Garnish');
INSERT INTO draanks.ingredient (id, name) VALUES (65, 'Orchard Apricot Liquor');
INSERT INTO draanks.ingredient (id, name) VALUES (23, 'Orange Curaçao');
INSERT INTO draanks.ingredient (id, name) VALUES (64, 'Ancho Reyes Chili Liquor');
INSERT INTO draanks.ingredient (id, name) VALUES (66, 'Pernod');
INSERT INTO draanks.ingredient (id, name) VALUES (59, 'Benedictine');
INSERT INTO draanks.ingredient (id, name) VALUES (60, 'Cognac');
INSERT INTO draanks.ingredient (id, name) VALUES (62, 'Old Tom Gin');
INSERT INTO draanks.ingredient (id, name) VALUES (67, 'Cocchi Rosa');
INSERT INTO draanks.ingredient (id, name) VALUES (61, 'Cardamaro');
INSERT INTO draanks.ingredient (id, name) VALUES (63, 'Whiskey');
INSERT INTO draanks.ingredient (id, name) VALUES (68, 'Hardshore Gin');
INSERT INTO draanks.ingredient (id, name) VALUES (69, 'Luxardo Bitter Bianco');
INSERT INTO draanks.ingredient (id, name) VALUES (70, 'Doulin White Vermouth');
INSERT INTO draanks.ingredient (id, name) VALUES (99, 'Cranberry Juice');
INSERT INTO draanks.ingredient (id, name) VALUES (100, 'Apple Juice');
INSERT INTO draanks.ingredient (id, name) VALUES (101, 'Pomegranate Juice');
INSERT INTO draanks.ingredient (id, name) VALUES (102, 'Cardamom Bitters');
INSERT INTO draanks.ingredient (id, name) VALUES (103, 'Falernun');
INSERT INTO draanks.ingredient (id, name) VALUES (104, 'Coconut Water');
INSERT INTO draanks.ingredient (id, name) VALUES (105, 'Scotch');
INSERT INTO draanks.ingredient (id, name) VALUES (106, 'Mezcal');


--
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 222
-- Name: ingredient_id_seq; Type: SEQUENCE SET; Schema: draanks; Owner: postgres
--

SELECT pg_catalog.setval('draanks.ingredient_id_seq', 109, true);


--
-- TOC entry 2388 (class 0 OID 42913)
-- Dependencies: 213
-- Data for Name: measure; Type: TABLE DATA; Schema: draanks; Owner: postgres
--

INSERT INTO draanks.measure (id, name, plural) VALUES (2, 'dashes', true);
INSERT INTO draanks.measure (id, name, plural) VALUES (6, 'ounces', true);
INSERT INTO draanks.measure (id, name, plural) VALUES (10, 'cups', true);
INSERT INTO draanks.measure (id, name, plural) VALUES (11, 'strips', true);
INSERT INTO draanks.measure (id, name, plural) VALUES (1, 'ounce', false);
INSERT INTO draanks.measure (id, name, plural) VALUES (3, 'dash', false);
INSERT INTO draanks.measure (id, name, plural) VALUES (4, 'TB', false);
INSERT INTO draanks.measure (id, name, plural) VALUES (7, ' ', false);
INSERT INTO draanks.measure (id, name, plural) VALUES (8, 'strip', false);
INSERT INTO draanks.measure (id, name, plural) VALUES (9, 'cup', false);
INSERT INTO draanks.measure (id, name, plural) VALUES (5, 'Tsp', false);
INSERT INTO draanks.measure (id, name, plural) VALUES (13, 'Tsp', true);


--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 221
-- Name: measure_id_seq; Type: SEQUENCE SET; Schema: draanks; Owner: postgres
--

SELECT pg_catalog.setval('draanks.measure_id_seq', 63, false);


--
-- TOC entry 2389 (class 0 OID 42922)
-- Dependencies: 214
-- Data for Name: members; Type: TABLE DATA; Schema: draanks; Owner: postgres
--

INSERT INTO draanks.members (id, name_first, name_last, name_business, occupation, email, phone_main, phone_secondary, member_since, active, comments, onlineid, password, pword_type, member_type) VALUES (2, 'Barbara', 'Dieringer', NULL, NULL, 'goodrubu@gmail.com', '5039395800', NULL, '2017-01-23', true, NULL, 'barb', 'barb', 0, 0);
INSERT INTO draanks.members (id, name_first, name_last, name_business, occupation, email, phone_main, phone_secondary, member_since, active, comments, onlineid, password, pword_type, member_type) VALUES (1, 'Al', 'Dynak', ' ', ' ', 'adynak@gmail.com', '4077569728', NULL, '2017-01-23', true, ' ', 'adynak', 'adynak', 0, 1);
INSERT INTO draanks.members (id, name_first, name_last, name_business, occupation, email, phone_main, phone_secondary, member_since, active, comments, onlineid, password, pword_type, member_type) VALUES (3, 'Thirsty', 'Soul', NULL, NULL, 'guest', NULL, NULL, '2017-09-18', true, NULL, 'guest', 'guest', 0, 0);


--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 223
-- Name: members_id_seq; Type: SEQUENCE SET; Schema: draanks; Owner: postgres
--

SELECT pg_catalog.setval('draanks.members_id_seq', 4, true);


--
-- TOC entry 2390 (class 0 OID 42933)
-- Dependencies: 215
-- Data for Name: recipe; Type: TABLE DATA; Schema: draanks; Owner: postgres
--

INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Pendelton Manhattan', NULL, 2, 2, '<ol><li>Place all of the ingredients,except for the cherry, into a cocktail shaker filled with ice. </li>
    <li>Vigorously shake the mixture for 35 seconds and then double strain into a cocktail glass. </li>
    <li>Garnish the drink with a Bada Bing cherry and then serve immediately.</li></ol>', 4, 9);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Pepper Blossom', NULL, 2, 3, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously shake the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Serve immediately.</li></ol>', 12, 3);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Whiskey Kiss', NULL, 1, 5, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously stir the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Serve immediately.</li></ol>', 3, 1);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Smokey Manhattan', NULL, 2, 6, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously stir the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Serve immediately.</li></ol>', 5, 9);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('White Lady', NULL, 1, 7, '<ol><li>Shake well with cracked ice. </li><li>Strain into a cocktail glass. </li><li>Serve immediately.</li></ol>', 12, 2);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Grapefruit Cocktail', NULL, 2, 8, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously shake the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Garnish the drink with a slice of apple and then serve immediately.</li></ol>', 12, 3);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Hot Toddy', NULL, 1, 9, '<ol><li>Put the clove and lemon strip in an Irish Coffee glass</li><li>Add the Brandy.</li><li>Top off the glass with hot water.</li></ol>
', 25, 7);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Dancing Pear', NULL, 1, 11, '<ol><li>Vigorously shake all ingredients together with ice. </li><li>Strain into a martini glass.</li></ol>', 14, 5);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Problem Solver', NULL, 1, 12, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously stir the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Serve immediately.</li></ol>', 11, 6);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('More Over', NULL, 1, 13, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously stir the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Serve immediately.</li></ol>', 35, 2);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Ward 8', NULL, 1, 14, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously stir the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Serve immediately.</li></ol>', 12, 6);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Barb''s Blood', NULL, 2, 15, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously stir the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Serve immediately.</li></ol>', 12, 6);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Orange Bourbon Sour', NULL, 4, 16, '<ol><li>Combine the juices, sugar and bourbon.</li><li>Stir or shake until the sugar is completely dissolved. </li><li>Pour the drink over chipped ice. </li><li>Garnish with an orange slice.</li></ol>', 12, 1);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Black Manhattan', NULL, 1, 17, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously shake the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Garnish the drink with the cherry and then serve immediately.</li></ol>', 4, 9);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Negroni', NULL, 1, 18, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 47, 8);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Brooklyn', NULL, 1, 19, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 48, 6);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Negronino', NULL, 2, 29, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 49, 8);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Maximo de Negroni', NULL, 1, 30, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 49, 8);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('White Negroni', NULL, 1, 31, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 53, 8);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Holland Negroni', NULL, 1, 33, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 51, 8);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Embittered Negroni', NULL, 1, 34, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 14, 8);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Bitter Manhattan', NULL, 1, 35, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 35, 9);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Forquilha Negroni', NULL, 1, 36, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 4, 8);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Vieux Carré', NULL, 1, 37, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 59, 6);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Holy Smokes', NULL, 1, 38, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 35, 5);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Daaaam Son', NULL, 1, 39, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 53, 6);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Off The Beaten Path', NULL, 1, 50, NULL, 47, 2);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Red Velvet', NULL, 1, 53, NULL, 42, 1);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Paper Plane', NULL, 1, 55, NULL, 49, 1);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('All Betts Are Off', NULL, 1, 57, NULL, 106, 110);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Gotham', NULL, 1, 58, NULL, 16, 3);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Autumn Manhattan', NULL, 1, 1, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously shake the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Garnish the drink with a slice of apple and then serve immediately.</li></ol>', 5, 9);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Last Word', NULL, 1, 10, '<ol><li>Vigorously shake all ingredients together with ice. </li><li>Strain into a martini glass.</li><li>Garnish with lime twist.</li></ol>', 29, 10);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Beginner''s Negroni', NULL, 1, 32, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 51, 8);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Boulevardier', NULL, 1, 40, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 47, 1);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Walla Walla Mark', NULL, 1, 41, '<ol><li>Place all of the ingredients into a cocktail shaker with some ice. </li><li>Vigorously stir the mixture for 19 seconds and then strain into a cocktail glass. </li><li>Garnish the drink and serve immediately.</li></ol>', 66, 6);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Drake By The Lake', NULL, 1, 42, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously shake the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Garnish the drink with a slice of apple and then serve immediately.</li></ol>', 4, 2);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Gin & Company', NULL, 1, 43, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously shake the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Garnish the drink with a slice of apple and then serve immediately.</li></ol>', 69, 2);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Negroni Bianco', NULL, 1, 44, '<ol><li>Place all of the ingredients into a cocktail shaker filled with ice. </li><li>Vigorously shake the mixture for 35 seconds and then strain into a cocktail glass. </li><li>Garnish the drink with a slice of apple and then serve immediately.</li></ol>', 69, 8);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Old Fashioned', NULL, 3, 45, NULL, 4, 11);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Old Pal', NULL, 1, 46, NULL, 47, 1);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('The Reanimator', NULL, 1, 54, NULL, 49, 6);
INSERT INTO draanks.recipe (name, description, portions, id, instructions, bittersid, categoryid) VALUES ('Bobby Burns', NULL, 1, 56, NULL, 105, 109);


--
-- TOC entry 2391 (class 0 OID 42942)
-- Dependencies: 216
-- Data for Name: recipeingredient; Type: TABLE DATA; Schema: draanks; Owner: postgres
--

INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (2, 1, 7, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (3, 1, 2, '1', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (4, 1, 5, '1', 3, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (5, 2, 1, '7', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (8, 2, 6, '4', 7, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (7, 2, 4, '4', 2, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (1, 1, 8, '2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (9, 2, 17, '1/2', 5, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (10, 3, 16, '2 1/2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (11, 3, 13, '2 1/2', 6, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (12, 3, 12, '1 1/2', 6, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (13, 3, 14, '1', 1, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (14, 3, 15, '1', 1, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (6, 2, 2, '3', 6, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (16, 5, 11, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (15, 5, 1, '2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (17, 5, 10, '1/2', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (18, 5, 3, '2', 2, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (19, 5, 12, '1/8', 5, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (20, 6, 8, '4', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (21, 6, 2, '2', 6, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (23, 6, 5, '2', 2, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (22, 6, 9, '1', 4, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (24, 7, 19, '2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (25, 7, 18, '1/2', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (36, 10, 19, '3/4', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (26, 7, 21, '1', 7, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (37, 10, 10, '3/4', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (38, 10, 28, '3/4', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (27, 7, 12, '1/2', 1, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (28, 8, 22, '3 1/2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (39, 10, 29, '3/4', 1, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (29, 8, 12, '1/2', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (30, 8, 23, '1/2', 1, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (132, 39, 8, '1 1/2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (40, 11, 31, '1 1/2', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (31, 8, 16, '2', 6, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (41, 11, 30, '1/2', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (42, 11, 12, '1', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (43, 11, 32, '1/2', 1, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (44, 11, 33, '2', 2, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (133, 39, 53, '3/4', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (45, 13, 19, '1 1/2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (46, 13, 38, '1/2', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (134, 39, 64, '1/2', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (32, 9, 24, '1', 7, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (33, 9, 25, '1', 8, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (34, 9, 26, '2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (35, 9, 27, '3', 6, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (135, 39, 65, '1', 5, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (47, 13, 2, '1/4', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (136, 39, 23, '1', 5, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (137, 40, 42, '1', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (138, 40, 50, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (57, 15, 8, '3', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (58, 15, 12, '2', 4, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (48, 13, 34, '1/4', 1, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (59, 15, 39, '2', 6, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (139, 40, 47, '1', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (77, 19, 28, '1/2', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (78, 29, 19, '2 1/2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (49, 13, 35, '1', 3, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (60, 15, 37, '4', 6, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (79, 29, 49, '2', 6, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (80, 29, 50, '2 1/2', 6, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (81, 29, 47, '1', 1, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (50, 14, 8, '2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (140, 41, 8, '2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (141, 41, 61, '1/2', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (61, 15, 40, '1', 1, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (142, 41, 50, '1/2', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (51, 14, 12, '3/4', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (143, 41, 66, '1/2', 5, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (82, 30, 19, '1', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (116, 37, 59, '1', 5, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (117, 37, 4, '2', 2, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (144, 41, 4, '2', 2, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (52, 14, 37, '3/4', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (62, 16, 37, '2', 10, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (118, 37, 5, '2', 2, 6);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (145, 41, 5, '1', 2, 6);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (83, 30, 52, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (53, 14, 36, '1', 5, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (147, 42, 62, '1', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (148, 42, 52, '2', 6, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (63, 16, 12, '1/2', 9, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (149, 42, 28, '1/2', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (150, 42, 4, '2', 2, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (54, 12, 8, '2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (151, 42, 56, '1', 7, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (84, 30, 49, '1', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (152, 43, 67, '2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (153, 43, 68, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (55, 12, 34, '1/2', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (64, 16, 41, '1/4', 9, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (154, 43, 69, '1', 5, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (156, 44, 69, '1 1/2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (56, 12, 11, '1/4', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (157, 44, 70, '3/4', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (158, 44, 19, '1 1/2', 6, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (65, 16, 42, '1/2', 9, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (85, 30, 56, '1', 7, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (86, 29, 57, '1', 7, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (87, 31, 19, '1 1/2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (88, 31, 38, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (66, 17, 44, '2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (67, 17, 43, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (68, 17, 4, '1', 3, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (69, 17, 45, '1', 7, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (89, 31, 53, '1/2', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (90, 31, 58, '1', 7, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (70, 18, 47, '1', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (71, 18, 19, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (72, 18, 2, '1', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (73, 19, 8, '2', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (91, 32, 19, '1', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (92, 32, 54, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (93, 32, 51, '1', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (127, 38, 63, '1 1/2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (74, 19, 38, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (94, 32, 57, '1', 7, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (95, 33, 19, '1', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (96, 33, 51, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (97, 33, 2, '1', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (75, 19, 46, '1/2', 1, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (98, 33, 58, '1', 7, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (99, 34, 19, '2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (100, 34, 47, '3/4', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (101, 34, 50, '3/4', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (128, 38, 61, '1/2', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (76, 19, 48, '6', 2, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (102, 34, 14, '6', 2, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (103, 34, 56, '1', 7, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (104, 35, 8, '2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (105, 35, 50, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (129, 38, 59, '1/2', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (106, 35, 4, '3', 2, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (107, 35, 35, '2', 2, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (108, 36, 19, '1 1/4', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (109, 36, 47, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (110, 36, 50, '1', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (111, 36, 4, '2', 2, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (112, 36, 56, '1', 7, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (113, 37, 1, '1', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (114, 37, 2, '1', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (115, 37, 60, '1', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (130, 38, 35, '2', 2, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (131, 38, 9, '1', 5, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (160, 45, 41, '1', 5, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (161, 45, 42, '2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (162, 45, 4, '3', 2, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (163, 46, 42, '1 1/2', 6, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (164, 46, 38, '3/4', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (165, 46, 47, '3/4', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (166, 46, 58, '1', 7, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (167, 47, 16, '2', 6, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (168, 48, 42, '1', 1, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (169, 48, 4, '1', 3, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (170, 48, 11, '2', 6, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (171, 49, 19, '1 1/2', 6, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (172, 49, 52, '1/2', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (173, 49, 47, '3/4', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (174, 49, 38, '1/4', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (175, 49, 48, '1', 3, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (176, 50, 19, '1 1/2', 6, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (177, 50, 47, '3/4', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (178, 50, 52, '1/2', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (179, 50, 38, '1/4', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (180, 50, 102, '1', 3, 4);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (181, 50, 48, '1', 3, 5);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (182, 51, 49, '1', 3, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (183, 52, 64, '1', 1, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (184, 53, 42, '1', 1, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (185, 53, 103, '1/4', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (186, 53, 104, '2', 6, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (187, 53, 5, '5', 2, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (188, 54, 49, '1 1/2', 6, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (189, 54, 8, '1 1/2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (190, 54, 25, '1', 8, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (191, 55, 49, '3/4', 1, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (192, 55, 51, '3/4', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (193, 55, 42, '3/4', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (194, 55, 12, '3/4', 1, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (195, 56, 105, '1', 1, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (196, 56, 2, '1', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (197, 56, 59, '1/2', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (198, 57, 106, '1 1/2', 6, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (199, 57, 70, '3/4', 1, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (200, 57, 10, '3/4', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (201, 57, 33, '2', 2, 3);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (202, 58, 16, '1 1/2', 6, 0);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (203, 58, 67, '1 1/2', 6, 1);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (204, 58, 46, '1/4', 1, 2);
INSERT INTO draanks.recipeingredient (id, recipeid, ingredientid, quantity, measureid, sequence) VALUES (205, 58, 48, '2', 2, 3);


--
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 218
-- Name: recipeingredient_id_seq; Type: SEQUENCE SET; Schema: draanks; Owner: postgres
--

SELECT pg_catalog.setval('draanks.recipeingredient_id_seq', 158, true);


--
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 217
-- Name: recipes_id_seq; Type: SEQUENCE SET; Schema: draanks; Owner: postgres
--

SELECT pg_catalog.setval('draanks.recipes_id_seq', 58, true);


-- Completed on 2017-12-05 16:19:02 PST

--
-- PostgreSQL database dump complete
--
