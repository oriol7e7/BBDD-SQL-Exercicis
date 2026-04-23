--EX1
CREATE OR REPLACE PROCEDURE proc_baixa_emp(id employees_copy.employee_id%type) AS $$
    BEGIN
        DELETE FROM employees WHERE employee_id = id;
    END;
    $$ LANGUAGE plpgsql;


DO $$
DECLARE
    input employees.employee_id%type := :input_id::integer;
BEGIN
    CALL proc_baixa_emp(input);
END;
$$;


--EX2
CREATE OR REPLACE FUNCTION func_num_emp(deptId employees.department_id%type) RETURNS integer AS $$
    DECLARE
        v_count integer;
    BEGIN
        SELECT count(*) INTO v_count FROM employees WHERE department_id = deptId;
        RETURN v_count;
    END;
    $$ LANGUAGE plpgsql;


DO $$
DECLARE
    input employees.department_id%type := :input::integer;
    v_result integer;
BEGIN
    v_result := func_num_emp(input_dept);
    raise notice '%', v_result;
END;
$$;


--EX3
CREATE OR REPLACE FUNCTION func_cost_dept(deptId employees.department_id%type) RETURNS numeric AS $$
    DECLARE
        v_cost numeric;
    BEGIN
        SELECT sum(salary) INTO v_cost FROM employees WHERE department_id = deptId;
        RETURN v_cost;
    END;
    $$ LANGUAGE plpgsql;


DO $$
DECLARE
    input_dept employees.department_id%type := :input_dept::integer;
    v_result numeric;
BEGIN
    v_result := func_cost_dept(input_dept);
    raise notice '%', v_result;
END;
$$;


--EX4
CREATE OR REPLACE PROCEDURE proc_mod_com(id employees.employee_id%type) AS $$
    DECLARE
        v_salary employees.salary%type;
    BEGIN
        SELECT salary INTO v_salary FROM employees WHERE employee_id = id;

        CASE
            WHEN v_salary < 3000 THEN
                UPDATE employees SET commission_pct = 0.1 WHERE employee_id = p_id;
            WHEN v_salary >= 3000 AND v_salary <= 7000 THEN
                UPDATE employees SET commission_pct = 0.15 WHERE employee_id = p_id;
            WHEN v_salary > 7000 THEN
                UPDATE employees SET commission_pct = 0.2 WHERE employee_id = p_id;
        END CASE;
    END;
    $$ LANGUAGE plpgsql;


DO $$
DECLARE
    input_id employees.employee_id%type := :input_id::integer;
BEGIN
    CALL proc_mod_com(input_id);
END;
$$;