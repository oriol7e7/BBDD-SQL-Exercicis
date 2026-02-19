/*Creacio BBDD*/
CREATE DATABASE biblio;

/*
Exercici 1. (1,5 punts)
Escriu les sentències necessàries per crear les taules SOCI, PRESTEC i LLIBRE a la base de dades
biblio. tenint en compte les restriccions indicades.
*/

--Taula soci
CREATE TABLE IF NOT EXISTS SOCI (
    idsoci SERIAL NOT NULL,
    nom VARCHAR(30),
    cognoms VARCHAR(50),
    dni VARCHAR(9) NOT NULL,
    telefon NUMERIC(9) NOT NULL,
    email VARCHAR(35) NOT NULL,
    CONSTRAINT PK_SOCI PRIMARY KEY (idsoci),
    CONSTRAINT UQ_DNI UNIQUE (dni),
    CONSTRAINT UQ_TELEFON UNIQUE (telefon),
    CONSTRAINT UQ_EMAIL UNIQUE (email)
);

--Taula llibre
CREATE TABLE IF NOT EXISTS LLIBRE (
    idllibre NUMERIC(15) NOT NULL,
    isbn VARCHAR(25) NOT NULL,
    titol VARCHAR(70),
    autor VARCHAR(60),
    CONSTRAINT PK_LLIBRE PRIMARY KEY (idllibre),
    CONSTRAINT UQ_ISBN UNIQUE (isbn)
);

--Taula prestec
CREATE TABLE IF NOT EXISTS PRESTEC (
    idprestec NUMERIC(35),
    idllibre NUMERIC(15),
    dataPres DATE,
    dataRet DATE,
    idsoci INTEGER,
    estat CHAR(3),
    penalitzacio NUMERIC(10) DEFAULT 20 NOT NULL,
    CONSTRAINT PK_PRESTEC PRIMARY KEY (idprestec),
    CONSTRAINT FK_PRESTEC_LLIBRE FOREIGN KEY (idllibre) REFERENCES LLIBRE(idllibre),
    CONSTRAINT FK_PRESTEC_SOCI FOREIGN KEY (idsoci) REFERENCES SOCI(idsoci),
    CONSTRAINT CK_ESTAT_VALUES CHECK (estat IN ('RET', 'PEN')),
    CONSTRAINT CK_PENALITZACIO_MAJOR0 CHECK (penalitzacio>0)
);

/*
Exercici 2. (0,25 punts)
Canvia el nom de la restricció que obliga que el camp estat de la taula prestec només accepti ‘REP’ o
‘PEN’. Ara es diu state_ck. Comprova si s’ha realitzat el canvi de nom.
*/

ALTER TABLE PRESTEC RENAME CONSTRAINT CK_ESTAT_VALUES TO state_ck;

--Comprovacio canvi de nom
\d+ PRESTEC

/*
Exercici 3. (0,25 punts)
Elimina la columna autor de la taula llibre i comprova l’estructura de la taula llibre.
*/

ALTER TABLE LLIBRE DROP COLUMN autor;

--Comprovacio eliminacio columna
\d LLIBRE

/*
Exercici 4. (0,25 punts)
Torna a afegir la columma autor a la taula llibre amb el tipus de dades VARCHAR(90) i comprova
l’estructura de la taula llibre.
*/

ALTER TABLE LLIBRE ADD COLUMN autor VARCHAR(90);

--Comprovacio addició columna
\d LLIBRE

/*
Exercici 5. (0,25 punts)
Afegeix una nova restricció a la taula prestec per controlar que la data de retorn ha de ser superior a la
data del préstec.
*/

ALTER TABLE PRESTEC ADD CONSTRAINT CK_DATARET_MAJOR_DATAPRES CHECK (dataRet>dataPres);

/*
Exercici 6. (0,25 punts)
Canvia el tipus de dades del camp idsoci de la taula prestec. El nou tipus de dades d’aquest camp ha de
ser NUMERIC(35). Si no es pot fer el canvi explica perquè.
*/

ALTER TABLE PRESTEC ALTER COLUMN idsoci TYPE NUMERIC(35) USING idsoci::NUMERIC;

--No es pot ja que a la taula PRESTEC on idsoci és clau foranea
--té el tipus de dades INTEGER i no podem tenir dues taules relacionades
--on el camp a cada taula te un tipus de dada diferent

