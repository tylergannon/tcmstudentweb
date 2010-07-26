class AddShortNameToHerbCategory < ActiveRecord::Migration
  def self.up
		add_column :herbs, :short_name, :string
		add_column :formulas, :short_name, :string
		
  end

  def self.down
		remove_column :herbs, :short_name
		remove_column :formulas, :short_name
  end
end
