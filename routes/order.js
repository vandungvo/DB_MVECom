const express = require('express');
const order_router = express.Router();
const order_controller = require('../controllers/order.js');

order_router.get("/:id", order_controller.getOrdersByCustomerID);
order_router.post("/", order_controller.createNewOrder);
order_router.get("/order/:id", order_controller.getOrdersByOrderID);

module.exports = order_router;
