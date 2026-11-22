#在客户成为会员之前刚购买的商品是哪一项
WITH before_member AS (
SELECT
    s.customer_id,
    m.product_name,
    s.order_date,
    ROW_NUMBER() OVER(PARTITION BY s.customer_id ORDER BY s.order_date DESC) AS rn
FROM sales s
JOIN members mb ON s.customer_id = mb.customer_id
JOIN menu m ON s.product_id = m.product_id
WHERE s.order_date < mb.join_date
)
SELECT customer_id, product_name
FROM before_member
WHERE rn = 1;