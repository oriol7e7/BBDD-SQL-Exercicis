/*Creacio base de dades bicirent*/
CREATE DATABASE bicirent;

/*
Exercici 1. (2,5 punts)
Escriu les sentències necessàries per crear les taules BICICLETA, CLIENT i LLOGUER a la base de
dades bicirent. tenint en compte les restriccions indicades. Afegeix a la base de dades un comentari a la
taula CLIENT i els comentaris dels camps només de la taual CLIENT.
*/

--Taula Client
CREATE TABLE IF NOT EXISTS CLIENT (
    idclient SERIAL NOT NULL,
    nom VARCHAR(30) NOT NULL,
    cognom1 VARCHAR(40) NOT NULL,
    cognom2 VARCHAR(40) NOT NULL,
    dni VARCHAR(10),
    telefon NUMERIC(10) ,
    email VARCHAR(35),
    CONSTRAINT PK_CLIENT PRIMARY KEY (idclient),
    CONSTRAINT UQ_DNI UNIQUE (dni),
    CONSTRAINT UQ_TELEFON UNIQUE (telefon),
    CONSTRAINT UQ_EMAIL UNIQUE (email)
);

--Taula bicicleta
CREATE TABLE IF NOT EXISTS BICICLETA (
    idbici NUMERIC(15) NOT NULL,
    marca VARCHAR(30) NOT NULL,
    model VARCHAR(30),
    preu DOUBLE PRECISION DEFAULT 250 NOT NULL,
    CONSTRAINT PK_BICICLETA PRIMARY KEY (idbici),
    CONSTRAINT CK_BICICLETA_PREU CHECK (preu>0)   
);

--Taula lloguer
CREATE TABLE IF NOT EXISTS LLOGUER (
    idlloguer NUMERIC(35) NOT NULL,
    bici NUMERIC(35) NOT NULL,
    datalloguer DATE DEFAULT CURRENT_DATE,
    dataretorn DATE,
    client INTEGER NOT NULL,
    retorn CHAR(3) NOT NULL,
    penalitzacio NUMERIC(20),
    preu NUMERIC(15) NOT NULL,
    CONSTRAINT PK_LLOGUER PRIMARY KEY (idlloguer),
    CONSTRAINT FK_LLOGUER_BICICLETA FOREIGN KEY (bici) REFERENCES BICICLETA(idbici),
    CONSTRAINT FK_LLOGUER_CLIENT FOREIGN KEY (client) REFERENCES CLIENT(idclient),
    CONSTRAINT CK_LLOGUER_PREU_MAJOR_0 CHECK (preu>0),
    CONSTRAINT CK_LLOGUER_RETORN_RANGE CHECK (retorn IN ('PEN', 'RET'))
);

/*
Exercici 2. (0,25 punts)
Comprova que les 3 taules s'han creat correctament amb la comanda que mostra la definició de
les taules amb els camps de les taules, tipus de dades, etc.
*/

\d CLIENT
\d BICICLETA
\d LLOGUER

/*
Exercici 3. (0,25 punts)
Canvia el nom de la restricció que obliga que el camp retorn de la taula LLOGUER només accepti ‘PEN’
o ‘REP’. Ara es diu ck_ret. Comprova si s’ha realitzat el canvi de nom.
*/

ALTER TABLE LLOGUER RENAME CONSTRAINT CK_LLOGUER_RETORN_RANGE TO ck_ret;

/*
Exercici 4. (0,25 punts)
Elimina la columna preu de la taula lloguer i comprova l’estructura de la taula lloguer.
*/

ALTER TABLE LLOGUER DROP COLUMN preu;
/d LLOGUER

/*
Exercici 5. (0,5 punts)
Torna a afegir la columma preu a la taula lloguer amb el tipus de dades DOUBLE PRECISION i que
sigui obligatori i comprova l’estructura de la taula lloguer.
*/

ALTER TABLE LLOGUER ADD COLUMN preu DOUBLE PRECISION NOT NULL;
/d LLOGUER

/*
Exercici 6. (0,25 punts)
Afegeix la restricció que el preu de la taula lloguer sigui més gran de zero i comprova el canvi de
l’estructura de la taula.
*/

ALTER TABLE LLOGUER ADD CONSTRAINT CK_LLOGUER_PREU_MAJOR0 CHECK (preu>0);
\d LLOGUER

/*
Exercici 7. (0,25 punts)
Afegeix una nova restricció a la taula lloguer per controlar que la data de retorn de la bicicleta ha de ser
posterior a la data del lloguer de la bicicleta i comprova el canvi de l’estructura de la taula.
*/

ALTER TABLE LLOGUER ADD CONSTRAINT CK_LLOGUER_dataretorn_MAJOR_datalloguer CHECK (dataretorn>datalloguer);
\d LLOGUER

