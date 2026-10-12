import React, { useState } from 'react';
import { SlidersHorizontal, Search, RotateCcw } from 'lucide-react';
import RegulationCard from './RegulationCard';

export default function GlobalRegulationsFeed({ 
  regulations, 
  selectedId, 
  onSelectRegulation, 
  onToggleBookmark,
  onViewAll
}) {
  const [filterSeverity, setFilterSeverity] = useState('ALL');
  const [query, setQuery] = useState('');

  const filtered = regulations.filter((r) => {
    const matchesSeverity = filterSeverity === 'ALL' || r.risk.toUpperCase() === filterSeverity;
    const matchesQuery = r.title.toLowerCase().includes(query.toLowerCase()) || 
                         r.category.toLowerCase().includes(query.toLowerCase());
    return matchesSeverity && matchesQuery;
  });

  return (
    <div className="panel-feed">
      <div className="feed-header">
        <span className="feed-title">Global Regulations Feed ({filtered.length})</span>
        <div className="feed-actions">
          {filterSeverity !== 'ALL' && (
            <button 
              className="header-icon-btn" 
              onClick={() => setFilterSeverity('ALL')}
              title="Reset Severity Filter"
            >
              <RotateCcw size={13} />
            </button>
          )}
          <button 
            className="header-icon-btn" 
            title="Filter Feed"
            onClick={() => {
              const sequence = ['ALL', 'CRITICAL', 'MEDIUM', 'LOW'];
              const nextIndex = (sequence.indexOf(filterSeverity) + 1) % sequence.length;
              setFilterSeverity(sequence[nextIndex]);
            }}
          >
            <SlidersHorizontal size={14} color={filterSeverity !== 'ALL' ? '#8b5cf6' : '#94a3b8'} />
          </button>
        </div>
      </div>

      <div style={{ padding: '8px 12px 2px' }}>
        <div className="sidebar-search-box" style={{ padding: '6px 10px' }}>
          <Search size={13} color="#64748b" />
          <input 
            type="text" 
            placeholder="Search regulations..." 
            className="sidebar-search-input" 
            value={query}
            onChange={(e) => setQuery(e.target.value)}
          />
        </div>
      </div>

      <div className="feed-quick-filters">
        {['ALL', 'CRITICAL', 'MEDIUM', 'LOW'].map((lvl) => (
          <button 
            key={lvl}
            className={`filter-pill ${filterSeverity === lvl ? 'active' : ''}`}
            onClick={() => setFilterSeverity(lvl)}
          >
            {lvl}
          </button>
        ))}
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

        {filtered.length === 0 && (
          <div style={{ padding: '24px', textAlign: 'center', color: '#64748b' }}>
            No regulations match current criteria.
          </div>
        )}
      </div>

      <div className="feed-view-all" onClick={onViewAll}>
        View all regulations ({regulations.length})
      </div>
    </div>
  );
}
