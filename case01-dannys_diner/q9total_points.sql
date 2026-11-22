#如果每花1美元相当于10积分，而寿司有2倍积分倍数——那每位顾客会有多少积分
SELECT
    s.customer_id,
    SUM(
        CASE m.product_name
            WHEN 'sushi' THEN m.price * 10 * 2
            ELSE m.price * 10
        END
    ) AS total_points
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id;