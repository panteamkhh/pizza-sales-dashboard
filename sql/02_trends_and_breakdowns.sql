/* ============================================================
   Pizza Sales Analysis - Trends and breakdowns
   SQL Server
   Source table: dbo.pizza_sales
   ============================================================ */

-- ------------------------------------------------------------
-- Orders by day of week
-- ------------------------------------------------------------
SELECT
    DATENAME(WEEKDAY, order_date) AS order_day,
    COUNT(DISTINCT order_id)      AS total_orders
FROM dbo.pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date)
ORDER BY total_orders;

-- ------------------------------------------------------------
-- Orders by hour of day
-- ------------------------------------------------------------
SELECT
    DATEPART(HOUR, order_time) AS order_hour,
    COUNT(DISTINCT order_id)   AS total_orders
FROM dbo.pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY order_hour;

-- ------------------------------------------------------------
-- Revenue share by pizza category
-- ------------------------------------------------------------
SELECT
    pizza_category,
    SUM(total_price) AS total_sales,
    CAST(
        SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM dbo.pizza_sales)
        AS DECIMAL(10, 2)
    ) AS sales_percentage
FROM dbo.pizza_sales
GROUP BY pizza_category
ORDER BY sales_percentage DESC;

-- Same share, limited to January
SELECT
    pizza_category,
    SUM(total_price) AS total_sales,
    CAST(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM dbo.pizza_sales WHERE MONTH(order_date) = 1)
        AS DECIMAL(10, 2)
    ) AS sales_percentage
FROM dbo.pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category
ORDER BY sales_percentage DESC;

-- ------------------------------------------------------------
-- Revenue share by pizza size
-- ------------------------------------------------------------
SELECT
    pizza_size,
    SUM(total_price) AS total_sales,
    CAST(
        SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM dbo.pizza_sales)
        AS DECIMAL(10, 2)
    ) AS sales_percentage
FROM dbo.pizza_sales
GROUP BY pizza_size
ORDER BY sales_percentage DESC;

-- ------------------------------------------------------------
-- Pizzas sold by category
-- ------------------------------------------------------------
SELECT
    pizza_category,
    SUM(quantity) AS total_pizzas_sold
FROM dbo.pizza_sales
GROUP BY pizza_category
ORDER BY total_pizzas_sold DESC;

-- ------------------------------------------------------------
-- Top 5 best sellers
-- ------------------------------------------------------------
SELECT TOP 5
    pizza_name,
    SUM(quantity) AS total_pizzas_sold
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold DESC;

-- ------------------------------------------------------------
-- Bottom 5 worst sellers
-- ------------------------------------------------------------
SELECT TOP 5
    pizza_name,
    SUM(quantity) AS total_pizzas_sold
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold ASC;
