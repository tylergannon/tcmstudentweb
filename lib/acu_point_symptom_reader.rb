class AcuPointSymptomReader < FormulaSymptomReader
  def from_object(obj)
    AcuPointSymptomReader.new(obj)
  end
  def from_string(s)
    fs = AcuPointSymptom.new
    fsr = AcuPointSymptomReader.new(fs)
    fsr.parse_string(s)
    fsr
  end
  def hash
    ObjectHasher.hash_acu_point_symptom(obj)
  end
end