export const apiCall = async (url, options = {}) => {
  const apiUrl = process.env.REACT_APP_API_URL || 'http://localhost:4000';
  const fullUrl = `${apiUrl}${url}`;

  try {
    const response = await fetch(fullUrl, {
      headers: {
        'Content-Type': 'application/json',
        ...options.headers
      },
      ...options
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    return await response.json();
  } catch (error) {
    console.error('API Error:', error);
    throw error;
  }
};

export default apiCall;
