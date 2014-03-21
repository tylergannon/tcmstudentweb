class CreateClinicPatients < ActiveRecord::Migration
  def change
    create_table :clinic_patients do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
