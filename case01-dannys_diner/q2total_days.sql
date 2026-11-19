#每位顾客光顾餐厅多少天
select s.customer_id,count(distinct s.order_date) as total_days
from sales as s
group by customer_id;