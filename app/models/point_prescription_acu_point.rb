class PointPrescriptionAcuPoint < ActiveRecord::Base
  belongs_to :point_prescription
  belongs_to :acu_point
  acts_as_linkable
  
  named_association :acu_point, :abbrev
end
