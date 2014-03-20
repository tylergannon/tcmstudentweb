class AddSlugToAcupunctureChannels < ActiveRecord::Migration
  def change
    add_column :acupuncture_channels, :slug, :string
    add_index :acupuncture_channels, :slug
  end
end
