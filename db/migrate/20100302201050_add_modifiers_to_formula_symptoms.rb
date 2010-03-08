class AddModifiersToFormulaSymptoms < ActiveRecord::Migration
  def self.up
    add_column :formula_symptoms, :possibly, :boolean
  end

  def self.down
    remove_column :formula_symptoms, :possibly
  end
end
