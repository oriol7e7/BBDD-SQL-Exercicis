-- Situació actual: BBDD - Agenda | Taula - FITXA

-- Si no esta creada la base de dades ni taules:
---------------------------------------------------
--Crear usuari agenda i permisos
CREATE USER agenda WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'agenda';
ALTER DATABASE agenda OWNER TO agenda;
GRANT ALL PRIVILEGES ON DATABASE agenda TO agenda;

--Sortir del client
\q

--Connectarse a la base de dades agenda amb el seu usuari
psql -U agenda -W -d agenda

--Creacio taula fitxa

CREATE TABLE IF NOT EXISTS FITXA(
    dni NUMERIC(10) NOT NULL,
    nom VARCHAR(30) NOT NULL,
    cognoms VARCHAR(70) NOT NULL,
    adreca VARCHAR(60),
    telefon VARCHAR(11) NOT NULL,
    provincia VARCHAR(30),
    data_naix DATE DEFAULT CURRENT_DATE,
    CONSTRAINT PK_FITXA PRIMARY KEY (dni)
);

--Comentaris
--taula.columna de la taula
COMMENT ON COLUMN FITXA.dni IS 'DNI de la persona';
COMMENT ON COLUMN FITXA.nom IS 'Nom de la persona';
COMMENT ON COLUMN FITXA.cognoms IS 'Cognoms de la persona';
COMMENT ON COLUMN FITXA.adreca IS 'Adreça de la persona';
COMMENT ON COLUMN FITXA.telefon IS 'Telefon de la persona';
COMMENT ON COLUMN FITXA.provincia IS 'Provincia on resideix la persona';
COMMENT ON COLUMN FITXA.data_naix IS 'Data de Naixmenet de la persona';

------------------------------
--Novetats practica RA4EA2

--Afegir camp Equip
ALTER TABLE FITXA ADD COLUMN EQUIP INTEGER;

--Inserts
INSERT INTO FITXA VALUES(
    3421232, 
    'LUIS MIGUEL', 
    'ACEDO GOMEZ',
    'GUZMÁN EL BUENO, 90',
    '969-23-12-56',
    NULL,
    '05/05/1970',
    1
);
INSERT INTO FITXA VALUES(
    4864868, 
    'BEATRIZ', 
    'SANCHO MANRIQUE',
    'ZURRIAGA, 25',
    '93-232-12-12',
    'BCN',
    '06/07/1978',
    2
);

--Eliminar fila amb dni 3421232
DELETE FROM FITXA WHERE dni = 3421232;

--Insert 
INSERT INTO FITXA VALUES(
    3421232, 
    'LUIS MIGUEL', 
    'ACEDO GOMEZ',
    'GUZMÁN EL BUENO, 90',
    '969-23-12-56',
    NULL,
    DEFAULT,
    1
);


--Buidar taula
TRUNCATE TABLE FITXA;

--Inserir dades indicant els camps
INSERT INTO FITXA (dni, nom, cognoms, adreca, telefon, provincia, data_naix, equip)
VALUES (
    3421232, 
    'LUIS MIGUEL', 
    'ACEDO GOMEZ',
    'GUZMÁN EL BUENO, 90',
    '969-23-12-56',
    NULL,
    '05/05/1970',
    1
);

INSERT INTO FITXA (dni, nom, cognoms, adreca, telefon, provincia, data_naix, equip)
VALUES (
    4864868, 
    'BEATRIZ', 
    'SANCHO MANRIQUE',
    'ZURRIAGA, 25',
    '93-232-12-12',
    'BCN',
    '06/07/1978',
    2
);

----
BEGIN

INSERT INTO FITXA VALUES(
    7868544, 
    'JONÁS', 
    'ALMENDROS RODRÍGUEZ',
    'FEDERICO PUERTAS, 3',
    '915478947',
    'MADRID',
    '01/01/1987',
    3
);
INSERT INTO FITXA VALUES(
    8324216, 
    'PEDRO', 
    'MARTÍN HIGUERO',
    'VIRGEN DEL CERRO, 154',
    '961522344',
    'SORIA',
    '29/04/1978',
    5
);

---

INSERT INTO FITXA VALUES(
    14948992, 
    'SANDRA', 
    'MARTÍN GONZÁLEZ',
    'PABLO NERUDA, 15',
    '916581515',
    'MADRID',
    '05/05/1970',
    6
);

---

INSERT INTO FITXA VALUES(
    15756214, 
    'MIGUEL', 
    'CAMARGO ROMÁN',
    'ARMADORES, 1',
    '949488588',
    NULL,
    '12/12/1985',
    7
);

COMMIT intA;

---

INSERT INTO FITXA VALUES(
    21158230, 
    'SERGIO', 
    'ALFARO IBIRICU',
    'AVENIDA DEL EJERCITO, 76',
    '934895855',
    'BCN',
    '11/11/1987',
    8
);

INSERT INTO FITXA VALUES(
    34225234, 
    'ALEJANDRO', 
    'ALCOCER JARABO',
    'LEONOR DE CORTINAS, 7',
    '935321211',
    'MADRID',
    '05/05/1970',
    9
);

COMMIT intB;

---

INSERT INTO FITXA VALUES(
    38624852, 
    'ALVARO', 
    'RAMÍREZ AUDIGE',
    'FUENCARRAL, 33',
    '912451168',
    'MADRID',
    '10/09/1976',
    10
);

COMMIT intC;

---

INSERT INTO FITXA VALUES(
    45824852, 
    'ROCÍO', 
    'PÉREZ DEL OLMO',
    'CERVANTES, 22',
    '912332138',
    'MADRID',
    '06/12/1987',
    11
);

INSERT INTO FITXA VALUES(
    48488588, 
    'JESÚS', 
    'BOBADILLA SANCHO',
    'GAZTAMBIQUE, 32',
    '913141111',
    'MADRID',
    '05/05/1970',
    13
);

COMMIT intD;

---

--Esborrar registre amb DNI: 45824852.

DELETE FROM FIXTA WHERE dni = 45824852;

COMMIT intE;

SELECT * FROM FITXA;


-- Modificar registre
UPDATE FITXA SET EQUIP = 11 WHERE DNI = 48488588;

COMMIT intF;

ROLLBACK intE;
SELECT * FROM FITXA;

ROLLBACK intD;
SELECT * FROM FITXA;

-- Modificar registre
UPDATE FITXA SET EQUIP = 11 WHERE DNI = 38624852.;
SELECT * FROM FITXA;


--
INSERT INTO FITXA VALUES(
    98987765, 
    'PEDRO', 
    'RUIZ RUIZ',
    'SOL, 43',
    '91-656-43-32',
    'MADRID',
    '10/09/1976',
    12
);

SELECT * FROM FITXA;