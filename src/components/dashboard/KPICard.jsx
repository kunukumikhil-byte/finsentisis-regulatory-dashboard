import React, { useState, useEffect, useRef } from 'react';
import { MoreVertical } from 'lucide-react';

export default function KPICard({ title, value, trend, isConfidence = false, onAction }) {
  const [menuOpen, setMenuOpen] = useState(false);
  const menuRef = useRef(null);

  useEffect(() => {
    const handleOutside = (e) => {
      if (menuRef.current && !menuRef.current.contains(e.target)) {
        setMenuOpen(false);
      }
    };
    if (menuOpen) {
      document.addEventListener('mousedown', handleOutside);
    }
    return () => document.removeEventListener('mousedown', handleOutside);
  }, [menuOpen]);

  return (
    <div className="kpi-card" ref={menuRef}>
      <div className="kpi-header">
        <span className="kpi-title">{title}</span>
        <button 
          className="header-icon-btn" 
          style={{ padding: '2px' }}
          onClick={() => setMenuOpen(prev => !prev)}
          aria-label={`Options for ${title}`}
        >
          <MoreVertical size={13} color="#64748b" />
        </button>
      </div>

      <div className="kpi-value">{value}</div>

      <div className={`kpi-trend ${isConfidence ? 'confidence' : 'positive'}`}>
        {trend}
      </div>

      {menuOpen && (
        <div className="kpi-dropdown-menu">
          <div className="kpi-dropdown-item" onClick={() => { setMenuOpen(false); onAction?.(`Export metric for ${title}`); }}>
            Export Metric
          </div>
          <div className="kpi-dropdown-item" onClick={() => { setMenuOpen(false); onAction?.(`Historical trends for ${title}`); }}>
            View History
          </div>
        </div>
      )}
    </div>
  );
}
