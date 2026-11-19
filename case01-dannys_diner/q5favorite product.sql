#每位顾客最喜欢哪种商品
WITH customer_item_count AS (
  SELECT
    s.customer_id,
    m.product_name,
    COUNT(product_name) AS purchase_times,
    DENSE_RANK() OVER (PARTITION BY s.customer_id ORDER BY COUNT(product_name) DESC) AS rnk
  FROM sales as s
  JOIN menu m ON s.product_id = m.product_id
  GROUP BY s.customer_id, m.product_name
)
SELECT customer_id, product_name, purchase_times
FROM customer_item_count
WHERE rnk = 1;