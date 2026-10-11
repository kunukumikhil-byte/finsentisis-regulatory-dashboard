# Finsentsis — AI Regulatory Intelligence Layer Frontend

A dark enterprise SaaS dashboard matching the production specifications for monitoring government regulations, compliance risk obligations, and impacted business entities.

## 🛠 Prerequisites
- Node.js >= 18.x
- npm >= 9.x

## 🚀 Installation & Running

1. **Install dependencies:**
   \`\`\`bash
   npm install
   \`\`\`

2. **Configure environment:**
   Create a \`.env\` file from \`.env.example\`:
   \`\`\`bash
   cp .env.example .env
   \`\`\`

3. **Start local development server:**
   \`\`\`bash
   npm run dev
   \`\`\`
   The dashboard runs at \`http://localhost:5173\`.

## ⚙️ Mock Mode vs NestJS Backend Integration

- **Mock Mode (Default):** Set \`VITE_USE_MOCK_DATA=true\` in \`.env\`. The frontend operates standalone without requiring the NestJS backend or PostgreSQL.
- **Backend Mode:** Set \`VITE_USE_MOCK_DATA=false\` and provide your NestJS endpoint via \`VITE_API_BASE_URL=http://localhost:3000/api\`.
