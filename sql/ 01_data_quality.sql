/************************************************************
 * File:    01_data_quality.sql
 * Author:  Maksym Yakushev
 * Date:    2026-09-18
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
FROM sales;


-- ============================================================
-- 4. DATA QUALITY CHECK
-- ============================================================

-- Price per Units | Total | Units Sold
SELECT
	'Price per Unit' AS column
	, MIN(price_per_unit) AS min
	, MAX(price_per_unit) AS max
	, AVG(price_per_unit) AS avg
FROM sales

UNION

SELECT
	'Total' AS column
	, MIN(total) AS min
	, MAX(total) AS max
	, AVG(total) AS avg
FROM sales

UNION

SELECT
	'Units Sold' AS column
	, MIN(units_sold) AS min
	, MAX(units_sold) AS max
	, AVG(units_sold) AS avg
FROM sales;


-- Invoice Date
SELECT
	'Invoice Date' AS column
	, MIN(invoice_date) AS min
	, MAX(invoice_date) AS max
FROM sales;


-- ============================================================
-- 5. DISTINCT VALUES — INDIVIDUAL COLUMNS
-- ============================================================

-- Product
SELECT
	DISTINCT product
FROM sales;


-- Region
SELECT
	DISTINCT region
FROM sales;


-- Sales Method
SELECT
	DISTINCT sales_method
FROM sales;


-- State
SELECT
	DISTINCT state
FROM sales;


-- ============================================================
-- 6. NULLS CHECK
-- ============================================================

SELECT
	COUNT(*) FILTER(WHERE invoice_date IS NULL) AS invoice_date_null
	, COUNT(*) FILTER(WHERE product IS NULL) AS product_null
	, COUNT(*) FILTER(WHERE region IS NULL) AS region_null
	, COUNT(*) FILTER(WHERE retailer IS NULL) AS retailer_null
	, COUNT(*) FILTER(WHERE sales_method IS NULL) AS sales_method_null
	, COUNT(*) FILTER(WHERE state IS NULL) AS state_null
	, COUNT(*) FILTER(WHERE price_per_unit IS NULL) AS price_per_unit_null
	, COUNT(*) FILTER(WHERE total IS NULL) AS total_null
	, COUNT(*) FILTER(WHERE units_sold IS NULL) AS units_sold_null
FROM sales;


-- ============================================================
-- 7. DUPLICATES CHECK
-- ============================================================

SELECT
	invoice_date
	, product
	, region
	, retailer
	, state
	, price_per_unit
	, total
	, units_sold
	, COUNT(*)
FROM sales
GROUP BY 
	invoice_date
	, product
	, region
	, retailer
	, state
	, price_per_unit
	, total
	, units_sold
HAVING COUNT(*) > 1
ORDER BY invoice_date ASC;
