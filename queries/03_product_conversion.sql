-- Analyze conversion funnel at the product level
SELECT 
    p.product_id,
    p.name AS product_name,

    -- Number of times the product was viewed
    COUNT(DISTINCT pv.view_id) AS views,

    -- Number of times the product was added to cart
    COUNT(DISTINCT ce.event_id) AS adds_to_cart,

    -- Number of times the product was purchased
    COUNT(DISTINCT pur.purchase_id) AS purchases,

    -- Conversion rates between stages
    ROUND(100.0 * COUNT(DISTINCT ce.event_id) / NULLIF(COUNT(DISTINCT pv.view_id), 0), 2) AS view_to_cart_rate,
    ROUND(100.0 * COUNT(DISTINCT pur.purchase_id) / NULLIF(COUNT(DISTINCT ce.event_id), 0), 2) AS cart_to_purchase_rate,
    ROUND(100.0 * COUNT(DISTINCT pur.purchase_id) / NULLIF(COUNT(DISTINCT pv.view_id), 0), 2) AS view_to_purchase_rate

FROM products p
LEFT JOIN pageviews pv ON p.product_id = pv.product_id
LEFT JOIN cart_events ce ON p.product_id = ce.product_id
LEFT JOIN purchases pur ON p.product_id = pur.product_id

GROUP BY p.product_id, p.name
ORDER BY views DESC
LIMIT 20;