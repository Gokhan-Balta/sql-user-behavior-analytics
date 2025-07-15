-- EDA

-- Total number of registrations per table
SELECT 'users' AS table_name, COUNT(*) AS row_count From users
UNION ALL 
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sessions', COUNT(*) FROM sessions
UNION ALL
SELECT 'pageviews', COUNT(*) FROM pageviews
UNION ALL
SELECT 'cart_events', COUNT(*) FROM cart_events
UNION ALL
SELECT 'purchases', COUNT(*) FROM purchases;




-- Top 10 products with the most page views
SELECT 
    pv.product_id,
    p.name,
    COUNT(*) AS view_count
FROM pageviews pv
JOIN products p ON pv.product_id = p.product_id
GROUP BY pv.product_id, p.name
ORDER BY view_count DESC
LIMIT 10;

-- Most purchased products
SELECT
	pr.product_id,
	p.name,
	COUNT(*) AS purchase_count
FROM purchases pr
JOIN products p ON pr.product_id = p.product_id
GROUP BY pr.product_id, p.name
ORDER BY purchase_count DESC
LIMIT 10;


-- How many users from which city?
SELECT 
	city, COUNT(*) AS user_count
FROM users
GROUP BY city
ORDER BY user_count DESC;


-- average session duration
SELECT 
    ROUND(AVG(EXTRACT(EPOCH FROM (session_end - session_start)) / 60), 2) AS avg_session_minutes
FROM sessions;









