class CreateHerbChannels < ActiveRecord::Migration
  def self.up
    create_table :herb_channels do |t|
      t.integer :herb_id
      t.integer :channel_id

      t.timestamps
    end
  end

  def self.down
    drop_table :herb_channels
  end
end
