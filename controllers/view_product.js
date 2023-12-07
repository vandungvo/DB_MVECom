const product_model = require('../model/DAO/product');
const authorization_model = require('../model/DAO/authorization');

const viewProduct = (req, res) => {
    let shop_id = req.body.shop_id;
    product_model.getAllProducts(shop_id, function (err, products) {
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

