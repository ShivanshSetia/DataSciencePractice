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


/*
Ketty gives Eve a task to generate a report containing three columns:
 Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received
  a grade lower than 8. The report must be in descending order by grade -- i.e. higher
   grades are entered first. If there is more than one student with the same grade (8-10)
    assigned to them, order those particular students by their name alphabetically. Finally,
     if the grade is lower than 8, use "NULL" as their name and list them by their grades in
      descending order. If there is more than one student with the same grade (1-7) assigned
       to them, order those particular students by their marks in ascending order.
*/

SELECT 
CASE 
WHEN G.GRADE>=8 THEN S.NAME
ELSE NULL
END AS NAM  , G.GRADE, S.MARKS FROM GRADES G
JOIN STUDENTS S ON S.MARKS>=G.MIN_MARK AND S.MARKS<=G.MAX_MARK
ORDER BY G.GRADE DESC, NAM ASC, S.MARKS ASC ;





/*

Julia just finished conducting a coding contest, and she needs your help assembling
the leaderboard! Write a query to print the respective hacker_id and name of hackers 
who achieved full scores for more than one challenge. Order your output in descending order
by the total number of challenges in which the hacker earned a full score. If more than one hacker
received full scores in same number of challenges, then sort them by ascending hacker_id.
*/




SELECT S.HACKER_ID, H.NAME
FROM SUBMISSIONS S
JOIN HACKERS H
ON H.HACKER_ID = S.HACKER_ID

JOIN 
(SELECT C.CHALLENGE_ID, D.SCORE 
    FROM DIFFICULTY D
    JOIN CHALLENGES C ON D.DIFFICULTY_LEVEL = C.DIFFICULTY_LEVEL ) AS CHAL 
ON S.CHALLENGE_ID = CHAL.CHALLENGE_ID  AND S.SCORE = CHAL.SCORE

GROUP BY S.HACKER_ID , H.NAME
HAVING COUNT(S.CHALLENGE_ID) > 1

ORDER BY COUNT(S.CHALLENGE_ID) DESC,  S.HACKER_ID ASC;



/*
Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.

Hermione decides the best way to choose is by determining the minimum number
 of gold galleons needed to buy each non-evil wand of high power and age. 
 Write a query to print the id, age, coins_needed, and power of the wands that Ron's 
 interested in, sorted in order of descending power. If more than one wand has same power, 
 sort the result in order of descending age.
*/


select  w.id, wp.age,w.coins_needed, w.power
from wands w
join 
wands_property wp
on wp.code = w.code
where  wp.is_evil = 0 and  w.coins_needed = 
 ( 
select min(w1.coins_needed) 
from wands w1
join wands_property wp1 
on wp1.code = w1.code 
where 
 w.power = w1.power and wp.age = wp1.age
) 

order by w.power desc , wp.age desc;


/*
Julia asked her students to create some coding challenges.
 Write a query to print the hacker_id, name, and the total number of challenges 
 created by each student. Sort your results by the total number of challenges in descending order.
  If more than one student created the same number of challenges, then sort the result by hacker_id.
   If more than one student created the same number of challenges and the count is less than
    the maximum number of challenges created, then exclude those students from the result.
*/

WITH SOLUTION AS (
SELECT h.hacker_id,
       h.name, 
       COUNT(c.hacker_id)AS num 
FROM hackers h JOIN challenges c
ON h.hacker_id = c.hacker_id
GROUP BY h.hacker_id, h.name
ORDER BY num DESC, h.hacker_id
)

SELECT * FROM SOLUTION 
WHERE num = (SELECT MAX(num) FROM SOLUTION) OR num in (SELECT num FROM SOLUTION GROUP BY num HAVING COUNT(num) = 1) ;





/*
You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!
The total score of a hacker is the sum of their maximum scores for all of the challenges.
 Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score.
  If more than one hacker achieved the same total score, then sort the result by ascending hacker_id.
   Exclude all hackers with a total score of 0 from your result.
*/


SELECT h.hacker_id,h.name,sum(s.score) as total_score 
from hackers h
join 
(
select hacker_id, max(score) as score
from submissions
group by hacker_id,challenge_id
) s
on h.hacker_id = s.hacker_id
group by h.hacker_id,h.name
having sum(score) > 0
order by sum(s.score) desc,h.hacker_id;




/*
P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

* * * * * 
* * * * 
* * * 
* * 
*
Write a query to print the pattern P(20).
*/


DECLARE @counter int = 20
WHILE @counter >= 1
BEGIN
PRINT replicate('* ', @counter)
SET @counter = @counter - 1
END;


/*
P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

* 
* * 
* * * 
* * * * 
* * * * *
Write a query to print the pattern P(20).
*/
DECLARE @counter int = 1
WHILE @counter <= 20
BEGIN
PRINT replicate('* ', @counter)
SET @counter = @counter + 1
END;