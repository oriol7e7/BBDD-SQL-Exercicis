/*
CREACIO BBDD I USUARI VIDEOCLUB
*/

--Crear base de dades videoclub
CREATE DATABASE videoclub;

--Crear usuari videoclub i permisos
CREATE USER videoclub WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'videoclub';
ALTER DATABASE videoclub OWNER TO videoclub;
GRANT ALL PRIVILEGES ON DATABASE videoclub TO videoclub;

--Sortir del client
\q

--Connectarse a la base de dades videoclub amb el seu usuari
psql -U videoclub -W -d videoclub


/*
Exercici 1 (3 punts). RA2
Escriu les sentències necessàries per crear les taules «actor», «director» i «movie» . Posa la descripció
del camp com un comentari de camp de la taula i decideix tu els comentaris de la taula.
Consideracions que has de tenir en compte alhora de crear les taules:
*/

CREATE TABLE IF NOT EXISTS actor (
    act_id VARCHAR(10) NOT NULL,
    act_fname VARCHAR(30),
    act_lname VARCHAR(30),
    act_gender VARCHAR(1),
    CONSTRAINT pk_actor PRIMARY KEY (act_id),
    CONSTRAINT ck_act_gender CHECK (act_gender IN ('D', 'H'))
);


CREATE TABLE IF NOT EXISTS director (
    dir_id VARCHAR(10) NOT NULL,
    dir_fname VARCHAR(20),
    dir_lname VARCHAR(20),
    CONSTRAINT pk_director PRIMARY KEY (dir_id)
);


CREATE TABLE IF NOT EXISTS movie (
    mov_id NUMERIC(10) NOT NULL,
    mov_title VARCHAR(60) NOT NULL,
    mov_year NUMERIC(10),
    mov_time NUMERIC(10) NOT NULL DEFAULT 90,
    mov_lang VARCHAR(20) NOT NULL,
    mov_dt_rel DATE NOT NULL,
    mov_rel_country VARCHAR(10) NOT NULL,
    CONSTRAINT pk_movie PRIMARY KEY (mov_id),
    CONSTRAINT uq_title UNIQUE (mov_title),
    CONSTRAINT ck_lang CHECK (mov_lang = UPPER(mov_lang)),
    CONSTRAINT ck_rel_country CHECK (mov_rel_country = UPPER(mov_rel_country))
);


/*
Exercici 2 (1,5 punts). RA2
Un cop creades les taules, ens hem adonat que hi ha errors en les taules «movie» i «director» i hem
de modificar un quants camps. Escriu el codi per realitzar aquests canvis. Les dades correctes són:
*/

ALTER TABLE movie ALTER COLUMN mov_time TYPE NUMERIC(4);
ALTER TABLE movie ADD CONSTRAINT ck_time CHECK (mov_time <= 300);
ALTER TABLE movie ALTER COLUMN mov_lang TYPE VARCHAR(40);
ALTER TABLE director ALTER COLUMN dir_fname TYPE VARCHAR(35);
ALTER TABLE director ADD CONSTRAINT ck_dir_fname CHECK (dir_fname = LOWER(dir_fname));
ALTER TABLE director ALTER COLUMN dir_fname VARCHAR(35) NOT NULL;


/*
Exercici 3 ( 1,5 punts). RA4
Carrega les següents dades a les taules corresponents. Si hi ha alguna fila que no es pot inserir perquè
dona un error, explica l’error que dona, i canvia el valor que dona error per poder inserir la fila. Escriu
les sentències per comprovar si les dades estan ben introduïdes. Les dades són les següents:
*/

--Taula actor
INSERT INTO actor (act_id, act_fname, act_lname, act_gender) VALUES
(101, 'James', 'Stewart', 'H');
INSERT INTO actor (act_id, act_fname, act_lname, act_gender) VALUES
(102, 'Deborah', 'Kerr', 'M'); 
--Error, ja que viola la restriccio del camp gender que només pot ser H o D
--Solucio:
INSERT INTO actor (act_id, act_fname, act_lname, act_gender) VALUES
(102, 'Deborah', 'Kerr', 'D'); 

INSERT INTO actor (act_id, act_fname, act_lname, act_gender) VALUES
(103, 'Peter', 'O Toole', 'H');
INSERT INTO actor (act_id, act_fname, act_lname, act_gender) VALUES
(104, 'Robert', 'De Niro', 'H');
INSERT INTO actor (act_id, act_fname, act_lname, act_gender) VALUES
(105, 'F.Murray', 'Abraham', 'H');

--Taula director
INSERT INTO director (dir_id, dir_fname, dir_lname) VALUES
(201, 'Alfred', 'Hitchcock');
--Error ja que viola la restriccio del camp fname ja que ha de ser en minuscula
--Solucio: 
INSERT INTO director (dir_id, dir_fname, dir_lname) VALUES
(201, 'alfred', 'Hitchcock');

