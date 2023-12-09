drop database if exists e_commerce;
create database e_commerce;
use e_commerce;

drop table if exists refund;
drop table if exists review;
drop table if exists shipment_address;
drop table if exists shipment;
drop table if exists bill_product;
drop table if exists bill;
drop table if exists payment;
drop table if exists method;
drop table if exists orders;
drop table if exists voucher;
drop table if exists sale;
drop table if exists shop_promotion;
drop table if exists promotion;
drop table if exists wish_item;
drop table if exists product;
drop table if exists category;
drop table if exists shop;
drop table if exists shipper;
drop table if exists shipping_company;
drop table if exists customer;
drop table if exists users;

create table users (
<<<<<<< HEAD
	user_id int not null primary key,
=======
	user_id int not null primary key auto_increment,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    first_name varchar(30) not null,
    last_name varchar(30) not null,
	user_type varchar(10) not null,
    email varchar(100) not null,
<<<<<<< HEAD
    password varchar(127) not null,
=======
    user_password varchar(32) not null,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    constraint user_type check (user_type in ('CUSTOMER', 'SELLER', 'SHIPPER', 'ADMIN'))
);

create table customer (
<<<<<<< HEAD
	user_id int not null primary key,
=======
	user_id int not null primary key auto_increment,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    constraint user_customer_fk foreign key (user_id) references users (user_id) on update cascade on delete cascade
);

create table shipping_company (
<<<<<<< HEAD
	company_id int not null primary key,
    name varchar(100) not null,
=======
	company_id int not null primary key auto_increment,
    company_name varchar(100) not null,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    address text,
    phone_num varchar(12) not null unique
);

create table shipper (
<<<<<<< HEAD
	user_id int not null primary key,
=======
	user_id int not null primary key auto_increment,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    company_id int not null,
	phone_num varchar(12) not null unique,
    constraint user_shipper_fk foreign key (user_id) references users (user_id) on update cascade on delete cascade,
    constraint company_shipper_fk foreign key (company_id) references shipping_company (company_id) 
);

create table shop (
<<<<<<< HEAD
	user_id int not null primary key,
=======
	user_id int not null primary key auto_increment,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    shop_name varchar(100) not null,
    address text,
    constraint user_shop_fk foreign key (user_id) references users (user_id) on update cascade on delete cascade
); 

create table category (
<<<<<<< HEAD
	ctg_id int not null primary key,
    name varchar(100) not null
);

create table product (
	product_id int not null primary key auto_increment,
    shop_id int not null,
    ctg_id int not null,
    name varchar(1000) not null,
=======
	ctg_id int not null primary key auto_increment,
    ctg_name varchar(100) not null
);

create table product (

	product_id int not null primary key auto_increment,
    shop_id int not null,
    ctg_id int not null,
    product_name varchar(1000) not null,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    SKU varchar(10) not null unique,
    upload_date date not null default (curdate()),
	price decimal(14,2) not null,


    stock int not null,
	sold_quantities int not null default 0,
    product_description text,
    image text,


    rating decimal(2, 1) default 0,
	rate_nums int default 0,
    constraint shop_product_fk foreign key (shop_id) references shop (user_id) on update cascade on delete cascade, 
    constraint ctg_product_fk foreign key (ctg_id) references category (ctg_id) on update cascade on delete no action


);

create table wish_item (
<<<<<<< HEAD
	wish_id int not null primary key,
=======
	wish_id int not null primary key auto_increment,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    cus_id int not null,
    product_id int not null,
    constraint cus_wish_fk foreign key (cus_id) references customer (user_id) on update cascade on delete cascade,
    constraint product_wish_fk foreign key (product_id) references product (product_id)
);

create table promotion (
<<<<<<< HEAD
	promotion_id int not null primary key,
    name varchar(100) not null,
    /* xem lai start_date*/
=======
	promotion_id varchar(20) not null primary key,
    promotion_name varchar(100) not null,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    start_date date not null,
    end_date date not null,
    promotion_type varchar (16) not null,
    discount_percen int not null,
    constraint promotion_type check (promotion_type in ('VOUCHER', 'SALE', 'SHOP PROMOTION'))
);

create table shop_promotion (
<<<<<<< HEAD
	promotion_id int not null,
=======
	promotion_id varchar(20) not null,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    shop_id int not null,
    constraint promotion_fk foreign key  (promotion_id) references promotion (promotion_id) on update cascade on delete no action, 
    constraint shop_promotion_fk foreign key (shop_id) references shop (user_id) on update cascade on delete cascade
);

create table sale (
<<<<<<< HEAD
	sale_id int not null primary key,
=======
	sale_id varchar(20) not null primary key,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    product_id int not null,
    constraint promotion_sale_fk foreign key (sale_id) references promotion (promotion_id) on update cascade on delete no action,
    constraint product_sale_fk foreign key (product_id) references product (product_id) on update cascade on delete cascade
);

