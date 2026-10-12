#!/usr/bin/env bash
set -e

# 1. Fix src/App.jsx: Eliminate duplicate nested .sidebar class and ensure clean toggle
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

  // Modals & Feedback
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

  // Prevent background scroll when mobile sidebar is open
  useEffect(() => {
    if (mobileMenuOpen) {
      document.body.style.overflow = 'hidden';
    } else {
      document.body.style.overflow = '';
    }
    return () => {
      document.body.style.overflow = '';
    };
  }, [mobileMenuOpen]);

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
      {/* Mobile Drawer Overlay */}
      <div 
        className={`sidebar-overlay ${mobileMenuOpen ? 'active' : ''}`} 
        onClick={() => setMobileMenuOpen(false)} 
        aria-hidden="true"
      />

      {/* Single Sidebar Instance with correct classes */}
      <Sidebar 
        activeNav={activeNav}
        onSelectNav={(nav) => {
          setActiveNav(nav);
          setMobileMenuOpen(false);
        }}
        isCollapsed={sidebarCollapsed}
        onToggleCollapse={() => setSidebarCollapsed(prev => !prev)}
        isMobileOpen={mobileMenuOpen}
        onCloseMobile={() => setMobileMenuOpen(false)}
      />

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

      {/* Reusable Modals */}
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

      {/* Accessible Floating Toast */}
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

# 2. Fix src/components/layout/Sidebar.jsx: Support isMobileOpen and add a Mobile Close Button
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
  onToggleCollapse,
  isMobileOpen = false,
  onCloseMobile
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
    <aside className={`sidebar ${isCollapsed ? 'collapsed' : ''} ${isMobileOpen ? 'mobile-open' : ''}`}>
      <div className="sidebar-brand">
        <div className="brand-wrapper">
          <div className="brand-icon">F</div>
          {(!isCollapsed || isMobileOpen) && (
            <div>
              <div className="brand-title">Finsentsis</div>
              <div className="brand-subtitle">Operating System</div>
            </div>
          )}
        </div>
        
        {/* Desktop Collapse Button */}
        <button 
          className="sidebar-collapse-btn desktop-only" 
          onClick={onToggleCollapse}
          aria-label={isCollapsed ? "Expand sidebar" : "Collapse sidebar"}
          title={isCollapsed ? "Expand sidebar" : "Collapse sidebar"}
        >
          {isCollapsed ? <ChevronRight size={16} /> : <ChevronLeft size={16} />}
        </button>

        {/* Mobile Close Button */}
        <button 
          className="sidebar-collapse-btn mobile-close-btn" 
          onClick={onCloseMobile}
          aria-label="Close menu"
          title="Close menu"
        >
          <X size={18} />
        </button>
      </div>

      {(!isCollapsed || isMobileOpen) && (
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
          {(!isCollapsed || isMobileOpen) && <ChevronDown size={12} />}
        </div>

        {filteredNav.map((item) => {
          const Icon = item.icon;
          const isActive = activeNav === item.label;
          return (
            <div 
              key={item.label}
              className={`nav-item ${isActive ? 'active' : ''}`}
              onClick={() => onSelectNav(item.label)}
              title={isCollapsed && !isMobileOpen ? item.label : undefined}
            >
              <Icon size={16} />
              <span>{item.label}</span>
            </div>
          );
        })}

        {filteredNav.length === 0 && (!isCollapsed || isMobileOpen) && (
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

        {profileOpen && (!isCollapsed || isMobileOpen) && (
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

# 3. Fix src/styles/responsive.css: Ensure full mobile drawer visibility with proper z-index and hardware acceleration
cat << 'FILE_EOF' > src/styles/responsive.css
.mobile-close-btn {
  display: none;
}

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
  .desktop-only {
    display: none !important;
  }

  .mobile-close-btn {
    display: flex !important;
  }

  /* Force mobile sidebar drawer to cover screen from left */
  .sidebar {
    position: fixed !important;
    top: 0 !important;
    bottom: 0 !important;
    left: 0 !important;
    width: 280px !important;
    height: 100vh !important;
    z-index: 100 !important;
    background: #0a0d14 !important;
    box-shadow: 10px 0 35px rgba(0, 0, 0, 0.85) !important;
    transform: translateX(-105%) !important;
    transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1) !important;
    will-change: transform;
    overflow-y: auto !important;
  }

  .sidebar.mobile-open {
    transform: translateX(0) !important;
  }

  /* Reset collapsed rules on mobile when opened */
  .sidebar.mobile-open .brand-subtitle,
  .sidebar.mobile-open .brand-title,
  .sidebar.mobile-open .sidebar-search-container,
  .sidebar.mobile-open .nav-section-title span,
  .sidebar.mobile-open .nav-item span,
  .sidebar.mobile-open .user-details,
  .sidebar.mobile-open .user-profile-chevron {
    display: block !important;
  }

  .sidebar.mobile-open .nav-item {
    justify-content: flex-start !important;
    padding: 9px 12px !important;
  }

  .sidebar-overlay {
    display: block !important;
    position: fixed !important;
    inset: 0 !important;
    background: rgba(0, 0, 0, 0.75) !important;
    backdrop-filter: blur(4px) !important;
    z-index: 95 !important;
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.3s ease;
  }

  .sidebar-overlay.active {
    opacity: 1 !important;
    pointer-events: auto !important;
  }

  .mobile-menu-btn {
    display: flex !important;
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

# 4. Commit, Push, and Deploy
git add .
git commit -m "fix(mobile): resolve sidebar visibility and hamburger drawer toggle" || true
git push origin main
npm run deploy

echo "✅ Mobile responsive sidebar fixed and deployed to GitHub Pages!"
