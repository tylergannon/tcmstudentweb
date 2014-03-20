source :in, {
  type: :database,
  target: :source,
  query: 'SELECT id, title, author_id, year, abbrev
  FROM textbooks;'
},
[ 
  :id, :title, :author_id, :year, :abbrev
]

after_read do |row|
  row[:abbreviation] = row[:abbrev]
  row
end

destination :out, {
  type: :insert_update_database,
  target: :destination,
  table: "references_textbooks"
}, {
  order: [:id, :title, :author_id, :year, :abbreviation, :created_at, :updated_at],
  primarykey: [:id],
  virtual: {
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
}
