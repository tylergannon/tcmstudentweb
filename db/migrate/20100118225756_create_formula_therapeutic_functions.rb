class CreateFormulaTherapeuticFunctions < ActiveRecord::Migration
  def self.up
    create_table :formula_therapeutic_functions do |t|
      t.integer :formula_id
      t.integer :therapeutic_function_id

      t.timestamps
    end
  end

  def self.down
    drop_table :formula_therapeutic_functions
  end
end
