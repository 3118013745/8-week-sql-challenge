#对所有事物进行排序
select 
s.customer_id,
s.order_date,
m.product_name,
m.price,
case when s.order_date>=mb.join_date then "Y"
else "N" end as member,
IF(CASE WHEN s.order_date >= mb.join_date THEN 'Y' ELSE 'N' END = 'Y',
       RANK() OVER (PARTITION BY s.customer_id, (CASE WHEN s.order_date >= mb.join_date THEN 'Y' ELSE 'N' END)
                    ORDER BY s.order_date),
       NULL) AS ranking#排序
from 
sales as s 
join menu m on s.product_id=m.product_id
left join members mb on s.customer_id=mb.customer_id
order by s.customer_id,s.order_date

