json.array!(@clinic_patients) do |clinic_patient|
  json.extract! clinic_patient, :id, :name, :slug
  json.url clinic_patient_url(clinic_patient, format: :json)
end
