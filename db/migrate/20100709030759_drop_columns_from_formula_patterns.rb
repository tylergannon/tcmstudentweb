class DropColumnsFromFormulaPatterns < ActiveRecord::Migration
  def self.up
    remove_column :formula_patterns, :id
    remove_column :formula_patterns, :commentary
    remove_column :formula_patterns, :citation
    rename_table :formula_patterns, :formulas_patterns
  end

  def self.down
  end
end
