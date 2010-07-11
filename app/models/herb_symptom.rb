class HerbSymptom < ActiveRecord::Base
  belongs_to :herb
  belongs_to :symptom
  named_association :symptom, :name, :create => true
  acts_as_linkable :name=>:symptom_name
end
