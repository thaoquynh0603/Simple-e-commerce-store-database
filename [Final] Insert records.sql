/*--------------------STEP 1: INSERT CUSTOMERS'INFORMATION --------------------*/
INSERT INTO e_commerce_store.customers (customer_id, customer_name, city, address, phone)
VALUES (01, 'Sophia', 'Sydney', '15 Lidcombe Street', '0212345678'),
		(02, 'Lucy' , 'Melbourne', '14 Griffin Cres', '0201827721'),
        (03, 'Mat' , 'Adelaide', '30 Abernethy Road', '0202817220');

/*--------------------STEP 2: INSERT PRODUCTS'INFORMATION --------------------*/
INSERT INTO e_commerce_store.products (product_id, product_name, unit_price)
VALUES (01, 'Dove Shampoo', 3), (02, 'Dove Conditioner', 2.9), (03, 'Danisa Cookie', 5), (04, 'Cooking Oid', 2), (05, 'Soyce Sauce', 1.0);

/*--------------------STEP 3: ORDERS'S RECEIVED --------------------*/
INSERT INTO e_commerce_store.orders (order_id, customer_id)
VALUES (01, 01), (02, 02), (03, 03);

						/* 3.1 Add time*/
UPDATE e_commerce_store.orders
SET create_time = now()
WHERE order_id = 01;

UPDATE e_commerce_store.orders
SET create_time = now()
WHERE order_id = 02;

UPDATE e_commerce_store.orders
SET create_time = now()
WHERE order_id = 03;

/*--------------------STEP 4: INSERT ORDER ITEMS' INFORMATION --------------------*/
INSERT INTO e_commerce_store.order_item(order_item_id, order_id, product_id, quantity)
VALUES (01, 01, 01, 2), (02, 01, 03, 3), (03, 02, 02, 1), (04, 02, 05, 3), (05, 02, 04, 1), (06, 03, 01, 1), (07, 03, 02, 1), (08, 03, 04, 4);

					/* 4.1 Insert the unit_price of the product*/
UPDATE
    order_item
INNER JOIN products
        ON order_item.product_id = products.product_id
SET order_item.unit_price =
	(select products.unit_price from products where products.product_id = order_item.product_id)
where order_item.order_item_id in (01, 02, 03, 04, 05, 06, 07, 08);

					/*4.2 Insert the extended_price of the product*/
UPDATE
    order_item
SET order_item.extended_price = order_item.quantity*order_item.unit_price
where order_item.order_item_id in (01, 02, 03, 04, 05, 06, 07, 08);

/*--------------------STEP 5: UPDATE INFORMATION ABOUT ORDER --------------------*/

					/*5.1 Add subtotal*/
UPDATE
    orders
INNER JOIN order_item
        ON order_item.order_id = orders.order_id
SET orders.subtotal =
	(select sum(order_item.extended_price) from order_item where order_item.order_id = 01)
where orders.order_id = 01;

UPDATE
    orders
INNER JOIN order_item
        ON order_item.order_id = orders.order_id
SET orders.subtotal =
	(select sum(order_item.extended_price) from order_item where order_item.order_id = 02)
where orders.order_id = 02;

UPDATE
    orders
INNER JOIN order_item
        ON order_item.order_id = orders.order_id
SET orders.subtotal =
	(select sum(order_item.extended_price) from order_item where order_item.order_id = 03)
where orders.order_id = 03;

				/*5.2 Add discount*/
UPDATE
    orders
SET orders.discount =
	(select 
		case 
			when orders.subtotal > 5 then orders.subtotal*(5/100)
            when orders.subtotal > 10 then orders.subtotal*(10/100)
            when orders.subtotal > 30 then orders.subtotal*(20/100)
            when orders.subtotal > 50 then orders.subtotal*(30/100)
		end)
where orders.order_id in (01, 02, 03);

				/*5.3 Add total*/
UPDATE
    orders
SET orders.total = orders.subtotal - orders.discount
where orders.order_id in (01, 02, 03);



