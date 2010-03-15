class AddCitationToFormulaHerbAndAcuPoint < ActiveRecord::Migration
  def self.up
    add_column :formulas, :citation_id, :integer
    add_column :formulas, :source_text_citation_id, :integer
    add_column :herbs, :citation_id, :integer
    add_column :herbs, :source_text_citation_id, :integer
    add_column :acu_points, :citation_id, :integer
    add_column :patterns, :citation_id, :integer
  end

  def self.down
    remove_column :formulas, :citation_id
    remove_column :formulas, :source_text_citation_id
    remove_column :herbs, :citation_id
    remove_column :herbs, :source_text_citation_id
    remove_column :acu_points, :citation_id
    remove_column :patterns, :citation_id
  end
end
