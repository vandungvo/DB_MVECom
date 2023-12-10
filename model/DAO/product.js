var connect_DB = require("./connect_db");

const getProducts = async (keyword, category, sortOption, page, pageSize) => {
  const offset = (page - 1) * pageSize;
  try {
    const [rows] = await connect_DB
      .promise()
      .query("CALL GetProducts(?, ?, ?, ?, ?)", [
        keyword,
        category,
        sortOption,
        offset,
        pageSize,
      ]);

    return rows[0];
  } catch (error) {
    console.error("Failed to get products:", error);
    throw error;
  }
};

const getProductByID = async (productId) => {
  try {
    const [rows] = await connect_DB
      .promise()
      .query("CALL GetProductById(?)", [productId]);
    return rows[0];
  } catch (error) {
    console.error(`Failed to get product with ID ${productId}:`, error);
    throw error;
  }
};

module.exports = {
  getProducts,
  getProductByID,
};
