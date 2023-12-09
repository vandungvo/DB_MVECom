-- Stored procedure to get name of shop
DELIMITER //
CREATE PROCEDURE GetShopName(
    IN id INT
)
BEGIN
    SELECT shop_name
    FROM shop
    WHERE user_id = id;
END //
DELIMITER ;

-- Stored procedure to get all products in a shop
DELIMITER //
CREATE PROCEDURE GetAllProducts(
	IN id INT
)
BEGIN
    SELECT p.*, c.name AS ctg_name
    FROM product p
    JOIN category c ON p.ctg_id = c.ctg_id
    WHERE p.shop_id = id;
END //
DELIMITER ;

-- Stored procedure to get all catergories
DELIMITER //
CREATE PROCEDURE GetCategories()
BEGIN
    SELECT * FROM category;
END //
DELIMITER ;


-- Stored procedure to add a new product
DELIMITER //
CREATE PROCEDURE InsertProduct(
    IN p_shop_id INT,
    IN p_ctg_id INT,
    IN p_name VARCHAR(100),
    IN p_SKU VARCHAR(100),
    IN p_price DECIMAL(14, 2),
    IN p_stock INT,
    IN p_description TEXT,
    IN p_image TEXT
)
BEGIN
    -- Kiểm tra giá và số lượng tồn kho là số dương
    IF p_price <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Giá sản phẩm phải lớn hơn 0';
    END IF;

    IF p_stock <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng tồn kho phải lớn hơn 0';
    END IF;

    -- Thực hiện thêm sản phẩm
    INSERT INTO product (shop_id, ctg_id, name, SKU, price, stock, description, image)
    VALUES (p_shop_id, p_ctg_id, p_name, p_SKU, p_price, p_stock, p_description, p_image);
END //
DELIMITER ;


-- Tạo stored procedure để cập nhật thông tin sản phẩm
DELIMITER //
CREATE PROCEDURE UpdateProduct(
    IN productId INT,
    IN newPrice DECIMAL(10, 2),
    IN newStock INT,
    IN newSoldQuantities INT,
    IN newRating INT,
    IN newRateNums INT
)
BEGIN
    -- Kiểm tra ràng buộc
    IF newPrice <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Giá sản phẩm phải lớn hơn 0';
    END IF;

    IF newStock <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Số lượng tồn kho phải lớn hơn 0';
    END IF;

    IF newSoldQuantities < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Số lượng đã bán phải không âm';
    END IF;

    -- Thực hiện update
    UPDATE product
    SET price = newPrice, stock = newStock
    WHERE product_id = productId;
END //
DELIMITER ;

-- Tạo stored procedure để xóa sản phẩm
DELIMITER //
CREATE PROCEDURE DeleteProduct(
    IN productId INT
)
BEGIN
    -- Thực hiện delete
    DELETE FROM product
    WHERE product_id = productId;
END //
DELIMITER ;


