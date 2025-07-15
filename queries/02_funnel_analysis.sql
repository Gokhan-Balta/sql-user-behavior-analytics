-- Create a user-level funnel view showing who started a session, viewed a product, added to cart, and made a purchase
SELECT 
    u.user_id,
    u.city,

    -- Whether the user has started at least one session
    CASE WHEN COUNT(DISTINCT s.session_id) > 0 THEN 1 ELSE 0 END AS session_started,
    -- Whether the user has viewed at least one product
    CASE WHEN COUNT(DISTINCT pv.view_id) > 0 THEN 1 ELSE 0 END AS product_viewed,
    -- Whether the user has added at least one product to cart
    CASE WHEN COUNT(DISTINCT ce.event_id) > 0 THEN 1 ELSE 0 END AS added_to_cart,
    -- Whether the user has made at least one purchase
    CASE WHEN COUNT(DISTINCT p.purchase_id) > 0 THEN 1 ELSE 0 END AS purchased

FROM users u
LEFT JOIN sessions s ON u.user_id = s.user_id
LEFT JOIN pageviews pv ON s.session_id = pv.session_id
LEFT JOIN cart_events ce ON s.session_id = ce.session_id
LEFT JOIN purchases p ON u.user_id = p.user_id

GROUP BY u.user_id, u.city
ORDER BY u.user_id;



-- Compute conversion rates for each funnel stage across all users
SELECT
    COUNT(*) AS total_users,

    -- Users who started a session
    SUM(CASE WHEN session_started = 1 THEN 1 ELSE 0 END) AS sessions_started,
    ROUND(100.0 * SUM(CASE WHEN session_started = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS session_rate,

    -- Users who viewed at least one product
    SUM(CASE WHEN product_viewed = 1 THEN 1 ELSE 0 END) AS product_viewed,
    ROUND(100.0 * SUM(CASE WHEN product_viewed = 1 THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN session_started = 1 THEN 1 ELSE 0 END), 0), 2) AS view_rate,

    -- Users who added at least one product to cart
    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END) AS added_to_cart,
    ROUND(100.0 * SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN product_viewed = 1 THEN 1 ELSE 0 END), 0), 2) AS cart_rate,

    -- Users who made at least one purchase
    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END) AS purchased,
    ROUND(100.0 * SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END), 0), 2) AS purchase_rate

FROM (
    -- Reuse the funnel logic inside a subquery
    SELECT 
        u.user_id,
        u.city,
        CASE WHEN COUNT(DISTINCT s.session_id) > 0 THEN 1 ELSE 0 END AS session_started,
        CASE WHEN COUNT(DISTINCT pv.view_id) > 0 THEN 1 ELSE 0 END AS product_viewed,
        CASE WHEN COUNT(DISTINCT ce.event_id) > 0 THEN 1 ELSE 0 END AS added_to_cart,
        CASE WHEN COUNT(DISTINCT p.purchase_id) > 0 THEN 1 ELSE 0 END AS purchased
    FROM users u
    LEFT JOIN sessions s ON u.user_id = s.user_id
    LEFT JOIN pageviews pv ON s.session_id = pv.session_id
    LEFT JOIN cart_events ce ON s.session_id = ce.session_id
    LEFT JOIN purchases p ON u.user_id = p.user_id
    GROUP BY u.user_id, u.city
) funnel;




