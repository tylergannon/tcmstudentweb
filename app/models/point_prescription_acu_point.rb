class PointPrescriptionAcuPoint < ActiveRecord::Base
  belongs_to :point_prescription
  belongs_to :acu_point
  acts_as_linkable
  
  before_save :default_values
  
  def default_values
    self.reason = "Primary" unless reason
  end
  
  named_association :acu_point, :abbrev
end
