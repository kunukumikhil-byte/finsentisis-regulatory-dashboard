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
  --bg-app: #06080d;
  --bg-sidebar: #0a0d14;
  --bg-header: rgba(10, 13, 20, 0.85);
  --bg-panel: rgba(14, 18, 28, 0.75);
  --bg-card: rgba(19, 24, 38, 0.7);
  --bg-card-hover: rgba(28, 35, 54, 0.9);
  --bg-input: rgba(15, 20, 31, 0.9);
  
  --border-color: rgba(255, 255, 255, 0.08);
  --border-subtle: rgba(255, 255, 255, 0.14);
  --border-glow: rgba(139, 92, 246, 0.45);
  
  --text-primary: #f8fafc;
  --text-secondary: #94a3b8;
  --text-muted: #64748b;
  
  --accent-purple: #8b5cf6;
  --accent-purple-hover: #7c3aed;
  --accent-purple-glow: rgba(139, 92, 246, 0.35);
  --accent-purple-dim: rgba(139, 92, 246, 0.14);

  --risk-critical: #f87171;
  --risk-critical-bg: rgba(239, 68, 68, 0.14);
  --risk-medium: #fbbf24;
  --risk-medium-bg: rgba(245, 158, 11, 0.14);
  --risk-low: #34d399;
  --risk-low-bg: rgba(16, 185, 129, 0.14);
  --source-blue: #38bdf8;
  --source-blue-bg: rgba(56, 189, 248, 0.14);

  --font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 14px;
}

body {
  font-family: var(--font-family);
  background-color: var(--bg-app);
  background-image: 
    radial-gradient(at 15% 15%, rgba(139, 92, 246, 0.08) 0px, transparent 45%),
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
  transition: background-color 0.2s cubic-bezier(0.16, 1, 0.3, 1),
              color 0.2s cubic-bezier(0.16, 1, 0.3, 1),
              border-color 0.2s cubic-bezier(0.16, 1, 0.3, 1),
              transform 0.15s ease,
              box-shadow 0.2s ease;
}

button:active {
  transform: scale(0.97);
}

button:disabled {
  opacity: 0.55;
  cursor: not-allowed;
  pointer-events: none;
}

button:focus-visible, input:focus-visible, select:focus-visible {
  outline: 2px solid var(--accent-purple);
  outline-offset: 1px;
}

