/*
Exercici 1. Crea un bloc anònim amb tres variables de tipus NUMERIC. Aquestes variables
han de tenir un valor inicial de 15, 40 i 35 respectivament. El bloc ha de sumar aquestes tres variables i
mostrar per pantalla ‘LA SUMA TOTAL ÉS: (la suma de les variables)’.
*/
do $$
DECLARE
    var1 NUMERIC(5) :=15;
    var2 NUMERIC(5) :=40;
    var3 NUMERIC(5) :=35;
    result numeric(6,2);
BEGIN
    result = var1+var2+var3;
    raise notice 'LA SUMA TOTAL ÉS%:', result;
end;
$$

/*
Exercici 2. Crea un bloc anònim que ha d'imprimir el cognom de l'empleat en majúscules amb codi
número 104 de la taula (EMPLOYEES), on has de declarar una variable de tipus last_name.
*/
do $$
DECLARE
    eLastName EMPLOYEES.last_name%TYPE;
BEGIN
    SELECT employees.last_name
    into eLastName
    from employees
    WHERE employee_id = 104;
    raise notice '%', eLastName;
end;
$$

/*
Exercici 3. Crea un bloc anònim que ha d'imprimir el cognom en majúscules de l'empleat amb l’id
introduït per pantalla.
*/
do $$
DECLARE
    eLastName EMPLOYEES.last_name%TYPE;
BEGIN
    SELECT employees.last_name
    into eLastName
    from employees
    WHERE employee_id = :id;
    raise notice '%', eLastName;
end;
$$
