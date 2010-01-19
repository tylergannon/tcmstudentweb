class FormulaPattern < ActiveRecord::Base
	belongs_to :formula
	belongs_to :pattern
	
	def pattern_name=(name)
		self.pattern = Pattern.find_or_create_by_name(name) unless name.blank?
	end
	
	def pattern_name
		pattern.name if pattern
	end
	
end
