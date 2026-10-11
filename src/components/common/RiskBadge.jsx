import React from 'react';

export default function RiskBadge({ risk }) {
  const level = (risk || '').toLowerCase();
  let badgeClass = 'risk-badge ';
  
  if (level === 'critical') badgeClass += 'risk-critical';
  else if (level === 'medium') badgeClass += 'risk-medium';
  else badgeClass += 'risk-low';

  return (
    <span className={badgeClass}>
      ▶ {risk}
    </span>
  );
}
