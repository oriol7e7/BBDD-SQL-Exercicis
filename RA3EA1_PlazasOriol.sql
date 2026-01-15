--ex1
SELECT last_name COGNOM, salary salari
FROM employees
WHERE salary>12000;

--ex2
SELECT last_name, department_id
FROM employees
WHERE employee_id = 176


--ex3
SELECT last_name, department_id
FROM employees
WHERE salary NOT BETWEEN 5000 and 12000;

--ex4
SELECT last_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN '1998-02-20' and '1998-05-01'
ORDER BY hire_date;


--ex5
SELECT last_name, department_id
FROM employees
WHERE department_id BETWEEN 20 AND 50
ORDER BY last_name;


--ex6
