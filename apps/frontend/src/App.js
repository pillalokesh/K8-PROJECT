import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

function App() {
  const [message, setMessage] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      setLoading(true);
      const apiUrl = process.env.REACT_APP_API_URL || 'http://localhost:4000';
      const response = await axios.get(`${apiUrl}/api/health`);
      setMessage(response.data.message);
      setError(null);
    } catch (err) {
      setError('Unable to connect to backend');
      setMessage('Frontend is running, but backend is unreachable');
    } finally {
      setLoading(false);
    }
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
              <p className={error ? 'error' : 'success'}>
                {error || message}
              </p>
              <button onClick={fetchData}>Refresh Status</button>
            </>
          )}
        </div>
        <div className="info-card">
          <h3>🌐 Architecture</h3>
          <p>Frontend: React + Nginx</p>
          <p>Backend: Node.js + Express</p>
          <p>Database: Amazon RDS MySQL</p>
          <p>Orchestration: Amazon EKS</p>
          <p>GitOps: ArgoCD</p>
        </div>
      </header>
    </div>
  );
}

export default App;
