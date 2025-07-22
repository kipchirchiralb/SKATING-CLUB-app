CREATE DATABASE IF NOT EXISTS skating_club;
USE skating_club;

CREATE TABLE MEMBERS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    joining_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    category ENUM('silver', 'gold') NOT NULL
);

CREATE TABLE RESOURCES (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    size VARCHAR(50),
    availability ENUM('available', 'unavailable') DEFAULT 'available',
    category varchar(255) NOT NULL
);

CREATE TABLE RESOURCE_ISSUANCE (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resource_id INT NOT NULL,
    member_id INT NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expected_return_date DATE NOT NULL,
    status ENUM('issued', 'returned') NOT NULL,
    FOREIGN KEY (resource_id) REFERENCES RESOURCES(id),
    FOREIGN KEY (member_id) REFERENCES MEMBERS(id)
);

CREATE TABLE PAYMENTS (
    receipt_no INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    status ENUM('fully_paid', 'partially_paid', 'not_paid') NOT NULL,
    subscription_year YEAR NOT NULL,
    FOREIGN KEY (member_id) REFERENCES MEMBERS(id)
);