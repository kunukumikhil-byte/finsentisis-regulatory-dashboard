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
