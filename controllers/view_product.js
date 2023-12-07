const product_model = require('../model/DAO/product');
// const seller_model = require('../model/DAO/seller');

const viewProduct = (req, res) => {
    product_model.getAllProducts((err, products) => {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else {
            res.json(products);
        }
    })
};

module.exports = {
    viewProduct
};

