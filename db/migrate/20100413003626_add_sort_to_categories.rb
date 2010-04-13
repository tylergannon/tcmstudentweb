class AddSortToCategories < ActiveRecord::Migration
  def self.up
    add_column :formula_categories, :position, :integer
    add_column :herb_categories, :position, :integer
    add_column :formula_categories, :parent_category, :integer
    add_column :herb_categories, :parent_category, :integer

  end

  def self.down
    remove_column :formula_categories, :position
    remove_column :herb_categories, :position
    remove_column :formula_categories, :parent_category
    remove_column :herb_categories, :parent_category
  end
end
