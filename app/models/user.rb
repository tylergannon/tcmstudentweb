class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  def role?(name)
    !roles.select{|t| t.name.underscore==name.to_s.underscore}.empty?
  end
  def roles
    @roles ||= Role.joins(:user_roles).where(:user_roles=>{:user_id=>id})
  end
end

