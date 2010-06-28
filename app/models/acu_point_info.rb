class AcuPointInfo < ActiveRecord::Base
  has_many :acu_point_therapeutic_functions
  accepts_nested_attributes_for :acu_point_therapeutic_functions, :allow_destroy => true, :reject_if => proc {|a| a['therapeutic_function_name'].blank?}

  has_many :acu_point_symptoms
  accepts_nested_attributes_for :acu_point_symptoms, :allow_destroy => true, :reject_if => proc {|a| a['symptom_name'].blank?}

  belongs_to :citation
  accepts_nested_attributes_for :citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}

  belongs_to :acu_point
  acts_as_cited
  def acu_point_symptoms_text
    FormParser.unparse_symptoms(acu_point_symptoms)
  end

  def acu_point_symptoms_text=(text)
    new_ps = FormParser.parse_symptoms(text, AcuPointSymptom)
    FormParser.merge(self.acu_point_symptoms, new_ps)
  end

  def acu_point_therapeutic_functions_text
    FormParser.unparse_therapeutic_functions(acu_point_therapeutic_functions)
  end

  def acu_point_therapeutic_functions_text=(text)
    new_ps = FormParser.parse_therapeutic_functions(text, AcuPointTherapeuticFunction)
    FormParser.merge(self.acu_point_therapeutic_functions, new_ps)
  end
end
