class CreateFormulaDuiYaos < ActiveRecord::Migration
  def self.up
    create_table :formula_dui_yaos do |t|
      t.integer :formula_id
      t.integer :dui_yao_id
      t.text :commentary

      t.timestamps
    end
  end

  def self.down
    drop_table :formula_dui_yaos
  end
end
