class Diagnosis::Symptom < ActiveRecord::Base
  has_many :pattern_symptoms, class_name: 'Diagnosis::PatternSymptom', foreign_key: 'symptom_id'
  has_many :patterns, through: :pattern_symptoms
end
