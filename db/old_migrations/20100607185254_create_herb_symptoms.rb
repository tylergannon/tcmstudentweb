class CreateHerbSymptoms < ActiveRecord::Migration
  def self.up
    create_table :herb_symptoms do |t|
      t.integer :herb_id
      t.integer :symptom_id
      t.integer :position
      t.text :commentary
      t.integer :citation_id

      t.timestamps
    end
  end

  def self.down
    drop_table :herb_symptoms
  end
end
