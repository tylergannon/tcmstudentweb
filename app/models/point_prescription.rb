class PointPrescription < ActiveRecord::Base
  has_many :pp_acu_points,
    :class_name => "PointPrescriptionAcuPoint",
    :dependent => :delete_all do
    def reasons
      select{|t| t.reason}.uniq
    end
    def primary
      for_reason("Primary")
    end
    def sort_by_acu_point
      sort{|x,y| x.acu_point_id <=> y.acu_point_id}
    end
    def reason_acu_pp_points(&block)
      reasons.each do |reason|
        block.call reason, for_reason(reason)
      end
    end

    def for_reason(reason)
      select{|t| t.reason==reason}.sort{|x,y| x.acu_point_id <=> y.acu_point_id}
    end

  end

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

