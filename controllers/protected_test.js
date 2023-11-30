const path = require("path");
const authorization_model = require('../model/DAO/authorization');

module.exports = {
    // an array of middleware functions
    authorize: [authorization_model.loadCurMember, authorization_model.authorizeAdmin, function (req, res) {
        res.status(200).json({}); // send a json response
    }],
    load: [authorization_model.loadCurMember, authorization_model.authorizeAdmin, function (req, res) {
        // send a customm response message
        res.json({ message: "Phản hồi từ server: Đăng nhập vào tài khoản quản trị thành công!" })
    }]
}