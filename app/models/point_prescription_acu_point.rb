class PointPrescriptionAcuPoint < ActiveRecord::Base
  belongs_to :point_prescription
  belongs_to :acu_point
  acts_as_linkable
  
  before_save :default_values
  
  scope :with_acu_point_abbrev, lambda{|abbrev|
    ap = AcuPoint.named(abbrev)
    id = ap.id if ap
    joins(:acu_point).where(:acu_points=>{:id=>id})
  }
  
  def default_values
    self.reason = "Primary" unless reason
  end
  
  named_association :acu_point, :abbrev
end
