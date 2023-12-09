use e_commerce;
set foreign_key_checks = 0;
set global local_infile = true;

insert into users 
values 
	-- admin
	(1,	'Dung',	'Vo', 'ADMIN', 'dungvoadmin@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	(12, 'Ky', 'Vo', 'ADMIN', 'kyvoadmin@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	(28, 'Thang', 'Pham', 'ADMIN', 'thangphamadmin@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	(69, 'Khoa', 'Huynh', 'ADMIN', 'khoahuynhadmin@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	-- customers
    (2,	'Dung',	'Vo', 'CUSTOMER', 'dungvo@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	(3,	'Ky', 'Vo', 'CUSTOMER', 'kyvo@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	(4,	'Thang', 'Pham', 'CUSTOMER', 'thangpham@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	(5,	'Khoa', 'Huynh', 'CUSTOMER', 'khoahuynh@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
    -- seller
	(14,	'Dung',	'Vo', 'SELLER', 'dungvoshop@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	(15,	'Ky', 'Vo', 'SELLER', 'kyvoshop@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	(21,	'Thang', 'Pham', 'SELLER', 'thangphamshop@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	(22,	'Khoa', 'Huynh', 'SELLER', 'khoahuynhshop@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
    -- shipper
	(11,	'Dung',	'Vo', 'SHIPPER', 'dungvoshipper@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	(23,	'Ky', 'Vo', 'SHIPPER', 'kyvoshipper@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	(29,	'Thang', 'Pham', 'SHIPPER', 'thangphamshipper@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy'),
	(48,	'Khoa', 'Huynh', 'SHIPPER', 'khoahuynhshipper@gmail.com', '$2b$10$vPfiwJdRbJsMV04pbav0TOry.VJe9Of6Gdo08d0mVh9VMpjpJUJHy');

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/customer.csv' 
INTO TABLE customer
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(user_id);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/shop.csv' 
INTO TABLE shop
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(user_id,shop_name,address);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/shipping_company.csv' 
INTO TABLE shipping_company
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(company_id,company_name,address,phone_num);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/shipper.csv' 
INTO TABLE shipper
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/category.csv' 
INTO TABLE category
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(ctg_id,ctg_name);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/product.csv' 
INTO TABLE product
character set latin1
FIELDS TERMINATED BY ',' 
lines terminated by '\r\n'
IGNORE 1 ROWS
(product_id,shop_id,ctg_id,product_name,SKU,upload_date,price,stock,sold_quantities,product_description,image,rating,rate_nums);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/orders.csv' 
INTO TABLE orders
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(order_id,cus_id,total_price,order_date);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/bill.csv' 
INTO TABLE bill
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS 
(bill_id, order_id, shop_id, order_date, total_price, bill_status);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/bill_product.csv' 
INTO TABLE bill_product
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(bill_id,product_id,quantity);