use e_commerce;
set global local_infile = true;
LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Desktop/DB_MVECom/data/users.csv' 
INTO TABLE users
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS
(user_id,first_name,last_name,user_type,email,user_password);

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