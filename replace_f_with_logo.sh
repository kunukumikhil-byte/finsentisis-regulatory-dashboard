#!/usr/bin/env bash
set -e

# 1. Create a dedicated SVG logo file in public/
cat << 'FILE_EOF' > public/logo.svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 500" width="100%" height="100%">
  <g fill="#FFFFFF">
    <!-- Head & Beak -->
    <path d="M 160 55 C 220 85 300 95 345 105 C 315 118 275 125 240 128 C 300 135 340 150 375 160 C 330 175 285 180 235 180 C 310 195 345 220 375 255 C 340 270 300 280 260 280 C 265 255 280 235 315 220 C 335 210 355 200 360 175 C 340 185 320 185 295 180 C 275 160 295 130 330 130 C 290 120 240 120 200 90 C 180 75 170 65 160 55 Z" />
    
    <!-- Eye cutout -->
    <path d="M 275 135 C 300 135 320 145 330 150 C 310 155 290 155 275 145 Z" fill="#06080d" />
    
    <!-- Main Neck Spine & Body sweep -->
    <path d="M 235 180 C 255 230 250 310 280 370 C 260 365 240 345 235 320 C 235 365 260 415 300 455 C 275 445 250 415 240 380 C 240 425 270 470 300 495 C 270 480 230 430 215 375 C 205 330 210 270 200 220 C 190 260 180 300 150 335 C 160 300 175 265 185 230 C 165 255 145 280 130 315 C 135 285 155 250 175 225 C 150 240 135 265 130 280 C 140 250 165 215 195 195 C 165 205 145 220 140 235 C 150 205 180 170 215 150 C 185 155 160 170 150 180 C 165 150 195 125 230 110 C 205 115 180 125 170 135 C 185 105 220 85 260 75 C 220 75 180 85 160 55 Z" />

    <!-- Stylized 'F' Crossbars in the throat -->
    <path d="M 275 235 C 320 235 360 235 375 235 C 365 255 340 265 275 265 Z" />
    <path d="M 275 295 C 315 295 345 295 350 295 C 340 315 320 325 275 325 Z" />

    <!-- Lower Feather Tail Flairs -->
    <path d="M 215 375 C 230 430 265 470 300 495 C 270 480 240 455 225 420 C 215 450 235 485 255 500 C 230 485 205 440 200 400 C 185 430 175 460 160 480 C 170 450 185 415 195 385 C 180 405 165 430 145 445 C 155 415 175 380 190 355 Z" />
  </g>
</svg>
FILE_EOF

# 2. Update Sidebar.jsx to replace the "F" box with the falcon logo image
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
              src="./logo.svg" 
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
FILE_EOF

# 3. Add styling in layout.css for the logo badge
cat << 'FILE_EOF' >> src/styles/layout.css

/* Logo Badge replacing the purple 'F' box */
.brand-logo-badge {
  width: 36px;
  height: 36px;
  background: #000000;
  border: 1px solid rgba(139, 92, 246, 0.4);
  border-radius: 9px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 4px;
  box-shadow: 0 0 14px rgba(139, 92, 246, 0.35);
  transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1),
              box-shadow 0.3s ease,
              border-color 0.3s ease;
  flex-shrink: 0;
}

.brand-wrapper:hover .brand-logo-badge {
  transform: translateY(-2px) scale(1.08);
  border-color: rgba(167, 139, 250, 0.8);
  box-shadow: 0 0 22px rgba(139, 92, 246, 0.65);
}

.brand-logo-img {
  width: 100%;
  height: 100%;
  object-fit: contain;
  display: block;
}
FILE_EOF

# 4. Commit, Push, and Deploy to GitHub Pages
git add .
git commit -m "feat: replace purple F with official falcon logo" || true
git push origin main
npm run deploy

echo "Logo successfully replaced and deployed to GitHub Pages!"
