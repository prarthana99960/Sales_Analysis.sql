mysql> -- =====================================
mysql> -- E-COMMERCE DATA ANALYSIS PROJECT
mysql> -- =====================================
mysql>
mysql> -- Create Database
mysql> CREATE DATABASE IF NOT EXISTS ecommerce_project;
Query OK, 1 row affected (0.07 sec)

mysql> USE ecommerce_project;
Database changed
mysql>
mysql> -- Drop table if exists
mysql> DROP TABLE IF EXISTS sales;
Query OK, 0 rows affected, 1 warning (0.02 sec)

mysql>
mysql> -- Create Table
mysql> CREATE TABLE sales (
    ->     order_id INT,
    ->     customer_id INT,
    ->     product_name VARCHAR(50),
    ->     category VARCHAR(50),
    ->     order_date DATE,
    ->     quantity INT,
    ->     price INT
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql>
mysql> -- =====================================
mysql> -- INSERT DATA
mysql> -- =====================================
mysql>
mysql> INSERT INTO sales VALUES
    -> (1,101,'Mobile','Electronics','2024-01-05',2,15000),
    -> (2,102,'Shoes','Fashion','2024-01-06',1,2000),
    -> (3,101,'Laptop','Electronics','2024-01-07',1,50000),
    -> (4,103,'T-shirt','Fashion','2024-01-07',3,500),
    -> (5,104,'Headphones','Electronics','2024-01-08',2,3000),
    -> (6,105,'Watch','Accessories','2024-02-01',1,2500),
    -> (7,106,'Bag','Accessories','2024-02-03',2,1500),
    -> (8,101,'Tablet','Electronics','2024-02-05',1,20000),
    -> (9,102,'Jeans','Fashion','2024-02-06',2,1800),
    -> (10,103,'Shoes','Fashion','2024-02-08',1,2200);
Query OK, 10 rows affected (0.03 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql>
mysql> -- =====================================
mysql> -- DATA CLEANING
mysql> -- =====================================
mysql>
mysql> -- Check NULL values
mysql> SELECT * FROM sales
    -> WHERE order_id IS NULL OR customer_id IS NULL;
Empty set (0.01 sec)

mysql>
mysql> -- Check duplicates
mysql> SELECT order_id, COUNT(*)
    -> FROM sales
    -> GROUP BY order_id
    -> HAVING COUNT(*) > 1;
Empty set (0.01 sec)

mysql>
mysql> -- =====================================
mysql> -- DATA ANALYSIS
mysql> -- =====================================
mysql>
mysql> -- 1. Total Revenue
mysql> SELECT SUM(quantity * price) AS total_revenue FROM sales;
+---------------+
| total_revenue |
+---------------+
|        120800 |
+---------------+
1 row in set (0.00 sec)

mysql>
mysql> -- 2. Top Selling Products
mysql> SELECT product_name, SUM(quantity) AS total_sold
    -> FROM sales
    -> GROUP BY product_name
    -> ORDER BY total_sold DESC;
+--------------+------------+
| product_name | total_sold |
+--------------+------------+
| T-shirt      |          3 |
| Mobile       |          2 |
| Shoes        |          2 |
| Headphones   |          2 |
| Bag          |          2 |
| Jeans        |          2 |
| Laptop       |          1 |
| Watch        |          1 |
| Tablet       |          1 |
+--------------+------------+
9 rows in set (0.00 sec)

mysql>
mysql> -- 3. Revenue by Category
mysql> SELECT category, SUM(quantity * price) AS revenue
    -> FROM sales
    -> GROUP BY category;
+-------------+---------+
| category    | revenue |
+-------------+---------+
| Electronics |  106000 |
| Fashion     |    9300 |
| Accessories |    5500 |
+-------------+---------+
3 rows in set (0.00 sec)

mysql>
mysql> -- 4. Monthly Sales Trend
mysql> SELECT
    ->     MONTH(order_date) AS month,
    ->     SUM(quantity * price) AS revenue
    -> FROM sales
    -> GROUP BY month
    -> ORDER BY month;
+-------+---------+
| month | revenue |
+-------+---------+
|     1 |   89500 |
|     2 |   31300 |
+-------+---------+
2 rows in set (0.00 sec)

mysql>
mysql> -- 5. Top Customers
mysql> SELECT customer_id, SUM(quantity * price) AS total_spent
    -> FROM sales
    -> GROUP BY customer_id
    -> ORDER BY total_spent DESC;
+-------------+-------------+
| customer_id | total_spent |
+-------------+-------------+
|         101 |      100000 |
|         104 |        6000 |
|         102 |        5600 |
|         103 |        3700 |
|         106 |        3000 |
|         105 |        2500 |
+-------------+-------------+
6 rows in set (0.00 sec)

