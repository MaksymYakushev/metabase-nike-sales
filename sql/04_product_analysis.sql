/************************************************************
 * File:    04_product_analysis.sql
 * Author:  Maksym Yakushev
 * Date:    2026-09-19
  * Purpose:  Product Analysis
 ************************************************************/


-- ============================================================
-- 1. DATA PREVIEW
-- ============================================================

SELECT 
	* 
FROM sales;


-- ============================================================
-- 2. PRODUCT PERFORMANCE
-- ============================================================

SELECT
	product
	, SUM(total) AS revenue
FROM sales
GROUP BY 
	product;


-- ============================================================
-- 3. PRODUCT PERFORMANCE BY REGION
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
-- 4. REVENUE BY STATE
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
-- 5. PRODUCT AND REVENUE BY STATE
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
-- 6. PRODUCT DETAILED ANALYSIS
-- ============================================================

SELECT
    product
    , ROUND(AVG(price_per_unit), 2) AS avg_price
    , MIN(price_per_unit) AS min_price
    , MAX(price_per_unit) AS max_price
    , SUM(units_sold) AS total_units_sold
    , ROUND(AVG(units_sold), 2) AS avg_units_per_transaction
    , SUM(total) AS revenue
    , COUNT(*) AS transactions
FROM sales
GROUP BY 
	product
ORDER BY 
	revenue DESC;


-- ============================================================
-- 7. PRICE VS UNITS SOLD
-- ============================================================

SELECT
    product
    , AVG(price_per_unit) AS avg_price
    , SUM(units_sold) AS total_units_sold
FROM sales
GROUP BY 
	product
ORDER BY 
	avg_price;


-- ============================================================
-- 8. CORRELATION BETWEEN PRICE AND UNITS SOLD
-- ============================================================

SELECT
    CORR(avg_price, total_units_sold) AS price_units_correlation
FROM (
    SELECT
        product
        , AVG(price_per_unit) AS avg_price
        , SUM(units_sold) AS total_units_sold
    FROM sales
    GROUP BY 
		product
) AS product_sales;






	