class CreateAcuPoints < ActiveRecord::Migration
  def self.up
    create_table :acu_points do |t|
      t.integer :channel_id
      t.integer :ordinal
      t.string :pinyin
      t.string :english
      t.string :chinese
      t.text :name_discussion
      t.text :commentary

      t.timestamps
    end
  end

  def self.down
    drop_table :acu_points
  end
end
