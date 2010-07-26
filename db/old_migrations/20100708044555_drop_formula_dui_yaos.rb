class DropFormulaDuiYaos < ActiveRecord::Migration
  def self.up
    drop_table :formula_dui_yaos
  end

  def self.down
    create_table "formula_dui_yaos", :force => true do |t|
      t.integer  "formula_id"
      t.integer  "dui_yao_id"
      t.text     "commentary"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "herb1_id"
      t.integer  "herb2_id"
    end
  end
end
