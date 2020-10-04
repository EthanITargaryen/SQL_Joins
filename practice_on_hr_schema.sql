-- Display details of jobs where the minimum salary is greater than 10000

SELECT * FROM JOBS
WHERE MIN_SALARY>10000;

-- Display the first name and join date of the employees who joined between 2002 and 2005

SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '01-Jan-2002' AND '31-Dec-2005';

-- Display first name and join date of the employees who is either IT Programmer or Sales Man.

SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE UPPER(JOB_ID) IN ('IT_PROG', 'SA_MAN');

-- Display employees who joined after 1st January 2008.

SELECT * FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') > 2007
ORDER BY HIRE_DATE;

SELECT * FROM EMPLOYEES
WHERE HIRE_DATE >= '01-JAN-2008';

-- Display details of employee with ID 150 or 160.

SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (150, 160);

-- Display first name, salary, commission pct, and hire date for employees with salary less than 10000.

SELECT FIRST_NAME, SALARY, COMMISSION_PCT, HIRE_DATE
FROM EMPLOYEES
WHERE SALARY < 10000;

-- Display job Title, the difference between minimum and maximum salaries for jobs with max salary in the
-- range 10000 to 20000.

SELECT JOB_TITLE, (MAX_SALARY - MIN_SALARY) AS DIFF_SALARY
FROM JOBS
WHERE MAX_SALARY BETWEEN 10000 AND 20000;

-- Display first name, salary, and round the salary to thousands

SELECT FIRST_NAME, SALARY, ROUND(SALARY/1000, 0) * 1000 AS SALARY_THOUSAND
FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY, ROUND(SALARY, -3) AS SALARY_THOUSAND
FROM EMPLOYEES;

-- Display details of jobs in the descending order of the title

SELECT * FROM JOBS
ORDER BY JOB_TITLE DESC;

-- Display employees where the first name or last name starts with S.

SELECT * FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'S%' OR LAST_NAME LIKE 'S%'
ORDER BY FIRST_NAME, LAST_NAME;

-- Display employees who joined in the month of May.

SELECT * FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'MON') = 'MAY';

-- Display details of the employees where commission percentage is null and salary in the range 5000 to 10000
-- and department is 30

SELECT * FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL AND
      SALARY BETWEEN 5000 AND 10000 AND
      DEPARTMENT_ID = 30;

-- FROM SB BOOK
-- Print hire dates of all employees in the following formats:
-- (i) 13th February, 1998 (ii) 13 February, 1998

SELECT TO_CHAR(HIRE_DATE, 'DDth Month, YYYY'), TO_CHAR(HIRE_DATE, 'DD Month, YYYY'), TO_CHAR(HIRE_DATE, 'DDspth Month, YYYY')
FROM EMPLOYEES;

SELECT RTRIM(TO_CHAR(HIRE_DATE, 'DD Month'), ' ') || TO_CHAR(HIRE_DATE, ' YYYY')
FROM EMPLOYEES;

-- Display first name and date of first salary of the employees

SELECT FIRST_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)+1
FROM EMPLOYEES;

-- Display first name and experience of the employees

SELECT FIRST_NAME, TRUNC((SYSDATE - HIRE_DATE) / 365) AS EXPERIENCE
FROM EMPLOYEES;

SELECT FIRST_NAME, HIRE_DATE, FLOOR((SYSDATE-HIRE_DATE)/365) FROM EMPLOYEES;

-- Display first name of employees who joined in 2001.

SELECT FIRST_NAME
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2001';

-- Display first name and last name after converting the first letter of each name to upper case and the rest to
-- lower case.

SELECT  UPPER(SUBSTR(FIRST_NAME, 1, 1)) || LOWER(SUBSTR(FIRST_NAME, 2)) || ' ' || UPPER(SUBSTR(LAST_NAME, 1, 1)) || LOWER(SUBSTR(LAST_NAME, 2))
FROM EMPLOYEES
ORDER BY FIRST_NAME;

SELECT INITCAP(FIRST_NAME) || ' ' || INITCAP(LAST_NAME)
FROM EMPLOYEES
ORDER BY FIRST_NAME;

