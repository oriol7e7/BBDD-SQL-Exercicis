--ex1
SELECT initcap(e.first_name), initcap(e.last_name)
FROM employees as e;

--ex2
SELECT initcap(e.first_name), initcap(e.last_name), e.hire_date
FROM employees as e
WHERE EXTRACT(MONTH FROM hire_date) = 5;


--ex3
SELECT DISTINCT job_title
FROM jobs;

--ex4
SELECT count(employees.employee_id), department_id
FROM employees
GROUP BY department_id;

--ex5
SELECT COUNT(e.employee_id)
FROM employees as e
GROUP BY job_id;

--ex6
SELECT region_id, COUNT(country_id)
FROM countries
WHERE region_id IN (1, 2, 3)
GROUP BY region_id;

--ex7
SELECT manager_id, COUNT(employee_id), AVG(salary)
FROM employees
GROUP BY manager_id;

--ex8
SELECT department_id, COUNT(employee_id)
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) > 4;