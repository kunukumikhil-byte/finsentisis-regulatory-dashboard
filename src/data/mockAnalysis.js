export const mockAnalysisData = {
  obligations: {
    count: 12,
    label: "12 Primary obligations identified",
    items: [
      "Risk Assessment and Classification",
      "Data Governance Requirements",
      "Transparency and Documentation",
      "Human Oversight Mechanism"
    ],
    fullList: [
      { id: 1, title: "Risk Assessment and Classification", severity: "High", due: "30 Days" },
      { id: 2, title: "Data Governance Requirements", severity: "High", due: "45 Days" },
      { id: 3, title: "Transparency and Documentation", severity: "Medium", due: "60 Days" },
      { id: 4, title: "Human Oversight Mechanism", severity: "High", due: "30 Days" },
      { id: 5, title: "Post-Market Monitoring Plan", severity: "Medium", due: "90 Days" },
      { id: 6, title: "Fundamental Rights Impact Assessment", severity: "Critical", due: "15 Days" }
    ]
  },
  risks: {
    count: 12,
    label: "12 Primary obligations identified",
    items: [
      "Risk Assessment and Classification",
      "Data Governance Requirements",
      "Transparency and Documentation",
      "Human Oversight Mechanism"
    ],
    fullList: [
      { id: 1, title: "Regulatory non-compliance fines up to €35M or 7% turnover", severity: "Critical" },
      { id: 2, title: "Missing technical documentation for production inference models", severity: "High" },
      { id: 3, title: "Inadequate continuous human oversight on autonomous loops", severity: "High" },
      { id: 4, title: "Vendor sub-processor data leaks under third-party contracts", severity: "Medium" }
    ]
  },
  actions: {
    count: 12,
    label: "12 Primary obligations identified",
    items: [
      "Risk Assessment and Classifica",
      "Data Governance Requirements",
      "Transparency and Documentation",
      "Human Oversight Mechanism"
    ],
    fullList: [
      { id: 1, title: "Review internal policies against EU AI Act Annex III", owner: "Legal Team" },
      { id: 2, title: "Assign compliance owners for proprietary foundational models", owner: "Chief AI Officer" },
      { id: 3, title: "Update vendor procurement clauses for high-risk AI software", owner: "Procurement" },
      { id: 4, title: "Schedule quarterly automated compliance audit scans", owner: "DevSecOps" }
    ]
  }
};
