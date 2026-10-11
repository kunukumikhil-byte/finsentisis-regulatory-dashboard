export const mockEntitiesData = [
  {
    type: "Contracts",
    count: 18,
    description: "Contracts require review.",
    actionText: "View contract",
    items: [
      { name: "SaaS Enterprise Licensing Agreement — EMEA", id: "CNT-8821" },
      { name: "Vendor Data Processing Addendum (Cloud Provider)", id: "CNT-9014" },
      { name: "External AI Subcontractor Master Agreement", id: "CNT-3302" }
    ]
  },
  {
    type: "Employees",
    count: 245,
    description: "Employees may affected.",
    actionText: "View contract",
    items: [
      { name: "Engineering / ML Research Division", count: 120 },
      { name: "Legal & Regulatory Compliance Unit", count: 35 },
      { name: "Product & Automated Operations", count: 90 }
    ]
  },
  {
    type: "Assets",
    count: 32,
    description: "AI Assets in scope",
    actionText: "View contract",
    items: [
      { name: "Customer Risk Scoring Neural Model v4", id: "AST-01" },
      { name: "Automated Resourcing Pipeline v2", id: "AST-02" },
      { name: "Synthetic Dataset Storage Cluster", id: "AST-03" }
    ]
  },
  {
    type: "Vendors",
    count: 14,
    description: "Vendors req. assessments",
    actionText: "View contract",
    items: [
      { name: "VectorDB Managed Cloud Infrastructure", status: "Audit Pending" },
      { name: "External Data Annotation Vendor Ltd", status: "Review Required" },
      { name: "Third-Party LLM Gateway Provider", status: "Compliant" }
    ]
  },
  {
    type: "Policies",
    count: 12,
    description: "Company internal SOPs",
    actionText: "View contract",
    items: [
      { name: "Responsible AI Development Standard Operating Procedure" },
      { name: "Enterprise Customer Data Processing Policy" },
      { name: "Algorithmic Bias Testing & Verification Protocol" }
    ]
  }
];
