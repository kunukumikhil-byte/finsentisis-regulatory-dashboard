#!/usr/bin/env bash
set -e

echo "📦 Installing framer-motion for authentic macOS JavaScript springs..."
npm install framer-motion

# 1. Update src/components/dashboard/RegulationTabs.jsx with JS layoutId pill slider
cat << 'FILE_EOF' > src/components/dashboard/RegulationTabs.jsx
import React from 'react';
import { motion } from 'framer-motion';

export default function RegulationTabs({ activeTab, onSelectTab }) {
  const tabs = [
    "Overview",
    "Full Text",
    "Amendment History",
    "Jurisdiction",
    "Related Laws",
    "Interpretation Log"
  ];

  return (
    <div className="viewer-tabs-wrapper">
      <div className="viewer-tabs-container" style={{ position: 'relative' }}>
        {tabs.map((tab) => {
          const isActive = activeTab === tab;
          return (
            <button
              key={tab}
              className={`viewer-tab-pill ${isActive ? 'active' : ''}`}
              onClick={() => onSelectTab(tab)}
              type="button"
              style={{ position: 'relative', zIndex: 1 }}
            >
              <span style={{ position: 'relative', zIndex: 2 }}>{tab}</span>
              {isActive && (
                <motion.div
                  layoutId="activeTabPill"
                  className="tab-pill-highlight"
                  transition={{
                    type: "spring",
                    stiffness: 450,
                    damping: 32
                  }}
                  style={{
                    position: 'absolute',
                    inset: 0,
                    borderRadius: '8px',
                    backgroundColor: 'rgba(139, 92, 246, 0.2)',
                    border: '1px solid rgba(139, 92, 246, 0.5)',
                    boxShadow: '0 4px 16px rgba(139, 92, 246, 0.3)',
                    zIndex: 1
                  }}
                />
              )}
              {isActive && (
                <motion.div
                  layoutId="activeTabUnderline"
                  transition={{
                    type: "spring",
                    stiffness: 500,
                    damping: 35
                  }}
                  style={{
                    position: 'absolute',
                    bottom: '-9px',
                    left: '20%',
                    right: '20%',
                    height: '2px',
                    backgroundColor: '#8b5cf6',
                    borderRadius: '2px',
                    boxShadow: '0 0 10px #8b5cf6',
                    zIndex: 3
                  }}
                />
              )}
            </button>
          );
        })}
      </div>
    </div>
  );
}
FILE_EOF

# 2. Update RegulationViewer.jsx with AnimatePresence Page-Pop physics
cat << 'FILE_EOF' > src/components/dashboard/RegulationViewer.jsx
import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { MoreVertical, ExternalLink } from 'lucide-react';
import RegulationTabs from './RegulationTabs';
import RegulationText from './RegulationText';
import AIInterpretationAnalysis from './AIInterpretationAnalysis';
import LinkedEntitiesImpacted from './LinkedEntitiesImpacted';

