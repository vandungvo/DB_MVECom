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
        FROM bill_product
        JOIN product ON bill_product.product_id = product.product_id
        WHERE bill.bill_id = NEW.bill_id
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
END //

DELIMITER ;