INSERT INTO director (dir_id, dir_fname, dir_lname) VALUES
(202, 'jack', 'Clayton');
INSERT INTO director (dir_id, dir_fname, dir_lname) VALUES
(203, 'david', 'Lean');
INSERT INTO director (dir_id, dir_fname, dir_lname) VALUES
(204, 'michael', 'Cimino');

/*
Exercici 4 (0,5 punts). RA4
Crea una seqüència anomenada seq_mov_id perquè el mov_id de la taula "movie" es pugui
autoincrementar. Que comenci per 610, que incrementi 10 i el valor màxim sigui 999999.
*/

CREATE SEQUENCE seq_id_mov
INCREMENT 10
START WITH 610
MAXVALUE 999999;

/*
Exercici 5 (1,5 punts). RA4
Introdueix les dades següents a la taula "movie", utilitzant la seqüència que has creat en l’anterior
exercici. Si hi ha alguna fila que no es pot insertar perquè dona un error, explica l’error que dona, i no
insereixis la fila. Les dades són les següents:
*/

/*
*tinc la data configurada en format YMD -> any mes dia
*/
INSERT INTO movie (mov_id, mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country) VALUES
(NEXTVAL('seq_id_mov'), 'Vertigo', 1958, 128, 'ENGLISH', '1958/08/24', 'UK');
INSERT INTO movie (mov_id, mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country) VALUES
(NEXTVAL('seq_id_mov'), 'The Innocents', 1961, DEFAULT, 'ENGLISH', '1962/02/19', 'SW');
INSERT INTO movie (mov_id, mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country) VALUES
(NEXTVAL('seq_id_mov'), 'Lawrence of Arabia', 1962, 216, 'ENGLISH', '1962/12/11', 'Uk');
--Error ja que viola la restriccio de majuscules de mov_rel_country (ha de ser majuscules)

INSERT INTO movie (mov_id, mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country) VALUES
(NEXTVAL('seq_id_mov'), 'The Deer Hunter' , NULL, 183, 'ENGLISH', '03/08/1979', 'UK');
--Dona error ja que la data no esta en el format que tinc configurat (es pot cambiar amb SET datestyle to european;)

INSERT INTO movie (mov_id, mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country) VALUES
(NEXTVAL('seq_id_mov'), 'Amadeus' , 1984, 320, 'ENGLISH', '1985/07/01', 'UK');
--Dona error ja que es viola la restriccio del mov_time, que ha de ser com a màxim 300 i és 320


/*
Exercici 6 (3 punts). RA2
Escriu les sentències necessàries per crear les taules «movie_direction» i «movie_cast» amb les
seves corresponents restriccions. Aquestes restriccions han de tenir un nom. No has d’afegir cap opció
d’eliminació a la clau forana. Posa la descripció del camp com un comentari de la taula.
Si durant la creació d’alguna taula dona error, indica quin és el problema i planteja una solució.
*/

CREATE TABLE movie_director(
    dir_id_dir NUMERIC(10),
    mov_id_dir NUMERIC(5),
    CONSTRAINT pk_movdir PRIMARY KEY (dir_id_dir, mov_id_dir),
    CONSTRAINT fk_movdir_director FOREIGN KEY (dir_id_dir) REFERENCES director(dir_id),
    CONSTRAINT fk_movdir_movie FOREIGN KEY (mov_id_dir) REFERENCES movie(movie_id)
);

--Dona l'error que dir_id_dir i el camp al que va referencia (director(dir_id)) son de tipus diferents, s'ha de cambiar
--solucio:
CREATE TABLE movie_director(
    dir_id_dir VARCHAR(10),
    mov_id_dir NUMERIC(5),
    CONSTRAINT pk_movdir PRIMARY KEY (dir_id_dir, mov_id_dir),
    CONSTRAINT fk_movdir_director FOREIGN KEY (dir_id_dir) REFERENCES director(dir_id),
    CONSTRAINT fk_movdir_movie FOREIGN KEY (mov_id_dir) REFERENCES movie(mov_id)
);


CREATE TABLE movie_cast(
    act_id_cast VARCHAR(10),
    mov_id_cast NUMERIC(5),
    role VARCHAR(30),
    CONSTRAINT pk_movie_cast PRIMARY KEY (act_id_cast, mov_id_cast),
    CONSTRAINT fk_movcast_actor FOREIGN KEY (act_id_cast) REFERENCES actor(act_id),
    CONSTRAINT fk_movcast_movie FOREIGN KEY (mov_id_cast) REFERENCES movie(mov_id),
    CONSTRAINT ck_role CHECK (role = LOWER(role))
);

