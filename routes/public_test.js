const express = require('express');
const public_test_router = express.Router();
const public_test_controller = require('../controllers/public_test');
const path = require("path");

public_test_router.post("/loadCustomer", public_test_controller.loadCustomer);
public_test_router.post("/loadSeller", public_test_controller.loadSeller);
public_test_router.post("/loadShipper", public_test_controller.loadShipper);

module.exports = public_test_router;