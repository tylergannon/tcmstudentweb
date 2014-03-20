source :in, {
  type: :database,
  target: :source,
  query: "SELECT id, name, commentary, citation_id, tongue, 
       pulse, canonical, slug
  FROM patterns;"
},
[ 
  :id, :name, :commentary, :citation_id, :tongue, :pulse, :canonical, :slug
]

destination :out, {
  type: :insert_update_database,
  target: :destination,
  table: "diagnosis_patterns"
}, {
  order: [:id, :name, :commentary, :citation_id, :tongue, :pulse, :slug, :canonical, :created_at, :updated_at],
  primarykey: [:id],
  virtual: {
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
}
