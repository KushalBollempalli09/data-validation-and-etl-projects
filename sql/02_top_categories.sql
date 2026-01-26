WITH base AS (
    SELECT
        product_category_name,
        SUM(item_revenue) AS revenue,
        COUNT(DISTINCT order_id) AS orders,
        COUNT(*) AS items_sold
    FROM fact_order_items
    WHERE order_status = 'delivered'
    GROUP BY 1
),
totals AS (
    SELECT SUM(revenue) AS total_revenue FROM base
)
SELECT
    b.product_category_name,
    b.revenue,
    b.orders,
    b.items_sold,
    b.revenue / NULLIF(t.total_revenue, 0) AS revenue_share
FROM base b
CROSS JOIN totals t
ORDER BY b.revenue DESC;
