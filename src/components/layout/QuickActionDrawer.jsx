import React, { useRef } from 'react';
import { Upload, GitCommit, UserPlus, Play, FileText, ChevronRight } from 'lucide-react';

export default function QuickActionDrawer({ onAction }) {
  const fileInputRef = useRef(null);

  const handleFileChange = (e) => {
    if (e.target.files && e.target.files[0]) {
      onAction('uploadFile', e.target.files[0].name);
    }
  };

  return (
    <div className="quick-action-bar">
      <span className="quick-action-label">Quick Action Drawer</span>
      
      <input 
        type="file" 
        ref={fileInputRef} 
        style={{ display: 'none' }} 
        onChange={handleFileChange}
      />

      <button className="quick-action-btn" onClick={() => fileInputRef.current.click()}>
        <Upload size={13} />
        <span>Upload Contract / Document</span>
      </button>

      <button className="quick-action-btn" onClick={() => onAction('createWorkflow')}>
        <GitCommit size={13} />
        <span>Create Workflow</span>
      </button>

      <button className="quick-action-btn" onClick={() => onAction('addEntity')}>
        <UserPlus size={13} />
        <span>Add Entity / Employee</span>
      </button>

      <button className="quick-action-btn" onClick={() => onAction('runScan')}>
        <Play size={13} />
        <span>Run AI Compliance Scan</span>
      </button>

      <button className="quick-action-btn" onClick={() => onAction('generateReport')}>
        <FileText size={13} />
        <span>Generate Reports</span>
      </button>

      <button className="quick-action-btn" onClick={() => onAction('moreActions')}>
        <ChevronRight size={13} />
      </button>
    </div>
  );
}
