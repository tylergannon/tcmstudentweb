source :in, {
  type: :database,
  target: :source,
  query: 'SELECT id, textbook_id, "where"
  FROM citations;'
},
[ 
  :id, :textbook_id, :where
]

after_read do |row|
  row[:location] = row[:where]
  row[:source_id] = row[:textbook_id]
  row
end

destination :out, {
  type: :insert_update_database,
  target: :destination,
  table: "references_citations"
}, {
  order: [:id, :source_id, :location, :created_at, :updated_at],
  primarykey: [:id],
  virtual: {
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
}
