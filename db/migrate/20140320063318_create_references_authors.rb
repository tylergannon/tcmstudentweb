class CreateReferencesAuthors < ActiveRecord::Migration
  def change
    create_table :references_authors do |t|
      t.string :name
      t.string :slug, index: true

      t.timestamps
    end
  end
end
