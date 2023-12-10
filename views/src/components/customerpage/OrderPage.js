import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { Table, Container } from "react-bootstrap";
import axios from "axios";

const OrderPage = () => {
  const { id: orderId } = useParams();
  const [order, setOrder] = useState(null);

  useEffect(() => {
    const fetchOrder = async () => {
      const response = await axios.get(
        `http://localhost:8080/api/orders/order/${orderId}`
      );
      setOrder(response.data);
    };

    fetchOrder();
  }, [orderId]);

  return (
    <Container>
      <h1>Order Details</h1>
      {order ? (
        <Table striped bordered hover>
          <thead>
            <tr>
              <th>Image</th>
              <th>Shop Name</th>
              <th>Product Name</th>
              <th>Quantity</th>
              <th>Price</th>
            </tr>
          </thead>
          <tbody>
            {order.map((product, index) => (
              <tr key={index}>
                <td style={{ width: "150px" }}>
                  <img
                    src={product.image}
                    alt=""
                    style={{ width: "150px" }}
                  />
                </td>
                <td>{product.shop_name}</td>
                <td>{product.product_name}</td>
                <td>{product.quantity}</td>
                <td>${product.price}</td>
              </tr>
            ))}
          </tbody>
        </Table>
      ) : (
        <p>Loading...</p>
      )}
    </Container>
  );
};

export default OrderPage;
