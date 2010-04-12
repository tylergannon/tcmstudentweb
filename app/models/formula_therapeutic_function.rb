class FormulaTherapeuticFunction < ActiveRecord::Base
	belongs_to :formula
	belongs_to :therapeutic_function

	def therapeutic_function_name=(name)
		self.therapeutic_function = TherapeuticFunction.find_or_create(:name, name) unless name.blank?
	end

	def therapeutic_function_name
		therapeutic_function.name if therapeutic_function
  end

  def key_attributes
    ["id", "therapeutic_function_name"]
  end

  def name
    therapeutic_function_name
  end
end