/*
Exercici 7. (0,5 punts)
Insereix 5 socis a la taula soci amb dades inventades. Tots els camps han de tenir un valor, i comprova
que s’han insertat correctament.
*/

--Es pot fer un a un per veure si un falla i que just aquest no s'insereixi
INSERT INTO SOCI (nom, cognoms, dni, telefon, email) VALUES 
('oriol', 'plazas leon', '123456789', 123456789, 'oriol@gmail.com'),
('dani', 'guillamon', '987654321', 987654321, 'dani@gmail.com'),
('jordi', 'garcia', '135790864', 135790864, 'jordi@gmail.com'),
('gemma', 'lopez', '123457896', 123457896, 'gemma@gmail.com'),
('andreu', 'fernandez', '111222333', 111222333, 'andreu@gmail.com');


/*
Exercici 8. (0,75 punts)
Introdueix les següents dades a la taula llibre. Si a l’introduir les dades et dona errors, explica el
motiu de l’error que et dona i no insereixis el registre. Comprova quins són els registres que s’han
inserit.
*/

--Es pot fer un a un per veure si un falla i que just aquest no s'insereixi
INSERT INTO LLIBRE (idllibre, isbn, titol, autor) VALUES 
(2121213, '0-7645-2641-22', 'Preludi de la fundació', 'Isaac Asimov'),
(2124215, '0-7645-2481-1', 'Estranger', 'Albert Camus'),
(2123217, '0-7645-2633-3', 'Jo Claudi', 'Robert Graves'),
(2121213, '0-7645-2641-3', 'Ulises', 'James Joyce'),
(2126219, '0-7645-34641-11', 'Els miserables', 'Victor Hugo'),
(21292110, '0-8445-2641-45', 'Rayuela', 'Julio Cortázar'),
(21212124, '0-7645-2633-3', 'El vell i el mar', 'Ernest Hemingway'),
(212123234, '', 'La taronja mecànica', 'Anthony Burgess');

--Els errors son que l'isbn no pot ser nul (a l'ultim registre), que l'isbn 
--tampoc es pot repetir (es NOT NULL), que l'idllibre tampoc es pot repetir (es PK)

/*
Exercici 9. (0,25 punts)
Crea una seqüència perquè el camp idprestec de la taula prestec es pugui autoincrementar. Que
comenci per 50, que incrementi 10 i el valor màxim sigui 9000000. La seqüència s’ha d’anomenar
idprestec_seq.
*/

CREATE SEQUENCE idprestec_seq
INCREMENT 10
START WITH 50
MAXVALUE 9000000;

/*
Exercici 10. (0,75 punts)
Intenta inserir els següents registres a la taula prestec. Utilitza la seqüencia creada en l’exercici
anterior. Si a l’introduir les dades et dona errors, explica l’error que et dona i no insereixis el registre.
La informació que s’ha d’intentar inserir és la següent:
*/

--Es pot fer un a un per veure si un falla i que just aquest no s'insereixi
INSERT INTO PRESTEC (idprestec, idllibre, datapres, dataret, idsoci, estat, penalitzacio) VALUES 
(NEXTVAL('idprestec_seq'), 2123217, '2017-01-29', '2017-05-28', 3, 'RET', 50),
(NEXTVAL('idprestec_seq'), 21331216, '2021-08-19', '2021-12-08', 1, 'PEN', 30),
(NEXTVAL('idprestec_seq'), 21292110, '2019-09-25', '2019-12-24', 2, 'PEN'),
(NEXTVAL('idprestec_seq'), 2123217, '2017-03-14', '2017-03-11', 2, 'RET', 50),
(NEXTVAL('idprestec_seq'), 2124215, '2019-08-14', '2020-01-05', 1, 'SET'),
(NEXTVAL('idprestec_seq'), 2123217, '2017-01-02', '01-02-2017', 8, 'PEN', 30),
(NEXTVAL('idprestec_seq'), 2121213, '2016-04-04', '2016-11-06', 4, 'RET');

--No deixa ja que hi ha registres con la data de prestec es major que la data de retorn
--hi han camps nuls, i a estat i han valors que no estan inclosos dins del rang de la constraint.
--També hi ha formats de dates incorrectes

/*
Exercici 11. (0,5 punts)
Actualitza els valors del camp estat de la taula prestec de tots els préstecs que la penalització sigui
més gran que 10. L’estat de tots aquests préstecs ha de ser PEN. Comprova que l’actualització s’ha
realitzat correctament.
*/

