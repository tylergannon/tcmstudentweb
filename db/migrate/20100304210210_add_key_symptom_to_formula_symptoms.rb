class AddKeySymptomToFormulaSymptoms < ActiveRecord::Migration
  def self.up
    add_column :formula_symptoms, :key_symptom, :boolean
    rename_column :formula_symptoms, :possibly, :maybe
    add_column :formula_symptoms, :commentary, :text
  end

  def self.down
    remove_column :formula_symptoms, :key_symptom
    rename_column :formula_symptoms, :maybe, :possibly
    remove_column :formula_symptoms, :commentary

  end
end
