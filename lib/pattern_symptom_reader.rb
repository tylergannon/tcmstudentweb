class PatternSymptomReader < FormulaSymptomReader
  def from_object(obj)
    PatternSymptomReader.new(obj)
  end
  def from_string(s)
    fs = PatternSymptom.new
    fsr = PatternSymptomReader.new(fs)
    fsr.parse_string(s)
    fsr
  end
  def hash
    ObjectHasher.hash_pattern_symptom(obj)
  end
end