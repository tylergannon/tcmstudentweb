class FormulaTherapeuticFunctionReader
  def initialize(obj)
    @fs = obj
  end

  def from_object(obj)
    FormulaTherapeuticFunctionReader.new(obj)
  end

  def parse_string(s)
    _s = String.new(s)
    @fs.therapeutic_function_name = _s if @fs.new_record?
  end

  def from_string(s)
    fs = FormulaTherapeuticFunction.new
    fsr = FormulaTherapeuticFunctionReader.new(fs)
    fsr.parse_string(s)
    fsr
  end

  def obj
    @fs
  end

  def id
    @fs.id
  end

  def id=(id)
    @fs.id = id
  end

  def name
    @fs.therapeutic_function_name
  end

  def name=(name)
    @fs.therapeutic_function_name = name
  end

  def hash
    ObjectHasher.hash_formula_therapeutic_function(@fs)
  end
end