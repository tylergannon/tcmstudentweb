class AddStateBoardToFormulasAndHerbs < ActiveRecord::Migration
  def self.up
    add_column :formulas, :state_board, :boolean
    add_column :herbs, :state_board, :boolean
  end

  def self.down
    remove_column :formulas, :state_board
    remove_column :herbs, :state_board
  end
end
