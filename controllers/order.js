const order_model = require("../model/DAO/order");

const getOrdersByCustomerID = async (req, res) => {
  try {
    const orders = await order_model.getOrdersByCustomerID(
      req.params.id,
      req.query.sortOrder
    );
    res.json(orders);
  } catch (err) {
    res
      .status(500)
      .json({ error: "An error occurred while retrieving the orders" });
  }
};

const getOrdersByOrderID = async (req, res) => {
  try {
    const order = await order_model.getOrdersByOrderID(
      req.params.id
    );
    res.json(order);
  } catch (err) {
    res
      .status(500)
      .json({ error: "An error occurred while retrieving the bill details" });
  }
};

const createNewOrder = async (req, res) => {
  try {
    const customerId = req.body.customerId;
    const products = req.body.products;
    await order_model.createNewOrder(customerId, products);
    res.json({ message: 'Order created successfully' });
  } catch (err) {
    res.status(500).json({ error: 'An error occurred while creating the order' });
  }
};

module.exports = {
  getOrdersByCustomerID,
  getOrdersByOrderID,
  createNewOrder
};
