/************************************************************
 * File:    03_sales_trend_analysis.sql
 * Author:  Maksym Yakushev
 * Date:    2026-09-19
  * Purpose:  Sales Trend Analysis
 ************************************************************/


-- ============================================================
-- 1. DATA PREVIEW
-- ============================================================

SELECT 
	* 
FROM sales;


-- ============================================================
-- 2. REVENUE BY MONTH
-- ============================================================

SELECT	
	TO_CHAR(DATE_TRUNC('month', invoice_date), 'YYYY-MM') AS month
	, SUM(total) AS revenue
FROM sales
GROUP BY 
	month
ORDER BY 
	month ASC;


-- ============================================================
-- 3. UNITS SOLD BY MONTH
-- ============================================================

SELECT	
	TO_CHAR(DATE_TRUNC('month', invoice_date), 'YYYY-MM') AS month
	, SUM(units_sold) AS "units sold"
FROM sales
GROUP BY 
	month
ORDER BY 
	month ASC;


-- ============================================================
-- 4. REVENUE AND UNITS SOLD BY MONTH
-- ============================================================

SELECT	
	TO_CHAR(DATE_TRUNC('month', invoice_date), 'YYYY-MM') AS month
	, SUM(total) AS revenue
	, SUM(units_sold) AS "units sold"
FROM sales
GROUP BY 
	month
ORDER BY 
	month ASC;


-- ============================================================
-- 5. TRANSACTIONS BY MONTH
-- ============================================================

SELECT	
	TO_CHAR(DATE_TRUNC('month', invoice_date), 'YYYY-MM') AS month
	, COUNT(*) AS transactions
FROM sales
GROUP BY 
	month
ORDER BY 
	month ASC;


-- ============================================================
-- 6. REVENUE YOY
-- ============================================================

WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM invoice_date) AS year
        , SUM(total) AS revenue
    FROM sales
    GROUP BY
		year
)

SELECT
    year
    , revenue
    , LAG(revenue) OVER (ORDER BY year) AS previous_year_revenue
    , ROUND(
		(revenue - LAG(revenue) OVER (ORDER BY year))
        / NULLIF(LAG(revenue) OVER (ORDER BY year), 0) * 100
		, 2) AS revenue_yoy
FROM yearly_sales
ORDER BY 
	year;


-- ============================================================
-- 7. MONTHLY GROWTH
-- ============================================================

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', invoice_date) AS month
    	, SUM(total) AS revenue
    FROM sales
    GROUP BY 
		month
),

monthly_growth AS (
    SELECT
        month
        , revenue
        , LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly_sales
)

SELECT
    month
    , revenue
    , previous_month_revenue
    , ROUND(((revenue - previous_month_revenue)::numeric 
		/ NULLIF(previous_month_revenue, 0)) * 100, 2) AS monthly_growth
FROM monthly_growth
ORDER BY 
	month;


-- ============================================================
-- 8. QUARTERLY REVENUE
-- ============================================================

SELECT
    DATE_TRUNC('quarter', invoice_date) AS quarter
    , SUM(total) AS revenue
FROM sales
GROUP BY 
	quarter
ORDER BY 
	quarter;
