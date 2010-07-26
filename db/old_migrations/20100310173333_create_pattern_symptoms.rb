class CreatePatternSymptoms < ActiveRecord::Migration
  def self.up
    create_table :pattern_symptoms do |t|
      t.integer :symptom_id
      t.integer :pattern_id
      t.text :commentary
      t.boolean :maybe
      t.boolean :key_symptom

      t.timestamps
    end
  end

  def self.down
    drop_table :pattern_symptoms
  end
end
