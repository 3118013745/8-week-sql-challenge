#每位会员在成为会员之前，总计的物品和花费金额是多少
select 
s.customer_id,
count(s.product_id) as total_product,
sum(m.price) as total_spend
from 
sales as s
join members mb on s.customer_id=mb.customer_id
join menu m on s.product_id=m.product_id
where s.order_date<mb.join_date 
group by s.customer_id;