class AcuPointTherapeuticFunction < ActiveRecord::Base
  belongs_to :acu_point_info
  belongs_to :therapeutic_function

  def name
    therapeutic_function_name
  end

  def therapeutic_function_name
    therapeutic_function.name if therapeutic_function
  end

  def therapeutic_function_name=(name)
    self.therapeutic_function = TherapeuticFunction.find_or_create_by_name(name) unless name.blank?
  end

  def key_attributes
    ["id", "therapeutic_function_name"]
  end
end
