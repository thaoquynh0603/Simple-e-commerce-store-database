/*CREATE AND USE THE SCHEMA*/
create schema e_commerce_store;
use e_commerce_store;

/*CREATE THE CUSTOMER TABLE*/
create table customers (
	customer_id int not null,
    customer_name varchar(250) not null,
    city varchar(250) not null,
    address varchar(300),
    phone char(10) not null, 
    primary key(customer_id)
    );

/*CREATE THE ORDER TABLE*/
create table orders(
	order_id int not null,
    customer_id int not null,
    create_time datetime not null default ('0000-0000-0000 00:00:00'),
    subtotal float not null default 0,
    discount float not null default 0,
    total float not null default 0,
    primary key(order_id),
    foreign key(customer_id) references customers(customer_id)
    );

/*CREATE THE PRODUCT TABLE*/
create table products(
	product_id int not null,
    product_name varchar(250) not null,
    unit_price float not null,
    primary key (product_id)
	);
    
/*CREATE THE ORDER ITEM TABLE*/
create table order_item(
	order_item_id int not null,
    order_id int not null,
    product_id int not null,
    quantity int not null,
    unit_price int not null default 0,
    extended_price float not null default 0,
    primary key(order_item_id, order_id),
    foreign key(order_id) references orders(order_id),
    foreign key(product_id) references products(product_id)
	);