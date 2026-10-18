#!/usr/bin/env bash
set -e

# 1. Create a dedicated React Logo Component with the exact Phoenix/Falcon vector silhouette
mkdir -p src/components/common
cat << 'FILE_EOF' > src/components/common/FinsentsisLogo.jsx
import React from 'react';

export default function FinsentsisLogo({ size = 32, className = '' }) {
  return (
    <svg 
      width={size} 
      height={size} 
      viewBox="0 0 100 100" 
      fill="none" 
      xmlns="http://www.w3.org/2000/svg"
      className={`finsentsis-brand-logo ${className}`}
      style={{ display: 'block', flexShrink: 0 }}
      aria-label="Finsentsis Logo"
    >
      <path 
        d="M33 7C38 15 50 16 68 17C61 20 54 21 42 22C34 23 30 21 28 18C31 24 37 28 47 29C40 31 34 30 29 28C33 34 40 37 45 37C39 39 33 38 27 35C29 42 36 47 43 47C35 49 29 46 27 43C28 50 35 55 42 55C32 57 26 53 26 52C28 62 38 68 42 70C35 70 31 67 31 65C35 75 46 80 49 81C43 80 39 76 39 74C45 83 55 87 60 93C53 87 49 84 46 76C48 78 52 82 59 84C55 79 51 74 46 68C48 70 54 74 61 74C56 66 52 62 48 56C51 61 57 66 64 66C59 58 55 53 49 46C56 46 66 46 75 37C63 37 55 44 49 44C51 38 53 32 58 27C67 27 73 24 75 22C73 27 67 31 60 32C64 30 65 25 61 21C59 23 55 21 55 21C61 17 67 18 69 17C59 15 48 14 33 7Z" 
        fill="currentColor"
      />
      {/* Central horizontal emblem bars forming the stylized 'F' */}
      <path 
        d="M55 37.5C62 37.5 70 37.5 75 37.5C73 40 68 41.5 55 41.5V37.5Z" 
        fill="currentColor" 
      />
      <path 
        d="M55 47.5C61 47.5 67 47.5 70 47.5C68 50.5 64 52 56 52V47.5Z" 
        fill="currentColor" 
      />
    </svg>
  );
}
FILE_EOF

# 2. Update Sidebar.jsx to display the brand logo with glowing hover mechanics
cat << 'FILE_EOF' > src/components/layout/Sidebar.jsx
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
import FinsentsisLogo from '../common/FinsentsisLogo';

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
        <div className="brand-wrapper" onClick={() => onSelectNav('AI Regulatory Intelligence Layer')} style={{ cursor: 'pointer' }}>
          <div className="brand-logo-container" title="Finsentsis OS">
            <FinsentsisLogo size={28} className="brand-svg" />
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
FILE_EOF

# 3. Add styling for the new emblem container in layout.css
cat << 'FILE_EOF' >> src/styles/layout.css

/* Brand Falcon/Phoenix Logo Styles */
.brand-logo-container {
  width: 36px;
  height: 36px;
  background: radial-gradient(circle at 30% 30%, #1e1b4b 0%, #0a0d14 100%);
  border: 1px solid rgba(139, 92, 246, 0.35);
  border-radius: 9px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #ffffff;
  box-shadow: 0 0 15px rgba(139, 92, 246, 0.25);
  transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1),
              box-shadow 0.3s ease,
              border-color 0.3s ease;
  flex-shrink: 0;
}

.brand-wrapper:hover .brand-logo-container {
  transform: translateY(-2px) scale(1.05);
  border-color: rgba(167, 139, 250, 0.7);
  box-shadow: 0 0 22px rgba(139, 92, 246, 0.55);
  color: #f5f3ff;
}

.brand-svg {
  filter: drop-shadow(0 1px 2px rgba(0, 0, 0, 0.5));
  transition: filter 0.25s ease;
}

.brand-wrapper:hover .brand-svg {
  filter: drop-shadow(0 0 6px rgba(167, 139, 250, 0.8));
}
FILE_EOF

# 4. Save as browser favicon
mkdir -p public
cat << 'FILE_EOF' > public/favicon.svg
<svg width="64" height="64" viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect width="100" height="100" rx="20" fill="#0A0D14"/>
  <path d="M33 7C38 15 50 16 68 17C61 20 54 21 42 22C34 23 30 21 28 18C31 24 37 28 47 29C40 31 34 30 29 28C33 34 40 37 45 37C39 39 33 38 27 35C29 42 36 47 43 47C35 49 29 46 27 43C28 50 35 55 42 55C32 57 26 53 26 52C28 62 38 68 42 70C35 70 31 67 31 65C35 75 46 80 49 81C43 80 39 76 39 74C45 83 55 87 60 93C53 87 49 84 46 76C48 78 52 82 59 84C55 79 51 74 46 68C48 70 54 74 61 74C56 66 52 62 48 56C51 61 57 66 64 66C59 58 55 53 49 46C56 46 66 46 75 37C63 37 55 44 49 44C51 38 53 32 58 27C67 27 73 24 75 22C73 27 67 31 60 32C64 30 65 25 61 21C59 23 55 21 55 21C61 17 67 18 69 17C59 15 48 14 33 7Z" fill="#FFFFFF"/>
  <path d="M55 37.5C62 37.5 70 37.5 75 37.5C73 40 68 41.5 55 41.5V37.5Z" fill="#FFFFFF"/>
  <path d="M55 47.5C61 47.5 67 47.5 70 47.5C68 50.5 64 52 56 52V47.5Z" fill="#FFFFFF"/>
</svg>
FILE_EOF

# 5. Commit, push and deploy
git add .
git commit -m "feat(branding): integrate official falcon emblem vector logo and favicon" || true
git push origin main
npm run deploy

echo "🦅 Official Finsentsis logo integrated and deployed to GitHub Pages!"
