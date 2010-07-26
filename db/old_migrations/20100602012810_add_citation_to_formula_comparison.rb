class AddCitationToFormulaComparison < ActiveRecord::Migration
  def self.up
    add_column :formula_comparisons, :citation_id, :integer
  end

  def self.down
    remove_column :formula_comparisons, :citation_id
  end
end
