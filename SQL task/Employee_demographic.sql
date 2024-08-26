-- Count the number of employees in each age group.
SELECT 
    CASE 
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 29 THEN '18-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        ELSE '70 and above'
    END AS age_count,
    COUNT(*) AS count
FROM  `general_data`
GROUP BY age_count
ORDER BY age_count;

-- How many male and female employees are working?
SELECT Gender, COUNT(*) AS EmployeeCount
FROM `general_data`
WHERE Attrition='No'
GROUP BY Gender;

-- How many employees travel for business frequently, rarely, or never? (Rename column as EmployeeCount)
SELECT BusinessTravel,count(*) AS Employeecount
from `general_data`
group by BusinessTravel;

-- How many employees in each education field with more than 3 JobLevels, ordered by the count of employees in ascending order?
select 	EducationField,COUNT(*) AS emp_count
from `general_data`
where `JobLevel` > 3
group by `EducationField`
order by emp_count;

-- What is the average age of employees in each job role with 'Manager' in the title, ordered by average age in ascending order?
select JobRole,avg(Age) as avgage	
from `general_data`
where `JobRole` like '%Manager%'
group by `JobRole`
order by avgage;