-- Display the first word in job title.

SELECT JOB_ID, SUBSTR(JOB_TITLE, 1, INSTR(JOB_TITLE || ' ', ' ')) AS JOB_TITLE_fW
FROM JOBS;

-- Display the length of first name for employees where last name contain character ‘b’ after 3rd position.

SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '%b__';

-- Display first name in upper case and email address in lower case for employees where the first name and
-- email address are same irrespective of the case.

SELECT UPPER(FIRST_NAME) AS FN, LOWER(EMAIL) AS EM
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME) = UPPER(EMAIL);

-- Display employees who joined in the current year

SELECT * FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY');

-- Display the number of days between system date and 1st January 2011

SELECT DISTINCT TRUNC(SYSDATE-TO_DATE('01-JAN-2011')) AS DIFF
FROM REGIONS;

-- Display how many employees joined in each month of the current year
-- replace to 2005

SELECT TO_CHAR(HIRE_DATE, 'MON') AS MONTH, COUNT(*) AS NO_HIRING
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2005'
GROUP BY TO_CHAR(HIRE_DATE, 'MON')
ORDER BY NO_HIRING;

-- SORT BY MONTH?

SELECT TO_CHAR(HIRE_DATE, 'MON') AS MONTH, COUNT(*) AS NO_HIRING
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2005'
GROUP BY TO_CHAR(HIRE_DATE, 'MON')
ORDER BY TO_DATE('01-' || MONTH || '-1971');

-- Display manager ID and number of employees managed by the manager.

SELECT MANAGER_ID, COUNT(*) AS NO_MANAGED
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY EMPLOYEES.MANAGER_ID;

SELECT MANAGER_ID, COUNT(*) AS NO_MANAGED
FROM EMPLOYEES
GROUP BY EMPLOYEES.MANAGER_ID
HAVING MANAGER_ID IS NOT NULL;

-- Display employee ID and the date on which he ended his previous job.

SELECT  EMPLOYEE_ID, MAX(END_DATE)
FROM JOB_HISTORY
GROUP BY EMPLOYEE_ID;

-- Display number of employees joined after 15th of the month

SELECT COUNT(EMPLOYEE_ID)
FROM EMPLOYEES
WHERE TO_NUMBER(TO_CHAR(HIRE_DATE, 'DD')) > 15;

-- Display the country ID and number of cities we have in the country

SELECT COUNTRY_ID, COUNT(CITY) AS NO_CITIES
FROM LOCATIONS
GROUP BY COUNTRY_ID;

-- if country name was sought

SELECT COUNTRY_NAME, COUNT(CITY) AS NO_CITIES
FROM LOCATIONS INNER JOIN COUNTRIES
    ON LOCATIONS.COUNTRY_ID = COUNTRIES.COUNTRY_ID
GROUP BY COUNTRY_NAME;

-- Display average salary of employees in each department who have commission percentage

SELECT DEPARTMENT_ID, ROUND(AVG(SALARY), 2) AS AVG_SALARY
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IS NOT NULL;

-- Display job ID, number of employees, sum of salary, and difference between highest salary and lowest salary
-- of the employees of the job.

-- three ways to do the same
SELECT JOBS.JOB_ID, COUNT(EMPLOYEE_ID), SUM(SALARY), AVG(MAX_SALARY - MIN_SALARY), MAX(MAX_SALARY - MIN_SALARY),
       MAX(SALARY) - MIN(SALARY)
FROM EMPLOYEES INNER JOIN JOBS
    ON EMPLOYEES.JOB_ID = JOBS.JOB_ID
GROUP BY JOBS.JOB_ID;

-- Display job ID for jobs with average salary more than 10000

SELECT JOB_ID --, AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY) > 10000;

-- Display years in which more than 10 employees joined

SELECT TO_CHAR(HIRE_DATE, 'YYYY') --, COUNT(EMPLOYEE_ID) AS NO_EMPLOYEE
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY')
HAVING COUNT(EMPLOYEE_ID) > 10;

