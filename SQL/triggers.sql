use e_commerce;

-- review trigger
DROP TRIGGER IF EXISTS update_product_rating;
DELIMITER //
CREATE TRIGGER update_product_rating
AFTER INSERT ON review
FOR EACH ROW
BEGIN
    UPDATE product
    SET rate_nums = rate_nums + 1,
        rating = (rating * (rate_nums - 1) + NEW.rating) / rate_nums
    WHERE product_id = NEW.product_id;
END //
DELIMITER ;

-- test review trigger
INSERT INTO product (shop_id, ctg_id, product_name, SKU, price, stock)
VALUES (14, 2001, 'Test Product', 'SKU123', 100.00, 20);

INSERT INTO review (cus_id, product_id, rating)
VALUES (2, 10101, 1);

INSERT INTO review (cus_id, product_id, rating)
VALUES (2, 10101, 5);

INSERT INTO review (cus_id, product_id, rating)
VALUES (2, 10101, 5);


DROP TRIGGER IF EXISTS after_bill_product_insert;
-- bill trigger
DELIMITER //
CREATE TRIGGER after_bill_product_insert
AFTER INSERT ON bill_product
FOR EACH ROW
BEGIN
    -- Update the bill table
    UPDATE bill
    SET total_price = (
        SELECT SUM(quantity * price)
        FROM (
            SELECT bill_product.quantity, product.price
            FROM bill_product
            JOIN product ON bill_product.product_id = product.product_id
            WHERE bill_product.bill_id = NEW.bill_id
        ) AS subquery
    )
    WHERE bill_id = NEW.bill_id;

    -- Update the orders table
    UPDATE orders
    SET total_price = (
        SELECT SUM(total_price)
        FROM bill
        WHERE orders.order_id = bill.order_id
    )
    WHERE order_id = (SELECT order_id FROM bill WHERE bill_id = NEW.bill_id);
    
    UPDATE product SET sold_quantities = sold_quantities + NEW.quantity WHERE product_id = NEW.product_id;
END //

DELIMITER ;

INSERT INTO orders (cus_id) VALUES (2);

INSERT INTO bill (order_id, shop_id) VALUES (3020, 14);

INSERT INTO bill_product (bill_id, product_id, quantity) VALUES (4047, 10003, 5);

INSERT INTO bill (order_id, shop_id) VALUES (3020, 15);

INSERT INTO bill_product (bill_id, product_id, quantity) VALUES (4048, 10004, 5);
