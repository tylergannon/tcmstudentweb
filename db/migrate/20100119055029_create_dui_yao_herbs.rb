class CreateDuiYaoHerbs < ActiveRecord::Migration
  def self.up
    create_table :dui_yao_herbs do |t|
      t.integer :dui_yao_id
      t.integer :herb_id

      t.timestamps
    end
  end

  def self.down
    drop_table :dui_yao_herbs
  end
end