/*
Exercici 8. (0,25 punts)
Canvia el tipus de dades del camp client de la taula lloguer. El nou tipus de dades d’aquest camp ha de ser
NUMERIC(35). Si no es pot fer el canvi explica perquè.
*/

ALTER TABLE LLOGUER ALTER COLUMN client TYPE NUMERIC(35) USING client::NUMERIC;

--No es pot ja que client es una clau foranea de la taula client i el camp idclient el qual es un serial equivalent a INTEGER i per tant no poden ser de tipus de dades diferents


/*
Exercici 9. (0,5 punts)
Insereix 5 socis a la taula client amb dades inventades. Tots els camps han de tenir un valor, i
comprova que s’han insertat correctament.
*/

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email) VALUES
('oriol', 'plazas', 'leon', 123234, 123234, 'oriol@gmail.com');

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email) VALUES
('dani', 'guillamon', 'rico', 1223234, 1223234, 'dani@gmail.com');

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email) VALUES
('gemma', 'lopez', 'garcia', 3123234, 3123234, 'gemma@gmail.com');

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email) VALUES
('iker', 'lopez', 'lopez', 3123934, 3123934, 'iker@gmail.com');

INSERT INTO CLIENT (nom, cognom1, cognom2, dni, telefon, email) VALUES
('pamela', 'fernandez', 'gutierrez', 13123934, 13123934, 'pamela@gmail.com');

/*
Exercici 10. (0,75 punts)
Introdueix les següents dades a la taula bicicleta. Si a l’introduir les dades et dona errors, explica el
motiu de l’error que et dona i no insereixis el registre. Comprova quins són els registres que s’han
inserit.
*/

INSERT INTO BICICLETA (idbici, marca, model, preu) VALUES
(333456, 'Acepac', 'XTS23', 1500);

INSERT INTO BICICLETA (idbici, marca, model, preu) VALUES
(4233456, 'AEVOOR', 'Alpine', 2000);

INSERT INTO BICICLETA (idbici, marca, model, preu) VALUES
(5633456, NULL, 'BTH', 3000);

INSERT INTO BICICLETA (idbici, marca, model, preu) VALUES
(333774, 'Capsuled', 'Lumen', 0);

INSERT INTO BICICLETA (idbici, marca, model, preu) VALUES
(24334562, 'Lazer', NULL, 2500);

INSERT INTO BICICLETA (idbici, marca, model, preu) VALUES
(333456, 'FAZUA', 'Remix', 1700);

INSERT INTO BICICLETA (idbici, marca, model, preu) VALUES
(33334568, 'Octane One', 'Collage');

-- Donen error els inserts els quals tenen null a la columna marca ja que esta declarada com a not null,
-- També les que tenen preu 0 ja que hi ha una restriccio que comprova que el preu es mes gran que 0.
-- També el penultim insert ja que l'idbici esta duplicat i es la PK, per tant no es pot.

/*
Exercici 11. (0,25 punts)
Crea una seqüència perquè el camp idlloguer de la taula lloguer es pugui autoincrementar. Que
comenci per 100, que incrementi 10 i el valor màxim sigui 99999999. La seqüència s’ha d’anomenar
idlloguer_seq.
*/

CREATE SEQUENCE idlloguer_seq
INCREMENT 10
START WITH 100
MAXVALUE 99999999;


/*
Exercici 12. (0,75 punts)
Intenta inserir els següents registres a la taula lloguer. Utilitza la seqüencia creada en l’exercici
anterior. Si a l’introduir les dades et dona errors, explica l’error que et dona i no insereixis el registre.
La informació que s’ha d’intentar inserir és la següent:
*/

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu) VALUES
(NEXTVAL('idlloguer_seq'), 4233456, '2017-01-29', '2017-05-28', 3, 'RET', 0, 200);

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu) VALUES
(NEXTVAL('idlloguer_seq'), 333456, '2019-07-14', '2019-08-20', 10, 'RET', 0, 400);

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu) VALUES
(NEXTVAL('idlloguer_seq'), 4233456, '2020-06-21', '2020-09-12', 2, 'RET', 50, 300);

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu) VALUES
(NEXTVAL('idlloguer_seq'), 33334568, '2021-04-20', '2021-02-02', 2, 'RET', 0, 260);

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu) VALUES
(NEXTVAL('idlloguer_seq'), 333456, '2022-06-20', '2022-07-01', 1, 'PET', 0, NULL);

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu) VALUES
(NEXTVAL('idlloguer_seq'), 333456, '2023-09-13', '2023-10-11', 2, 'SET', 100, 370);

INSERT INTO LLOGUER (idlloguer, bici, datalloguer, dataretorn, client, retorn, penalitzacio, preu) VALUES
(NEXTVAL('idlloguer_seq'), 5633456, '2020-09-13', '2023-10-11', 2, 'PEN', 100, 500);