UPDATE PRESTEC
SET estat = 'PEN'
WHERE penalitzacio > 10;

--Comprovacio
SELECT * FROM PRESTEC;

/*
Exercici 12. (0,5 punts)
Elimina el llibre que el codi del llibre sigui igual a 2126219.
*/

DELETE FROM LLIBRES WHERE idllibre = 2126219;

/*
Exercici 13. (0,25 punts)
Intenta eliminar la taula llibre. Ho pots fer? En cas negatiu explica perquè. Torna-la a crear afegint les
5 files inicials si l’has pogut eliminar.
*/

DROP TABLE LLIBRE;

--No es pot eliminar ja que a la taula PRESTEC està el camp idllibre(FK) i sense la taula llibre no pot fer referencia al camp idllibre, 
--s'hauria de posar un ON DELETE CASCADE per a que al esborrar la taula també s'esborressin els valors dels camps d'altres taules on hi hagi
--algun camp referenciant a la taula esborrada

/*
Exercici 14. (0,25 punts)
Intenta eliminar tot els valors de la taula llibre. Ho pots fer? En cas negatiu explica perquè.
*/

TRUNCATE TABLE LLIBRE;

--No es pot fer pel mateix motiu que el drop table

/*
Exercici 16. (0,5 punts)
Crea una vista anomenada socipen amb el nom, cognoms i telèfon dels socis que tinguin préstecs amb
penalitzacions més grans que 20. Comprova el contingut de la vista creada.
*/

CREATE VIEW socipen AS (SELECT p.nom, p.cognom, p.telefon FROM SOCI s, PRESTEC p WHERE p.penalitzacio>20);

/*
Exercici 17. (0,25 punts)
Crea un índex únic anomenat isbn_idx sobre el camp isbn de la taula llibre i comprova que s’ha creat
correctament.
*/

CREATE INDEX isbn_idx ON LLIBRE(isbn);

--Comprovar que s'ha creat 
\d LLIBRE

/*
Exercici 18. (0,25 punts)
Crea un índex anomenat autor_idx sobre el camp autor de la taula llibre i comprova que s’ha creat
correctament.
*/

CREATE INDEX autor_idx ON LLIBRE(autor);

--Comprovar que s'ha creat
\d LLIBRE

/*
Exercici 19. (0,75 punt)
Actualitza el codi del llibre amb idllibre igual a 2121213. El nou codi és 4121214. Si no es pot
modificar explica perquè i realitza els canvis que siguin necessaris a l‘estructura de les taules perquè
aquest valor es pugui actualitzar. Comprova que realment s'ha pogut actualitzar.
*/
UPDATE LLIBRE
SET idllibre = 4121214
WHERE idllibre = 2121213;


--Comprovacio que s'ha actualitzat
SELECT idllibre FROM LLIBRE WHERE idllibre = 4121214;

/*
Exercici 20. (1,5 punts)
Exercici de transaccions. Suposem que inicialment la taula llibre esta buida. Tenint en compte les
següents sentències respon les preguntes:
*/

--a) En quin estat està la taula i perquè?
--S'ha inserit un registre

--b) En quin estat està la taula i perquè?
--Ara esta buida ja que tornes enrere al principi ja que no hi ha commits

--c) En quin estat està la taula i perquè?
--Ara hi han dades inserides i guardades amb el commit


--d) en quin estat està la taula i perquè?
--Ara s'ha tornat enrere a l'ultim commit ja que s'ha fet un rollbacl i les dades estan aixi: INSERT INTO llibre VALUES (‘50’, ’12345679’, ’Introducció a Oracle II’, ’Jordi Gómez’);

--e) En quin estat està la taula i perquè?
--Ara s'han inserit dos registres més i s'ha posat una marca amb nom intA

--f) En quin estat està la taula i perquè?
--Ara l'ultim insert ha sigut esborrat i s'ha tornat enrere a la marca intA ja que s'ha fet un rollback, per això l'ultim insert desapareix

--g) En quin estat està la taula i perquè?
--Ara s'han actualitzat dades amb UPDATE i s'han guardat ja que s'ha fet commit

--h) En quin estat està la taula i perquè?
--Ara s'ha tirat enrere a la ultima marca amb nom intA ja que s'ha fet rollback