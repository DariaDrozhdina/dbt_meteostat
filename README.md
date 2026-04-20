What business problem does your dbt model solve?
Northwind needs a reliable way to track and evaluate sales performance across products, categories, and time. Raw transactional tables like orders and order_details are not analysis-ready — they need cleaning, joining, and aggregation. This dbt project transforms that raw data into a consistent, trustworthy layer that business users and analysts can query directly.

Which models did you build, and what does each do?

staging_orders — cleans and standardizes raw orders data, handles types and nulls
staging_order_details — cleans line-item data (quantity, unit price, discount)
staging_products — standardizes product reference data
staging_categories — cleans category lookup table
prep_sales — joins staging models together into a unified sales grain 
mart_sales_performance — final aggregated model


What insights can your mart provide to Northwind?

Which categories and products drive the most revenue
How discounts affect sales volume and margins
Sales trends over time — growth or decline by month
Which products underperform relative to their price point


What was your biggest learning moment?
Handling the source configuration correctly — understanding that name: in sources.yml is what you reference in {{ source() }} calls, while schema: is where dbt actually looks in the database. That distinction between logical naming and physical location was a key dbt concept that unlocked how the whole DAG fits together.