class CreateTextbooks < ActiveRecord::Migration
  def self.up
    create_table :textbooks do |t|
      t.string :title
      t.integer :author_id
      t.integer :year

      t.timestamps
    end
  end

  def self.down
    drop_table :textbooks
  end
end
