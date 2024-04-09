-- Creating and Utilizing the dtabase 'ETL_Process':
CREATE DATABASE ETL_PROCESS;
USE ETL_PROCESS;

-- Imported CSV files into MySQL database.
-- Emp.csv
-- City.csv
-- Dept.csv

-- Retrieving Tables ( Emp, City, Dept ) :
SELECT * FROM Emp; 
SELECT * FROM City;
SELECT * FROM Dept;

-- Combining unstructured tables using LEFT JOIN to ensure all records in Emp table should be present :
SELECT e.emp_id, e.emp_name, e.gender, e.hired_date, c.city_name, d.dept_name, e.rewards, e.monthly_salary
FROM emp e
LEFT JOIN City c ON e.emp_city_id = c.city_id
LEFT JOIN Dept d ON e.emp_dept_id = d.dept_id
ORDER BY e.emp_id;

-- Creating view table for combined result-set :
CREATE VIEW vw_emp_data AS
SELECT e.emp_id, e.emp_name, e.gender, e.hired_date, c.city_name, d.dept_name, e.rewards, e.monthly_salary
FROM emp e
LEFT JOIN City c ON e.emp_city_id = c.city_id
LEFT JOIN Dept d ON e.emp_dept_id = d.dept_id
ORDER BY e.emp_id;