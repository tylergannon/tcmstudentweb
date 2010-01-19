class CreateHerbFlavors < ActiveRecord::Migration
  def self.up
    create_table :herb_flavors do |t|
      t.integer :herb_id
      t.integer :flavor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :herb_flavors
  end
end
