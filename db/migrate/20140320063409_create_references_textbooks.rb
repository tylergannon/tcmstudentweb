class CreateReferencesTextbooks < ActiveRecord::Migration
  def change
    create_table :references_textbooks do |t|
      t.references :author, index: true
      t.string :title
      t.string :slug, index: true
      t.string :year
      t.string :abbreviation

      t.timestamps
    end
  end
end
