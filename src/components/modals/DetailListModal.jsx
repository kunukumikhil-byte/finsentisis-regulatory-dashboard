import React from 'react';
import Modal from '../common/Modal';

export default function DetailListModal({ isOpen, onClose, title, items = [] }) {
  return (
    <Modal isOpen={isOpen} onClose={onClose} title={title}>
      <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
        {items.map((item, idx) => (
          <div 
            key={idx} 
            style={{ 
              background: '#181d2a', 
              padding: '10px', 
              borderRadius: '4px',
              border: '1px solid #23293a',
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center'
            }}
          >
            <div>
              <div style={{ color: '#fff', fontSize: '12px', fontWeight: 500 }}>
                {item.title || item.name}
              </div>
              {(item.due || item.status || item.owner) && (
                <div style={{ color: '#64748b', fontSize: '11px', marginTop: '2px' }}>
                  {item.due ? `Due: ${item.due}` : ''} {item.status ? `Status: ${item.status}` : ''} {item.owner ? `Owner: ${item.owner}` : ''}
                </div>
              )}
            </div>
            {item.severity && (
              <span style={{ fontSize: '10px', color: '#f87171', background: 'rgba(239,68,68,0.1)', padding: '2px 6px', borderRadius: '3px' }}>
                {item.severity}
              </span>
            )}
          </div>
        ))}
      </div>
    </Modal>
  );
}