export default function RegulationViewer({ 
  regulation, 
  analysisData, 
  entitiesData,
  onOpenAnalysisModal,
  onOpenEntityModal
}) {
  const [activeTab, setActiveTab] = useState("Overview");
  const [showAllArticles, setShowAllArticles] = useState(false);

  if (!regulation) {
    return (
      <div className="panel-viewer" style={{ padding: '32px', textAlign: 'center', color: '#94a3b8' }}>
        No regulation selected.
      </div>
    );
  }

  return (
    <motion.div 
      className="panel-viewer" 
      key={regulation.id}
      initial={{ opacity: 0, scale: 0.95, y: 15 }}
      animate={{ opacity: 1, scale: 1, y: 0 }}
      transition={{ type: "spring", stiffness: 380, damping: 28 }}
    >
      <div className="viewer-header">
        <div>
          <div className="viewer-title-row">
            <span className="reg-source-badge">{regulation.shortName}</span>
            <span className="viewer-title">{regulation.title}</span>
          </div>
          <div style={{ fontSize: '11px', color: '#64748b' }}>{regulation.category}</div>
        </div>

        <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
          <div className="viewer-meta-grid">
            <div className="meta-item">
              <span className="meta-label">Source Authority</span>
              <span className="meta-val">{regulation.sourceAuthority}</span>
            </div>
            <div className="meta-item">
              <span className="meta-label">Version</span>
              <span className="meta-val">{regulation.version}</span>
            </div>
            <div className="meta-item">
              <span className="meta-label">Last Verified</span>
              <span className="meta-val">{regulation.lastVerified}</span>
            </div>
          </div>
          <button className="header-icon-btn" title="Regulation Options">
            <MoreVertical size={16} />
          </button>
        </div>
      </div>

      <RegulationTabs activeTab={activeTab} onSelectTab={setActiveTab} />

      {/* JavaScript-Powered Tab Page-Pop Container */}
      <div className="viewer-body" style={{ position: 'relative', overflow: 'hidden' }}>
        <AnimatePresence mode="wait">
          <motion.div
            key={activeTab}
            initial={{ opacity: 0, scale: 0.93, y: 18 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.96, y: -12 }}
            transition={{ type: "spring", stiffness: 360, damping: 26 }}
            style={{ width: '100%' }}
          >
            {activeTab === 'Overview' && (
              <div style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
                <RegulationText 
                  articles={showAllArticles ? regulation.articles : regulation.articles.slice(0, 3)} 
                  onViewAll={() => setShowAllArticles(prev => !prev)} 
                />
                <AIInterpretationAnalysis 
                  analysisData={analysisData} 
                  onOpenModal={onOpenAnalysisModal}
                />
                <LinkedEntitiesImpacted 
                  entities={entitiesData} 
                  onSelectEntity={onOpenEntityModal}
                />
              </div>
            )}

            {activeTab === 'Full Text' && (
              <div style={{ padding: '4px 0' }}>
                <h4 style={{ color: '#fff', marginBottom: '8px', fontSize: '13.5px' }}>
                  Consolidated Legal Text — {regulation.title}
                </h4>
                <p style={{ color: '#94a3b8', fontSize: '12.5px', marginBottom: '16px' }}>
                  Official text copy verified by {regulation.sourceAuthority}. Sets harmonized criteria for high-risk AI models and accountability pipelines.
                </p>
                {regulation.articles.map((art) => (
                  <div key={art.number} className="article-card">
                    <div className="article-num">Article {art.number}</div>
                    <div className="article-title">{art.title}</div>
                    <div className="article-desc">{art.summary}</div>
                  </div>
                ))}
              </div>
            )}

            {activeTab === 'Amendment History' && (
              <div style={{ padding: '4px 0', color: '#94a3b8', fontSize: '12.5px' }}>
                <div className="article-card">
                  <div className="article-num">Update 1.0.3 • August 2025</div>
                  <div className="article-title">Realignment with Harmonised Technical Standards</div>
                  <div className="article-desc">Updated conformity assessment procedures under Article 43 for high-risk biometric identification models.</div>
                </div>
                <div className="article-card">
                  <div className="article-num">Update 1.0.2 • June 2025</div>
                  <div className="article-title">Transparency Clarification for GPAI Models</div>
                  <div className="article-desc">Systemic risk indicators codified for foundation models exceeding 10^25 FLOPs training thresholds.</div>
                </div>
              </div>
            )}

            {activeTab === 'Jurisdiction' && (
              <div style={{ padding: '4px 0', color: '#94a3b8', fontSize: '12.5px' }}>
                <div className="article-card">
                  <div className="article-num">Applicable Region</div>
                  <div className="article-title">{regulation.jurisdiction}</div>
                  <div className="article-desc">
                    Direct applicability across member territories with extraterritorial reach applied to commercial systems serving users inside the target market.
                  </div>
                </div>
              </div>
            )}

            {activeTab === 'Related Laws' && (
              <div style={{ padding: '4px 0', color: '#94a3b8', fontSize: '12.5px' }}>
                <div className="article-card" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                  <div>
                    <div className="article-title">Regulation (EU) 2016/679 (GDPR)</div>
                    <div className="article-desc">Shared obligations concerning algorithmic transparency and user consent.</div>
                  </div>
                  <ExternalLink size={14} color="#8b5cf6" />
                </div>
                <div className="article-card" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                  <div>
                    <div className="article-title">Digital Services Act (EU DSA)</div>
                    <div className="article-desc">Intermediary liability and risk assessments for VLOPs.</div>
                  </div>
                  <ExternalLink size={14} color="#8b5cf6" />
                </div>
              </div>
            )}

            {activeTab === 'Interpretation Log' && (
              <div style={{ padding: '4px 0', color: '#94a3b8', fontSize: '12.5px' }}>
                <div className="article-card">
                  <div className="article-num">Audit Verification Log</div>
                  <div className="article-title">Autonomous Scan Execution #8924</div>
                  <div className="article-desc">Completed with 94.7% confidence model. Internal legal counsel confirmed all human oversight triggers.</div>
                </div>
              </div>
            )}
          </motion.div>
        </AnimatePresence>
      </div>
    </motion.div>
  );
}
FILE_EOF

