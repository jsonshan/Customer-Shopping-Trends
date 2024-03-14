# Customer-Shopping-Trends
Data Analysis on Customer Shopping Trends

## Project Overview
This project explores Customer Shopping trends to understand consumer behavior and purchasing patterns. The aim is to study sales strategies and how we can improve and optimize customer experience and boost sale revenues for stores 

## Data Source
Dataset: This dataset was taken from the [Customer Shopping Trends Dataset](https://www.kaggle.com/datasets/iamsouravbanerjee/customer-shopping-trends-dataset?select=shopping_trends_updated.csv) on Kaggle

I divided the dataset into two CSV files, demographics and products to show my skills of aggregation, joins, CTES, and Temp Tables 😄

#### demographics TABLE
|Columns|Description|Type|
|-------|-----------|----|
|customer_id|Unique identifier for each customer|INT|
|age|Age of the customer|INT|
|gender|Gender of the customer (Male/Female)|VARCHAR(10)|
|location|Location where the purchase was made|VARCHAR(255)|
|season|Season during which the purchase was made|VARCHAR(50)|
|subscription_status|Indicates if the customer has a subscription (Yes/No)|VARCHAR(50)|
|frequency_of_purchases|Frequency at which the customer makes purchases (e.g., Weekly, Fortnightly, Monthly)|VARCHAR(50)|

#### products TABLE
|Columns|Description|Type|
|-------|-----------|----|
|customer_id|Unique identifier for each customer|INT|
|item_purchased|The item purchased by the customer|VARCHAR(50)|
|category|Category of the item purchased|VARCHAR(50)|
|purchase_amount|The amount of the purchase in USD|DECIMAL(10, 2)|
|size|Size of the purchased item|VARCHAR(10)|
|color|Color of the purchased item|VARCHAR(50)|
|review_rating|Rating given by the customer for the purchased item|DECIMAL(10,2)|
|shipping_type|Type of shipping chosen by the customer|VARCHAR(50)|
|discount_applied|Indicates if a discount was applied to the purchase (Yes/No)|VARCHAR(10)|
|promo_code_used|Indicates if a promo code was used for the purchase (Yes/No)|VARCHAR(50)|
|previous_purchases|The total count of transactions concluded by the customer at the store, excluding the ongoing transaction|INT|
|payment_method|Customer's most preferred payment method|VARCHAR(50)|

## Tools Used

SQL
