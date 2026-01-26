WITH base AS (
    SELECT
        customer_state,
        SUM(item_revenue) AS revenue,
        COUNT(DISTINCT order_id) AS orders
    FROM fact_order_items
    WHERE order_status = 'delivered'
    GROUP BY 1
),
ordered AS (
    SELECT
        customer_state,
        revenue,
        orders,
        revenue / NULLIF(SUM(revenue) OVER (), 0) AS revenue_share
    FROM base
)
SELECT
    customer_state,
    revenue,
    orders,
    revenue_share,
    SUM(revenue_share) OVER (ORDER BY revenue DESC) AS cumulative_revenue_share
FROM ordered
ORDER BY revenue DESC;
