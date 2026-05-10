--ex1
SELECT d.department_name
FROM departments d
WHERE (
    SELECT AVG(e.salary)
    FROM employees e
    WHERE e.department_id = d.department_id
) >= (
    SELECT AVG(salary)
    FROM employees
);

--ex2
SELECT d.department_name, SUM(e.salary) as "Total salary"
FROM departments d
    JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING SUM(e.salary) >= ALL (
    SELECT SUM(salary)
    FROM employees
    GROUP BY department_id
    )
ORDER BY SUM(e.salary) DESC;

--ex3
SELECT e.first_name, e.last_name, d.department_name, e.hire_date
FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
WHERE (e.department_id, e.hire_date) IN (
    SELECT department_id, MIN(hire_date)
    FROM employees
    GROUP BY department_id
);



--ex4
SELECT DISTINCT d.*
FROM departments d
    JOIN employees e
ON d.department_id = e.department_id
WHERE e.employee_id IN (
    SELECT j.employee_id
    FROM job_history j
WHERE j.end_date BETWEEN '1992-01-01' AND '2001-12-31'
);