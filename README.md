# End-to-End E-Commerce Business Analytics

# Business Context
This project simulates the work of a Data Analyst at a mid-size e-commerce company.
The goal is to support leadership with a Monthly Business Review by transforming raw transactional data into actionable business insights.

Stakeholders include:
- Marketing Management
- Product Management
- Finance and Operations

# Business Objectives
- Track revenue growth over time
- Identify top-performing product categories
- Detect revenue concentration
- Quantify revenue loss due to cancellations
- Understand regional performance patterns

# Key KPIs
- Revenue
- Orders
- Average Order Value (AOV)
- Month-over-Month revenue growth
- Revenue share by category
- Cancelled revenue share
- Revenue by customer region

# Data Overview
- Source: Public Olist Brazilian E-Commerce Dataset
- Raw data includes orders, order items, products, customers, and payments
- Raw data is stored unchanged in data/raw/

A clean analytics-ready fact table is built with one row per order item.

# Data Modeling Approach
- Built a star-schema-like fact_order_items table
- Joined orders, order items, products, customers, and aggregated payments
- Ensured no row duplication and validated joins
- Stored processed data as Parquet for efficient analytics

## Analysis Performed
- Monthly Business Performance
- Revenue, orders, AOV by month
- Excluded early ramp-up months with very low order volume
- Identified stable growth driven by demand rather than pricing

### Product Category Analysis
- Ranked categories by revenue contribution
- Found strong Pareto effect
- 16 categories generate ~80% of total revenue

### Cancellation Impact
- Quantified potential revenue lost due to cancellations
- Highlighted opportunity for revenue uplift without new acquisition

### Regional Performance
- Revenue and order distribution by customer state
- Identified geographic concentration of demand

# Key Business Insights
- Revenue growth is driven primarily by volume, not price inflation
- A small subset of product categories drives most business value
- Reducing cancellations can increase revenue at low marginal cost
- Geographic concentration suggests focus areas for logistics optimization

# Tools & Technologies
- Python (Pandas)
- Jupyter Notebook (Anaconda)
- Parquet for analytics storage
