const product_model = require('../model/DAO/product');

const getProducts = async (req, res) => {
  try {
    let { keyword, category, sort, page = 1, pageSize = 4 } = req.query;
    category = (category !== "") ? category + "\r" : "";
    const products = await product_model.getProducts(keyword, category, sort, page, pageSize);
    res.json(products);
  } catch (error) {
    console.error('Failed to get products:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
}

const getProductByID = async (req, res) => {
  try {
    const product = await product_model.getProductByID(req.params.id);
    if (!product) {
      return res.status(404).json({ error: 'Product not found' });
    }
    res.json(product);
  } catch (err) {
    res.status(500).json({ error: 'An error occurred while retrieving the product' });
  }
};

module.exports = {
  getProducts,
  getProductByID,
};
