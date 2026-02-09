SELECT initcap(e.first_name), initcap(e.last_name)
FROM employees as e;

SELECT initcap(e.first_name), initcap(e.last_name), e.hire_date
FROM employees as e
WHERE EXTRACT(MONTH FROM hire_date) = 5;

SELECT job_title
FROM jobs;