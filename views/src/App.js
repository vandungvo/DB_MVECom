import "./App.css";
import ReactDOM from "react-dom/client";
import { BrowserRouter, Routes, Route, Link, NavLink, Outlet } from "react-router-dom";
import $ from 'jquery';
import Popper from 'popper.js';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min';
import Header from './components/shared/header'
import Homepage from './components/homepage/homepage';
import NoPage from './components/nopage/nopage';
import SignIn from './components/signin/signin'
import axios from 'axios'
import PrivateRoutes from './components/shared/private_routes';
import ProtectedTest from './components/(test_only)protected_test/protected_test';
import PublicTest from './components/(test_only)public_test/public_test';
import SignUp from './components/signup/signup';
import ManageProduct from './components/seller/manageProduct';
import ManageProfile from './components/seller/manageProfile';
import ManageOrder  from "./components/seller/manageOrder";
import ShopPage from './components/customerpage/ShopPage';
import ProductPage from './components/customerpage/ProductPage';
import CartPage from './components/customerpage/CartPage';
import ProfilePage from './components/customerpage/ProfilePage';
import OrderPage from './components/customerpage/OrderPage';

function App() {
  return (
    <Routes>
      <Route path="/" element={<Header />}>
        <Route index element={<Homepage />} />
        <Route path="signin" element={<SignIn />} />
        <Route path="signup" element={<SignUp />} />
        <Route path="publicTest" element={<PublicTest />} />
        <Route element={<PrivateRoutes validateRoute={"protectedTest"} />}>
          <Route path="protectedTest" element={<ProtectedTest />} />
        </Route>
        <Route path='manageProduct' element={<ManageProduct/>} />
        <Route path='manageProfile' element={<ManageProfile />} />
        <Route path='manageOrder' element={<ManageOrder />} />
        <Route path='shop' element={<ShopPage />} />
        <Route path='shop/:keyword' element={<ShopPage />} />
        <Route path='product/:id' element={<ProductPage />} />
        <Route path='cart' element={<CartPage />} />
        <Route path='profile' element={<ProfilePage />} />
        <Route path='order/:id' element={<OrderPage />} />
        
        <Route path="*" element={<NoPage />} />
      </Route>
    </Routes>
  );
}

export default App;
