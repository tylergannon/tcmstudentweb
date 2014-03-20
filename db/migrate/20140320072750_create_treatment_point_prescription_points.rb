class CreateTreatmentPointPrescriptionPoints < ActiveRecord::Migration
  def change
    create_table :treatment_point_prescription_points do |t|
      t.references :point_prescription
      t.references :point
      t.string :reason
      t.string :commentary, limit: 65500

      t.timestamps
    end
    add_index :treatment_point_prescription_points, :point_prescription_id, name: 'index_point_prescription_pp_id'
    add_index :treatment_point_prescription_points, :point_id, name: 'index_point_prescription_point_id'
  end
end
