class FormulaContraindication < ActiveRecord::Base
	belongs_to :formula
	belongs_to :contraindication
	
	def contraindication_name=(name)
		self.contraindication = Contraindication.find_or_create_by_name(name) unless name.blank?
	end
	
	def contraindication_name
		contraindication.name if contraindication
	end
	
end
