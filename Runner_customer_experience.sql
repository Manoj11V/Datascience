-- How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
/*WITH week_n AS (
    SELECT
        runner_id,
        DATE(pickup_time) AS extracted_date
    FROM runner_orders
)
SELECT
     floor(datediff(extracted_date,' 2021-01-01')/7)AS week_number,
    COUNT(runner_id) AS runners_signed
FROM week_n
where extracted_date is not null
GROUP BY week_number
ORDER BY week_number;*/
select 
	week(registration_date,1)-week('2021-01-01',1) + 1  as week_number,
    count(runner_id) as runners_signed
 from runners
 group by week_number;
        
-- What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
    with time_runners as 
		(
			select 
				c.order_id as customer_order_id,
                r.order_id as runner_order_id,
                r.runner_id,
                -- time(c.order_time) as order_time,
                -- time(r.pickup_time) as pickup_time
                c.order_time as order_time,
                r.pickup_time as pickup_time
			from customer_orders c
            left join runner_orders r on c.order_id = r.order_id
            where r.pickup_time is not null)
select 
	runner_id,
   --  case 
    -- when order_time < pickup_time then 
	round(avg(abs(timestampdiff(minute,pickup_time,order_time))) ,0) as average_runner
	/*else 
		 abs(1440-timestampdiff(minute,pickup_time,order_time)) */
	-- end as minutes_runner_arrival
from time_runners
group by runner_id;	
            
    
-- Is there any relationship between the number of pizzas and how long the order takes to prepare?
with order_prepare as 
	(select 
		c.order_id,
        c.pizza_id,
        abs(timestampdiff(minute,c.order_time,r.pickup_time)) as time_diff
	from customer_orders c
	join runner_orders r on c.order_id=r.order_id
    where r.pickup_time is not null
    ),
number_pizza as(select 
					order_id,
                    count(pizza_id ) as number_pizzas
				from customer_orders
                GROUP BY order_id)

select 
      n.order_id,
      n.number_pizzas,
      avg(o.time_diff) as average_time_waiting
from number_pizza n
join order_prepare o on n.order_id=o.order_id
group by n.order_id;

-- What was the average distance travelled for each customer?
select c.customer_id, 
		avg(r.distance)  as avg_distance
from runner_orders r
join customer_orders c on r.order_id = c.order_id
group by customer_id;


-- What was the difference between the longest and shortest delivery times for all orders?
with del as(select 
      max(timestampdiff(minute,order_time,pickup_time))+max(duration) as max_time,
       min(timestampdiff(minute,order_time,pickup_time))+min(duration)  as min_time
from runner_orders r
join customer_orders c on r.order_id = c.order_id)
select max_time - min_time  as tot_differ
from del;
-- What was the average speed for each runner for each delivery and do you notice any trend for these values?
select runner_id,
	order_id,
		(distance*1000)/(duration*60) as avg_speed
from runner_orders
where cancellation='No';

-- What is the successful delivery percentage for each runner?
select runner_id,
	count(runner_id) as total_delivery,
    count(case 
			when cancellation='No'then 1  end) as expected_delivery,
	round(count(case 
			when cancellation='No'then 1  end)/count(runner_id) *100 ) as Percent
from runner_orders
group by runner_id
     
