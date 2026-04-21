--EX1
do $$
    declare
        num1 REAL;
        num2 REAL;
        result Numeric(10,2);
    begin
        num1 := :num1;
        num2 := :num2;
        if num1 < 0 OR num2 <0 then
            raise notice 'Han de ser numeros positius';
        else
            result := num1/num2 + num2;
            raise notice '%', result;
        end if;
    end;
$$

--EX2
do $$
    declare
        num1 REAL;
        num2 REAL;
        result Numeric(10,2);
    begin
        num1 := :num1;
        num2 := :num2;
        if num1 < 0 OR num2 <0 then
            raise notice 'Han de ser numeros positius';
        elsif num2>num1 then
            raise notice 'Error! el primer número ha de ser més gran que el segon.';
        else
            result := num1/num2 + num2;
            raise notice '%', result;
        end if;
    end;
$$


--EX3
do $$
declare
    age INTEGER;
begin
    age := :age;
    case
        when age between 0 and 17 then
            raise notice 'Ets menor';
        when age between 18 and 40 then
            raise notice 'Ja ets major de edat';
        when age > 40 then
            raise notice 'Ja ets força gran';
        when age < 0 then
            raise notice 'La edat no pot ser negativa';
    end case;
end;
$$


--EX4
do $$
declare
    a real;
    b real;
    operation integer;
begin
    a := :a;
    b := :b;
    raise notice 'opció 1 SUMAR, opció 2 RESTAR, opció 3 MULTIPLICAR, opció 4 DIVIDIR .';
    operation := :operation;
    case operation
        when 1 then
            raise notice 'has escollit suma';
            RAISE NOTICE '% + % = %', a, b, a + b;
        when 2 then
            raise notice 'has escollit resta';
            RAISE NOTICE '% - % = %', a, b, a - b;
        when 3 then
            raise notice 'has escollit multiplicacio';
            RAISE NOTICE '% * % = %', a, b, a * b;
        when 4 then
            raise notice 'has escollit divisio';
            RAISE NOTICE '% / % = %', a, b, a / b;
        else
            RAISE NOTICE 'Opcio no valida';
    end case;
end;
$$

--EX5 - FOR LOOP
do $$
declare
    min INTEGER;
    max INTEGER;
begin
    min := 1;
    max := :max;
    if max >= 2 then
        for i in min..max LOOP
            raise notice '%', i;
        end loop;
    end if;
end;
$$

--EX5 - WHILE
do $$
declare
    min INTEGER;
    max INTEGER;
    iterator INTEGER;
begin
    min := 1;
    max := :max;
    iterator := min;
    if max >= 2 then
        WHILE iterator <= max LOOP
        raise notice '%', iterator;
        iterator := iterator+1;
        END LOOP;
    end if;
end;
$$

--EX6
do $$
declare
    vmin integer := :vmin;   
    vmax integer := :vmax;    
    vstep integer := :vstep;  
begin
    if vmin < vmax AND vstep > 1 then
        for i in vmin..vmax by vstep loop
            raise notice '%', i;
        end loop;
    end if;
end;
$$;


