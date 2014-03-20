class CreateReferencesCitations < ActiveRecord::Migration
  def change
    create_table :references_citations do |t|
      t.integer :source_id
      t.string :location

      t.timestamps
    end
  end
end
