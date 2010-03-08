class FormulaSymptomReader
  def initialize(obj)
    @fs = obj
  end

  def from_object(obj)
    FormulaSymptomReader.new(obj)
  end

  def parse_string(s)
    _s = String.new(s)
    if s.index("*") == 0
      @fs.key_symptom = true
      @fs.maybe = false
      _s.slice!(0)
      _s.strip!
    end
    if s.index("-") == 0
      @fs.maybe = true
      @fs.key_symptom = false
      _s.slice!(0)
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
    a = {:symptom_name => @fs.symptom_name}
    if @fs.maybe then
      a[:maybe] = "1"
    end
    if @fs.key_symptom then
      a[:key_symptom] = "1"
    end
    if @fs.id then
      a[:id] = @fs.id.to_s
    end
    a
  end
end

