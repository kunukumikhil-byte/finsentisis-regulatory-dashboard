import React from 'react';
import { ArrowRight, CornerDownRight } from 'lucide-react';

export default function AnalysisCard({ title, subtitle, items, onViewDetails }) {
  return (
    <div className="analysis-card">
      <div>
        <div className="analysis-card-title">{title}</div>
        <div className="analysis-card-sub">{subtitle}</div>
        
        <ul className="analysis-items-list">
          {items.map((item, idx) => (
            <li key={idx} className="analysis-item-row">
              <CornerDownRight size={12} className="analysis-arrow" />
              <span>{item}</span>
            </li>
          ))}
        </ul>
      </div>

      <button className="btn-view-analysis" onClick={onViewDetails}>
        View all obligations <ArrowRight size={11} />
      </button>
    </div>
  );
}
