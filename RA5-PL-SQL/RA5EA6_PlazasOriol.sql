/*
EX1
*/
--PROCEDIMENT
CREATE OR REPLACE PROCEDURE proc_alta_dept(par_id departments.department_id%type, par_name departments.department_name%type, par_managerId departments.manager_id%type, par_locationId departments.location_id%type) AS $$
BEGIN
    INSERT INTO departments(department_id, department_name, manager_id, location_id) VALUES(par_id, par_name, par_managerId, par_locationId);
    raise notice 'success';
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error general';
END;
    $$ LANGUAGE plpgsql;


--EXECUCIO
do $$
DECLARE
    var_id departments.department_id%type := :v_id;
    var_name departments.department_name%type := :v_name;
    var_manager departments.manager_id%type := :v_manager;
    var_loc departments.location_id%type := :v_loc;
BEGIN
    IF(func_compv_dept(var_id)) THEN
        RAISE NOTICE 'El departament ja existeix';
    ELSE
        IF(func_comprovar_mng(var_manager) AND func_comprovar_loc(var_loc)) THEN
            CALL proc_alta_dept(var_id, var_name, var_manager, var_loc);        
        ELSE
            RAISE NOTICE 'El manager o localització no existeixen';
        END IF;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error general';
END;
    $$ LANGUAGE plpgsql;

--JOC DE PROVES
/*
CODIS ERRONIS - Output: El manager o localització no existeixen / El departament ja existeix
CODIS EXISTENTS - Output: success
*/


/*
EX 2
*/
--FUNCIO
create or replace function func_nom_emp(par_id employees.employee_id%type) RETURNS employees.first_name%type AS $$
    DECLARE
        var_nomEmpleat employees.first_name%type;
    BEGIN
        SELECT employees.first_name
        INTO STRICT var_nomEmpleat
        FROM employees
        WHERE employee_id = par_id;
        RETURN var_nomEmpleat;
    END;
    $$ LANGUAGE plpgsql;

--EXECUCIO
do $$
DECLARE
    var_id employees.employee_id%type := :v_id;
    var_nomEmpleat employees.first_name%type;
BEGIN
    var_nomEmpleat := func_nom_emp(var_id);
    raise notice 'L empleat amb codi % es diu %', var_id, var_nomEmpleat;
EXCEPTION
    WHEN SQLSTATE 'P0002' THEN
        RAISE NOTICE 'Error, no s ha trobar cap empleat amb id %', var_id;
    WHEN OTHERS THEN
        RAISE NOTICE 'Error Generar';
END;
    $$ LANGUAGE plpgsql;

--JOC DE PROVES
/*
Empleat amb codi 35 - Output: Error, no s ha trobar cap empleat amb id 35
Empleat amb codi 167 - Output: L empleat amb codi 167 es diu Amit
*/