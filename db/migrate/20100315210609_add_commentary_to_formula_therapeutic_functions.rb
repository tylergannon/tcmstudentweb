class AddCommentaryToFormulaTherapeuticFunctions < ActiveRecord::Migration
  def self.up
    add_column :formula_therapeutic_functions, :commentary, :text
  end

  def self.down
    remove_column :formula_therapeutic_functions, :commentary
  end
end