input, select, textarea {
  font-family: inherit;
  font-size: 13px;
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

::-webkit-scrollbar {
  width: 5px;
  height: 5px;
}
::-webkit-scrollbar-track {
  background: transparent;
}
::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.15);
  border-radius: 4px;
}
::-webkit-scrollbar-thumb:hover {
  background: rgba(255, 255, 255, 0.25);
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(6px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes scaleIn {
  from { opacity: 0; transform: scale(0.96); }
  to { opacity: 1; transform: scale(1); }
}

@keyframes pulseGlow {
  0%, 100% { box-shadow: 0 0 10px rgba(124, 58, 237, 0.35); }
  50% { box-shadow: 0 0 20px rgba(139, 92, 246, 0.65); }
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.spinner {
  animation: spin 0.8s linear infinite;
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
  transition: width 0.25s cubic-bezier(0.16, 1, 0.3, 1), transform 0.25s cubic-bezier(0.16, 1, 0.3, 1);
}

.sidebar.collapsed {
  width: 72px;
}

.sidebar.collapsed .brand-subtitle,
.sidebar.collapsed .brand-title,
.sidebar.collapsed .sidebar-search-container,
.sidebar.collapsed .nav-section-title span,
.sidebar.collapsed .nav-item span,
.sidebar.collapsed .user-details,
.sidebar.collapsed .user-profile-chevron {
  display: none !important;
}

.sidebar.collapsed .nav-item {
  justify-content: center;
  padding: 11px 0;
}

.sidebar.collapsed .sidebar-brand {
  justify-content: center;
  padding: 18px 0;
}

.sidebar-overlay {
  display: none;
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.75);
  backdrop-filter: blur(4px);
  z-index: 45;
  animation: fadeIn 0.2s ease-out;
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
  box-shadow: 0 0 14px rgba(124, 58, 237, 0.45);
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
  display: flex;
  align-items: center;
  justify-content: center;
}

.sidebar-collapse-btn:hover {
  background: rgba(255, 255, 255, 0.06);
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
  border: 1px solid transparent;
}

.nav-item:hover {
  background: rgba(255, 255, 255, 0.05);
  color: #fff;
  transform: translateX(2px);
}

.nav-item.active {
  background: rgba(139, 92, 246, 0.12);
  color: #ddd6fe;
  font-weight: 600;
  border-color: rgba(139, 92, 246, 0.35);
  box-shadow: inset 0 0 14px rgba(139, 92, 246, 0.1);
}

.sidebar-bottom {
  padding: 12px;
  border-top: 1px solid var(--border-color);
  position: relative;
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
  flex-shrink: 0;
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

.profile-dropdown-menu {
  position: absolute;
  bottom: 60px;
  left: 12px;
  right: 12px;
  background: #151926;
  border: 1px solid var(--border-subtle);
  border-radius: var(--radius-md);
  padding: 6px;
  box-shadow: 0 10px 25px rgba(0,0,0,0.5);
  z-index: 60;
  animation: fadeIn 0.15s ease-out;
}

.profile-dropdown-item {
  padding: 8px 10px;
  font-size: 12px;
  border-radius: var(--radius-sm);
  color: var(--text-secondary);
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
}

.profile-dropdown-item:hover {
  background: rgba(255, 255, 255, 0.06);
  color: #fff;
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
  gap: 8px;
  position: relative;
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

.header-popover {
  position: absolute;
  top: 48px;
  right: 0;
  width: 290px;
  background: #131724;
  border: 1px solid var(--border-subtle);
  border-radius: var(--radius-md);
  padding: 14px;
  box-shadow: 0 14px 30px rgba(0, 0, 0, 0.6);
  z-index: 60;
  animation: fadeIn 0.2s ease-out;
}

.dashboard-content {
  padding: 20px 24px 50px;
  display: flex;
  flex-direction: column;
  gap: 18px;
  animation: fadeIn 0.3s cubic-bezier(0.16, 1, 0.3, 1);
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

# 3. Update src/styles/components.css
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
  position: relative;
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

.kpi-dropdown-menu {
  position: absolute;
  top: 36px;
  right: 12px;
  background: #161b2a;
  border: 1px solid var(--border-subtle);
  border-radius: var(--radius-md);
  padding: 6px;
  box-shadow: 0 10px 24px rgba(0, 0, 0, 0.6);
  z-index: 20;
  animation: fadeIn 0.15s ease-out;
}

.kpi-dropdown-item {
  padding: 7px 10px;
  font-size: 11.5px;
  color: var(--text-secondary);
  border-radius: var(--radius-sm);
  cursor: pointer;
  white-space: nowrap;
}
.kpi-dropdown-item:hover {
  background: rgba(255, 255, 255, 0.06);
  color: #fff;
}

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

.feed-quick-filters {
  display: flex;
  gap: 6px;
  padding: 8px 12px 0;
  overflow-x: auto;
}

.filter-pill {
  padding: 3px 9px;
  font-size: 10px;
  border-radius: 12px;
  border: 1px solid var(--border-color);
  color: var(--text-secondary);
  background: rgba(255, 255, 255, 0.02);
  font-weight: 500;
}
.filter-pill:hover {
  color: #fff;
  border-color: var(--border-subtle);
}
.filter-pill.active {
  background: var(--accent-purple-dim);
  border-color: var(--accent-purple);
  color: #ddd6fe;
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
}
.feed-view-all:hover {
  background: rgba(255, 255, 255, 0.04);
  color: #fff;
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
}
.viewer-tab-btn:hover { color: #fff; }
.viewer-tab-btn.active {
  color: #ffffff;
  border-bottom-color: var(--accent-purple);
  font-weight: 600;
}

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
  animation: fadeIn 0.2s ease-out;
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
  animation: scaleIn 0.2s cubic-bezier(0.16, 1, 0.3, 1);
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
  display: inline-flex;
  align-items: center;
  gap: 6px;
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

# 4. Update src/components/layout/Sidebar.jsx
cat << 'FILE_EOF' > src/components/layout/Sidebar.jsx
import React, { useState, useEffect, useRef } from 'react';
import { 
  Radar, 
  Cpu, 
  GitFork, 
  Bot, 
  FileCheck2, 
  Briefcase, 
  HelpCircle, 
  Settings, 
  Search,
  ChevronDown,
  ChevronLeft,
  ChevronRight,
  LogOut,
  User,
  X
} from 'lucide-react';

export default function Sidebar({ 
  activeNav, 
  onSelectNav, 
  isCollapsed = false, 
  onToggleCollapse 
}) {
  const [profileOpen, setProfileOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const searchInputRef = useRef(null);
  const profileMenuRef = useRef(null);

  const navItems = [
    { label: "Global Dashboard & Risk Radar", icon: Radar },
    { label: "AI Regulatory Intelligence Layer", icon: Cpu },
    { label: "Policy-to-Process Automation", icon: GitFork },
    { label: "Autonomous Compliance Copilot", icon: Bot },
    { label: "Audit-Ready Evidence & Blockchain Trail", icon: FileCheck2 },
    { label: "Consulting & Expert Marketplace", icon: Briefcase },
  ];

  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === '/' && document.activeElement !== searchInputRef.current) {
        e.preventDefault();
        searchInputRef.current?.focus();
      }
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, []);

  useEffect(() => {
    const handleClickOutside = (e) => {
      if (profileMenuRef.current && !profileMenuRef.current.contains(e.target)) {
        setProfileOpen(false);
      }
    };
    if (profileOpen) {
      document.addEventListener('mousedown', handleClickOutside);
    }
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, [profileOpen]);

  const filteredNav = navItems.filter((item) =>
    item.label.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <aside className={`sidebar ${isCollapsed ? 'collapsed' : ''}`}>
      <div className="sidebar-brand">
        <div className="brand-wrapper">
          <div className="brand-icon">F</div>
          {!isCollapsed && (
            <div>
              <div className="brand-title">Finsentsis</div>
              <div className="brand-subtitle">Operating System</div>
            </div>
          )}
        </div>
        <button 
          className="sidebar-collapse-btn" 
          onClick={onToggleCollapse}
          aria-label={isCollapsed ? "Expand sidebar" : "Collapse sidebar"}
          title={isCollapsed ? "Expand sidebar" : "Collapse sidebar"}
        >
          {isCollapsed ? <ChevronRight size={16} /> : <ChevronLeft size={16} />}
        </button>
      </div>

      {!isCollapsed && (
        <div className="sidebar-search-container">
          <div className="sidebar-search-box">
            <Search size={14} color="#64748b" />
            <input 
              ref={searchInputRef}
              type="text" 
              placeholder="Search navigation" 
              className="sidebar-search-input" 
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
            {searchTerm ? (
              <button onClick={() => setSearchTerm('')} aria-label="Clear navigation search">
                <X size={12} color="#94a3b8" />
              </button>
            ) : (
              <span className="kbd-shortcut">/</span>
            )}
          </div>
        </div>
      )}

      <div className="sidebar-nav">
        <div className="nav-section-title">
          <span>Dashboard</span>
          {!isCollapsed && <ChevronDown size={12} />}
        </div>

        {filteredNav.map((item) => {
          const Icon = item.icon;
          const isActive = activeNav === item.label;
          return (
            <div 
              key={item.label}
              className={`nav-item ${isActive ? 'active' : ''}`}
              onClick={() => onSelectNav(item.label)}
              title={isCollapsed ? item.label : undefined}
            >
              <Icon size={16} />
              <span>{item.label}</span>
            </div>
          );
        })}

        {filteredNav.length === 0 && !isCollapsed && (
          <div style={{ padding: '12px 10px', fontSize: '11px', color: '#64748b' }}>
            No modules found.
          </div>
        )}
      </div>

      <div className="sidebar-bottom" ref={profileMenuRef}>
        <div 
          className={`nav-item ${activeNav === 'Help and Support' ? 'active' : ''}`} 
          onClick={() => onSelectNav('Help and Support')}
          title="Help and Support"
        >
          <HelpCircle size={16} />
          <span>Help and Support</span>
        </div>
        <div 
          className={`nav-item ${activeNav === 'Settings' ? 'active' : ''}`} 
          onClick={() => onSelectNav('Settings')}
          title="Settings"
        >
          <Settings size={16} />
          <span>Settings</span>
        </div>

        {profileOpen && !isCollapsed && (
          <div className="profile-dropdown-menu">
            <div className="profile-dropdown-item" onClick={() => { setProfileOpen(false); onSelectNav('User Profile'); }}>
              <User size={13} /> View Profile
            </div>
            <div className="profile-dropdown-item" onClick={() => { setProfileOpen(false); onSelectNav('Settings'); }}>
              <Settings size={13} /> Account Settings
            </div>
            <div className="profile-dropdown-item" style={{ color: '#f87171' }} onClick={() => { setProfileOpen(false); onSelectNav('Sign Out'); }}>
              <LogOut size={13} /> Sign Out
            </div>
          </div>
        )}

        <div 
          className="user-profile" 
          style={{ marginTop: '8px' }} 
          onClick={() => setProfileOpen(prev => !prev)}
          title="Sophie Bennett (Account)"
        >
          <div className="user-avatar">SB</div>
          <div className="user-details">
            <div className="user-name">Sophie Bennett</div>
            <div className="user-email">sophie@finsentsis.com</div>
          </div>
          <ChevronDown size={14} color="#64748b" className="user-profile-chevron" />
        </div>
      </div>
    </aside>
  );
}
FILE_EOF

# 5. Update src/components/layout/Header.jsx
cat << 'FILE_EOF' > src/components/layout/Header.jsx
import React, { useState, useEffect, useRef } from 'react';
import { Sparkles, Bell, Settings, HelpCircle, Menu, CheckCircle2 } from 'lucide-react';

export default function Header({ 
  activeNav,
  onOpenCopilot, 
  onOpenSettings, 
  onToggleSidebar 
}) {
  const [notificationOpen, setNotificationOpen] = useState(false);
  const popoverRef = useRef(null);

  useEffect(() => {
    const handleClickOutside = (e) => {
      if (popoverRef.current && !popoverRef.current.contains(e.target)) {
        setNotificationOpen(false);
      }
    };
    if (notificationOpen) {
      document.addEventListener('mousedown', handleClickOutside);
    }
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, [notificationOpen]);

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
          <span className="current">{activeNav}</span>
        </div>
      </div>

      <div className="header-actions" ref={popoverRef}>
        <button className="btn-copilot" onClick={onOpenCopilot}>
          <Sparkles size={13} />
          <span>Ask Copilot</span>
        </button>

        <button 
          className="header-icon-btn" 
          onClick={() => setNotificationOpen(prev => !prev)} 
          title="Notifications"
          style={{ position: 'relative' }}
        >
          <Bell size={16} />
          <span style={{
            position: 'absolute',
            top: '4px',
            right: '4px',
            width: '6px',
            height: '6px',
            backgroundColor: '#34d399',
            borderRadius: '50%'
          }} />
        </button>

        {notificationOpen && (
          <div className="header-popover">
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '8px' }}>
              <CheckCircle2 size={16} color="#34d399" />
              <strong style={{ fontSize: '12px' }}>System Status: Operational</strong>
            </div>
            <p style={{ fontSize: '11.5px', color: '#94a3b8', lineHeight: 1.4 }}>
              Scrapers and watchdogs actively polling 142 global regulatory portals. 0 unaddressed security non-compliances.
            </p>
          </div>
        )}

        <button className="header-icon-btn" onClick={onOpenSettings} title="Settings">
          <Settings size={16} />
        </button>

        <button 
          className="header-icon-btn" 
          onClick={() => window.open('https://github.com/kunukumikhil-byte/finsentisis-regulatory-dashboard', '_blank')} 
          title="Documentation"
        >
          <HelpCircle size={16} />
        </button>
      </div>
    </header>
  );
}
FILE_EOF

# 6. Update src/components/dashboard/KPICard.jsx
cat << 'FILE_EOF' > src/components/dashboard/KPICard.jsx
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
FILE_EOF

# 7. Update src/components/dashboard/KPICardsRow.jsx
cat << 'FILE_EOF' > src/components/dashboard/KPICardsRow.jsx
import React from 'react';
import KPICard from './KPICard';

export default function KPICardsRow({ onAction }) {
  const cards = [
    { title: "Total Regulations Tracked", value: "12,842", trend: "↑ 380 VS Last Month" },
    { title: "Countries Active", value: "142", trend: "↑ 5 VS Last Month" },
    { title: "Recent Law Changes", value: "276", trend: "↑ 18 VS Last Month" },
    { title: "New Obligations Detected", value: "1,109", trend: "↑ 124 VS Last Month" },
    { title: "Regulations Confidence Level", value: "94.7", trend: "↑ High Confidence", isConfidence: true },
  ];

  return (
    <div className="kpi-row">
      {cards.map((c, i) => (
        <KPICard key={i} {...c} onAction={onAction} />
      ))}
    </div>
  );
}
FILE_EOF

# 8. Update src/components/dashboard/GlobalRegulationsFeed.jsx
cat << 'FILE_EOF' > src/components/dashboard/GlobalRegulationsFeed.jsx
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
FILE_EOF

# 9. Update src/components/dashboard/RegulationViewer.jsx
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
      <div className="panel-viewer" style={{ padding: '32px', textAlign: 'center', color: '#94a3b8' }}>
        No regulation selected.
      </div>
    );
  }

  return (
    <div className="panel-viewer">
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

      <div className="viewer-body">
        {activeTab === 'Overview' && (
          <div style={{ display: 'flex', flexDirection: 'column', gap: '24px', animation: 'fadeIn 0.25s ease' }}>
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
          <div style={{ padding: '10px 0', animation: 'fadeIn 0.25s ease' }}>
            <h4 style={{ color: '#fff', marginBottom: '8px', fontSize: '13px' }}>
              Consolidated Legal Text — {regulation.title}
            </h4>
            <p style={{ color: '#94a3b8', fontSize: '12.5px', marginBottom: '14px' }}>
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
          <div style={{ padding: '10px 0', color: '#94a3b8', fontSize: '12.5px', animation: 'fadeIn 0.25s ease' }}>
            <div className="article-card">
              <div className="article-num">Update 1.0.3 • August 2025</div>
              <div className="article-title">Realignment with Harmonised Technical Standards</div>
              <div className="article-desc">Updated conformity assessment procedures under Article 43 for high-risk biometric identification models.</div>
            </div>
            <div className="article-card">
              <div className="article-num">Update 1.0.2 • June 2025</div>
              <div className="article-title">Transparency Clarification for GPAI Models</div>
              <div className="article-desc">Systemic risk indicators codified for foundation models exceeding $10^{25}$ FLOPs training thresholds.</div>
            </div>
          </div>
        )}

        {activeTab === 'Jurisdiction' && (
          <div style={{ padding: '10px 0', color: '#94a3b8', fontSize: '12.5px', animation: 'fadeIn 0.25s ease' }}>
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
          <div style={{ padding: '10px 0', color: '#94a3b8', fontSize: '12.5px', animation: 'fadeIn 0.25s ease' }}>
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
          <div style={{ padding: '10px 0', color: '#94a3b8', fontSize: '12.5px', animation: 'fadeIn 0.25s ease' }}>
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

# 10. Update src/App.jsx
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
  const [activeNav, setActiveNav] = useState('AI Regulatory Intelligence Layer');
  const [regulations, setRegulations] = useState([]);
  const [selectedRegulation, setSelectedRegulation] = useState(null);
  const [analysisData, setAnalysisData] = useState(null);
  const [entitiesData, setEntitiesData] = useState([]);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [sidebarCollapsed, setSidebarCollapsed] = useState(false);

  const [isCopilotOpen, setIsCopilotOpen] = useState(false);
  const [isWorkflowOpen, setIsWorkflowOpen] = useState(false);
  const [isAddEntityOpen, setIsAddEntityOpen] = useState(false);
  const [detailModal, setDetailModal] = useState({ open: false, title: '', items: [] });
  const [toastMessage, setToastMessage] = useState('');

  const triggerToast = (msg) => {
    setToastMessage(msg);
    setTimeout(() => setToastMessage(''), 3200);
  };

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
    triggerToast("Regulation bookmark toggled");
  };

  const handleQuickAction = async (actionType, payload) => {
    if (actionType === 'uploadFile') {
      triggerToast(`Contract "${payload}" received for compliance scan.`);
    } else if (actionType === 'createWorkflow') {
      setIsWorkflowOpen(true);
    } else if (actionType === 'addEntity') {
      setIsAddEntityOpen(true);
    } else if (actionType === 'runScan') {
      triggerToast("AI Compliance scan initiated...");
      const scanRes = await regulationService.runComplianceScan();
      triggerToast(`Compliance scan completed: Score ${scanRes.score}% (${scanRes.issuesDetected} findings)`);
    } else if (actionType === 'generateReport') {
      triggerToast("Executive Compliance Audit (PDF) generated.");
    } else if (actionType === 'moreActions') {
      triggerToast("Policy Differ and Evidence Verifier active.");
    }
  };

  return (
    <div className="app-container">
      <div 
        className={`sidebar-overlay ${mobileMenuOpen ? 'active' : ''}`} 
        onClick={() => setMobileMenuOpen(false)} 
      />

      <div className={`sidebar ${mobileMenuOpen ? 'mobile-open' : ''} ${sidebarCollapsed ? 'collapsed' : ''}`}>
        <Sidebar 
          activeNav={activeNav}
          onSelectNav={(nav) => {
            setActiveNav(nav);
            setMobileMenuOpen(false);
          }}
          isCollapsed={sidebarCollapsed}
          onToggleCollapse={() => setSidebarCollapsed(prev => !prev)}
        />
      </div>

      <div className="main-wrapper">
        <Header 
          activeNav={activeNav}
          onToggleSidebar={() => setMobileMenuOpen(prev => !prev)}
          onOpenCopilot={() => setIsCopilotOpen(true)}
          onOpenSettings={() => triggerToast("Compliance settings configured.")}
        />

        <main className="dashboard-content">
          <QuickActionDrawer onAction={handleQuickAction} />

          <div className="dashboard-heading-area">
            <h1 className="dashboard-title">{activeNav}</h1>
            <p className="dashboard-subtext">
              Track regulations, obligations, and organizational exposure across global legal frameworks.
            </p>
          </div>

          {activeNav === 'AI Regulatory Intelligence Layer' ? (
            <>
              <KPICardsRow onAction={(metric) => triggerToast(metric)} />

              <div className="dashboard-grid">
                <GlobalRegulationsFeed 
                  regulations={regulations}
                  selectedId={selectedRegulation?.id}
                  onSelectRegulation={handleSelectRegulation}
                  onToggleBookmark={handleToggleBookmark}
                  onViewAll={() => triggerToast(`Loaded full registry of ${regulations.length} active regulations.`)}
                />

                <RegulationViewer 
                  regulation={selectedRegulation}
                  analysisData={analysisData}
                  entitiesData={entitiesData}
                  onOpenAnalysisModal={(title, items) => setDetailModal({ open: true, title, items })}
                  onOpenEntityModal={(entity) => setDetailModal({ open: true, title: `Impacted ${entity.type}`, items: entity.items })}
                />
              </div>
            </>
          ) : (
            <div style={{
              background: 'var(--bg-panel)',
              border: '1px solid var(--border-color)',
              borderRadius: 'var(--radius-md)',
              padding: '40px',
              textAlign: 'center',
              animation: 'fadeIn 0.25s ease'
            }}>
              <h2 style={{ fontSize: '18px', color: '#fff', marginBottom: '8px' }}>{activeNav} Workspace</h2>
              <p style={{ color: '#94a3b8', fontSize: '12.5px', maxWidth: '500px', margin: '0 auto 20px' }}>
                Automated continuous sync established with the core regulatory radar. Real-time updates and active monitors configured for this sub-module.
              </p>
              <button 
                className="btn-primary" 
                onClick={() => setActiveNav('AI Regulatory Intelligence Layer')}
              >
                Return to Intelligence Layer
              </button>
            </div>
          )}
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

      {toastMessage && (
        <div style={{
          position: 'fixed',
          bottom: '24px',
          right: '24px',
          background: '#161b2a',
          border: '1px solid rgba(139, 92, 246, 0.4)',
          borderRadius: '8px',
          padding: '10px 16px',
          color: '#f8fafc',
          fontSize: '12px',
          boxShadow: '0 12px 28px rgba(0,0,0,0.6)',
          zIndex: 1000,
          animation: 'fadeIn 0.2s ease'
        }}>
          {toastMessage}
        </div>
      )}
    </div>
  );
}
FILE_EOF

# 11. Git Add, Commit, Push, and Deploy
git add .
git commit -m "fix: responsive sidebar, working buttons, smooth animations, and enhanced ui/ux" || true
git push origin main
npm run deploy

echo "✅ All files updated, committed, pushed to main, and deployed to GitHub Pages!"
