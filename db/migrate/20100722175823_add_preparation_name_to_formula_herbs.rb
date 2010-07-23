class AddPreparationNameToFormulaHerbs < ActiveRecord::Migration
  def self.up
    add_column :formula_herbs, :preparation_name, :string
  end

  def self.down
    remove_column :formula_herbs, :preparation_name
  end
end
