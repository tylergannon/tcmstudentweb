source :in, {
  type: :database,
  target: :source,
  query: 'SELECT id, name, slug
  FROM symptoms;'
},
[ 
  :id, :name, :slug
]

after_read do |row|
  row[:position] = row[:ordinal]
  row
end

destination :out, {
  type: :insert_update_database,
  target: :destination,
  table: "diagnosis_symptoms"
}, {
  order: [:id, :name, :slug, :created_at, :updated_at],
  primarykey: [:id],
  virtual: {
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
}
