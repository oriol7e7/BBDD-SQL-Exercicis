--ex1
select e.department_id, e.first_name, e.last_name
from employees as e, departments as d
WHERE d.department_name LIKE 'Sales' AND e.department_id = d.department_id;


--ex2
select d.department_name, e.*
from departments as d, employees as e
where e.department_id = d.department_id AND d.department_name NOT IN('IT', 'PURCHASING');


--ex3
select l.city, d.department_name
from locations as l, departments as d
where l.location_id = d.location_id AND LOWER(d.department_name) LIKE '_u%';

--ex4
select l.city, d.*
from locations as l, departments as d
where l.location_id = d.location_id AND l.postal_code LIKE '98199';

--ex5
select j.job_title, e.*
from jobs as j, employees as e
where j.job_id = e.job_id AND j.job_title LIKE 'Programmer';

--ex6
select c.country_name, r.region_name
from countries as c, regions as r
where c.region_id = r.region_id AND r.region_name IN ('Asia', 'Europe');

--ex7
select d.department_name, e.first_name, e.hire_date as "Data inici contracte", jh.end_date as "Data fi contracte"
from departments as d, employees as e, job_history as jh
WHERE d.department_id = e.department_id 
AND e.employee_id = jh.employee_id 
AND jh.department_id = d.department_id 
AND EXTRACT(YEAR FROM jh.end_date) = 1993;

--ex8
SELECT e.first_name, e.last_name, d.department_name
from employees as e, departments as d, locations as l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id AND LOWER(l.city) LIKE 'seattle';

--ex9
SELECT d.department_name, l.city, c.country_name
FROM departments as d, locations as l, countries as c
WHERE l.country_id = c.country_id AND l.location_id = d.location_id;

--ex10
SELECT e.last_name, e.job_id, m.first_name AS "Nom jefe"
FROM employees as e, employees as m
WHERE e.manager_id = m.employee_id AND e.job_id = m.job_id;         

--ex11
SELECT e.last_name, e.job_id, m.first_name AS "Nom jefe", j.job_title
FROM employees as e, employees as m, jobs as j
WHERE e.manager_id = m.employee_id AND e.job_id = m.job_id AND e.job_id = j.job_id;     
