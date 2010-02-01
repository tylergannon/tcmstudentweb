class MoveDuiYaoHerbsToDuiYaoTable < ActiveRecord::Migration
  def self.up
		drop_table :dui_yao_herbs
		add_column :dui_yaos, :herb1_id, :integer
		add_column :dui_yaos, :herb2_id, :integer
  end

  def self.down
		remove_column :dui_yaos, :herb1_id
		remove_column :dui_yaos, :herb2_id
		
    create_table :dui_yao_herbs do |t|
      t.integer :dui_yao_id
      t.integer :herb_id
      t.timestamps
    end		
  end
end
