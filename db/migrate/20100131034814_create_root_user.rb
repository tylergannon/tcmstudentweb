class CreateRootUser < ActiveRecord::Migration
  def self.up
		down
		
		root = User.new(:email => "eightbittortillachip@gmail.com", :login => "admin", 
			:password => "12345", :password_confirmation => "12345", 
			:active => true, 
			:verified => true)
		root.active = true
		root.verified = true
		root.roles = [User::ROLES[0]]
		root.save
  end

  def self.down
		User.all.each {|t| t.destroy}
  end
end
