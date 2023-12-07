import ReactDOM from "react-dom/client";
import { BrowserRouter, Routes, Route, Link, NavLink, Outlet, useNavigate } from "react-router-dom";
import Popper from 'popper.js';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min';
import logo from '../../img/SIMSBCLogo.png'
import { createContext, useEffect, useState } from "react";
import Cookies from "universal-cookie";
import axios from 'axios';

const UserContext = createContext();

export default function Navbar() {
    const navigate = useNavigate();
    const [signin, setSignIn] = useState(false);
    const cookies = new Cookies();
    const [user_type, setUserType] = useState(null);
    useEffect(() => {
        const token = cookies.get("TOKEN");
        if (!token) {
            setSignIn(false);
            setUserType(null);
        }
        else {
            axios.post("/api/authorization/customer", {}, {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            }).then((response) => {
                setSignIn(true);
                setUserType("Customer");
            }).catch((error) => { });

            axios.post("/api/authorization/seller", {}, {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            }).then((response) => {
                setSignIn(true);
                setUserType("Seller");
            }).catch((error) => { });

            axios.post("/api/authorization/shipper", {}, {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            }).then((response) => {
                setSignIn(true);
                setUserType("Shipper");
            }).catch((error) => { });

            axios.post("/api/authorization/admin", {}, {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            }).then((response) => {
                setSignIn(true);
                setUserType("Admin");
            }).catch((error) => { });
        }
    }, []);

    const handleSignOut = (e) => {
        cookies.remove('TOKEN', {
            path: "/",
        });
        setSignIn(false);
        setUserType(null);
        navigate("signin");
    }

    let navItem = null, renderSignOut = null, renderSignIn = null;

    if (!signin) {
        navItem = (
            <>
                <li className="nav-item">
                    <Link className="nav-link" aria-current="page" to="/" style={{color: "white", fontWeight: "600"}}>
                        Home
                    </Link>
                </li>
                <li className="nav-item">
                    <Link className="nav-link" to="/signup" style={{color: "white", fontWeight: "600"}}>
                        Đăng ký
                    </Link>
                </li>
            </>
        )
        renderSignIn = (
            <Link className="nav-link" to="/signin">
                Đăng nhập
            </Link>
        );
    }
    else {
        if (user_type === "Customer") {
            navItem = (
                <>
                    <li className="nav-item">
                        <Link className="nav-link" aria-current="page" to="/">
                            Home
                        </Link>
                    </li>
                </>
            );
        }
        else if (user_type === "Seller") {
            navItem = (
                <>
                    <li className="nav-item">
                        <Link className="nav-link" aria-current="page" to="/">
                            Home
                        </Link>
                    </li>
                    <li className="nav-item">
                        <Link className="nav-link" to="/manageProduct">
                            Manage Product
                        </Link>
                    </li>
                    <li className="nav-item">
                        <Link className="nav-link" to="/manageOrder">
                            Orders
                        </Link>
                    </li>
                </>
            );
        }
        else {
            navItem = (
                <>
                    <li className="nav-item">
                        <Link className="nav-link" aria-current="page" to="/" >
                            Home
                        </Link>
                    </li>
                    <li className="nav-item">
                        <Link className="nav-link" to="/wip">
                            Đang phát triển (WIP)...
                        </Link>
                    </li>
                </>
            );
        }
        renderSignOut = (
            <button type="submit" className="btn btn-primary" onClick={handleSignOut}>
                Đăng xuất
            </button>
        );
    }

    return (
        <nav className="navbar navbar-expand-lg border-bottom border-body">
            <div className="container-fluid" style={{ marginLeft: '50px', marginRight: '50px' }}>
                <img src="https://e-learning.hcmut.edu.vn/pluginfile.php/1/core_admin/logocompact/300x300/1685588876/logoBK.png"
                    alt="HCMUT Logo" width="50" height="50"/>
                <Link className="navbar-brand" to="/">
                    HCMUT_Ecommerce
                </Link>
                <button
                    className="navbar-toggler"
                    type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
                >
                    <span className="navbar-toggler-icon" />
                </button>
                <div className="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul className="navbar-nav me-auto mb-2 mb-lg-0">
                        {navItem}
                    </ul>
                    {renderSignIn}
                    {renderSignOut}
                </div>
            </div>
        </nav>
    )

}