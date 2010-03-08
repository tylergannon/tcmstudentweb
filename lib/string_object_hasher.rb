class StringObjectHasher

  def self.hash_formula_symptoms(params, object)
    return if params[:extra].nil? || params[:extra][:symptoms].nil?
    a = StringObjectHasher.new(params[:extra][:symptoms],
                           object.formula_symptoms,
                           FormulaSymptomReader.new(nil)).get_hash
    unless a.nil? then params[:formula_symptoms_attributes] = a end
  end

  def self.hash_therapeutic_functions(params, object)
    return if params[:extra].nil? || params[:extra][:therapeutic_functions].nil?
    a = StringObjectHasher.new(params[:extra][:therapeutic_functions],
                           object.formula_therapeutic_functions,
                           FormulaTherapeuticFunctionReader.new(nil)).get_hash
    unless a.nil? then params[:formula_therapeutic_functions_attributes] = a end
  end

  def initialize(text, objects, reader)
    @strings = cleaned_items(text)
    @old_objects = objects.map{|v| reader.from_object(v)}
    @new_objects = cleaned_items(text).map{|v|
      rdr = reader.from_string(v)
      existing_obj = pop_matching_old_object!(rdr)
      if existing_obj
        existing_obj.parse_string(v)
        existing_obj
      else
        rdr
      end
    }

    @reader = reader
  end

  def strings
    @strings
  end

  def objects
    @new_objects
  end

  def get_hash
    hash = {}
    i = 0
    @new_objects.each do |obj|
      hash[i.to_s] = obj.hash
      i+=1
    end

    @old_objects.each do |obj|
      hash[i.to_s] = {:id => obj.id.to_s, :_destroy => "1"}
      i+=1
    end

    hash
  end

  private
  #
  #  Splits s by semicolon and removes leading and trailing whitespace from each resulting string
  #
  def cleaned_items(s)
    s.strip.split(";").collect{|a| a.strip}
  end

  #
  #  Methods for export:::
  #

  def hash_this(obj)
    a = {:symptom_name => obj.symptom_name,
         :maybe => obj.maybe ? "1" : "0",
         :key_symptom => obj.key_symptom ? "1" : "0"}
    a[:id] = obj.id unless obj.new_record?
    return a
  end

  def make_object_array_from_strings
    @new_objects = []
    @strings.each do |str|
      rdr = @reader.from_obj(str)
      _fs = pop_old_by_name!(str)
      unless _fs then
        _fs = FormulaSymptom.new(:symptom_name => str)
      end
      _fs.key_symptom = key_symptom
      _fs.maybe = maybe
      @new_objects << _fs
    end
  end

  def pop_matching_old_object!(rdr)
    a = @old_objects.select{|v| v.name.downcase == rdr.name.downcase}[0]
    if a then
      @old_objects.delete(a)
    end
    a
  end


end
