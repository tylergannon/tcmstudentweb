class AcuPointTherapeuticFunctionReader < FormulaTherapeuticFunctionReader
  def from_object(obj)
    AcuPointTherapeuticFunctionReader.new(obj)
  end

  def from_string(s)
    fs = AcuPointTherapeuticFunction.new
    fsr = AcuPointTherapeuticFunctionReader.new(fs)
    fsr.parse_string(s)
    fsr
  end

  def hash
    ObjectHasher.hash_acu_point_therapeutic_function(@fs)
  end
end