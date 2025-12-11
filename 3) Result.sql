-- 1. Setup Database
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- 2. Reset Tables (Fixes "Table already exists" error)
DROP VIEW IF EXISTS customer_order_summary;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- 3. Create Tables
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    join_date DATE
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 4. Insert Data
INSERT INTO customers (name, email, city, join_date) VALUES
('Alice Smith', 'alice@example.com', 'New York', '2023-01-15'),
('Bob Johnson', 'bob@example.com', 'Los Angeles', '2023-02-10'),
('Charlie Brown', 'charlie@example.com', 'Chicago', '2023-03-05'),
('Diana Prince', 'diana@example.com', 'New York', '2023-04-20'),
('Evan Wright', 'evan@example.com', 'Miami', '2023-05-12');

INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('Desk Chair', 'Furniture', 150.00),
('Coffee Table', 'Furniture', 200.00),
('Headphones', 'Electronics', 100.00);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2023-06-01', 1200.00),
(1, '2023-06-15', 100.00),
(2, '2023-07-01', 800.00),
(3, '2023-07-10', 150.00),
(4, '2023-07-20', 2000.00);

-- 5. Data Analysis

-- A. Total spending by customers in New York
SELECT 
    c.name, 
    c.city, 
    SUM(o.total_amount) as total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE c.city = 'New York'
GROUP BY c.name, c.city
ORDER BY total_spent DESC;

-- B. List all orders with customer names
SELECT 
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- C. Customers who spent more than average
SELECT name, email
FROM customers
WHERE customer_id IN (
    SELECT customer_id 
    FROM orders 
    WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
);

-- D. Total revenue and average order value
SELECT 
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_order_value
FROM orders;

-- E. Create and query view
CREATE VIEW customer_order_summary AS
SELECT 
    c.name, 
    COUNT(o.order_id) as number_of_orders, 
    SUM(o.total_amount) as total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

SELECT * FROM customer_order_summary;

-- F. Create Index
CREATE INDEX idx_city ON customers(city);