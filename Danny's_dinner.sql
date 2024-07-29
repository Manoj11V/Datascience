 -- use `dannys_diner`;
-- What is the total amount each customer spent at the restaurant?
select distinct s.customer_id,sum(m.price) over (partition by  s.customer_id) as cost_spent
from menu m
join sales s on s.product_id = m.product_id
order by cost_spent DESC;

-- How many days has each customer visited the restaurant?
select customer_id, count(distinct order_date) as days_count
from sales
group by customer_id;

-- What was the first item from the menu purchased by each customer?
select distinct s.customer_id , first_value(m.product_name) over (partition by s.customer_id)  as First_ordered
from menu m
join sales s on s.product_id = m.product_id;

-- What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT 
  product_id,
  count
FROM (
  SELECT 
    product_id,
    COUNT(product_id) AS count 
  FROM sales
  GROUP BY product_id
) AS need
ORDER BY count DESC
LIMIT 1;

-- Which item was the most popular for each customer?
 select customer_id,product_id,max(count) as max_count
 from (select 
   customer_id,
   product_id,
   COUNT(product_id) AS count,
   ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY COUNT(product_id) DESC) AS rn
 from sales
 group by customer_id,product_id) as need
where rn=1
group by customer_id,product_id
order by max_count DESC;


-- Which item was purchased first by the customer after they became a member?
WITH FirstPurchases AS (
    SELECT 
        m.customer_id,
        s.product_id,
        s.order_date AS first_purchase_date,
        ROW_NUMBER() OVER (PARTITION BY m.customer_id ORDER BY s.order_date) AS rn
    FROM members m
    INNER JOIN sales s ON m.customer_id = s.customer_id
    WHERE s.order_date > m.join_date
)
select
	customer_id,
    product_id,
    first_purchase_date
from FirstPurchases
where rn = 1
order by customer_id;

-- Which item was purchased just before the customer became a member?

WITH FirstPurchases AS (
    SELECT 
        m.customer_id,
        s.product_id,
        s.order_date AS first_purchase_date,
        ROW_NUMBER() OVER (PARTITION BY m.customer_id ORDER BY s.order_date) AS rn
    FROM members m
    INNER JOIN sales s ON m.customer_id = s.customer_id
    WHERE s.order_date < m.join_date
)
select
	customer_id,
    product_id,
    first_purchase_date
from FirstPurchases
where rn = 1
order by customer_id;
 
 -- What is the total items and amount spent for each member before they became a member?
-- use `dannys_diner`;
 WITH TotalAmount AS (
    SELECT 
        m.customer_id,
        COUNT(s.product_id) AS count_product,
        SUM(m1.price) AS sum_price
    FROM members m
    INNER JOIN sales s ON m.customer_id = s.customer_id
    INNER JOIN menu m1 ON s.product_id = m1.product_id
    WHERE s.order_date < m.join_date
    GROUP BY m.customer_id
)
SELECT * FROM TotalAmount;


-- If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
with customer_points as(
   select 
       s.customer_id,
       sum(
            CASE 
               when product_name = 'sushi' then m.price *10 *2
               else m.price *10
			END 
          ) as total_points
    from menu m
    inner join sales s on m.product_id = s.product_id
    group by s.customer_id
)
select customer_id,total_points from customer_points
 order by total_points DESC;
 
 
 
 -- In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

with AfterJoining_points as(
   select 
       s.customer_id,
       sum(m.price * 2 * 10) as total_points
    from menu m
    inner join sales s on s.product_id = m.product_id
    inner join members m1 on m1.customer_id = s.customer_id
    where m1.join_date <= s.order_date
    group by s.customer_id
)

select * from AfterJoining_points;