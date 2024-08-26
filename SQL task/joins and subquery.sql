-- use EMPLOYEE;
select * from `general_data`;
select * from `employee_survey_data`;

-- What is the monthly income and job satisfaction level of each employee?(Using General_data and employee_survey_data)
select e.`EmployeeID` , g.`MonthlyIncome`,e.`JobSatisfaction`
from `general_data` g
join `employee_survey_data` e on e.EmployeeID=g.EmployeeID;

-- How many employees are there in each job role with their respective job satisfaction levels?
SELECT g.JobRole, e.JobSatisfaction, COUNT(*) AS employee_count
FROM general_data g
JOIN employee_survey_data e ON g.EmployeeID = e.EmployeeID
GROUP BY g.JobRole , e.JobSatisfaction 
ORDER BY g.JobRole ,e.JobSatisfaction ;

-- Get the gender and work-life balance level for each employee, including those without any survey data.
select  e.EmployeeID,g.Gender,e.WorkLifeBalance
from general_data g
join employee_survey_data e on g.EmployeeID=e.EmployeeID;

-- Get the job role, work-life balance, and performance rating of employees, only for those with data in all tables.
/*update employee_survey_data1
set JobSatisfaction='0'
where JobSatisfaction ='NA';
update employee_survey_data1
set WorkLifeBalance='0'
where WorkLifeBalance ='NA';
update employee_survey_data1
set EnvironmentSatisfaction='0'
where EnvironmentSatisfaction ='NA';
*/
alter table employee_survey_data1
modify column WorkLifeBalance int;

alter table employee_survey_data1
modify column JobSatisfaction int;

alter table employee_survey_data1
modify column EnvironmentSatisfaction int;

select * from employee_survey_data1;

select e.EmployeeId,g.JobRole,e.WorkLifeBalance,m.PerformanceRating
from general_data g
inner join employee_survey_data1 e on g.EmployeeID=e.EmployeeID
inner join manager_survey_data m on m.EmployeeID=e.EmployeeID
where e.WorkLifeBalance!=0
order by e.EmployeeID;

-- Find the employee ID who has a monthly income above the average monthly income.

select EmployeeID 
from general_data 
where MonthlyIncome > (select avg(MonthlyIncome) from general_data);

-- Find the employee ID who lives closer than the average distance from home.
select EmployeeId
from general_data
where DistanceFromHome < (select avg(DistanceFromHome) from general_data);