class FormulaComparison < ActiveRecord::Base
	belongs_to :formula1, :foreign_key => "formula1_id", :class_name => "Formula"
	belongs_to :formula2, :foreign_key => "formula2_id", :class_name => "Formula"
	acts_as_cited
	
	named_association :formula1, :pinyin, :create => true, :class_name => "Formula"
	named_association :formula2, :pinyin, :create => true, :class_name => "Formula"
	
	scope :with_formula, lambda{ |formula|
	  where(["formula1_id = ? or formula2_id = ?", formula.id, formula.id])
	}

  def other_formula(formula)
    if formula.id == formula1.id
      formula2
    else
      formula1
    end
  end
end

