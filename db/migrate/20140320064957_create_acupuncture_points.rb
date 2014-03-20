class CreateAcupuncturePoints < ActiveRecord::Migration
  def change
    create_table :acupuncture_points do |t|
      t.references :channel, index: true
      t.integer :orginal
      t.string :pinyin
      t.string :chinese
      t.string :name_discussion
      t.string :commentary, limit: 65500
      t.string :canonical
      t.string :slug, index: true

      t.timestamps
    end
  end
end
