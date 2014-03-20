class CreateTreatmentPointPrescriptions < ActiveRecord::Migration
  def change
    create_table :treatment_point_prescriptions do |t|
      t.string :name
      t.string :slug, index: true
      t.string :commentary
      t.references :citation, index: true
      t.references :pattern, index: true

      t.timestamps
    end
  end
end
