import React, { useState } from 'react';
import Modal from '../common/Modal';
import { regulationService } from '../../services/regulationService';
import { Send, Bot } from 'lucide-react';

export default function AskCopilotModal({ isOpen, onClose }) {
  const [query, setQuery] = useState('');
  const [messages, setMessages] = useState([
    { sender: 'bot', text: 'Hello Sophie. I am your Autonomous Compliance Copilot. Ask me any question regarding active global regulations or impacted company policies.' }
  ]);
  const [loading, setLoading] = useState(false);

  const handleSend = async (e) => {
    e.preventDefault();
    if (!query.trim()) return;

    const userText = query;
    setMessages(prev => [...prev, { sender: 'user', text: userText }]);
    setQuery('');
    setLoading(true);

    try {
      const res = await regulationService.askCopilot(userText);
      setMessages(prev => [...prev, { sender: 'bot', text: res.answer }]);
    } catch {
      setMessages(prev => [...prev, { sender: 'bot', text: 'Error connecting to AI Copilot service.' }]);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Modal isOpen={isOpen} onClose={onClose} title="Autonomous Compliance Copilot">
      <div style={{ display: 'flex', flexDirection: 'column', gap: '12px', minHeight: '260px' }}>
        <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '8px' }}>
          {messages.map((m, i) => (
            <div 
              key={i} 
              style={{
                alignSelf: m.sender === 'user' ? 'flex-end' : 'flex-start',
                backgroundColor: m.sender === 'user' ? '#8b5cf6' : '#1e2433',
                color: '#fff',
                padding: '8px 12px',
                borderRadius: '8px',
                maxWidth: '85%',
                fontSize: '12px'
              }}
            >
              {m.sender === 'bot' && <Bot size={13} style={{ marginRight: '6px', verticalAlign: 'middle' }} />}
              {m.text}
            </div>
          ))}
          {loading && <div style={{ color: '#94a3b8', fontSize: '11px' }}>Copilot is analyzing...</div>}
        </div>

        <form onSubmit={handleSend} style={{ display: 'flex', gap: '8px', marginTop: '12px' }}>
          <input 
            type="text" 
            className="form-input" 
            placeholder="e.g. What are our high-risk obligations under Article 6?" 
            value={query}
            onChange={(e) => setQuery(e.target.value)}
          />
          <button type="submit" className="btn-primary" disabled={loading} style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
            <Send size={13} />
          </button>
        </form>
      </div>
    </Modal>
  );
}
