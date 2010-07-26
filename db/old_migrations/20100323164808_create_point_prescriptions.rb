class CreatePointPrescriptions < ActiveRecord::Migration
  def self.up
    create_table :point_prescriptions do |t|
      t.integer :pattern_id
      t.string :name
      t.text :commentary
      t.integer :citation_id
      t.timestamps
    end
  end

  def self.down
    drop_table :point_prescriptions
  end
end
