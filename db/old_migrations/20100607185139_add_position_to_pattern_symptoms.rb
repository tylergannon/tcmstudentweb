class AddPositionToPatternSymptoms < ActiveRecord::Migration
  def self.up
    add_column :pattern_symptoms, :position, :integer
  end

  def self.down
    remove_column :pattern_symptoms, :position
  end
end
