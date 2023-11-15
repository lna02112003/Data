CREATE DATABASE STOREMANAGER;

USE STOREMANAGER;
-- Tạo bảng customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(255),
    middlename VARCHAR(255),
    lastname VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    img VARCHAR(255) NULL,
    password VARCHAR(32),
    row_delete TinyINT default 0,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tạo bảng user
CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(255),
    middlename VARCHAR(255),
    lastname VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    img VARCHAR(255) NULL,
    password VARCHAR(32),
    row_delete TinyINT default 0,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tạo bảng role
CREATE TABLE role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(255),
    row_delete TinyINT default 0,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tạo bảng user_role
CREATE TABLE user_role (
    user_role_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    role_id INT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    row_delete TinyINT default 0,
    FOREIGN KEY (user_id) REFERENCES user (user_id),
    FOREIGN KEY (role_id) REFERENCES role (role_id)
);

-- Tạo bảng category
CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255),
    description TEXT NULL,
    parentID INT,
    row_delete TinyINT default 0,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tạo bảng product
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255),
    hot TINYINT,
    description LONGTEXT,
    row_delete TinyINT default 0,
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
    row_delete TinyINT default 0,
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
    row_delete TinyINT default 0,
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

-- Tạo bảng attribute
CREATE TABLE attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    attribute_name VARCHAR(255),
    row_delete TinyINT default 0,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tạo bảng attribute_value
CREATE TABLE attribute_value (
    attribute_value_id INT AUTO_INCREMENT PRIMARY KEY,
    attribute_id INT,
    attribute_value_name VARCHAR(255),
    price_in DOUBLE,
    price_out DOUBLE,
    row_delete TinyINT default 0,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (attribute_id) REFERENCES attribute (attribute_id)
);

-- Tạo bảng product_attribute
CREATE TABLE product_attribute (
    product_attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    attribute_id INT,
    row_delete TinyINT default 0,
    FOREIGN KEY (product_id) REFERENCES product (product_id),
    FOREIGN KEY (attribute_id) REFERENCES attribute (attribute_id)
);

-- Tạo bảng order
CREATE TABLE `order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    description TEXT NULL,
    status VARCHAR(255),
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    row_delete TinyINT default 0,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
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
    row_delete TinyINT default 0,
    FOREIGN KEY (order_id) REFERENCES `order` (order_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);
