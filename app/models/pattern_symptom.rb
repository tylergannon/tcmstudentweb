class PatternSymptom < ActiveRecord::Base
  belongs_to :pattern
  belongs_to :symptom

  def symptom_name
    symptom.name if symptom
  end

  def symptom_name=(sn)
    return if sn.blank?
		self.symptom = Symptom.find(:first, :conditions => ['lower(name) = ?', sn.downcase])
    unless self.symptom
      self.symptom = Symptom.create(:name => sn)
    end
  end

  def name
    symptom_name
  end


  def key_attributes
    ["id", "key_symptom", "maybe", "commentary", "symptom_name"]
  end
end
