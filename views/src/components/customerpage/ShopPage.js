import { Row, Col, CardGroup, Dropdown, Pagination, Container, Alert, Spinner } from "react-bootstrap";
import { useParams } from "react-router-dom";
import SearchBar from "./SearchBar";
import Product from "./Product";
import axios from "axios";
import { useState, useEffect } from "react";


const ShopPage = () => {
  const [products, setProducts] = useState([]);
  const [category, setCategory] = useState("");
  const [sortOption, setSortOption] = useState("");
  const [keyword, setKeyword] = useState("");
  const [page, setPage] = useState(1);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        setLoading(true);
        const response = await axios.get(
          `http://localhost:8080/api/products?keyword=${keyword}&category=${category}&sort=${sortOption}&page=${page}`
        );
        setProducts(response.data);
        setLoading(false);
      } catch (error) {
        console.error("Failed to fetch products:", error);
      }
    };

    fetchProducts();
  }, [keyword, category, sortOption, page, setLoading]);

  useEffect(() => {
    setPage(1);
  }, [keyword, category, sortOption])

  if (loading) {
    return <Spinner />
  }

  return (
    <Container className="m-5">
      <Row>
        <Col className="d-flex gap-5">
          <Dropdown>
            <Dropdown.Toggle variant="primary" id="dropdown-basic">
              Category
            </Dropdown.Toggle>
            <Dropdown.Menu>
              <Dropdown.Item onClick={() => setCategory("")}>
                None
              </Dropdown.Item>
              <Dropdown.Item onClick={() => setCategory("Computers")}>
                Computers
              </Dropdown.Item>
              <Dropdown.Item onClick={() => setCategory("Smart Home")}>
                Smart Home
              </Dropdown.Item>
              <Dropdown.Item onClick={() => setCategory("Art and Crafts")}>
                Art and Crafts
              </Dropdown.Item>
              <Dropdown.Item onClick={() => setCategory("Automotive")}>
                Automotive
              </Dropdown.Item>
              <Dropdown.Item onClick={() => setCategory("Baby")}>
                Baby
              </Dropdown.Item>
              <Dropdown.Item
                onClick={() => setCategory("Beauty and Personal care")}
              >
                Beauty and Personal care
              </Dropdown.Item>
            </Dropdown.Menu>
          </Dropdown>
          <Dropdown>
            <Dropdown.Toggle variant="primary" id="sort">
              Sort By
            </Dropdown.Toggle>
            <Dropdown.Menu>
              <Dropdown.Item onClick={() => setSortOption("price_asc")}>
                Price Ascending
              </Dropdown.Item>
              <Dropdown.Item onClick={() => setSortOption("price_desc")}>
                Price Descending
              </Dropdown.Item>
              <Dropdown.Item onClick={() => setSortOption("sold_quantities_asc")}>
                Sales Ascending
              </Dropdown.Item>
              <Dropdown.Item onClick={() => setSortOption("sold_quantities_desc")}>
                Sales Descending
              </Dropdown.Item>
              <Dropdown.Item onClick={() => setSortOption("rating_asc")}>
                Rating Ascending
              </Dropdown.Item>
              <Dropdown.Item onClick={() => setSortOption("rating_desc")}>
                Rating Descending
              </Dropdown.Item>
            </Dropdown.Menu>
          </Dropdown>
        </Col>
        <Col>
          <SearchBar setKeyword={setKeyword} />
        </Col>
      </Row>
      <Row className="mb-5">
        <CardGroup>
            {products.map((product) => (
              <Col key={product.product_id} sm={12} md={6} lg={4} xl={3}>
                <Product product={product} />
              </Col>
            ))}
        </CardGroup>
      </Row>
      {products.length !== 0 ? <Row>
        <Pagination className="justify-content-center">
          <Pagination.Prev onClick={() => setPage(Math.max(page - 1, 1))} />
          <Pagination.Item>{page}</Pagination.Item>
          <Pagination.Next onClick={() => setPage(page + 1)} />
        </Pagination>
      </Row> : <Alert variant="danger">No products found!</Alert>}
    </Container>
  );
};

export default ShopPage;
