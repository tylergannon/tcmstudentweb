source :in, {
  type: :database,
  target: :source,
  query: 'SELECT id, symptom_id, pattern_id, commentary, maybe, key_symptom, created_at, 
       updated_at, "position"
  FROM pattern_symptoms;'
},
[ 
  :id, :symptom_id, :pattern_id, :commentary, :maybe, :key_symptom, :position
]

after_read do |row|
  row[:position] = row[:ordinal]
  row
end

destination :out, {
  type: :insert_update_database,
  target: :destination,
  table: "diagnosis_pattern_symptoms"
}, {
  order: [:id, :symptom_id, :pattern_id, :commentary, :maybe, :key_symptom, :position, :created_at, :updated_at],
  primarykey: [:id],
  virtual: {
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
}
