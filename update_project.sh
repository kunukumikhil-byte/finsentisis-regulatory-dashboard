#!/usr/bin/env bash
set -e

# 1. Update src/styles/global.css
cat << 'FILE_EOF' > src/styles/global.css
*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

:root {
  --bg-app: #080a0f;
  --bg-sidebar: #0b0d13;
  --bg-header: #0e1118;
  --bg-panel: #11141d;
  --bg-card: #141824;
  --bg-card-hover: #1b2131;
  --bg-input: #151821;
  --border-color: #1f2536;
  --border-subtle: #293044;
  
  --text-primary: #f8fafc;
  --text-secondary: #94a3b8;
  --text-muted: #64748b;
  
  --accent-purple: #8b5cf6;
  --accent-purple-hover: #7c3aed;
  --accent-purple-glow: rgba(139, 92, 246, 0.35);
  --accent-purple-dim: rgba(139, 92, 246, 0.12);

  --risk-critical: #ef4444;
  --risk-critical-bg: rgba(239, 68, 68, 0.12);
  --risk-medium: #f59e0b;
  --risk-medium-bg: rgba(245, 158, 11, 0.12);
  --risk-low: #10b981;
  --risk-low-bg: rgba(16, 185, 129, 0.12);
  --source-blue: #38bdf8;
  --source-blue-bg: rgba(56, 189, 248, 0.12);

  --font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  --radius-sm: 6px;
  --radius-md: 8px;
  --radius-lg: 12px;
  --shadow-subtle: 0 4px 20px rgba(0, 0, 0, 0.4);
}

body {
  font-family: var(--font-family);
  background-color: var(--bg-app);
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
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
}

button:active {
  transform: scale(0.97);
}

input, select, textarea {
  font-family: inherit;
  font-size: 13px;
  transition: all 0.2s ease;
}

::-webkit-scrollbar {
  width: 5px;
  height: 5px;
}
::-webkit-scrollbar-track {
  background: transparent;
}
::-webkit-scrollbar-thumb {
  background: #252b3d;
  border-radius: 4px;
}
::-webkit-scrollbar-thumb:hover {
  background: #3e4764;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(6px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes pulseGlow {
  0%, 100% { box-shadow: 0 0 12px var(--accent-purple-glow); }
  50% { box-shadow: 0 0 20px rgba(139, 92, 246, 0.6); }
}
FILE_EOF

# 2. Update src/styles/layout.css
cat << 'FILE_EOF' > src/styles/layout.css
.app-container {
  display: flex;
  min-height: 100vh;
  background-color: var(--bg-app);
  position: relative;
  overflow-x: hidden;
}

.sidebar {
  width: 250px;
  background-color: var(--bg-sidebar);
  border-right: 1px solid var(--border-color);
  display: flex;
  flex-direction: column;
  position: sticky;
  top: 0;
  height: 100vh;
  z-index: 50;
  flex-shrink: 0;
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.sidebar-overlay {
  display: none;
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.65);
  backdrop-filter: blur(3px);
  z-index: 45;
}

