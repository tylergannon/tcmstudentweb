class CreateHerbPreparations < ActiveRecord::Migration
  def self.up
    create_table :herb_preparations do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :herb_preparations
  end
end
