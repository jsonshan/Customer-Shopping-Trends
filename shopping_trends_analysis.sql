-- Setting up demographics and products TABLES for EDA --



DROP TABLE IF EXISTS demographics;
CREATE TABLE demographics (
    customer_id INT,
    age INT,
    gender VARCHAR(10),
    location VARCHAR(255),
    season VARCHAR(50),
    subscription_status VARCHAR(50),
	frequency_of_purchases VARCHAR(50)
);

SELECT *
FROM demographics;

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    customer_id INT,
    item_purchased VARCHAR(50),
    category VARCHAR(50),
    purchase_amount DECIMAL(10, 2),
    size VARCHAR(10),
    color VARCHAR(50),
    review_rating DECIMAL(10,2),
    shipping_type VARCHAR(50),
    discount_applied VARCHAR(10),
    promo_code_used VARCHAR(50),
    previous_purchases INT,
    payment_method VARCHAR(50)
);

SELECT *
FROM products;





-- EXLORATORY DATA ANALYSIS --



SELECT *
FROM demographics;

SELECT *
FROM products;

-- Check the number of Customer ID matches with all demographics,products, and purchase_details TABLES

SELECT COUNT(DISTINCT(customer_id)) AS UniqueDemographicsIDs
FROM demographics;

SELECT COUNT(DISTINCT(customer_ID)) AS UniqueProductIDS
FROM products;

-- Check for any missing values in key fields from each table

SELECT COUNT(*) AS MissingValuesDemographics
FROM demographics
WHERE age IS NULL OR gender IS NULL OR location IS NULL;

SELECT COUNT(*) AS MissingValuesProduct
FROM products
WHERE shipping_type IS NULL OR discount_applied IS NULL OR payment_method IS NULL OR item_purchased IS NULL OR category IS NULL OR purchase_amount IS NULL;

-- Find out the number of items purchased in each category
SELECT category, COUNT(*) AS NumItemsPurchased
FROM products
GROUP BY category
ORDER BY NumItemsPurchased DESC;

-- Overview of Customer Ratings
SELECT 
	min(review_rating) as MinRating,
	max(review_rating) as MaxRating,
	avg(review_rating) as AVGRating
FROM products;

-- Counting the amount of data in each season
SELECT season, COUNT(*) as SeasonsCount
FROM demographics
GROUP BY season
ORDER BY SeasonsCount;

-- Checking Subscription Status
SELECT subscription_status, COUNT(*) as subscription_status_count 
FROM demographics
GROUP BY subscription_status
ORDER BY subscription_status_count;

-- Most Popular Sizes
SELECT size, COUNT(*) as Count
FROM products
GROUP BY size
ORDER BY Count DESC;

-- Different Types of Colors
SELECT color, COUNT(*) as Count
FROM products
GROUP BY color
ORDER BY Count DESC;

-- Most common payment methods
SELECT payment_method, COUNT(*) as Count
FROM products
GROUP BY payment_method
ORDER BY Count DESC;








-- Data Analysis --





SELECT *
FROM demographics;

SELECT *
FROM products;


-- Does discounts/promo codes lead to more sales/revenue?
SELECT SUM(purchase_amount) as TotalRevenue, COUNT(*) AS TotalSales, discount_applied, promo_code_used
FROM products
GROUP BY discount_applied, promo_code_used
ORDER BY TotalSales DESC;

-- Which State makes the most revenue in the U.S?
SELECT d.location location, SUM(p.purchase_amount) as TotalRevenue
FROM demographics d
JOIN products p
ON d.customer_id = p.customer_id
GROUP BY location
ORDER BY TotalRevenue DESC;

-- Do Males or Females generate more Revenue for Stores? 
SELECT d.gender gender, SUM(p.purchase_amount) as TotalRevenue
FROM demographics d
JOIN products p
ON d.customer_id = p.customer_id
GROUP BY gender
ORDER BY TotalRevenue DESC;

-- What are Female/Male preferences on Categories and Product?

-- Male Most Popular Products
SELECT p.item_purchased item_purchased, COUNT(p.item_purchased) AS count_items_purchased
FROM demographics d
JOIN products p
ON d.customer_id = p.customer_id
WHERE gender = 'Male'
GROUP BY item_purchased
ORDER BY count_items_purchased DESC;

-- Male Most Popular Categories
SELECT p.category category, COUNT(p.category) AS count_category
FROM demographics d
JOIN products p
ON d.customer_id = p.customer_id
WHERE gender = 'Male'
GROUP BY category
ORDER BY count_category DESC;





-- Female Most Popular Products
SELECT p.item_purchased item_purchased, COUNT(p.item_purchased) AS count_items_purchased
FROM demographics d
JOIN products p
ON d.customer_id = p.customer_id
WHERE gender = 'Female'
GROUP BY item_purchased
ORDER BY count_items_purchased DESC;

-- Female Most Popular Categories
SELECT p.category category, COUNT(p.category) AS count_category
FROM demographics d
JOIN products p
ON d.customer_id = p.customer_id
WHERE gender = 'Female'
GROUP BY category
ORDER BY count_category DESC;



-- What age range generates the most revenue?
SELECT CASE
			WHEN d.age >= 18 AND d.age <= 24 THEN '18 - 24'
            WHEN d.age >= 25 AND d.age <= 34 THEN '25 - 34 '
            WHEN d.age >= 35 AND d.age <= 49 THEN '35 - 49'
            WHEN d.age >= 50 AND d.age <= 64 THEN '50 - 64'
            ELSE 'Over 65'
		END AS AgeRange,
        SUM(p.purchase_amount) AS TotalRevenue,
        COUNT(*) CustomerCount,
		SUM(p.purchase_amount) / COUNT(*) AS AverageCustomerSpent 
FROM demographics d
JOIN products p
ON d.customer_id = p.customer_id
GROUP BY AgeRange
ORDER BY CustomerCount DESC;


-- Which season is the most profitable every year?
SELECT 
d.season, SUM(p.purchase_amount) AS TotalRevenue
FROM demographics d
JOIN products p
ON d.customer_id = p.customer_id
-- WHERE d.location = 'New York'			-- Checking New York's revenue
GROUP BY season
ORDER BY TotalRevenue DESC;


--
SELECT shipping_type, COUNT(*) ShippingCount
FROM products
GROUP BY shipping_type
ORDER BY ShippingCount
