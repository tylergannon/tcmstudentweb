json.array!(@references_authors) do |references_author|
  json.extract! references_author, :id, :name, :slug
  json.url references_author_url(references_author, format: :json)
end
