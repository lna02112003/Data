CREATE DATABASE PHONEMANAGER;

USE PHONEMANAGER;
-- Tạo bảng customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    firstname VARCHAR(255),
    middlename VARCHAR(255),
    lastname VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    img VARCHAR(255) NULL,
    password VARCHAR(255),
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tạo bảng user
CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    firstname VARCHAR(255),
    middlename VARCHAR(255),
    lastname VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    img VARCHAR(255) NULL,
    password VARCHAR(255),
    role tinyINT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tạo bảng category
CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255),
    description TEXT NULL,
    parentID INT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tạo bảng product
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255),
    price DOUBLE,
    hot TINYINT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tạo bảng product_category
CREATE TABLE product_category (
    product_category_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    category_id INT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (product_id) REFERENCES product (product_id),
    FOREIGN KEY (category_id) REFERENCES category (category_id)
);

-- Tạo bảng product_data
CREATE TABLE product_data (
    product_data_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    URL VARCHAR(255),
    Loai_URL VARCHAR(50),
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

-- Tạo bảng attribute
CREATE TABLE attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    attribute_name VARCHAR(255),
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tạo bảng attribute_value
CREATE TABLE attribute_value (
    attribute_value_id INT AUTO_INCREMENT PRIMARY KEY,
    attribute_id INT,
    attribute_value_name VARCHAR(255),
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (attribute_id) REFERENCES attribute (attribute_id)
);

-- Tạo bảng product_attribute
CREATE TABLE product_attribute (
    product_attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    attribute_id INT,
    FOREIGN KEY (product_id) REFERENCES product (product_id),
    FOREIGN KEY (attribute_id) REFERENCES attribute (attribute_id)
);

-- Tạo bảng shipping
CREATE TABLE shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    shipping_name VARCHAR(255),
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tạo bảng payment
CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_method VARCHAR(255),
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tạo bảng order
CREATE TABLE `order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    payment_id INT,
    shipping_id INT,
    description TEXT NULL,
    status VARCHAR(255),
    delivery_date DATE,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    FOREIGN KEY (payment_id) REFERENCES payment (payment_id),
    FOREIGN KEY (shipping_id) REFERENCES shipping (shipping_id)
);

-- Tạo bảng order_detail
CREATE TABLE order_detail (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DOUBLE,
    description TEXT NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (order_id) REFERENCES `order` (order_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);
