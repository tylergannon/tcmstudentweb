class CreateAcuPointCategories < ActiveRecord::Migration
  def self.up
    create_table :acu_point_categories do |t|
      t.integer :acu_point_id
      t.integer :category_id
      t.integer :position
      t.text :commentary

      t.timestamps
    end
  end

  def self.down
    drop_table :acu_point_categories
  end
end