create table voucher (
<<<<<<< HEAD
	voucher_id int not null primary key,
=======
	voucher_id varchar(20) not null primary key,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    cus_id int not null,
    voucher_code varchar(50) not null,
    max_amount int not null,
    constraint promotion_voucher_fk foreign key (voucher_id) references promotion (promotion_id) on update cascade on delete no action,
    constraint promotion_customer_fk foreign key (cus_id) references customer (user_id) on update cascade on delete cascade
);

create table orders (
<<<<<<< HEAD
	order_id int not null primary key,
=======
	order_id int not null primary key auto_increment,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    cus_id int not null,
    total_price decimal(12, 2) not null,
    order_date date not null default(curdate()),
    constraint customer_order_fk foreign key (cus_id) references customer (user_id) on update cascade on delete cascade
);

create table method (
	method_id int primary key,
	method text
);

insert into method (method_id, method)
values 
	(1, 'Payment via credit/debit card'),
	(2, 'Electronic wallet (e-Wallet)'),
	(3, 'Installment Payments'),
	(4, 'Payment via Internet Banking'),
	(5, 'Cash on Delivery');

create table payment (
	order_id int not null,
    amount decimal(12,2) not null,
    method_id int not null,
    payment_timestamp datetime not null default current_timestamp,
    constraint method_payment_fk foreign key (method_id) references method (method_id) on update no action on delete no action
);

create table bill (
<<<<<<< HEAD
	bill_id int not null primary key,
    order_id int not null,
    shop_id int not null,
    voucher_id int,
=======
	bill_id int not null primary key auto_increment,
    order_id int not null,
    shop_id int not null,
    voucher_id varchar(20) default null,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    order_date date not null default (curdate()),
    total_price decimal(12,2) not null,
    bill_status varchar(35) not null,
    constraint oder_bill_fk foreign key (order_id) references orders (order_id) on update cascade on delete cascade,
    constraint shop_bill_fk foreign key (shop_id) references shop (user_id) on update no action on delete no action,
    constraint voucher_bill_fk foreign key (voucher_id) references voucher (voucher_id) on update cascade on delete cascade
);

create table bill_product (
	bill_id int,
    product_id int,
    quantity int not null,
    constraint bil_product_fk primary key (bill_id, product_id),
    constraint bill_fk foreign key (bill_id) references bill (bill_id) on update no action on delete cascade,
    constraint product_fk foreign key (product_id) references product (product_id) on update no action on delete no action
);

create table shipment (
<<<<<<< HEAD
	shipment_id int not null primary key,
    voucher_id int,
=======
	shipment_id int not null primary key auto_increment,
    voucher_id varchar(20),
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    bill_id int not null,
    shipper_id int not null,
    shipping_free decimal(10,2) not null,
    phone_num varchar(12) not null,
    shipment_status varchar(12) not null,
    estimated_time date default (curdate()),
    constraint voucher_shipment_fk foreign key (voucher_id) references voucher (voucher_id) on update no action on delete no action,
    constraint bill_shipment_fk foreign key (bill_id) references bill (bill_id) on update no action on delete cascade,
    constraint shipper_shipment_fk foreign key (shipper_id) references shipper (user_id) on update no action on delete no action,
    constraint shipment_status check (shipment_status in ('COMPLETE', 'INCOMPLETE', 'DELIVERING'))
);

create table shipment_address (
	shipment_id int not null,
<<<<<<< HEAD
    /* thieu cac thuoc tinh */
=======
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    street_address varchar(50),
    district varchar(20),
    city varchar(20) not null,
    note text,
    constraint shipment_fk foreign key (shipment_id) references shipment (shipment_id) on update no action on delete cascade
);

create table review (
<<<<<<< HEAD
	review_id int not null primary key,
=======
	review_id int not null primary key auto_increment,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    cus_id int not null,
    product_id int not null,
    post_date datetime not null default current_timestamp,
    rating decimal(2,1),
    review_comment text,
    constraint customer_review_fk foreign key (cus_id) references customer (user_id),
    constraint product_review_fk foreign key (product_id) references product (product_id) on update no action on delete cascade,
    constraint rating_check check(rating >= 0 and rating <= 5)
);

create table refund (
<<<<<<< HEAD
	refund_id int not null primary key,
=======
	refund_id int not null primary key auto_increment,
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
    cus_id int not null,
    bill_id int not null,
    reason text,
    amount decimal(12,2) not null,
    refund_date date not null default (curdate()),
    refund_status varchar(32) not null,
    constraint customer_refund_fk foreign key (cus_id) references customer (user_id) on update no action on delete cascade,
    constraint bill_refund_fk foreign key (bill_id) references bill (bill_id) on update no action on delete no action,
<<<<<<< HEAD
    constraint refund_status check (status in ('WAIT FOR CONFIRMATION', 'CONFIRMED', 'REFUSED'))
);

set foreign_key_checks = 0;
=======
    constraint refund_status check (refund_status in ('WAIT FOR CONFIRMATION', 'CONFIRMED', 'REFUSED'))
);
>>>>>>> 84d2b02de39f5c4c18dad3b6e164edbe3832f860