# 3. Update KPICard.jsx with interactive spring hovers and taps
cat << 'FILE_EOF' > src/components/dashboard/KPICard.jsx
import React, { useState, useEffect, useRef } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
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
    <motion.div 
      className="kpi-card" 
      ref={menuRef}
      whileHover={{ y: -6, scale: 1.02 }}
      whileTap={{ scale: 0.97 }}
      transition={{ type: "spring", stiffness: 400, damping: 25 }}
    >
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

      <AnimatePresence>
        {menuOpen && (
          <motion.div 
            className="kpi-dropdown-menu"
            initial={{ opacity: 0, scale: 0.9, y: -6 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.9, y: -6 }}
            transition={{ type: "spring", stiffness: 450, damping: 25 }}
          >
            <div className="kpi-dropdown-item" onClick={() => { setMenuOpen(false); onAction?.(`Export metric for ${title}`); }}>
              Export Metric
            </div>
            <div className="kpi-dropdown-item" onClick={() => { setMenuOpen(false); onAction?.(`Historical trends for ${title}`); }}>
              View History
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </motion.div>
  );
}
FILE_EOF

# 4. Update RegulationCard.jsx with Mac list-item spring feedback
cat << 'FILE_EOF' > src/components/dashboard/RegulationCard.jsx
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
FILE_EOF

# 5. Update Modal.jsx with macOS Sheet Dropdown Physics
cat << 'FILE_EOF' > src/components/common/Modal.jsx
import React, { useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X } from 'lucide-react';

export default function Modal({ isOpen, onClose, title, children, footer }) {
  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === 'Escape') onClose();
    };
    if (isOpen) {
      window.addEventListener('keydown', handleKeyDown);
    }
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [isOpen, onClose]);

  return (
    <AnimatePresence>
      {isOpen && (
        <motion.div 
          className="modal-overlay" 
          onClick={onClose}
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.2 }}
        >
          <motion.div 
            className="modal-dialog" 
            onClick={(e) => e.stopPropagation()}
            initial={{ opacity: 0, scale: 0.88, y: -40 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.9, y: -25 }}
            transition={{ type: "spring", stiffness: 420, damping: 28 }}
          >
            <div className="modal-header">
              <h3 className="modal-title">{title}</h3>
              <button className="header-icon-btn" onClick={onClose} aria-label="Close modal">
                <X size={16} />
              </button>
            </div>
            <div className="modal-body">{children}</div>
            {footer && <div className="modal-footer">{footer}</div>}
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
FILE_EOF

# 6. Commit, Push, and Deploy
git add .
git commit -m "feat(animations): add authentic macOS JavaScript spring transitions with framer-motion" || true
git push origin main
npm run deploy

echo "🍏 JavaScript spring transitions installed and published to GitHub Pages!"
