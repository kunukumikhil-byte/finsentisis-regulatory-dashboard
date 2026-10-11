import React from 'react';
import { Sparkles, Bell, Settings, HelpCircle } from 'lucide-react';

export default function Header({ onOpenCopilot, onOpenSettings, onOpenNotifications }) {
  return (
    <header className="top-header">
      <div className="breadcrumb">
        <span>Dashboard</span>
        <span>/</span>
        <span className="current">AI Regulatory Intelligence Layer</span>
      </div>

      <div className="header-actions">
        <button className="btn-copilot" onClick={onOpenCopilot}>
          <Sparkles size={13} />
          <span>Ask Copilot</span>
        </button>

        <button className="header-icon-btn" onClick={onOpenNotifications} title="Notifications">
          <Bell size={15} />
        </button>

        <button className="header-icon-btn" onClick={onOpenSettings} title="Settings">
          <Settings size={15} />
        </button>

        <button className="header-icon-btn" title="Help">
          <HelpCircle size={15} />
        </button>
      </div>
    </header>
  );
}