/*
Exercici 7 (1 punt). RA4
Introdueix les següents dades a les taula movie_direction. Si hi ha alguna fila que no es pot insertar perquè
dona un error, explica l’error que dona i no la insertis. Digues quina comanda has de afegir després dels inserts
per assegurar que les dades introduïdes es queden gravades i no es perdran?.
*/

--Per guardar tots els inserts s'ha de fer COMMIT
INSERT INTO movie_director (dir_id_dir, mov_id_dir) VALUES
(201, 610);
INSERT INTO movie_director (dir_id_dir, mov_id_dir) VALUES
(202, 620);
INSERT INTO movie_director (dir_id_dir, mov_id_dir) VALUES
(203, 730);
--dona error ja que no hi ha cap registre a la taula movie amb mov_id que sigue 730, per tant viola la clau forana

INSERT INTO movie_director (dir_id_dir, mov_id_dir) VALUES
(204, 640);
--dona error ja que no hi ha cap registre a la taula movie amb mov_id que sigue 640, per tant viola la clau forana

COMMIT

/*
Exercici 8 (1 punt). RA4
Introdueix les següents dades a les taula movie_cast. Si hi ha alguna fila que no es pot insertar perquè dona un
error, explica l’error que dona, i canvia el que sigui necessari de l’estructura de la taula per poder insertar la fila.
*/

INSERT INTO movie_cast (act_id_cast, mov_id_cast, role) VALUES
(101, 610, 'John Scottie Ferguson');
--Dona error ja que el camp role viola la restriccio que diu que ha de ser en minuscules


INSERT INTO movie_cast (act_id_cast, mov_id_cast, role) VALUES
(102, 620, 'miss giddens');

INSERT INTO movie_cast (act_id_cast, mov_id_cast, role) VALUES
(103, 630, 't.e. lawrenc');
--dona error ja que no hi ha cap registre a la taula movie amb mov_id que sigui 630, per tant viola la clau forana


/*
Exercici 9 (1 punt). RA2
Afegeix els següents camps a la taula «movie».
*/

ALTER TABLE movie ADD COLUMN production_budget DECIMAL(10,2) DEFAULT 2500;
ALTER TABLE movie ADD COLUMN profit DECIMAL(10,2);
ALTER TABLE movie ADD COLUMN genres VARCHAR(50);
ALTER TABLE movie ADD CONSTRAINT ck_genre CHECK (genres IN ('comedy', 'sci-fi', 'horror', 'romance', 'drama'));


/*
Exercici 10 (0,5 punts). RA2
Canvia el nom de la restricció de verificació del camp genres de la taula movie. El nou nom d’aquesta
restricció és CK_MOVIE_GENRES
*/
ALTER TABLE movie RENAME CONSTRAINT ck_genre TO CK_MOVIE_GENRES;


/*
Exercici 11 (1 punt). RA4
La taula movie actualment té el camp profit sense dades. Escriu una sentència que actualitzi el camp
profit a 300000 d’aquelles pel·lícules que han sigut realitzades els anys anteriors al 1963. Escriu la
sentència per comprovar si s’han realitzat els canvis.
*/

UPDATE MOVIE
SET profit = 300000
WHERE mov_year < 1963;

--Comprovar que s'ha canviat
SELECT profit, mov_year FROM MOVIE;

--o

SELECT profit, mov_year FROM MOVIE WHERE mov_year<1963;


/*
Exercici 12 (1 punt). RA4
Realitza les sentències pertinents
- Crea un índex únic sobre el camp «mov_id» de la taula «movie». Creus que és necessari? Raona la
teva resposta.
- Crea un índex únic sobre el camp «mov_rel_country» de la taula «movie». Si no pots crear-lo
explica perquè no es pot i crea un índex no únic.
*/

--index normal
--si que pot arribar a ser necessari per a poder agilitzar més les consultes, pero un index unic d'un altre camp podria arribar a ser més útil
CREATE INDEX index_mov_id
ON movie(mov_id);

--index unic 
CREATE UNIQUE INDEX uq_index_mov_rel_country
ON movie(mov_rel_country);


/*
Exercici 13 (1 punt). RA2
Elimina el camp production_budget de la taula movie.
*/

ALTER TABLE movie DROP COLUMN production_budget;


/*
Exercici 14 (1,5 punts). RA4
Elimina el director amb codi «201». Si no es pot eliminar explica el motiu.
*/

--(ha l'id ha d'estar entre cometes ja que es un camp de tipus varchar, sino no deixa)
DELETE FROM director WHERE dir_id = '201';
--No es pot eliminar ja que a la taula movie_director hi ha un camp que es clau forana cap a aquest i per tant viola la FK
--Si es volgués eliminar s'hauria de eliminar i tornar a crear la FK amb ON DELETE CASCADE


/*
Exercici 15 (1 punt). RA4
Elimina l’actor amb cognom «Abraham». Si no es pot eliminar explica el motiu.
*/

DELETE FROM actor WHERE act_lname = 'Abraham';