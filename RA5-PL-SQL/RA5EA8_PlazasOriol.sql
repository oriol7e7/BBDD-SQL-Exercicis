/*
EX1
*/

--FOR IN
DO $$
DECLARE
    var_emp employees%ROWTYPE;
BEGIN
    FOR var_emp IN SELECT * FROM employees LOOP
        RAISE NOTICE 'EMPLEAT:';
        RAISE NOTICE '%, %, %, %, %', var_emp.employee_id, var_emp.first_name, var_emp.salary, COALESCE(var_emp.commission_pct, 0), var_emp.hire_date;
        RAISE NOTICE '=======================';
        END LOOP;
END;
$$;

--OPEN - FETCH - CLOSE
DO $$
DECLARE
    var_emp employees%ROWTYPE;
    emp_cursor CURSOR FOR
    SELECT *
    FROM employees;
BEGIN
    OPEN emp_cursor;
        LOOP
            FETCH emp_cursor INTO var_emp;
            EXIT WHEN NOT FOUND;
            RAISE NOTICE 'EMPLEAT:';
            RAISE NOTICE '%, %, %, %, %', var_emp.employee_id, var_emp.first_name, var_emp.salary, COALESCE(var_emp.commission_pct, 0), var_emp.hire_date;
            RAISE NOTICE '=======================';
        END LOOP;
    CLOSE emp_cursor;
END;
$$;

/*
EX2
*/

--FUNCIO CONTROL NEGATIUS
CREATE OR REPLACE function func_control_neg(num real) returns bool as $$
    BEGIN
        IF num<0 THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    END;
$$ language plpgsql;


--OPEN - FETCH - CLOSE
DO $$
DECLARE
    var_emp employees%ROWTYPE;
    var_salary real;
    emp_cursor CURSOR (par_salary real) FOR
    SELECT *
    FROM employees
    WHERE salary>par_salary;
BEGIN
    var_salary := :v_salary;
    IF(func_control_neg(var_salary)) THEN
        OPEN emp_cursor(var_salary);
            LOOP
                FETCH emp_cursor INTO var_emp;
                EXIT WHEN NOT FOUND;
                RAISE NOTICE 'EMPLEAT:';
                RAISE NOTICE '%, %, %', var_emp.employee_id, var_emp.first_name, var_emp.salary;
                RAISE NOTICE '=======================';
            END LOOP;
        CLOSE emp_cursor;
    ELSE
        RAISE NOTICE 'ERROR: salari negatiu i ha de ser positiu';
    END IF;
END;
$$;

--FOR IN

DO $$
DECLARE
    var_emp employees%ROWTYPE;
    var_salary real;
    emp_cursor CURSOR (par_salary real) FOR
    SELECT *
    FROM employees
    WHERE salary>par_salary;
BEGIN
    var_salary := :v_salary;
    IF(func_control_neg(var_salary)) THEN
        FOR var_emp in emp_cursor(var_salary) LOOP
            RAISE NOTICE 'EMPLEAT:';
            RAISE NOTICE '%, %, %', var_emp.employee_id, var_emp.first_name, var_emp.salary;
            RAISE NOTICE '=======================';
            END LOOP;
    ELSE
        RAISE NOTICE 'ERROR: salari negatiu i ha de ser positiu';
    END IF;
END;
$$;
