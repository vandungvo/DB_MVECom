-- Stored procedure để lấy tất cả thông tin sản phẩm
DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM product;
END //
DELIMITER ;

-- Stored procedure để thêm mới sản phẩm
DELIMITER //
CREATE PROCEDURE InsertProduct(
    IN productName VARCHAR(255),
    IN price DECIMAL(10, 2),
    IN stock INT,
    IN description TEXT
)
BEGIN
    -- Kiểm tra ràng buộc
    IF price <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Giá sản phẩm phải lớn hơn 0';
    END IF;

    IF stock <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Số lượng tồn kho phải lớn hơn 0';
    END IF;

    -- Thực hiện insert
    INSERT INTO product (product_name, price, stock, description, sold_quantities, rating, rate_nums)
    VALUES (productName, price, stock, description, 0, 0, 0);
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


