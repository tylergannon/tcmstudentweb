class AddNeedlingToAcuPointInfos < ActiveRecord::Migration
  def self.up
    add_column :acu_point_infos, :needling, :string
  end

  def self.down
    remove_column :acu_point_infos, :needling
  end
end
