class PatternSymptom < ActiveRecord::Base
  belongs_to :pattern
  belongs_to :symptom
  acts_as_linkable :partial => 'symptoms/object_symptom', :object_name => 'object_symptom'

  default_scope order("position")

  named_association :symptom, :name, :create=>true
  scope :with_symptom_name, lambda{|name| joins(:symptom).where(
    :symptoms=>{:name=> name}
  )}

#  scope :key_symptoms, where(:key_symptom=>true)

  require 'decorations'
  include TcmStudentWeb::Decorations
end

