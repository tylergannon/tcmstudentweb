class AddCategoryToFormula < ActiveRecord::Migration
  def self.up
		add_column :formulas, :formula_category_id, :integer
  end

  def self.down
		drop_column :formulas, :formula_category_id
  end
end
