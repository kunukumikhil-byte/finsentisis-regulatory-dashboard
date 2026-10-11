import React from 'react';
import { ArrowRight } from 'lucide-react';

export default function RegulationText({ articles, onViewAll }) {
  return (
    <div>
      <div className="section-head-bar">
        <span className="section-head-title">Original Regulation Text</span>
        <button className="btn-link-action" onClick={onViewAll}>
          View all Regulation <ArrowRight size={11} />
        </button>
      </div>

      {articles?.map((art) => (
        <div key={art.number} className="article-card">
          <div className="article-num">Article {art.number}</div>
          <div className="article-title">{art.title}</div>
          <div className="article-desc">{art.summary}</div>
        </div>
      ))}
    </div>
  );
}