-- Display departments in which more than five employees have commission percentage

SELECT DEPARTMENT_ID --, COUNT(*)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) > 5;

-- Display employee ID for employees who did more than one job in the past.

SELECT EMPLOYEE_ID
FROM JOB_HISTORY
GROUP BY EMPLOYEE_ID
HAVING COUNT(*)>1;

-- Display job ID of jobs that were done by more than 3 employees for more than 100 days
-- Consider only Jobs table

SELECT JOB_ID
FROM EMPLOYEES
WHERE (SYSDATE - HIRE_DATE) > 100
GROUP BY JOB_ID
HAVING COUNT(EMPLOYEE_ID) > 3;

-- Display department ID, year, and Number of employees joined

SELECT DEPARTMENT_ID, TO_CHAR(HIRE_DATE, 'YYYY') AS YEAR, COUNT(*) AS EMPLOYEES
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY YEAR, DEPARTMENT_ID;

-- Display departments where any manager is managing more than 5 employees

SELECT DISTINCT DEPARTMENT_ID
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, MANAGER_ID
HAVING COUNT(EMPLOYEE_ID) > 5;

-- Display department name and number of employees in the department

SELECT DEPARTMENT_NAME, COUNT(EMPLOYEE_ID) AS NO_EMPLOYEES
FROM EMPLOYEES INNER JOIN DEPARTMENTS
    ON DEPARTMENTS.DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME;

-- Display job title, employee ID, number of days between ending date and starting date for all jobs in
-- department 50 from job history

SELECT JOB_TITLE, EMPLOYEE_ID, END_DATE-START_DATE
FROM JOB_HISTORY INNER JOIN JOBS J on J.JOB_ID = JOB_HISTORY.JOB_ID
WHERE DEPARTMENT_ID = 50;

-- Display department name and manager first name

SELECT DEPARTMENT_NAME, FIRST_NAME
FROM DEPARTMENTS INNER JOIN EMPLOYEES
    ON DEPARTMENTS.MANAGER_ID = EMPLOYEES.EMPLOYEE_ID;

-- Display department name, manager name, and city

SELECT DEPARTMENT_NAME, FIRST_NAME || ' ' || LAST_NAME AS NAME, CITY
FROM (DEPARTMENTS INNER JOIN EMPLOYEES
    ON DEPARTMENTS.MANAGER_ID = EMPLOYEES.EMPLOYEE_ID) INNER JOIN LOCATIONS
    ON DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID;

-- Display country name, city, and department name

SELECT COUNTRY_NAME, CITY, DEPARTMENT_NAME
FROM COUNTRIES INNER JOIN LOCATIONS L on COUNTRIES.COUNTRY_ID = L.COUNTRY_ID
    INNER JOIN DEPARTMENTS D on L.LOCATION_ID = D.LOCATION_ID;

-- Display job title, department name, employee last name, starting date for all jobs from 2000 to 2005

SELECT JOB_TITLE, DEPARTMENT_NAME, LAST_NAME, START_DATE
FROM JOBS J , DEPARTMENTS D, EMPLOYEES E, JOB_HISTORY H
WHERE START_DATE BETWEEN ('01-JAN-2000') AND ('31-DEC-2005') AND
      H.JOB_ID = J.JOB_ID AND
      H.DEPARTMENT_ID = D.DEPARTMENT_ID AND
      H.EMPLOYEE_ID = E.EMPLOYEE_ID;

-- Display job title and average salary of employees

SELECT JOB_TITLE, AVG(SALARY) AS AVG_SALARY
FROM JOBS, EMPLOYEES
WHERE JOBS.JOB_ID = EMPLOYEES.JOB_ID
GROUP BY JOB_TITLE;

-- Display job title, employee name, and the difference between maximum salary for the job and salary of the
-- employee

SELECT JOB_TITLE, (FIRST_NAME || ' ' || LAST_NAME) AS EMPLOYEE_NAME, (MAX_SALARY - SALARY) AS DIFFERENCE
FROM JOBS J INNER JOIN EMPLOYEES E on J.JOB_ID = E.JOB_ID;

