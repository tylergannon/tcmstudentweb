class AcuPoint < ActiveRecord::Base
  validates_presence_of :pinyin
  has_many :acu_point_therapeutic_functions
  accepts_nested_attributes_for :acu_point_therapeutic_functions, :allow_destroy => true, :reject_if => proc {|a| a['therapeutic_function_name'.blank?]}

  has_many :acu_point_symptoms
  accepts_nested_attributes_for :acu_point_symptoms, :allow_destroy => true, :reject_if => proc {|a| a['symptom_name'.blank?]}

  def display_name
    
  end
end
