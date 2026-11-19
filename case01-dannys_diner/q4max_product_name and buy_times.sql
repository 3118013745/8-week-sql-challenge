#菜单上购买次数最多的是什么，所有顾客购买了多少次
select 
m.product_name as max_product_name,
count(s.product_id) as buy_times
from sales as s join menu m on s.product_id=m.product_id
group by max_product_name
order by buy_times desc
limit 1;