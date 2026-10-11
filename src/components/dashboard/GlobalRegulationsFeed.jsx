import React, { useState } from 'react';
import { SlidersHorizontal, MoreVertical } from 'lucide-react';
import RegulationCard from './RegulationCard';

export default function GlobalRegulationsFeed({ 
  regulations, 
  selectedId, 
  onSelectRegulation, 
  onToggleBookmark,
  onViewAll
}) {
  const [filterSeverity, setFilterSeverity] = useState('ALL');

  const filtered = regulations.filter((r) => {
    if (filterSeverity === 'ALL') return true;
    return r.risk.toUpperCase() === filterSeverity;
  });

  return (
    <div className="panel-feed">
      <div className="feed-header">
        <span className="feed-title">Global Regulations Feed</span>
        <div className="feed-actions">
          <button 
            className="header-icon-btn" 
            title="Filter Feed"
            onClick={() => setFilterSeverity(prev => prev === 'ALL' ? 'CRITICAL' : 'ALL')}
          >
            <SlidersHorizontal size={14} color={filterSeverity !== 'ALL' ? '#8b5cf6' : '#94a3b8'} />
          </button>
          <button className="header-icon-btn" title="Feed Options">
            <MoreVertical size={14} />
          </button>
        </div>
      </div>

      <div className="feed-list">
        {filtered.map((reg) => (
          <RegulationCard
            key={reg.id}
            regulation={reg}
            isSelected={reg.id === selectedId}
            onSelect={onSelectRegulation}
            onToggleBookmark={onToggleBookmark}
          />
        ))}
      </div>

      <div className="feed-view-all" onClick={onViewAll}>
        View all regulations
      </div>
    </div>
  );
}
