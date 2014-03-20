class CreatePatterns < ActiveRecord::Migration
  def change
    create_table :patterns do |t|
      t.string :name
      t.string :commentary
      t.string :citation_id
      t.string :tongue
      t.string :pulse
      t.string :slug
      t.string :canonical

      t.timestamps
    end
  end
end