-- Display last name, job title of employees who have commission percentage and belongs to department 30

SELECT LAST_NAME, JOB_TITLE
FROM EMPLOYEES E INNER JOIN JOBS J on J.JOB_ID = E.JOB_ID
WHERE DEPARTMENT_ID = 30 AND COMMISSION_PCT IS NOT NULL;

SELECT LAST_NAME, JOB_TITLE
FROM EMPLOYEES E INNER JOIN JOBS J on J.JOB_ID = E.JOB_ID
WHERE DEPARTMENT_ID = 80 AND COMMISSION_PCT IS NOT NULL;

-- Display details of jobs that were done by any employee who is currently drawing more than 15000 of salary

SELECT J.*
FROM JOB_HISTORY H INNER JOIN JOBS J on J.JOB_ID = H.JOB_ID
    INNER JOIN EMPLOYEES E on E.EMPLOYEE_ID = H.EMPLOYEE_ID
WHERE E.SALARY>15000;

-- Display department name, manager name, and salary of the manager for all managers whose experience is
-- more than 5 years.

SELECT DEPARTMENT_NAME, MANAGERS.MANAGER_NAME AS MANAGER_NAME, MANAGERS.SAL AS SALARY
FROM DEPARTMENTS INNER JOIN (
        SELECT DISTINCT E1.EMPLOYEE_ID AS MANAGER_ID, (E1.FIRST_NAME || ' ' || E1.LAST_NAME) MANAGER_NAME
                      , E1.DEPARTMENT_ID AS DEPT, E1.SALARY AS SAL
        FROM EMPLOYEES E1, EMPLOYEES E2
        WHERE E1.EMPLOYEE_ID = E2.MANAGER_ID
        AND ((SYSDATE - E1.HIRE_DATE)/365) > 5
    ) MANAGERS
    ON MANAGERS.DEPT = DEPARTMENT_ID;

-- Display employee name if the employee joined before his manager

SELECT (E2.FIRST_NAME || ' ' || E2.LAST_NAME) AS EMPLOYEE_NAME
FROM EMPLOYEES E1, EMPLOYEES E2
WHERE E1.EMPLOYEE_ID = E2.MANAGER_ID
AND E2.HIRE_DATE < E1.HIRE_DATE;

-- Display employee name, job title for the jobs employee did in the past where the job was done less than six
-- months

SELECT (FIRST_NAME || ' ' || LAST_NAME) AS EMPLOYEE_NAME, JOB_TITLE, MONTHS_BETWEEN(END_DATE, START_DATE)
FROM JOB_HISTORY, EMPLOYEES, JOBS
WHERE MONTHS_BETWEEN(END_DATE, START_DATE) < 15
AND JOB_HISTORY.EMPLOYEE_ID = EMPLOYEES.EMPLOYEE_ID
AND JOB_HISTORY.JOB_ID = JOBS.JOB_ID;

-- Display employee name and country in which he is working

SELECT (FIRST_NAME || ' ' || LAST_NAME) AS EMPLOYEE_NAME, COUNTRY_NAME
FROM EMPLOYEES, COUNTRIES, LOCATIONS, DEPARTMENTS
WHERE DEPARTMENTS.DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID
    AND LOCATIONS.LOCATION_ID = DEPARTMENTS.LOCATION_ID
    AND COUNTRIES.COUNTRY_ID = LOCATIONS.COUNTRY_ID;

-- Display department name, average salary and number of employees with commission within the department

SELECT DEPARTMENT_NAME, ROUND(AVG(SALARY), 2) AS AVG_SALARY, COUNT(COMMISSION_PCT) AS NO_E_WC
FROM DEPARTMENTS, EMPLOYEES
WHERE EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME;

-- Display the month in which more than 5 employees joined in any department located in /*Sydney*/ SEATTLE

SELECT TO_CHAR(HIRE_DATE, 'MON, YYYY') MONTH
FROM EMPLOYEES, DEPARTMENTS, LOCATIONS
WHERE CITY = 'Seattle' AND
      EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID AND
      DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
