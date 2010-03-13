class Symptom < ActiveRecord::Base
  def =~ (other)
    false if other.nil? || other.class != Symptom
    if name.empty? || other.name.empty?
      name == other.name
    else
      name.downcase == other.name.downcase
    end
  end
end
