class AcuPointInfo < ActiveRecord::Base
  has_many :acu_point_therapeutic_functions
  has_many :acu_point_symptoms
  belongs_to :acu_point

  acts_as_cited

  accepts_nested_attributes_for :acu_point_symptoms, :allow_destroy => true, :reject_if => proc {|a| a['symptom_name'].blank?}
  accepts_nested_attributes_for :acu_point_therapeutic_functions, :allow_destroy => true, :reject_if => proc {|a| a['therapeutic_function_name'].blank?}

  def acu_point_symptoms_text
    StringReader.new.write_items(acu_point_symptoms) do |ps|
      [StringReader.decorate_symptom(ps), ps.commentary]
    end
  end

  def acu_point_symptoms_text=(text)
    return if text.empty?
    self.acu_point_symptoms = StringReader.new.read_items(text) do |symptom, commentary|
      aps = AcuPointSymptom.new(:commentary => commentary)
      StringReader.parse_symptom(aps, symptom)
      aps
    end
  end

  def acu_point_therapeutic_functions_text
    StringReader.new.write_items(acu_point_therapeutic_functions) do |atf|
      [atf.therapeutic_function_name, atf.commentary]
    end
  end

  def acu_point_therapeutic_functions_text=(text)
    return if text.empty?
    self.acu_point_therapeutic_functions = StringReader.new.read_items(text) do |tfn, commentary|
      AcuPointTherapeuticFunction.new(:therapeutic_function_name=>tfn, :commentary => commentary)
    end
  end
end
