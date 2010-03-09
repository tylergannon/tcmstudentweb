class FormulaSymptomReader
  def initialize(obj)
    @fs = obj
  end

  def from_object(obj)
    FormulaSymptomReader.new(obj)
  end

  def parse_string(s)
    _s = String.new(s)
    if _s.index("*") == 0
      @fs.key_symptom = true
      @fs.maybe = false
      _s.slice!(0)
      _s.strip!
    end
    if _s.index("-") == 0
      @fs.maybe = true
      @fs.key_symptom = false
      _s.slice!(0)
      _s.strip!
    end
    if j = _s.index("(")
      k = _s.index(")")
      if k
        _s.slice!(k)
        k -= 1
      else
        k = _s.size-1
      end
      commentary = _s.slice!(j..k)
      commentary.slice!(0)
      @fs.commentary = commentary
      _s.strip!
    end
    @fs.symptom_name = _s if @fs.new_record?
  end

  def from_string(s)
    fs = FormulaSymptom.new

    fsr = FormulaSymptomReader.new(fs)
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
    @fs.symptom_name
  end

  def name=(name)
    @fs.symptom_name = name
  end

  def hash
    ObjectHasher.hash_formula_symptom(@fs)
#    a = {:symptom_name => @fs.symptom_name}
#    if @fs.maybe then
#      a[:maybe] = "1"
#    end
#    if @fs.key_symptom then
#      a[:key_symptom] = "1"
#    end
#    if @fs.id then
#      a[:id] = @fs.id.to_s
#    end
#    a
  end
end

