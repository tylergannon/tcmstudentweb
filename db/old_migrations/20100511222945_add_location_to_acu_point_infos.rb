class AddLocationToAcuPointInfos < ActiveRecord::Migration
  def self.up
    add_column :acu_point_infos, :location, :string
  end

  def self.down
    remove_column :acu_point_infos, :location
  end
end
