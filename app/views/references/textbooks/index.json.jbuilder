json.array!(@references_textbooks) do |references_textbook|
  json.extract! references_textbook, :id, :author_id, :title, :slug, :year, :abbreviation
  json.url references_textbook_url(references_textbook, format: :json)
end
