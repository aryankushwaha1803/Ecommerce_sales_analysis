
USE ecommerce_sales;

-- 1. Monthly Sales
SELECT
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS month,
    SUM(Sales) AS total_sales
FROM sales_fixed
GROUP BY month
ORDER BY month;

-- 2. Monthly Profit
SELECT
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS month,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_fixed
GROUP BY month
ORDER BY month;

-- 3. Monthly Sales, Profit and Profit Margin
SELECT
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS month,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS profit_margin_pct
FROM sales_fixed
GROUP BY month
ORDER BY month;

-- 4. Sales by Category
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales
FROM sales_fixed
GROUP BY Category
ORDER BY total_sales DESC;

-- 5. Sales by Sub-Category
SELECT
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS total_sales
FROM sales_fixed
GROUP BY `Sub-Category`
ORDER BY total_sales DESC;

-- 6. Profit by Category
SELECT
    Category,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_fixed
GROUP BY Category
ORDER BY total_profit DESC;

-- 7. Profit by Sub-Category
SELECT
    `Sub-Category`,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_fixed
GROUP BY `Sub-Category`
ORDER BY total_profit DESC;

-- 8. Sales and Profit by Customer Segment
SELECT
    Segment,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS profit_margin_pct
FROM sales_fixed
GROUP BY Segment
ORDER BY total_sales DESC;

-- 9. Sales and Profit by Region
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_fixed
GROUP BY Region
ORDER BY total_sales DESC;

-- 10. Top 10 States by Sales
SELECT
    State,
    ROUND(SUM(Sales), 2) AS total_sales
FROM sales_fixed
GROUP BY State
ORDER BY total_sales DESC
LIMIT 10;

-- 11. Top 10 Products by Sales
SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS total_sales
FROM sales_fixed
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;

-- 12. Top 10 Products by Profit
SELECT
    `Product Name`,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_fixed
GROUP BY `Product Name`
ORDER BY total_profit DESC
LIMIT 10;

-- 13. Bottom 10 Products by Profit
SELECT
    `Product Name`,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_fixed
GROUP BY `Product Name`
ORDER BY total_profit ASC
LIMIT 10;

-- 14. Discount Analysis
SELECT
    Discount,
    COUNT(*) AS number_of_rows,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_fixed
GROUP BY Discount
ORDER BY Discount;

-- 15. Categories Generating a Loss
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_fixed
GROUP BY Category
HAVING SUM(Profit) < 0
ORDER BY total_profit;

-- 16. Loss-Making Sub-Categories
SELECT
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_fixed
GROUP BY `Sub-Category`
HAVING SUM(Profit) < 0
ORDER BY total_profit;

-- 17. Yearly Sales and Profit
SELECT
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS order_year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_fixed
GROUP BY order_year
ORDER BY order_year;

-- 18. Sales and Profit by Ship Mode
SELECT
    `Ship Mode`,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_fixed
GROUP BY `Ship Mode`
ORDER BY total_sales DESC;

-- 19. Top 10 Customers by Sales
SELECT
    `Customer ID`,
    `Customer Name`,
    ROUND(SUM(Sales), 2) AS total_sales
FROM sales_fixed
GROUP BY `Customer ID`, `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

-- 20. Average Order Value
SELECT
    ROUND(SUM(Sales) / COUNT(DISTINCT `Order ID`), 2) AS average_order_value
FROM sales_fixed;

-- 21. Overall Business KPIs
SELECT
    COUNT(DISTINCT `Order ID`) AS total_orders,
    COUNT(DISTINCT `Customer ID`) AS total_customers,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2) AS profit_margin_pct
FROM sales_fixed;

-- 22. Rows with Negative Profit
SELECT *
FROM sales_fixed
WHERE Profit < 0
ORDER BY Profit ASC;
