
/************************************************************
 * File:    10_abc_product_classification.sql
 * Author:  Maksym Yakushev
 * Date:    2026-09-22
  * Purpose:  ABC Product Classification
 ************************************************************/


-- ============================================================
-- 1. DATA PREVIEW
-- ============================================================

SELECT 
	* 
FROM sales;


-- ============================================================
-- 2. ABC CLASSIFICATION
-- ============================================================

WITH product_sales AS (
    SELECT
        product
        , SUM(total) AS revenue
    FROM sales
    GROUP BY 
		product
),

product_abc AS (
    SELECT
        product
        , revenue
        , SUM(revenue) OVER () AS total_revenue
        , SUM(revenue) OVER (ORDER BY revenue DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue
    FROM product_sales
)

SELECT
    product
    , revenue
    , ROUND(revenue / total_revenue * 100, 2) AS revenue_share
    , ROUND(cumulative_revenue / total_revenue * 100, 2) AS cumulative_revenue_share
    , CASE
		WHEN cumulative_revenue / total_revenue <= 0.80
			THEN 'A'
        WHEN cumulative_revenue / total_revenue <= 0.95
            THEN 'B'
        ELSE 'C' END AS abc_class
FROM product_abc
ORDER BY 
	revenue DESC;


-- ============================================================
-- 3. SUMMARY BY ABC CLASSES
-- ============================================================

WITH product_sales AS (
    SELECT
        product
        , SUM(total) AS revenue
    FROM sales
    GROUP BY 
		product
),

product_abc AS (
    SELECT
        product
        , revenue
        , SUM(revenue) OVER () AS total_revenue
        , SUM(revenue) OVER (ORDER BY revenue DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue
    FROM product_sales
),

classified AS (
    SELECT
        product
        , revenue
        , CASE
			WHEN cumulative_revenue / total_revenue <= 0.80
                THEN 'A'
            WHEN cumulative_revenue / total_revenue <= 0.95
                THEN 'B'
            ELSE 'C' END AS abc_class
    FROM product_abc
)

SELECT
    abc_class
    , COUNT(*) AS products
    , SUM(revenue) AS revenue
    , ROUND(SUM(revenue) / SUM(SUM(revenue)) OVER () * 100, 2) AS revenue_share
FROM classified
GROUP BY 
	abc_class
ORDER BY 
	abc_class;
