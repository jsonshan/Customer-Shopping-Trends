-- EXLORATORY DATA ANALYSIS --
SELECT *
FROM shopping_trends_demographics;

SELECT *
FROM shopping_trends_products;

-- Check the number of Customer ID matches with all demographics,products, and purchase_details TABLES

SELECT COUNT(DISTINCT `Customer ID`) AS UniqueDemographicsIDs
FROM shopping_trends_demographics;

SELECT COUNT(DISTINCT `Customer ID`) AS UniqueProductIDS
FROM shopping_trends_products;

-- Check for any missing values in key fields from each table

SELECT COUNT(*) AS MissingValuesDemographics
FROM shopping_trends_demographics
WHERE Age IS NULL OR Gender IS NULL OR Location IS NULL;

SELECT COUNT(*) AS MissingValuesProduct
FROM shopping_trends_products
WHERE `Shipping Type` IS NULL OR `Discount Applied` IS NULL OR `Payment Method` IS NULL OR `Item Purchased` IS NULL OR Category IS NULL OR `Purchase Amount (USD)` IS NULL;

-- Find out the number of items purchased in each category
SELECT Category, COUNT(*) AS NumItemsPurchased
FROM shopping_trends_products
GROUP BY Category
ORDER BY NumItemsPurchased DESC;

-- Overview of Customer Ratings
SELECT 
	min(`Review Rating`) as MinRating,
	max(`Review Rating`) as MaxRating,
	avg(`Review Rating`) as AVGRating
FROM shopping_trends_products


-- Data Analysis --


