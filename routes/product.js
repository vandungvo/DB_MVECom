const express = require('express');
const product_router = express.Router();
const product_controller = require('../controllers/product');

product_router.get("/", product_controller.getProducts);
product_router.get("/:id", product_controller.getProductByID);

module.exports = product_router;
