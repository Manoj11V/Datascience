select * from pizza_recipe;
select extras from customer_orders;
create table temp_table (select * from customer_orders);
-- Creating separate values
SELECT
  order_id,
  customer_id,
  exclusions,
  exc_single_value.exc AS exc_single_value,
  extras,
  ext_single_value.ext AS ext_single_value
FROM 
  temp_table
LEFT JOIN JSON_TABLE(
  concat('["', replace(exclusions, ',', '","'), '"]'), '$[*]'
  COLUMNS (exc INT PATH '$')
) AS exc_single_value ON TRUE
LEFT JOIN JSON_TABLE(
  concat('["', replace(extras, ',', '","'), '"]'), '$[*]'
  COLUMNS (ext INT PATH '$')
) AS ext_single_value ON TRUE;

select * from temp_table;

-- Creating order_items
with ref_order as (select 
	c.order_id as oi,
    c.exclusions as ex,
    c.extras as ext,
    c.pizza_id as cpi,
    pn.pizza_name as pin
    from customer_orders c
join pizza_names as pn on c.pizza_id=pn.pizza_id),
ref2_order as(
	select * from pizza_toppings
)

select 
	r1.oi,
	case 
		when r1.ex is null and r1.ext is null then r1.pin
        when r1.ex is null and r1.ext is not null then CONCAT(r1.pin, ' - Extras ', GROUP_CONCAT(DISTINCT r2.topping_name ORDER BY r2.topping_name SEPARATOR ', '))
	end  as order_item
from ref_order as r1
LEFT JOIN ref2_order r2 ON  r1.ext like concat("%, ",r2.topping_id,"%") or r1.ext like concat(r2.topping_id,"%")
group by r1.oi ;
 select * from pizza_toppings; 
 
 
 -- testing
WITH ref_order AS (
  SELECT 
    c.order_id AS oi,
    c.exclusions AS ex,
    c.extras AS ext,
    c.pizza_id AS cpi,
    pn.pizza_name AS pin
  FROM customer_orders c
  JOIN pizza_names pn ON c.pizza_id = pn.pizza_id
),
ref2_order AS (
  SELECT * FROM pizza_toppings
)

SELECT 
  r1.oi,
  CASE 
    WHEN r1.ex IS NULL AND r1.ext IS NULL THEN r1.pin
    WHEN r1.ex IS NULL AND r1.ext IS NOT NULL THEN CONCAT(r1.pin, ' - Extras ', GROUP_CONCAT(DISTINCT r2.topping_name ORDER BY r2.topping_name SEPARATOR ', '))
    WHEN r1.ex IS NOT NULL AND r1.ext IS NULL THEN CONCAT(r1.pin, ' - Exclude ', GROUP_CONCAT(DISTINCT r3.topping_name ORDER BY r3.topping_name SEPARATOR ', '))
    WHEN r1.ex IS NOT NULL AND r1.ext IS NOT NULL THEN CONCAT(r1.pin, ' - Exclude ', GROUP_CONCAT(DISTINCT r3.topping_name ORDER BY r3.topping_name SEPARATOR ', '), ' - Extras ', GROUP_CONCAT(DISTINCT r2.topping_name ORDER BY r2.topping_name SEPARATOR ', '))
  END AS order_item
FROM ref_order AS r1
LEFT JOIN ref2_order r2 ON FIND_IN_SET(r2.topping_id, r1.ext) > 0
LEFT JOIN ref2_order r3 ON FIND_IN_SET(r3.topping_id, r1.ex) > 0
GROUP BY r1.oi, r1.pin, r1.ex, r1.ext;



WITH ref_order AS (
  SELECT 
    c.order_id AS oi,
    c.exclusions AS ex,
    c.extras AS ext,
    c.pizza_id AS cpi,
    pn.pizza_name AS pin
  FROM customer_orders c
  JOIN pizza_names pn ON c.pizza_id = pn.pizza_id
),
ref2_order AS (
  SELECT * FROM pizza_toppings
)

SELECT 
  r1.oi,
  CASE 
    WHEN r1.ex IS NULL AND r1.ext IS NULL THEN r1.pin
    WHEN r1.ex IS NULL AND r1.ext IS NOT NULL THEN CONCAT(r1.pin, ' - Extras ', GROUP_CONCAT(DISTINCT r2.topping_name ORDER BY r2.topping_name SEPARATOR ', '))
    WHEN r1.ex IS NOT NULL AND r1.ext IS NULL THEN CONCAT(r1.pin, ' - Exclude ', GROUP_CONCAT(DISTINCT r3.topping_name ORDER BY r3.topping_name SEPARATOR ', '))
    WHEN r1.ex IS NOT NULL AND r1.ext IS NOT NULL THEN CONCAT(r1.pin, ' - Exclude ', GROUP_CONCAT(DISTINCT r3.topping_name ORDER BY r3.topping_name SEPARATOR ', '), ' - Extras ', GROUP_CONCAT(DISTINCT r2.topping_name ORDER BY r2.topping_name SEPARATOR ', '))
  END AS order_item
FROM ref_order AS r1
LEFT JOIN ref2_order r2 ON r1.ext like concat("%, ",r2.topping_id,"%") or r1.ext like concat(r2.topping_id,"%") 
LEFT JOIN ref2_order r3 ON r1.ex like concat("%, ",r3.topping_id,"%") or r1.ex like concat(r3.topping_id,"%")
GROUP BY r1.oi, r1.pin, r1.ex, r1.ext;
