#!/usr/bin/env bash
set -e

# 1. Update src/styles/global.css with macOS Elastic Springs & Window Pop Animations
cat << 'FILE_EOF' > src/styles/global.css
*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

:root {
  --bg-app: #06080d;
  --bg-sidebar: #0a0d14;
  --bg-header: rgba(10, 13, 20, 0.85);
  --bg-panel: rgba(14, 18, 28, 0.75);
  --bg-card: rgba(19, 24, 38, 0.7);
  --bg-card-hover: rgba(28, 35, 54, 0.95);
  --bg-input: rgba(15, 20, 31, 0.9);
  
  --border-color: rgba(255, 255, 255, 0.08);
  --border-subtle: rgba(255, 255, 255, 0.15);
  --border-glow: rgba(139, 92, 246, 0.5);
  
  --text-primary: #f8fafc;
  --text-secondary: #94a3b8;
  --text-muted: #64748b;
  
  --accent-purple: #8b5cf6;
  --accent-purple-hover: #7c3aed;
  --accent-purple-glow: rgba(139, 92, 246, 0.4);
  --accent-purple-dim: rgba(139, 92, 246, 0.14);

  --risk-critical: #f87171;
  --risk-critical-bg: rgba(239, 68, 68, 0.14);
  --risk-medium: #fbbf24;
  --risk-medium-bg: rgba(245, 158, 11, 0.14);
  --risk-low: #34d399;
  --risk-low-bg: rgba(16, 185, 129, 0.14);
  --source-blue: #38bdf8;
  --source-blue-bg: rgba(56, 189, 248, 0.14);

  --font-family: 'Inter', -apple-system, BlinkMacSystemFont, "SF Pro Display", "SF Pro Text", "Segoe UI", Roboto, sans-serif;
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 16px;

  /* macOS Apple Fluid Springs */
  --ease-apple-spring: cubic-bezier(0.34, 1.56, 0.64, 1);
  --ease-apple-out: cubic-bezier(0.16, 1, 0.3, 1);
}

body {
  font-family: var(--font-family);
  background-color: var(--bg-app);
  background-image: 
    radial-gradient(at 15% 15%, rgba(139, 92, 246, 0.09) 0px, transparent 45%),
    radial-gradient(at 85% 85%, rgba(56, 189, 248, 0.05) 0px, transparent 50%);
  background-attachment: fixed;
  color: var(--text-primary);
  font-size: 13px;
  line-height: 1.5;
  -webkit-font-smoothing: antialiased;
  overflow-x: hidden;
}

button {
  font-family: inherit;
  border: none;
  background: none;
  cursor: pointer;
  color: inherit;
  user-select: none;
  touch-action: manipulation;
  will-change: transform, box-shadow;
  transition: transform 0.22s var(--ease-apple-spring),
              background-color 0.2s var(--ease-apple-out),
              box-shadow 0.2s var(--ease-apple-out);
}

button:active {
  transform: scale(0.94) !important;
}

button:disabled {
  opacity: 0.55;
  cursor: not-allowed;
  pointer-events: none;
}

button:focus-visible, input:focus-visible, select:focus-visible {
  outline: 2px solid var(--accent-purple);
  outline-offset: 2px;
}

/* macOS Page / Window Pop Keyframes */
@keyframes macPagePop {
  0% {
    opacity: 0;
    transform: scale3d(0.94, 0.94, 1) translate3d(0, 16px, 0);
  }
  60% {
    opacity: 1;
    transform: scale3d(1.015, 1.015, 1) translate3d(0, -2px, 0);
  }
  100% {
    opacity: 1;
    transform: scale3d(1, 1, 1) translate3d(0, 0, 0);
  }
}

@keyframes macTabPop {
  0% {
    opacity: 0;
    transform: scale3d(0.97, 0.97, 1) translate3d(0, 8px, 0);
  }
  100% {
    opacity: 1;
    transform: scale3d(1, 1, 1) translate3d(0, 0, 0);
  }
}

@keyframes macSheetOpen {
  0% {
    opacity: 0;
    transform: scale3d(0.92, 0.92, 1) translate3d(0, -30px, 0);
  }
  65% {
    opacity: 1;
    transform: scale3d(1.02, 1.02, 1) translate3d(0, 4px, 0);
  }
  100% {
    opacity: 1;
    transform: scale3d(1, 1, 1) translate3d(0, 0, 0);
  }
}

@keyframes macGlowPulse {
  0%, 100% {
    box-shadow: 0 0 10px rgba(124, 58, 237, 0.35);
  }
  50% {
    box-shadow: 0 0 24px rgba(139, 92, 246, 0.65), 0 0 40px rgba(124, 58, 237, 0.25);
  }
}

