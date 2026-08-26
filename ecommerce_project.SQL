CREATE DATABASE ecommerce_project;
USE ecommerce_project;
select*from ecommerce_sales;
DESCRIBE ecommerce_sales;

ALTER TABLE ecommerce_sales 
MODIFY COLUMN Quantity INT,
MODIFY COLUMN UnitPrice DECIMAL(10,2),
MODIFY COLUMN Discount DECIMAL(5,2),
MODIFY COLUMN Sales DECIMAL(10,2),
MODIFY COLUMN Profit DECIMAL(10,2);
SELECT 
    SUM(CASE WHEN CustomerName IS NULL OR CustomerName = '' THEN 1 ELSE 0 END) AS Null_Customers,
    SUM(CASE WHEN City IS NULL OR City = '' THEN 1 ELSE 0 END) AS Null_Cities,
    SUM(CASE WHEN Discount IS NULL THEN 1 ELSE 0 END) AS Null_Discounts
FROM ecommerce_sales;

UPDATE ecommerce_sales 
SET CustomerName = 'Unknown Customer' 
WHERE CustomerName IS NULL OR CustomerName = '';

UPDATE ecommerce_sales 
SET City = 'Unknown City' 
WHERE City IS NULL OR City = '';

UPDATE ecommerce_sales 
SET Discount = 0.00 
WHERE Discount IS NULL;

select*FROM ecommerce_sales;
select
OrderID,Product,Quantity,Sales,count(*) AS DUBLICATE_COUNT
from ecommerce_sales
group by OrderID,Product,Quantity,Sales
having count(*) >1;

SELECT * FROM ecommerce_sales WHERE OrderID = 'ORD-10027';

CREATE TABLE temp_ecommerce_sales AS
SELECT DISTINCT * FROM ecommerce_sales;

TRUNCATE TABLE ecommerce_sales;

INSERT INTO ecommerce_sales
SELECT * FROM temp_ecommerce_sales;

DROP TABLE temp_ecommerce_sales;

ALTER TABLE ecommerce_sales 
MODIFY COLUMN OrderID VARCHAR(50),
MODIFY COLUMN Product VARCHAR(255);

ALTER TABLE ecommerce_sales 
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

SELECT 
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM ecommerce_sales;


SELECT 
    Category,
    SUM(Sales) AS Category_TotalSales
FROM ecommerce_sales
GROUP BY Category;

SELECT 
    Region,
    SUM(Sales) AS Region_TotalSales
FROM ecommerce_sales
GROUP BY Region
order by Region_TotalSales desc;

SELECT 
    Category,
    count(*) AS Total_Order,
    sum(Sales) AS Total_Sales,
    SUM(Profit) AS Category_TotalProfit
FROM ecommerce_sales
GROUP BY Category
order by Category_TotalProfit desc;

SELECT 
OrderID,CustomerName,Sales,Profit
FROM ecommerce_sales
where Profit >1000
order by Profit desc;

SELECT 
Category,
SUM(Sales) AS Total_Sales
FROM ecommerce_sales
group by Category
having Total_Sales >10000000
order by Total_Sales desc;

SELECT 
City,
AVG(Discount) AS Avg_Discount
FROM ecommerce_sales
group by City
having Avg_Discount >0.15
order by Avg_Discount desc;

SELECT 
CustomerName,
sum(Sales) AS Total_Spent
FROM ecommerce_sales
where CustomerName != 'Unknown Customer'
group by CustomerName
order by Total_Spent desc
LIMIT 5;	

SELECT 
Product,
sum(Sales) AS Total_Sales,
sum(Profit) AS Total_Profit
FROM ecommerce_sales
group by Product
having Total_Profit <0
order by Total_Profit asc;

SELECT 
    CustomerName,
    Product,
    Discount,
    Sales,
    Profit
FROM ecommerce_sales
WHERE Discount > 0.20
ORDER BY Discount DESC;

SELECT 
    Category,
    Product,
    Sales,
    DENSE_RANK() OVER (PARTITION BY Category ORDER BY Sales DESC) AS Product_Rank
FROM ecommerce_sales;

WITH RankedProducts AS (
    SELECT 
        Category,
        Product,
        Sales,
        DENSE_RANK() OVER (PARTITION BY Category ORDER BY Sales DESC) AS Product_Rank
    FROM ecommerce_sales
)
SELECT 
    Category,
    Product,
    Sales
FROM RankedProducts
WHERE Product_Rank = 1;
