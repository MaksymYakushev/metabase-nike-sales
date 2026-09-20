/************************************************************
 * File:    05_regional_performance.sql
 * Author:  Maksym Yakushev
 * Date:    2026-09-19
  * Purpose:  Regional Performance
 ************************************************************/


-- ============================================================
-- 1. DATA PREVIEW
-- ============================================================

SELECT 
	* 
FROM sales;

-- ============================================================
-- 2. PRODUCT PERFORMANCE BY REGION
-- ============================================================

SELECT
	product
	, region
	, SUM(total) AS revenue
FROM sales
GROUP BY 
	product
	, region
ORDER BY 
	revenue DESC;


-- ============================================================
-- 3. TOP-10 STATE BY REVENUE
-- ============================================================

SELECT
	state
	, SUM(total) AS revenue
FROM sales
GROUP BY 
	state
ORDER BY 
	revenue DESC
LIMIT 10;


-- ============================================================
-- 4. PRODUCT AND REVENUE BY STATE
-- ============================================================

SELECT
	state
	, product
	, SUM(total) AS revenue
FROM sales
GROUP BY 
	state
	, product
ORDER BY 
	revenue DESC
LIMIT 10;


-- ============================================================
-- 5. REGIONAL PERFORMANCE OVERVIEW
-- ============================================================

SELECT
    region
    , SUM(total) AS revenue
    , SUM(units_sold) AS units_sold
    , COUNT(*) AS transactions
    , ROUND(AVG(price_per_unit), 2) AS avg_price
    , ROUND(AVG(total), 2) AS avg_transaction_value
FROM sales
GROUP BY 
	region
ORDER BY 
	revenue DESC;


-- ============================================================
-- 6. REVENUE SHARE BY REGION 
-- ============================================================

SELECT
    region
    , SUM(total) AS revenue
    , ROUND(SUM(total) / SUM(SUM(total)) OVER () * 100, 2) AS revenue_share
FROM sales
GROUP BY 
	region
ORDER BY 
	revenue DESC;


-- ============================================================
-- 7. REVENUE BY REGION OVER TIME
-- ============================================================

SELECT
    DATE_TRUNC('month', invoice_date) AS month
    , region
    , SUM(total) AS revenue
FROM sales
GROUP BY 
	month
	, region
ORDER BY 
	month
	, region;


-- ============================================================
-- 8. STATE PERFORMANCE OVERVIEW
-- ============================================================

SELECT
    state
    , region
    , SUM(total) AS revenue
    , SUM(units_sold) AS units_sold
    , COUNT(*) AS transactions
    , ROUND(AVG(price_per_unit), 2) AS avg_price
    , ROUND(AVG(total), 2) AS avg_transaction_value
FROM sales
GROUP BY 
	state
	, region
ORDER BY 
	revenue DESC;


-- ============================================================
-- 9. TOP-10 BOTTOM STATES BY REVENUE
-- ============================================================

SELECT
	state
	, SUM(total) AS revenue
FROM sales
GROUP BY 
	state
ORDER BY 
	revenue ASC
LIMIT 10;


-- ============================================================
-- 10. STATE REVENUE SHARE
-- ============================================================

SELECT
    state
    , SUM(total) AS revenue
    , ROUND(SUM(total) / SUM(SUM(total)) OVER () * 100, 2) AS revenue_share
FROM sales
GROUP BY 
	state
ORDER BY 
	revenue DESC;


-- ============================================================
-- 11. REGION/STATE REVENUE 
-- ============================================================

SELECT
    region
    , state
    , SUM(total) AS revenue
FROM sales
GROUP BY 
	region
	, state
ORDER BY 
	region
	, revenue DESC;

