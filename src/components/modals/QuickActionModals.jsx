import React, { useState } from 'react';
import Modal from '../common/Modal';

export function WorkflowModal({ isOpen, onClose }) {
  const [name, setName] = useState('');
  const [trigger, setTrigger] = useState('New Regulation Enacted');

  const handleSubmit = (e) => {
    e.preventDefault();
    alert(`Workflow "${name}" created successfully with trigger: ${trigger}`);
    onClose();
  };

  return (
    <Modal 
      isOpen={isOpen} 
      onClose={onClose} 
      title="Create Compliance Workflow"
      footer={
        <>
          <button className="btn-secondary" onClick={onClose}>Cancel</button>
          <button className="btn-primary" onClick={handleSubmit}>Create</button>
        </>
      }
    >
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label className="form-label">Workflow Name</label>
          <input 
            type="text" 
            required 
            className="form-input" 
            value={name} 
            onChange={(e) => setName(e.target.value)}
            placeholder="e.g. EU AI Act Policy Review Loop"
          />
        </div>
        <div className="form-group">
          <label className="form-label">Trigger Condition</label>
          <select className="form-select" value={trigger} onChange={(e) => setTrigger(e.target.value)}>
            <option>New Regulation Enacted</option>
            <option>Risk Threshold Exceeded</option>
            <option>Vendor Contract Amendment</option>
          </select>
        </div>
      </form>
    </Modal>
  );
}

export function AddEntityModal({ isOpen, onClose }) {
  const [entityName, setEntityName] = useState('');
  const [type, setType] = useState('Employee');

  const handleSubmit = (e) => {
    e.preventDefault();
    alert(`Entity "${entityName}" (${type}) added successfully.`);
    onClose();
  };

  return (
    <Modal 
      isOpen={isOpen} 
      onClose={onClose} 
      title="Add Entity or Employee"
      footer={
        <>
          <button className="btn-secondary" onClick={onClose}>Cancel</button>
          <button className="btn-primary" onClick={handleSubmit}>Add Entity</button>
        </>
      }
    >
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label className="form-label">Type</label>
          <select className="form-select" value={type} onChange={(e) => setType(e.target.value)}>
            <option>Employee</option>
            <option>Contract</option>
            <option>Asset</option>
            <option>Vendor</option>
          </select>
        </div>
        <div className="form-group">
          <label className="form-label">Identifier / Name</label>
          <input 
            type="text" 
            required 
            className="form-input" 
            value={entityName} 
            onChange={(e) => setEntityName(e.target.value)}
            placeholder="e.g. Lead ML Compliance Auditor"
          />
        </div>
      </form>
    </Modal>
  );
}
