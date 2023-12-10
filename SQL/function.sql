USE e_commerce;

DROP FUNCTION IF EXISTS ShopVolume;
DELIMITER //
CREATE FUNCTION ShopVolume(start_date DATE, end_date DATE) 
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE shop_volume DECIMAL(12,2);
    DECLARE shop_access INT;
    DECLARE shop_access_id INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE result_msg TEXT DEFAULT "";
    DECLARE total_shop INT;
    DECLARE shop_access CURSOR FOR 
		SELECT user_id FROM shop ORDER BY user_id ASC;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE = TRUE;
    
    SELECT COUNT(*) INTO total_shop FROM shop;
    IF total_shop = 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: No Shop Found';
	END IF;
    IF start_date > end_date THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Invalid Date';
    END IF;
    IF end_date > NOW() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Invalid Date';
	END IF;
    
    SET result_msg = CONCAT("---------", "VOLUME OF SHOPS FROM ", start_date, " TO ", end_date, "---------\n");
    OPEN shop_access;
    read_loop: LOOP
		FETCH shop_access INTO shop_access_id;
        IF done THEN 
			LEAVE read_loop;
		END IF;
        SELECT SUM(total_price) INTO shop_volume FROM bill 
			WHERE shop_id = shop_access_id AND order_date >= start_date AND order_date <= end_date AND bill_status = 1;
        IF shop_volume IS NULL THEN
			SET shop_volume = 0;
		END IF;
        SET result_msg = CONCAT(result_msg, '\nshop id: ', shop_access_id, ' | volume: ', shop_volume);
	END LOOP read_loop;
    CLOSE shop_access;
    RETURN result_msg;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION ShopReport(shop_id INT,start_date DATE, end_date DATE) 
RETURNS TEXT
DETERMINISTIC
BEGIN 
    DECLARE product_quantity INT;
    DECLARE product_access INT;
    DECLARE product_access_id INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE result_msg TEXT DEFAULT "";
    DECLARE total_product INT;
    DECLARE product_access CURSOR FOR 
		SELECT product_id FROM product p 
    JOIN shop s ON p.shop_id = s.shop_id 
    WHERE s.shop_id = shop_id 
    ORDER BY product_id ASC;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE = TRUE;
    
    SELECT COUNT(*) INTO total_product FROM product;
    IF total_product = 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No Product found!';
	END IF;
    IF end_date > NOW() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Invalid input date, end_date can not greater than now';
	END IF;
    IF start_date > end_date THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Invalid input date, end_date can not greater than start_date';
	END IF;
    
    SET result_msg = CONCAT("---------", "PRODUCT SELLING REPORT FROM ", start_date, " TO ", end_date, "---------\n");
    OPEN product_access;
    read_loop: LOOP
		FETCH product_access INTO product_access_id;
        IF done THEN 
			LEAVE read_loop;
		END IF;
        SELECT SUM(quantity) INTO product_quantity 
        FROM bill b 
        JOIN bill_product b_d ON b.bill_id = b_d.product_id 
        JOIN product p ON b_d.product_id = p.product_id 
			WHERE b.shop_id = shop_id 
        AND p.product_id = product_access_id 
        AND b.order_date >= start_date 
        AND b.order_date <= end_date 
        AND b.bill_status = 'COMPLETE';
      IF product_quantity IS NULL THEN
			SET product_quantity = 0;
		END IF;
        SET result_msg = CONCAT(result_msg, '\nProduct id: ', product_access_id, ' | Sold quantities: ', product_quantity);
	END LOOP read_loop;
    CLOSE product_access;
    RETURN result_msg;

END //
DELIMITER ;



SELECT ShopVolume('2023-01-01', '2023-12-10');
