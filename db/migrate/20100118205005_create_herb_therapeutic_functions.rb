class CreateHerbTherapeuticFunctions < ActiveRecord::Migration
  def self.up
    create_table :herb_therapeutic_functions do |t|
      t.integer :herb_id
      t.integer :therapeutic_function_id
      t.text :commentary

      t.timestamps
    end
  end

  def self.down
    drop_table :herb_therapeutic_functions
  end
end
