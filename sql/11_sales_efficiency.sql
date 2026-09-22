
/************************************************************
 * File:    11_sales_efficiency.sql
 * Author:  Maksym Yakushev
 * Date:    2026-09-22
  * Purpose:  Sales Efficiency Analysis
 ************************************************************/


-- ============================================================
-- 1. DATA PREVIEW
-- ============================================================

SELECT 
	* 
FROM sales;


-- ============================================================
-- 2. PRODUCT X REGION X SALES METHOD
-- ============================================================

SELECT
    product
    , region
    , sales_method
    , SUM(total) AS revenue
    , SUM(units_sold) AS units_sold
    , COUNT(*) AS transactions
    , ROUND(AVG(price_per_unit), 2) AS avg_price
    , ROUND(AVG(total), 2) AS avg_transaction_value
FROM sales
GROUP BY 
	product
	, region
	, sales_method
ORDER BY 
	revenue DESC;


-- ============================================================
-- 3. REVENUE PER TRANSACTION
-- ============================================================

SELECT
    product
    , region
    , sales_method
    , ROUND(SUM(total) / NULLIF(COUNT(*), 0), 2) AS revenue_per_transaction
FROM sales
GROUP BY 
	product
	, region
	, sales_method
ORDER BY 
	revenue_per_transaction DESC;


-- ============================================================
-- 4. UNITS PER TRANSACTION
-- ============================================================

SELECT
    product
    , region
    , sales_method
    , ROUND(SUM(units_sold)::numeric / NULLIF(COUNT(*), 0), 2) AS units_per_transaction
FROM sales
GROUP BY 
	product
	, region
	, sales_method
ORDER BY 
	units_per_transaction DESC;


-- ============================================================
-- 5. SALES EFFICIENCY SUMMARY
-- ============================================================

WITH sales_efficiency AS (
    SELECT
        product
        , region
        , sales_method
        , SUM(total) AS revenue
        , SUM(units_sold) AS units_sold
        , COUNT(*) AS transactions
    FROM sales
    GROUP BY 
		product
		, region
		, sales_method
)

SELECT
    product
    , region
    , sales_method
    , revenue
    , units_sold
    , transactions
    , ROUND(revenue / NULLIF(transactions, 0), 2) AS revenue_per_transaction
    , ROUND(units_sold::numeric / NULLIF(transactions, 0), 2) AS units_per_transaction
FROM sales_efficiency
ORDER BY 
	revenue DESC;

	