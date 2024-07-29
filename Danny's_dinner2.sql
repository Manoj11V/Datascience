	-- Recreating the output by joining the three tables
with full_table as (
select 
    s.product_id AS sales_product_id, 
    s.customer_id AS sales_customer_id, 
    s.order_date, 
    m.product_id AS menu_product_id, 
    m.product_name, 
    m.price,
    m1.customer_id AS member_customer_id, 
    m1.join_date
from  sales  as s 
left  join menu m on m.product_id= s.product_id
left  join members m1 on m1.customer_id = s.customer_id)
 select 
	sales_customer_id as customer_id,
    order_date,
    product_name,
	price,
    case 
        when sales_customer_id is not null and join_date <= order_date then 'Y'
        else 'N'
	end as `member`
from full_table
order by customer_id and order_date;

-- Ranking 
CREATE TABLE customer_summary AS
WITH full_table AS (
    SELECT 
        s.product_id AS sales_product_id, 
        s.customer_id AS sales_customer_id, 
        s.order_date, 
        m.product_id AS menu_product_id, 
        m.product_name, 
        m.price,
        m1.customer_id AS member_customer_id, 
        m1.join_date
    FROM sales AS s 
    LEFT JOIN menu m ON m.product_id = s.product_id
    LEFT JOIN members m1 ON m1.customer_id = s.customer_id
)
SELECT 
    sales_customer_id AS customer_id,
    order_date,
    product_name,
    price,
    CASE 
        WHEN sales_customer_id IS NOT NULL AND join_date <= order_date THEN 'Y'
        ELSE 'N'
    END AS `member`
FROM full_table
ORDER BY customer_id, order_date;

-- first_code
select *,
	case
		when `member` = 'Y' then   dense_rank() over (partition by customer_id  order by order_date,price desc) 
        else  null
	end as Ranking
from customer_summary ;


-- Rohit_code
select *,
	dense_rank() over (partition by customer_id order by order_date, price desc)
	as Ranking
from customer_summary where member = 'Y'

UNION 

select *,
	NULL
	as Ranking
from customer_summary 
where member = 'N'
order by customer_id, ranking;

-- using CTE 
WITH ranked_summary AS (
    SELECT *,
		DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY customer_id,order_date, price DESC) as ranking
    FROM customer_summary 
)

SELECT *,
	case 
		when `member` = 'Y' then Ranking
        else null
	end as final_ranking
FROM ranked_summary
ORDER BY customer_id, `member`, Ranking;

-- corrected code
select *,
	dense_rank() over (partition by customer_id order by order_date, price desc)
	as Ranking
from customer_summary where member = 'Y'

UNION ALL 

select *,
	NULL
	as Ranking
from customer_summary 
where member = 'N'
order by customer_id, ranking;