-- Stored procedure to get shop information
DELIMITER //
CREATE PROCEDURE GetUser(
	IN id INT
)
BEGIN 
	SELECT * 
    FROM users
    WHERE user_id = id;
END //
DELIMITER;

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
    SELECT p.*, c.ctg_name
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
    INSERT INTO product (shop_id, ctg_id, product_name, SKU, price, stock, product_description, image)
    VALUES (p_shop_id, p_ctg_id, p_name, p_SKU, p_price, p_stock, p_description, p_image);
END //
DELIMITER ;


-- stored procedure to update product
DELIMITER //
CREATE PROCEDURE UpdateProduct(
    IN p_id INT,
    IN p_ctg_id INT,
    IN p_name VARCHAR(100),
    IN p_SKU VARCHAR(100),
    IN p_price DECIMAL(14, 2),
    IN p_stock INT,
    IN p_description TEXT,
    IN p_image TEXT
)
BEGIN
    -- Kiểm tra ràng buộc
    IF p_price <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Giá sản phẩm phải lớn hơn 0';
    END IF;

    IF p_stock <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Số lượng tồn kho phải lớn hơn 0';
    END IF;

    UPDATE product
    SET ctg_id = p_ctg_id, product_name = p_name, SKU = p_SKU, 
		price = p_price, stock = p_stock, product_description = p_description,
        image = p_image
    WHERE product_id = p_id;
END //
DELIMITER ;

-- stored procedure to delete a product
DELIMITER //
CREATE PROCEDURE DeleteProduct(
    IN p_id INT
)
BEGIN
    DELETE FROM product
    WHERE product_id = p_id;
END //
DELIMITER ;

drop procedure getBillInfo;
-- stored procedure to get orders
DELIMITER //
create procedure getBillInfo (in shop_id int)
begin
  select product_name, quantity, quantity * price as total_price, bill_status
  from product
  inner join bill_product on product.product_id = bill_product.product_id
  inner join bill on bill_product.bill_id = bill.bill_id
  where bill.shop_id = shop_id;
end
DELIMITER ;



