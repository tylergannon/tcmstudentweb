source :in, {
  type: :database,
  target: :source,
  query: 'SELECT id, point_prescription_id, acu_point_id, commentary, reason
  FROM point_prescription_acu_points;'
},
[ 
  :id, :point_prescription_id, :acu_point_id, :commentary, :reason
]

after_read do |row|
  row[:point_id] = row[:acu_point_id]
  row
end

destination :out, {
  type: :insert_update_database,
  target: :destination,
  table: "treatment_point_prescription_points"
}, {
  order: [:id, :point_prescription_id, :point_id, :commentary, :reason, :created_at, :updated_at],
  primarykey: [:id],
  virtual: {
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
}
