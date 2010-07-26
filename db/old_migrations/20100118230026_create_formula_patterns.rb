class CreateFormulaPatterns < ActiveRecord::Migration
  def self.up
    create_table :formula_patterns do |t|
      t.integer :formula_id
      t.integer :pattern_id
			t.text :commentary
      t.timestamps
    end
  end

  def self.down
    drop_table :formula_patterns
  end
end
