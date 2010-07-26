class CreatePulseQualities < ActiveRecord::Migration
  def self.up
    create_table :pulse_qualities do |t|
      t.string :name
      t.text :commentary
      t.timestamps
    end
  end
  
  def self.down
    drop_table :pulse_qualities
  end
end
