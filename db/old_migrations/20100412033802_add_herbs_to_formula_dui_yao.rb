class AddHerbsToFormulaDuiYao < ActiveRecord::Migration
  def self.up
    add_column :formula_dui_yaos, :herb1_id, :integer
    add_column :formula_dui_yaos, :herb2_id, :integer
  end

  def self.down
    remove_column :formula_dui_yaos, :herb1_id
    remove_column :formula_dui_yaos, :herb2_id
  end
end
