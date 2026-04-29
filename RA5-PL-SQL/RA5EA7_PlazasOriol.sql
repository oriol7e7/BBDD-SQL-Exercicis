/*
EXERCICI 1
*/

--EXECUCIO
DO $$
DECLARE
    var_id DEPARTMENTS.DEPARTMENT_ID%TYPE := :v_id;
    var_nomdept DEPARTMENTS.DEPARTMENT_NAME%TYPE;
BEGIN
    SELECT DEPARTMENT_NAME
    INTO STRICT var_nomdept
    FROM DEPARTMENTS
    WHERE DEPARTMENT_ID = var_id;

    RAISE NOTICE 'Departament: %', var_nomdept;

    IF (var_nomdept LIKE 'A%') THEN
        RAISE NOTICE 'COMENÇA PER LA LLETRA A';
    ELSE
        RAISE NOTICE 'NO COMENÇA PER LA LLETRA A';
    END IF;
EXCEPTION
    WHEN SQLSTATE 'P0002' THEN
        RAISE NOTICE 'ERROR: no dades';
    WHEN SQLSTATE 'P0003' THEN
        RAISE NOTICE 'ERROR: retorna més files';
    WHEN OTHERS THEN
        RAISE NOTICE 'ERROR (sense definir)';
END;
$$ LANGUAGE plpgsql;

--JOC DE PROVES
/*
Departament amb codi 9999 (No existeix) - Output: ERROR: no dades
Departament amb codi 10 (Administration) - Output: Departament: Administration / COMENÇA PER LA LLETRA A
Departament amb codi 20 (Marketing) - Output: Departament: Marketing / NO COMENÇA PER LA LLETRA A
*/

/*
EXERCICI 2
*/

--FUNCIO
CREATE OR REPLACE FUNCTION func_comprovar_loc(par_id LOCATIONS.LOCATION_ID%TYPE) RETURNS BOOLEAN AS $$
DECLARE
    var_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO var_count
    FROM LOCATIONS
    WHERE LOCATION_ID = par_id;

    IF (var_count > 0) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

--PROCEDIMENT
CREATE OR REPLACE PROCEDURE proc_loc_address(par_id LOCATIONS.LOCATION_ID%TYPE, par_address LOCATIONS.STREET_ADDRESS%TYPE) AS $$
BEGIN
    UPDATE LOCATIONS
    SET STREET_ADDRESS = par_address
    WHERE LOCATION_ID = par_id;
EXCEPTION
    WHEN OTHERS THEN
    RAISE EXCEPTION 'Error general al procediment';
END;
$$ LANGUAGE plpgsql;

--EXECUCIO
DO $$
DECLARE
    var_id LOCATIONS.LOCATION_ID%TYPE := :v_id;
    var_address LOCATIONS.STREET_ADDRESS%TYPE := :v_address;
BEGIN
    IF (func_comprovar_loc(var_id)) THEN
        CALL proc_loc_address(var_id, var_address);
        RAISE NOTICE 'Adreça modificada amb exit';
    ELSE
        RAISE NOTICE 'La localitzacio no existeix';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error general a l execucio';
END;
$$ LANGUAGE plpgsql;

--JOC DE PROVES
/*
Localització amb codi 9999 i adreça 'Carrer Nou 1' - Output: La localitzacio no existeix
Localització amb codi 1700 i adreça 'Carrer Nou 1' - Output: Adreça modificada amb exit
*/