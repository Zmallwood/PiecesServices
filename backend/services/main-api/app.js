// server.js

const express = require('express');
const app = express();
const port = 3000;

// Middleware to parse JSON
app.use(express.json());

// Home route
app.get('/', (req, res) => {
  res.send('Welcome to the Express API!');
});

// Sample API route
app.get('/api/users', (req, res) => {
  const users = [
    { id: 1, name: 'Alice' },
    { id: 2, name: 'Bob' },
  ];
  res.json(users);
});

// POST example
app.post('/api/users', (req, res) => {
  const newUser = req.body;
  // Here you'd normally save the user to a database
  res.status(201).json({
    message: 'User created',
    user: newUser
  });
});

// Start server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

