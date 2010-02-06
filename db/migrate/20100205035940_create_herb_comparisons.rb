class CreateHerbComparisons < ActiveRecord::Migration
  def self.up
    create_table :herb_comparisons do |t|
      t.integer :herb1_id
      t.integer :herb2_id
      t.integer :herb3_id
      t.text :herb1_commentary
      t.text :herb2_commentary
      t.text :herb3_commentary
      t.text :commentary

      t.timestamps
    end
  end

  def self.down
    drop_table :herb_comparisons
  end
end
