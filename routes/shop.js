const express = require('express');
const shop_router = express.Router();
const shop_controller = require('../controllers/shop');

shop_router.post("/getShopName", shop_controller.getShopName);
shop_router.post("/getCategories", shop_controller.getCategories);
shop_router.post("/viewProduct", shop_controller.viewProduct);
shop_router.post("/insertProduct", shop_controller.insertProduct);

module.exports = shop_router;