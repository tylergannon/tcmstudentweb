class AddBenskyPageToFormulasAndHerbs < ActiveRecord::Migration
  def self.up
		add_column :formulas, :bensky_page, :integer
		add_column :herbs, :bensky_page, :integer
  end

  def self.down
		remove_column :formulas, :bensky_page
		remove_column :herbs, :bensky_page		
  end
end
