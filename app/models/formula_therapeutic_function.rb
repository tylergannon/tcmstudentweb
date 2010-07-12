class FormulaTherapeuticFunction < ActiveRecord::Base
	belongs_to :formula
	belongs_to :therapeutic_function
	
	named_association :therapeutic_function, :name, :create=>true
	scope :with_tf_name, lambda{|name| 
	  tf = TherapeuticFunction.named(name)
	  id = tf.id if tf
	  joins(:therapeutic_function).where(
	    :therapeutic_functions=>{:id=>id})
  }

end
