# METACOMANDES, TIPUS DE DADES, DDL (CONSTRAINTS)

## METACOMANDES BÀSIQUES POSTGRES

Llistar Bases de Dades al gestor (nivell servidor)
````` sql
\l
`````

Llistar taules de la base de dades a la que estàs connectat (pots afegir una taula per veure els camps)
````` sql
\d
`````

LListar Schemas dins de la base de dades
````` sql
\dn
`````

Veure Schema on estas situat actualment
````` sql
\ds
`````
### Crear base de dades amb usuari

````` sql
--Crear base de dades institut
CREATE DATABASE institut;

--Crear usuari institut i permisos
CREATE USER institut WITH SUPERUSER CREATEROLE ENCRYPTED PASSWORD 'institut';
ALTER DATABASE institut OWNER TO institut;
GRANT ALL PRIVILEGES ON DATABASE institut TO institut;

--Sortir del client
\q

--Connectarse a la base de dades institut amb el seu usuari
psql -U institut -W -d institut

--Veure usuari connectat
SELECT current_user;
`````

## TIPUS DE DADES

### Dades de caràcters (Text)

-   **VARCHAR($n$):** Cadena de caràcters de longitud variable amb un màxim de $n$ caràcters.
    
-   **CHAR($n$):** Cadena de caràcters de longitud fixa de $n$ caràcters. S'omple amb espais si el valor és més curt.
    
-   **TEXT:** Cadena de caràcters de longitud variable per a grans quantitats de text.
    

### Dades numèriques

-   **INT / INTEGER:** Nombre enter.
    
-   **SMALLINT:** Nombre enter petit.
    
-   **BIGINT:** Nombre enter gran.
    
-   **NUMERIC($p, s$) / DECIMAL($p, s$):** Nombre amb precisió i escala. $p$ és el nombre total de dígits, $s$ és el nombre de dígits després del punt decimal.
    
-   **FLOAT / REAL:** Nombre en coma flotant (aproximat).
    
-   **DOUBLE PRECISION:** Nombre en coma flotant de doble precisió (aproximat).
    

### Dades de data i hora

-   **DATE:** Emmagatzema només la data (any, mes, dia).
    
-   **TIME:** Emmagatzema només l'hora (hora, minut, segon).
    
-   **TIMESTAMP:** Emmagatzema la data i l'hora.
    
-   **INTERVAL:** Emmagatzema un període de temps.
    

## Dades booleanes

-   **BOOLEAN:** Pot emmagatzemar $\text{TRUE}$, $\text{FALSE}$ o $\text{NULL}$.



## CONSTRAINTS
### Restriccions de clau:
  
#### PRIMARY KEY:
````` sql
CONSTRAINT [PK_TAULA] PRIMARY KEY ([DNI])
`````
  

*PK_TAULA és el nom per a identificar la primary key, s’acostuma a posar PK_NOMTAULA

*DNI és el camp de la taula que serà la primary key

  

#### FOREIGN KEY:
````` sql
CONSTRAINT [FK_TAULA_TAULAREF] FOREIGN KEY ([DNI]) REFERENCES [CLIENT(DNI)]
`````
  

*PK_TAULA_TAULAREF és el nom per a identificar la foreign key, s’acostuma a posar PK_NOMTAULA_TAULAQUEREFERENCIA

*DNI és el camp de la taula que serà la foreign key

*CLIENT(DNI) Client es la taula a la que fa referència la clau forànea i dni es el camp de la taula a la que fa referència (dni està relacionat amb dni de la taula client)

  

### Restriccions Check:

Per comprovar si el valor a introduir compleix unes regles definides

  

#### Comparació i rang (<, >, <=, >=, =, BETWEEN):

Comparar un valor per veure si està en un rang o si és major o menor que (valors numèrics)
`````sql
CONSTRAINT CK_TAULA CHECK (preu>0)
`````
  

#### Conjunt de valors (IN, NOT IN):

El valor ha de ser un determinat en una llista especifica
`````sql
CONSTRAINT CK_TAULA CHECK (color IN (‘Vermell’, ‘Verd’, ‘Blau’’))
`````
  

#### Manipulació de Strings (UPPER, LOWER, o LENGTH):

El valor ha de ser en majúscules, minúscules o d’una llargària determinada
`````sql
CONSTRAINT CK_TAULA CHECK (nom = UPPER(nom))
`````
  
  

#### Operacions matemàtiques (+, -, *, /):

Assegurar lògica matemàtica entre valors de diferents columnes
````` sql
CONSTRAINT CK_TAULA CHECK (marge > (cost * 0.10))
`````
  

#### Operadors Lògics (AND, OR, NOT):

Combinar condicions en una regla
`````sql
CONSTRAINT CK_TAULA CHECK ((metode = 'aeri' AND pes< 5) OR (metode = 'maritim'))
`````
  

#### Format i patró (~):

Validar formats complexes segons regles
`````sql
CONSTRAINT CK_TAULA CHECK (DNI ~ '^[0-9]{8}[A-Z]$')
`````
*el camp DNI ha de ser de 8 caracters entre 0 i 9 i una lletra

  
  

### Restricció UNIQUE:

Garanteix que el valor no és repeteix en el camp (no pot aparèixer el mateix DNI dos vegades)
`````sql
CONSTRAINT [UQ_DNI] UNIQUE [email]
`````
  
  

### Restricció NOT NULL:

Garanteix que el valor no pot ser null, i per tant sempre ha de haver un valor. (Sense Constraint)

`````sql
campExemple NUMERIC(100) NOT NULL
`````
  
  

### Restricció DEFAULT:

Especifica el valor per defecte que té aquell camp
`````sql
estat VARCHAR(20) DEFAULT ‘ACTIU’CONSTRAINTS SQL
`````
## SCHEMAS:

Un esquema es un grup de taules que les pot agrupar en tipus. 
Per exemple una base de dades d'un laboratori pot tindre un Schema d'administració i de clinica.

Crear Schema:
`````sql
CREATE SCHEMA [nom-schema];
`````
 
Situar-se a un Schema (al schema que et situis, totes les instruccions que facis (com CREATE TABLE) es faran dins d'aquell Schema, al fer CREATE TABLE es crearà la taula dins de l'Schema):
`````sql
SET search_path TO [nom-schema];
`````

Moure una taula d'un Schema a un altre
`````sql
ALTER TABLE nom-schema.nomTaula SET SCHEMA [schema-desti];
`````
