class Symptom < ActiveRecord::Base
  has_many :pattern_symptoms
  has_many :patterns, :through => :pattern_symptoms
  has_and_belongs_to_many :acu_point_therapeutic_functions, :autosave=>false
  acts_as_linkable :name=>:name
  search_on :name

  autocomplete_format do |symptom|
    {:value=>symptom.name}
  end

  scope :search_mod, order('char_length(name)')


  def formulas
    patterns.map{|p| p.formulas.all}.uniq
  end

  def self.consolidate!(id, condemned_id)
    symptom = find(id)
    condemned = find(condemned_id)
    condemned.pattern_symptoms.each do |ps|
      ps.symptom = symptom
      ps.save
    end
    condemned.destroy
  end
end

