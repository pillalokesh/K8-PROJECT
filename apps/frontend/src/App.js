import React, { useState, useEffect } from 'react';
import axios from 'axios';
import Dashboard from './components/Dashboard';
import UserForm from './components/UserForm';
import './App.css';

function App() {
  const [health, setHealth] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [refreshKey, setRefreshKey] = useState(0);

  useEffect(() => {
    fetchHealth();
  }, []);

  const fetchHealth = async () => {
    try {
      setLoading(true);
      const apiUrl = process.env.REACT_APP_API_URL || 'http://localhost:4000';
      const response = await axios.get(`${apiUrl}/api/health`);
      setHealth(response.data);
      setError(null);
    } catch (err) {
      setError('Unable to connect to backend');
      setHealth(null);
    } finally {
      setLoading(false);
    }
  };

  const handleUserCreated = () => {
    setRefreshKey(prev => prev + 1);
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>🏢 Enterprise DevSecOps Platform</h1>
        <div className="status-card">
          <h2>Application Status</h2>
          {loading ? (
            <p>Loading...</p>
          ) : (
            <>
              {health && (
                <div className={error ? 'status-error' : 'status-success'}>
                  <p><strong>Status:</strong> {health.status}</p>
                  <p><strong>Database:</strong> {health.database}</p>
                  <p><strong>Uptime:</strong> {Math.round(health.uptime)}s</p>
                  <p><strong>Environment:</strong> {health.environment}</p>
                </div>
              )}
              {error && <p className="error-text">{error}</p>}
              <button onClick={fetchHealth} className="refresh-btn">Refresh Status</button>
            </>
          )}
        </div>
        <div className="info-card">
          <h3>🌐 Architecture</h3>
          <ul>
            <li>Frontend: React + Nginx</li>
            <li>Backend: Node.js + Express</li>
            <li>Database: Amazon RDS MySQL</li>
            <li>Orchestration: Amazon EKS</li>
            <li>CI/CD: GitHub Actions → ArgoCD</li>
          </ul>
        </div>
      </header>
      <main className="App-main">
        <UserForm onSuccess={handleUserCreated} />
        <Dashboard key={refreshKey} />
      </main>
      <footer className="App-footer">
        <p>&copy; 2026 Enterprise DevSecOps Platform. All rights reserved.</p>
      </footer>
    </div>
  );
}

export default App;
