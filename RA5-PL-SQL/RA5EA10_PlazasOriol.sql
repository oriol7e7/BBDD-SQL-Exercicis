/*
EX1
*/

--OPEN - FETCH - CLOSE
DO $$
DECLARE
    var_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE;
    reg_emp RECORD;
    curs_emp CURSOR (par_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE) FOR
        SELECT EMPLOYEE_ID, LAST_NAME
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = par_dept_id;
BEGIN
    var_dept_id := :v_dept_id;
    OPEN curs_emp(var_dept_id);
        LOOP
            FETCH curs_emp INTO reg_emp;
            EXIT WHEN NOT FOUND;
            RAISE NOTICE 'EMPLEAT:';
            RAISE NOTICE '%, %', reg_emp.EMPLOYEE_ID, reg_emp.LAST_NAME;
            RAISE NOTICE '=======================';
        END LOOP;
    CLOSE curs_emp;
END;
$$;


/*
EX2
*/

--FUNCIO COMPROVAR DEPARTAMENT
CREATE OR REPLACE FUNCTION func_comp_dep(par_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE) RETURNS BOOL AS $$
DECLARE
    var_count INT;
BEGIN
    SELECT COUNT(*) INTO var_count FROM DEPARTMENTS WHERE DEPARTMENT_ID = par_dept_id;
    IF var_count > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

--FOR IN
DO $$
DECLARE
    var_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE;
    reg_emp RECORD;
    curs_emp CURSOR (par_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE) FOR
        SELECT EMPLOYEE_ID, LAST_NAME
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = par_dept_id;
BEGIN
    var_dept_id := :v_dept_id;
    IF func_comp_dep(var_dept_id) THEN
        FOR reg_emp IN curs_emp(var_dept_id) LOOP
            RAISE NOTICE 'EMPLEAT:';
            RAISE NOTICE '%, %', reg_emp.EMPLOYEE_ID, reg_emp.LAST_NAME;
            RAISE NOTICE '=======================';
        END LOOP;
    ELSE
        RAISE NOTICE 'El departament no existeix!';
    END IF;
END;
$$;


/*
EX3
*/

--FUNCIO RETORNAR EMPLEATS DEPARTAMENT
CREATE OR REPLACE FUNCTION func_emps_dep(par_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE) RETURNS SETOF EMPLOYEES AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = par_dept_id;
END;
$$ LANGUAGE plpgsql;


/*
EX4
*/

--Creació de la nova taula
--CREATE TABLE EMP_NOU_SALARY AS SELECT * FROM EMPLOYEES;

--OPEN - FETCH - CLOSE
DO $$
DECLARE
    var_nou_salari REAL;
    reg_emp RECORD;
    curs_emps CURSOR FOR
        SELECT EMPLOYEE_ID, LAST_NAME, SALARY
        FROM EMP_NOU_SALARY;
BEGIN
    OPEN curs_emps;
        LOOP
            FETCH curs_emps INTO reg_emp;
            EXIT WHEN NOT FOUND;
            var_nou_salari := reg_emp.SALARY * 1.18;
            RAISE NOTICE 'El salari antic de l`empleat % era % i el nou salari serà: %', reg_emp.LAST_NAME, reg_emp.SALARY, var_nou_salari;
            
            UPDATE EMP_NOU_SALARY
            SET SALARY = var_nou_salari
            WHERE EMPLOYEE_ID = reg_emp.EMPLOYEE_ID;
            
        END LOOP;
    CLOSE curs_emps;
END;
$$;


/*
EX5
*/

--OPEN - FETCH - CLOSE
DO $$
DECLARE
    var_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE;
    reg_emp RECORD;
    curs_emps CURSOR (par_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE) FOR
        SELECT EMPLOYEE_ID, COMMISSION_PCT
        FROM EMP_NOU_SALARY
        WHERE DEPARTMENT_ID = par_dept_id;
BEGIN
    var_dept_id := :v_dept_id;
    OPEN curs_emps(var_dept_id);
        LOOP
            FETCH curs_emps INTO reg_emp;
            IF NOT FOUND THEN
                RAISE NOTICE 'El departament % ja no té més empleats', var_dept_id;
                EXIT;
            END IF;
            
            IF reg_emp.COMMISSION_PCT IS NOT NULL THEN
                UPDATE EMP_NOU_SALARY
                SET COMMISSION_PCT = COMMISSION_PCT + 0.20
                WHERE EMPLOYEE_ID = reg_emp.EMPLOYEE_ID;
            ELSE
                UPDATE EMP_NOU_SALARY
                SET COMMISSION_PCT = 0
                WHERE EMPLOYEE_ID = reg_emp.EMPLOYEE_ID;
            END IF;
            
        END LOOP;
    CLOSE curs_emps;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'S`ha produït un error.';
END;
$$;


/*
EX6
*/

--Creació de la nova taula
--CREATE TABLE EMP_WITH_COMISS AS SELECT * FROM EMPLOYEES;

--FOR IN
DO $$
DECLARE
    reg_emp RECORD;
    curs_emps CURSOR FOR
        SELECT EMPLOYEE_ID
        FROM EMP_WITH_COMISS
        WHERE COMMISSION_PCT IS NULL;
BEGIN
    FOR reg_emp IN curs_emps LOOP
        DELETE FROM EMP_WITH_COMISS
        WHERE EMPLOYEE_ID = reg_emp.EMPLOYEE_ID;
    END LOOP;
END;
$$;