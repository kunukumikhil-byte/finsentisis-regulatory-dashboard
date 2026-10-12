#!/usr/bin/env bash
set -e

# 1. Ultra-Modern Dark Theme CSS with Glassmorphism & Keyframes
cat << 'FILE_EOF' > src/styles/global.css
*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

:root {
  --bg-app: #06080d;
  --bg-sidebar: #0a0d14;
  --bg-header: rgba(10, 13, 20, 0.75);
  --bg-panel: rgba(14, 18, 28, 0.7);
  --bg-card: rgba(19, 24, 38, 0.65);
  --bg-card-hover: rgba(28, 35, 54, 0.85);
  --bg-input: rgba(15, 20, 31, 0.9);
  
  --border-color: rgba(255, 255, 255, 0.07);
  --border-subtle: rgba(255, 255, 255, 0.12);
  --border-glow: rgba(139, 92, 246, 0.4);
  
  --text-primary: #f8fafc;
  --text-secondary: #94a3b8;
  --text-muted: #64748b;
  
  --accent-purple: #8b5cf6;
  --accent-purple-hover: #7c3aed;
  --accent-purple-glow: rgba(139, 92, 246, 0.35);
  --accent-purple-dim: rgba(139, 92, 246, 0.12);

  --risk-critical: #f87171;
  --risk-critical-bg: rgba(239, 68, 68, 0.12);
  --risk-medium: #fbbf24;
  --risk-medium-bg: rgba(245, 158, 11, 0.12);
  --risk-low: #34d399;
  --risk-low-bg: rgba(16, 185, 129, 0.12);
  --source-blue: #38bdf8;
  --source-blue-bg: rgba(56, 189, 248, 0.12);

  --font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 14px;
}

body {
  font-family: var(--font-family);
  background-color: var(--bg-app);
  background-image: 
    radial-gradient(at 15% 15%, rgba(139, 92, 246, 0.08) 0px, transparent 40%),
    radial-gradient(at 85% 85%, rgba(56, 189, 248, 0.05) 0px, transparent 45%);
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
  transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
}

button:active {
  transform: scale(0.96);
}

input, select, textarea {
  font-family: inherit;
  font-size: 13px;
  transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
}

::-webkit-scrollbar {
  width: 5px;
  height: 5px;
}
::-webkit-scrollbar-track {
  background: transparent;
}
::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.12);
  border-radius: 4px;
}
::-webkit-scrollbar-thumb:hover {
  background: rgba(255, 255, 255, 0.22);
}

/* Animations */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes pulseGlow {
  0%, 100% { box-shadow: 0 0 10px rgba(124, 58, 237, 0.35); }
  50% { box-shadow: 0 0 22px rgba(139, 92, 246, 0.7); }
}
FILE_EOF

# 2. Modern Glass Layout
cat << 'FILE_EOF' > src/styles/layout.css
.app-container {
  display: flex;
  min-height: 100vh;
  background-color: var(--bg-app);
  position: relative;
  overflow-x: hidden;
}

.sidebar {
  width: 254px;
  background: var(--bg-sidebar);
  border-right: 1px solid var(--border-color);
  display: flex;
  flex-direction: column;
  position: sticky;
  top: 0;
  height: 100vh;
  z-index: 50;
  flex-shrink: 0;
  backdrop-filter: blur(16px);
  transition: transform 0.35s cubic-bezier(0.16, 1, 0.3, 1);
}

.sidebar-overlay {
  display: none;
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.75);
  backdrop-filter: blur(4px);
  z-index: 45;
  animation: fadeIn 0.25s ease-out;
}

