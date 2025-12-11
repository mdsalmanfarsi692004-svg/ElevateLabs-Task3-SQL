-- 1. Create and Select the Database
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- FIX: Reset the tables to avoid "Table already exists" errors.
-- We drop 'orders' first because it refers to 'customers' (Foreign Key)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- 2. Create Tables
-- Customers Table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    join_date DATE
);

-- Products Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 3. Insert Dummy Data
-- Insert Customers
INSERT INTO customers (name, email, city, join_date) VALUES
('Alice Smith', 'alice@example.com', 'New York', '2023-01-15'),
('Bob Johnson', 'bob@example.com', 'Los Angeles', '2023-02-10'),
('Charlie Brown', 'charlie@example.com', 'Chicago', '2023-03-05'),
('Diana Prince', 'diana@example.com', 'New York', '2023-04-20'),
('Evan Wright', 'evan@example.com', 'Miami', '2023-05-12');

-- Insert Products
INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('Desk Chair', 'Furniture', 150.00),
('Coffee Table', 'Furniture', 200.00),
('Headphones', 'Electronics', 100.00);

-- Insert Orders
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2023-06-01', 1200.00), -- Alice bought a laptop
(1, '2023-06-15', 100.00),  -- Alice bought headphones
(2, '2023-07-01', 800.00),  -- Bob bought a phone
(3, '2023-07-10', 150.00),  -- Charlie bought a chair
(4, '2023-07-20', 2000.00); -- Diana bought multiple items