update customer_orders
set  exclusions= null
where exclusions = '' or exclusions = 'null' or exclusions is null;

update customer_orders
set  extras= null
where extras = '' or extras = 'null' or extras is null;

update runner_orders
set distance= '0'
where distance= '' or distance= 'null' or distance is null;

update runner_orders
set  cancellation= 'No'
where cancellation is null or cancellation= '' or cancellation ='null';

update runner_orders
set cancellation='yes'
where  cancellation <> 'no' ;

update runner_orders
set duration = '0' 
where duration is null or duration='' or duration ='null' ;

update runner_orders
set pickup_time='0000-00-00 00:00:00'
where pickup_time is null or pickup_time='' or pickup_time='null';

alter table customer_orders
modify exclusions int;


CREATE TABLE temp_table AS
SELECT DISTINCT *
FROM customer_orders;
select * from temp_table;

drop table  customer_orders;

alter table temp_table
RENAME to customer_orders;
-- drop table temp_tab
select * from temp_table ;