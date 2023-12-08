const express = require('express');
const authorization_router = express.Router();
const authorization_controller = require('../controllers/authorization');
const path = require("path");

authorization_router.post("/customer", authorization_controller.customer);
authorization_router.post("/seller", authorization_controller.seller);
authorization_router.post("/shipper", authorization_controller.shipper);
authorization_router.post("/admin", authorization_controller.admin);

module.exports = authorization_router;

