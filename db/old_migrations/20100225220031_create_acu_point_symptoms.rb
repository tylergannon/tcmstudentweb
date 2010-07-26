class CreateAcuPointSymptoms < ActiveRecord::Migration
  def self.up
    create_table :acu_point_symptoms do |t|
      t.integer :acu_point_id
      t.integer :symptom_id

      t.timestamps
    end
  end

  def self.down
    drop_table :acu_point_symptoms
  end
end
