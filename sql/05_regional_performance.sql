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
-- 3. REVENUE BY STATE
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
-- 5. 
-- ============================================================