.sidebar-brand {
  padding: 18px 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.brand-wrapper {
  display: flex;
  align-items: center;
  gap: 12px;
}

.brand-icon {
  width: 32px;
  height: 32px;
  background: linear-gradient(135deg, #a78bfa 0%, #6d28d9 100%);
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  color: #fff;
  font-size: 15px;
  box-shadow: 0 0 14px rgba(124, 58, 237, 0.5);
}

.brand-title {
  font-size: 14px;
  font-weight: 700;
  color: #ffffff;
  letter-spacing: -0.2px;
}

.brand-subtitle {
  font-size: 10px;
  color: var(--text-muted);
}

.sidebar-collapse-btn {
  color: var(--text-muted);
  padding: 6px;
  border-radius: var(--radius-sm);
}
.sidebar-collapse-btn:hover {
  background: rgba(255, 255, 255, 0.05);
  color: var(--text-primary);
}

.sidebar-search-container {
  padding: 0 14px 14px;
}

.sidebar-search-box {
  display: flex;
  align-items: center;
  background: var(--bg-input);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 8px 12px;
  gap: 8px;
  transition: all 0.2s ease;
}
.sidebar-search-box:focus-within {
  border-color: var(--accent-purple);
  box-shadow: 0 0 12px rgba(139, 92, 246, 0.25);
}

.sidebar-search-input {
  background: transparent;
  border: none;
  outline: none;
  color: var(--text-primary);
  width: 100%;
  font-size: 12px;
}

.kbd-shortcut {
  background: rgba(255, 255, 255, 0.06);
  border: 1px solid var(--border-subtle);
  padding: 1px 6px;
  border-radius: 4px;
  font-size: 10.5px;
  color: var(--text-muted);
}

.sidebar-nav {
  flex: 1;
  overflow-y: auto;
  padding: 6px 12px;
}

.nav-section-title {
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.6px;
  color: var(--text-muted);
  padding: 8px 10px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 11px;
  padding: 9px 12px;
  border-radius: var(--radius-md);
  color: var(--text-secondary);
  font-size: 12.5px;
  margin-bottom: 3px;
  cursor: pointer;
  transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);
  border: 1px solid transparent;
}

.nav-item:hover {
  background: rgba(255, 255, 255, 0.04);
  color: #fff;
  transform: translateX(3px);
}

.nav-item.active {
  background: rgba(139, 92, 246, 0.12);
  color: #ddd6fe;
  font-weight: 600;
  border-color: rgba(139, 92, 246, 0.35);
  box-shadow: inset 0 0 14px rgba(139, 92, 246, 0.12);
}

.sidebar-bottom {
  padding: 12px;
  border-top: 1px solid var(--border-color);
}

.user-profile {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 8px 10px;
  border-radius: var(--radius-md);
  cursor: pointer;
  background: rgba(255, 255, 255, 0.02);
  border: 1px solid var(--border-color);
  transition: all 0.2s ease;
}

.user-profile:hover {
  background: rgba(255, 255, 255, 0.06);
  border-color: var(--border-subtle);
}

.user-avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: linear-gradient(135deg, #3b82f6, #1d4ed8);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 11.5px;
  color: #fff;
  box-shadow: 0 0 8px rgba(59, 130, 246, 0.4);
}

.user-details {
  flex: 1;
  overflow: hidden;
}

.user-name {
  font-size: 12px;
  font-weight: 600;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.user-email {
  font-size: 10.5px;
  color: var(--text-muted);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.main-wrapper {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-width: 0;
}

.top-header {
  height: 52px;
  border-bottom: 1px solid var(--border-color);
  background: var(--bg-header);
  backdrop-filter: blur(16px);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
  position: sticky;
  top: 0;
  z-index: 40;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.mobile-menu-btn {
  display: none;
  color: var(--text-primary);
  padding: 6px;
  border-radius: var(--radius-sm);
}

.breadcrumb {
  font-size: 12px;
  color: var(--text-muted);
  display: flex;
  align-items: center;
  gap: 6px;
}

.breadcrumb span.current {
  color: var(--text-primary);
  font-weight: 500;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 10px;
}

.btn-copilot {
  background: linear-gradient(135deg, #8b5cf6 0%, #6d28d9 100%);
  color: #ffffff;
  padding: 6px 15px;
  border-radius: 20px;
  font-size: 11.5px;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 6px;
  border: 1px solid rgba(167, 139, 250, 0.45);
  animation: pulseGlow 4s infinite ease-in-out;
}
.btn-copilot:hover {
  transform: translateY(-1px);
}

.header-icon-btn {
  color: var(--text-secondary);
  padding: 7px;
  border-radius: var(--radius-sm);
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid transparent;
}
.header-icon-btn:hover {
  color: #fff;
  background: rgba(255, 255, 255, 0.05);
  border-color: var(--border-color);
}

.dashboard-content {
  padding: 20px 24px 50px;
  display: flex;
  flex-direction: column;
  gap: 18px;
  animation: fadeIn 0.4s cubic-bezier(0.16, 1, 0.3, 1);
}

.dashboard-title {
  font-size: 20px;
  font-weight: 700;
  color: #fff;
  letter-spacing: -0.3px;
}

.dashboard-subtext {
  font-size: 12.5px;
  color: var(--text-secondary);
  margin-top: 3px;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: 420px 1fr;
  gap: 18px;
  align-items: start;
}
FILE_EOF

# 3. Modern Interactive Components CSS
cat << 'FILE_EOF' > src/styles/components.css
.quick-action-bar {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 14px;
  background: var(--bg-panel);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  overflow-x: auto;
  backdrop-filter: blur(12px);
  scrollbar-width: none;
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
}
.quick-action-btn:hover {
  background: rgba(255, 255, 255, 0.08);
  color: #fff;
  border-color: var(--border-subtle);
  transform: translateY(-1px);
}

.kpi-row {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 12px;
}

.kpi-card {
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 14px 16px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  backdrop-filter: blur(12px);
  transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
}
.kpi-card:hover {
  border-color: var(--border-subtle);
  transform: translateY(-3px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.45);
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

.panel-feed {
  background: var(--bg-panel);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  display: flex;
  flex-direction: column;
  backdrop-filter: blur(14px);
  overflow: hidden;
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
  transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
}
.regulation-card:hover {
  background: var(--bg-card-hover);
  border-color: var(--border-subtle);
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.35);
}

.regulation-card.selected {
  border-color: var(--accent-purple);
  background: rgba(139, 92, 246, 0.1);
  box-shadow: 0 0 20px rgba(139, 92, 246, 0.18);
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
  border: 1px solid rgba(56, 189, 248, 0.2);
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
  transition: all 0.2s ease;
}
.regulation-card:hover .btn-view-reg {
  color: #fff;
  transform: translateX(3px);
}

.feed-view-all {
  text-align: center;
  padding: 12px;
  font-size: 11.5px;
  color: var(--text-secondary);
  border-top: 1px solid var(--border-color);
  cursor: pointer;
  background: rgba(255, 255, 255, 0.01);
  transition: all 0.2s ease;
}
.feed-view-all:hover {
  background: rgba(255, 255, 255, 0.04);
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
  backdrop-filter: blur(14px);
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
  transition: all 0.2s ease;
}
.viewer-tab-btn:hover { color: #fff; }
.viewer-tab-btn.active {
  color: #ffffff;
  border-bottom-color: var(--accent-purple);
  font-weight: 600;
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
}
.btn-link-action:hover {
  color: #fff;
  transform: translateX(3px);
}

.article-card {
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  padding: 14px 16px;
  margin-bottom: 10px;
  transition: all 0.2s ease;
}
.article-card:hover {
  border-color: var(--border-subtle);
  background: var(--bg-card-hover);
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

/* AI Interpretation Cards */
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
  transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
}
.analysis-card:hover {
  border-color: var(--accent-purple);
  box-shadow: 0 8px 24px rgba(139, 92, 246, 0.2);
  transform: translateY(-3px);
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
}
.btn-view-analysis:hover {
  color: #fff;
  transform: translateX(3px);
}

/* Entities */
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
  transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);
}
.entity-card:hover {
  border-color: var(--border-subtle);
  transform: translateY(-2px);
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.3);
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
}
.entity-btn:hover {
  background: rgba(255, 255, 255, 0.08);
  color: #fff;
  border-color: var(--border-subtle);
}

/* Modals */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.78);
  backdrop-filter: blur(8px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
  padding: 16px;
  animation: fadeIn 0.25s cubic-bezier(0.16, 1, 0.3, 1);
}

.modal-dialog {
  background: #111522;
  border: 1px solid var(--border-subtle);
  border-radius: var(--radius-lg);
  width: 100%;
  max-width: 520px;
  box-shadow: 0 24px 60px rgba(0, 0, 0, 0.8), 0 0 1px 1px rgba(255, 255, 255, 0.08);
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
  box-shadow: 0 0 0 2px rgba(139, 92, 246, 0.25);
}

.btn-primary {
  background: var(--accent-purple);
  color: #ffffff;
  padding: 8px 16px;
  border-radius: var(--radius-sm);
  font-size: 12px;
  font-weight: 600;
  box-shadow: 0 2px 10px rgba(139, 92, 246, 0.35);
}
.btn-primary:hover {
  background: var(--accent-purple-hover);
  box-shadow: 0 4px 16px rgba(139, 92, 246, 0.5);
}

.btn-secondary {
  background: rgba(255, 255, 255, 0.05);
  color: var(--text-secondary);
  padding: 8px 16px;
  border-radius: var(--radius-sm);
  font-size: 12px;
  border: 1px solid var(--border-color);
}
.btn-secondary:hover {
  background: rgba(255, 255, 255, 0.1);
  color: #fff;
}
FILE_EOF

# 4. Modern Fluid Breakpoints
cat << 'FILE_EOF' > src/styles/responsive.css
@media (max-width: 1280px) {
  .dashboard-grid {
    grid-template-columns: 360px 1fr;
  }
  .kpi-row {
    grid-template-columns: repeat(3, 1fr);
  }
  .analysis-grid {
    grid-template-columns: 1fr;
  }
  .entities-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (max-width: 980px) {
  .sidebar {
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
    transform: translateX(-100%);
    box-shadow: 6px 0 30px rgba(0, 0, 0, 0.8);
  }

  .sidebar.mobile-open {
    transform: translateX(0);
  }

  .sidebar-overlay.active {
    display: block;
  }

  .mobile-menu-btn {
    display: flex;
  }

  .dashboard-grid {
    grid-template-columns: 1fr;
  }
  
  .kpi-row {
    grid-template-columns: repeat(2, 1fr);
  }

  .viewer-meta-grid {
    flex-wrap: wrap;
    gap: 16px;
  }
}

@media (max-width: 640px) {
  .top-header {
    padding: 0 14px;
  }

  .breadcrumb {
    display: none;
  }

  .dashboard-content {
    padding: 14px 14px 36px;
    gap: 14px;
  }

  .kpi-row {
    grid-template-columns: 1fr;
  }
  
  .entities-grid {
    grid-template-columns: 1fr;
  }

  .viewer-header {
    flex-direction: column;
    align-items: flex-start;
  }

  .viewer-meta-grid {
    width: 100%;
    justify-content: space-between;
  }

  .quick-action-bar {
    padding: 8px;
  }
}
FILE_EOF

# 5. Git Commit, Push to Main & Deploy to GitHub Pages
git add .
git commit -m "style: ultra modern glassmorphism UI, smooth transitions & animations" || true
git push origin main
npm run deploy

echo "🚀 Production build published to GitHub Pages with modern animations!"
