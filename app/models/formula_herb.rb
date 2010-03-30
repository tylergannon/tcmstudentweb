class FormulaHerb < ActiveRecord::Base
	belongs_to :formula
	belongs_to :herb
	belongs_to :formula_role

	def herb_pinyin=(pinyin)
    return if pinyin.blank
    a = Herb.search(pinyin, :first)
    raise "Could not find herb #{pinyin}" unless a
    self.herb = a
	end

	def herb_pinyin
		herb.pinyin if herb
	end

	def formula_role_pinyin=(pinyin)
		self.formula_role = FormulaRole.find_or_create_by_pinyin(pinyin) unless pinyin.blank?
	end

	def formula_role_pinyin
		formula_role.pinyin if formula_role
	end
end
