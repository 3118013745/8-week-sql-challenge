#每位顾客从菜单上购买的第一件商品
with rank_order as (
	select 
	s.customer_id,
	m.product_name as first_product_name,
	s.order_date,row_number() over (
	partition by s.customer_id
	order by s.order_date asc
	)as rn 
	from sales as s 
	join menu as m on s.product_id=m.product_id
	)
	select distinct customer_id,first_product_name
	from rank_order
	where rn=1;
	