USE employees;
/*
Create a new department called “Business Analysis”. Register it under number ‘d010’.
*/
INSERT INTO departments VALUES ('d010', 'Business Analysis');

SELECT*
FROM departments;

/*
Change the “Business Analysis” department name to “Data Analysis”.
*/
UPDATE departments
SET
    dept_name = 'Data Analysis'
WHERE
    dept_no = 'd010';

SELECT*
FROM departments;

/*
Remove the department number 10 record from the “departments” table.
*/
DELETE FROM departments
WHERE
    dept_no = 'd010';
    
SELECT*
FROM departments;

/*
How many departments are there in the “employees” database? 
*/
SELECT
    COUNT(DISTINCT dept_no)
FROM dept_emp;

/*
What is the total amount of money spent on salaries for all 
contracts starting after the 1st of January 1997?
*/
SELECT
    SUM(salary)
FROM salaries
WHERE from_date > '1997-01-01';

/*
Which is the lowest employee number in the database?
2. Which is the highest employee number in the database?
*/
SELECT
    MIN(emp_no)
FROM employees;

SELECT
    MAX(emp_no)
FROM employees;

/*
What is the average annual salary paid to employees who 
started after the 1st of January 1997?
*/
SELECT
    AVG(salary)
FROM salaries
WHERE from_date > '1997-01-01';

/*
Round the average amount of money spent on salaries for 
all contracts that started after the 1st of January 1997 
to a precision of cents.
*/
SELECT
    ROUND(AVG(salary), 2)
FROM salaries
WHERE from_date > '1997-01-01';

/*
Add a third column where you name the department number 
(‘dept_no’) as ‘dept_info’. If ‘dept_no’ does not have a value, 
use ‘dept_name’.
*/
SELECT
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM departments
ORDER BY dept_no ASC;

/*
Create table with the data type of dept_no be CHAR of 4, and the data type 
of dept_name be VARCHAR of 40. Both columns are allowed to have null values. 
Finally, insert the information contained in ‘departments’ into ‘departments_dup’.)
Then, insert a record whose department name is “Public Relations”.
Delete the record(s) related to department number two.
Insert two new records in the “departments_dup” table. Let their values in the 
“dept_no” column be “d010” and “d011”.
*/
CREATE TABLE departments_dup
(
    dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);

INSERT INTO departments_dup
(
    dept_no,
    dept_name
)
SELECT*
FROM departments;

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');
DELETE FROM departments_dup
WHERE dept_no = 'd002'; 

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (

  emp_no int(11) NOT NULL,

  dept_no char(4) NULL,

  from_date date NOT NULL,

  to_date date NULL

  );

 
/*
Create and fill in the ‘dept_manager_dup’ table
*/
CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );
  
INSERT INTO dept_manager_dup
SELECT * FROM dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES                
	(999904, '2017-01-01'),
	(999905, '2017-01-01'),
	(999906, '2017-01-01'),
	(999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';
    
INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');

DELETE FROM departments_dup
WHERE dept_no = 'd002'; 

/*
Extract a list containing information about all managers’ employee number, 
first and last name, department number, and hire date. 
*/
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no;

/*
Join the 'employees' and the 'dept_manager' tables to return a subset of 
all the employees whose last name is Markovitch. See if the output contains 
a manager with that name.  
*/
SELECT
    e.emp_no,  
    e.first_name,  
    e.last_name,  
    dm.dept_no,  
    dm.from_date  
FROM  employees e  
	LEFT JOIN  dept_manager dm ON e.emp_no = dm.emp_no  
WHERE e.last_name = 'Markovitch'  
ORDER BY dm.dept_no DESC, e.emp_no;

/*
Extract a list containing information about all managers’ employee number, 
first and last name, department number, and hire date. Use the old type of 
join syntax to obtain the result.
*/
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM
    employees e,
    dept_manager dm
WHERE e.emp_no = dm.emp_no;
    

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM employees e
        JOIN dept_manager dm ON e.emp_no = dm.emp_no; 
        
/*
Select the first and last name, the hire date, and the job title of 
all employees whose first name is “Margareta” and have the last name “Markovitch”.
*/
SELECT
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title
FROM employees e
        JOIN titles t ON e.emp_no = t.emp_no
WHERE first_name = 'Margareta' AND last_name = 'Markovitch'
ORDER BY e.emp_no;   

/*
Use a CROSS JOIN to return a list with all possible combinations between 
managers from the dept_manager table and department number 9.
*/
SELECT
    dm.*, d.*
FROM departments d
        CROSS JOIN dept_manager dm
WHERE d.dept_no = 'd009'
ORDER BY d.dept_name;

/*
Return a list with the first 10 employees with all the departments they 
can be assigned to.
*/
SELECT
    e.*, d.*
FROM employees e
        CROSS JOIN departments d
WHERE e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;

/*
Select all managers’ first and last name, hire date, job title, start date, 
and department name.
*/
SELECT
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN dept_manager m ON e.emp_no = m.emp_no
        JOIN departments d ON m.dept_no = d.dept_no
        JOIN titles t ON e.emp_no = t.emp_no
            AND m.from_date = t.from_date
ORDER BY e.emp_no;

/*
How many male and how many female managers do we have in the ‘employees’ database?
*/
SELECT
    e.gender, COUNT(dm.emp_no)
FROM employees e
        JOIN dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;

/*
UNION VS UNION ALL
*/
SELECT *
FROM
(SELECT
        e.emp_no,
		e.first_name,
		e.last_name,
		NULL AS dept_no,
		NULL AS from_date
FROM employees e
WHERE  
		last_name = 'Denis' UNION SELECT
        NULL AS emp_no,
		NULL AS first_name,
		NULL AS last_name,
		dm.dept_no,
		dm.from_date
FROM dept_manager dm) as a
ORDER BY -a.emp_no DESC;