-- Find employees who have a monthly income above 5000
with monthinco as (
	select 
		EmployeeID,
        MonthlyIncome
	from general_data
    where MonthlyIncome > 5000)
select 
		EmployeeId,
        MonthlyIncome
	from monthinco;
    
-- Calculate the total monthly income for each department

WITH totalmonthinco as(
	select distinct
		Department,
        sum(MonthlyIncome) over (partition by Department 
                    order by Department) as Sum_income
	from general_data)
select * 
  from totalmonthinco;