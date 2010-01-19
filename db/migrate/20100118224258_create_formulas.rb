class CreateFormulas < ActiveRecord::Migration
  def self.up
    create_table :formulas do |t|
      t.string :pinyin
      t.string :english
      t.text :preparation
      t.text :commentary

      t.timestamps
    end
  end

  def self.down
    drop_table :formulas
  end
end
