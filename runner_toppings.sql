
--  What are the standard ingredients for each pizza?
create table pizza_recipe as (select	
	pizza_id,
    toppings,
    value as Topping
from 
	pizza_recipes,
    JSON_TABLE(
		concat('["',replace(toppings,',','","'),'"]'),'$[*]' columns	(value int path '$') 
	)as jt);
select * from pizza_recipe;
alter table pizza_recipe 
drop toppings; 

select 
    p.pizza_id, 
    JSON_ARRAYAGG(pt.topping_name) AS Ingredients
from pizza_recipe p
join pizza_toppings pt ON p.Topping = pt.topping_id
group by p.pizza_id;

-- What was the most commonly added extra?
 select   p.topping_name,
          count(extras) as counting 
 from pizza_toppings as p 
join customer_orders as c on  c.extras like concat("%, ",p.topping_id,"%") or c.extras like concat(p.topping_id,"%")
where c.extras is not null
group by p.topping_name
order by counting desc 
limit 1;

-- What was the most common exclusion?
  with sample as(
	select   p.topping_name,
         count(c.exclusions) as counting 
 from pizza_toppings as p 
join customer_orders as c on  c.exclusions like concat("%, ",p.topping_id,"%") or c.exclusions like concat(p.topping_id,"%")
where c.exclusions is not null
group by p.topping_name
 ),
sample1 as (select topping_name,
				counting,
		dense_rank() over(order by counting desc) as rnk
 from sample
)
select topping_name,
	   counting
from sample1 as s1
where s1.rnk =1;
/*Generate an order item for each record in the customers_orders table in the format of one of the following:
        Meat Lovers
        Meat Lovers - Exclude Beef
        Meat Lovers - Extra Bacon
        Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
    
   
*/



with ref_order as (select 
    c.order_id as oi,
    c.exclusions as ex,
    c.extras as ext,
    c.pizza_id as cpi,
    pn.pizza_name as pin
    from customer_orders as c
join pizza_names as pn on c.pizza_id=pn.pizza_id),
ref2_order as (select * from pizza_toppings)
select
	r1.oi,
	case 
		when r1.ex is null and r1.ext is null then r1.pin
        when r1.ex is null  and r1.ext is not null then concat(r1.pin ," -Extras ",group_concat(distinct r2.topping_name  separator ', '))
		when r1.ex is not null  and r1.ext is null then concat(r1.pin ," -Exclude ",group_concat(distinct r3.topping_name separator ', '))
        when r1.ex is not null  and r1.ext is not null then concat(r1.pin ," -Exclude ",group_concat(distinct r3.topping_name separator ', ')," -Extras ",group_concat(distinct r2.topping_name separator ', '))
	end  as order_item
from ref_order as r1
left join ref2_order as r2 on  r1.ext like concat("%, ",r2.topping_id,"%") or r1.ext like concat(r2.topping_id,"%")
left join ref2_order as r3 on  r1.ex like concat("%, ",r3.topping_id,"%") or r1.ex like concat(r3.topping_id,"%")
group by r1.oi,r1.pin,r1.ex,r1.ext;

-- Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
     --   For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"
with ref_order as (select 
    c.order_id as oi,
    c.exclusions as ex,
    c.extras as ext,
    c.pizza_id as cpi,
    pn.pizza_name as pin
    from customer_orders as c
join pizza_names as pn on c.pizza_id=pn.pizza_id),
ref2_order as (select * from pizza_toppings)
select
	r1.oi,
    r1.cpi,
    p3.toppings,
	case 
		when r1.ex is null and r1.ext is null then r1.pin
        when r1.ex is null  and r1.ext is not null then concat(r1.pin ,":",group_concat(distinct r2.topping_name order by r2.topping_name  separator ', '))
		when r1.ex is not null  and r1.ext is null then concat(r1.pin ," -Exclude ",group_concat(distinct r3.topping_name order by r3.topping_name separator ', '))
        when r1.ex is not null  and r1.ext is not null then concat(r1.pin ," -Exclude ",group_concat(distinct r3.topping_name order by r3.topping_name separator ', ')," -Extras ",group_concat(distinct r2.topping_name order by r2.topping_name separator ', '))
	end  as order_item
from ref_order as r1
left join ref2_order as r2 on  r1.ext like concat("%, ",r2.topping_id,"%") or r1.ext like concat(r2.topping_id,"%")
left join ref2_order as r3 on  r1.ex like concat("%, ",r3.topping_id,"%") or r1.ex like concat(r3.topping_id,"%")
left join pizza_recipes as p3 on p3.pizza_id =r1.cpi
group by r1.oi,r1.pin,r1.ex,r1.ext,r1.cpi,p3.toppings;



--  What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?