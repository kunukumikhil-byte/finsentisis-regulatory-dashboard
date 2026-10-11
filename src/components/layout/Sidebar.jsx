import React from 'react';
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
  ChevronLeft
} from 'lucide-react';

export default function Sidebar({ activeNav = 'AI Regulatory Intelligence Layer', onSelectNav }) {
  const navItems = [
    { label: "Global Dashboard & Risk Radar", icon: Radar },
    { label: "AI Regulatory Intelligence Layer", icon: Cpu },
    { label: "Policy-to-Process Automation", icon: GitFork },
    { label: "Autonomous Compliance Copilot", icon: Bot },
    { label: "Audit-Ready Evidence & Blockchain Trail", icon: FileCheck2 },
    { label: "Consulting & Expert Marketplace", icon: Briefcase },
  ];

  return (
    <aside className="sidebar">
      <div className="sidebar-brand">
        <div className="brand-wrapper">
          <div className="brand-icon">F</div>
          <div>
            <div className="brand-title">Finsentsis</div>
            <div className="brand-subtitle">Operating System</div>
          </div>
        </div>
        <button className="sidebar-collapse-btn" aria-label="Collapse sidebar">
          <ChevronLeft size={16} />
        </button>
      </div>

      <div className="sidebar-search-container">
        <div className="sidebar-search-box">
          <Search size={14} color="#64748b" />
          <input 
            type="text" 
            placeholder="Search for anything" 
            className="sidebar-search-input" 
          />
          <span className="kbd-shortcut">/</span>
        </div>
      </div>

      <div className="sidebar-nav">
        <div className="nav-section-title">
          <span>Dashboard</span>
          <ChevronDown size={12} />
        </div>

        {navItems.map((item) => {
          const Icon = item.icon;
          const isActive = activeNav === item.label;
          return (
            <div 
              key={item.label}
              className={`nav-item ${isActive ? 'active' : ''}`}
              onClick={() => onSelectNav && onSelectNav(item.label)}
            >
              <Icon size={15} />
              <span>{item.label}</span>
            </div>
          );
        })}
      </div>

      <div className="sidebar-bottom">
        <div className="nav-item" onClick={() => onSelectNav && onSelectNav('Help and Support')}>
          <HelpCircle size={15} />
          <span>Help and Support</span>
        </div>
        <div className="nav-item" onClick={() => onSelectNav && onSelectNav('Settings')}>
          <Settings size={15} />
          <span>Settings</span>
        </div>

        <div className="user-profile" style={{ marginTop: '8px' }}>
          <div className="user-avatar">SB</div>
          <div className="user-details">
            <div className="user-name">Sophie Bennett</div>
            <div className="user-email">sophie@finsentsis.com</div>
          </div>
          <ChevronDown size={14} color="#64748b" />
        </div>
      </div>
    </aside>
  );
}
