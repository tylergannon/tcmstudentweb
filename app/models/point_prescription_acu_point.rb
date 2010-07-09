class PointPrescriptionAcuPoint < ActiveRecord::Base
  belongs_to :point_prescription
  belongs_to :acu_point

  def name
    acu_point_abbrev
  end
  
  named_association :acu_point, AcuPoint, :abbrev

  def key_attributes
    ["acu_point_abbrev", "commentary"]
  end
end
