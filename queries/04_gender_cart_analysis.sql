-- Compare number of cart actions per gender
SELECT 
    u.gender,
    COUNT(ce.event_id) AS total_cart_events
FROM cart_events ce
JOIN sessions s ON ce.session_id = s.session_id
JOIN users u ON s.user_id = u.user_id
GROUP BY u.gender;

-- Compare average price of added-to-cart products per gender
SELECT 
    u.gender,
    ROUND(AVG(p.price), 2) AS avg_price_in_cart
FROM cart_events ce
JOIN sessions s ON ce.session_id = s.session_id
JOIN users u ON s.user_id = u.user_id
JOIN products p ON ce.product_id = p.product_id
GROUP BY u.gender;

