var connect_DB = require('./connect_db');

const getShopName = (shop_id, controller) => {
    const query = `CALL GetShopName(${shop_id})`;
    connect_DB.query(query, (err, result) => {
        if (err) {
            console.error(err);
            controller(err, null);
        } else { 
            controller(null, result[0]);
        }
    });
}

const getCategories = (controller) => {
    const query = `CALL GetCategories()`;
    connect_DB.query(query, (err, result) => {
        if (err) {
            console.error(err);
            controller(err, null);
        } else { 
            controller(null, result[0]);
        }
    });
}

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

const insertProduct = (product, controller) => {
    const query = `CALL InsertProduct(
        ${product.shop_id}, ${product.ctg_id}, '${product.name}', '${product.SKU}', 
        ${product.price}, ${product.stock}, '${product.description}', '${product.image}'
    )`;
    connect_DB.query(query, (err, result) => {
        if (err) {
            console.error(err.message);
            controller(err, null);
        } else {
           controller(null, result[0]);
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
    getShopName,
    getCategories,
    getAllProducts,
    insertProduct,
    updateProduct,
    deleteProduct
}
