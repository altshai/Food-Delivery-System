create database food_delivery_system;
use food_delivery_system;

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    mobile_no VARCHAR(15)
);

-- Restaurants Table
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    rating DECIMAL(3,1) CHECK (rating >= 0 AND rating <= 5),
    opens_at TIME NOT NULL,
    closes_at TIME NOT NULL
);

-- Menu Table
CREATE TABLE menu (
    menu_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    dishname VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    rating DECIMAL(3,1) CHECK (rating >= 0 AND rating <= 5),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    menu_id INT NOT NULL,
    orderdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    rating DECIMAL(3,1) CHECK (rating >= 0 AND rating <= 5),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES menu(menu_id) ON DELETE CASCADE
);

-- Order Items Table
CREATE TABLE order_items (
    orderitem_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES menu(menu_id) ON DELETE CASCADE
);

-- Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    paymentmethod VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    paymentstatus ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- Delivery Table
CREATE TABLE delivery (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    deliverystatus ENUM('Pending', 'Out for Delivery', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    trackingnumber VARCHAR(50) UNIQUE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- Admin Table
CREATE TABLE admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('SuperAdmin', 'RestaurantAdmin', 'DeliveryAdmin') NOT NULL
);

    
    
	USE food_delivery_system;

-- Insert Users
INSERT INTO users (name, address, mobile_no) VALUES
('John Doe', '123 Main St, New York', '9876543210'),
('Alice Smith', '45 Elm St, San Francisco', '9123456789'),
('Bob Johnson', '67 Pine St, Chicago', '9234567890'),
('Emily Davis', '89 Oak St, Miami', '9345678901'),
('Michael Brown', '12 Maple St, Houston', '9456789012'),
('Sarah Wilson', '23 Birch St, Boston', '9567890123'),
('David Miller', '34 Cedar St, Seattle', '9678901234'),
('Laura White', '56 Spruce St, Denver', '9789012345'),
('James Anderson', '78 Redwood St, Phoenix', '9890123456'),
('Emma Thomas', '90 Willow St, Dallas', '9901234567');

-- Insert Restaurants
INSERT INTO restaurants (restaurant_name, location, rating, opens_at, closes_at) VALUES
('Pizza Hut', 'New York', 4.5, '10:00:00', '23:00:00'),
('McDonalds', 'San Francisco', 4.2, '08:00:00', '22:00:00'),
('KFC', 'Chicago', 4.0, '09:00:00', '21:30:00'),
('Subway', 'Miami', 4.3, '07:30:00', '22:00:00'),
('Starbucks', 'Houston', 4.7, '06:00:00', '20:00:00'),
('Burger King', 'Boston', 3.9, '10:00:00', '22:00:00'),
('Dominos', 'Seattle', 4.1, '09:30:00', '23:30:00'),
('Taco Bell', 'Denver', 4.2, '11:00:00', '23:00:00'),
('Chipotle', 'Phoenix', 4.4, '10:30:00', '21:00:00'),
('Panda Express', 'Dallas', 4.0, '09:00:00', '22:00:00');

-- Insert Menu Items
INSERT INTO menu (restaurant_id, dishname, price, rating) VALUES
(1, 'Pepperoni Pizza', 12.99, 4.5),
(1, 'Cheese Pizza', 10.99, 4.3),
(2, 'Big Mac', 5.99, 4.2),
(2, 'Chicken Nuggets', 4.99, 4.1),
(3, 'Zinger Burger', 6.99, 4.0),
(3, 'Popcorn Chicken', 5.49, 3.9),
(4, 'Turkey Sub', 7.99, 4.3),
(4, 'Veggie Delight', 6.49, 4.1),
(5, 'Cappuccino', 3.99, 4.7),
(5, 'Espresso', 2.99, 4.8),
(6, 'Whopper', 6.49, 4.0),
(6, 'French Fries', 2.99, 3.8),
(7, 'BBQ Chicken Pizza', 13.99, 4.2),
(7, 'Margherita Pizza', 11.99, 4.4),
(8, 'Taco Supreme', 4.99, 4.2),
(8, 'Cheesy Gordita', 3.99, 4.1),
(9, 'Burrito Bowl', 9.99, 4.4),
(9, 'Chips & Guac', 3.49, 4.3),
(10, 'Orange Chicken', 8.99, 4.0),
(10, 'CHICKEN & Broccoli', 7.99, 4.1);

-- Insert Orders
INSERT INTO orders (user_id, restaurant_id, menu_id, orderdate, rating) VALUES
(1, 1, 1, NOW(), 4.5),
(2, 2, 3, NOW(), 4.2),
(3, 3, 5, NOW(), 4.0),
(4, 4, 7, NOW(), 4.3),
(5, 5, 9, NOW(), 4.7),
(6, 6, 11, NOW(), 3.9),
(7, 7, 13, NOW(), 4.1),
(8, 8, 15, NOW(), 4.2),
(9, 9, 17, NOW(), 4.4),
(10, 10, 19, NOW(), 4.0);

-- Insert Order Items
INSERT INTO order_items (order_id, menu_id, quantity, price) VALUES
(1, 1, 2, 25.98),
(2, 3, 1, 5.99),
(3, 5, 3, 20.97),
(4, 7, 1, 7.99),
(5, 9, 2, 7.98),
(6, 11, 1, 6.49),
(7, 13, 2, 27.98),
(8, 15, 1, 4.99),
(9, 17, 1, 9.99),
(10, 19, 3, 26.97);

-- Insert Payments
INSERT INTO payments (order_id, paymentmethod, amount, paymentstatus) VALUES
(1, 'Credit Card', 25.98, 'Completed'),
(2, 'PayPal', 5.99, 'Completed'),
(3, 'Debit Card', 20.97, 'Pending'),
(4, 'Cash', 7.99, 'Completed'),
(5, 'Credit Card', 7.98, 'Completed'),
(6, 'PayPal', 6.49, 'Failed'),
(7, 'Debit Card', 27.98, 'Completed'),
(8, 'Credit Card', 4.99, 'Completed'),
(9, 'PayPal', 9.99, 'Completed'),
(10, 'Cash', 26.97, 'Completed');

-- Insert Deliveries
INSERT INTO delivery (order_id, deliverystatus, trackingnumber) VALUES
(1, 'Delivered', 'TRK001'),
(2, 'Out for Delivery', 'TRK002'),
(3, 'Pending', 'TRK003'),
(4, 'Delivered', 'TRK004'),
(5, 'Cancelled', 'TRK005'),
(6, 'Pending', 'TRK006'),
(7, 'Delivered', 'TRK007'),
(8, 'Out for Delivery', 'TRK008'),
(9, 'Delivered', 'TRK009'),
(10, 'Delivered', 'TRK010');

-- Insert Admins
INSERT INTO admin (username, password, role) VALUES
('admin1', 'securepass1', 'SuperAdmin'),
('admin2', 'securepass2', 'RestaurantAdmin'),
('admin3', 'securepass3', 'DeliveryAdmin');


SHOW TABLES;
SELECT * FROM users;
SELECT * FROM restaurants;
SELECT * FROM menu;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;
SELECT * FROM delivery;
SELECT * FROM admin;


SELECT 
    o.order_id, 
    u.name AS customer, 
    r.restaurant_name AS restaurant, 
    SUM(oi.price * oi.quantity) AS total_price, 
    o.orderdate AS order_time
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, u.name, r.restaurant_name, o.orderdate;


SELECT 
    oi.orderitem_id, 
    m.dishname AS menu_item, 
    oi.quantity, 
    oi.price
FROM order_items oi
JOIN menu m ON oi.menu_id = m.menu_id
WHERE oi.order_id = 1;

SELECT * FROM payments WHERE paymentstatus = 'Completed';



    
    
     

