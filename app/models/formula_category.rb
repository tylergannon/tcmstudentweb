class FormulaCategory < ActiveRecord::Base
	has_many :formulas

  belongs_to :parent_category, :class_name => "FormulaCategory", :foreign_key => "parent_category_id"
  has_many :categories, :order => "position", :class_name => "FormulaCategory", :foreign_key => "parent_category_id"
  

end
