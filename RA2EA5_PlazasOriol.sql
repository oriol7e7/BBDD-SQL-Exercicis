--Conectarse a client Postgres
psql -U postgres

--Crear base de dades agenda
CREATE DATABASE agenda;

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

--Alter table
ALTER TABLE FITXA ADD COLUMN cp VARCHAR(5);

--comprovar que s'ha creat
\d FITXA

--Canviar nom
ALTER TABLE FITXA RENAME COLUMN cp TO Codi_Postal;

ALTER TABLE FITXA RENAME CONSTRAINT PK_FITXA TO PrimKey_Fitxa;

--Modificar longitud tipus de dada
ALTER TABLE FITXA ALTER COLUMN Codi_Postal TYPE VARCHAR(10);

ALTER TABLE FITXA ALTER COLUMN Codi_Postal TYPE NUMERIC(5);

