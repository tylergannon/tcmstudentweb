class CreateFormulaComparisons < ActiveRecord::Migration
  def self.up
    create_table :formula_comparisons do |t|
      t.integer :formula1_id
      t.integer :formula2_id
      t.text :formula1_commentary
      t.text :formula2_commentary
      t.text :commentary

      t.timestamps
    end
  end

  def self.down
    drop_table :formula_comparisons
  end
end
