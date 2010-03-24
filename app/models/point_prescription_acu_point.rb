class PointPrescriptionAcuPoint < ActiveRecord::Base
  belongs_to :point_prescription
  belongs_to :acu_point

  def name
    acu_point_abbrev
  end

  def acu_point_abbrev
    acu_point.abbrev if acu_point
  end

  def acu_point_abbrev=(abbrev)
    self.acu_point = AcuPoint.find_by_abbrev(abbrev) unless abbrev.blank?
  end

  def key_attributes
    ["acu_point_abbrev", "commentary"]
  end
end
