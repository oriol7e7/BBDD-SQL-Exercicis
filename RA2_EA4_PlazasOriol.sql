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
