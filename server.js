const express = require('express');
const path = require('path');
const app = express();
const port = process.env.PORT || 3002;

require('dotenv').config();

app.use(express.json());

// Serve static files
app.use(express.static(path.join(__dirname, 'public')));

// API Endpoint for key
app.get('/api/key', (req, res) => {
    if (!process.env.API_KEY) {
        return res.status(500).send('API key not set');
    }
    res.json({ apiKey: process.env.API_KEY });
});

// SPA routing - serve index.html for all routes
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});