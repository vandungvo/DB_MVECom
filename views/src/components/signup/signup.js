import ReactDOM from "react-dom/client";
import { BrowserRouter, Routes, Route, Link, NavLink, Outlet, Navigate, useNavigate } from "react-router-dom";
import $ from 'jquery';
import Popper from 'popper.js';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min';
import axios from 'axios'
import { useState, useEffect } from "react";
import Header from '../shared/header';
import Cookies from "universal-cookie";
const cookies = new Cookies();

function SignUp() {
    const [user_id, setUserID] = useState("");
    const [user_name, setUserName] = useState("");
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [errorMessage, setErrorMessage] = useState(null);
    const navigate = useNavigate();
    // const [login, setLogin] = useState(false);
    const handleSubmit = (e) => {
        e.preventDefault();
        axios.post("/api/register", {
            user_id,
            user_name,
            email,
            password
        })
            .then((response) => {
                cookies.set("TOKEN", response.data.token, {
                    path: "/",
                });
                navigate("/publicTest");
            })
            .catch((error) => {
                if (error.response) {
                    setErrorMessage(error.response.data.message);
                }
            })
    }
    return (
        <form>
            <div className="mb-3">
                <label htmlFor="exampleInputId1" className="form-label">
                    Mã số người dùng (dùng mssv nếu đăng ký tài khoản SV)
                </label>
                <input
                    type="text"
                    className="form-control"
                    id="exampleInputId1"
                    aria-describedby="idHelp"
                    value={user_id}
                    onChange={(e) => setUserID(e.target.value)}
                />
            </div>
            <div className="mb-3">
                <label htmlFor="exampleInputName1" className="form-label">
                    Tên
                </label>
                <input
                    type="text"
                    className="form-control"
                    id="exampleInputName1"
                    aria-describedby="nameHelp"
                    value={user_name}
                    onChange={(e) => setUserName(e.target.value)}
                />
            </div>
            <div className="mb-3">
                <label htmlFor="exampleInputEmail1" className="form-label">
                    Email
                </label>
                <input
                    type="email"
                    className="form-control"
                    id="exampleInputEmail1"
                    aria-describedby="emailHelp"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                />
            </div>
            <div className="mb-3">
                <label htmlFor="exampleInputPassword1" className="form-label">
                    Mật khẩu
                </label>
                <input
                    type="password"
                    className="form-control"
                    id="exampleInputPassword1"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                />
            </div>
            <button type="submit" className="btn btn-primary" onClick={(e) => handleSubmit(e)}>
                Đăng ký
            </button>
            <p>{errorMessage ? errorMessage : ""}</p>
        </form>
    )

}
export default SignUp;