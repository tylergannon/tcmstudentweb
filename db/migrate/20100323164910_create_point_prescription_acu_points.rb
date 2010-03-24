class CreatePointPrescriptionAcuPoints < ActiveRecord::Migration
  def self.up
    create_table :point_prescription_acu_points do |t|
      t.integer :point_prescription_id
      t.integer :acu_poin_id
      t.text :commentary

      t.timestamps
    end
  end

  def self.down
    drop_table :point_prescription_acu_points
  end
end
