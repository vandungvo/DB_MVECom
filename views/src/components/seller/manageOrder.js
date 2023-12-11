import React from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min';
import axios from 'axios'
import { useState, useEffect } from "react";
import Cookies from "universal-cookie";
import './manageProduct.css';

const cookies = new Cookies();
const shop_id = cookies.get("USER_ID");
console.log(shop_id);
function ManageOrder() {
    // view all orders in shop
    const [orders, setOrders] = useState([]);

    useEffect(() => {
        axios.post('/api/shop/getOrder', { shop_id })
        .then(response => setOrders(response.data) )
        .catch(error => console.error('Error fetching orders:', error));
    }, []);

    return (
        <div className='m-5'>
            <h1 className='text-center m-4' style={{color: "black"}}>Order list</h1>
            <table className='table table-striped'>
                <thead>
                    <tr>
                        <th className='text-center'>Name</th>
                        <th className='text-center'>Quantity</th>
                        <th className='text-center'>Price per product</th>
                        <th className='text-center'>Total price</th>
                        <th className='text-center'>Status</th>
                    </tr>
                </thead>
                <tbody>
                    {orders.map(order => (
                        <tr key={order.product_id}>
                            <td className='text-center'>{order.product_name}</td>
                            <td className='text-center'>{order.quantity}</td>
                            <td className='text-center'>{order.price}</td>
                            <td className='text-center'>{order.total_price}</td>
                            <td className='text-center'>{order.bill_status}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export default ManageOrder;