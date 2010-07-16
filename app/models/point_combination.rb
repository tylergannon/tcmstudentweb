class PointCombination < ActiveRecord::Base
  anaf_habtm :acu_points, :find=>{:with_abbrev=>:abbrev}, :ar_options=>{:uniq=>true}
  anaf_habtm :symptoms, :find=>{:with_name=>:name}, :ar_options=>{:uniq=>true}
  acts_as_cited
  belongs_to :source_text_citation, :class_name=>"Citation",
              :foreign_key=>"source_text_citation_id"
  search_on :name
  accepts_nested_attributes_for :source_text_citation

  simple_association_text :acu_points, ','
  simple_association_text :symptoms, '\n'
end

