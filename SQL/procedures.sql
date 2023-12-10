use e_commerce;

DELIMITER //
CREATE PROCEDURE GetProductsByCategory(IN categoryName VARCHAR(100))
BEGIN
    DECLARE no_rows CONDITION FOR SQLSTATE '02000'

    DECLARE EXIT HANDLER FOR no_rows
    BEGIN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No Category name';
    END;

    SELECT 
        s.shop_name, p.name, p.price, p.rating, p.rate_nums
    FROM product p
    JOIN category c ON p.ctg_id = c.ctg_id
    JOIN shop s ON p.shop_id = s.user_id
    WHERE c.name = categoryName
    ORDER BY p.sold_quantities;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetOrderHistory(user_id INT,start_date DATE, end_date DATE)
BEGIN
    DECLARE no_rows CONDITION FOR SQLSTATE '02000'

    DECLARE EXIT HANDLER FOR no_rows
    BEGIN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No Customer_id found!';
    END;

    IF end_date > NOW() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Invalid input date, end_date can not greater than now';
	END IF;
    IF start_date > end_date THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Invalid input date, end_date can not greater than start_date';
	END IF;
    SELECT 
        p.name,
        s.shop_name,
        b_d.quantity,
        b.total_price,
        b.order_date,
        ctg.ctg_name
    FROM customer c 
    JOIN orders o ON c.user_id = o.cus_id
    JOIN bill b ON   o.order_id = b.order_id
    JOIN bill_product b_d ON b.bill_id = b_d.bill_id 
    JOIN product p ON b_d.product_id = p.product_id
    JOIN category ctg on p.ctg_id = ctg.ctg_id 
    WHERE
        c.user_id = user_id AND b.order_date >= start_date AND b.order_date <= end_date
    ORDER BY b.order_date;
END //
DELIMITER;


-- DELIMITER //
-- CREATE PROCEDURE GetShopProductsByCategoryAndMinRating(IN categoryName VARCHAR(100), IN minRating DECIMAL(2,1))
-- BEGIN
--     SELECT s.shop_name, AVG(p.rating) AS avg_rating, SUM(p.sold_quantities) AS total_sold
--     FROM product p
--     JOIN category c ON p.ctg_id = c.ctg_id
--     JOIN shop s ON p.shop_id = s.user_id
--     WHERE c.name = categoryName
--     GROUP BY s.shop_name
--     HAVING avg_rating > minRating
--     ORDER BY total_sold DESC;
-- END //
-- DELIMITER ;



