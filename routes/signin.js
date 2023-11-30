const express = require('express');
const signin_router = express.Router();
const signin_controller = require('../controllers/signin');
const path = require("path");

signin_router.post("/", signin_controller.signin)

module.exports = signin_router;