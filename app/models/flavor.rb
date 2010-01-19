class Flavor < ActiveRecord::Base
	has_many :herb_flavors
	has_many :herbs, :through => :herb_flavors
end
