json.array!(@acupuncture_channels) do |acupuncture_channel|
  json.extract! acupuncture_channel, :id, :name, :abbreviation
  json.url acupuncture_channel_url(acupuncture_channel, format: :json)
end
