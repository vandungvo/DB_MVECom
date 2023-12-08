const shop_model = require('../model/DAO/shop');
const authorization_model = require('../model/DAO/authorization');

const getShopName = (req, res) => {
    let shop_id = req.body.shop_id;
    shop_model.getShopName(shop_id, function (err, shop_name) {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else {
            res.json(shop_name);
        }
    })
}

const viewProduct = (req, res) => {
    let shop_id = req.body.shop_id;
    shop_model.getAllProducts(shop_id, function (err, products) {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else {
            res.json(products);
        }
    })
};

module.exports = {
    getShopName,
    viewProduct
};

