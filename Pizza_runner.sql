use pizza_runner;
select * from customer_orders;
update customer_orders
set exclusions = null
where exclusions = 0;

SELECT * FROM temp_table
WHERE exclusions  LIKE '%,%' or extras like '%,%' ;

alter table temp_table
modify exclusions DOUBLE;

UPDATE temp_table SET extras = REPLACE(extras, ',', '');

 select * from runner_orders;

update runner_orders 
set distance=case
					when distance like "%km%" then cast(replace(distance,"km","") as decimal(10,2))
                    else cast(distance as decimal(10,2))
			end;

update runner_orders 
set duration=case
					when duration like "%minutes%" then cast(replace(duration,"minutes","") as decimal(10,0))
                    when duration like "%mins%" then cast(replace(duration,"minutes","") as decimal(10,0))
                    when duration like "%minute%" then cast(replace(duration,"minute","") as decimal(10,0))
                    else cast(duration as decimal(10,0))
			end;
						





