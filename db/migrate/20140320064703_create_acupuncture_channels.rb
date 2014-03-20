class CreateAcupunctureChannels < ActiveRecord::Migration
  def change
    create_table :acupuncture_channels do |t|
      t.string :name
      t.string :abbreviation

      t.timestamps
    end
  end
end
