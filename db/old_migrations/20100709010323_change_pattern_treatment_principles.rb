class ChangePatternTreatmentPrinciples < ActiveRecord::Migration
  def self.up
    remove_column :pattern_treatment_principles, :id
    remove_column :pattern_treatment_principles, :commentary
    rename_table :pattern_treatment_principles, :patterns_therapeutic_functions
  end

  def self.down
  end
end
