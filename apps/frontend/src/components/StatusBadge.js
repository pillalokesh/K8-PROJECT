import React from 'react';

const StatusBadge = ({ status, message }) => {
  const statusClass = status === 'success' ? 'badge-success' : 'badge-error';
  return (
    <span className={`status-badge ${statusClass}`}>
      {message}
    </span>
  );
};

export default StatusBadge;
