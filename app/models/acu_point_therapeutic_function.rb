class AcuPointTherapeuticFunction < ActiveRecord::Base
  belongs_to :acu_point_info
  belongs_to :therapeutic_function

  def name
    therapeutic_function_name
  end
	named_association :therapeutic_function, TherapeuticFunction, :name, :create
end
