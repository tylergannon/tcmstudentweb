source :in, {
  type: :database,
  target: :source,
  query: "SELECT id, channel_id, ordinal, pinyin, chinese, name_discussion, commentary, 
       canonical, slug
  FROM acu_points;"
},
[ 
  :id, :channel_id, :ordinal, :pinyin, :chinese, :name_discussion, :commentary, :canonical, :slug
]

after_read do |row|
  row[:position] = row[:ordinal]
  row
end

destination :out, {
  type: :insert_update_database,
  target: :destination,
  table: "acupuncture_points"
}, {
  order: [:id, :channel_id, :position, :pinyin, :chinese, :name_discussion, :commentary, :canonical, :slug, :created_at, :updated_at],
  primarykey: [:id],
  virtual: {
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
}
