class Treatment::PointPrescription < ActiveRecord::Base
  belongs_to :citation, class: References::Citation
  belongs_to :pattern, class: Diagnosis::Pattern
  
  extend FriendlyId
  friendly_id :name, use: :slugged
end
