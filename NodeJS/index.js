// We're using the Nodemon package to automatically restart the server anytime a change has been detected

const express = require('express');
const path = require('path');
const logger = require('./middleware/logger');
const accessHeaders = require('./middleware/access-headers');

const app = express();

// Set the access headers (middleware)
app.use(accessHeaders);
// Set the logger (middleware)
app.use(logger);

// With this middleware we're able to handle raw json and url encoded data
app.use(express.json());
app.use(express.urlencoded({ extended: false}));

// Set a static folder, this is basically the index.html
app.use(express.static(path.join(__dirname, 'public')));

// Use the Review API routes
app.use('/api/reviews', require('./routes/api/reviews'));
app.use('/api/users', require('./routes/api/users'));
app.use('/api/users/register', require('./routes/api/users'));

// If we have an envirnoment value for the port, then we use that. Else we use port 5000
const PORT = process.env.PORT || 3636;

app.listen(PORT, () => console.log(`Server has started on port: ${PORT}`));