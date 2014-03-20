class Diagnosis::Pattern < ActiveRecord::Base
  belongs_to :citation, class_name: 'References::Citation'
  has_many :pattern_symptoms, class_name: 'Diagnosis::PatternSymptom', foreign_key: 'pattern_id'
  has_many :symptoms, through: :pattern_symptoms
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
end
