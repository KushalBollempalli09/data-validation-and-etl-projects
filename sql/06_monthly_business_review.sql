WITH delivered AS (
    SELECT
        strftime(order_purchase_timestamp, '%Y-%m') AS purchase_month,
        SUM(item_revenue) AS delivered_revenue,
        COUNT(DISTINCT order_id) AS delivered_orders,
        COUNT(*) AS delivered_items
    FROM fact_order_items
    WHERE order_status = 'delivered'
      AND order_purchase_timestamp IS NOT NULL
    GROUP BY 1
),
cancelled AS (
    SELECT
        strftime(order_purchase_timestamp, '%Y-%m') AS purchase_month,
        SUM(item_revenue) AS cancelled_revenue,
        COUNT(DISTINCT order_id) AS cancelled_orders
    FROM fact_order_items
    WHERE order_status = 'canceled'
      AND order_purchase_timestamp IS NOT NULL
    GROUP BY 1
),
combined AS (
    SELECT
        d.purchase_month,
        d.delivered_revenue AS revenue,
        d.delivered_orders AS orders,
        d.delivered_items AS items_sold,
        d.delivered_revenue / NULLIF(d.delivered_orders, 0) AS aov,
        COALESCE(c.cancelled_revenue, 0) AS cancelled_revenue,
        COALESCE(c.cancelled_orders, 0) AS cancelled_orders,
        COALESCE(c.cancelled_revenue, 0) / NULLIF(d.delivered_revenue, 0) AS cancelled_revenue_share
    FROM delivered d
    LEFT JOIN cancelled c
    ON d.purchase_month = c.purchase_month
)
SELECT
    purchase_month,
    revenue,
    orders,
    items_sold,
    aov,
    (revenue / NULLIF(LAG(revenue) OVER (ORDER BY purchase_month), 0)) - 1 AS mom_revenue_growth,
    cancelled_revenue,
    cancelled_orders,
    cancelled_revenue_share
FROM combined
ORDER BY purchase_month;
