class ChangeFormulaPatternsToHabtm < ActiveRecord::Migration
  def self.up
#    remove_column :formula_patterns, :id
#    remove_column :formula_patterns, :commentary
#    remove_column :formula_patterns, :citation
#    rename_table :formula_patterns, :formulas_patterns


    drop_table :herb_preparations
    drop_table :pulse_qualities
    drop_table :tongue_qualities
    drop_table :diseases
    drop_table :flavors
    drop_table :formula_categories
    drop_table :formula_pulse_qualities
    drop_table :formula_symptoms
    drop_table :formula_tongue_qualities
    drop_table :herb_channels
    
  end

  def self.down
  end
end
