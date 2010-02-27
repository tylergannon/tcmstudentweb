class Ability                                      
	include CanCan::Ability
	
	def initialize(user)
		user ||= User.new  #guest user
	  if user.role? :admin
			can :manage, :all
		else
			can :read, :all
			if user.role? :user
				can [:create, :update], [Herb, Formula, Contraindication]	
			end
		end
	end
end