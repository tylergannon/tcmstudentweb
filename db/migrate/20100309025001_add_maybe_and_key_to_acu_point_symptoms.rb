class AddMaybeAndKeyToAcuPointSymptoms < ActiveRecord::Migration
  def self.up
    add_column :acu_point_symptoms, :key_symptom, :boolean
    add_column :acu_point_symptoms, :maybe, :boolean
  end

  def self.down
    remove_column :acu_point_symptoms, :key_symptom
    remove_column :acu_point_symptoms, :maybe    
  end
end
