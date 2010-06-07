class AddPositionToAcuPointTherapeuticFunctions < ActiveRecord::Migration
  def self.up
    add_column :acu_point_therapeutic_functions, :position, :integer
  end

  def self.down
    remove_column :acu_point_therapeutic_functions, :position
  end
end
