class AddTongueAndPulseToPattern < ActiveRecord::Migration
  def self.up
    add_column :patterns, :tongue, :string
    add_column :patterns, :pulse, :string

  end

  def self.down
    remove_column :patterns, :tongue
    remove_column :patterns, :pulse
  end
end
