/************************************************************
 * File:    01_data_quality.sql
 * Author:  Maksym Yakushev
 * Date:    2026-09-17
  * Purpose: Check Data Quality
 ************************************************************/


-- ============================================================
-- 1. DATA PREVIEW
-- ============================================================

SELECT 
	* 
FROM sales;



-- ============================================================
-- 2. ROWS COUNTING
-- ============================================================

SELECT 
	COUNT(*) 
FROM sales;


-- ============================================================
-- 3. BASIC PROFILING
-- ============================================================

SELECT 
	COUNT(*)
	, COUNT(DISTINCT invoice_date) AS unq_invoice_date
	, COUNT(DISTINCT product) AS unq_product
	, COUNT(DISTINCT region) AS unq_region
	, COUNT(DISTINCT retailer) AS unq_retailer
	, COUNT(DISTINCT sales_method) AS unq_sales_method
	, COUNT(DISTINCT state) AS unq_state
FROM sales


-- ============================================================
-- 4. 
-- ============================================================



