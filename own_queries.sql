-- total amount spent for  highest sales food for  each customer
with highest_sales as
 (	
	select 
		product_name,
        customer_id,
        price,
        COUNT(product_name) as count,
        row_number() over (partition by customer_id order by count(product_name) desc ) as rn
	from customer_summary
	group by customer_id,product_name,price
	order by count desc
 )
 select 
      customer_id,
      sum(price) * count as major_sales
from highest_sales
where rn =1
group by customer_id,count;

-- highest ranking price for each  of the customers
with high_rank as(select *,
	dense_rank() over (partition by customer_id order by order_date, price desc)
	as Ranking
from customer_summary where member = 'Y'
UNION ALL
select *,
	NULL
	as Ranking
from customer_summary 
where member = 'N'
order by customer_id, ranking)

select
    customer_id, 
    product_name
    from high_rank 
    where Ranking = 1;

