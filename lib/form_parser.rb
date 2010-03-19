class FormParser
  PATTERN_SYMPTOMS_REGEXP = /([\*-])?([^\n]+)\n(?:  (.*?)\*{5}\n)?/m

  def self.scan_text(text)
    (text + "\n").gsub(/\r\n/, "\n").scan(PATTERN_SYMPTOMS_REGEXP)
  end

  def self.parse_symptoms(text, klass)
    scan_text(text).map {|match|
      klass.send(:new, :symptom_name => match[1].strip,
                 :maybe => (match[0]=="-"),
                 :key_symptom => (match[0]=="*"),
                 :commentary => match[2])
    }
  end

  def self.parse_therapeutic_functions(text, klass)
    if text.empty?
      []
    else
      scan_text(text).map {|match|
        klass.send(:new, :therapeutic_function_name => match[1].strip,
                   :commentary => match[2])
      }
    end
  end

  def self.unparse_symptoms(ps)
    text = ""
    ps.each do |s|
      text += "#{s.maybe ? "-" : ""}#{s.key_symptom ? "*" : ""}#{s.symptom_name}\n"
      text += "  #{s.commentary}*****\n" unless s.commentary.blank?
    end
    text
  end

  def self.unparse_therapeutic_functions(ptp)
    text = ""
    ptp.each do |tp|
      text += "#{tp.therapeutic_function_name}\n"
      text += "  #{tp.commentary}*****\n" unless tp.commentary.blank?
    end
    text
  end

  def self.merge(old_array, new_array)
    old_array.each do |existing|
      new_obj = new_array.find_same(existing)
      if new_obj.nil?
        existing.destroy
        old_array.delete(existing)
      else
        existing.incorporate new_obj
        new_array.delete(new_obj)
      end
    end

    #  Create new objects for anything not represented in the existing data.
    old_array << new_array
  end

end