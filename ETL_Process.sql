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

-- Retrieving view table vw_emp_data :
SELECT * FROM vw_emp_data; 

-- Creating User-Defined Function for capitalizing First Letter of each word :
USE ETL_PROCESS;
DELIMITER $$
CREATE FUNCTION CAPITALIZE(STR TEXT)
RETURNS TEXT
DETERMINISTIC
BEGIN
	DECLARE RESULT TEXT;
    DECLARE I INT;
    SET STR = LCASE(STR);
	SET RESULT = UPPER(LEFT(STR,1));
    SET I = 2;
    
    WHILE I <= LENGTH(STR) DO
		IF SUBSTRING(STR, I - 1, 1) IN (' ' ,'-','_') THEN
			SET RESULT = CONCAT (RESULT, UPPER(SUBSTRING(STR, I, 1)));
		ELSE 
			SET RESULT = CONCAT(RESULT, SUBSTRING(STR, I, 1));
		END IF;
        SET I = I + 1;
	END WHILE;
    RETURN RESULT;
END$$

-- Transforming and Cleaning unstructured data to structured data :
SELECT DISTINCT
	emp_id,
    CAPITALIZE(emp_name) AS emp_name,
    IF(gender = 'm', 'Male', 'Female') AS gender,
    hired_date,
    CAPITALIZE(city_name) AS city_name,
    CAPITALIZE(dept_name) AS dept_name,
    IFNULL(IF(rewards IN ('n/a', 'not applicable'), null, rewards), 0) AS rewards,
    TRIM(REPLACE(monthly_salary, '?','')) AS monthly_salary
FROM vw_emp_data
ORDER BY emp_id;

-- Creating View Table for transformed result set :
CREATE VIEW vw_emp_info AS
SELECT DISTINCT
	emp_id,
    CAPITALIZE(emp_name) AS emp_name,
    IF(gender = 'm', 'Male', 'Female') AS gender,
    hired_date,
    CAPITALIZE(city_name) AS city_name,
    CAPITALIZE(dept_name) AS dept_name,
    IFNULL(IF(rewards IN ('n/a', 'not applicable'), null, rewards), 0) AS rewards,
    TRIM(REPLACE(monthly_salary, '?','')) AS monthly_salary
FROM vw_emp_data
ORDER BY emp_id;

-- Retrieving View Table "vw_emp_info" :
SELECT * FROM vw_emp_info;

-- Creating new database called 'ReportDB' :
CREATE DATABASE ReportDB;

-- Creating a table in ReportDB, in order to store transformed data set :
CREATE TABLE ReportDB.Emp_Info(
emp_id INT NOT NULL PRIMARY KEY,
emp_name VARCHAR(50) NOT NULL,
gender ENUM('Male', 'Female', 'Other') NOT NULL,
hired_date DATE NOT NULL,
city_name VARCHAR(50)NOT NULL,
dept_name VARCHAR(50)NOT NULL,
rewards INT DEFAULT 0,
monthly_salary INT NOT NULL,
INDEX idx_emp_name (emp_name),
INDEX idx_hired_date (hired_date),
INDEX idx_city_name (city_name),
INDEX idx_dept_name (dept_name),
INDEX idx_rewards (rewards),
INDEX idx_monthly_salary (monthly_salary)
);

--  Loading transformed data-set to the new table (emp_info) into ReportDB :
INSERT INTO ReportDB.emp_info 
SELECT DISTINCT
	emp_id,
    CAPITALIZE(emp_name) AS emp_name,
    IF(gender = 'm', 'Male', 'Female') AS gender,
    hired_date,
    CAPITALIZE(city_name) AS city_name,
    CAPITALIZE(dept_name) AS dept_name,
    IFNULL(IF(rewards IN ('n/a', 'not applicable'), null, rewards), 0) AS rewards,
    TRIM(REPLACE(monthly_salary, '?','')) AS monthly_salary
FROM vw_emp_data
ORDER BY emp_id;
-- ====================================================================================================================================================