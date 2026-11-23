#客户加入计划的第一周（包括加入日期）会在所有商品上获得2倍积分，不仅仅是寿司——客户A和B在一月底时有多少积分
WITH dates_cte AS (
    SELECT 
        customer_id,
        join_date,
        DATE_ADD(join_date, INTERVAL 6 DAY) AS valid_date 
    FROM members
)
SELECT
    dc.customer_id,
    SUM(
        CASE
            WHEN s.order_date BETWEEN dc.join_date AND dc.valid_date THEN m.price * 20#第一周全部商品*20
            WHEN m.product_name = 'sushi' THEN m.price * 20#非第一周sushi*20
            ELSE m.price * 10#非第一周其他商品*10
        END
    ) AS total_points
FROM dates_cte dc
JOIN sales s ON dc.customer_id = s.customer_id
JOIN menu m ON s.product_id = m.product_id
WHERE s.order_date <= '2021-01-31'#一月底
GROUP BY dc.customer_id;