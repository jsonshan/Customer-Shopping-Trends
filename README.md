# Customer-Shopping-Trends
Data Analysis on Customer Shopping Trends

## Table of Contents
- [Project Overview](#project-overview)
- [Business Recommendations](#results-business-recommendations)
- [Data Source](#data-source)
  - [Demographics Table](#demographics-table)
  - [Products Table](#products-table)
- [Tools Used](#tools-used)
- [Results to Data Questions Asked](#results-to-data-questions-asked)
  - [Exploratory Data Analysis](#exploratory-data-analysis)
  - [Data Analysis](#data-analysis)
- [Limitations](#limitations)

## Project Overview
This project explores Customer Shopping trends to understand consumer behavior and purchasing patterns. The aim is to study sales strategies, so we can improve and optimize customer experience and boost sales revenues for retail and shopping experience

## Results/Business Recommendations

1. **Promotional Strategies** - Implement targeted discount and promo code campaigns to drive sales, especially during peak seasons.

2. **Geographic Targeting** - Focus marketing efforts on states like Vermont, Louisiana, and Virginia to capitalize on high revenue potential.

3. **Gender-Specific Marketing** - Tailor marketing strategies to cater to the preferences of each gender, emphasizing clothing for males and accessories for females.

4. **Seasonal Stock Planning** - Stock up on inventory for fall-related products and capitalize on the increased demand during this season.

5. **Customer Retention** - Develop loyalty programs to encourage repeat purchases and enhance customer lifetime value.

6. **Product Assortment Optimization** - Expand product offerings in popular categories like clothing and accessories, focusing on items like pants and blouses.

7. **Size and Color Considerations** - Ensure adequate stock of medium-sized items and red-colored products to meet customer demand effectively.

8. **Payment Method Convenience** - Continue supporting payment methods like PayPal, Credit Card, and Cash to provide convenient options for customers.


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

- MySQL - Aggregations, Joins, CTES, Temp Tables

# Results to data questions asked
 
## Exploratory Data Analysis

### What is the unique count of customer IDs in demographics and products tables?

|UniqueDemographicsIDS|UniqueProductIDS|
|-|-|
|3900|3900|

----------------------------------------------------------------------------------

### Check for any missing values in key fields from each table

|MissingValuesDemographics|MissingValuesProduct|
|-|-|
|0|0|

----------------------------------------------------------------------------------

### What are the most purchased categories and items?

|category|NumItemsPurchased|
|-|-|
|Clothing|1737|
|Accessories|1240|
|Footwear|599|
|Outerwear|324|

----------------------------------------------------------------------------------

### What is the overview of customer ratings?

|MinRating|MaxRating|AVGRating|
|-|-|-|
|2.50|5.00|3.749949|

----------------------------------------------------------------------------------

### What is the distribution of data across different seasons and subscription statuses?

|seasons|SeasonsCount|
|-|-|
|Summer|955|
|Winter|971|
|Fall|975|
|Spring|999|

----------------------------------------------------------------------------------

### Checking Subscription Status

|subscription_status|subscription_status_count|
|-|-|
|Yes|1053|
|No|2847|

----------------------------------------------------------------------------------

### What are the most popular sizes, colors, and payment methods?

|size|Count|
|-|-|
|M|1755|
|L|1053|
|S|663|
|XL|429|

|color|Count|
|-|-|
|Red|148|
|Lavender|147|
|Beige|147|
|Indigo|147|
|Turquoise|145|

|payment_method|Count|
|-|-|
|PayPal|677|
|Credit Card|671|
|Cash|670|
|Debit Card|636|
|Venmo|634|
|Bank Transfer|612|

----------------------------------------------------------------------------------

## Data Analysis

### Do discounts/promo codes lead to increased sales or revenue?

|TotalRevenue|TotalSales|discount_applied|promo_code_used|
|-|-|-|-|
|133670.00|2223|No|No|
|99411.00|1677|Yes|Yes|

----------------------------------------------------------------------------------

### Which state generates the highest revenue?

|location|TotalRevenue|
|-|-|
|Vermont|4860.00|
|Louisiana|4848.00|
|Virginia|4842.00|
|Arkansas|4828.00|
|Maryland|4795.00|

----------------------------------------------------------------------------------

### Do males or females contribute more revenue?

|gender|TotalRevenue|TotalCustomers|
|-|-|-|
|Male|157890.00|2652|
|Female|75191.00|1248|

----------------------------------------------------------------------------------

### What are the preferences of males and females in terms of categories and products?

----------------------------------------------------------------------------------

-- Males

Products
|item_purchased|count_items_purchased|
|-|-|
|Pants|123|
|Jewelry|119|
|Sweater|114|
|Coat|114|
|Dress|114|

Category
|category|count_category|
|-|-|
|Clothing|1181|
|Accessories|848|
|Footwear|400|
|Outerwear|223|

----------------------------------------------------------------------------------

-- Females

Products
|item_purchased|count_items_purchased|
|-|-|
|Blouse|66|
|Sandals|59|
|Shirt|59|
|Handbag|58|
|Socks|58|

Category
|category|count_category|
|-|-|
|Clothing|556|
|Accessories|392|
|Footwear|199|
|Outerwear|101|

----------------------------------------------------------------------------------

### What is the average rating of each category?


|category|AVGReviewRating|
|-|-|
|Footwear|3.790651|
|Accessories|3.768629|
|Outerwear|3.746914|
|Clothing|3.723143|

----------------------------------------------------------------------------------

### What are the most popular categories for both genders?

|gender|item_purchased|TotalCount|
|-|-|-|
|Female|Clothing|556|
|Male|Clothing|1181|

----------------------------------------------------------------------------------

### What are the most popular products in the clothing category for males and females?

|gender|item_purchased|TotalCount|
|-|-|-|
|Male|Pants|123|
|Female|Blouse|66|

----------------------------------------------------------------------------------

### What age range generates the most revenue?

|AgeRange|TotalRevenue|CustomerCount|AverageCustomerSpent|
|-|-|-|-|
|50 - 64|67916.00|1132|59.996466|
|35 - 49|65013.00|1100|59.102727|
|25 - 34|45400.00|755|60.132450|
|18 - 24|29258.00|486|60.201646|
|Over 65|25494.00|427|59.704918|

----------------------------------------------------------------------------------

### Which season is the most profitable every year?

|season|TotalRevenue|
|-|-|
|Fall|60018.00|
|Spring|58679.00|
|Winter|58607.00|
|Summer|55777.00|

----------------------------------------------------------------------------------

### Do greater previous purchases or returning customers generate more revenue?

|returning_customers|TotalRevenue|TotalCustomers|
|-|-|-|
|Greater Than 40|51035.00|847|
|20 - 29|46919.00|791|
|30 - 39|46816.00|784|
|10 - 19|45169.00|770|
|0 - 9|43142.00|708|

----------------------------------------------------------------------------------

### Which color shirts/accessories should I include to boost revenue?

|category|color|TotalRevenue|
|-|-|-|
|Accessories|Gray|3838.00|
|Clothing|Green|5345.00|

----------------------------------------------------------------------------------

## Limitations

1. There are no dates so we cannot see trends and relationships between products and customers over time. 
2. Sampling bias could occur as there was a majority of 68% of males being surveyed
   
