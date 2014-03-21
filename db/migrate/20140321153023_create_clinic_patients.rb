class CreateClinicPatients < ActiveRecord::Migration
  def change
    create_table :clinic_patients do |t|
      t.string :name
      t.string :slug
      t.integer :practitioner_id, index: true

      t.timestamps
    end
  end
end
