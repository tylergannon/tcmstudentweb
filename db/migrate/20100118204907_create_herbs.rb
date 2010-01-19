class CreateHerbs < ActiveRecord::Migration
  def self.up
    create_table :herbs do |t|
			t.integer :category_id
      t.string :pinyin
      t.string :english
      t.string :latin
      t.text :commentary
			t.text :contraindications
      t.timestamps
    end
  end

  def self.down
    drop_table :herbs
  end
end
