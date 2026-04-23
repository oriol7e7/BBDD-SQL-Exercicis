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

--EX3
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

--EX4
CREATE OR REPLACE PROCEDURE PROC_ALTA_JOB(p_job_id jobs.job_id%type, p_job_title jobs.job_title%type, p_min_salary jobs.min_salary%type, p_max_salary jobs.max_salary%type) AS $$
    BEGIN
        IF p_min_salary >= 0 AND p_max_salary >= 0 AND p_min_salary < p_max_salary THEN
            INSERT INTO jobs (job_id, job_title, min_salary, max_salary) 
            VALUES (p_job_id, p_job_title, p_min_salary, p_max_salary);
        ELSE
            IF p_min_salary < 0 OR p_max_salary < 0 THEN
                RAISE NOTICE 'Error: El salari minim i maxim no poden ser negatius.';
            END IF;

            IF p_min_salary >= p_max_salary THEN
                RAISE NOTICE 'Error: El salari minim ha de ser mes petit que el salari maxim.';
            END IF;
        END IF;
    END;
    $$ LANGUAGE plpgsql;


DO $$
DECLARE
    input_id jobs.job_id%type := :input_id::varchar;
    input_title jobs.job_title%type := :input_title::varchar;
    input_min numeric := :input_min::numeric;
    input_max numeric := :input_max::numeric;
BEGIN
    CALL PROC_ALTA_JOB(input_id, input_title, input_min, input_max);
END;
$$;