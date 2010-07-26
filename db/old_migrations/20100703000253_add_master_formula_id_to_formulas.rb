class AddMasterFormulaIdToFormulas < ActiveRecord::Migration
  def self.up
    add_column :formulas, :master_formula_id, :integer
  end

  def self.down
    remove_column :formulas, :master_formula_id
  end
end
