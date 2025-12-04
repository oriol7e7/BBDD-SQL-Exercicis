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