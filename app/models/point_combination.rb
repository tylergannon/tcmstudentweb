class PointCombination < ActiveRecord::Base
  anaf_habtm :acu_points, :find=>{:with_abbrev=>:abbrev}, :ar_options=>{:uniq=>true}
  anaf_habtm :symptoms, :find=>{:with_name=>:name}, :ar_options=>{:uniq=>true}
  acts_as_cited
  belongs_to :source_text_citation, :class_name=>"Citation",
              :foreign_key=>"source_text_citation_id"
  search_on :name
  accepts_nested_attributes_for :source_text_citation
  scope :by_acu_point, lambda {|acu_point_id|
    joins(:acu_points).where(:acu_points=>{:id=>acu_point_id})
  }

  INCLUDE_ALL = [:symptoms, :acu_points]

  scope :by_symptom, lambda {|symptom_id|
    joins(:symptoms).where(:symptoms=>{:id=>symptom_id})
  }

  simple_association_text :acu_points, :find_by=>:abbrev, :delim=>','
  simple_association_text :symptoms, :find_by=>:name, :create=>true, :delim=>','
  attr_accessor :acu_point_id
#  before_save :check_acu_point_id

#  def check_acu_point_id
#    self.acu_points << AcuPoint.find(acu_point_id) if acu_point_id
#  end
end

