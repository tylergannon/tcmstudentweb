class CreateDiagnosisSymptoms < ActiveRecord::Migration
  def change
    create_table :diagnosis_symptoms do |t|
      t.string :name
      t.string :slug, index: true

      t.timestamps
    end
  end
end
