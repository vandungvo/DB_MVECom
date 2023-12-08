use e_commerce;
delete from users;
LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/users.csv' 
INTO TABLE users
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/customer.csv' 
INTO TABLE customer
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/shop.csv' 
INTO TABLE shop
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/shipping_company.csv' 
INTO TABLE shipping_company
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/shipper.csv' 
INTO TABLE shipper
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/category.csv' 
INTO TABLE category
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/product.csv' 
INTO TABLE product
character set latin1
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/orders.csv' 
INTO TABLE orders
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/bill.csv' 
INTO TABLE bill
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'c:/users/admin/Documents/hcsdl/DB_MVECom/data/bill_product.csv' 
INTO TABLE bill_product
FIELDS TERMINATED BY ',' 
IGNORE 1 ROWS;
