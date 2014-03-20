class CreateDiagnosisPatterns < ActiveRecord::Migration
  def change
    create_table :diagnosis_patterns do |t|
      t.string :name
      t.string :commentary
      t.integer :citation_id
      t.string :tongue
      t.string :pulse
      t.string :slug, index: true
      t.string :canonical

      t.timestamps
    end
  end
end
