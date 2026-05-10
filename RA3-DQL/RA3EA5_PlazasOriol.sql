--ex1 - JOIN USING
SELECT e.first_name, d.department_name, e.manager_id
FROM employees as e
JOIN departments as d USING(department_id);

--ex1 - JOIN ON
SELECT e.first_name, d.department_name, e.manager_id
FROM employees as e
JOIN departments as d ON d.department_id = e.department_id;

--ex2 JOIN ON
SELECT l.city, d.department_name
FROM locations as l
JOIN departments as d ON d.location_id = l.location_id
WHERE l.location_id = 1400;

--ex2 JOIN USING
SELECT l.city, d.department_name
FROM locations as l
JOIN departments as d USING(location_id)
WHERE l.location_id = 1400;

--ex3
SELECT e.last_name, e.hire_date
from employees as e
JOIN employees as d ON d.last_name = 'Davies'
WHERE e.hire_date > d.hire_date;

--ex4 JOIN USING
SELECT e.first_name, e.last_name, d.department_name, l.city
from employees as e
JOIN departments as d USING(department_id)
JOIN locations as l USING(location_id);

--ex4 JOIN ON 
SELECT e.first_name, e.last_name, d.department_name, l.city
from employees as e
JOIN departments as d ON d.department_id = e.department_id
JOIN locations as l ON l.location_id = d.location_id;

--ex5
SELECT e.department_id AS "Num departament", e.last_name as Empleat, c.last_name as Company
from employees as e
JOIN employees as c ON c.department_id = e.department_id --nomes agafo els camps con el department_id sigui el mateix, tambe es podria posar al where
WHERE e.employee_id != c.employee_id;