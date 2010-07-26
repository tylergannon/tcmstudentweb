class CreateTherapeuticFunctions < ActiveRecord::Migration
  def self.up
    create_table :therapeutic_functions do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :therapeutic_functions
  end
end
