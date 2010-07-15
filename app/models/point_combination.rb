class PointCombination < ActiveRecord::Base
  anaf_habtm :acu_points, :find=>{:with_abbrev=>:abbrev}, :ar_options=>{:uniq=>true}
  anaf_habtm :symptoms, :find=>{:with_name=>:name}, :ar_options=>{:uniq=>true}
  acts_as_cited
  belongs_to :source_text_citation, :class_name=>"Citation",
              :foreign_key=>"source_text_citation_id"
  search_on :name
  accepts_nested_attributes_for :source_text_citation

  association_text :acu_points, :name=>:abbrev, :scope=>:with_abbrev
  association_text :symptoms, :name=>:name, :scope=>:with_name
end

