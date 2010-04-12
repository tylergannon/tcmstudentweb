class FormulaPattern < ActiveRecord::Base
	belongs_to :formula
  accepts_nested_attributes_for :formula, :allow_destroy => false, :reject_if => proc {|a| a['pinyin'].blank?}

  belongs_to :pattern
  accepts_nested_attributes_for :pattern, :allow_destroy => false, :reject_if => proc {|a| a['name'].blank?}
  belongs_to :citation
  accepts_nested_attributes_for :citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}

  def pattern_name=(name)
		self.pattern = Pattern.find_or_create_by_name(name) unless name.blank?
	end

	def pattern_name
		pattern.name if pattern
  end

  def formula_pinyin=(pinyin)
  	self.formula = Formula.find_or_create_by_pinyin(pinyin) unless pinyin.blank?
  end

  def formula_pinyin
  	formula.pinyin if formula
  end
end
