# Ecommerce-Sales-SQL-Analysis
# E-Commerce Sales & Business Performance Analysis (MySQL)

## 📌 Project Overview
This project focuses on cleaning, structuring, and analyzing an end-to-end E-Commerce sales dataset using **MySQL Workbench**. The objective is to extract actionable business insights, evaluate sales and profitability trends across categories and regions, and identify high-value customers using intermediate to advanced SQL techniques.

---

## 🛠️ Tech Stack & Tools Used
* **Database Engine:** MySQL Server 8.0
* **IDE:** MySQL Workbench
* **Key SQL Concepts:** Data Cleaning, Primary Keys, Aggregations (`SUM`, `COUNT`, `AVG`), Grouping (`GROUP BY`, `HAVING`), Filtering (`WHERE`), Sorting (`ORDER BY`), Window Functions (`DENSE_RANK()`), and Common Table Expressions (CTEs).

---

## 🧹 Data Cleaning & Database Schema
To maintain data integrity and handle potential duplicates, the dataset structure was optimized as follows:
* Corrected column data types (`INT`, `VARCHAR`, `DECIMAL`).
* Handled `NULL` values and resolved duplicate record issues.
* Added an auto-incrementing surrogate primary key to uniquely identify every transaction.

```sql
ALTER TABLE ecommerce_sales 
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;
