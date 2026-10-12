import React from 'react';
import { Sparkles, Bell, Settings, HelpCircle, Menu } from 'lucide-react';

export default function Header({ onOpenCopilot, onOpenSettings, onOpenNotifications, onToggleSidebar }) {
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
          <span className="current">AI Regulatory Intelligence Layer</span>
        </div>
      </div>

      <div className="header-actions">
        <button className="btn-copilot" onClick={onOpenCopilot}>
          <Sparkles size={13} />
          <span>Ask Copilot</span>
        </button>

        <button className="header-icon-btn" onClick={onOpenNotifications} title="Notifications">
          <Bell size={16} />
        </button>

        <button className="header-icon-btn" onClick={onOpenSettings} title="Settings">
          <Settings size={16} />
        </button>

        <button className="header-icon-btn" title="Help">
          <HelpCircle size={16} />
        </button>
      </div>
    </header>
  );
}
