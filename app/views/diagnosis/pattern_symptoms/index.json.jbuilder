json.array!(@diagnosis_pattern_symptoms) do |diagnosis_pattern_symptom|
  json.extract! diagnosis_pattern_symptom, :id, :pattern_id, :symptom_id, :commentary, :maybe, :key_symptom, :position
  json.url diagnosis_pattern_symptom_url(diagnosis_pattern_symptom, format: :json)
end
