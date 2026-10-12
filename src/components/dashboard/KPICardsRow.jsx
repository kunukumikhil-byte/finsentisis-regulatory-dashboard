import React from 'react';
import KPICard from './KPICard';

export default function KPICardsRow({ onAction }) {
  const cards = [
    { title: "Total Regulations Tracked", value: "12,842", trend: "↑ 380 VS Last Month" },
    { title: "Countries Active", value: "142", trend: "↑ 5 VS Last Month" },
    { title: "Recent Law Changes", value: "276", trend: "↑ 18 VS Last Month" },
    { title: "New Obligations Detected", value: "1,109", trend: "↑ 124 VS Last Month" },
    { title: "Regulations Confidence Level", value: "94.7", trend: "↑ High Confidence", isConfidence: true },
  ];

  return (
    <div className="kpi-row">
      {cards.map((c, i) => (
        <KPICard key={i} {...c} onAction={onAction} />
      ))}
    </div>
  );
}
