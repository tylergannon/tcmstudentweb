class HerbFlavor < ActiveRecord::Base
	belongs_to :herb
	belongs_to :flavor
	
	def flavor_name=(name)
		self.flavor = Flavor.find_or_create_by_name(name) unless name.blank?
	end
	
	def flavor_name
		flavor.name if flavor
	end
	
end
