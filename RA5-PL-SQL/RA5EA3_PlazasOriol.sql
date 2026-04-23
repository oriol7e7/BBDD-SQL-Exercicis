--EX1
create or replace function FUNC_DUPLICAR_QUANTITAT(num real) RETURNS real as
    $$
    declare
        result real;
    BEGIN
        result := num*2;
        return result;
    end;
    $$ language plpgsql;


DO $$
DECLARE
    input real := :input::real;
    dupl real;
BEGIN
    dupl := FUNC_DUPLICAR_QUANTITAT(input);
    RAISE NOTICE '%', dupl;
END;
$$;


--EX2
CREATE OR REPLACE FUNCTION FUNC_FACTORIAL(num INTEGER) RETURNS INTEGER AS $$
    DECLARE
        result INTEGER := 1;
    BEGIN
        FOR i IN 1..num LOOP
            result = result * i;
            END LOOP;
        RETURN result;
    END;
    $$ LANGUAGE plpgsql;


DO $$
DECLARE
    input INTEGER := :input::INTEGER;
    fact INTEGER;
BEGIN
    fact := FUNC_FACTORIAL(input);
    RAISE NOTICE 'FACTORIAL: %', fact;
END;
$$;

--EX2
CREATE OR REPLACE PROCEDURE PROC_EMP_INFO(id employees.employee_id%type) AS $$
    DECLARE
        empl employees%rowtype;
        vcarrec jobs.job_title%type;
    BEGIN
        SELECT e.employee_id as codi_empleat, e.first_name as nom_empleat, j.job_title as carrec, e.salary as salari
        INTO empl.employee_id, empl.first_name, vcarrec, empl.salary
        FROM employees e
            JOIN jobs j
                ON e.job_id = j.job_id
        WHERE e.employee_id = id;
    END;
    $$ LANGUAGE plpgsql;


DO $$
DECLARE
    input integer := :input::integer;
BEGIN
    CALL PROC_EMP_INFO(input);
END;
$$;