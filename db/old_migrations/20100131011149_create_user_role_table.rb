class CreateUserRoleTable < ActiveRecord::Migration
  def self.up
		create_table :users_roles, :id => false do |t|
			t.integer :user_id
			t.integer :role_id
		end
  end

  def self.down
		drop_table :users_roles
  end
end
