class FormulaPattern < ActiveRecord::Base
	belongs_to :formula
	belongs_to :pattern
  accepts_nested_attributes_for :pattern, :allow_destroy => false, :reject_if => proc {|a| a['name'].blank?}

  def pattern_name=(name)
		self.pattern = Pattern.find_or_create_by_name(name) unless name.blank?
	end

	def pattern_name
		pattern.name if pattern
  end

end
