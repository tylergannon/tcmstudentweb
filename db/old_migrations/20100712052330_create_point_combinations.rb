class CreatePointCombinations < ActiveRecord::Migration
  def self.up
    create_table :point_combinations do |t|
      t.string :name
      t.integer :citation_id
      t.integer :source_text_citation_id

      t.timestamps
    end
    
    create_table :point_combinations_symptoms, :id=>false do |t|
      t.integer :point_combination_id
      t.integer :symptom_id
    end
    create_table :acu_points_point_combinations, :id=>false do |t|
      t.integer :point_combination_id
      t.integer :acu_point_id
    end
  end

  def self.down
    drop_table :point_combinations
    drop_table :acu_points_point_combinations
    drop_table :point_combinations_symptoms
  end
end
