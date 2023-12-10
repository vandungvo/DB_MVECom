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

-- Test review trigger
INSERT INTO review(cus_id, product_id, rating, review_comment) 
VALUES (2, 10001, 1, 'Great product!');

DROP TRIGGER IF EXISTS after_bill_product_insert;
-- bill trigger
DELIMITER //
CREATE TRIGGER after_bill_product_insert
AFTER INSERT ON bill_product
FOR EACH ROW
BEGIN
    -- Update the bill table
    UPDATE bill
    SET total_price = COALESCE((
        SELECT SUM(quantity * price)
        FROM bill_product
        JOIN product ON bill_product.product_id = product.product_id
        WHERE bill.bill_id = NEW.bill_id
    ), 0)
    WHERE bill_id = NEW.bill_id;

    -- Update the orders table
    UPDATE orders
    SET total_price = COALESCE ((
        SELECT SUM(total_price)
        FROM bill
        WHERE orders.order_id = bill.order_id
    ), 0)
    WHERE order_id = (SELECT order_id FROM bill WHERE bill_id = NEW.bill_id);
END //

DELIMITER ;

-- Test bill trigger
INSERT INTO orders(cus_id, total_price) 
VALUES (2, 0);

INSERT INTO bill(order_id, shop_id, total_price, bill_status) 
VALUES (3014, 21, 0, 'Pending');

INSERT INTO bill_product(bill_id, product_id, quantity) 
VALUES (4040, 10005, 10);


