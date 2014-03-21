json.array!(@clinic_visits) do |clinic_visit|
  json.extract! clinic_visit, :id, :patient_id, :appointment_time
  json.url clinic_visit_url(clinic_visit, format: :json)
end