.mac-page-pop {
  animation: macPagePop 0.45s var(--ease-apple-spring) forwards;
}

.mac-tab-pop {
  animation: macTabPop 0.35s var(--ease-apple-out) forwards;
}

@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
FILE_EOF

# 2. Update RegulationViewer.jsx with Apple Tab Switch Page Pop
cat << 'FILE_EOF' > src/components/dashboard/RegulationViewer.jsx
import React, { useState } from 'react';
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
      <div className="panel-viewer mac-page-pop" style={{ padding: '32px', textAlign: 'center', color: '#94a3b8' }}>
        No regulation selected.
      </div>
    );
  }

  return (
    <div className="panel-viewer mac-page-pop" key={regulation.id}>
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

      {/* Tab container with Apple Safari-style page pop effect */}
      <div className="viewer-body mac-tab-pop" key={activeTab}>
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
      </div>
    </div>
  );
}
FILE_EOF

# 3. Update Modal.jsx with Apple Sheet Pop Animation
cat << 'FILE_EOF' > src/components/common/Modal.jsx
import React, { useEffect } from 'react';
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

  if (!isOpen) return null;

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div 
        className="modal-dialog" 
        style={{ animation: 'macSheetOpen 0.38s cubic-bezier(0.34, 1.56, 0.64, 1)' }}
        onClick={(e) => e.stopPropagation()}
      >
        <div className="modal-header">
          <h3 className="modal-title">{title}</h3>
          <button className="header-icon-btn" onClick={onClose} aria-label="Close modal">
            <X size={16} />
          </button>
        </div>
        <div className="modal-body">{children}</div>
        {footer && <div className="modal-footer">{footer}</div>}
      </div>
    </div>
  );
}
FILE_EOF

# 4. Update components.css for Mac Dock Hover Lifts and Smooth Shadows
cat << 'FILE_EOF' > src/styles/components.css
/* Quick Action Drawer */
.quick-action-bar {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 14px;
  background: var(--bg-panel);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  overflow-x: auto;
  backdrop-filter: blur(16px);
  scrollbar-width: none;
  animation: macPagePop 0.4s var(--ease-apple-spring);
}
.quick-action-bar::-webkit-scrollbar { display: none; }

.quick-action-label {
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.6px;
  color: var(--text-secondary);
  white-space: nowrap;
  margin-right: 6px;
}

.quick-action-btn {
  display: flex;
  align-items: center;
  gap: 7px;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid var(--border-color);
  padding: 7px 12px;
  border-radius: var(--radius-sm);
  font-size: 11.5px;
  color: var(--text-secondary);
  white-space: nowrap;
  transition: transform 0.24s var(--ease-apple-spring), background 0.2s ease, border-color 0.2s ease;
}
.quick-action-btn:hover {
  background: rgba(255, 255, 255, 0.09);
  color: #fff;
  border-color: var(--border-subtle);
  transform: translateY(-3px) scale(1.02);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.4);
}

/* KPI Cards Row with Mac Dock Scaling */
.kpi-row {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 12px;
  animation: macPagePop 0.45s var(--ease-apple-spring);
}

.kpi-card {
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 14px 16px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  backdrop-filter: blur(14px);
  position: relative;
  will-change: transform, box-shadow;
  transition: transform 0.28s var(--ease-apple-spring),
              border-color 0.25s var(--ease-apple-out),
              box-shadow 0.28s var(--ease-apple-spring);
}
.kpi-card:hover {
  border-color: rgba(139, 92, 246, 0.45);
  transform: translateY(-4px) scale(1.02);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.55), 0 0 16px rgba(139, 92, 246, 0.2);
}

.kpi-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.kpi-title {
  font-size: 11px;
  color: var(--text-secondary);
  font-weight: 500;
}

.kpi-value {
  font-size: 24px;
  font-weight: 700;
  color: #ffffff;
  margin: 6px 0 2px;
  letter-spacing: -0.6px;
}

