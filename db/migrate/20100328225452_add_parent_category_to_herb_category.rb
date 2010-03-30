class AddParentCategoryToHerbCategory < ActiveRecord::Migration
  def self.up
    add_column :herb_categories, :parent_category_id, :integer
  end

  def self.down
    remove_column :herb_categories, :parent_category_id
  end
end
