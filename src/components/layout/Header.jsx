import React, { useState, useEffect, useRef } from 'react';
import { Sparkles, Bell, Settings, HelpCircle, Menu, CheckCircle2 } from 'lucide-react';

export default function Header({ 
  activeNav,
  onOpenCopilot, 
  onOpenSettings, 
  onToggleSidebar 
}) {
  const [notificationOpen, setNotificationOpen] = useState(false);
  const popoverRef = useRef(null);

  useEffect(() => {
    const handleClickOutside = (e) => {
      if (popoverRef.current && !popoverRef.current.contains(e.target)) {
        setNotificationOpen(false);
      }
    };
    if (notificationOpen) {
      document.addEventListener('mousedown', handleClickOutside);
    }
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, [notificationOpen]);

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
          <span className="current">{activeNav}</span>
        </div>
      </div>

      <div className="header-actions" ref={popoverRef}>
        <button className="btn-copilot" onClick={onOpenCopilot}>
          <Sparkles size={13} />
          <span>Ask Copilot</span>
        </button>

        <button 
          className="header-icon-btn" 
          onClick={() => setNotificationOpen(prev => !prev)} 
          title="Notifications"
          style={{ position: 'relative' }}
        >
          <Bell size={16} />
          <span style={{
            position: 'absolute',
            top: '4px',
            right: '4px',
            width: '6px',
            height: '6px',
            backgroundColor: '#34d399',
            borderRadius: '50%'
          }} />
        </button>

        {notificationOpen && (
          <div className="header-popover">
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '8px' }}>
              <CheckCircle2 size={16} color="#34d399" />
              <strong style={{ fontSize: '12px' }}>System Status: Operational</strong>
            </div>
            <p style={{ fontSize: '11.5px', color: '#94a3b8', lineHeight: 1.4 }}>
              Scrapers and watchdogs actively polling 142 global regulatory portals. 0 unaddressed security non-compliances.
            </p>
          </div>
        )}

        <button className="header-icon-btn" onClick={onOpenSettings} title="Settings">
          <Settings size={16} />
        </button>

        <button 
          className="header-icon-btn" 
          onClick={() => window.open('https://github.com/kunukumikhil-byte/finsentisis-regulatory-dashboard', '_blank')} 
          title="Documentation"
        >
          <HelpCircle size={16} />
        </button>
      </div>
    </header>
  );
}
