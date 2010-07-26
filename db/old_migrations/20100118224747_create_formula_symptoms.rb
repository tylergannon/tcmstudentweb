class CreateFormulaSymptoms < ActiveRecord::Migration
  def self.up
    create_table :formula_symptoms do |t|
      t.integer :formula_id
      t.integer :symptom_id

      t.timestamps
    end
  end

  def self.down
    drop_table :formula_symptoms
  end
end
