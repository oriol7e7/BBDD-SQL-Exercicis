--Conectarse a client Postgres
psql -U postgres

--Crear base de dades cadastre
CREATE DATABASE cadastre;

--Crear usuari cadastre i permisos
CREATE USER cadastre WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'cadastre';
ALTER DATABASE cadastre OWNER TO cadastre;
GRANT ALL PRIVILEGES ON DATABASE cadastre TO cadastre;

--Sortir del client
\q

--Connectarse a la base de dades cadastre amb el seu usuari
psql -U cadastre -W -d cadastre


--Creacio taules sense constraints
CREATE TABLE IF NOT EXISTS zonaurbana(
    nom_zona VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS vivenda(
    carrer VARCHAR(80) NOT NULL,
    nombre NUMERIC(4) NOT NULL,
    tipus_vivenda VARCHAR(1),
    codi_postal NUMERIC(5),
    metres NUMERIC(5),
    nom_zona VARCHAR(60)
);

CREATE TABLE IF NOT EXISTS persona(
    dni VARCHAR(12) NOT NULL,
    nom_persona VARCHAR(20),
    cognoms_persona VARCHAR(40),
    dni_c VARCHAR(12),
    carrer VARCHAR(80),
    nombre NUMERIC(4)
);

CREATE TABLE IF NOT EXISTS bloccases(
    carrer VARCHAR(80) NOT NULL,
    nombre NUMERIC(4) NOT NULL,
    metres_b NUMERIC(4)
);

CREATE TABLE IF NOT EXISTS pis (
    carrer VARCHAR(80) NOT NULL,
    nombre NUMERIC(4) NOT NULL,
    escala VARCHAR(1) NOT NULL,
    planta NUMERIC(2) NOT NULL,
    porta VARCHAR(2) NOT NULL,
    metres_p NUMERIC(4),
    dni_p VARCHAR(12)
);

CREATE TABLE IF NOT EXISTS casaparticular(
    carrer VARCHAR(80) NOT NULL,
    nombre NUMERIC(4) NOT NULL,
    metres_c NUMERIC(4),
    dni_cp VARCHAR(12)
);

CREATE TABLE IF NOT EXISTS habitapis(
    dni VARCHAR(12) NOT NULL
    carrer VARCHAR(80) NOT NULL,
    nombre NUMERIC(4) NOT NULL,
    escala VARCHAR(1) NOT NULL,
    planta NUMERIC(2) NOT NULL,
    porta VARCHAR(2) NOT NULL
);

--Alter table per afegir constraint

ALTER TABLE zonaurbana
ADD CONSTRAINT PK_zonaurbana PRIMARY KEY (nom_zona),
ADD CONSTRAINT CK_nomZonaMajus CHECK (nom_zona = UPPER(nom_zona));

ALTER TABLE vivenda
ADD CONSTRAINT PK_vivenda PRIMARY KEY (carrer, nombre),
ADD CONSTRAINT FK_vivenda_zonaurbana FOREIGN KEY (nom_zona) REFERENCES zonaurbana(nom_zona),
ADD CONSTRAINT CK_carrerPrimeraMajus CHECK (carrer = INITCAP(carrer)),
ADD CONSTRAINT CK_nombreMajor0 CHECK (nombre>0),
ADD CONSTRAINT CK_tipus_vivendaIn CHECK (tipus_vivenda IN ('C', 'B'));

--Afegir default, no es pot en la mateixa comanda (block) que les constraints
ALTER TABLE vivenda
ALTER COLUMN codi_postal SET DEFAULT '00001';

ALTER TABLE persona
ADD CONSTRAINT PK_persona PRIMARY KEY (dni),
ADD CONSTRAINT FK_persona_vivenda_carrer_nombre FOREIGN KEY (carrer, nombre) REFERENCES vivenda(carrer, nombre),
ADD CONSTRAINT FK_persona_dni_c FOREIGN KEY (dni_c) REFERENCES persona(dni)

ALTER TABLE bloccases 
ADD CONSTRAINT PK_bloccases PRIMARY KEY (carrer, nombre),
ADD CONSTRAINT FK_bloccases_vivenda_carrer_nombre FOREIGN KEY (carrer, nombre) REFERENCES vivenda(carrer, nombre) ON DELETE CASCADE,
ADD CONSTRAINT CK_metresbMajor0 CHECK (metres_b>0);

ALTER TABLE casaparticular
ADD CONSTRAINT PK_casaparticular PRIMARY KEY (carrer, nombre),
ADD CONSTRAINT FK_casaparticular_persona_dnicp FOREIGN KEY (dni_cp) REFERENCES persona(dni),
ADD CONSTRAINT FK_casaparticular_vivenda_carrer_nombre FOREIGN KEY (carrer, nombre) REFERENCES vivenda(carrer, nombre) ON DELETE CASCADE,
ADD CONSTRAINT CK_metrescMajor0 CHECK (metres_c>0);

ALTER TABLE pis 
ADD CONSTRAINT PK_pis PRIMARY KEY (carrer, nombre, escala, planta, porta),
ADD CONSTRAINT FK_casaparticular_bloccases_carrer_nombre FOREIGN KEY (carrer, nombre) REFERENCES bloccases(carrer, nombre) ON DELETE CASCADE,
ADD CONSTRAINT FK_pis_persona_dnip FOREIGN KEY (dni_p) REFERENCES persona(dni) ON DELETE CASCADE,
ADD CONSTRAINT CK_metres_pMajor0 CHECK (metres_p>0);

ALTER TABLE habitapis
ADD CONSTRAINT PK_habitapis PRIMARY KEY (dni),
ADD CONSTRAINT FK_habitapis_persona_dni FOREIGN KEY (dni) REFERENCES persona(dni),
ADD CONSTRAINT FK_habitapis_pis FOREIGN KEY (carrer, nombre, escala, planta, porta) REFERENCES pis(carrer, nombre, escala, planta, porta) ON DELETE CASCADE;
