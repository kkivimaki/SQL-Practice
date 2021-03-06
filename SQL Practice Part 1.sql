USE EMPLOYEES;
SELECT 
    first_name, last_name
FROM
    employees;

SELECT *
FROM
    employees;

SELECT *
FROM
    employees
WHERE FIRST_NAME = 'DENIS' AND GENDER='M';

SELECT *
FROM
    employees
WHERE FIRST_NAME = 'DENIS' OR FIRST_NAME= 'ELVIS';

/*
EMPLOYEE EITHER MALE OR FEMALE WITH LAST NAME DENIS
*/
SELECT* 
FROM
	EMPLOYEES
WHERE
	LAST_NAME='DENIS' AND (GENDER='M' OR GENDER='F');
  
/*
EMPLOYEES WHOSE NAME IS EITHER CATHIE, MARK OR NATHAN
*/
SELECT*
FROM EMPLOYEES
WHERE 
    FIRST_NAME IN('CATHIE', 'MARK', 'NATHAN');

/*
WHOSE FIRST NAME IS EITHER DENIS OR ELVIS
*/
SELECT*
FROM EMPLOYEES
WHERE FIRST_NAME IN ('DENIS', 'ELVIS');

/*
EXTRACT RECORDS ASIDE FROM THOSE WITH EMPLOYEES NAMES JOHN, MARK OR JACOB
*/
SELECT*
FROM EMPLOYEES
WHERE FIRST_NAME NOT IN ('JOHN', 'MARK', 'JACOB');

/*
ALL INDIVIDUALS WHOSE FIRST NAEM STARTS WITH MARK - CAN BE SUCCEEDED BY ANY SEQUENCE
OF CHARACTERS
*/
SELECT*
FROM EMPLOYEES
WHERE FIRST_NAME LIKE ('MARK%');

/*
RETRIEVE LIST WITH ALL EMPLOYEES WHO HAVE BEEN HIRED IN YEAR 2000
*/
SELECT*
FROM EMPLOYEES
WHERE HIRE_DATE LIKE ('%2000%');

/* 
LIST OF EMPLOYEES WHOSE NUMBER IS WRITTEN WITH 5 CHARACTERS, AND STARTS WITH 1000
*/
SELECT*
FROM EMPLOYEES
WHERE EMP_NO LIKE ('1000_');

/* 
EXTRACT INDIVIDUALS FROM EMPLOYEES WHOSE NAME CONTAINS JACK
*/
SELECT*
FROM EMPLOYEES
WHERE FIRST_NAME LIKE ('%JACK%');

/*
EXTRACT LIST CONTAING NAMES THAT DO NOT CONTAIN JACK
*/
SELECT*
FROM EMPLOYEES
WHERE FIRST_NAME NOT LIKE ('%JACK%');

/*
ALL INFO FROM SALARIES REGARDING CONTRACTS FROM $66000 TO $70000/YR
*/
SELECT*
FROM SALARIES
WHERE SALARY BETWEEN 66000 AND 70000;

/*
INDIVIDUALS WHOSE EMPLOYEE NUMBER IS NOT BEWTWEEN 10004 AND 10012
*/
SELECT*
FROM EMPLOYEES
WHERE EMP_NO NOT BETWEEN '10004' AND '10012';

/*
NAMES OF ALL DEPTS WITH NUMBERS BETWEEN DOO3 AND D006
*/

SELECT DEPT_NAME
FROM DEPARTMENTS
WHERE DEPT_NO BETWEEN 'DOO3' AND 'DOO6';

/*
NAMES OF ALL DEPTS WHOSE NUMBER IS NOT NULL
*/
SELECT DEPT_NAME
FROM DEPARTMENTS
WHERE DEPT_NO IS NOT NULL;

/*
LIST WITH DATA ABOUT ALL FEMALE EMPLOYEES WHO WERE HIRED IN YEAR 2000 OR AFTER
*/
SELECT*
FROM EMPLOYEES
WHERE HIRE_DATE>= '2000-01-01'
	AND GENDER = 'F';

/*
EXTRACT LIST WITH ALL EMPLOYEES' SALARIES HIGHER THAN $150,000 PER ANNUM
*/
SELECT*
FROM SALARIES
WHERE SALARY > 150000;

/*
OBTAIN LIST WITH DIFFERENT HIRE DATES FROM EMPLOYEE TABLE
*/
SELECT DISTINCT 
	HIRE_DATE
FROM EMPLOYEES;

/*
HOW MANY ANNUAL CONTRACT WITH A VALUE HIGHER THAN OR EQUAL TO $100,00
HAVE BEEN REGISTERD IN SALARIES TABLE
*/
SELECT COUNT(*)
FROM SALARIES
WHERE SALARY >=100000;

/*
HOW MANY MANAGERS DO WE HAVE IN THE EMPLOYEES DATABASE
*/
SELECT COUNT(*)
FROM DEPT_MANAGER;

/*
SELECT ALL DATA FROM EMPLOYEES TABLE, ORDERING BY HIRE DATE IN DESCENDING ORDER
*/
SELECT*
FROM EMPLOYEES
ORDER BY HIRE_DATE DESC;

/*
OBTAIN 2 COLUMNS - FIRST MUST CONTAIN ANNUAL SALARIES HIGHER THAN $80,000
AND SECOND MUST BE RENAMED TO EMPS_WITH_SAME_SALARY AND MUST SHOW THE NUMBER
OF EMPLOYEES CONTRACTED TO THAT SALARY.
SORT OUTPUT BY FIRST COLUMN
*/
SELECT 
	SALARY,
    COUNT(EMP_NO) AS EMPS_WITH_SAME_SALARY
FROM SALARIES
WHERE SALARY > 80000
GROUP BY SALARY
ORDER BY SALARY;

/*
SELECT ALL EMPLOYEES WHOSE AVERAGE SALARY IS HIGHER THAN $120,00/ANNUM
*/
SELECT EMP_NO, AVG(SALARY)
FROM SALARIES
GROUP BY EMP_NO
HAVING AVG(SALARY) > 120000
ORDER BY EMP_NO;

/* 
USE WHERE INSTEAD OF HAVING TO COMPARE PREVIOUS QUERY
*/
SELECT* , AVG(SALARY)
FROM SALARIES
WHERE SALARY>120000
GROUP BY EMP_NO
ORDER BY EMP_NO;

/*
SELECT EMPLOYEE NUMBERS OF ALL WHO HAVE SIGNED MORE THAN 1 CONTRACT
AFTER 1ST OF JANUARY 2020
*/
SELECT EMP_NO
FROM DEPT_EMP
WHERE FROM_DATE > '2000-01-01'
GROUP BY EMP_NO
HAVING COUNT(FROM_DATE)>1
ORDER BY EMP_NO;

/*
SELECT FIRST 100 ROWS FROM THE 'DEPT_EMP' TABLE
*/
SELECT*
FROM DEPT_EMP
LIMIT 100;