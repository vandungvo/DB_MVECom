const express = require('express');
const shop_router = express.Router();
const shop_controller = require('../controllers/shop');

shop_router.post("/getShopName", shop_controller.getShopName);
shop_router.post("/viewProduct", shop_controller.viewProduct);

module.exports = shop_router;