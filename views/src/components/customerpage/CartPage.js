import { Link, useNavigate } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";
import {
  Row,
  Col,
  ListGroup,
  Image,
  Button,
  Card,
} from "react-bootstrap";
import { FaTrash } from "react-icons/fa";
import { addToCart, removeFromCart, clearCartItems } from "../../slices/cartSlice";
import Alert from "react-bootstrap/Alert";
import axios from "axios";
import Cookies from 'universal-cookie';


const cookies = new Cookies();
const user_id = cookies.get("USER_ID") || null;

const CartPage = () => {
  const navigate = useNavigate();
  const dispatch = useDispatch();

  const cart = useSelector((state) => state.cart);
  const { cartItems } = cart;

  const addToCartHandler = async (product, qty) => {
    dispatch(addToCart({ ...product, qty }));
  };

  const removeFromCartHandler = (id) => {
    dispatch(removeFromCart(id));
  };

  const checkoutHandler = async (customerId, products) => {
    try {
      const response = await axios.post('http://localhost:8080/api/orders', {
        customerId: user_id,
        products: cartItems
      });
      dispatch(clearCartItems());
      navigate("/profile");
    } catch (error) {
      console.error('An error occurred while checking out:', error);
    }
  };

  return (
    <Row className="mx-5 mt-3">
      <Col md={8}>
        <h1 style={{ marginBottom: "20px" }}>Shopping Cart</h1>
        {cartItems.length === 0 ? (
          <Alert>
            Your cart is empty <Link to="/shop">Go Back</Link>
          </Alert>
        ) : (
          <ListGroup variant="flush" className="d-flex gap-3" >
            {cartItems.map((item) => (
              <ListGroup.Item key={item.product_id} style={{ height: '150px', overflow: 'hidden' }}>
                <Row>
                  <Col md={2}>
                    <Image
                      src={item.image}
                      alt={item.product_name}
                      fluid
                      rounded
                    />
                  </Col>
                  <Col md={3}>
                    <Link to={`/product/${item.product_id}`}>
                      {item.product_name}
                    </Link>
                  </Col>
                  <Col md={2}>${item.price}</Col>
                  <Col md={2}>
                    <Button
                      variant="outline-primary"
                      onClick={() =>
                        addToCartHandler(item, item.qty > 1 ? item.qty - 1 : 1)
                      }
                    >
                      -
                    </Button>
                    <span className="mx-2">{item.qty}</span>
                    <Button
                      variant="outline-primary"
                      onClick={() =>
                        addToCartHandler(
                          item,
                          item.qty < item.stock ? item.qty + 1 : item.stock
                        )
                      }
                    >
                      +
                    </Button>
                  </Col>
                  <Col md={2}>
                    <Button
                      type="button"
                      variant="light"
                      onClick={() => removeFromCartHandler(item.product_id)}
                    >
                      <FaTrash />
                    </Button>
                  </Col>
                </Row>
              </ListGroup.Item>
            ))}
          </ListGroup>
        )}
      </Col>
      <Col md={4}>
        <Card>
          <ListGroup variant="flush">
            <ListGroup.Item>
              <h2>
                Total ({cartItems.reduce((acc, item) => acc + item.qty, 0)})
                items
              </h2>
              $
              {cartItems
                .reduce((acc, item) => acc + item.qty * item.price, 0)
                .toFixed(2)}
            </ListGroup.Item>
            <ListGroup.Item>
              <Button
                type="button"
                className="btn-block"
                disabled={cartItems.length === 0}
                onClick={checkoutHandler}
              >
                Checkout
              </Button>
            </ListGroup.Item>
          </ListGroup>
        </Card>
      </Col>
    </Row>
  );
};

export default CartPage;
