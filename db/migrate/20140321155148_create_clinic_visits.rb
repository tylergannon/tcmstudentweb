class CreateClinicVisits < ActiveRecord::Migration
  def change
    create_table :clinic_visits do |t|
      t.references :patient, index: true
      t.datetime :appointment_time

      t.timestamps
    end
  end
end
