--ex1
SELECT c.country_name
FROM countries c
WHERE c.region_id = ANY (
    SELECT r.region_id
    FROM regions r
    WHERE r.region_name IN ('Asia', 'Europe')
);


--ex2
SELECT e.last_name
FROM employees e
WHERE e.first_name LIKE 'H%'
AND e.salary > ANY (
    SELECT salary
    FROM employees
    WHERE department_id = 100
);


--ex3
SELECT e.last_name
FROM employees e
WHERE e.department_id NOT IN (
    SELECT d.department_id
    FROM departments d
    WHERE d.department_name IN ('Marketing', 'Sales')
);


--ex4
SELECT e.last_name, e.salary
FROM employees e
WHERE e.salary < (
    SELECT AVG(e2.salary)
    FROM employees e2
);

--ex5
SELECT e.last_name
FROM employees e
WHERE e.department_id <> (
    SELECT d.department_id
    FROM employees d
    WHERE d.first_name = 'Steven'
      AND d.last_name = 'King'
);
