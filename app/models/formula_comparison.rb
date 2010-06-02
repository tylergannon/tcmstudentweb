class FormulaComparison < ActiveRecord::Base
	belongs_to :formula1, :foreign_key => "formula1_id", :class_name => "Formula"
	belongs_to :formula2, :foreign_key => "formula2_id", :class_name => "Formula"
  belongs_to :citation
  accepts_nested_attributes_for :citation, :allow_destroy => false, :reject_if => proc {|a| a['textbook_title'].blank?}

	def formula1_pinyin=(pinyin)
		self.formula1 = Formula.find_or_create_by_pinyin(pinyin) unless pinyin.blank?
	end

	def formula1_pinyin
		formula1.pinyin if formula1
	end

	def formula2_pinyin=(pinyin)
		self.formula2 = Formula.find_or_create_by_pinyin(pinyin) unless pinyin.blank?
	end

	def formula2_pinyin
		formula2.pinyin if formula2
	end

	def self.with_formula(formula)
	  find(:all, :conditions => ["formula1_id = ? or formula2_id = ? or formula3_id = ?", formula.id, formula.id, formula.id])
	end

  def other_formula(formula)
    if formula.id == formula1.id
      formula2
    else
      formula1
    end
  end
end

