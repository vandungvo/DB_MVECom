import { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { Link } from "react-router-dom";
import {
  Row,
  Col,
  Image,
  ListGroup,
  Card,
  Button,
  Form,
  Spinner,
} from "react-bootstrap";
import Rating from "./Rating";
import { addToCart } from "../../slices/cartSlice";
import { useDispatch } from "react-redux";
import axios from "axios";

const ProductPage = () => {
  const { id: productId } = useParams();

  const dispatch = useDispatch();
  const navigate = useNavigate();

  const [product, setProduct] = useState({});
  const [qty, setQty] = useState(1);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchProduct = async () => {
      setLoading(true);
      const response = await axios.get(`/api/products/${productId}`);
      setProduct(response.data[0]);
      setLoading(false);
      console.log(response.data);
    };

    fetchProduct();
  }, [productId]);

  const addToCartHandler = () => {
    dispatch(addToCart({ ...product, qty }));
    navigate("/cart");
  };

  if (loading) {
    return <Spinner />;
  }

  return (
    <>
      <Link className="btn btn-light mx-5 my-3" to="/shop">
        Go Back
      </Link>
      <>
        <Row className="mx-5">
          <Col md={5}>
            <Image src={product.image} alt={product.product_name} fluid />
          </Col>
          <Col md={4}>
            <ListGroup variant="flush">
              <ListGroup.Item>
                <h3>{product.product_name}</h3>
              </ListGroup.Item>
              <ListGroup.Item>
                <div className="d-flex justify-content-between">
                  <h6>{product.shop_name}</h6>
                  <h6>{product.ctg_name}</h6>
                </div>
              </ListGroup.Item>
              <ListGroup.Item>
                <Rating
                  value={product.rating}
                  text={`${product.rate_nums} reviews`}
                />
              </ListGroup.Item>
              <ListGroup.Item>Price: ${product.price}</ListGroup.Item>
              <ListGroup.Item>
                Description: {product.product_description}
              </ListGroup.Item>
            </ListGroup>
          </Col>
          <Col md={3}>
            <Card>
              <ListGroup variant="flush">
                <ListGroup.Item>
                  <Row>
                    <Col>Price:</Col>
                    <Col>
                      <strong>${product.price}</strong>
                    </Col>
                  </Row>
                </ListGroup.Item>
                <ListGroup.Item>
                  <Row>
                    <Col>Status:</Col>
                    <Col>{product.stock > 0 ? "In Stock" : "Out Of Stock"}</Col>
                  </Row>
                </ListGroup.Item>

                {product.stock > 0 && (
                  <ListGroup.Item>
                    <Row>
                      <Col>Qty</Col>
                      <Col>
                        <Button
                          variant="outline-primary"
                          onClick={() => setQty(qty > 1 ? qty - 1 : 1)}
                        >
                          -
                        </Button>
                        <span className="mx-2">{qty}</span>
                        <Button
                          variant="outline-primary"
                          onClick={() =>
                            setQty(
                              qty < product.stock ? qty + 1 : product.stock
                            )
                          }
                        >
                          +
                        </Button>
                      </Col>
                    </Row>
                  </ListGroup.Item>
                )}

                <ListGroup.Item>
                  <Button
                    className="btn-block"
                    type="button"
                    disabled={product.stock === 0}
                    onClick={addToCartHandler}
                  >
                    Add To Cart
                  </Button>
                </ListGroup.Item>
              </ListGroup>
            </Card>
          </Col>
        </Row>
      </>
    </>
  );
};

export default ProductPage;
