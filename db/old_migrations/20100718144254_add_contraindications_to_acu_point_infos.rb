class AddContraindicationsToAcuPointInfos < ActiveRecord::Migration
  def self.up
    add_column :acu_point_infos, :contraindications, :string
  end

  def self.down
    remove_column :acu_point_infos, :contraindications
  end
end
