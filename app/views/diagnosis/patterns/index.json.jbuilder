json.array!(@diagnosis_patterns) do |diagnosis_pattern|
  json.extract! diagnosis_pattern, :id, :name, :commentary, :citation_id, :tongue, :pulse, :slug, :canonical
  json.url diagnosis_pattern_url(diagnosis_pattern, format: :json)
end
