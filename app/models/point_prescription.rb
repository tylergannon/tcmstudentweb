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

  def pp_acu_points_text
    StringReader.new.write_items(pp_acu_points) do |ppap|
      [ppap.acu_point_abbrev, ppap.commentary]
    end
  end

  def pp_acu_points_text=(text)
    return if text.empty?
    logger.error "Called with " + text
    self.pp_acu_points = StringReader.new.read_items(text) do |abbrev, commentary|
      logger.error "StringReader got abbrev: #{abbrev}"
      acu_point = AcuPoint.named(abbrev)
      ppap = self.pp_acu_points.where(:acu_point_id => acu_point.id).first
      ppap = ppap ||= PointPrescriptionAcuPoint.new(:acu_point_abbrev=>abbrev)
      ppap.commentary = commentary unless commentary.empty?
      ppap unless ppap	.acu_point.nil?
    end
    save
  end
  
  def copy_citation
    return if citation.nil? || pattern.nil?
    pattern.citation = citation
    pattern.save
  end
end

