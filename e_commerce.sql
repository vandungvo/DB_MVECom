create database e_commerce;
use e_commerce;
create table users (
	user_id varchar(10) not null primary key,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    user_type varchar(8) not null,
    email varchar(320) not null,
    password varchar(32) not null,
    constraint user_type check (user_type in ('CUSTOMER', 'SELLER', 'SHIPPER'))
);

create table customer (
	user_id varchar(10) not null primary key,
    constraint foreign key (user_id) references users (user_id)
);

create table shipping_company (
	company_id varchar(10) not null primary key,
    name varchar(100) not null,
    /* thieu address */
    address text,
    phone_num varchar(12) not null
);

create table shipper (
	user_id varchar(10) not null primary key,
    company_id varchar(10) not null,
	phone_num varchar(11) not null unique,
    constraint foreign key (user_id) references users (user_id),
    constraint foreign key (company_id) references shipping_company (company_id)
);

create table shop (
	user_id varchar(10) not null primary key,
    shop_name varchar(100) not null,
    /*xem xet address */
    address text,
    constraint foreign key (user_id) references users (user_id)
); 

create table category (
	ctg_id varchar(10) not null primary key,
    name varchar(100) not null
);


create table product (
	product_id varchar(10) not null primary key,
    shop_id varchar(10) not null,
    ctg_id varchar(10) not null,
    name varchar(100) not null,
    
    upload_date date not null,
    stock int not null,
    price decimal(14,2) not null,
   
    image text,
    SKU varchar(8) not null unique,
    sold_quantities int not null,
    rating decimal(2, 1),
    constraint foreign key (shop_id) references shop (user_id),
    constraint foreign key (ctg_id) references category (ctg_id)
);

/* kiem tra lai weak entity*/
create table wish_item (
	wish_id varchar(10) not null primary key,
    cus_id varchar(10) not null,
    product_id varchar(10) not null,
    constraint foreign key (cus_id) references customer (user_id),
    constraint foreign key (product_id) references product (product_id)
);

/*kiem tra lai phan nay*/
create table promotion (
	promotion_id varchar(10) not null primary key,
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
	promotion_id varchar(10) not null,
    shop_id varchar(10) not null,
    constraint foreign key  (promotion_id) references promotion (promotion_id),
    constraint foreign key (shop_id) references shop (user_id)
);

create table sale (
	sale_id varchar(10) not null primary key,
    product_id varchar(10) not null,
    constraint foreign key (sale_id) references promotion (promotion_id),
    constraint foreign key (product_id) references product (product_id)
);

create table voucher (
	voucher_id varchar(10) not null primary key,
    cus_id varchar(10) not null,
    voucher_code varchar(50) not null,
    max_amount int not null,
    constraint foreign key (voucher_id) references promotion (promotion_id),
    constraint foreign key (cus_id) references customer (user_id)
);

create table orders (
	order_id varchar(10) not null primary key,
    cus_id varchar(10) not null,
    total_price decimal(12, 2) not null,
    /* chu y kieu du lieu date*/
    order_date date not null,
    constraint foreign key (cus_id) references customer (user_id)
);

create table method (
	method_id int not null primary key,
    method text
);

create table payment (
	order_id varchar(10) not null,
    amount decimal(12,2) not null,
    /* thieu method*/
    method_id int not null,
    /*thieu timestamp*/
    timestamp int,
    constraint foreign key (method_id) references method (method_id)
);

create table bill (
	bill_id varchar(10) not null primary key,
    order_id varchar(10) not null,
    shop_id varchar(10) not null,
    product_id varchar(10) not null,
    voucher_id varchar(10),
    total_price decimal(12,2) not null,
    /* thieu thuoc tinh status*/
    status varchar(32) not null,
    constraint foreign key (order_id) references orders (order_id),
    constraint foreign key (shop_id) references shop (user_id),
    constraint foreign key (voucher_id) references voucher (voucher_id),
    constraint bill_status check (status in ('WAIT FOR CONFIRMATION', 'DELIVERING', 'COMPLETE', 'INCOMPLETE'))
);

create table bill_product (
	bill_id varchar(10),
    product_id varchar(10),
    quantity int not null,
    constraint primary key (bill_id, product_id),
    constraint foreign key (bill_id) references bill (bill_id),
    constraint foreign key (product_id) references product (product_id)
);

create table shipment (
	shipment_id varchar(10) not null primary key,
    voucher_id varchar(10),
    bill_id varchar(10) not null,
    shipper_id varchar(10) not null,
    shipping_free decimal(10,2) not null,
    phone_num varchar(11) not null,
    /* kiem tra lai state*/
    status varchar(12) not null,
    estimated_time date,
    constraint foreign key (voucher_id) references voucher (voucher_id),
    constraint foreign key (bill_id) references bill (bill_id),
    constraint foreign key (shipper_id) references shipper (user_id),
    constraint shipment_status check (status in ('COMPLETE', 'INCOMPLETE', 'DELIVERING'))
);

create table shipment_address (
	shipment_id varchar(10) not null,
    /* thieu cac thuoc tinh */
    street_address varchar(50),
    district varchar(20),
    city varchar(20) not null,
    note text,
    constraint foreign key (shipment_id) references shipment (shipment_id)
);

create table review (
	review_id varchar(10) not null primary key,
    cus_id varchar(10) not null,
    product_id varchar(10) not null,
    post_date date not null,
    rating decimal(2,1),
    comment text,
    constraint foreign key (cus_id) references customer (user_id),
    constraint foreign key (product_id) references product (product_id),
    constraint check(rating >= 0 and rating <= 5)
);

create table refund (
	refund_id varchar(10) not null primary key,
    cus_id varchar(10) not null,
    bill_id varchar(10) not null,
    reason text,
    amount decimal(12,2) not null,
    date date not null,
    /* thieu state*/
    status varchar(32) not null,
    constraint foreign key (cus_id) references customer (user_id),
    constraint foreign key (bill_id) references bill (bill_id),
    constraint refund_status check (status in ('WAIT FOR CONFIRMATION', 'CONFIRMED', 'REFUSED'))
);