--ERRORS:
--El registre 2 no es pot insertar ja que el client amb id 10 no existeix (hem creat 5 clients)
--El 4 no es pot insertar ja que la data de lloguer es mes gran que la data de retorn i per tant viola la constraint declarada
--El 5 no es pot insertar ja que el preu no pot ser null
--El 6 no es pot ja que a retorn només es pot inserir RET o PEN no es SET i per tant viola la restriccio
--El 7 no es pot insertar ja que l'id de la bici no existeix

/*
Exercici 13. (0,5 punts)
Actualitza els valors del camp retorn de la taula lloguer de tots els lloguers que el preu sigui més
gran que 150. El retorn de tots aquests lloguers ha de ser PEN. Comprova que l’actualització s’ha
realitzat correctament.
*/

UPDATE LLOGUER
SET retorn = 'PEN'
WHERE preu>150;

SELECT * FROM LLOGUER;

/*
Exercici 14. (0,5 punts)
Elimina el la bicicleta amb l’identificador igual a 2126219
*/

DELETE FROM BICICLETA WHERE idbici = 2126219;

/*
Exercici 15. (0,25 punts)
Intenta eliminar la taula client. Ho pots fer? En cas negatiu explica perquè. Torna-la a crear afegint les
5 files inicials si l’has pogut eliminar.
*/

DROP TABLE CLIENT;

--No es pot esborrar ja que client te altres taules amb claus foranees que depenen d'ella, s'hauria de fer amb on delete cascade

/*
Exercici 16. (0,25 punts)
Intenta eliminar tot els valors de la taula bicicleta. Ho pots fer? En cas negatiu explica perquè.
*/

TRUNCATE TABLE BICICLETA;

--No es pot esborrar ja que bicicleta te altres taules amb claus foranees que depenen d'ella, s'hauria de fer amb on delete cascade

/*
Exercici 17. (0,5 punts)
Crea una vista anomenada telfclient amb el nom, primer cognom i telèfons dels clients.
Comprova el contingut de la vista creada.
*/

CREATE VIEW telfclient
AS (SELECT nom, cognom1, cognom2, telefon FROM CLIENT);

SELECT * FROM telfclient;

/*
Exercici 18. (0,25 punts)
Crea un índex únic anomenat cognom_idx sobre el camp cognom1 de la taula client i
comprova que s’ha creat correctament. Creus que és la millor opció crear un índex únic per
aquest camp?. Raona la resposta.
*/

CREATE INDEX cognom_idx
ON CLIENT(cognom1);

\d CLIENT

--La millor opcio es fer un UNIQUE INDEX

/*
Exercici 19. (0,5 punts)
Intenta actualitzar l’identificador de la bicicleta amb idbici igual a 4233456. El nou
identificador és 2233456. Si no es pot modificar explica perquè i realitza els canvis que
siguin necessaris a l‘estructura de les taules perquè aquest valor es pugui actualitzar.
Comprova que realment s'ha pogut actualitzar.
*/

UPDATE BICICLETA
SET idbici = 2233456
WHERE idbici = 4233456;

--No es pot ja que idbici tambe esta a la taula lloguer com a clau foranea

--Per fer-ho s'ha de posar la dada com a ON UPDATE cascade

--Canvi a la estructura de la taula
ALTER TABLE LLOGUER DROP CONSTRAINT FK_LLOGUER_BICICLETA ;
ALTER TABLE LLOGUER ADD CONSTRAINT FK_LLOGUER_BICICLETA FOREIGN KEY (bici) REFERENCES BICICLETA(idbici) ON UPDATE CASCADE;

--Comprovacio
SELECT idbici FROM BICICLETA WHERE idbici = 2233456;

/*
Exercici 20. (0,5 punts)
Exercici de transaccions. Suposem que inicialment la taula bicicleta està buida. Tenint en compte
les següents sentències respon les preguntes: Primer executem BEGIN;
T1: INSERT INTO bicicleta VALUES (‘45567’, ’BH’, ’Simple’, ’600’);
a) En quin estat està la taula i perquè?
T2: SELECT * FROM bicicleta;
T3: DELETE FROM bicicleta WHERE idllibre=’45567’;
T4: ROLLBACK;
b) En quin estat està la taula i perquè?
T5: INSERT INTO bicicleta VALUES (‘533422’, ’BH’, ’Ramses’, 970);
T6: COMMIT;
c) En quin estat està la taula i perquè?
*/

--a) Ara la taula te un registre
--b) Ara s'ha esborrat el registre i amb el rollback s'ha tirat enrere fins al principi
--c) Ara s'ha inserit un registre i s'ha fet commit, per tant aquest registre ja esta guardat