.sidebar-brand {
  padding: 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.brand-wrapper {
  display: flex;
  align-items: center;
  gap: 10px;
}

.brand-icon {
  width: 32px;
  height: 32px;
  background: linear-gradient(135deg, #a78bfa, #6d28d9);
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  color: #fff;
  font-size: 16px;
  box-shadow: 0 0 10px rgba(109, 40, 217, 0.4);
}

.brand-title {
  font-size: 14px;
  font-weight: 600;
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
  background-color: rgba(255, 255, 255, 0.05);
  color: var(--text-primary);
}

.sidebar-search-container {
  padding: 0 14px 12px;
}

.sidebar-search-box {
  display: flex;
  align-items: center;
  background-color: var(--bg-input);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 7px 12px;
  gap: 8px;
}
.sidebar-search-box:focus-within {
  border-color: var(--accent-purple);
  box-shadow: 0 0 0 2px rgba(139, 92, 246, 0.2);
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
  background-color: #212738;
  border: 1px solid #31394f;
  padding: 1px 6px;
  border-radius: 4px;
  font-size: 10px;
  color: var(--text-muted);
}

.sidebar-nav {
  flex: 1;
  overflow-y: auto;
  padding: 8px 12px;
}

.nav-section-title {
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  color: var(--text-muted);
  padding: 8px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 9px 12px;
  border-radius: var(--radius-md);
  color: var(--text-secondary);
  font-size: 12.5px;
  margin-bottom: 3px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.nav-item:hover {
  background-color: rgba(255, 255, 255, 0.05);
  color: var(--text-primary);
  transform: translateX(2px);
}

.nav-item.active {
  background-color: var(--accent-purple-dim);
  color: #ddd6fe;
  font-weight: 600;
  border: 1px solid rgba(139, 92, 246, 0.35);
  box-shadow: inset 0 0 10px rgba(139, 92, 246, 0.1);
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
  background-color: rgba(255, 255, 255, 0.02);
  border: 1px solid transparent;
  transition: all 0.2s ease;
}

.user-profile:hover {
  background-color: rgba(255, 255, 255, 0.06);
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
  font-weight: 600;
  font-size: 12px;
  color: #fff;
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
  background-color: var(--bg-app);
}

.top-header {
  height: 52px;
  border-bottom: 1px solid var(--border-color);
  background-color: rgba(14, 17, 24, 0.85);
  backdrop-filter: blur(8px);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
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

.mobile-menu-btn:hover {
  background-color: rgba(255, 255, 255, 0.08);
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
  gap: 8px;
}

.btn-copilot {
  background: linear-gradient(135deg, #7c3aed, #6d28d9);
  color: #ffffff;
  padding: 6px 14px;
  border-radius: 20px;
  font-size: 11.5px;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 6px;
  border: 1px solid rgba(167, 139, 250, 0.4);
  animation: pulseGlow 4s infinite ease-in-out;
}

.btn-copilot:hover {
  opacity: 0.95;
  transform: translateY(-1px);
}

.header-icon-btn {
  color: var(--text-secondary);
  padding: 8px;
  border-radius: var(--radius-sm);
  display: flex;
  align-items: center;
  justify-content: center;
}

.header-icon-btn:hover {
  color: var(--text-primary);
  background-color: rgba(255, 255, 255, 0.07);
}

.dashboard-content {
  padding: 16px 20px 48px;
  display: flex;
  flex-direction: column;
  gap: 18px;
  animation: fadeIn 0.4s ease-out;
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
  gap: 16px;
  align-items: start;
}
FILE_EOF

# 3. Update src/styles/components.css
cat << 'FILE_EOF' > src/styles/components.css
.quick-action-bar {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 14px;
  background-color: var(--bg-panel);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  overflow-x: auto;
  scrollbar-width: none;
}
.quick-action-bar::-webkit-scrollbar {
  display: none;
}

.quick-action-label {
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  color: var(--text-secondary);
  white-space: nowrap;
  margin-right: 6px;
}

.quick-action-btn {
  display: flex;
  align-items: center;
  gap: 7px;
  background-color: rgba(255, 255, 255, 0.03);
  border: 1px solid var(--border-color);
  padding: 7px 12px;
  border-radius: var(--radius-sm);
  font-size: 11.5px;
  color: var(--text-secondary);
  white-space: nowrap;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
}

.quick-action-btn:hover {
  background-color: rgba(255, 255, 255, 0.08);
  color: var(--text-primary);
  border-color: var(--border-subtle);
  transform: translateY(-1px);
}

.kpi-row {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 12px;
}

.kpi-card {
  background-color: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 14px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
  transition: all 0.25s ease;
}

.kpi-card:hover {
  border-color: var(--border-subtle);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.35);
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
  color: var(--text-muted);
  display: flex;
  align-items: center;
  gap: 4px;
}

.kpi-trend.positive {
  color: #38bdf8;
}

.kpi-trend.confidence {
  color: #34d399;
}

.panel-feed {
  background-color: var(--bg-panel);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.feed-header {
  padding: 12px 16px;
  border-bottom: 1px solid var(--border-color);
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: rgba(255, 255, 255, 0.01);
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
  padding: 10px;
  gap: 8px;
}

.regulation-card {
  background-color: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 14px;
  cursor: pointer;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
}

.regulation-card:hover {
  background-color: var(--bg-card-hover);
  border-color: var(--border-subtle);
  transform: translateY(-2px);
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.35);
}

.regulation-card.selected {
  border-color: var(--accent-purple);
  background-color: rgba(139, 92, 246, 0.08);
  box-shadow: 0 0 16px rgba(139, 92, 246, 0.15);
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
  background-color: var(--source-blue-bg);
  padding: 3px 8px;
  border-radius: 4px;
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
  transition: color 0.15s ease, transform 0.15s ease;
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
  background-color: rgba(255, 255, 255, 0.01);
  transition: all 0.2s ease;
}

.feed-view-all:hover {
  background-color: rgba(255, 255, 255, 0.04);
  color: var(--text-primary);
}

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
  background-color: var(--risk-critical-bg);
  color: var(--risk-critical);
  border: 1px solid rgba(239, 68, 68, 0.35);
}

.risk-medium {
  background-color: var(--risk-medium-bg);
  color: var(--risk-medium);
  border: 1px solid rgba(245, 158, 11, 0.35);
}

.risk-low {
  background-color: var(--risk-low-bg);
  color: var(--risk-low);
  border: 1px solid rgba(16, 185, 129, 0.35);
}

.panel-viewer {
  background-color: var(--bg-panel);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.viewer-header {
  padding: 16px 20px;
  border-bottom: 1px solid var(--border-color);
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 16px;
  background-color: rgba(255, 255, 255, 0.01);
}

.viewer-title-row {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 6px;
  flex-wrap: wrap;
}

.viewer-title {
  font-size: 14.5px;
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

.viewer-tabs {
  display: flex;
  border-bottom: 1px solid var(--border-color);
  padding: 0 16px;
  background-color: rgba(0, 0, 0, 0.2);
  overflow-x: auto;
  scrollbar-width: none;
}
.viewer-tabs::-webkit-scrollbar {
  display: none;
}

.viewer-tab-btn {
  padding: 12px 16px;
  font-size: 12px;
  color: var(--text-secondary);
  border-bottom: 2px solid transparent;
  white-space: nowrap;
  font-weight: 500;
  transition: all 0.2s ease;
}

.viewer-tab-btn:hover {
  color: var(--text-primary);
}

.viewer-tab-btn.active {
  color: #ffffff;
  border-bottom-color: var(--accent-purple);
  font-weight: 600;
}

.viewer-body {
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 24px;
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
  transform: translateX(2px);
}

.article-card {
  background-color: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  padding: 14px;
  margin-bottom: 10px;
  transition: all 0.2s ease;
}

.article-card:hover {
  border-color: var(--border-subtle);
  background-color: var(--bg-card-hover);
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

.analysis-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}

.analysis-card {
  background: linear-gradient(180deg, #131526 0%, #10121f 100%);
  border: 1px solid rgba(139, 92, 246, 0.25);
  border-radius: var(--radius-md);
  padding: 14px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  transition: all 0.25s ease;
}

.analysis-card:hover {
  border-color: var(--accent-purple);
  box-shadow: 0 4px 18px rgba(139, 92, 246, 0.15);
  transform: translateY(-2px);
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
  gap: 8px;
  margin-bottom: 16px;
}

.analysis-item-row {
  display: flex;
  align-items: flex-start;
  gap: 7px;
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
  transform: translateX(2px);
}

.entities-grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 10px;
}

.entity-card {
  background-color: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  padding: 12px;
  display: flex;
  flex-direction: column;
  transition: all 0.2s ease;
}

.entity-card:hover {
  border-color: var(--border-subtle);
  transform: translateY(-2px);
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
  background-color: rgba(255, 255, 255, 0.02);
}

.entity-btn:hover {
  background-color: rgba(255, 255, 255, 0.08);
  color: #fff;
  border-color: var(--border-subtle);
}

.modal-overlay {
  position: fixed;
  inset: 0;
  background-color: rgba(0, 0, 0, 0.75);
  backdrop-filter: blur(4px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
  padding: 16px;
  animation: fadeIn 0.2s ease-out;
}

.modal-dialog {
  background-color: #121622;
  border: 1px solid var(--border-subtle);
  border-radius: var(--radius-lg);
  width: 100%;
  max-width: 520px;
  box-shadow: 0 16px 40px rgba(0, 0, 0, 0.6);
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
  background-color: var(--bg-input);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  color: #ffffff;
  outline: none;
}

.form-input:focus, .form-textarea:focus, .form-select:focus {
  border-color: var(--accent-purple);
  box-shadow: 0 0 0 2px rgba(139, 92, 246, 0.2);
}

.btn-primary {
  background-color: var(--accent-purple);
  color: #ffffff;
  padding: 8px 16px;
  border-radius: var(--radius-sm);
  font-size: 12px;
  font-weight: 600;
  box-shadow: 0 2px 8px rgba(139, 92, 246, 0.3);
}

.btn-primary:hover {
  background-color: var(--accent-purple-hover);
}

.btn-secondary {
  background-color: rgba(255, 255, 255, 0.05);
  color: var(--text-secondary);
  padding: 8px 16px;
  border-radius: var(--radius-sm);
  font-size: 12px;
  border: 1px solid var(--border-color);
}

.btn-secondary:hover {
  background-color: rgba(255, 255, 255, 0.1);
  color: #fff;
}
FILE_EOF

# 4. Update src/styles/responsive.css
cat << 'FILE_EOF' > src/styles/responsive.css
@media (max-width: 1240px) {
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

@media (max-width: 960px) {
  .sidebar {
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
    transform: translateX(-100%);
    box-shadow: 4px 0 24px rgba(0, 0, 0, 0.6);
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
    padding: 0 12px;
  }

  .breadcrumb {
    display: none;
  }

  .dashboard-content {
    padding: 12px 12px 32px;
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

# 5. Update src/components/layout/Header.jsx
cat << 'FILE_EOF' > src/components/layout/Header.jsx
import React from 'react';
import { Sparkles, Bell, Settings, HelpCircle, Menu } from 'lucide-react';

export default function Header({ onOpenCopilot, onOpenSettings, onOpenNotifications, onToggleSidebar }) {
  return (
    <header className="top-header">
      <div className="header-left">
        <button 
          className="mobile-menu-btn" 
          onClick={onToggleSidebar}
          aria-label="Toggle navigation menu"
        >
          <Menu size={20} />
        </button>

        <div className="breadcrumb">
          <span>Dashboard</span>
          <span>/</span>
          <span className="current">AI Regulatory Intelligence Layer</span>
        </div>
      </div>

      <div className="header-actions">
        <button className="btn-copilot" onClick={onOpenCopilot}>
          <Sparkles size={13} />
          <span>Ask Copilot</span>
        </button>

        <button className="header-icon-btn" onClick={onOpenNotifications} title="Notifications">
          <Bell size={16} />
        </button>

        <button className="header-icon-btn" onClick={onOpenSettings} title="Settings">
          <Settings size={16} />
        </button>

        <button className="header-icon-btn" title="Help">
          <HelpCircle size={16} />
        </button>
      </div>
    </header>
  );
}
FILE_EOF

# 6. Update src/App.jsx
cat << 'FILE_EOF' > src/App.jsx
import React, { useState, useEffect } from 'react';
import Sidebar from './components/layout/Sidebar';
import Header from './components/layout/Header';
import QuickActionDrawer from './components/layout/QuickActionDrawer';
import KPICardsRow from './components/dashboard/KPICardsRow';
import GlobalRegulationsFeed from './components/dashboard/GlobalRegulationsFeed';
import RegulationViewer from './components/dashboard/RegulationViewer';
import AskCopilotModal from './components/modals/AskCopilotModal';
import { WorkflowModal, AddEntityModal } from './components/modals/QuickActionModals';
import DetailListModal from './components/modals/DetailListModal';
import { regulationService } from './services/regulationService';

export default function App() {
  const [regulations, setRegulations] = useState([]);
  const [selectedRegulation, setSelectedRegulation] = useState(null);
  const [analysisData, setAnalysisData] = useState(null);
  const [entitiesData, setEntitiesData] = useState([]);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  const [isCopilotOpen, setIsCopilotOpen] = useState(false);
  const [isWorkflowOpen, setIsWorkflowOpen] = useState(false);
  const [isAddEntityOpen, setIsAddEntityOpen] = useState(false);
  const [detailModal, setDetailModal] = useState({ open: false, title: '', items: [] });

  useEffect(() => {
    async function loadData() {
      try {
        const regs = await regulationService.getRegulations();
        setRegulations(regs);
        if (regs.length > 0) {
          setSelectedRegulation(regs[0]);
          const [analysis, entities] = await Promise.all([
            regulationService.getAnalysisByRegulationId(regs[0].id),
            regulationService.getImpactedEntities(regs[0].id)
          ]);
          setAnalysisData(analysis);
          setEntitiesData(entities);
        }
      } catch (err) {
        console.error("Failed to load initial data", err);
      }
    }
    loadData();
  }, []);

  const handleSelectRegulation = async (reg) => {
    setSelectedRegulation(reg);
    try {
      const [analysis, entities] = await Promise.all([
        regulationService.getAnalysisByRegulationId(reg.id),
        regulationService.getImpactedEntities(reg.id)
      ]);
      setAnalysisData(analysis);
      setEntitiesData(entities);
    } catch (err) {
      console.error(err);
    }
  };

  const handleToggleBookmark = (id) => {
    setRegulations(prev => prev.map(item => 
      item.id === id ? { ...item, bookmarked: !item.bookmarked } : item
    ));
  };

  const handleQuickAction = async (actionType, payload) => {
    if (actionType === 'uploadFile') {
      alert(`Contract / Document uploaded: "${payload}". File queued for AI compliance parsing.`);
    } else if (actionType === 'createWorkflow') {
      setIsWorkflowOpen(true);
    } else if (actionType === 'addEntity') {
      setIsAddEntityOpen(true);
    } else if (actionType === 'runScan') {
      const confirmed = window.confirm("Initiate real-time compliance scan across active regulatory feeds?");
      if (confirmed) {
        const scanRes = await regulationService.runComplianceScan();
        alert(`Compliance Scan Completed! Score: ${scanRes.score}% (${scanRes.issuesDetected} findings logged).`);
      }
    } else if (actionType === 'generateReport') {
      alert("Executive Regulatory Impact Report (PDF) exported successfully.");
    } else if (actionType === 'moreActions') {
      alert("Additional compliance tools: Policy Differ, Hash Verifier, Sandbox Engine.");
    }
  };

  return (
    <div className="app-container">
      <div 
        className={`sidebar-overlay ${mobileMenuOpen ? 'active' : ''}`} 
        onClick={() => setMobileMenuOpen(false)} 
      />

      <div className={`sidebar ${mobileMenuOpen ? 'mobile-open' : ''}`}>
        <Sidebar onSelectNav={() => setMobileMenuOpen(false)} />
      </div>

      <div className="main-wrapper">
        <Header 
          onToggleSidebar={() => setMobileMenuOpen(prev => !prev)}
          onOpenCopilot={() => setIsCopilotOpen(true)}
          onOpenSettings={() => alert("Settings panel will connect to NestJS configuration.")}
          onOpenNotifications={() => alert("0 unread alerts: All systems compliant.")}
        />

        <main className="dashboard-content">
          <QuickActionDrawer onAction={handleQuickAction} />

          <div className="dashboard-heading-area">
            <h1 className="dashboard-title">AI Regulatory Intelligence Layer</h1>
            <p className="dashboard-subtext">
              Track spend, applications, and hires across all job channels. Identify wasteful spend and optimize budget.
            </p>
          </div>

          <KPICardsRow />

          <div className="dashboard-grid">
            <GlobalRegulationsFeed 
              regulations={regulations}
              selectedId={selectedRegulation?.id}
              onSelectRegulation={handleSelectRegulation}
              onToggleBookmark={handleToggleBookmark}
              onViewAll={() => alert("All 12,842 regulations loaded in repository.")}
            />

            <RegulationViewer 
              regulation={selectedRegulation}
              analysisData={analysisData}
              entitiesData={entitiesData}
              onOpenAnalysisModal={(title, items) => setDetailModal({ open: true, title, items })}
              onOpenEntityModal={(entity) => setDetailModal({ open: true, title: `Impacted ${entity.type}`, items: entity.items })}
            />
          </div>
        </main>
      </div>

      <AskCopilotModal 
        isOpen={isCopilotOpen} 
        onClose={() => setIsCopilotOpen(false)} 
      />
      <WorkflowModal 
        isOpen={isWorkflowOpen} 
        onClose={() => setIsWorkflowOpen(false)} 
      />
      <AddEntityModal 
        isOpen={isAddEntityOpen} 
        onClose={() => setIsAddEntityOpen(false)} 
      />
      <DetailListModal 
        isOpen={detailModal.open}
        onClose={() => setDetailModal({ open: false, title: '', items: [] })}
        title={detailModal.title}
        items={detailModal.items}
      />
    </div>
  );
}
FILE_EOF

# 7. Git commit, push, and deploy to GitHub Pages
git add .
git commit -m "style: responsive design, animations and enhanced ui/ux" || true
git push origin main
npm run deploy

echo "✅ Successfully updated code, pushed to GitHub, and deployed to GitHub Pages!"
