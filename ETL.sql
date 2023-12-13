-- Creating and Accessing Database (ETL) :
CREATE DATABASE ETL;
USE ETL;
-- ----------------------------------------------------------------

-- Creating Tables (City, Dept, Emp) :
CREATE TABLE City(
city_id INT PRIMARY KEY,
city_name VARCHAR(50)
);

CREATE TABLE Dept(
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50)
); 

CREATE TABLE Emp(
emp_id INT,
emp_name VARCHAR(50),
gender ENUM ('M','F'),
hired_date DATE,
emp_city_id INT,
emp_dept_id INT,
rewards VARCHAR(50),
monthly_salary VARCHAR(15),
FOREIGN KEY(emp_city_id) REFERENCES City(city_id),
FOREIGN KEY(emp_dept_id) REFERENCES Dept(dept_id)
);
-- ----------------------------------------------------------------