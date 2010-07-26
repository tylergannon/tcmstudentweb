class CreateTableDuiYaosFormulas < ActiveRecord::Migration
  def self.up
    create_table :dui_yaos_formulas, :id => false, :force => true do |t|
      t.integer  "formula_id"
      t.integer  "dui_yao_id"
      t.timestamps
    end
  end

  def self.down
    drop_table :dui_yaos_formulas
  end
end
