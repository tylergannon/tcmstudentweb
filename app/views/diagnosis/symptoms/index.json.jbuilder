json.array!(@diagnosis_symptoms) do |diagnosis_symptom|
  json.extract! diagnosis_symptom, :id, :name, :slug
  json.url diagnosis_symptom_url(diagnosis_symptom, format: :json)
end
