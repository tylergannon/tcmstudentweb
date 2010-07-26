class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
		
		Role.new(:name => "Admin").save
		Role.new(:name => "User").save
  end

  def self.down
    drop_table :roles
  end
end
