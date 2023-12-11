const shop_model = require('../model/DAO/shop');
const authorization_model = require('../model/DAO/authorization');

const getUser = (req, res) => {
    let shop_id = req.body.shop_id;
    shop_model.getUser(shop_id, function (err, user) {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else {
            res.json(user);
        }
    })
}

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

const getCategories = (req, res) => {
    shop_model.getCategories(function (err, categories) {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else {
            res.json(categories);
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

const insertProduct = (req, res) => {
    let product = {
        shop_id: req.body.shop_id,
        ctg_id: req.body.ctg_id,
        name: req.body.name,
        SKU: req.body.SKU,
        price: req.body.price,
        stock: req.body.stock,
        description: req.body.description,
        image: req.body.image
    };
    const isEmpty = (value) => value == null || value == undefined || value == '';
    if (isEmpty(req.body.ctg_id)) {
        res.status(400).json({ message: 'Không được để trống catergory' });
    } else if (isEmpty(req.body.name)) {
        res.status(400).json({ message: 'Không được để trống tên sản phẩm' });
    } else if (isEmpty(req.body.SKU)) {
        res.status(400).json({ message: 'Không được để trống SKU' });
    } else if (isEmpty(req.body.price)) {
        res.status(400).json({ message: 'Không được để trống giá' });
    } else if (isEmpty(req.body.stock)) {
        res.status(400).json({ message: 'Không được để trống stock' });
    } else {
        shop_model.insertProduct(product, function (err, result) {
            if (err) {
                res.status(500).json({ message: err.message });
            } else {
                res.json({ message: "Successfully add product!" });
            }
        })
    }
};

const updateProduct = (req, res) => {
    let product = {
        product_id: req.body.product_id,
        ctg_id: req.body.ctg_id,
        name: req.body.name,
        SKU: req.body.SKU,
        price: req.body.price,
        stock: req.body.stock,
        description: req.body.description,
        image: req.body.image
    };
    const isEmpty = (value) => value == null || value == undefined || value == '';
    if (isEmpty(req.body.ctg_id)) {
        res.status(400).json({ message: 'Không được để trống catergory' });
    } else if (isEmpty(req.body.name)) {
        res.status(400).json({ message: 'Không được để trống tên sản phẩm' });
    } else if (isEmpty(req.body.SKU)) {
        res.status(400).json({ message: 'Không được để trống SKU' });
    } else if (isEmpty(req.body.price)) {
        res.status(400).json({ message: 'Không được để trống giá' });
    } else if (isEmpty(req.body.stock)) {
        res.status(400).json({ message: 'Không được để trống stock' });
    } else {
        shop_model.updateProduct(product, function (err, result) {
            if (err) {
                res.status(500).json({ message: err.message });
            } else {
                res.json({ message: "Successfully update product!" });
            }
        })
    }
};

const deleteProduct = (req, res) => {
    let product_id = req.body.product_id;
    shop_model.deleteProduct(product_id, function (err, result) {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else {
            res.json({ message: "Successfully delete product!" });
        }
    })
}

const getOrder = (req, res) => {
    let shop_id = req.body.shop_id;
    shop_model.getOrder(shop_id, function (err, orders) {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else {
            res.json(orders);
        }
    })
}

module.exports = {
    getUser,
    getShopName,
    getCategories,
    viewProduct,
    insertProduct,
    updateProduct,
    deleteProduct,
    getOrder
};

