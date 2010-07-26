class AddChineseToFormulasAndHerbs < ActiveRecord::Migration
  def self.up
		add_column :formulas, :chinese, :string
		add_column :herbs, :chinese, :string
  end

  def self.down
		drop_column :formulas, :chinese
		drop_column :herbs, :chinese
		
  end
end
