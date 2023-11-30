var connect_DB = require('./connect_db');
var jwt = require("jsonwebtoken");
var bcrypt = require("bcrypt");

async function loadCurMember(req, res, next) {
    try {
        const token = await req.headers.authorization.split(" ")[1];
        const decodeToken = await jwt.verify(token, "RANDOM-TOKEN");
        const cur_member = await decodeToken;
        req.cur_member = cur_member;
        next();
    }
    catch (error) {
        res.status(401).json({ message: "Người dùng chưa đăng nhập hoặc phiên đã hết hạn" });
    }
}

async function authorizeCustomer(req, res, next) {
    if (req.cur_member) {
        let sql = "SELECT * FROM users WHERE user_id = ? AND user_type = ? AND email = ?";
        connect_DB.query(sql, [
            req.cur_member.user_id,
            req.cur_member.user_type,
            req.cur_member.email
        ], function (err, result, field) {
            if (err) {
                res.status(500).json({ message: "Hệ thống gặp vấn đề. Vui lòng thử lại sau" });
            }
            else if (result.length == 0) {
                res.status(400).json({ message: "Người dùng không tồn tại. Vui lòng kiểm tra" });
            }
            else {
                if (result[0].user_type != "Customer") {
                    res.status(403).json({ message: "Người dùng không có quyền truy cập trang hay tác vụ này!" });
                }
                else {
                    next();
                }
            }
        })
    }
    else {
        res.status(401).json({ message: "Người dùng không xác định. Vui lòng kiểm tra" });
    }
}

async function authorizeSeller(req, res, next) {
    if (req.cur_member) {
        let sql = "SELECT * FROM users WHERE user_id = ? AND user_type = ? AND email = ?";
        connect_DB.query(sql, [
            req.cur_member.user_id,
            req.cur_member.user_type,
            req.cur_member.email
        ], function (err, result, field) {
            if (err) {
                res.status(500).json({ message: "Hệ thống gặp vấn đề. Vui lòng thử lại sau" });
            }
            else if (result.length == 0) {
                res.status(400).json({ message: "Người dùng không tồn tại. Vui lòng kiểm tra" });
            }
            else {
                if (result[0].user_type != "Seller") {
                    res.status(403).json({ message: "Người dùng không có quyền truy cập trang hay tác vụ này!" });
                }
                else {
                    next();
                }
            }
        })
    }
    else {
        res.status(401).json({ message: "Người dùng không xác định. Vui lòng kiểm tra" });
    }
}

async function authorizeShipper(req, res, next) {
    if (req.cur_member) {
        let sql = "SELECT * FROM users WHERE user_id = ? AND user_type = ? AND email = ?";
        connect_DB.query(sql, [
            req.cur_member.user_id,
            req.cur_member.user_type,
            req.cur_member.email
        ], function (err, result, field) {
            if (err) {
                res.status(500).json({ message: "Hệ thống gặp vấn đề. Vui lòng thử lại sau" });
            }
            else if (result.length == 0) {
                res.status(400).json({ message: "Người dùng không tồn tại. Vui lòng kiểm tra" });
            }
            else {
                if (result[0].user_type != "Shipper") {
                    res.status(403).json({ message: "Người dùng không có quyền truy cập trang hay tác vụ này!" });
                }
                else {
                    next();
                }
            }
        })
    }
    else {
        res.status(401).json({ message: "Người dùng không xác định. Vui lòng kiểm tra" });
    }
}

async function authorizeAdmin(req, res, next) {
    if (req.cur_member) {
        let sql = "SELECT * FROM users WHERE user_id = ? AND user_type = ? AND email = ?";
        connect_DB.query(sql, [
            req.cur_member.user_id,
            req.cur_member.user_type,
            req.cur_member.email
        ], function (err, result, field) {
            if (err) {
                res.status(500).json({ message: "Hệ thống gặp vấn đề. Vui lòng thử lại sau" });
            }
            else if (result.length == 0) {
                res.status(400).json({ message: "Người dùng không tồn tại. Vui lòng kiểm tra" });
            }
            else {
                if (result[0].user_type != "Admin") {
                    res.status(403).json({ message: "Người dùng không có quyền truy cập trang hay tác vụ này!" });
                }
                else {
                    next();
                }
            }
        })
    }
    else {
        res.status(401).json({ message: "Người dùng không xác định. Vui lòng kiểm tra" });
    }
}

module.exports = {
    loadCurMember,
    authorizeCustomer,
    authorizeSeller,
    authorizeShipper,
    authorizeAdmin
}