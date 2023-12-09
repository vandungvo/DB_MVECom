use e_commerce;
set global local_infile = true;
LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/users.csv' 
INTO TABLE users
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(user_id,first_name,last_name,user_type,email,user_password);

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/customer.csv' 
INTO TABLE customer
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(user_id);

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/shop.csv' 
INTO TABLE shop
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(user_id,shop_name,address);

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/shipping_company.csv' 
INTO TABLE shipping_company
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(company_id,company_name,address,phone_num);

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/shipper.csv' 
INTO TABLE shipper
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/category.csv' 
INTO TABLE category
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(ctg_id,ctg_name);

delete from product;
LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/product.csv' 
INTO TABLE product
character set latin1
FIELDS TERMINATED BY ',' 
lines terminated by '\r\n'
IGNORE 1 ROWS
(product_id,shop_id,ctg_id,product_name,SKU,upload_date,price,stock,sold_quantities,product_description,image,rating,rate_nums);

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/orders.csv' 
INTO TABLE orders
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(order_id,cus_id,total_price,order_date);

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/bill.csv' 
INTO TABLE bill
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS 
(bill_id, order_id, shop_id, order_date, total_price, bill_status);

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/bill_product.csv' 
INTO TABLE bill_product
FIELDS TERMINATED BY ',' 
<<<<<<< HEAD
<<<<<<< HEAD
IGNORE 1 ROWS;

-- Insert data into 'users' table
INSERT INTO users (user_id, first_name, last_name, user_type, email, password) 
VALUES 
    (1, 'John', 'Doe', 'CUSTOMER', 'john.doe@example.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
    (2, 'Alice', 'Smith', 'SELLER', 'alice.smith@example.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
    (3, 'Bob', 'Johnson', 'SHIPPER', 'bob.johnson@example.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
    (4, 'Admin', 'Admin', 'ADMIN', 'admin@example.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy');

-- Insert data into 'customer' table
INSERT INTO customer (user_id) VALUES (1);

-- Insert data into 'shipping_company' table
INSERT INTO shipping_company (company_id, name, address, phone_num) 
VALUES 
    (1, 'Express Shipping Co.', '123 Shipping St', '1234567890'),
    (2, 'Speedy Couriers', '456 Delivery Ave', '9876543210');

-- Insert data into 'shipper' table
INSERT INTO shipper (user_id, company_id, phone_num) VALUES (3, 1, '5551234567');

-- Insert data into 'shop' table
INSERT INTO shop (user_id, shop_name, address) VALUES (2, 'Awesome Shop', '789 Shop St');

-- Insert data into 'category' table
INSERT INTO category (ctg_id, name) VALUES (1, 'Electronics'), (2, 'Clothing');

-- Insert data into 'product' table
INSERT INTO product (shop_id, ctg_id, name, SKU, price, stock, description, image, rating, rate_nums) 
VALUES 
    (2, 1, 'Smartphone X', 'SKU123', 599.99, 50, 'High-end smartphone', 'phone.jpg', 4.5, 100),
    (2, 2, 'Casual T-shirt', 'SKU456', 29.99, 100, 'Comfortable cotton shirt', 'shirt.jpg', 4.0, 50);

-- Insert data into 'wish_item' table
INSERT INTO wish_item (wish_id, cus_id, product_id) VALUES (1, 1, 1);

-- Insert data into 'promotion' table
INSERT INTO promotion (promotion_id, name, start_date, end_date, promotion_type, discount_percen) 
VALUES (1, 'Holiday Sale', '2023-12-01', '2023-12-31', 'SALE', 10);

-- Insert data into 'shop_promotion' table
INSERT INTO shop_promotion (promotion_id, shop_id) VALUES (1, 2);

-- Insert data into 'sale' table
INSERT INTO sale (sale_id, product_id) VALUES (1, 1);

-- Insert data into 'voucher' table
INSERT INTO voucher (voucher_id, cus_id, voucher_code, max_amount) 
VALUES (1, 1, 'VOUCHER123', 50);

-- Insert data into 'orders' table
INSERT INTO orders (order_id, cus_id, total_price) VALUES (1, 1, 549.99);

-- Insert data into 'method' table (already provided in the question)

-- Insert data into 'payment' table
INSERT INTO payment (order_id, amount, method_id, timestamp) 
VALUES (1, 549.99, 1, '2023-12-05 10:30:00');

-- Insert data into 'bill' table
INSERT INTO bill (bill_id, order_id, shop_id, voucher_id, total_price, status) 
VALUES (1, 1, 2, 1, 549.99, 'COMPLETE');

-- Insert data into 'bill_product' table
INSERT INTO bill_product (bill_id, product_id, quantity) VALUES (1, 1, 1);

-- Insert data into 'shipment' table
INSERT INTO shipment (shipment_id, voucher_id, bill_id, shipper_id, shipping_free, phone_num, status) 
VALUES (1, 1, 1, 3, 5.00, '5559876543', 'DELIVERING');

-- Insert data into 'shipment_address' table
INSERT INTO shipment_address (shipment_id, street_address, district, city, note) 
VALUES (1, '123 Delivery St', 'Central District', 'Cityville', 'Leave at the doorstep');

-- Insert data into 'review' table
INSERT INTO review (review_id, cus_id, product_id, rating, comment) 
VALUES (1, 1, 1, 5.0, 'Great product, fast delivery!');

-- Insert data into 'refund' table
INSERT INTO refund (refund_id, cus_id, bill_id, reason, amount, date, status) 
VALUES (1, 1, 1, 'Product damaged', 30.00, '2023-12-10', 'WAIT FOR CONFIRMATION');

SET foreign_key_checks = 1;


=======
IGNORE 1 ROWS
(bill_id,product_id,quantity);
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
=======
IGNORE 1 ROWS
(bill_id,product_id,quantity);
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
