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
SELECT last_name, hire_date
FROM employees
WHERE hire_date BETWEEN DATE '1998-01-01' AND DATE '1998-12-31';


--ex7
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NULL;

--ex8
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;


--ex9
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';


--ex10
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%' and last_name LIKE '%e%';


--ex11
SELECT last_name, job_id, salary
FROM employees
WHERE (job_id = 'AC_ACCOUNT' or job_id = 'AD_ASST') AND salary NOT IN (2500, 3500, 7000);
