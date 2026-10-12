import React from 'react';
import { motion } from 'framer-motion';
import { Bookmark, ArrowRight } from 'lucide-react';
import RiskBadge from '../common/RiskBadge';

export default function RegulationCard({ 
  regulation, 
  isSelected, 
  onSelect, 
  onToggleBookmark 
}) {
  return (
    <motion.div 
      className={`regulation-card ${isSelected ? 'selected' : ''}`}
      onClick={() => onSelect(regulation)}
      whileHover={{ y: -3, scale: 1.012 }}
      whileTap={{ scale: 0.98 }}
      transition={{ type: "spring", stiffness: 400, damping: 28 }}
    >
      <div className="reg-card-top">
        <span className="reg-source-badge">{regulation.shortName}</span>
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
          <RiskBadge risk={regulation.risk} />
          <button 
            onClick={(e) => {
              e.stopPropagation();
              onToggleBookmark(regulation.id);
            }}
            aria-label="Toggle bookmark"
          >
            <Bookmark 
              size={13} 
              color={regulation.bookmarked ? "#8b5cf6" : "#64748b"} 
              fill={regulation.bookmarked ? "#8b5cf6" : "none"} 
            />
          </button>
        </div>
      </div>

      <div className="reg-title">{regulation.title}</div>
      <div className="reg-cat">{regulation.category}</div>

      <div className="reg-card-footer">
        <span>📅 {regulation.date}</span>
        <span className="btn-view-reg">
          View Regulation <ArrowRight size={11} />
        </span>
      </div>
    </motion.div>
  );
}
