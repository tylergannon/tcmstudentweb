class AcuPointSymptom < ActiveRecord::Base
  belongs_to :acu_point
  belongs_to :symptom
  acts_as_linkable :partial => 'symptoms/object_symptom', :object_name => 'object_symptom'
  scope :with_symptom_name, lambda {|name|
    s = Symptom.named(name)
    id = s.id if s
    joins(:symptom).where(:symptoms=>{:id=>id})
  }
  named_association :symptom, :name, :create => true 
end
