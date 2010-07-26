class AddTemperatureToHerbs < ActiveRecord::Migration
  def self.up
    add_column :herbs, :temperature, :string
  end

  def self.down
    remove_column :herbs, :temperature
  end
end

