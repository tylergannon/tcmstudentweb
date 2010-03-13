class CreatePatternTreatmentPrinciples < ActiveRecord::Migration
  def self.up
    create_table :pattern_treatment_principles do |t|
      t.integer :pattern_id
      t.integer :therapeutic_function_id
      t.text    :commentary
      t.timestamps
    end
  end

  def self.down
    drop_table :pattern_treatment_principles
  end
end
