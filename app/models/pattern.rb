class Pattern < ActiveRecord::Base
  has_many :pattern_treatment_principles
  accepts_nested_attributes_for :pattern_treatment_principles, :allow_destroy => true, \
    :reject_if => proc {|a| a['treatment_principle_name'].blank?}
  has_many :pattern_symptoms
  accepts_nested_attributes_for :pattern_symptoms, :allow_destroy => true, \
    :reject_if => proc {|a| a['symptom_name'].blank?}

  belongs_to :citation
  accepts_nested_attributes_for :citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_name'].blank?}

  def pattern_symptoms_text
    FormParser.unparse_symptoms(self.pattern_symptoms)
  end

  def pattern_symptoms_text=(text)
    new_ps = FormParser.parse_symptoms(text, PatternSymptom)
    FormParser.merge(self.pattern_symptoms, new_ps)
  end

  def pattern_treatment_principles_text
    FormParser.unparse_therapeutic_functions(self.pattern_treatment_principles)
  end

  def pattern_treatment_principles_text=(text)
    new_ps = FormParser.parse_therapeutic_functions(text, PatternTreatmentPrinciple)
    FormParser.merge(self.pattern_treatment_principles, new_ps)
  end

  def key_symptoms
    self.pattern_symptoms.select{|x| x.key_symptom}
  end

  def key_attributes
    ["name", "id", "pattern_symptoms_text", "pattern_treatment_principles_text", "commentary"]
  end
end
