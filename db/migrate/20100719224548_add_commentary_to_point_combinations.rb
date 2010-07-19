class AddCommentaryToPointCombinations < ActiveRecord::Migration
  def self.up
    add_column :point_combinations, :commentary, :text
  end

  def self.down
    remove_column :point_combinations, :commentary
  end
end
