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
