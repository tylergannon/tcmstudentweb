class CreateAcuPointTherapeuticFunctions < ActiveRecord::Migration
  def self.up
    create_table :acu_point_therapeutic_functions do |t|
      t.integer :acu_point_id
      t.integer :therapeutic_function_id
      t.text :commentary

      t.timestamps
    end
  end

  def self.down
    drop_table :acu_point_therapeutic_functions
  end
end
