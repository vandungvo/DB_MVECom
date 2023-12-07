var connect_DB = require('./connect_db');

const getAllProducts = (shop_id, controller) => {
    const query = `CALL GetAllProducts(${shop_id})`;
    connect_DB.query(query, (err, result) => {
        if (err) {
            console.error(err);
            controller(err, null);
        } else { 
            controller(null, result[0]);
        }
    });
}

const insertProduct = (productName, price, stock, description, callback) => {
    const query = "CALL InsertProduct(?, ?, ?, ?)";
    connect_DB.query(query, [productName, price, stock, description], (err, result) => {
        if (err) {
            console.error(err);
            callback(err, null);
        } else {
            callback(null, result);
        }
    });
}

const updateProduct = (productId, newPrice, newStock, newSoldQuantities, newRating, newRateNums, callback) => {
    const query = "CALL UpdateProduct(?, ?, ?, ?, ?, ?)";
    connect_DB.query(query, [productId, newPrice, newStock, newSoldQuantities, newRating, newRateNums], (err, result) => {
        if (err) {
            console.error(err);
            callback(err, null);
        } else {
            callback(null, result);
        }
    });
}

const deleteProduct = (productId, callback) => {
    const query = "CALL DeleteProduct(?)";
    connect_DB.query(query, [productId], (err, result) => {
        if (err) {
            console.error(err);
            callback(err, null);
        } else {
            callback(null, result);
        }
    });
}

module.exports = {
    getAllProducts,
    insertProduct,
    updateProduct,
    deleteProduct
}
