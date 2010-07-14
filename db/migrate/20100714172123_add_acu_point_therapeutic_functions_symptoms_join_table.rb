class AddAcuPointTherapeuticFunctionsSymptomsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :acu_point_therapeutic_functions_symptoms, :id => false do |t|
      t.integer :acu_point_therapeutic_function_id
      t.integer :symptom_id
    end
    add_index :acu_point_therapeutic_functions_symptoms, :symptom_id
    add_index :acu_point_therapeutic_functions_symptoms,
                :acu_point_therapeutic_function_id
  end

  def self.down
    drop_table :acu_point_therapeutic_functions_symptoms
  end
end

