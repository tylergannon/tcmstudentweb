json.array!(@patterns) do |pattern|
  json.extract! pattern, :id, :name, :commentary, :citation_id, :tongue, :pulse, :slug, :canonical
  json.url pattern_url(pattern, format: :json)
end
