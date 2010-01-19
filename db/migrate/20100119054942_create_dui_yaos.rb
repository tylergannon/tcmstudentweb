class CreateDuiYaos < ActiveRecord::Migration
  def self.up
    create_table :dui_yaos do |t|
      t.text :commentary

      t.timestamps
    end
  end

  def self.down
    drop_table :dui_yaos
  end
end
