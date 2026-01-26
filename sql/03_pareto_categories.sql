WITH base AS (
    SELECT
        product_category_name,
        SUM(item_revenue) AS revenue
    FROM fact_order_items
    WHERE order_status = 'delivered'
    GROUP BY 1
),
ordered AS (
    SELECT
        product_category_name,
        revenue,
        revenue / NULLIF(SUM(revenue) OVER (), 0) AS revenue_share
    FROM base
),
cume AS (
    SELECT
        product_category_name,
        revenue,
        revenue_share,
        SUM(revenue_share) OVER (ORDER BY revenue DESC) AS cumulative_revenue_share,
        ROW_NUMBER() OVER (ORDER BY revenue DESC) AS category_rank
    FROM ordered
)
SELECT *
FROM cume
ORDER BY category_rank;
