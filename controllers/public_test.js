const path = require("path");
const authorization_model = require('../model/DAO/authorization');

module.exports = {
    loadCustomer: [authorization_model.loadCurMember, authorization_model.authorizeCustomer, function (req, res) {
        res.status(200).json({});
    }],
    loadSeller: [authorization_model.loadCurMember, authorization_model.authorizeSeller, function (req, res) {
        res.json({})
    }],
    loadShipper: [authorization_model.loadCurMember, authorization_model.authorizeShipper, function (req, res) {
        res.status(200).json({})
    }]
}