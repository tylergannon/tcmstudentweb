class Treatment::PointPrescriptionPoint < ActiveRecord::Base
  belongs_to :point_prescription, class: Treatment::PointPrescription, foreign_key: 'point_prescription_id'
  belongs_to :point, class: Acupuncture::Point, foreign_key: 'point_id'
  
end
