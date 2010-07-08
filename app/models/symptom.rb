class Symptom < ActiveRecord::Base
  has_many :pattern_symptoms
  has_many :patterns, :through => :pattern_symptoms
  
  search_on :name

  def formulas
    a = []
    patterns.each do |p|
      p.formula_patterns.each do |fp|
        a << fp.formula unless a.include?(fp.formula)
      end
    end
    a
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

  def =~ (other)
    false if other.nil? || other.class != Symptom
    if name.empty? || other.name.empty?
      name == other.name
    else
      name.downcase == other.name.downcase
    end
  end

end
