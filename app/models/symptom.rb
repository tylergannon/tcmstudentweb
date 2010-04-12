class Symptom < ActiveRecord::Base
  has_many :pattern_symptoms
  has_many :patterns, :through => :pattern_symptoms

  def formulas
    a = []
    patterns.each do |p|
      p.formula_patterns.each do |fp|
        a << fp.formula unless a.include?(fp.formula)
      end
    end
    a
  end

  def =~ (other)
    false if other.nil? || other.class != Symptom
    if name.empty? || other.name.empty?
      name == other.name
    else
      name.downcase == other.name.downcase
    end
  end

  def self.search_columns
    ["name"]
  end
end
