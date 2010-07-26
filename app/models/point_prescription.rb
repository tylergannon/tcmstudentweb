class PointPrescription < ActiveRecord::Base
  acts_as_cited
  after_save :copy_citation, :if => Proc.new {|pp| !pp.pattern.nil? && pp.pattern.citation.nil?}

  belongs_to :pattern
  has_many :acu_points, :through => :pp_acu_points

  named_association :pattern, :name, :create => true
  accepts_nested_attributes_for :pattern, :allow_destroy => false, :reject_if => proc {|a| a['name'].blank?}

  scope :by_acu_point, lambda {|acu_point_id|
    joins(:acu_points).where(:acu_points=>{:id=>acu_point_id})
  }

  scope :by_pattern, lambda {|pattern_id| where(:pattern_id => pattern_id)}

  association_text :pp_acu_points, :name=>:acu_point_abbrev,
      :commentary=>:commentary, :scope=>:with_acu_point_abbrev,
      :class_name=>"PointPrescriptionAcuPoint"

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
    def points_per_reason(&block)
      reasons.each do |reason|
        block.call reason, for_reason(reason)
      end
    end

    def for_point(acu_point)
      select{|t| t.acu_point == acu_point}[0]
    end

    def for_reason(reason)
      select{|t| t.reason==reason}.sort{|x,y| x.acu_point_id <=> y.acu_point_id}
    end

  end

  def point_prescription_acu_points
    pp_acu_points
  end

  def point_prescription_acu_points=(ppap)
    pp_acu_points = ppap
  end


  def copy_citation
    return if citation.nil? || pattern.nil?
    pattern.citation = citation
    pattern.save
  end
end

