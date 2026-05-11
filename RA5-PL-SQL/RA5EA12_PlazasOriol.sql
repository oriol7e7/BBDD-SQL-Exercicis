/*
EX1
*/
--procediment
CREATE OR REPLACE PROCEDURE proc_elim_nous_emps() LANGUAGE plpgsql
AS $$
    DECLARE
        var_nomDept departments.department_name%type;
        var_employee RECORD;
          curs_emp CURSOR (par_dept_name departments.department_name%type) FOR
            SELECT e.*
            FROM employees e
                JOIN departments d
                ON d.department_id = e.department_id
            WHERE LOWER(d.department_name) = LOWER(par_dept_name)
            LIMIT 2;
    BEGIN
        var_nomDept := :v_nomDept;
        IF func_comprv_dept(LOWER(var_nomDept)) THEN
            OPEN curs_emp(LOWER(var_nomDept));
                LOOP
                    FETCH curs_emp INTO var_employee;
                    EXIT WHEN NOT FOUND;
                    RAISE NOTICE 'L`empleat %,%, amb id % serà eliminat.', var_employee.first_name, var_employee.last_name, var_employee.employee_id;
                    DELETE FROM employees WHERE employee_id = var_employee.employee_id;
                end loop;
        ELSE
            RAISE EXCEPTION 'No existeix el departament amb nom: %', var_nomDept;
        end if;
    end;
    $$;

--funcio
CREATE OR REPLACE FUNCTION func_comprv_dept(par_nomDept departments.department_name%type) RETURNS boolean language plpgsql
AS $$
    DECLARE
        var_numsDept real;
    BEGIN
        SELECT COUNT(*) INTO var_numsDept FROM departments WHERE department_name = par_nomDept;
        IF var_numsDept > 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    end;
    $$;

call proc_elim_nous_emps();

/*EX2*/
--Creacio taules
CREATE TABLE canvis_locations (
id INT GENERATED ALWAYS AS IDENTITY,
location_id numeric(11) NOT NULL,
city_old VARCHAR(30) NOT NULL,
city_new VARCHAR(30) not null,
changed_on TIMESTAMP(6) NOT NULL);

CREATE TABLE canvis (
id serial,
timestamp_ TIMESTAMP WITH TIME ZONE default NOW(),
nom_trigger text,
tipus_trigger text,
nivell_trigger text,
ordre text );

--funcio trigger1
CREATE OR REPLACE FUNCTION func_registrar_canvis_loc() RETURNS TRIGGER LANGUAGE plpgsql
AS $$
    BEGIN
        IF NEW.city <> OLD.city THEN
            INSERT INTO canvis_locations (location_id, city_old, city_new, changed_on)
            VALUES (NEW.location_id, OLD.city, NEW.city, NOW());
        end if;
        RETURN NEW;
    END;
    $$;

--trigger
CREATE OR REPLACE TRIGGER trig_registrar_canvis_loc
    BEFORE UPDATE
    ON locations
    FOR EACH ROW
    EXECUTE FUNCTION func_registrar_canvis_loc();

--funcio trigger2
CREATE OR REPLACE FUNCTION func_registrar_canvis() RETURNS TRIGGER LANGUAGE plpgsql
AS $$
    BEGIN
        INSERT INTO canvis(nom_trigger, tipus_trigger, nivell_trigger, ordre)
        VALUES(TG_NAME, TG_OP, TG_LEVEL, '');
        RETURN NEW;
    END;
    $$;

--trigger2
CREATE OR REPLACE TRIGGER trig_gravar_operacion
    BEFORE UPDATE
    ON locations
    FOR EACH STATEMENT
    EXECUTE FUNCTION func_registrar_canvis();

/*
Joc de proves
*/
UPDATE locations
SET city = 'Barcelona', street_address = '113 Passeig de Gràcia'
WHERE location_id = 1000;

UPDATE locations
SET street_address = '20 Carrer Valencia'
WHERE location_id = 1000;

SELECT * FROM canvis_locations;
/*
OUTPUT:
id | location_id | city_old | city_new | changed_on
1       1000        Roma      Barcelona 2026-05-11 10:23:10.591917
*/

SELECT * FROM canvis;
/*
OUTPUT:
id  |   timestamp_                      |   nom_trigger         |   tipus_trigger   |   nivell_trigger
2    2026-05-11 10:23:10.591917 +00:00   trig_gravar_operacion      UPDATE              STATEMENT
3    2026-05-11 10:23:24.266084 +00:00   trig_gravar_operacion      UPDATE              STATEMENT
*/

/*
EX3
*/
--Tipus de dada per guardar dades vitals d'un empleat
CREATE TYPE dades_emp_type AS (
    id real,
    nom text,
    cognom text
);

--Procediment que imprimeix les dades de l'empleat mes antic
CREATE OR REPLACE PROCEDURE proc_mostrar_empt_dept (par_nom_dept departments.department_name%type) language plpgsql
AS $$
    DECLARE
        var_dadesEmp dades_emp_type;
    BEGIN
        IF func_comprv_dept(par_nom_dept) THEN
            var_dadesEmp := func_emp_mes_antic(par_nom_dept);
            RAISE NOTICE 'L`empleat més antic del % té l`ID
%i es diu %', par_nom_dept, var_dadesEmp.id, CONCAT(var_dadesEmp.nom, ' ', var_dadesEmp.cognom);
        ELSE
            RAISE EXCEPTION 'El departament amb nom: % no existeix', par_nom_dept;
        end if;

    END;
    $$;


--Funcio que comprova si el nom del departament existeix o no
CREATE OR REPLACE FUNCTION func_comprv_dept(par_nomDept departments.department_name%type) RETURNS boolean language plpgsql
AS $$
    DECLARE
        var_numsDept real;
    BEGIN
        SELECT COUNT(*) INTO var_numsDept FROM departments WHERE LOWER(department_name) = LOWER(par_nomDept);
        IF var_numsDept > 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END;
    $$;

--Funcio per retornar empleat mes antic

CREATE OR REPLACE FUNCTION func_emp_mes_antic(par_nomDept departments.department_name%type) RETURNS dades_emp_type LANGUAGE plpgsql
AS $$
    DECLARE
        var_dadesEmp dades_emp_type;
    BEGIN
       SELECT e.employee_id, e.first_name, e.last_name
        INTO var_dadesEmp
        FROM employees e
        JOIN departments d ON d.department_id = e.department_id
        WHERE LOWER(d.department_name) = LOWER(par_nomDept)
        ORDER BY e.hire_date ASC
        LIMIT 1;
        RETURN var_dadesEmp;
    END;
    $$;

/*
Joc de proves
*/
call proc_mostrar_empt_dept('IT');
--L`empleat més antic del IT té l`ID
--103i es diu Alexander Hunold
call proc_mostrar_empt_dept('Shipping');
--L`empleat més antic del Shipping té l`ID
--122i es diu Payam Kaufling
call proc_mostrar_empt_dept('fakeDept');
--[P0001] ERROR: El departament amb nom: fakeDept no existeix Where: PL/ pgSQL function proc_mostrar_empt_dept(character varying) line 10 at RAISE