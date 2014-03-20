class CreatePatterns < ActiveRecord::Migration
  def change
    create_table :patterns do |t|
      t.string :name
      t.string :commentary, limit: 65500
      t.integer :citation_id, index: true
      t.string :tongue
      t.string :pulse
      t.string :slug, index: true
      t.string :canonical

      t.timestamps
    end
  end
end
