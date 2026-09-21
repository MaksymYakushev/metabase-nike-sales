/************************************************************
 * File:    08_product_x_region_analysis.sql
 * Author:  Maksym Yakushev
 * Date:    2026-09-21
  * Purpose:  Product x Region Analysis
 ************************************************************/


-- ============================================================
-- 1. DATA PREVIEW
-- ============================================================

SELECT 
	* 
FROM sales;


-- ============================================================
-- 2. PRODUCT X REGION REVENUE
-- ============================================================

SELECT
    product
    , region
    , SUM(total) AS revenue
    , SUM(units_sold) AS units_sold
    , COUNT(*) AS transactions
FROM sales
GROUP BY 
	product
	, region
ORDER BY 
	product
	, revenue DESC;


-- ============================================================
-- 3. PRODUCT X REGION HEATMAP
-- ============================================================

SELECT
	product
	, region
	, SUM(total) AS revenue
FROM sales
GROUP BY
	product
	, region;


-- ============================================================
-- 4. TOP PRODUCT IN EACH REGION
-- ============================================================

WITH product_region_sales AS (
    SELECT
        region
        , product
        , SUM(total) AS revenue
    FROM sales
    GROUP BY 
		region
		, product
),

ranked_products AS (
    SELECT
        region
        , product
        , revenue
        , RANK() OVER (PARTITION BY region ORDER BY revenue DESC) AS rank
    FROM product_region_sales
)

SELECT
    region
    , product
    , revenue
    , rank
FROM ranked_products
WHERE 
	rank <= 5
ORDER BY 
	region
	, rank;


-- ============================================================
-- 5. PRODUCT REVENUE SHARE WITHIN REGION
-- ============================================================

WITH product_region_sales AS (
    SELECT
        region
        , product
        , SUM(total) AS revenue
    FROM sales
    GROUP BY 
		region
		, product
)

SELECT
    region
    , product
    , revenue
    , ROUND(revenue / SUM(revenue) OVER (PARTITION BY region) * 100, 2) AS regional_revenue_share
FROM product_region_sales
ORDER BY 
	region
	, revenue DESC;


	
	