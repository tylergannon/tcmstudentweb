class AddSourceTypeToReferencesCitations < ActiveRecord::Migration
  def change
    add_column :references_citations, :source_type, :string
  end
end
