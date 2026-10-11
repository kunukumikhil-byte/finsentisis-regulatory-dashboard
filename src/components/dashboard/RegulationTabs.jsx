import React from 'react';

export default function RegulationTabs({ activeTab, onSelectTab }) {
  const tabs = [
    "Overview",
    "Full Text",
    "Amendment History",
    "Jurisdiction",
    "Related Laws",
    "Interpretation Log"
  ];

  return (
    <div className="viewer-tabs">
      {tabs.map((tab) => (
        <button
          key={tab}
          className={`viewer-tab-btn ${activeTab === tab ? 'active' : ''}`}
          onClick={() => onSelectTab(tab)}
        >
          {tab}
        </button>
      ))}
    </div>
  );
}
