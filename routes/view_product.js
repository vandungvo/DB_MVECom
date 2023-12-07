const express = require('express');
const view_product_router = express.Router();
const view_product_controller = require('../controllers/view_product');

view_product_router.post("/", view_product_controller.viewProduct);

module.exports = view_product_router;