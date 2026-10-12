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
