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
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
lines terminated by '\n'
IGNORE 1 ROWS
(product_id,shop_id,ctg_id,product_name,SKU,upload_date,price,stock,sold_quantities,product_description,image,rating,rate_nums);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/wish_item.csv' 
INTO TABLE wish_item
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(wish_id,cus_id,product_id);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/promotion.csv' 
INTO TABLE promotion
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(promotion_id,promotion_name,start_date,end_date,promotion_type,discount_percen);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/shop_promotion.csv' 
INTO TABLE shop_promotion
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(promotion_id,shop_id);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/sale.csv' 
INTO TABLE sale
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(sale_id,product_id);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/voucher.csv' 
INTO TABLE voucher
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(voucher_id,cus_id,voucher_code,max_amount);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/payment.csv' 
INTO TABLE payment
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(order_id,amount,method_id,payment_timestamp);

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

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/shipment.csv' 
INTO TABLE shipment
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(shipment_id,bill_id,shipper_id,shipping_fee,phone_num,shipment_status,estimated_time);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/shipment_address.csv' 
INTO TABLE shipment_address
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(shipment_id,street_address,district,city,note);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/review.csv' 
INTO TABLE review
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(review_id,cus_id,product_id,post_date,rating,review_comment);

LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/refund.csv' 
INTO TABLE refund
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(refund_id,cus_id,bill_id,reason,amount,refund_date,refund_status);
