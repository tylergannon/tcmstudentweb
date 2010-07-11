class AcuPointSymptom < ActiveRecord::Base
  belongs_to :acu_point
  belongs_to :symptom
  acts_as_linkable :partial => 'symptoms/object_symptom', :object_name => 'object_symptom'

  named_association :symptom, :name, :create => true 
end
