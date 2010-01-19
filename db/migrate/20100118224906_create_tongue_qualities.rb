class CreateTongueQualities < ActiveRecord::Migration
  def self.up
    create_table :tongue_qualities do |t|
      t.string :name
      t.text :commentary
      t.timestamps
    end
  end
  
  def self.down
    drop_table :tongue_qualities
  end
end
