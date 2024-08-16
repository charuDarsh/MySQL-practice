USE HealthcareSystemDB1;
-- **Ticket 6: CASE Statement**

-- - **Description:** Use the `CASE` statement to categorize data based on conditions.
  
   -- - **Tasks:**
 -- 1. **Create a query that labels bills as 'High' if the `TotalAmount` is greater than $1000, 'Medium' if between $500 and $1000, and 'Low' if below $500.**
 --    - Use a `CASE` statement to categorize each bill based on `TotalAmount`.
 
 Select TotalAmount ,
 CASE 
 WHEN TotalAmount > 1000 THEN 'High' 
 WHEN TotalAmount >=500 and TotalAmount<=1000 THEN 'Medium'
 WHEN TotalAmount< 500 THEN 'Low'
 ELSE 'Out of Range' END AS EXPENSE 
 FROM billing ORDER BY TotalAmount;
 
 

 
--  2. **Write a query to show patients labeled as 'Minor' if their age is less than 18, 'Adult' if between 18 and 65, and 'Senior' if older than 65.**
--     - Use `CASE` to create age categories based on `DateOfBirth`.

select timestampdiff(YEAR,DateOfBirth,CURDATE()) as AvgAGe,
CASE
WHEN timestampdiff(YEAR,DateOfBirth,CURDATE())<18 THEN 'Minor'
WHEN timestampdiff(YEAR,DateOfBirth,CURDATE()) BETWEEN 18 and 65  THEN 'Adult'
WHEN timestampdiff(YEAR,DateOfBirth,CURDATE())>65 THEN 'Senior'
ELSE 'Out of age'
END as ActualAge 
from patients order by AvgAGe;












