--ex1
SELECT d.department_id, e.job_id, count(e.employee_id)
FROM departments as d
JOIN employees as e ON e.department_id = d.department_id
GROUP BY d.department_id, e.job_id;

--ex2
SELECT d.department_name, count(e.employee_id)
FROM departments as d
JOIN employees as e ON e.department_id = d.department_id
GROUP BY d.department_id;

--ex3
SELECT d.department_name, count(e.employee_id)
FROM employees as e
JOIN departments as d ON e.department_id = d.department_id
WHERE upper(d.department_name) = 'SALES'
GROUP BY d.department_name;

--ex4
SELECT l.city, count(d.department_id)
FROM departments as d
JOIN locations as l ON l.location_id = d.location_id
WHERE UPPER(l.city) = 'SEATTLE'
GROUP BY l.city;

--ex5
SELECT m.first_name, SUM(e.salary)
FROM employees as e
JOIN employees as m ON e.manager_id = m.employee_id
GROUP BY m.employee_id, m.first_name
HAVING AVG(e.salary) > 5000;

--ex6
SELECT m.first_name, count(e.employee_id) AS "Num empleats al carrec", MAX(e.salary) as "Salari maxim"
FROM employees as e
JOIN employees as m ON e.manager_id = m.employee_id
GROUP BY m.employee_id, m.first_name
HAVING count(*) > 6;

--ex7
SELECT m.first_name, count(e.employee_id) AS "Num empleats al carrec", MAX(e.salary) as "Salari maxim"
FROM employees as e
JOIN employees as m ON e.manager_id = m.employee_id
WHERE m.employee_id IN(100, 121, 122)
GROUP BY m.employee_id, m.first_name
HAVING count(*) > 6
ORDER BY m.manager_id;