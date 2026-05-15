const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const mysql = require('mysql2/promise');

const app = express();
const PORT = process.env.PORT || 4000;

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());
app.use(rateLimit({ windowMs: 15 * 60 * 1000, max: 100 }));

// Database connection pool
let dbPool = null;

const initDbPool = () => {
  if (process.env.DB_HOST) {
    dbPool = mysql.createPool({
      host: process.env.DB_HOST,
      port: process.env.DB_PORT || 3306,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0
    });
  }
};

// Health check endpoint
app.get('/api/health', async (req, res) => {
  try {
    if (dbPool) {
      const [rows] = await dbPool.query('SELECT 1');
      res.json({
        status: 'healthy',
        database: 'connected',
        message: 'All systems operational'
      });
    } else {
      res.json({
        status: 'healthy',
        database: 'not configured',
        message: 'Backend is running without database'
      });
    }
  } catch (error) {
    res.json({
      status: 'degraded',
      database: 'error',
      message: 'Database connection failed'
    });
  }
});

// API endpoint
app.get('/api/welcome', (req, res) => {
  res.json({
    message: 'Welcome to Enterprise Backend API',
    version: '1.0.0',
    endpoints: ['/api/health', '/api/welcome']
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});

app.listen(PORT, () => {
  console.log(`Backend server running on port ${PORT}`);
  initDbPool();
});

module.exports = app;
