class PointPrescription < ActiveRecord::Base
  has_many :pp_acu_points, :class_name => "PointPrescriptionAcuPoint", :dependent => :delete_all

  has_many :acu_points, :through => :pp_acu_points
  after_save :copy_citation, :if => Proc.new {|pp| !pp.pattern.nil? && pp.pattern.citation.nil?}
  
  acts_as_cited
  
  named_association :pattern, :name, :create => true

  belongs_to :pattern
  accepts_nested_attributes_for :pattern, :allow_destroy => false, :reject_if => proc {|a| a['name'].blank?}

  def point_prescription_acu_points
    pp_acu_points
  end
  
  def point_prescription_acu_points=(ppap)
    pp_acu_points = ppap
  end
  
  association_text :pp_acu_points, :name=>:acu_point_abbrev, 
      :commentary=>:commentary, :scope=>:with_acu_point_abbrev,
      :class_name=>"PointPrescriptionAcuPoint"
  
  def copy_citation
    return if citation.nil? || pattern.nil?
    pattern.citation = citation
    pattern.save
  end
end

