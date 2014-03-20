source :in, {
  type: :database,
  target: :source,
  query: 'SELECT id, name, commentary, created_at, updated_at, citation_id, tongue, pulse, canonical, slug
  FROM patterns;'
},
[ 
  :id, :name, :commentary, :created_at, :updated_at, :citation_id, :tongue, :pulse, :canonical, :slug
]

after_read do |row|
  row[:position] = row[:ordinal]
  row
end

destination :out, {
  type: :insert_update_database,
  target: :destination,
  table: "diagnosis_patterns"
}, {
  order: [:id, :name, :commentary, :created_at, :updated_at, :citation_id, :tongue, :pulse, :canonical, :slug, :created_at, :updated_at],
  primarykey: [:id],
  virtual: {
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
}
