--drop database e_commerce;
--create database e_commerce;
use e_commerce;

if OBJECT_ID('refund', 'U') is not null
	drop table refund
if OBJECT_ID('review', 'U') is not null
	drop table review
if OBJECT_ID('review', 'U') is not null
	drop table review;
if OBJECT_ID('shipment_address', 'U') is not null
	drop table shipment_address;
if OBJECT_ID('shipment', 'U') is not null
	drop table shipment;
if OBJECT_ID('bill_product', 'U') is not null
	drop table bill_product;
if OBJECT_ID('bill', 'U') is not null
	drop table bill;
if OBJECT_ID('payment', 'U') is not null
	drop table payment;
if OBJECT_ID('method', 'U') is not null
	drop table method;
if OBJECT_ID('orders', 'U') is not null
	drop table orders;
if OBJECT_ID('voucher', 'U') is not null
	drop table voucher;
if OBJECT_ID('sale', 'U') is not null
	drop table sale;
if OBJECT_ID('shop_promotion', 'U') is not null
	drop table shop_promotion;
if OBJECT_ID('promotion', 'U') is not null
	drop table promotion;
if OBJECT_ID('wish_item', 'U') is not null
	drop table wish_item;
if OBJECT_ID('product', 'U') is not null
	drop table product;
if OBJECT_ID('category', 'U') is not null
	drop table category;
if OBJECT_ID('shop', 'U') is not null
	drop table shop;
if OBJECT_ID('shipper', 'U') is not null
	drop table shipper;
if OBJECT_ID('shipping_company', 'U') is not null
	drop table shipping_company;
if OBJECT_ID('customer', 'U') is not null
	drop table customer;
if OBJECT_ID('users', 'U') is not null
	drop table users;

create table users (
	user_id varchar(40) not null primary key,
    first_name varchar(30) not null,
    last_name varchar(30) not null,
	user_type varchar(10) not null,
    email varchar(100) not null,
    password varchar(32) not null,
    constraint user_type check (user_type in ('CUSTOMER', 'SELLER', 'SHIPPER', 'ADMIN')),
	constraint email_check check(CharIndex('@', email) > 1)
);

create table customer (
	user_id varchar(40) not null primary key,
    constraint user_customer_fk foreign key (user_id) references users (user_id) on update cascade on delete cascade
);

create table shipping_company (
	company_id varchar(40) not null primary key,
    name varchar(100) not null,
    address text,
    phone_num varchar(12) not null unique
);

create table shipper (
	user_id varchar(40) not null primary key,
    company_id varchar(40) not null,
	phone_num varchar(12) not null unique,
    constraint user_shipper_fk foreign key (user_id) references users (user_id) on update cascade on delete cascade,
    constraint company_shipper_fk foreign key (company_id) references shipping_company (company_id) 
);

create table shop (
	user_id varchar(40) not null primary key,
    shop_name varchar(100) not null,
    /*xem xet address */
    address text,
    constraint user_shop_fk foreign key (user_id) references users (user_id) on update cascade on delete cascade
); 

create table category (
	ctg_id varchar(40) not null primary key,
    name varchar(100) not null
);


create table product (
	product_id varchar(40) not null primary key,
    shop_id varchar(40) not null,
    ctg_id varchar(40) not null,
    name text not null,
    SKU varchar(10) not null unique,
    upload_date date not null default current_timestamp,
	price decimal(14,2) not null,
    stock int not null,
	sold_quantities int not null default 0,
    description text,
    image text,
    rating decimal(2, 1) default 0,
	rate_nums int default 0,
    constraint shop_product_fk foreign key (shop_id) references shop (user_id) on update cascade on delete cascade, 
    constraint ctg_product_fk foreign key (ctg_id) references category (ctg_id) on update cascade on delete no action
);

/* kiem tra lai weak entity*/
create table wish_item (
	wish_id varchar(40) not null primary key,
    cus_id varchar(40) not null,
    product_id varchar(40) not null,
    constraint cus_wish_fk foreign key (cus_id) references customer (user_id) on update cascade on delete cascade,
    constraint product_wish_fk foreign key (product_id) references product (product_id)
);

/*kiem tra lai phan nay*/
create table promotion (
	promotion_id varchar(40) not null primary key,
    name varchar(100) not null,
    /* xem lai start_date*/
    start_date date not null,
    end_date date not null,
    promotion_type varchar (16) not null,
    /* kiem tra lai discount */
    discount_percen int not null,
    constraint promotion_type check (promotion_type in ('VOUCHER', 'SALE', 'SHOP PROMOTION'))
);

create table shop_promotion (
	promotion_id varchar(40) not null,
    shop_id varchar(40) not null,
    constraint promotion_fk foreign key  (promotion_id) references promotion (promotion_id) on update cascade on delete no action, 
    constraint shop_promotion_fk foreign key (shop_id) references shop (user_id) on update cascade on delete cascade
);

