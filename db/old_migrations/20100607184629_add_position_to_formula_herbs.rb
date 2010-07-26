class AddPositionToFormulaHerbs < ActiveRecord::Migration
  def self.up
    add_column :formula_herbs, :position, :integer
  end

  def self.down
    remove_column :formula_herbs, :position
  end
end
