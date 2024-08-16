
// We have to add these headers so that our Angular app is able to make a connection to the API

const accessHeaders = (req, res, next) => {

    // Allow port 4200 (Angular) to connect
    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:4200');

    // Request methods we have to allow
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

    // Request headers we have to allow
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

    // Allow cookies
    res.setHeader('Access-Control-Allow-Credentials', true);

    next();
};

module.exports = accessHeaders;