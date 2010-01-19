class CreateFormulaPulseQualities < ActiveRecord::Migration
  def self.up
    create_table :formula_pulse_qualities do |t|
      t.integer :formula_id
      t.integer :pulse_quality_id

      t.timestamps
    end
  end

  def self.down
    drop_table :formula_pulse_qualities
  end
end
