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
function ManageProduct() {
    // view all products in shop
    const [reFresh, setReFresh] = useState(null);
    const [products, setProducts] = useState([]);

    useEffect(() => {
        axios.post('/api/shop/viewProduct', { shop_id })
        .then(response => setProducts(response.data) )
        .catch(error => console.error('Error fetching products:', error));
    }, [reFresh]);

    // insert and update a product
    const [product_id, setProductId] = useState('');
    const [ctg_id, setCtgId] = useState('');
    const [categories, setCategories] = useState([]);
    const [name, setName] = useState('');
    const [SKU, setSKU] = useState('');
    const [price, setPrice] = useState('');
    const [stock, setStock] = useState('');
    const [description, setDescription] = useState('');
    const [image, setImage] = useState('');
    const [error, setError] = useState(null);
    
    // insert
    const [addPopup, setAddPopup] = useState(false);
    const handleAddButtonClick = () => {
        axios.post('/api/shop/getCategories')
        .then( response => setCategories(response.data) )
        .catch( err => setError(err.response.data.message) );
        setAddPopup(true);
    }
    const handleAddPopupClose = () => { setAddPopup(false); setError(null) }
    const handleInsertProductSubmit = (e) => {
        e.preventDefault();
        axios.post('/api/shop/insertProduct', { shop_id, ctg_id, name, SKU, price, stock, description, image })
        .then((response) => { setReFresh(prev => prev + 1); setError(null); })
        .catch( err => setError(err.response.data.message) );
    };

    // update
    const [updatePopup, setUpdatePopup] = useState(false);
    const handleUpdateButtonClick = (product_id) => { 
        axios.post('/api/shop/getCategories')
        .then( response => setCategories(response.data) )
        .catch( err => setError(err.response.data.message) );
        setProductId(product_id); 
        setUpdatePopup(true); 
    }
    const handleUpdatePopupClose = () => { setUpdatePopup(false); setError(null) }
    const handleUpdateProductSubmit = (e) => {
        e.preventDefault();
        axios.post('/api/shop/updateProduct', { product_id, ctg_id, name, SKU, price, stock, description, image })
        .then((response) => { setReFresh(prev => prev + 1); setError(null); })
        .catch( err => setError(err.response.data.message) );
    }

    // delete
    const handleDeleteProduct = (product_id) => {
        axios.post('/api/shop/deleteProduct', { product_id })
        .then( setReFresh(prev => prev + 1) )
        .catch( err => setError(err.response.data.message) );
    };

    return (
        <div className='m-5'>
            <h1 className='text-center m-4' style={{color: "black"}}>Product list</h1>
            <table className='table table-striped'>
                <thead>
                    <tr>
                        <th className='text-center'>Category</th>
                        <th className='text-center'>Name</th>
                        <th className='text-center'>Stock</th>
                        <th className='text-center'>Price</th>
                        <th className='text-center'>SKU</th>
                        <th className='text-center'>Sold quantities</th>
                        <th className='text-center'>Modify</th>
                        <th className='text-center'>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    {products.map(product => (
                        <tr key={product.product_id}>
                            <td className='text-center'>{product.ctg_name}</td>
                            <td className='text-center'>{product.product_name}</td>
                            <td className='text-center'>{product.stock}</td>
                            <td className='text-center'>{product.price}</td>
                            <td className='text-center'>{product.SKU}</td>
                            <td className='text-center'>{product.sold_quantities}</td>
                            <td className='text-center'>
                                <button className='modifyButton' onClick={() => handleUpdateButtonClick(product.product_id)}>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-in-down-left" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M9.636 2.5a.5.5 0 0 0-.5-.5H2.5A1.5 1.5 0 0 0 1 3.5v10A1.5 1.5 0 0 0 2.5 15h10a1.5 1.5 0 0 0 1.5-1.5V6.864a.5.5 0 0 0-1 0V13.5a.5.5 0 0 1-.5.5h-10a.5.5 0 0 1-.5-.5v-10a.5.5 0 0 1 .5-.5h6.636a.5.5 0 0 0 .5-.5"/>
                                        <path fill-rule="evenodd" d="M5 10.5a.5.5 0 0 0 .5.5h5a.5.5 0 0 0 0-1H6.707l8.147-8.146a.5.5 0 0 0-.708-.708L6 9.293V5.5a.5.5 0 0 0-1 0z"/>
                                    </svg>
                                </button>
                            </td>
                            <td className='text-center'>
                                <button className='modifyButton' onClick={() => handleDeleteProduct(product.product_id)}>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
                                        <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
                                    </svg>
                                </button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
            <button className='btn btn-primary' onClick={handleAddButtonClick}>Add</button>

            {addPopup && (
                <div className="popup-overlay">
                    <div className="popup">
                        <div>
                            <h2 className="mt-1">Add new product</h2>
                        </div>
                        <form>
                        <table>
                            <tbody>
                                <tr>
                                    <td>Category</td>
                                    <td>
                                        <select
                                            value={ctg_id}
                                            onChange={(e) => setCtgId(e.target.value)}
                                        >
                                            <option value="">Select a category</option>
                                            {categories.map((ctg) => (
                                                <option key={ctg.id} value={ctg.ctg_id}>
                                                    {ctg.ctg_name}
                                                </option>
                                            ))}
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Name</td>
                                    <td>
                                    <input
                                        type="text"
                                        value={name}
                                        onChange={e => setName(e.target.value)}
                                    />
                                    </td>
                                </tr>
                                <tr>
                                    <td>SKU</td>
                                    <td>
                                    <input
                                        type="text"
                                        value={SKU}
                                        onChange={e => setSKU(e.target.value)}
                                    />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Price</td>
                                    <td>
                                    <input
                                        type="text"
                                        value={price}
                                        onChange={e => setPrice(e.target.value)}
                                    />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Stock</td>
                                    <td>
                                    <input
                                        type="text"
                                        value={stock}
                                        onChange={e => setStock(e.target.value)}
                                    />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Description</td>
                                    <td>
                                    <input
                                        type="text"
                                        value={description}
                                        onChange={e => setDescription(e.target.value)}
                                    />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Image</td>
                                    <td>
                                    <input
                                        type="text"
                                        value={image}
                                        onChange={e => setImage(e.target.value)}
                                    />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        {error && (<p className="text-danger mt-3">{error}</p>)}
                        <button className="btn btn-danger mt-2 mx-5" onClick={handleAddPopupClose}>Huỷ</button>
                        <button className="btn btn-primary mt-2 mx-5" onClick={handleInsertProductSubmit}>Xác nhận</button>
                        </form>
                    </div>
                </div>
            )}

            {updatePopup && (
                <div className="popup-overlay">
                    <div className="popup">
                        <div>
                            <h2 className="mt-1">Update product</h2>
                        </div>
                        <form>
                        <table>
                            <tbody>
                                <tr>
                                    <td>Category</td>
                                    <td>
                                        <select
                                            value={ctg_id}
                                            onChange={(e) => setCtgId(e.target.value)}
                                        >
                                            <option value="">Select a category</option>
                                            {categories.map((ctg) => (
                                                <option key={ctg.id} value={ctg.ctg_id}>
                                                    {ctg.ctg_name}
                                                </option>
                                            ))}
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Name</td>
                                    <td>
                                    <input
                                        type="text"
                                        value={name}
                                        onChange={e => setName(e.target.value)}
                                    />
                                    </td>
                                </tr>
                                <tr>
                                    <td>SKU</td>
                                    <td>
                                    <input
                                        type="text"
                                        value={SKU}
                                        onChange={e => setSKU(e.target.value)}
                                    />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Price</td>
                                    <td>
                                    <input
                                        type="text"
                                        value={price}
                                        onChange={e => setPrice(e.target.value)}
                                    />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Stock</td>
                                    <td>
                                    <input
                                        type="text"
                                        value={stock}
                                        onChange={e => setStock(e.target.value)}
                                    />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Description</td>
                                    <td>
                                    <input
                                        type="text"
                                        value={description}
                                        onChange={e => setDescription(e.target.value)}
                                    />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Image</td>
                                    <td>
                                    <input
                                        type="text"
                                        value={image}
                                        onChange={e => setImage(e.target.value)}
                                    />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        {error && (<p className="text-danger mt-3">{error}</p>)}
                        <button className="btn btn-danger mt-2 mx-5" onClick={handleUpdatePopupClose}>Huỷ</button>
                        <button className="btn btn-primary mt-2 mx-5" onClick={handleUpdateProductSubmit}>Xác nhận</button>
                        </form>
                    </div>
                </div>
            )}
    
        </div>
    );
}

export default ManageProduct;