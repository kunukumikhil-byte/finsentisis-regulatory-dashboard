import React from 'react';
import { MoreVertical } from 'lucide-react';

export default function EntityCard({ type, count, description, actionText, onClick }) {
  return (
    <div className="entity-card">
      <div className="entity-header">
        <span className="entity-name">{type}</span>
        <MoreVertical size={12} color="#475569" style={{ cursor: 'pointer' }} />
      </div>
      <div className="entity-count">{count}</div>
      <div className="entity-desc">{description}</div>
      <button className="entity-btn" onClick={onClick}>
        {actionText}
      </button>
    </div>
  );
}
