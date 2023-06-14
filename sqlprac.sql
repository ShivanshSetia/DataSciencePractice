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


/*
Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than .
 Round your answer to  decimal places.
*/

SELECT CAST(LONG_W AS DECIMAL(10,4)) FROM STATION 
WHERE LAT_N = (SELECT MIN(LAT_N) FROM STATION WHERE LAT_N > 38.7780); 

/*
Consider a,b and c,d to be two points on a 2D plane.

a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
*/

select cast(round( abs(max(lat_n) -min(lat_n)) + abs(max(long_w) - min(long_w)),4) as decimal(10,4) )
from station;



/*
Query the Euclidean Distance between points P1 and P2 format your answer to display  decimal digits.
*/

select cast(   round(   sqrt( power(abs(max(lat_n) -min(lat_n)),2) + 
                     power(abs(max(long_w) - min(long_w)),2) )    ,4) as decimal(10,4) )
from station;


/*
A median is defined as a number separating the higher half of a data set from the lower half.
 Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.
*/

select 
(
cast
(
   ( 
    (select max(lat_n) 
     from (select top 50 percent lat_n from station order by lat_n) as onehalf)
    +
    (select min(lat_n) 
     from (select top 50 percent lat_n from station order by lat_n desc) as otherhalf)
 
)/2 as decimal(10,4)  ) 
) as median 


/*
Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
*/

SELECT SUM(CITY.POPULATION)
FROM CITY
INNER JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.CONTINENT = "ASIA";

/*
Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/


SELECT CITY.NAME
FROM CITY
INNER JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.CONTINENT = "Africa";

/*
Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and
 their respective average city populations (CITY.Population) rounded down to the nearest integer.
*/


SELECT Country.Continent , cast(round(avg(CITY.Population),0)  as decimal(10,0) )
FROM CITY
INNER JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
group by Country.continent
