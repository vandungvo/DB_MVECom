const path = require("path");
const authorization_model = require('../model/DAO/authorization');

module.exports = {
    customer: [authorization_model.loadCurMember, authorization_model.authorizeCustomer, function (req, res) {
        res.status(200).json({});
    }],
    seller: [authorization_model.loadCurMember, authorization_model.authorizeSeller, function (req, res) {
        res.status(200).json({});
    }],
    shipper: [authorization_model.loadCurMember, authorization_model.authorizeShipper, function (req, res) {
        res.status(200).json({});
    }],
    admin: [authorization_model.loadCurMember, authorization_model.authorizeAdmin, function (req, res) {
        res.status(200).json({});
    }]
}