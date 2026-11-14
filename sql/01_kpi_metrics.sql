/* ============================================================
   Pizza Sales Analysis - KPI metrics
   SQL Server
   Source table: dbo.pizza_sales
   ============================================================ */

-- Preview the raw table
SELECT *
FROM dbo.pizza_sales;

-- 1. Total revenue
SELECT ROUND(SUM(total_price), 2) AS total_revenue
FROM dbo.pizza_sales;

-- 2. Total orders
-- One order can contain several pizzas, so order_id must be counted distinctly.
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM dbo.pizza_sales;

-- 3. Total pizzas sold
SELECT SUM(quantity) AS total_pizzas_sold
FROM dbo.pizza_sales;

-- 4. Average order value (revenue / number of distinct orders)
SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM dbo.pizza_sales;

-- 5. Average pizzas per order
-- Multiplying by 1.0 forces decimal division in SQL Server.
SELECT CAST(SUM(quantity) * 1.0 / COUNT(DISTINCT order_id) AS DECIMAL(10, 2))
       AS average_pizzas_per_order
FROM dbo.pizza_sales;
