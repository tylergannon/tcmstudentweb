class AddReasonToPointPrescriptionAcuPoints < ActiveRecord::Migration
  def self.up
    add_column :point_prescription_acu_points, :reason, :string
  end

  def self.down
    remove_column :point_prescription_acu_points, :reason
  end
end
