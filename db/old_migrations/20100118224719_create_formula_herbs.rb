class CreateFormulaHerbs < ActiveRecord::Migration
  def self.up
    create_table :formula_herbs do |t|
      t.integer :formula_id
      t.integer :herb_id
      t.integer :formula_role_id
      t.string :dose
      t.text :commentary

      t.timestamps
    end
  end

  def self.down
    drop_table :formula_herbs
  end
end