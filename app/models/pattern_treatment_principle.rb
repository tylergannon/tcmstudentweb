class PatternTreatmentPrinciple < ActiveRecord::Base
  belongs_to :treatment_principle, :class_name => "TherapeuticFunction", :foreign_key => 'therapeutic_function_id'
  belongs_to :pattern

  def treatment_principle_name
    treatment_principle.name if treatment_principle
  end

  def key_attributes
    ["id", "treatment_principle_name", "commentary"]
  end

  def name
    treatment_principle_name
  end

  def treatment_principle_name=(name)
    self.treatment_principle = TherapeuticFunction.find_or_create_by_name(name) unless name.blank?
  end

  def therapeutic_function_name
    treatment_principle_name
  end

  def therapeutic_function_name=(name)
    self.treatment_principle_name = name
  end


end
