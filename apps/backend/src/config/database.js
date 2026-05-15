const mysql = require('mysql2/promise');

let dbPool = null;

const initializePool = async () => {
  if (!process.env.DB_HOST) {
    console.warn('Database not configured - skipping pool initialization');
    return null;
  }

  try {
    dbPool = await mysql.createPool({
      host: process.env.DB_HOST,
      port: process.env.DB_PORT || 3306,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0,
      enableKeepAlive: true,
      keepAliveInitialDelayMs: 0
    });

    console.log('✓ Database pool initialized');
    return dbPool;
  } catch (error) {
    console.error('✗ Failed to initialize database pool:', error);
    return null;
  }
};

const getPool = () => {
  return dbPool;
};

const closePool = async () => {
  if (dbPool) {
    await dbPool.end();
    dbPool = null;
    console.log('✓ Database pool closed');
  }
};

module.exports = {
  initializePool,
  getPool,
  closePool
};
