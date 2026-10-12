import React from 'react';
import { motion } from 'framer-motion';

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
    <div className="viewer-tabs-wrapper">
      <div className="viewer-tabs-container" style={{ position: 'relative' }}>
        {tabs.map((tab) => {
          const isActive = activeTab === tab;
          return (
            <button
              key={tab}
              className={`viewer-tab-pill ${isActive ? 'active' : ''}`}
              onClick={() => onSelectTab(tab)}
              type="button"
              style={{ position: 'relative', zIndex: 1 }}
            >
              <span style={{ position: 'relative', zIndex: 2 }}>{tab}</span>
              {isActive && (
                <motion.div
                  layoutId="activeTabPill"
                  className="tab-pill-highlight"
                  transition={{
                    type: "spring",
                    stiffness: 450,
                    damping: 32
                  }}
                  style={{
                    position: 'absolute',
                    inset: 0,
                    borderRadius: '8px',
                    backgroundColor: 'rgba(139, 92, 246, 0.2)',
                    border: '1px solid rgba(139, 92, 246, 0.5)',
                    boxShadow: '0 4px 16px rgba(139, 92, 246, 0.3)',
                    zIndex: 1
                  }}
                />
              )}
              {isActive && (
                <motion.div
                  layoutId="activeTabUnderline"
                  transition={{
                    type: "spring",
                    stiffness: 500,
                    damping: 35
                  }}
                  style={{
                    position: 'absolute',
                    bottom: '-9px',
                    left: '20%',
                    right: '20%',
                    height: '2px',
                    backgroundColor: '#8b5cf6',
                    borderRadius: '2px',
                    boxShadow: '0 0 10px #8b5cf6',
                    zIndex: 3
                  }}
                />
              )}
            </button>
          );
        })}
      </div>
    </div>
  );
}
