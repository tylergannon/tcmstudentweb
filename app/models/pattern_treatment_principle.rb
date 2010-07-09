class PatternTreatmentPrinciple < ActiveRecord::Base
  belongs_to :treatment_principle, :class_name => "TherapeuticFunction", :foreign_key => 'therapeutic_function_id'
  belongs_to :pattern

  named_association :treatment_principle, TreatmentPrinciple, :name, :create

  def key_attributes
    ["id", "treatment_principle_name", "commentary"]
  end

  def name
    therapeutic_function_name
  end
end
