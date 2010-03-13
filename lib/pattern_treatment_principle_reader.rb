class PatternTreatmentPrincipleReader < FormulaTherapeuticFunctionReader
  def from_object(obj)
    PatternTreatmentPrincipleReader.new(obj)
  end

  def from_string(s)
    fs = PatternTreatmentPrinciple.new
    fsr = PatternTreatmentPrincipleReader.new(fs)
    fsr.parse_string(s)
    fsr
  end
  def parse_string(s)
    _s = String.new(s)
    obj.treatment_principle_name = _s if obj.new_record?
  end
  def name
    obj.treatment_principle_name
  end

  def name=(name)
   obj.treatment_principle_name = name
  end

  def hash()
    ObjectHasher.hash_pattern_treatment_principle(obj)
  end
end