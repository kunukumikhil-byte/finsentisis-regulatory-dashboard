import React from 'react';
import { MoreVertical } from 'lucide-react';

export default function KPICard({ title, value, trend, isConfidence = false }) {
  return (
    <div className="kpi-card">
      <div className="kpi-header">
        <span className="kpi-title">{title}</span>
        <MoreVertical size={13} color="#475569" style={{ cursor: 'pointer' }} />
      </div>
      <div className="kpi-value">{value}</div>
      <div className={`kpi-trend ${isConfidence ? 'confidence' : 'positive'}`}>
        {trend}
      </div>
    </div>
  );
}
