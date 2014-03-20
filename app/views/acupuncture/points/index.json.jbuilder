json.array!(@acupuncture_points) do |acupuncture_point|
  json.extract! acupuncture_point, :id, :channel_id, :orginal, :pinyin, :chinese, :name_discussion, :commentary, :canonical, :slug
  json.url acupuncture_point_url(acupuncture_point, format: :json)
end
