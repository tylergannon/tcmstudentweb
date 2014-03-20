json.array!(@treatment_point_prescription_points) do |treatment_point_prescription_point|
  json.extract! treatment_point_prescription_point, :id, :point_prescription_id, :point_id, :reason, :commentary
  json.url treatment_point_prescription_point_url(treatment_point_prescription_point, format: :json)
end
