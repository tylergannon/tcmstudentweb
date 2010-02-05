class AddCommonNameToHerbs < ActiveRecord::Migration
  def self.up
		add_column :herbs, :common_name, :string
  end

  def self.down
		remove_column :herbs, :common_name
  end
end
