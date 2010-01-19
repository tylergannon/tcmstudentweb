class RenameHerbCategoryIdColumn < ActiveRecord::Migration
  def self.up
		rename_column :herbs, :category_id, :herb_category_id 
  end

  def self.down
		rename_column :herbs, :herb_category_id, :category_id
  end
end
