class AddAbbrevToTextbook < ActiveRecord::Migration
  def self.up
    add_column :textbooks, :abbrev, :string
  end

  def self.down
    remove_column :textbooks, :abbrev
  end
end
