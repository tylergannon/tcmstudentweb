json.array!(@treatment_point_prescriptions) do |treatment_point_prescription|
  json.extract! treatment_point_prescription, :id, :name, :slug, :commentary, :citation_id, :pattern_id
  json.url treatment_point_prescription_url(treatment_point_prescription, format: :json)
end
