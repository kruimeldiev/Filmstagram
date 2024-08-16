
// This arrow function is called everytime a request has been made
const logger = (req, res, next) => {
    // Prints out the URL that has been called
    console.log(`${req.protocol}://${req.get('host')}${req.originalUrl} called`);
    next();
};

module.exports = logger;