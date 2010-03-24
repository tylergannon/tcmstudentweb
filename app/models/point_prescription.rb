class PointPrescription < ActiveRecord::Base
  has_many :pp_acu_points, :class_name => "PointPrescriptionAcuPoint"
  accepts_nested_attributes_for :pp_acu_points, :allow_destroy => true, :reject_if => proc {|a| a['acu_point'].nil?}

  has_many :acu_points, :through => :pp_acu_points

  belongs_to :pattern
  accepts_nested_attributes_for :pattern, :allow_destroy => false, :reject_if => proc {|a| a['name'].blank?}

end
