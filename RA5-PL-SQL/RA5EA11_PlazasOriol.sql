/*
EX1
*/

--FUNCIO DEL TRIGGER
CREATE OR REPLACE FUNCTION func_department_not_null () RETURNS TRIGGER LANGUAGE plpgsql AS
    $$
    BEGIN
        IF NEW.department_name IS NULL THEN
            RAISE EXCEPTION 'El nom del departament no pot ser null';
        END IF;
        RETURN NEW;
    END;
    $$;

--TRIGGER
CREATE OR REPLACE TRIGGER trig_nom_departament_notnull
    BEFORE INSERT
    ON departments
    FOR EACH ROW
    EXECUTE FUNCTION func_department_not_null();

--JOC DE PROVES
/*
Insert amb valor null
OUTPUT: ERROR: El nom del departament no pot ser null

Insert amb valor correcte
Sense errors
*/

/*
EX2
*/

--FUNCIO DEL TRIGGER 
CREATE OR REPLACE FUNCTION func_check_restriccions_empleats() RETURNS TRIGGER LANGUAGE plpgsql
AS $$
    BEGIN
       IF TG_OP = 'INSERT' THEN
         IF NEW.salary < 0 THEN
             RAISE EXCEPTION 'L empleat no pot tindre salari negatiu';
         END IF;
       ELSIF TG_OP = 'UPDATE' THEN
           IF NEW.salary != OLD.salary THEN
               IF OLD.commission_pct IS NULL THEN
                   RAISE EXCEPTION 'No es pot modificar el salari ja que l empleat no te comission pct';
               ELSIF OLD.salary > NEW.salary THEN
                   RAISE EXCEPTION 'El salari nomes es pot incrementar';
               END IF;
           END IF;
       END IF;
       RETURN NEW;
    END;
    $$;

--TRIGGER
CREATE OR REPLACE TRIGGER trig_restriccions_emp
    BEFORE INSERT OR UPDATE
    ON employees
    FOR EACH ROW
    EXECUTE FUNCTION func_check_restriccions_empleats();

--JOC DE PROVES
/*
Insert amb salari negatiu
OUTPUT: ERROR: L empleat no pot tindre salari negatiu

Insert amb salari positiu i sense comissio
Sense errors

Update amb empleat sense comissio
OUTPUT: ERROR: No es pot modificar el salari ja que l empleat no te comission pct

Update per baixar salari
OUTPUT: ERROR: El salari nomes es pot incrementar

Update per pujar salari i tenint comissio
Sense errors
*/


/*
EX3
*/
--FUNCIO DEL TRIGGER
CREATE OR REPLACE FUNCTION func_check_commission_major() RETURNS TRIGGER LANGUAGE plpgsql
AS $$
    BEGIN
        IF NEW.commission_pct > NEW.salary THEN
           RAISE EXCEPTION 'La comissio es major que el salari';
        END IF;
        RETURN NEW;
    END;
    $$;

--TRIGGER
CREATE OR REPLACE TRIGGER trig_comissio
    BEFORE INSERT
    ON employees
    FOR EACH ROW
    EXECUTE FUNCTION func_check_commission_major();

--JOC DE PROVES
/*
Insert amb commission_pct major que salari
OUTPUT: ERROR: La comissio es major que el salari

Insert amb commission_pct menor que salari
Sense errors
*/


/*
EX 4
*/

--FUNCIO DEL TRIGGER
CREATE OR REPLACE FUNCTION func_check_emp_modificacio() RETURNS TRIGGER LANGUAGE plpgsql
AS $$
    BEGIN
        IF NEW.first_name != OLD.first_name THEN
           RAISE EXCEPTION 'No es pot modificar el nom';
        ELSIF NEW.employee_id != OLD.employee_id THEN
            RAISE EXCEPTION 'No es pot modificar el codi d empleat';
        ELSIF NEW.salary > OLD.salary * 1.10 THEN
            RAISE EXCEPTION 'No es pot pujar el salari mes de un 10 percent';
        END IF;
        RETURN NEW;
    END;
    $$;

--TRIGGER
CREATE OR REPLACE TRIGGER trig_errada_modificacio
    BEFORE UPDATE
    ON employees
    FOR EACH ROW
    EXECUTE FUNCTION func_check_emp_modificacio();

--JOC DE PROVES
/*
Update modificant el first_name
OUTPUT: ERROR: No es pot modificar el nom

Update modificant el employee_id
OUTPUT: ERROR: No es pot modificar el codi d empleat

Update pujant el salari mes d un 10%
OUTPUT: ERROR: No es pot pujar el salari mes de un 10 percent

Update amb canvis correctes (salari pujat menys d un 10%)
Sense errors
*/

/*
EX5
*/

--CREACIO TAULA AUXILIAR
CREATE TABLE RESAUDITAREMP (
    RESULTAT VARCHAR(200)
);


--CREACIO FUNCIO TRIGGER
CREATE OR REPLACE FUNCTION func_log_emp_changes () RETURNS TRIGGER LANGUAGE plpgsql
AS $$
    BEGIN
        INSERT INTO RESAUDITAREMP (RESULTAT) VALUES (CONCAT(NOW(), TG_NAME, TG_WHEN, TG_LEVEL, TG_OP));
        IF TG_OP = 'DELETE' THEN
            RETURN OLD;
        END IF;
        RETURN NEW;
    END;
    $$;


--TRIGGER
CREATE OR REPLACE TRIGGER trig_auditartaulaemp
    BEFORE INSERT OR UPDATE OR DELETE
    ON employees
    FOR EACH ROW
    EXECUTE FUNCTION func_log_emp_changes();

--JOC DE PROVES
/*
INSERCIO I MODIFICACIO DE DADES:
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary)
VALUES (997, 'Joan', 'Puig', 'JPUIG', CURRENT_DATE, 'IT_PROG', 3000);

UPDATE employees SET last_name = 'Colomer' WHERE employee_id = 997;

DELETE FROM employees WHERE employee_id = 997;

RESULTAT TAULA RESAUDITAREMP:
2026-05-04 16:18:32.355604+00trig_auditartaulaempBEFOREROWINSERT
2026-05-04 16:18:38.314995+00trig_auditartaulaempBEFOREROWUPDATE
2026-05-04 16:18:40.54089+00trig_auditartaulaempBEFOREROWDELETE
*/