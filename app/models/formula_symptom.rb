class FormulaSymptom < ActiveRecord::Base
	belongs_to :formula
	belongs_to :symptom

	def symptom_name=(name)
		self.symptom = Symptom.find_or_create(:name, name) unless name.blank?
	end

	def symptom_name
		symptom.name if symptom
  end

  def display_name
    if possibly
      "(possibly) #{symptom_name}"
    else
      symptom_name
    end
  end

  def key_attributes
    ["id", "symptom_name", "maybe", "key_symptom"]
  end

  def name
    symptom_name
  end

end
