class HerbTherapeuticFunction < ActiveRecord::Base
	belongs_to :herb
	belongs_to :therapeutic_function
	named_association :therapeutic_function, :name, :create=>true
	acts_as_linkable :name=>:therapeutic_function_name
end
