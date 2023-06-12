/*
Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's  key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.

Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.
*/


select cast(ceiling(avg(cast(salary as float)) - avg(cast(replace(salary, '0', '') as float))) as int) 
from employees


/*
We define an employee's total earnings to be their monthly  worked, and the maximum
 total earnings to be the maximum total earnings for any employee in the Employee table.
  Write a query to find the maximum total earnings for all employees as well as the total number
   of employees who have maximum total earnings. Then print these values as  space-separated integers.
*/

select max(months*salary), count(*)
from employee
where months*salary = (select max(months*salary) from employee );


/*
Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) 
in STATION that is less than . Round your answer to  decimal places.
*/


select cast(long_w as decimal(10,4)) from station 
where  lat_n = (select max(lat_n) from station where lat_n <137.2345  );


/*
Query the smallest Northern Latitude (LAT_N) from STATION that is greater than . Round your answer to  decimal places.
*/


select cast(min(lat_n) as decimal(10,4)) from station 
where lat_n > 38.7780;