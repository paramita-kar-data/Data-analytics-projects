-- SQL Sales Analysis Project
-- Dataset: Superstore
-- Author: Paramita Kar

CREATE DATABASE retail_sales_project;
USE retail_sales_project;
SHOW DATABASES;
CREATE TABLE superstore (
row_id INT,
order_id VARCHAR(50),
order_date DATE,
ship_date DATE,
ship_mode VARCHAR(50),
customer_id VARCHAR(50),
customer_name VARCHAR(100),
segment VARCHAR(50),
country VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
postal_code VARCHAR(20),
region VARCHAR(50),
product_id VARCHAR(50),
category VARCHAR(50),
sub_category VARCHAR(50),
product_name VARCHAR(255),
sales FLOAT,
quantity INT,
discount FLOAT,
profit FLOAT
);
SHOW Tables;
DESCRIBE superstore;

SELECT * FROM superstore;
INSERT INTO superstore VALUES
(1,'CA-2016-152156','2016-11-08','2016-11-11','Second Class','CG-12520','Claire Gute','Consumer','United States','Henderson','Kentucky','42420','South','FUR-BO-10001798','Furniture','Bookcases','Bush Somerset Collection Bookcase',261.96,2,0,41.91);
SELECT * FROM superstore;

INSERT INTO superstore VALUES
(2,'CA-2016-152156','2016-11-08','2016-11-11','Second Class','CG-12520','Claire Gute','Consumer','United States','Henderson','Kentucky','42420','South','FUR-CH-10000454','Furniture','Chairs','Hon Deluxe Fabric Upholstered Stacking Chairs',731.94,3,0,219.58),

(3,'CA-2016-138688','2016-06-12','2016-06-16','Second Class','DV-13045','Darrin Van Huff','Corporate','United States','Los Angeles','California','90036','West','OFF-LA-10000240','Office Supplies','Labels','Self-Adhesive Address Labels',14.62,2,0,6.87),

(4,'US-2015-108966','2015-10-11','2015-10-18','Standard Class','SO-20335','Sean O''Donnell','Consumer','United States','Fort Lauderdale','Florida','33311','South','FUR-TA-10000577','Furniture','Tables','Bretford Rectangular Conference Table',957.58,5,0.45,-383.03),

(5,'US-2015-108966','2015-10-11','2015-10-18','Standard Class','SO-20335','Sean O''Donnell','Consumer','United States','Fort Lauderdale','Florida','33311','South','OFF-ST-10000760','Office Supplies','Storage','Eldon Fold N Roll Cart System',22.37,2,0.2,2.52);
##Total sales by region
SELECT region, SUM(sales) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

## Total Profit by Category
SELECT category, SUM(profit) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;

##Sales by customers
SELECT customer_name, SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC;

##Loss making products
SELECT product_name, profit
FROM superstore
WHERE profit < 0;

## Top selling product
SELECT product_name, SUM(sales) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 1;

##Rank Products by Sales
SELECT 
    product_name,
    SUM(sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM superstore
GROUP BY product_name;

##Running Totals of Sales
SELECT 
    order_date,
    sales,
    SUM(sales) OVER (ORDER BY order_date) AS running_total_sales
FROM superstore;

##Profit Contribution by Category
SELECT 
    category,
    SUM(profit) AS total_profit,
    SUM(profit) * 100.0 / SUM(SUM(profit)) OVER () AS profit_percentage
FROM superstore
GROUP BY category;
