import React, { useState, useEffect, useRef } from 'react';
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
  ChevronLeft,
  ChevronRight,
  LogOut,
  User,
  X
} from 'lucide-react';

export default function Sidebar({ 
  activeNav, 
  onSelectNav, 
  isCollapsed = false, 
  onToggleCollapse,
  isMobileOpen = false,
  onCloseMobile
}) {
  const [profileOpen, setProfileOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const searchInputRef = useRef(null);
  const profileMenuRef = useRef(null);

  const navItems = [
    { label: "Global Dashboard & Risk Radar", icon: Radar },
    { label: "AI Regulatory Intelligence Layer", icon: Cpu },
    { label: "Policy-to-Process Automation", icon: GitFork },
    { label: "Autonomous Compliance Copilot", icon: Bot },
    { label: "Audit-Ready Evidence & Blockchain Trail", icon: FileCheck2 },
    { label: "Consulting & Expert Marketplace", icon: Briefcase },
  ];

  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === '/' && document.activeElement !== searchInputRef.current) {
        e.preventDefault();
        searchInputRef.current?.focus();
      }
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, []);

  useEffect(() => {
    const handleClickOutside = (e) => {
      if (profileMenuRef.current && !profileMenuRef.current.contains(e.target)) {
        setProfileOpen(false);
      }
    };
    if (profileOpen) {
      document.addEventListener('mousedown', handleClickOutside);
    }
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, [profileOpen]);

  const filteredNav = navItems.filter((item) =>
    item.label.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <aside className={`sidebar ${isCollapsed ? 'collapsed' : ''} ${isMobileOpen ? 'mobile-open' : ''}`}>
      <div className="sidebar-brand">
        <div 
          className="brand-wrapper" 
          onClick={() => onSelectNav('AI Regulatory Intelligence Layer')}
          style={{ cursor: 'pointer' }}
        >
          {/* Logo replaces the purple "F" box */}
          <div className="brand-logo-badge" title="Finsentsis">
            <img 
              src={`${import.meta.env.BASE_URL}logo.svg`} 
              alt="Finsentsis Logo" 
              className="brand-logo-img" 
            />
          </div>
          
          {(!isCollapsed || isMobileOpen) && (
            <div>
              <div className="brand-title">Finsentsis</div>
              <div className="brand-subtitle">Operating System</div>
            </div>
          )}
        </div>
        
        {/* Desktop Collapse Button */}
        <button 
          className="sidebar-collapse-btn desktop-only" 
          onClick={onToggleCollapse}
          aria-label={isCollapsed ? "Expand sidebar" : "Collapse sidebar"}
          title={isCollapsed ? "Expand sidebar" : "Collapse sidebar"}
        >
          {isCollapsed ? <ChevronRight size={16} /> : <ChevronLeft size={16} />}
        </button>

        {/* Mobile Close Button */}
        <button 
          className="sidebar-collapse-btn mobile-close-btn" 
          onClick={onCloseMobile}
          aria-label="Close menu"
          title="Close menu"
        >
          <X size={18} />
        </button>
      </div>

      {(!isCollapsed || isMobileOpen) && (
        <div className="sidebar-search-container">
          <div className="sidebar-search-box">
            <Search size={14} color="#64748b" />
            <input 
              ref={searchInputRef}
              type="text" 
              placeholder="Search navigation" 
              className="sidebar-search-input" 
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
            {searchTerm ? (
              <button onClick={() => setSearchTerm('')} aria-label="Clear navigation search">
                <X size={12} color="#94a3b8" />
              </button>
            ) : (
              <span className="kbd-shortcut">/</span>
            )}
          </div>
        </div>
      )}

      <div className="sidebar-nav">
        <div className="nav-section-title">
          <span>Dashboard</span>
          {(!isCollapsed || isMobileOpen) && <ChevronDown size={12} />}
        </div>

        {filteredNav.map((item) => {
          const Icon = item.icon;
          const isActive = activeNav === item.label;
          return (
            <div 
              key={item.label}
              className={`nav-item ${isActive ? 'active' : ''}`}
              onClick={() => onSelectNav(item.label)}
              title={isCollapsed && !isMobileOpen ? item.label : undefined}
            >
              <Icon size={16} />
              <span>{item.label}</span>
            </div>
          );
        })}

        {filteredNav.length === 0 && (!isCollapsed || isMobileOpen) && (
          <div style={{ padding: '12px 10px', fontSize: '11px', color: '#64748b' }}>
            No modules found.
          </div>
        )}
      </div>

      <div className="sidebar-bottom" ref={profileMenuRef}>
        <div 
          className={`nav-item ${activeNav === 'Help and Support' ? 'active' : ''}`} 
          onClick={() => onSelectNav('Help and Support')}
          title="Help and Support"
        >
          <HelpCircle size={16} />
          <span>Help and Support</span>
        </div>
        <div 
          className={`nav-item ${activeNav === 'Settings' ? 'active' : ''}`} 
          onClick={() => onSelectNav('Settings')}
          title="Settings"
        >
          <Settings size={16} />
          <span>Settings</span>
        </div>

        {profileOpen && (!isCollapsed || isMobileOpen) && (
          <div className="profile-dropdown-menu">
            <div className="profile-dropdown-item" onClick={() => { setProfileOpen(false); onSelectNav('User Profile'); }}>
              <User size={13} /> View Profile
            </div>
            <div className="profile-dropdown-item" onClick={() => { setProfileOpen(false); onSelectNav('Settings'); }}>
              <Settings size={13} /> Account Settings
            </div>
            <div className="profile-dropdown-item" style={{ color: '#f87171' }} onClick={() => { setProfileOpen(false); onSelectNav('Sign Out'); }}>
              <LogOut size={13} /> Sign Out
            </div>
          </div>
        )}

        <div 
          className="user-profile" 
          style={{ marginTop: '8px' }} 
          onClick={() => setProfileOpen(prev => !prev)}
          title="Sophie Bennett (Account)"
        >
          <div className="user-avatar">SB</div>
          <div className="user-details">
            <div className="user-name">Sophie Bennett</div>
            <div className="user-email">sophie@finsentsis.com</div>
          </div>
          <ChevronDown size={14} color="#64748b" className="user-profile-chevron" />
        </div>
      </div>
    </aside>
  );
}
