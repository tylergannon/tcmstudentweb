class TherapeuticFunction < ActiveRecord::Base
	has_many :herb_therapeutic_functions
	has_many :herbs, :through => :herb_therapeutic_functions
end
