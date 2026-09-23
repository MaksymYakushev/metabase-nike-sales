/************************************************************
 * File:    12_outlier_analysis.sql
 * Author:  Maksym Yakushev
 * Date:    2026-09-23
  * Purpose: Outlier Analysis
 ************************************************************/


-- ============================================================
-- 1. DATA PREVIEW
-- ============================================================

SELECT 
	* 
FROM sales;


-- ============================================================
-- 2. TOTAL OVERVIEW
-- ============================================================

SELECT
    MIN(total) AS min_transaction
    , ROUND(AVG(total), 2) AS avg_transaction
    , MAX(total) AS max_transaction
    , PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total) AS q1
    , PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY total) AS median
    , PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total) AS q3
FROM sales;


-- ============================================================
-- 3. IQR METHOD
-- ============================================================

WITH quartiles AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total) AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total) AS q3
    FROM sales
),

bounds AS (
    SELECT
        q1
        , q3
        , q3 - q1 AS iqr
        , q1 - 1.5 * (q3 - q1) AS lower_bound
        , q3 + 1.5 * (q3 - q1) AS upper_bound
    FROM quartiles
)

SELECT
    s.*
	, CASE
		WHEN s.total > b.upper_bound THEN 'High Outlier'
        WHEN s.total < b.lower_bound THEN 'Low Outlier'
        ELSE 'Normal' END AS outlier_status
FROM sales s
CROSS JOIN bounds b
ORDER BY 
	s.total DESC;


-- ============================================================
-- 4. OUTLIERS COUNT
-- ============================================================

WITH quartiles AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total) AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total) AS q3
    FROM sales
),

classified AS (
    SELECT
        s.total
        , CASE
            WHEN s.total > q3 + 1.5 * (q3 - q1) THEN 'High Outlier'
            WHEN s.total < q1 - 1.5 * (q3 - q1) THEN 'Low Outlier'
            ELSE 'Normal' END AS status
    FROM sales s
    CROSS JOIN quartiles
)

SELECT
    status
    , COUNT(*) AS transactions
    , ROUND(COUNT(*)::numeric / SUM(COUNT(*)) OVER () * 100, 2) AS percentage
FROM classified
GROUP BY 
	status
ORDER BY 
	transactions DESC;