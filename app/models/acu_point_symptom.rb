class AcuPointSymptom < ActiveRecord::Base
  belongs_to :acu_point
  belongs_to :symptom

  def name
    symptom_name
  end

  def key_attributes
    ["id", "symptom_name"]
  end

  def symptom_name=(name)
    self.symptom = Symptom.find_or_create_by_name(name) unless name.blank?
  end

  def symptom_name
    symptom.name if symptom
  end
end
