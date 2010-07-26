class CreateContraindications < ActiveRecord::Migration
  def self.up
    create_table :contraindications do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :contraindications
  end
end
