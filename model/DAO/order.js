var connect_DB = require("./connect_db");

const getOrdersByCustomerID = async (customerId, sortOrder) => {
  try {
    const [rows] = await connect_DB
      .promise()
      .query("CALL GetOrdersByCustomerID(?, ?)", [customerId, sortOrder]);

    return rows[0];
  } catch (error) {
    console.error("Failed to get orders:", error);
    throw error;
  }
};

const getOrdersByOrderID = async (orderId) => {
  try {
    const [rows] = await connect_DB.promise().query(
      'CALL GetBillDetailsByOrderId(?)',
      [orderId]
    );
    
    return rows[0];
  } catch (error) {
    console.error('Failed to get bill details:', error);
    throw error;
  }
}

const createNewOrder = async (customerId, products) => {
  try {
    console.log(customerId, products);
    await connect_DB.promise().query(
      'CALL CreateNewOrder(?, ?)',
      [customerId, JSON.stringify(products)]
    );
  } catch (error) {
    console.error('Failed to create order:', error);
    throw error;
  }
};

module.exports = {
  getOrdersByCustomerID,
  getOrdersByOrderID,
  createNewOrder
};
