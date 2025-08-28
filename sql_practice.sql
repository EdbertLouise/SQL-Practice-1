SELECT * FROM retail LIMIT 2000;

-- SELECT COUNT(*) FROM retail WHERE gender = "FEMALE";

-- SELECT * FROM retail WHERE age IS NULL;

-- Finding entries where some values are null

SELECT * FROM retail WHERE 
	transactions_id is NULL OR
    sale_date is NULL OR
    sale_time is NULL OR
    customer_id is NULL OR
    gender is NULL OR
    age is NULL OR
    category is NULL OR
    quantity is NULL OR
    price_per_unit is NULL OR
    cogs is NULL OR
    total_sales is NULL;
    
/*
DELETE FROM retail WHERE 
	transactions_id is NULL OR
    sale_date is NULL OR
    sale_time is NULL OR
    customer_id is NULL OR
    gender is NULL OR
    age is NULL OR
    category is NULL OR
    quantity is NULL OR
    price_per_unit is NULL OR
    cogs is NULL OR
    total_sales is NULL 
*/

-- Finding the amount of unique customer IDs
SELECT COUNT(DISTINCT customer_id) AS "IDs" FROM retail;

-- Listing the unique categories
SELECT DISTINCT category AS "Categories" FROM retail;


-- Practice
-- Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail WHERE sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'clothing' and the 
-- quantity sold is more than or equal to 4 in the month of Nov-2022
SELECT * FROM retail WHERE category = 'Clothing' 
	AND quantity >= 4
    AND MONTH(sale_date) = 11
    AND YEAR(sale_date) = 2022;

-- EXTRA: Write a SQL query to retrieve all customers where the category is 'clothing' and the 
-- quantity sold is more than or equal to 5 in the month of Nov-2022

SELECT customer_id, SUM(quantity) AS total FROM retail 
	WHERE category = 'Clothing' AND
    MONTH(sale_date) = 11 AND
	YEAR(sale_date) = 2022
    GROUP BY customer_id
    HAVING total >= 5;


-- Write a SQL query to calculate the total sales for each category
SELECT SUM(total_sales), category FROM retail
	GROUP BY category;
-- GROUP BY 2;


-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' 
-- category
SELECT AVG(age), category FROM retail
WHERE category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT * FROM retail 
WHERE total_sales > 1000;

-- Write a SQL query to find the total number of transactions made by each gender in each 
-- category
SELECT category, gender, COUNT(*) AS total_transactions FROM retail
GROUP BY category, gender;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month
-- in each year
SELECT AVG(total_sales) as avg_sales, MONTH(sale_date) AS months FROM retail 
GROUP BY MONTH(sale_date)
ORDER BY avg_sales DESC;

/*
By Ascending Month
SELECT AVG(total_sales) as avg_sales, MONTH(sale_date) AS months FROM retail 
GROUP BY MONTH(sale_date)
ORDER BY months ASC;
*/

-- Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sales) AS total FROM retail
GROUP BY customer_id
ORDER BY total DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each 
-- category

SELECT COUNT(DISTINCT customer_id), category FROM retail
	GROUP BY category;


/*
Viewing not just the count but each ID individually
SELECT DISTINCT customer_id, category FROM retail
ORDER BY category ASC;
*/

-- Write a SQL query to create each shift and number of orders (Example: Morning <= 12, Afternoon
-- Between 12 & 17, Evening > 17)
SELECT COUNT(*) AS num_orders,
	CASE 
		WHEN HOUR(sale_time) <= 12 THEN "Morning"
        WHEN HOUR(sale_time) BETWEEN 13 AND 17 THEN "Afternoon"
        WHEN HOUR(sale_time) > 17 THEN "Evening"
	END AS shift
 FROM retail
 GROUP BY shift;
 
/*
CASE => Case statement from C
AS => Renaming a variable
ORDER BY => As the name implies
GROUP BY => Same here
LIMIT n => Show the top n entries

DISTINCT and SELECT * shouldn't be used with GROUP BY

WHERE → filters rows before grouping/aggregation.	
HAVING → filters groups after aggregation.

Here’s the actual order (simplified):
FROM → get the raw table.
WHERE → filter raw rows.
GROUP BY → group the remaining rows.
HAVING → filter the groups.
SELECT → calculate what to show (including aggregates like SUM(quantity)).
ORDER BY → sort the final results.


SELECT {condition}, m
GROUP BY m;

*/