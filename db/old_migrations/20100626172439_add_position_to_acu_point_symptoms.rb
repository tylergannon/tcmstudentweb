class AddPositionToAcuPointSymptoms < ActiveRecord::Migration
  def self.up
    add_column :acu_point_symptoms, :position, :integer
  end

  def self.down
    remove_column :acu_point_symptoms, :position
  end
end
