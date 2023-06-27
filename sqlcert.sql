/*
COUNTRY PHONE NUMBER
*/

SELECT C.CUSTOMER_ID  , C.NAME  , CONCAT( "+",COC.COUNTRY_CODE,C.PHONE_NUMBER  )

FROM CUSTOMERS C
LEFT JOIN ON COUNTRY_CODES COC ON C.COUNTRY = COC.COUNTRY
;

/*
PROFITABLE STOCKS
*/
SELECT PT.STOCK_CODE 
FROM PRICE_TODAY PT
INNER JOIN PRICE_TOMORROW PTO ON PT.STOCK_CODE = PTO.STOCK_CODE 
WHERE PT.PRICE < PTO.PRICE
ORDER BY PT.STOCK_CODE
;


/*
Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy: 

Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers,
 total number of senior managers, total number of managers, and total number of employees. Order your output by 
 ascending company_code.

Note:

The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example,
 if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.
*/

select  c.company_code , c.founder , count( distinct lead_manager_code) ,
count( distinct senior_manager_code) ,
count( distinct manager_code) , count( distinct employee_code) 

from company c 
join 
employee em
on c.company_code = em.company_code

group by c.company_code , c.founder 
order by c.company_code
;