class Diagnosis::PatternSymptom < ActiveRecord::Base
  belongs_to :pattern, class_name: 'Diagnosis::Pattern', foreign_key: 'pattern_id'
  belongs_to :symptom, class_name: 'Diagnosis::Symptom', foreign_key: 'symptom_id'
end
