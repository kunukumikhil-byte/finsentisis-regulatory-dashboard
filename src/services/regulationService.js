import api from './api';
import { mockRegulations } from '../data/mockRegulations';
import { mockAnalysisData } from '../data/mockAnalysis';
import { mockEntitiesData } from '../data/mockEntities';

const USE_MOCK = import.meta.env.VITE_USE_MOCK_DATA !== 'false';

export const regulationService = {
  async getRegulations() {
    if (USE_MOCK) return Promise.resolve([...mockRegulations]);
    const response = await api.get('/regulations');
    return response.data;
  },

  async getRegulationById(id) {
    if (USE_MOCK) {
      const reg = mockRegulations.find((r) => r.id === id) || mockRegulations[0];
      return Promise.resolve({ ...reg });
    }
    const response = await api.get(`/regulations/${id}`);
    return response.data;
  },

  async getAnalysisByRegulationId(id) {
    if (USE_MOCK) return Promise.resolve({ ...mockAnalysisData });
    const response = await api.get(`/regulations/${id}/analysis`);
    return response.data;
  },

  async getImpactedEntities(id) {
    if (USE_MOCK) return Promise.resolve([...mockEntitiesData]);
    const response = await api.get(`/regulations/${id}/impacted-entities`);
    return response.data;
  },

  async runComplianceScan() {
    if (USE_MOCK) {
      return new Promise((resolve) => {
        setTimeout(() => {
          resolve({ status: 'completed', score: 94.7, issuesDetected: 3 });
        }, 800);
      });
    }
    const response = await api.post('/compliance/scan');
    return response.data;
  },

  async askCopilot(query) {
    if (USE_MOCK) {
      return new Promise((resolve) => {
        setTimeout(() => {
          resolve({
            answer: `Based on Article 3 of the EU AI Act, systems with autonomous decision-making in critical infrastructures fall under high-risk classification. Immediate documentation and audit logging are required.`
          });
        }, 600);
      });
    }
    const response = await api.post('/copilot/query', { query });
    return response.data;
  }
};