.kpi-trend {
  font-size: 10.5px;
  display: flex;
  align-items: center;
  gap: 4px;
}
.kpi-trend.positive { color: #38bdf8; }
.kpi-trend.confidence { color: #34d399; }

.kpi-dropdown-menu {
  position: absolute;
  top: 36px;
  right: 12px;
  background: #161b2a;
  border: 1px solid var(--border-subtle);
  border-radius: var(--radius-md);
  padding: 6px;
  box-shadow: 0 12px 28px rgba(0, 0, 0, 0.65);
  z-index: 20;
  animation: macTabPop 0.22s var(--ease-apple-spring);
}

.kpi-dropdown-item {
  padding: 7px 10px;
  font-size: 11.5px;
  color: var(--text-secondary);
  border-radius: var(--radius-sm);
  cursor: pointer;
  white-space: nowrap;
  transition: transform 0.2s var(--ease-apple-spring), background 0.15s ease;
}
.kpi-dropdown-item:hover {
  background: rgba(255, 255, 255, 0.08);
  color: #fff;
  transform: translateX(3px);
}

/* Feed Panel */
.panel-feed {
  background: var(--bg-panel);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  display: flex;
  flex-direction: column;
  backdrop-filter: blur(14px);
  overflow: hidden;
  animation: macPagePop 0.5s var(--ease-apple-spring);
}

.feed-header {
  padding: 14px 18px;
  border-bottom: 1px solid var(--border-color);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.feed-title {
  font-size: 13.5px;
  font-weight: 600;
  color: #fff;
}

.feed-actions {
  display: flex;
  align-items: center;
  gap: 6px;
}

.feed-quick-filters {
  display: flex;
  gap: 6px;
  padding: 8px 12px 0;
  overflow-x: auto;
}

.filter-pill {
  padding: 4px 10px;
  font-size: 10px;
  border-radius: 14px;
  border: 1px solid var(--border-color);
  color: var(--text-secondary);
  background: rgba(255, 255, 255, 0.02);
  font-weight: 500;
  transition: transform 0.22s var(--ease-apple-spring), background 0.2s ease, border-color 0.2s ease;
}
.filter-pill:hover {
  color: #fff;
  border-color: var(--border-subtle);
  transform: translateY(-2px);
}
.filter-pill.active {
  background: var(--accent-purple-dim);
  border-color: var(--accent-purple);
  color: #ddd6fe;
  box-shadow: 0 0 12px rgba(139, 92, 246, 0.3);
}

.feed-list {
  display: flex;
  flex-direction: column;
  padding: 12px;
  gap: 10px;
}

.regulation-card {
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 14px;
  cursor: pointer;
  will-change: transform, box-shadow;
  transition: transform 0.25s var(--ease-apple-spring),
              border-color 0.2s ease,
              background 0.2s ease,
              box-shadow 0.25s var(--ease-apple-spring);
}
.regulation-card:hover {
  background: var(--bg-card-hover);
  border-color: var(--border-subtle);
  transform: translateY(-3px) scale(1.01);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.45);
}

.regulation-card.selected {
  border-color: var(--accent-purple);
  background: rgba(139, 92, 246, 0.12);
  box-shadow: 0 0 24px rgba(139, 92, 246, 0.25);
}

.reg-card-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.reg-source-badge {
  font-size: 10px;
  font-weight: 600;
  color: var(--source-blue);
  background: var(--source-blue-bg);
  padding: 3px 8px;
  border-radius: 4px;
  border: 1px solid rgba(56, 189, 248, 0.25);
}

.reg-title {
  font-size: 12.5px;
  font-weight: 600;
  color: #f8fafc;
  margin-bottom: 4px;
  line-height: 1.4;
}

.reg-cat {
  font-size: 11px;
  color: var(--text-muted);
  margin-bottom: 10px;
}

.reg-card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 10.5px;
  color: var(--text-muted);
}

.btn-view-reg {
  color: var(--text-secondary);
  font-size: 11px;
  display: flex;
  align-items: center;
  gap: 4px;
  font-weight: 500;
  transition: transform 0.22s var(--ease-apple-spring), color 0.2s ease;
}
.regulation-card:hover .btn-view-reg {
  color: #fff;
  transform: translateX(4px);
}

.feed-view-all {
  text-align: center;
  padding: 12px;
  font-size: 11.5px;
  color: var(--text-secondary);
  border-top: 1px solid var(--border-color);
  cursor: pointer;
  background: rgba(255, 255, 255, 0.01);
  transition: background 0.2s ease, color 0.2s ease;
}
.feed-view-all:hover {
  background: rgba(255, 255, 255, 0.05);
  color: #fff;
}

/* Badges */
.risk-badge {
  font-size: 10px;
  font-weight: 600;
  padding: 3px 8px;
  border-radius: 4px;
  display: inline-flex;
  align-items: center;
  gap: 4px;
}
.risk-critical {
  background: var(--risk-critical-bg);
  color: var(--risk-critical);
  border: 1px solid rgba(239, 68, 68, 0.35);
}
.risk-medium {
  background: var(--risk-medium-bg);
  color: var(--risk-medium);
  border: 1px solid rgba(245, 158, 11, 0.35);
}
.risk-low {
  background: var(--risk-low-bg);
  color: var(--risk-low);
  border: 1px solid rgba(16, 185, 129, 0.35);
}

/* Regulation Viewer Panel */
.panel-viewer {
  background: var(--bg-panel);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  display: flex;
  flex-direction: column;
  backdrop-filter: blur(16px);
  overflow: hidden;
}

.viewer-header {
  padding: 18px 22px;
  border-bottom: 1px solid var(--border-color);
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 16px;
}

.viewer-title-row {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 6px;
  flex-wrap: wrap;
}

.viewer-title {
  font-size: 15px;
  font-weight: 700;
  color: #fff;
}

.viewer-meta-grid {
  display: flex;
  gap: 24px;
  font-size: 11px;
}

.meta-item {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.meta-label {
  color: var(--text-muted);
  font-size: 10px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.meta-val {
  color: var(--text-secondary);
  font-weight: 500;
}

/* Tabs */
.viewer-tabs {
  display: flex;
  border-bottom: 1px solid var(--border-color);
  padding: 0 16px;
  background: rgba(0, 0, 0, 0.25);
  overflow-x: auto;
  scrollbar-width: none;
}
.viewer-tabs::-webkit-scrollbar { display: none; }

.viewer-tab-btn {
  padding: 12px 16px;
  font-size: 12px;
  color: var(--text-secondary);
  border-bottom: 2px solid transparent;
  white-space: nowrap;
  font-weight: 500;
  transition: color 0.2s ease, transform 0.22s var(--ease-apple-spring);
}
.viewer-tab-btn:hover {
  color: #fff;
  transform: translateY(-2px);
}
.viewer-tab-btn.active {
  color: #ffffff;
  border-bottom-color: var(--accent-purple);
  font-weight: 600;
  box-shadow: inset 0 -4px 12px rgba(139, 92, 246, 0.25);
}

/* Viewer Body */
.viewer-body {
  padding: 22px;
  display: flex;
  flex-direction: column;
  gap: 26px;
}

.section-head-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.section-head-title {
  font-size: 13.5px;
  font-weight: 700;
  color: #ffffff;
}

.btn-link-action {
  font-size: 11.5px;
  color: var(--text-secondary);
  display: flex;
  align-items: center;
  gap: 5px;
  font-weight: 500;
  transition: transform 0.22s var(--ease-apple-spring), color 0.2s ease;
}
.btn-link-action:hover {
  color: #fff;
  transform: translateX(4px);
}

.article-card {
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  padding: 14px 16px;
  margin-bottom: 10px;
  transition: transform 0.25s var(--ease-apple-spring),
              border-color 0.2s ease,
              background 0.2s ease;
}
.article-card:hover {
  border-color: var(--border-subtle);
  background: var(--bg-card-hover);
  transform: translateY(-2px);
}

.article-num {
  font-size: 10.5px;
  font-weight: 700;
  color: var(--accent-purple);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.article-title {
  font-size: 12.5px;
  font-weight: 600;
  color: #f8fafc;
  margin: 3px 0 6px;
}

.article-desc {
  font-size: 12px;
  color: var(--text-secondary);
  line-height: 1.6;
}

/* AI Interpretation Cards with Spring Pop */
.analysis-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}

.analysis-card {
  background: linear-gradient(180deg, rgba(25, 23, 44, 0.7) 0%, rgba(16, 17, 30, 0.7) 100%);
  border: 1px solid rgba(139, 92, 246, 0.25);
  border-radius: var(--radius-md);
  padding: 16px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  will-change: transform, box-shadow;
  transition: transform 0.3s var(--ease-apple-spring),
              border-color 0.25s ease,
              box-shadow 0.3s var(--ease-apple-spring);
}
.analysis-card:hover {
  border-color: var(--accent-purple);
  box-shadow: 0 12px 32px rgba(139, 92, 246, 0.3);
  transform: translateY(-4px) scale(1.015);
}

.analysis-card-title {
  font-size: 12px;
  font-weight: 700;
  color: #ddd6fe;
  margin-bottom: 3px;
}

.analysis-card-sub {
  font-size: 10.5px;
  color: var(--text-muted);
  margin-bottom: 12px;
}

.analysis-items-list {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 9px;
  margin-bottom: 16px;
}

.analysis-item-row {
  display: flex;
  align-items: flex-start;
  gap: 8px;
  font-size: 11.5px;
  color: #cbd5e1;
  line-height: 1.4;
  transition: transform 0.2s var(--ease-apple-spring);
}
.analysis-card:hover .analysis-item-row {
  transform: translateX(3px);
}

.analysis-arrow {
  color: #a78bfa;
  flex-shrink: 0;
  margin-top: 2px;
}

.btn-view-analysis {
  font-size: 11px;
  color: var(--text-secondary);
  display: flex;
  align-items: center;
  gap: 5px;
  font-weight: 500;
  transition: transform 0.22s var(--ease-apple-spring), color 0.2s ease;
}
.btn-view-analysis:hover {
  color: #fff;
  transform: translateX(4px);
}

/* Impacted Entities */
.entities-grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 10px;
}

.entity-card {
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  padding: 12px;
  display: flex;
  flex-direction: column;
  transition: transform 0.25s var(--ease-apple-spring),
              border-color 0.2s ease,
              box-shadow 0.25s var(--ease-apple-spring);
}
.entity-card:hover {
  border-color: var(--border-subtle);
  transform: translateY(-3px) scale(1.02);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.45);
}

.entity-name {
  font-size: 11px;
  color: var(--text-muted);
  font-weight: 600;
}

.entity-count {
  font-size: 22px;
  font-weight: 700;
  color: #ffffff;
  margin: 4px 0 2px;
}

.entity-desc {
  font-size: 10.5px;
  color: var(--text-muted);
  margin-bottom: 10px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.entity-btn {
  font-size: 10.5px;
  font-weight: 500;
  color: var(--text-secondary);
  border: 1px solid var(--border-color);
  padding: 6px;
  border-radius: var(--radius-sm);
  text-align: center;
  background: rgba(255, 255, 255, 0.02);
  transition: all 0.2s ease;
}
.entity-btn:hover {
  background: rgba(255, 255, 255, 0.09);
  color: #fff;
  border-color: var(--border-subtle);
  transform: translateY(-1px);
}

/* Apple Window Sheet Modals */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.75);
  backdrop-filter: blur(14px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
  padding: 16px;
}

.modal-dialog {
  background: #111522;
  border: 1px solid var(--border-subtle);
  border-radius: var(--radius-lg);
  width: 100%;
  max-width: 520px;
  box-shadow: 0 28px 70px rgba(0, 0, 0, 0.85), 0 0 1px 1px rgba(255, 255, 255, 0.1);
  display: flex;
  flex-direction: column;
}

.modal-header {
  padding: 16px 20px;
  border-bottom: 1px solid var(--border-color);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.modal-title {
  font-size: 15px;
  font-weight: 600;
  color: #ffffff;
}

.modal-body {
  padding: 20px;
  max-height: 70vh;
  overflow-y: auto;
}

.modal-footer {
  padding: 14px 20px;
  border-top: 1px solid var(--border-color);
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

.form-group {
  margin-bottom: 16px;
}

.form-label {
  display: block;
  font-size: 11.5px;
  font-weight: 500;
  color: var(--text-secondary);
  margin-bottom: 6px;
}

.form-input, .form-textarea, .form-select {
  width: 100%;
  padding: 9px 12px;
  background: var(--bg-input);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  color: #ffffff;
  outline: none;
}
.form-input:focus, .form-textarea:focus, .form-select:focus {
  border-color: var(--accent-purple);
  box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.3);
}

.btn-primary {
  background: var(--accent-purple);
  color: #ffffff;
  padding: 8px 16px;
  border-radius: var(--radius-sm);
  font-size: 12px;
  font-weight: 600;
  box-shadow: 0 2px 10px rgba(139, 92, 246, 0.35);
  display: inline-flex;
  align-items: center;
  gap: 6px;
  transition: transform 0.22s var(--ease-apple-spring), box-shadow 0.2s ease, background 0.2s ease;
}
.btn-primary:hover {
  background: var(--accent-purple-hover);
  box-shadow: 0 6px 20px rgba(139, 92, 246, 0.55);
  transform: translateY(-2px);
}

.btn-secondary {
  background: rgba(255, 255, 255, 0.05);
  color: var(--text-secondary);
  padding: 8px 16px;
  border-radius: var(--radius-sm);
  font-size: 12px;
  border: 1px solid var(--border-color);
  transition: all 0.2s ease;
}
.btn-secondary:hover {
  background: rgba(255, 255, 255, 0.1);
  color: #fff;
  transform: translateY(-1px);
}
FILE_EOF

# 5. Git commit, push and deploy
git add .
git commit -m "style: add macbook page-pop spring animations for tabs, windows and cards" || true
git push origin main
npm run deploy

echo "🍏 MacBook page-pop spring animations successfully applied and deployed to GitHub Pages!"
