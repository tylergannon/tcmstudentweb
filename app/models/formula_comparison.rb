class FormulaComparison < ActiveRecord::Base
	belongs_to :formula1, :foreign_key => "formula1_id", :class_name => "Formula"
	belongs_to :formula2, :foreign_key => "formula2_id", :class_name => "Formula"
	acts_as_cited
	
	named_association :formula1, Formula, :pinyin, :create
	named_association :formula2, Formula, :pinyin, :create
	
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

