const { getPool } = require('../config/database');

const getHealth = async (req, res) => {
  try {
    const pool = getPool();
    let dbStatus = 'not configured';

    if (pool) {
      try {
        const connection = await pool.getConnection();
        await connection.query('SELECT 1');
        connection.release();
        dbStatus = 'connected';
      } catch (err) {
        dbStatus = 'error';
      }
    }

    res.json({
      status: 'healthy',
      timestamp: new Date().toISOString(),
      uptime: process.uptime(),
      database: dbStatus,
      environment: process.env.NODE_ENV || 'development',
      version: '1.0.0'
    });
  } catch (error) {
    res.status(500).json({
      status: 'unhealthy',
      error: error.message
    });
  }
};

module.exports = {
  getHealth
};
