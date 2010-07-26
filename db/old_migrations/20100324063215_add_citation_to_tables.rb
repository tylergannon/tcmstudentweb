class AddCitationToTables < ActiveRecord::Migration
  def self.up
    add_column :formula_patterns, :citation_id, :integer
  end

  def self.down
    remove_column :formula_patterns, :citation_id
  end
end
