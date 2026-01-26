WITH base AS (
    SELECT
        strftime(order_purchase_timestamp, '%Y-%m') AS purchase_month,
        SUM(item_revenue) AS revenue,
        COUNT(DISTINCT order_id) AS orders,
        COUNT(*) AS items_sold
    FROM fact_order_items
    WHERE order_status = 'delivered'
      AND order_purchase_timestamp IS NOT NULL
    GROUP BY 1
),
with_aov AS (
    SELECT
        purchase_month,
        revenue,
        orders,
        items_sold,
        revenue / NULLIF(orders, 0) AS aov
    FROM base
)
SELECT
    purchase_month,
    revenue,
    orders,
    items_sold,
    aov,
    (revenue / NULLIF(LAG(revenue) OVER (ORDER BY purchase_month), 0)) - 1 AS mom_revenue_growth
FROM with_aov
QUALIFY orders >= 100
ORDER BY purchase_month;
