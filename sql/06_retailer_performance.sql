/************************************************************
 * File:    06_retailer_performance.sql
 * Author:  Maksym Yakushev
 * Date:    2026-09-20
  * Purpose:  Retailer Performance
 ************************************************************/


-- ============================================================
-- 1. DATA PREVIEW
-- ============================================================

SELECT 
	* 
FROM sales;


-- ============================================================
-- 2. RETAILER PERFORMANCE OVERVIEW
-- ============================================================

SELECT
    retailer
    , SUM(total) AS revenue
    , SUM(units_sold) AS units_sold
    , COUNT(*) AS transactions
    , ROUND(AVG(price_per_unit), 2) AS avg_price
    , ROUND(AVG(total), 2) AS avg_transaction_value
FROM sales
GROUP BY 
	retailer
ORDER BY 
	revenue DESC;


-- ============================================================
-- 3. RETAILER REVENUE SHARE
-- ============================================================

SELECT
    retailer
    , SUM(total) AS revenue
    , ROUND(SUM(total) / SUM(SUM(total)) OVER () * 100, 2) AS revenue_share
FROM sales
GROUP BY 
	retailer
ORDER BY 
	revenue DESC;


-- ============================================================
-- 4. RETAILER PERFORMANCE OVER TIME
-- ============================================================

SELECT
    DATE_TRUNC('month', invoice_date) AS month
    , retailer
    , SUM(total) AS revenue
FROM sales
GROUP BY 	
	month
	, retailer
ORDER BY 	
	month
	, retailer;


-- ============================================================
-- 5. RETAILER AND SALES METHOD
-- ============================================================

SELECT
    retailer
    , sales_method
    , SUM(total) AS revenue
    , SUM(units_sold) AS units_sold
    , COUNT(*) AS transactions
FROM sales
GROUP BY 
	retailer
	, sales_method
ORDER BY 
	retailer
	, revenue DESC;


-- ============================================================
-- 6. RETAILER AND REGION
-- ============================================================

SELECT
    retailer
    , region
    , SUM(total) AS revenue
    , SUM(units_sold) AS units_sold
FROM sales
GROUP BY 
	retailer
	, region
ORDER BY 
	retailer
	, revenue DESC;


-- ============================================================
-- 7. RETAILER'S TOP
-- ============================================================

SELECT
    retailer
    , SUM(total) AS revenue
FROM sales
GROUP BY 
	retailer
ORDER BY 
	revenue DESC;
