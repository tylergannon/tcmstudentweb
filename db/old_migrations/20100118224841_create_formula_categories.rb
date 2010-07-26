class CreateFormulaCategories < ActiveRecord::Migration
  def self.up
    create_table :formula_categories do |t|
      t.string :name
      t.text :commentary
      t.timestamps
    end
  end
  
  def self.down
    drop_table :formula_categories
  end
end
