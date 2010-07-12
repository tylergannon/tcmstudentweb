class AcuPointTherapeuticFunction < ActiveRecord::Base
  belongs_to :acu_point_info
  belongs_to :therapeutic_function
  acts_as_linkable :name => :therapeutic_function_name
	named_association :therapeutic_function, :name, :create => true
	
	attr_accessor :tag_list
	before_save :set_tf_tags
	
	def set_tf_tags
	  self.therapeutic_function.tag_list = tag_list if therapeutic_function
	  self.therapeutic_function.save if therapeutic_function
  end

	scope :with_tf_name, lambda{|name| 
	  tf = TherapeuticFunction.named(name)
	  id = tf.id if tf
	  joins(:therapeutic_function).where(
	    :therapeutic_functions=>{:id=>id})
  }

end
