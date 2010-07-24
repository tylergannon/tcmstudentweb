class HerbTherapeuticFunction < ActiveRecord::Base
	belongs_to :herb
	belongs_to :therapeutic_function
	named_association :therapeutic_function, :name, :create=>true
	acts_as_linkable :name=>:therapeutic_function_name
	scope :with_tf_name, lambda{|name|
	  tf = TherapeuticFunction.named(name).try(:id)
	  joins(:therapeutic_function).where(
	    :therapeutic_functions=>{:id=>id})
  }
end

