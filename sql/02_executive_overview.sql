/************************************************************
 * File:    02_executive_overview.sql
 * Author:  Maksym Yakushev
 * Date:    2026-09-18
  * Purpose:  Executive Dataset Overview
 ************************************************************/


-- ============================================================
-- 1. DATA PREVIEW
-- ============================================================

SELECT 
	* 
FROM sales;


-- ============================================================
-- 2. TOTAL REVENUE
-- ============================================================

SELECT 
	SUM(total) AS revenue 
FROM sales;


-- ============================================================
-- 3. TOTAL UNITS SOLD
-- ============================================================

SELECT 
	SUM(units_sold) AS total_units_sold 
FROM sales;


-- ============================================================
-- 4. AVG. TRANSACTION VALUE
-- ============================================================

SELECT 
	AVG(total) AS avg_transaction_value
FROM sales;


-- ============================================================
-- 5. AVG. PRICE PER UNIT
-- ============================================================

SELECT 
	AVG(price_per_unit) AS avg_price_per_unit
FROM sales;


-- ============================================================
-- 6. NUMBER OF TRANSACTIONS
-- ============================================================

SELECT 
	COUNT(*) AS number_of_transactions
FROM sales;


-- ============================================================
-- 7. NUMBER OF PRODUCTS
-- ============================================================

SELECT 
	SUM(units_sold) AS number_of_products
FROM sales;


-- ============================================================
-- 8. NUMBER OF RETAILERS
-- ============================================================

SELECT 
	COUNT(DISTINCT retailer) AS number_of_retailers
FROM sales;


-- ============================================================
-- 9. NUMBER OF STATES
-- ============================================================

SELECT 
	COUNT(DISTINCT state) AS number_of_states
FROM sales;