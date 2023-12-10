import {useState} from 'react';
import { Form, Button } from 'react-bootstrap';

const SearchBar = ({ setKeyword }) => {
  const [input, setInput] = useState('');

  const submitHandler = (e) => {
    e.preventDefault();
    setKeyword(input);
  };

  return (
    <Form onSubmit={submitHandler} className='d-flex'>
      <Form.Control
        type='text'
        name='q'
        onChange={(e) => setInput(e.target.value)}
        value={input}
        placeholder='Search Products...'
        className='mr-sm-2 ml-sm-5'
      ></Form.Control>
      <Button type='submit' variant='outline-success' className='p-2 mx-2'>
        Search
      </Button>
    </Form>
  );
};

export default SearchBar;
