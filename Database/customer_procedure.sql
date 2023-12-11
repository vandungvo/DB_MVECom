use e_commerce;

DROP PROCEDURE IF EXISTS GetProducts;
DELIMITER //
CREATE PROCEDURE GetProducts(IN keyword VARCHAR(1000), IN category VARCHAR(100), IN sortOption VARCHAR(100), IN offset INT, IN lim INT)
BEGIN
  SET @keywordCondition = IF(keyword = '', '', CONCAT(' AND p.product_name LIKE "%', keyword, '%"'));
  SET @categoryCondition = IF(category = '', '', CONCAT(' AND c.ctg_name = "', category, '"'));
  CASE sortOption
    WHEN 'price_asc' THEN SET @sortCondition = ' ORDER BY p.price ASC';
    WHEN 'price_desc' THEN SET @sortCondition = ' ORDER BY p.price DESC';
    WHEN 'sold_quantities_asc' THEN SET @sortCondition = ' ORDER BY p.sold_quantities ASC';
    WHEN 'sold_quantities_desc' THEN SET @sortCondition = ' ORDER BY p.sold_quantities DESC';
    WHEN 'rating_asc' THEN SET @sortCondition = ' ORDER BY p.rating ASC';
    WHEN 'rating_desc' THEN SET @sortCondition = ' ORDER BY p.rating DESC';
    ELSE SET @sortCondition = '';
  END CASE;
  SET @limitCondition = CONCAT(' LIMIT ', offset, ', ', lim);

  SET @sql = CONCAT('SELECT p.product_id, p.product_name, p.image, p.rating, p.rate_nums, p.price, c.ctg_name, s.shop_name
                     FROM product p
                     JOIN category c ON p.ctg_id = c.ctg_id
                     JOIN shop s ON p.shop_id = s.user_id
                     WHERE 1', @keywordCondition, @categoryCondition, @sortCondition, @limitCondition);

  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS GetProductById;
DELIMITER //
CREATE PROCEDURE GetProductById(IN productId INT)
BEGIN
    SELECT 
        s.shop_name, 
        s.user_id AS shop_id,
        c.ctg_name, 
        p.product_id,
        p.product_name, 
        p.image, 
        p.rating, 
        p.rate_nums, 
        p.price, 
        p.product_description, 
        p.stock
    FROM product p	
    INNER JOIN shop s ON p.shop_id = s.user_id
    INNER JOIN category c ON p.ctg_id = c.ctg_id
    WHERE p.product_id = productId;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS GetOrdersByCustomerID;
DELIMITER //
CREATE PROCEDURE GetOrdersByCustomerID(IN customerId INT, IN sortOrder VARCHAR(4))
BEGIN
    IF sortOrder = '' THEN
        SET sortOrder = 'ASC';  
    END IF;

    SET @sql = CONCAT('SELECT * FROM orders WHERE cus_id = ', customerId, ' ORDER BY order_date ', sortOrder);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS GetBillDetailsByOrderId;
DELIMITER //
CREATE PROCEDURE GetBillDetailsByOrderId(IN orderId INT)
BEGIN
    SELECT 
        s.shop_name, 
        p.product_name, 
        p.image, 
        bp.quantity, 
        p.price
    FROM bill b
    INNER JOIN shop s ON b.shop_id = s.user_id
    INNER JOIN bill_product bp ON b.bill_id = bp.bill_id
    INNER JOIN product p ON bp.product_id = p.product_id
    WHERE b.order_id = orderId
    ORDER BY s.shop_name;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS CreateNewOrder;
DELIMITER //
CREATE PROCEDURE CreateNewOrder(IN customerId INT, IN products JSON)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE productCount INT;
    DECLARE currentProductId INT;
    DECLARE currentShopId INT;
    DECLARE currentQty INT;
    DECLARE currentPrice DECIMAL(12, 2);
    DECLARE currentShopName VARCHAR(100);
    DECLARE orderId INT;
    DECLARE billId INT;

    SET productCount = JSON_LENGTH(products);

    INSERT INTO orders (cus_id) VALUES (customerId);
	SET orderId = LAST_INSERT_ID();

    WHILE i < productCount DO
        SET currentProductId = JSON_EXTRACT(products, CONCAT('$[', i, '].product_id'));
        SET currentShopId = JSON_EXTRACT(products, CONCAT('$[', i, '].shop_id'));
        SET currentQty = JSON_EXTRACT(products, CONCAT('$[', i, '].qty'));
        SET currentPrice = JSON_EXTRACT(products, CONCAT('$[', i, '].price'));
        SET currentShopName = JSON_EXTRACT(products, CONCAT('$[', i, '].shop_name'));

        IF i = 0 OR currentShopName != JSON_EXTRACT(products, CONCAT('$[', i - 1, '].shop_name')) THEN
            INSERT INTO bill (order_id, shop_id) VALUES (orderId, currentShopId);
            SET billId = LAST_INSERT_ID();
        END IF;

        INSERT INTO bill_product (bill_id, product_id, quantity) VALUES (billId, currentProductId, currentQty);

        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;







