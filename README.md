# CONSTRAINTS SQL
  
  
## Restriccions de clau:
  
### PRIMARY KEY:
````` sql
CONSTRAINT [PK_TAULA] PRIMARY KEY ([DNI])
`````
  

*PK_TAULA és el nom per a identificar la primary key, s’acostuma a posar PK_NOMTAULA

*DNI és el camp de la taula que serà la primary key

  

### FOREIGN KEY:
````` sql
CONSTRAINT [FK_TAULA_TAULAREF] FOREIGN KEY ([DNI]) REFERENCES [CLIENT(DNI)]
`````
  

*PK_TAULA_TAULAREF és el nom per a identificar la foreign key, s’acostuma a posar PK_NOMTAULA_TAULAQUEREFERENCIA

*DNI és el camp de la taula que serà la foreign key

*CLIENT(DNI) Client es la taula a la que fa referència la clau forànea i dni es el camp de la taula a la que fa referència (dni està relacionat amb dni de la taula client)

  

## Restriccions Check:

Per comprovar si el valor a introduir compleix unes regles definides

  

### Comparació i rang (<, >, <=, >=, =, BETWEEN):

Comparar un valor per veure si està en un rang o si és major o menor que (valors numèrics)
`````sql
CONSTRAINT CK_TAULA CHECK (preu>0)
`````
  

### Conjunt de valors (IN, NOT IN):

El valor ha de ser un determinat en una llista especifica
`````sql
CONSTRAINT CK_TAULA CHECK (color IN (‘Vermell’, ‘Verd’, ‘Blau’’))
`````
  

### Manipulació de Strings (UPPER, LOWER, o LENGTH):

El valor ha de ser en majúscules, minúscules o d’una llargària determinada
`````sql
CONSTRAINT CK_TAULA CHECK (nom = UPPER(nom))
`````
  
  

### Operacions matemàtiques (+, -, *, /):

Assegurar lògica matemàtica entre valors de diferents columnes
````` sql
CONSTRAINT CK_TAULA CHECK (marge > (cost * 0.10))
`````
  

### Operadors Lògics (AND, OR, NOT):

Combinar condicions en una regla
`````sql
CONSTRAINT CK_TAULA CHECK ((metode = 'aeri' AND pes< 5) OR (metode = 'maritim'))
`````
  

### Format i patró (~):

Validar formats complexes segons regles
`````sql
CONSTRAINT CK_TAULA CHECK (DNI ~ '^[0-9]{8}[A-Z]$')
`````
*el camp DNI ha de ser de 8 caracters entre 0 i 9 i una lletra

  
  

## Restricció UNIQUE:

Garanteix que el valor no és repeteix en el camp (no pot aparèixer el mateix DNI dos vegades)
`````sql
CONSTRAINT [UQ_DNI] UNIQUE [email]
`````
  
  

## Restricció NOT NULL:

Garanteix que el valor no pot ser null, i per tant sempre ha de haver un valor. (Sense Constraint)

`````sql
campExemple NUMERIC(100) NOT NULL
`````
  
  

## Restricció DEFAULT:

Especifica el valor per defecte que té aquell camp
`````sql
estat VARCHAR(20) DEFAULT ‘ACTIU’CONSTRAINTS SQL
`````
  
