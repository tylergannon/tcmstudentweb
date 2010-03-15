class AcuPointTherapeuticFunction < ActiveRecord::Base
  belongs_to :acu_point
  belongs_to :therapeutic_function

  def therapeutic_function_name
    therapeutic_function.name if therapeutic_function
  end

  def therapeutic_function_name=(name)
    self.therapeutic_function = TherapeuticFunction.find_or_create_by_name(name) unless name.blank?
  end
end