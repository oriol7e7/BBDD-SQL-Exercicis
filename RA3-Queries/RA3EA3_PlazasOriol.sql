--ex1
select e.department_id, e.first_name, e.last_name
from employees as e, departments as d
WHERE d.department_name LIKE 'Sales' AND e.department_id = d.department_id;


--ex2
select d.department_name, e.*
from departments as d, employees as e
where e.department_id = d.department_id AND d.department_name NOT IN('IT', 'PURCHASING');


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
AND EXTRACT(YEAR FROM hire_date) < 1998;