var connect_DB = require('./connect_db');

const getUser = (shop_id, controller) => {
    const query = `CALL GetUser(${shop_id})`;
    connect_DB.query(query, (err, result) => {
        if (err) {
            console.error(err);
            controller(err, null);
        } else { 
            controller(null, result[0]);
        }
    });
}

const getShopName = (shop_id, controller) => {
    const query = `CALL GetShopName(${shop_id})`;
    connect_DB.query(query, (err, result) => {
        controller(err, result[0]);
    })
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
    connect_DB.query(query, function (err, result) {
        controller(err, result);
    });
}

const updateProduct = (product, controller) => {
    const query = `CALL UpdateProduct(
        ${product.product_id}, ${product.ctg_id}, '${product.name}', '${product.SKU}', 
        ${product.price}, ${product.stock}, '${product.description}', '${product.image}'
    )`;
    connect_DB.query(query, function (err, result) {
        controller(err, result);
    });
}

const deleteProduct = (product_id, controller) => {
    const query = `CALL DeleteProduct(${product_id})`;
    connect_DB.query(query, (err, result) => {
        if (err) {
            console.error(err.message);
            controller(err, null);
        } else {
           controller(null, result);
        }
    });
}

const getOrder = (shop_id, controller) => {
    const query = `CALL GetBillInfo(${shop_id})`;
    connect_DB.query(query, (err, result) => {
        if (err) {
            console.error(err);
            controller(err, null);
        } else { 
            controller(null, result[0]);
        }
    });
}

module.exports = {
    getUser,
    getShopName,
    getCategories,
    getAllProducts,
    insertProduct,
    updateProduct,
    deleteProduct,
    getOrder
}
