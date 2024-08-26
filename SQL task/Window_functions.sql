-- Assign a rank to each employee based on their monthly income.(Using Window Function)
select 
	EmployeeId,
    MonthlyIncome,
    dense_rank() over (order by MonthlyIncome desc)
			as rank_income
from general_data
order by MonthlyIncome desc;

-- Calculate the average monthly income within each department.(Using Window Function)


select distinct
     Department,
     avg(MonthlyIncome) over (partition by Department ) 
     as avg_department
from general_data;

-- Calculate the third highest monthly income within each department.
select distinct MonthlyIncome,Department
from (select
	EmployeeID,
    Department,
    MonthlyIncome,
    dense_rank() over (partition by Department
                       order by MonthlyIncome desc
                       )
	as rank_income
from general_data) ranked
where rank_income=3;

-- Calculate the difference between each employee's monthly income and the previous employee's monthly income in the dataset.
select 
	EmployeeID,
    MonthlyIncome,
    MonthlyIncome - lag(MonthlyIncome) over (order by EmployeeID) as diff_income
from general_data;
