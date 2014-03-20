source :in, {
  type: :database,
  target: :source,
  query: "SELECT id, name, created_at, updated_at, abbreviation, commentary
  FROM channels;"
},
[ 
  :id, :name, :commentary, :abbreviation
]

destination :out, {
  type: :insert_update_database,
  target: :destination,
  table: "acupuncture_channels"
}, {
  order: [:id, :name, :abbreviation, :created_at, :updated_at],
  primarykey: [:id],
  virtual: {
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
}
