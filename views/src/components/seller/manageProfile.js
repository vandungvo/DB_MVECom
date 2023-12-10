import React from 'react';
import { useState, useEffect } from 'react';
import { MDBCol, MDBContainer, MDBRow, MDBCard, MDBCardText, MDBCardBody, MDBCardImage, MDBTypography, MDBIcon } from 'mdb-react-ui-kit';
import axios from 'axios';
import Cookies from 'universal-cookie';

const cookies = new Cookies();

function ManageProfile() {
    const shop_id = cookies.get("USER_ID") || null;
    const [first_name, setFirstName] = useState(null);
    const [last_name, setLastName] = useState(null);
    const [email, setEmail] = useState(null);
    const [user_type, setUserType] = useState(null);

    useEffect(() => {
        axios.post('/api/shop/getUser', {
            shop_id
        }).then(response => {
            setFirstName(response.data[0].first_name)
            setLastName(response.data[0].last_name)
            setEmail(response.data[0].email)
            setUserType(response.data[0].user_type)
        }).catch(error => {
            console.error(error);
        })
    }, []);

    return (
        <section className="vh-100" style={{ backgroundColor: '#f4f5f7' }}>
        <MDBContainer className="py-5 h-100">
            <MDBRow className="justify-content-center align-items-center h-100">
            <MDBCol lg="6" className="mb-4 mb-lg-0">
                <MDBCard className="mb-3" style={{ borderRadius: '.5rem' }}>
                <MDBRow className="g-0">
                    <MDBCol md="4" className="gradient-custom text-center text-white"
                    style={{ borderTopLeftRadius: '.5rem', borderBottomLeftRadius: '.5rem' }}>
                    <MDBCardImage src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                        alt="Avatar" className="my-3" style={{ width: '80px' }} fluid />
                    <MDBTypography tag="h5">Marie Horwitz</MDBTypography>
                    <MDBCardText className='text-muted' tag="h6">{user_type}</MDBCardText>
                    </MDBCol>
                    <MDBCol md="8">
                    <MDBCardBody className="p-4">
                        <MDBTypography tag="h6">Administrator</MDBTypography>
                        <hr className="mt-0 mb-4" />
                        <MDBRow className="pt-1">
                        <MDBCol size="6" className="mb-3">
                            <MDBTypography tag="h6">First name</MDBTypography>
                            <MDBCardText className="text-muted">{first_name}</MDBCardText>
                        </MDBCol>
                        <MDBCol size="6" className="mb-3">
                            <MDBTypography tag="h6">Last name</MDBTypography>
                            <MDBCardText className="text-muted">{last_name}</MDBCardText>
                        </MDBCol>
                        </MDBRow>

                        <MDBTypography tag="h6">Information</MDBTypography>
                        <hr className="mt-0 mb-4" />
                        <MDBRow className="pt-1">
                        <MDBCol size="9" className="mb-3">
                            <MDBTypography tag="h6">Email</MDBTypography>
                            <MDBCardText className="text-muted">{email}</MDBCardText>
                        </MDBCol>
                        </MDBRow>

                        <div className="d-flex justify-content-start">
                        <a href="#!"><MDBIcon fab icon="facebook me-3" size="lg" /></a>
                        <a href="#!"><MDBIcon fab icon="twitter me-3" size="lg" /></a>
                        <a href="#!"><MDBIcon fab icon="instagram me-3" size="lg" /></a>
                        </div>
                    </MDBCardBody>
                    </MDBCol>
                </MDBRow>
                </MDBCard>
            </MDBCol>
            </MDBRow>
        </MDBContainer>
        </section>
    );
}

export default ManageProfile;