create table sale (
	sale_id varchar(40) not null primary key,
    product_id varchar(40) not null,
    constraint promotion_sale_fk foreign key (sale_id) references promotion (promotion_id) on update cascade on delete no action,
    constraint product_sale_fk foreign key (product_id) references product (product_id) on update cascade on delete cascade
);

create table voucher (
	voucher_id varchar(40) not null primary key,
    cus_id varchar(40) not null,
    voucher_code varchar(50) not null,
    max_amount int not null,
    constraint promotion_voucher_fk foreign key (voucher_id) references promotion (promotion_id) on update cascade on delete no action,
    constraint promotion_customer_fk foreign key (cus_id) references customer (user_id) on update cascade on delete cascade
);

create table orders (
	order_id varchar(40) not null primary key,
    cus_id varchar(40) not null,
    total_price decimal(12, 2) not null,
    /* chu y kieu du lieu date*/
    order_date date not null,
    constraint customer_order_fk foreign key (cus_id) references customer (user_id) on update cascade on delete cascade
);

create table method (
	method_id int primary key,
	method text
)

insert into method (method_id, method)
values 
	(1, 'Payment via credit/debit card'),
	(2, 'Electronic wallet (e-Wallet)'),
	(3, 'Installment Payments'),
	(4, 'Payment via Internet Banking'),
	(5, 'Cash on Delivery');

create table payment (
	order_id varchar(10) not null,
    amount decimal(12,2) not null,
    /* thieu method*/
    method_id int not null,
    /*thieu timestamp*/
    timestamp datetime not null default getdate(),
    constraint method_payment_fk foreign key (method_id) references method (method_id) on update no action on delete no action
);

create table bill (
	bill_id varchar(40) not null primary key,
    order_id varchar(40) not null,
    shop_id varchar(40) not null,
    voucher_id varchar(40),
    order_date date not null,
    total_price decimal(12,2) not null,
    /* thieu thuoc tinh status*/
    status varchar(32) not null,
    constraint oder_bill_fk foreign key (order_id) references orders (order_id) on update cascade on delete cascade,
    constraint shop_bill_fk foreign key (shop_id) references shop (user_id) on update no action on delete no action,
    constraint voucher_bill_fk foreign key (voucher_id) references voucher (voucher_id) on update no action on delete no action,
    constraint bill_status check (status in ('WAIT FOR CONFIRMATION', 'DELIVERING', 'COMPLETE', 'INCOMPLETE'))
);

create table bill_product (
	bill_id varchar(40),
    product_id varchar(40),
    quantity int not null,
    constraint bil_product_fk primary key (bill_id, product_id),
    constraint bill_fk foreign key (bill_id) references bill (bill_id) on update no action on delete cascade,
    constraint product_fk foreign key (product_id) references product (product_id) on update no action on delete no action
);

create table shipment (
	shipment_id varchar(40) not null primary key,
    voucher_id varchar(40),
    bill_id varchar(40) not null,
    shipper_id varchar(40) not null,
    shipping_free decimal(10,2) not null,
    phone_num varchar(12) not null,
    /* kiem tra lai state*/
    status varchar(12) not null,
    estimated_time date,
    constraint voucher_shipment_fk foreign key (voucher_id) references voucher (voucher_id) on update no action on delete no action,
    constraint bill_shipment_fk foreign key (bill_id) references bill (bill_id) on update no action on delete cascade,
    constraint shipper_shipment_fk foreign key (shipper_id) references shipper (user_id) on update no action on delete no action,
    constraint shipment_status check (status in ('COMPLETE', 'INCOMPLETE', 'DELIVERING'))
);

create table shipment_address (
	shipment_id varchar(40) not null,
    /* thieu cac thuoc tinh */
    street_address varchar(50),
    district varchar(20),
    city varchar(20) not null,
    note text,
    constraint shipment_fk foreign key (shipment_id) references shipment (shipment_id) on update no action on delete cascade
);

create table review (
	review_id varchar(40) not null primary key,
    cus_id varchar(40) not null,
    product_id varchar(40) not null,
    post_date datetime not null default getdate(),
    rating decimal(2,1),
    comment text,
    constraint customer_review_fk foreign key (cus_id) references customer (user_id),
    constraint product_review_fk foreign key (product_id) references product (product_id) on update no action on delete cascade,
    constraint rating_check check(rating >= 0 and rating <= 5)
);

create table refund (
	refund_id varchar(40) not null primary key,
    cus_id varchar(40) not null,
    bill_id varchar(40) not null,
    reason text,
    amount decimal(12,2) not null,
    date date not null,
    /* thieu state*/
    status varchar(32) not null,
    constraint customer_refund_fk foreign key (cus_id) references customer (user_id) on update no action on delete cascade,
    constraint bill_refund_fk foreign key (bill_id) references bill (bill_id) on update no action on delete no action,
    constraint refund_status check (status in ('WAIT FOR CONFIRMATION', 'CONFIRMED', 'REFUSED'))
);

