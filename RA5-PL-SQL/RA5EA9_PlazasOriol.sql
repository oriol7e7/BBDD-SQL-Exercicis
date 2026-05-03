/*
EX 1
*/

--OPEN, FETCH, CLOSE
DO $$
DECLARE
    var_dept_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    var_location_id DEPARTMENTS.LOCATION_ID%TYPE;
    var_city LOCATIONS.CITY%TYPE;
    dept_cursor CURSOR FOR
        SELECT D.DEPARTMENT_NAME, D.LOCATION_ID, L.CITY
        FROM DEPARTMENTS D
        JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID;
BEGIN
    OPEN dept_cursor;
    LOOP
        FETCH dept_cursor INTO var_dept_name, var_location_id, var_city;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'DEPARTAMENT:';
        RAISE NOTICE '%, %, %', var_dept_name, var_location_id, var_city;
        RAISE NOTICE '=======================';
    END LOOP;
    CLOSE dept_cursor;
END;
$$;

--FOR 
DO $$
DECLARE
    reg_dept RECORD;
BEGIN
    FOR reg_dept IN 
        SELECT D.DEPARTMENT_NAME, D.LOCATION_ID, L.CITY 
        FROM DEPARTMENTS D 
        JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID 
    LOOP
        RAISE NOTICE 'DEPARTAMENT:';
        RAISE NOTICE '%, %, %', reg_dept.DEPARTMENT_NAME, reg_dept.LOCATION_ID, reg_dept.CITY;
        RAISE NOTICE '=======================';
    END LOOP;
END;
$$;


/*
EX 2
*/

--OPEN, FETCH, CLOSE 
DO $$
DECLARE
    reg_emp RECORD;
    emp_cursor CURSOR FOR
        SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
        FROM EMPLOYEES E
        JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO reg_emp;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'EMPLEAT i DEPARTAMENT:';
        RAISE NOTICE '%, %, %, %', reg_emp.EMPLOYEE_ID, reg_emp.FIRST_NAME, reg_emp.DEPARTMENT_ID, reg_emp.DEPARTMENT_NAME;
        RAISE NOTICE '=======================';
    END LOOP;
    CLOSE emp_cursor;
END;
$$;

-- FOR
DO $$
DECLARE
    reg_emp RECORD;
BEGIN
    FOR reg_emp IN 
        SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME 
        FROM EMPLOYEES E 
        JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
    LOOP
        RAISE NOTICE 'EMPLEAT i DEPARTAMENT:';
        RAISE NOTICE '%, %, %, %', reg_emp.EMPLOYEE_ID, reg_emp.FIRST_NAME, reg_emp.DEPARTMENT_ID, reg_emp.DEPARTMENT_NAME;
        RAISE NOTICE '=======================';
    END LOOP;
END;
$$;