import React, { useState } from 'react';
import { MoreVertical } from 'lucide-react';
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

  if (!regulation) {
    return (
      <div className="panel-viewer" style={{ padding: '24px', textAlign: 'center' }}>
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
          <button className="header-icon-btn">
            <MoreVertical size={16} />
          </button>
        </div>
      </div>

      <RegulationTabs activeTab={activeTab} onSelectTab={setActiveTab} />

      <div className="viewer-body">
        {activeTab === 'Overview' && (
          <>
            <RegulationText 
              articles={regulation.articles} 
              onViewAll={() => alert("Displaying all 113 articles in expanded legal view.")} 
            />
            <AIInterpretationAnalysis 
              analysisData={analysisData} 
              onOpenModal={onOpenAnalysisModal}
            />
            <LinkedEntitiesImpacted 
              entities={entitiesData} 
              onSelectEntity={onOpenEntityModal}
            />
          </>
        )}

        {activeTab === 'Full Text' && (
          <div style={{ padding: '10px 0', color: '#94a3b8', fontSize: '12.5px' }}>
            <h4 style={{ color: '#fff', marginBottom: '8px' }}>Consolidated Full Text — {regulation.title}</h4>
            <p>Official legal text version {regulation.version} verified by {regulation.sourceAuthority}. Searchable tree view with indexed annexes and recitals enabled.</p>
          </div>
        )}

        {activeTab === 'Amendment History' && (
          <div style={{ padding: '10px 0', color: '#94a3b8', fontSize: '12.5px' }}>
            <p>• <strong>v1.0.3</strong> (Aug 2025): Realignment with harmonised European standards.</p>
            <p>• <strong>v1.0.2</strong> (Jun 2025): Clarification on General Purpose AI models.</p>
          </div>
        )}

        {activeTab === 'Jurisdiction' && (
          <div style={{ padding: '10px 0', color: '#94a3b8', fontSize: '12.5px' }}>
            <p>Direct applicability in all 27 EU Member States with extraterritorial reach for providers serving EU users.</p>
          </div>
        )}

        {activeTab === 'Related Laws' && (
          <div style={{ padding: '10px 0', color: '#94a3b8', fontSize: '12.5px' }}>
            <p>• Regulation (EU) 2016/679 (GDPR)</p>
            <p>• Regulation (EU) 2022/2065 (Digital Services Act)</p>
            <p>• Product Liability Directive 2024</p>
          </div>
        )}

        {activeTab === 'Interpretation Log' && (
          <div style={{ padding: '10px 0', color: '#94a3b8', fontSize: '12.5px' }}>
            <p>• Automated scan completed on 02 Aug 2025 with 94.7% confidence model.</p>
            <p>• Legal Ops team confirmed human oversight triggers.</p>
          </div>
        )}
      </div>
    </div>
  );
}
