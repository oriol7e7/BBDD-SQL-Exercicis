--EX1
DO $$
DECLARE
    var_num1 NUMERIC := :v_num1::NUMERIC;
    var_num2 INTEGER := :v_num2::INTEGER;
    var_result NUMERIC := 1;
BEGIN
    IF var_num1 <= 0 OR var_num2 <= 0 THEN
        RAISE NOTICE 'Error: Els numeros han de ser positius.';
    ELSE
        FOR i IN 1..var_num2 LOOP
            var_result := var_result * var_num1;
        END LOOP;

        RAISE NOTICE 'El resultat és: %', var_result;
    END IF;
END;
$$;

--EX2
CREATE OR REPLACE FUNCTION func_checkP(par_radi NUMERIC) RETURNS BOOLEAN AS $$
BEGIN
    IF par_radi > 0 THEN
        RETURN TRUE;
    ELSE
        RAISE NOTICE 'Recorda que el número ha de ser positiu!!!';
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_calculArea(par_radi NUMERIC) RETURNS NUMERIC AS $$
DECLARE
    var_pi CONSTANT NUMERIC := 3.1416;
    var_area NUMERIC := 0;
BEGIN
    IF func_checkP(par_radi) THEN
        var_area := (par_radi * par_radi) * var_pi;
    END IF;
    
    RETURN var_area;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    var_radi NUMERIC := :v_radi::NUMERIC;
    var_area NUMERIC;
BEGIN
    var_area := func_calculArea(var_radi);
    
    IF var_area > 0 THEN
        RAISE NOTICE 'Àrea de la circumferència de radi % és %', var_radi, var_area;
    END IF;
END;
$$;


--EX3
CREATE OR REPLACE FUNCTION func_nom_manager(par_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE) RETURNS EMPLOYEES.FIRST_NAME%TYPE AS $$
DECLARE
    var_nom_manager EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    SELECT E.FIRST_NAME INTO var_nom_manager 
    FROM DEPARTMENTS D 
    JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID 
    WHERE D.DEPARTMENT_ID = par_dept_id;
    
    RETURN var_nom_manager;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    var_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE := :v_dept_id::INTEGER;
    var_nom_manager EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    var_nom_manager := func_nom_manager(var_dept_id);
    RAISE NOTICE 'Mànager: %', var_nom_manager;
END;
$$;


--EX4
CREATE OR REPLACE PROCEDURE proc_dades_empl(par_emp_id EMPLOYEES.EMPLOYEE_ID%TYPE) AS $$
DECLARE
    reg_emp RECORD;
BEGIN
    SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, D.LOCATION_ID 
    INTO reg_emp
    FROM EMPLOYEES E
    JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE E.EMPLOYEE_ID = par_emp_id;

    RAISE NOTICE 'Nom: % | Cognom: % | Departament: % | Localitat: %', 
                 reg_emp.FIRST_NAME, reg_emp.LAST_NAME, reg_emp.DEPARTMENT_NAME, reg_emp.LOCATION_ID;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    var_emp_id EMPLOYEES.EMPLOYEE_ID%TYPE := :v_emp_id::INTEGER;
BEGIN
    CALL proc_dades_empl(var_emp_id);
END;
$$;


--EX5
CREATE OR REPLACE PROCEDURE proc_alta_pais(par_country_id COUNTRIES.COUNTRY_ID%TYPE, par_country_name COUNTRIES.COUNTRY_NAME%TYPE, par_region_name REGIONS.REGION_NAME%TYPE) AS $$
DECLARE
    var_region_id REGIONS.REGION_ID%TYPE;
    reg_country COUNTRIES%ROWTYPE;
BEGIN
    SELECT REGION_ID INTO var_region_id 
    FROM REGIONS 
    WHERE REGION_NAME = par_region_name;

    INSERT INTO COUNTRIES (COUNTRY_ID, COUNTRY_NAME, REGION_ID) 
    VALUES (par_country_id, par_country_name, var_region_id);

    SELECT * INTO reg_country 
    FROM COUNTRIES 
    WHERE COUNTRY_ID = par_country_id;

    RAISE NOTICE 'País inserit: %', reg_country.COUNTRY_NAME;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    var_country_id COUNTRIES.COUNTRY_ID%TYPE := :v_country_id::VARCHAR;
    var_country_name COUNTRIES.COUNTRY_NAME%TYPE := :v_country_name::VARCHAR;
    var_region_name REGIONS.REGION_NAME%TYPE := :v_region_name::VARCHAR;
BEGIN
    CALL proc_alta_pais(var_country_id, var_country_name, var_region_name);
END;
$$;