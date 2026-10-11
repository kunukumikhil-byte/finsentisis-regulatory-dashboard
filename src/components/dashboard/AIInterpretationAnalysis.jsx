import React from 'react';
import AnalysisCard from './AnalysisCard';

export default function AIInterpretationAnalysis({ analysisData, onOpenModal }) {
  if (!analysisData) return null;

  return (
    <div>
      <div className="section-head-bar">
        <span className="section-head-title">AI Interpretation and Analysis</span>
      </div>

      <div className="analysis-grid">
        <AnalysisCard 
          title="Obligations Extracted"
          subtitle={analysisData.obligations.label}
          items={analysisData.obligations.items}
          onViewDetails={() => onOpenModal('Obligations Extracted', analysisData.obligations.fullList)}
        />
        <AnalysisCard 
          title="Risk Implications"
          subtitle={analysisData.risks.label}
          items={analysisData.risks.items}
          onViewDetails={() => onOpenModal('Risk Implications', analysisData.risks.fullList)}
        />
        <AnalysisCard 
          title="Required Actions"
          subtitle={analysisData.actions.label}
          items={analysisData.actions.items}
          onViewDetails={() => onOpenModal('Required Actions', analysisData.actions.fullList)}
        />
      </div>
    </div>
  );
}
