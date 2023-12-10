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
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Chưa có shop nào được thêm vào';
	END IF;
    IF start_date > end_date THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Ngày không hợp lệ';
    END IF;
    IF end_date > NOW() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Ngày không hợp lệ';
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
SELECT ShopVolume('2023-01-01', '2023-12-10');