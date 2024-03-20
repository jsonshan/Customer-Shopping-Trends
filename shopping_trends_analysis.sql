-- Setting up demographics and products TABLES for EDA --



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

-- What is the unique count of customer IDs in demographics and products tables?

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

-- What are the most purchased categories and items?
SELECT category, COUNT(*) AS NumItemsPurchased
FROM products
GROUP BY category
ORDER BY NumItemsPurchased DESC;

-- What is the overview of customer ratings?
SELECT 
	min(review_rating) as MinRating,
	max(review_rating) as MaxRating,
	avg(review_rating) as AVGRating
FROM products;

-- What is the distribution of data across different seasons and subscription statuses?
SELECT season, COUNT(*) as SeasonsCount
FROM demographics
GROUP BY season
ORDER BY SeasonsCount;

-- Checking Subscription Status
SELECT subscription_status, COUNT(*) as subscription_status_count 
FROM demographics
GROUP BY subscription_status
ORDER BY subscription_status_count;

-- What are the most popular sizes, colors, and payment methods?

-- Sizes
SELECT size, COUNT(*) as Count
FROM products
GROUP BY size
ORDER BY Count DESC;

-- Colors
SELECT color, COUNT(*) as Count
FROM products
GROUP BY color
ORDER BY Count DESC;

-- Payment Methods
SELECT payment_method, COUNT(*) as Count
FROM products
GROUP BY payment_method
ORDER BY Count DESC;








-- Data Analysis --





SELECT *
FROM demographics;

SELECT *
FROM products;


-- Do discounts/promo codes lead to increased sales or revenue?
SELECT SUM(purchase_amount) as TotalRevenue, COUNT(*) AS TotalSales, discount_applied, promo_code_used
FROM products
GROUP BY discount_applied, promo_code_used
ORDER BY TotalSales DESC;

-- Which state generates the highest revenue?
CREATE TEMPORARY TABLE Revenue_By_Location AS
SELECT *
FROM (
    SELECT d.location AS location, SUM(p.purchase_amount) AS TotalRevenue
    FROM demographics d
    JOIN products p ON d.customer_id = p.customer_id
    GROUP BY location
) AS subquery;

SELECT * FROM Revenue_By_Location;


-- Do males or females contribute more revenue?
CREATE TEMPORARY TABLE Revenue_By_Gender AS
SELECT *
FROM (
    SELECT d.gender AS gender, SUM(p.purchase_amount) AS TotalRevenue, COUNT(*) AS TotalCustomers
    FROM demographics d
    JOIN products p ON d.customer_id = p.customer_id
    GROUP BY gender
) AS subquery;

SELECT * FROM Revenue_By_Gender;


-- What are the preferences of males and females in terms of categories and products?

WITH Male_Products AS (
    SELECT p.item_purchased AS item_purchased, COUNT(p.item_purchased) AS count_items_purchased
    FROM demographics d
    JOIN products p ON d.customer_id = p.customer_id
    WHERE gender = 'Male'
    GROUP BY item_purchased
)
SELECT * FROM Male_Products;

WITH Male_Categories AS (
    SELECT p.category AS category, COUNT(p.category) AS count_category
    FROM demographics d
    JOIN products p ON d.customer_id = p.customer_id
    WHERE gender = 'Male'
    GROUP BY category
)
SELECT * FROM Male_Categories;

WITH Female_Products AS (
    SELECT p.item_purchased AS item_purchased, COUNT(p.item_purchased) AS count_items_purchased
    FROM demographics d
    JOIN products p ON d.customer_id = p.customer_id
    WHERE gender = 'Female'
    GROUP BY item_purchased
)
SELECT * FROM Female_Products;

WITH Female_Categories AS (
    SELECT p.category AS category, COUNT(p.category) AS count_category
    FROM demographics d
    JOIN products p ON d.customer_id = p.customer_id
    WHERE gender = 'Female'
    GROUP BY category
)
SELECT * FROM Female_Categories;



-- What is the average rating of each category?
SELECT category, AVG(review_rating) AS AVGReviewRating
FROM products
GROUP BY category
ORDER BY AVGReviewRating DESC;



-- What are the most popular categories for both genders?
SELECT gender, category, TotalCount
FROM (
    SELECT 
        d.gender AS gender, 
        p.category AS category, 
        COUNT(*) AS TotalCount,
        ROW_NUMBER() OVER(PARTITION BY d.gender ORDER BY COUNT(*) DESC) AS row_num
    FROM products p
    JOIN demographics d 
    ON p.customer_id = d.customer_id
    GROUP BY d.gender, p.category
) AS gender_category_counts
WHERE row_num = 1;



-- What are the most popular products in the clothing category for males and females?
SELECT gender, item_purchased, TotalCount
FROM (
	SELECT d.gender gender, p.item_purchased item_purchased, COUNT(item_purchased) AS TotalCount,
		ROW_NUMBER() OVER(PARTITION BY gender ORDER BY COUNT(item_purchased) DESC) AS row_num
	FROM products p
	JOIN demographics d
	ON p.customer_id = d.customer_id
	WHERE category = 'Clothing'
	GROUP BY gender, item_purchased
	ORDER BY TotalCount DESC
) AS gender_products_counts
WHERE row_num = 1;

-- What age range generates the most revenue?
SELECT CASE
			WHEN d.age >= 18 AND d.age <= 24 THEN '18 - 24'
            WHEN d.age >= 25 AND d.age <= 34 THEN '25 - 34'
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
SELECT d.season, SUM(p.purchase_amount) AS TotalRevenue
FROM demographics d
JOIN products p
ON d.customer_id = p.customer_id
-- WHERE d.location = 'New York'			-- Checking New York's revenue --
GROUP BY season
ORDER BY TotalRevenue DESC;



-- Do greater previous purchases or returning customers generate more revenue?
SELECT CASE
			WHEN previous_purchases >= 0 AND previous_purchases < 10 THEN "0 - 9"
			WHEN previous_purchases >= 10 AND previous_purchases < 20 THEN "10 - 19"
            WHEN previous_purchases >= 20 AND previous_purchases < 30 THEN "20 - 29"
            WHEN previous_purchases >= 30 AND previous_purchases < 40 THEN "30 - 39"
            WHEN previous_purchases >= 40 THEN "Greater Than 40"
		END AS returning_customers,
		SUM(purchase_amount) AS TotalRevenue,
        COUNT(*) AS TotalCustomers
FROM products
GROUP BY returning_customers
ORDER BY TotalRevenue DESC;



-- Which color shirts/accessories should I include to boost revenue?
-- CTE

WITH Revenue_Boost_CTE AS (
    SELECT category, color, SUM(purchase_amount) AS TotalRevenue,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY SUM(purchase_amount) DESC) rank_
    FROM products
    WHERE category IN ('Clothing', 'Accessories')
    GROUP BY category, color
)
SELECT category, color, TotalRevenue
FROM Revenue_Boost_CTE
WHERE rank_ = 1






