#成为会员后，客户最先购买的是哪一项商品
with after_member as (
select
    s.customer_id,
    m.product_name,
    s.order_date,
    row_number() over(partition by s.customer_id order by s.order_date) as rn
from sales s
join members mb on s.customer_id=mb.customer_id
join menu m on s.product_id=m.product_id
where s.order_date >= mb.join_date
)
select customer_id,product_name
from after_member
where rn = 1;