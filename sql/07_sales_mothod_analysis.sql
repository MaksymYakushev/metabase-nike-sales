/************************************************************
 * File:    07_sales_mothod_analysis.sql
 * Author:  Maksym Yakushev
 * Date:    2026-09-21
  * Purpose:  Sales Method Analysis
 ************************************************************/


-- ============================================================
-- 1. DATA PREVIEW
-- ============================================================

SELECT 
	* 
FROM sales;


-- ============================================================
-- 2. SALES METHOD OVERVIEW
-- ============================================================

SELECT
    sales_method
    , SUM(total) AS revenue
    , SUM(units_sold) AS units_sold
    , COUNT(*) AS transactions
    , ROUND(AVG(price_per_unit), 2) AS avg_price
    , ROUND(AVG(total), 2) AS avg_transaction_value
FROM sales
GROUP BY 
	sales_method
ORDER BY 
	revenue DESC;


-- ============================================================
-- 3. REVENUE SHARE BY SALES METHOD
-- ============================================================

SELECT
    sales_method
    , SUM(total) AS revenue
    , ROUND(SUM(total) / SUM(SUM(total)) OVER () * 100, 2) AS revenue_share
FROM sales
GROUP BY 
	sales_method
ORDER BY 
	revenue DESC;


-- ============================================================
-- 4. SALES METHOD OVER TIME
-- ============================================================

SELECT
    DATE_TRUNC('month', invoice_date) AS month
    , sales_method
    , SUM(total) AS revenue
FROM sales
GROUP BY 	
	month
	, sales_method
ORDER BY 
	month
	, sales_method;


-- ============================================================
-- 5. RETAILER BY SALES METHOD
-- ============================================================

SELECT
    retailer
    , sales_method 
    , SUM(total) AS revenue 
    , SUM(units_sold) AS units_sold 
    , COUNT(*) AS transactions 
    , ROUND(AVG(total), 2) AS avg_transaction_value
FROM sales
GROUP BY 
	retailer
	, sales_method
ORDER BY 
	retailer
	, revenue DESC;


-- ============================================================
-- 6. SALES METHOD SHARE WITHIN RETAILER
-- ============================================================

WITH retailer_method_sales AS (
    SELECT
        retailer
        , sales_method
        , SUM(total) AS revenue
    FROM sales
    GROUP BY 
		retailer
		, sales_method
)

SELECT
    retailer
    , sales_method
    , revenue
    , ROUND(revenue / SUM(revenue) OVER (PARTITION BY retailer) * 100, 2) AS method_share
FROM retailer_method_sales
ORDER BY 
	retailer
	, revenue DESC;


