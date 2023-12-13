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

-- Inserting Records into Tables (Emp , City, Dept) :
INSERT INTO City(city_id, city_name) VALUES
(11, 'chennai'),
(12, 'BanGalore'),
(13, 'MUMBAI');

INSERT INTO Dept(dept_id, dept_name) VALUES
(101, 'web designer'),
(102, 'front-end developer'),
(103, 'back-end developer'),
(104, 'Full stack developer'),
(105, 'devOPS engineer');

INSERT INTO Emp(emp_id, emp_name, gender, hired_date, emp_city_id, emp_dept_id, rewards, monthly_salary) VALUES
(1,			'Yugi',					'M',	'2023-02-20',	11,		104,	'5',						'₹ 88000'),
(2,			'Rohith',				'M',	'2023-12-04',	11,		104,	'6',						'₹ 86000'),
(3,			'Balu',					'M',	'2023-05-04',	12,		102,	'4',						'₹ 45000'),
(4,			'Sakthi dass',			'M',	'2023-01-02',	12,		101,	'3',						'₹ 46000'),
(5,			'Ajay',					'M',	'2021-06-22',	13,		101,	'3',						'₹ 40000'),
(6,			'Dravid',				'M',	'2023-04-04',	11,		101,	'N/A',						'₹ 42000'),
(7,			'Tharun',				'M',	'2023-01-01',	13,		105,	'5',						'₹ 77000'),
(8,			'Naveen',				'M',	'2022-05-03',	13,		102,	'Not Applicable',			'₹ 55000'),
(9,			'Venkatesh babu',		'M',	'2023-02-20',	13,		102,	'not applicable',			'₹ 54000'),
(10,		'Farook',				'M',	'2023-04-22',	12,		103,	'4',						'₹ 74000'),
(11,		'Jessia',				'F',	'2023-05-02',	12,		103,	'4',						'₹ 70000'),
(12,		'shifa',				'F',	'2023-01-24',	11,		105,	'6',						'₹ 76000'),
(13,		'yazhini',				'F',	'2023-02-14',	12,		105,	'5',						'₹ 75000'),
(14,		'Prema',				'F',	'2023-02-03',	12,		102,	'6',						'₹ 44000'),
(15,		'Swathi',				'F',	'2023-01-02',	11,		104,	'5',						'₹ 82000'),
(16,		'Lokesh',				'M',	'2022-08-10',	12,		105,	'3',						'₹ 76000'),
(17,		'Madhavan',				'M',	'2023-06-02',	11,		102,	'4',						'₹ 54000'),
(18,		'Gokul',				'M',	'2022-01-01',	12,		101,	'2',						'₹ 41000'),
(19,		'Kanna',				'M',	'2023-01-02',	12,		103,	'4',						'₹ 68000'),
(20,		'Soorya',				'M',	'2023-08-04',	13,		null,	'n/a',						'₹ 24000'),
(21,		'Eswar',				'M',	'2023-02-01',	13,		102,	'3',						'₹ 64000'),
(22,		'Karthick',				'M',	'2023-05-02',	11,		105,	'4',						'₹ 77000'),
(23,		'Kishore',				'M',	'2023-06-02',	11,		105,	'6',						'₹ 78000'),
(24,		'Vinoth',				'M',	'2023-03-02',	13,		102,	'5',						'₹ 58000'),
(25,		'Akash',				'M',	'2023-07-04',	13,		101,	'4',						'₹ 45000'),
(1,			'Yugi',					'M',	'2023-02-20',	11,		104,	'5',						'₹ 88000');
-- ----------------------------------------------------------------

-- Retrieving Tables (Emp, City, Dept) :
SELECT * FROM Emp;
SELECT * FROM City;
SELECT * FROM Dept;
-- ----------------------------------------------------------------

-- Combining Tables, Using LEFT JOIN :
SELECT e.emp_id, e.emp_name, e.gender, e.hired_date, c.city_name, d.dept_name, e.rewards, e.monthly_salary
FROM emp e
LEFT JOIN City c ON e.emp_city_id = c.city_id
LEFT JOIN Dept d ON e.emp_dept_id = d.dept_id
ORDER BY e.emp_id;
-- ----------------------------------------------------------------

-- CREATING VIEW For The Combined Table :
CREATE VIEW vw_emp_data AS
SELECT e.emp_id, e.emp_name, e.gender, e.hired_date, c.city_name, d.dept_name, e.rewards, e.monthly_salary
FROM emp e
LEFT JOIN City c ON e.emp_city_id = c.city_id
LEFT JOIN Dept d ON e.emp_dept_id = d.dept_id
ORDER BY e.emp_id;

SELECT * FROM vw_emp_data;
-- ----------------------------------------------------------------