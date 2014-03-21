class CreateClinicVisits < ActiveRecord::Migration
  def change
    create_table :clinic_visits do |t|
      t.references :patient, index: true
      t.datetime :appointment_time
      t.string :slug
      t.references :practitioner, index: true
      t.timestamps
    end
    add_index :clinic_visits, :slug
  end
end
