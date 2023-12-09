import { Row, Col, CardGroup } from "react-bootstrap";
import { useParams } from "react-router-dom";
import SearchBar from "./SearchBar";
import Product from "./Product";

const products = [
  {
    product_id: "1",
    name: "Amazon Echo Dot 3rd Generation",
    image: "https://m.media-amazon.com/images/I/41BsHIgteaL.jpg",
    rating: 4.5,
    rate_nums: 20,
    price: 29.99,
  },
  {
    product_id: "2",
    name: "Apple Watch Series 3",
    image:
      "https://m.media-amazon.com/images/I/71LfnkRgZ4L._AC_UY436_FMwebp_QL65_.jpg",
    rating: 4.0,
    rate_nums: 15,
    price: 199.99,
  },
  {
    product_id: "3",
    name: "Samsung Galaxy S20",
    image:
      "https://m.media-amazon.com/images/I/81lGGiahJTS._AC_UY436_FMwebp_QL65_.jpg",
    rating: 4.5,
    rate_nums: 25,
    price: 899.99,
  },
  {
    product_id: "4",
    name: "Google Pixel 4A",
    image:
      "https://m.media-amazon.com/images/I/81lGGiahJTS._AC_UY436_FMwebp_QL65_.jpg",
    rating: 4.5,
    rate_nums: 30,
    price: 349.99,
  },
  {
    product_id: "5",
    name: "Bose QuietComfort 35 II",
    image:
      "https://m.media-amazon.com/images/I/81lGGiahJTS._AC_UY436_FMwebp_QL65_.jpg",
    rating: 4.5,
    rate_nums: 40,
    price: 299.99,
  },
  {
    product_id: "11",
    name: "Nintendo Switch",
    image:
      "https://m.media-amazon.com/images/I/81lGGiahJTS._AC_UY436_FMwebp_QL65_.jpg",
    rating: 4.5,
    rate_nums: 50,
    price: 299.99,
  },
  {
    product_id: "12",
    name: "Dell XPS 13",
    image:
      "https://m.media-amazon.com/images/I/81lGGiahJTS._AC_UY436_FMwebp_QL65_.jpg",
    rating: 4.5,
    rate_nums: 60,
    price: 999.99,
  },
  {
    product_id: "13",
    name: "Sony WH-1000XM4",
    image:
      "https://m.media-amazon.com/images/I/81lGGiahJTS._AC_UY436_FMwebp_QL65_.jpg",
    rating: 4.5,
    rate_nums: 70,
    price: 349.99,
  },
  {
    product_id: "14",
    name: "Apple iPad Pro",
    image:
      "https://m.media-amazon.com/images/I/81lGGiahJTS._AC_UY436_FMwebp_QL65_.jpg",
    rating: 4.5,
    rate_nums: 80,
    price: 799.99,
  },
  {
    product_id: "15",
    name: "GoPro HERO9 Black",
    image:
      "https://m.media-amazon.com/images/I/81lGGiahJTS._AC_UY436_FMwebp_QL65_.jpg",
    rating: 4.5,
    rate_nums: 90,
    price: 399.99,
  },
];

const ShopPage = () => {
  const { keyword } = useParams();

  return (
    <div className="m-5">
      <SearchBar />
      <CardGroup>
        <Row>
          {products.map((product) => (
            <Col key={product.product_id} sm={12} md={6} lg={4} xl={3}>
              <Product product={product} />
            </Col>
          ))}
        </Row>
      </CardGroup>
    </div>
  );
};

export default ShopPage;
