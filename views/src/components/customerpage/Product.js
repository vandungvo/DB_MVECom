import { Card } from "react-bootstrap";
import { Link } from "react-router-dom";
import Rating from "./Rating";

const Product = ({ product }) => {
  return (
    <Card className="my-3 p-3 rounded d-flex flex-column justify-content-between h-100">
      <Link to={`/product/${product.product_id}`} className="flex-grow-1 d-flex align-items-center justify-content-center">
        <Card.Img src={product.image} variant="top" className="img-fluid" style={{height: '200px', objectFit: 'cover'}} />
      </Link>

      <Card.Body className="flex-grow-1">
        <Card.Text as="h6" className="d-flex justify-content-between">
          {product.ctg_name}
        </Card.Text>
        <Link to={`/product/${product.product_id}`}>
          <Card.Title as="div" className="product-title">
            <strong>{product.product_name}</strong>
          </Card.Title>
        </Link>
        <Card.Text as="div" className="d-flex justify-content-between">
          {product.shop_name}
          <Rating
            value={product.rating}
            text={`${product.rate_nums} reviews`}
          />
        </Card.Text>
        <Card.Text as="h5"></Card.Text>
        <Card.Text as="h3">${product.price}</Card.Text>
      </Card.Body>
    </Card>
  );
};

export default Product;
