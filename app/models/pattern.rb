class Pattern < ActiveRecord::Base
  has_many :pattern_treatment_principles
  accepts_nested_attributes_for :pattern_treatment_principles, :allow_destroy => true, \
    :reject_if => proc {|a| a['treatment_principle_name'].blank?}
  has_many :pattern_symptoms
  accepts_nested_attributes_for :pattern_symptoms, :allow_destroy => true, \
    :reject_if => proc {|a| a['symptom_name'].blank?}

end
