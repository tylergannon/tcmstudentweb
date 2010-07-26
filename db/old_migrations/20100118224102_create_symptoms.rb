class CreateSymptoms < ActiveRecord::Migration
  def self.up
    create_table :symptoms do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :symptoms
  end
end
