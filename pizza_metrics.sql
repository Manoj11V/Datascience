use `pizza_runner`;
-- How many pizzas were ordered?
select * from customer_orders;
select * from runner_orders;
select    
   count(c.pizza_id) as pizza_ordered
from customer_order c; 

-- How many unique customer orders were made?
select count(Unique_customers) as number_customers
from (select 
    count(customer_id) as Unique_customers
from customer_orders
group by customer_id) as a;

-- How many successful orders were delivered by each runner?
select runner_id ,
	count(case 
			when cancellation = 'No'  then 1
		 end ) as sucessful_orders
from runner_orders
group by runner_id
;

-- Another code for the successful orders
select runner_id ,
	count(*)as count_delivery
from runner_orders
where cancellation = 'no'
group by runner_id;

-- How many of each type of pizza was delivered?

select 
   pizza_id ,
   count(*)  as number_pizza
from customer_orders c
left join runner_orders r on c.order_id=r.order_id
where cancellation = "No"
group by pizza_id;

-- How many Vegetarian and Meatlovers were ordered by each customer?
select 
     customer_id,
     count( case 
		when pizza_id = 1 then "Vegetarian"
      end ) as "Vegetarian",
	 count( case 
		when pizza_id = 2 then "MeatLovers"
      end ) as "MeatLovers"
from customer_orders
group by customer_id;

-- What was the maximum number of pizzas delivered in a single order?
with max_pizza as (select order_id,
                    count(*) as number_pizza
                    from customer_orders
                    group by order_id
                     )
select * from max_pizza order by number_pizza desc limit 1 ;

-- For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
create table temp_table(select * from customer_orders);
select * from temp_table;
/*select	
	order_id,
    customer_id,
    exclusions,
    value as single_value
from 
	temp_table,
    JSON_TABLE(
		concat('["',replace(exclusions,',','","'),'"]'),'$[*]' columns	(value int path '$') 
	)as jt;*/
select 
	c.customer_id,
	count(case
		when (c.exclusions is not null or c.extras  is not null) and r.cancellation = 'No' then 1
	end) as count_changes,
	count(case 
		when (c.exclusions is null and c.extras is null) and r.cancellation = 'No' then 1
	end) as count_Nochanges
from customer_orders c
join runner_orders r on c.order_id=r.order_id
group by c.customer_id;
-- where r.cancellation !='No';

-- How many pizzas were delivered that had both exclusions and extras?
select 
	count(case
		when (c.exclusions is not null and c.extras  is not null) and r.cancellation = 'No' then 1
	end) as count_changes
from customer_ordesrs c
join runner_orders r on c.order_id=r.order_id;

-- What was the total volume of pizzas ordered for each hour of the day?
with date_month as(
	select 
		pizza_id,
        extract(hour from order_time ) as hour_extracted
	from customer_orders
) 
select
    hour_extracted, 
	count(pizza_id) pizza_count_hour
from date_month 
group by hour_extracted;
-- What was the volume of orders for each day of the week?
with date_month as(
	select 
		pizza_id,
        date(order_time) as day_extracted
	from customer_orders
)
select 
     dayname(day_extracted) as days,
     count(pizza_id) as num_pizzas_day
from date_month
group by days;
     
