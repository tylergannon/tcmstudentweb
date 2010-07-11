class AcuPointTherapeuticFunction < ActiveRecord::Base
  belongs_to :acu_point_info
  belongs_to :therapeutic_function
  acts_as_linkable :name => :therapeutic_function_name

	named_association :therapeutic_function, :name, :create => true
end
