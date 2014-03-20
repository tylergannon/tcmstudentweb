class CreateDiagnosisPatternSymptoms < ActiveRecord::Migration
  def change
    create_table :diagnosis_pattern_symptoms do |t|
      t.references :pattern, index: true
      t.references :symptom, index: true
      t.string :commentary, limit: 65500
      t.boolean :maybe
      t.boolean :key_symptom
      t.integer :position

      t.timestamps
    end
  end
end
