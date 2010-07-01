class PointPrescription < ActiveRecord::Base
  has_many :pp_acu_points, :class_name => "PointPrescriptionAcuPoint", :dependent => :delete_all
  accepts_nested_attributes_for :pp_acu_points, :allow_destroy => true, :reject_if => proc {|a| a['acu_point'].nil?}

  has_many :acu_points, :through => :pp_acu_points

  belongs_to :citation
  accepts_nested_attributes_for :citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}

  belongs_to :pattern
  accepts_nested_attributes_for :pattern, :allow_destroy => false, :reject_if => proc {|a| a['name'].blank?}
  def point_prescription_acu_points
    pp_acu_points
  end
  
  def point_prescription_acu_points=(ppap)
    pp_acu_points = pp
  end

  def pp_acu_points_text
    FormParser.unparse_point_prescription_acu_points(pp_acu_points)
  end

  def pp_acu_points_text=(text)
    new_ps = FormParser.parse_point_prescription_acu_points(text)
    FormParser.merge(self.pp_acu_points, new_ps)
  end
end

