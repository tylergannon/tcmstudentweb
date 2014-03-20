source :in, {
  type: :database,
  target: :source,
  query: 'SELECT id, pattern_id, name, commentary, citation_id, created_at, updated_at
  FROM point_prescriptions;'
},
[ 
  :id, :pattern_id, :name, :commentary, :citation_id
]

after_read do |row|
  row[:point_id] = row[:acu_point_id]
  row
end

destination :out, {
  type: :insert_update_database,
  target: :destination,
  table: "treatment_point_prescriptions"
}, {
  order: [:id, :pattern_id, :name, :commentary, :citation_id, :created_at, :updated_at],
  primarykey: [:id],
  virtual: {
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
}