GROUP BY TO_CHAR(HIRE_DATE, 'MON, YYYY')
HAVING COUNT(EMPLOYEE_ID) > 1;

-- Display details of departments in which the maximum salary is more than 10000

SELECT DEPARTMENTS.*
FROM DEPARTMENTS
WHERE DEPARTMENT_ID IN
(   SELECT DEPARTMENT_ID
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
    HAVING MAX(SALARY) > 10000);

-- Display details of departments managed by /*‘Smith’*/ King

SELECT DEPARTMENTS.*
FROM DEPARTMENTS, EMPLOYEES
WHERE EMPLOYEES.EMPLOYEE_ID = DEPARTMENTS.MANAGER_ID AND
      LAST_NAME = 'King';

-- Display jobs into which employees joined in the current year

SELECT JOBS.*
FROM JOBS, EMPLOYEES
WHERE JOBS.JOB_ID = EMPLOYEES.JOB_ID AND
      TO_CHAR(HIRE_DATE, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY');

-- Display employees who did not do any job in the past

SELECT EMPLOYEES.*
FROM JOB_HISTORY, EMPLOYEES
WHERE JOB_HISTORY.EMPLOYEE_ID (+) = EMPLOYEES.EMPLOYEE_ID AND
      JOB_HISTORY.EMPLOYEE_ID IS NULL;

-- Display job ID and average salary for employees who did a job in the pas



-- Display country name, city, and number of departments where department has more than 5 employees

SELECT COUNTRY_NAME, CITY, COUNT(*) AS CNT
FROM DEPARTMENTS, LOCATIONS, COUNTRIES
WHERE COUNTRIES.COUNTRY_ID = LOCATIONS.COUNTRY_ID AND
      LOCATIONS.LOCATION_ID = DEPARTMENTS.LOCATION_ID AND
      DEPARTMENTS.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                    FROM EMPLOYEES
                                    GROUP BY DEPARTMENT_ID
                                    HAVING COUNT(EMPLOYEE_ID) > 5)
GROUP BY COUNTRY_NAME, CITY;

-- Display details of manager who manages more than 5 employees

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN(SELECT E1.EMPLOYEE_ID
                        FROM EMPLOYEES E1, EMPLOYEES E2
                        WHERE E1.EMPLOYEE_ID = E2.MANAGER_ID
                        GROUP BY E1.EMPLOYEE_ID, E1.FIRST_NAME
                        HAVING COUNT(E2.EMPLOYEE_ID) > 5);

-- Display employee name, job title, start date, and end date of past jobs of all employees with commission
-- percentage null.

SELECT (FIRST_NAME || ' ' || LAST_NAME) EMP_NAME, JOB_TITLE, START_DATE, END_DATE
FROM JOB_HISTORY H INNER JOIN EMPLOYEES E on E.EMPLOYEE_ID = H.EMPLOYEE_ID
                   INNER JOIN JOBS J on J.JOB_ID = E.JOB_ID
WHERE COMMISSION_PCT IS NULL;

-- Display the departments into which no employee joined in last /*two*/ 13 year/*s*/

SELECT * FROM DEPARTMENTS
WHERE DEPARTMENT_ID NOT IN(SELECT DISTINCT DEPARTMENT_ID
                            FROM EMPLOYEES
                            WHERE (SYSDATE - HIRE_DATE)/365 < 13 AND
                                  DEPARTMENT_ID IS NOT NULL);

-- Display the city of employee whose employee ID is 105

SELECT CITY
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D on D.DEPARTMENT_ID = E.DEPARTMENT_ID
                 INNER JOIN LOCATIONS L on L.LOCATION_ID = D.LOCATION_ID
WHERE E.EMPLOYEE_ID = 105;

-- Display third highest salary of all employees

SELECT DISTINCT MAX(E3.SALARY)
FROM EMPLOYEES E1, EMPLOYEES E2, EMPLOYEES E3
WHERE E1.SALARY > E2.SALARY
    AND E2.SALARY > E3.SALARY;
