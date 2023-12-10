import { useEffect, useState } from "react";
import {
  Table,
  ListGroup,
  Button,
  Row,
  Col,
  Spinner,
  Dropdown,
} from "react-bootstrap";
import { useDispatch, useSelector } from "react-redux";
import { Link } from "react-router-dom";
import axios from "axios";
import Cookies from 'universal-cookie';

const userInfo = {
  first_name: "Thang",
  last_name: "Pham",
  user_type: "customer",
  email: "thang.phamduc258@gmail.com",
};

const cookies = new Cookies();
const user_id = cookies.get("USER_ID") || null;

const ProfilePage = () => {
  /* const { userInfo } = useSelector((state) => state.auth);
  const { id } = userInfo; */

  const [orders, setOrders] = useState([]);
  const [sortOrder, setSortOrder] = useState("");
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const fetchOrders = async () => {
      setIsLoading(true);
      const response = await axios.get(
        `http://localhost:8080/api/orders/${user_id}?sortOrder=${sortOrder}`
      );
      setOrders(response.data);
      setIsLoading(false);
    };

    fetchOrders();
  }, [sortOrder]);

  return (
    <Row className="m-3">
      <Col md={3}>
        <h2>User Profile</h2>

        <ListGroup>
          <ListGroup.Item>
            <h3>First Name</h3>
            <p>{userInfo.first_name}</p>
          </ListGroup.Item>

          <ListGroup.Item>
            <h3>Last Name</h3>
            <p>{userInfo.last_name}</p>
          </ListGroup.Item>

          <ListGroup.Item>
            <h3>Email Address</h3>
            <p>{userInfo.email}</p>
          </ListGroup.Item>
        </ListGroup>
      </Col>
      <Col md={9}>
        <h2>My Orders</h2>
        {isLoading ? (
          <Spinner />
        ) : (
          <>
            <Dropdown>
              <Dropdown.Toggle variant="success" id="dropdown-basic">
                Sort By Time
              </Dropdown.Toggle>
              <Dropdown.Menu>
                <Dropdown.Item onClick={() => setSortOrder("asc")}>
                  Ascending
                </Dropdown.Item>
                <Dropdown.Item onClick={() => setSortOrder("desc")}>
                  Descending
                </Dropdown.Item>
              </Dropdown.Menu>
            </Dropdown>
            <Table striped hover responsive className="table-sm">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>DATE</th>
                  <th>TOTAL</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                {orders.map((order) => (
                  <tr key={order.order_id}>
                    <td>{order.order_id}</td>
                    <td>{order.order_date}</td>
                    <td>{order.total_price}</td>
                    <td>
                      <Link to={`/order/${order.order_id}`}>
                        <Button className="btn-sm" variant="light">
                          Details
                        </Button>
                      </Link>
                    </td>
                  </tr>
                ))}
              </tbody>
            </Table>
          </>
        )}
      </Col>
    </Row>
  );
};

export default ProfilePage;
