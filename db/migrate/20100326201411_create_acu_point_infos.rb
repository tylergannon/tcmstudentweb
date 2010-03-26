class CreateAcuPointInfos < ActiveRecord::Migration
  def self.up
    create_table :acu_point_infos do |t|
      t.integer :acu_point_id
      t.string :english
      t.text :commentary
      t.integer :citation_id
      t.timestamps
    end

    remove_column :acu_point_therapeutic_functions, :acu_point_id
    add_column :acu_point_therapeutic_functions, :acu_point_info_id, :integer
    remove_column :acu_point_symptoms, :acu_point_id
    add_column :acu_point_symptoms, :acu_point_info_id, :integer
    remove_column :acu_points, :citation_id
    remove_column :acu_points, :english

  end

  def self.down
    drop_table :acu_point_infos
    add_column :acu_points, :citation_id, :integer

    add_column :acu_point_therapeutic_functions, :acu_point_id, :integer
    remove_column :acu_point_therapeutic_functions, :acu_point_info_id
    add_column :acu_point_symptoms, :acu_point_id, :integer
    remove_column :acu_point_symptoms, :acu_point_info_id
    add_column :acu_points, :english, :string
  end
end
