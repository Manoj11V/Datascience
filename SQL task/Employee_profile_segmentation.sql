-- Find the employees who work in either the Sales or Research and Development departments.
select EmployeeID
from general_data
where Department = 'Sales' or Department ='Research & Development';

-- Find the employees who are in either Job Level 3 or Job Level 4.
select EmployeeID 
from general_data
where JobLevel =3 or JobLevel =4;

-- Classify employees into income brackets ('Low', 'Medium', 'High') based on their monthly income.(Low=20,000 and Medium= 20,000 to 70,000 , high>=70,000)
select 
    EmployeeID,
	case
		when MonthlyIncome <= 20000 then 'LOW'
        	when MonthlyIncome between 20000 and 70000 then 'Medium'
        	when MonthlyIncome >= 70000 then 'High'
	end as income_range
from general_data;

-- Categorize employees based on their distance from home into 'Close', 'Medium', and 'Far'. (close<=7, medium 7 to 20, far>=20)
	select 
	EmployeeId,
    case
		when DistanceFromHome <= 7 then 'Close'
        	when DistanceFromHome between 7 and 20 then 'Medium'
        	when DistanceFromHome >=20 then 'Far'
	end as distance_range
from general_data;

-- Create a summary that counts employees in each department by job level.(using case statement)
use `EMPLOYEE`;
select
	Department,
    sum(case
			when JobLevel = 1 then 1
			else 0
        end ) as one_count,
	sum(case
			when JobLevel = 2 then 1
            else 0
		end) as two_count,
	sum(case
			when JobLevel = 3 then 1
            else 0
		end) as three_count,
	sum(case 
			when JobLevel = 4  then 1
            else 0
		end) as four_count,
	sum(case 
			when JobLevel = 5 then 1
            else 0
		end) as five_count
from general_data
group by Department
order by Department;
        
        
