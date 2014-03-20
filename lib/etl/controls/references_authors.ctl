source :in, {
  type: :database,
  target: :source,
  query: 'SELECT id, name
  FROM authors;'
},
[ 
  :id, :name
]

destination :out, {
  type: :insert_update_database,
  target: :destination,
  table: "references_authors"
}, {
  order: [:id, :name, :created_at, :updated_at],
  primarykey: [:id],
  virtual: {
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
}
