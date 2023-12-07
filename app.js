var express = require('express'); // framework for building web application
var url = require('url'); // module for parsing and formatting URLs
var fs = require('fs'); // module for interacting with the file system
var bodyParser = require('body-parser'); // parse incoming request bodies
var helmet = require('helmet'); // security module for HTTP headers
var rateLimit = require("express-rate-limit"); // limits the number of requests from a single IP address
var session = require('express-session'); // module for managing sessions
var cookieParser = require('cookie-parser'); // parse cookies from HTTP requests

const homepageRoute = require('./routes/homepage'); // handles requests for the homepage
const signinRoute = require('./routes/signin');
const protectedTestRoute = require("./routes/protected_test");
const registrationRoute = require("./routes/registration");
const publicTestRoute = require("./routes/public_test");
const viewProductRoute = require("./routes/view_product");

const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100 // limit each IP to 100 requests per windowMs
});

const cspConfig = {
    directives: {
      scriptSrc: ["'self'", "ajax.googleapis.com", "cdn.jsdelivr.net", "www.google.com"],
      frameSrc: ["'self'", "www.google.com"],
    },
  };



var app = express();
// app.set('view engine', 'ejs');
app.use(bodyParser.json()); // parse Json-formatted request bodies
app.use(bodyParser.urlencoded({ extended: true })); // parse URL-encoded request bodies
app.use(helmet.contentSecurityPolicy(cspConfig)); // set Content-Security-Policy headers
app.use(express.static('assets')); // serve static files from the assets directory
app.use(limiter); // apply rate limiter to all requests
app.use(cookieParser()); // parse cookies from HTTP requests
app.use(session({
    secret: "Your secret key",
    resave: false,
    saveUninitialized: true,
})); // manage sessions using the provided configuration

app.use("/api/homepage", homepageRoute); // associate homepageRoute with the /api/homepage path

app.use("/api/signin", signinRoute);

app.use("/api/protectedTest", protectedTestRoute);

app.use("/api/register", registrationRoute);

app.use("/api/publicTest", publicTestRoute);

app.use("/api/viewProduct", viewProductRoute);

app.listen(8080);