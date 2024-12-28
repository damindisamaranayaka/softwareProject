const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const patientRoutes = require('./routes/patientRoutes'); // Import patient routes

// Load environment variables from .env file
require('dotenv').config();

// Initialize the Express app
const app = express();

// Import database connection
require('./db'); // MongoDB connection logic in db.js

// Middleware to parse JSON requests
app.use(express.json());

// Token verification middleware
const authenticateToken = (req, res, next) => {
  const token = req.headers['authorization']?.split(' ')[1];
  if (!token) return res.sendStatus(401); // Unauthorized

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.sendStatus(403); // Forbidden
    req.user = user; // Save user info for use in other routes
    next();
  });
};

// Use the patient routes
app.use('/api', patientRoutes);

// Example of a protected route
app.get('/api/protected-route', authenticateToken, (req, res) => {
  res.send('This is a protected route.');
});

// Default route for testing
app.get('/', (req, res) => {
  res.send('Welcome to the Medical Clinic API');
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});