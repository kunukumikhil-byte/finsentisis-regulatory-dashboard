import React from 'react';
import EntityCard from './EntityCard';

export default function LinkedEntitiesImpacted({ entities, onSelectEntity }) {
  return (
    <div>
      <div className="section-head-bar">
        <span className="section-head-title">Linked Entities Impacted</span>
      </div>

      <div className="entities-grid">
        {entities.map((ent, idx) => (
          <EntityCard 
            key={idx} 
            {...ent} 
            onClick={() => onSelectEntity(ent)}
          />
        ))}
      </div>
    </div>
  );
}
