json.array!(@references_citations) do |references_citation|
  json.extract! references_citation, :id, :source_id, :location
  json.url references_citation_url(references_citation, format: :json)
end
