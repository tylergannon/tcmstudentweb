class AddPreparationToFormulaHerbs < ActiveRecord::Migration
  def self.up
    add_column :formula_herbs, :preparation_id, :integer
  end

  def self.down
    remove_column :formula_herbs, :preparation_id
  end
end
