class FormParser
  PATTERN_SYMPTOMS_REGEXP = /([\*-])?([^\n\(]+)(?:(?:\n  (.*?);{2}\n)|\s\(([^\)]+)\))?/m

  def self.scan_text(text)
    (text + "\n").gsub(/\r\n/, "\n").scan(PATTERN_SYMPTOMS_REGEXP)
  end

  def self.get_commentary(match)
    match[2] ||= match[3]
  end

  def self.parse_symptoms(text, klass)
    scan_text(text).map {|match|
      klass.send(:new, :symptom_name => match[1].strip,
                 :maybe => (match[0]=="-"),
                 :key_symptom => (match[0]=="*"),
                 :commentary => get_commentary(match))
    }
  end

  def self.parse_point_prescription_acu_points(text)
    scan_text(text).map {|match|
      puts match
      PointPrescriptionAcuPoint.new(:acu_point_abbrev => match[1].strip, :commentary => match[2])
    }.delete_if{|v| v.acu_point.nil?}
  end

  def self.parse_therapeutic_functions(text, klass)
    if text.empty?
      []
    else
      scan_text(text).map {|match|
        klass.send(:new, :therapeutic_function_name => match[1].strip,
                   :commentary => get_commentary(match))
      }
    end
  end

  def self.unparse_commentary(s)
    case
      when s.commentary.blank?
        "\n"
      when s.commentary.index("\n") || s.commentary.length > 40
        "\n  #{s.commentary};;\n"
      else
        " (#{s.commentary})\n"
    end
  end

  def self.unparse_symptoms(ps)
    text = ""
    ps.each do |s|
      text += "#{s.maybe ? "-" : ""}#{s.key_symptom ? "*" : ""}#{s.symptom_name}"
      text += unparse_commentary(s)
    end
    text
  end

  def self.unparse_point_prescription_acu_points(ps)
    text = ""
    ps.each do |s|
      text += "#{s.acu_point_abbrev}" + unparse_commentary(s)
    end
    text
  end

  def self.unparse_therapeutic_functions(ptp)
    text = ""
    ptp.each do |tp|
      text += "#{tp.therapeutic_function_name}" + unparse_commentary(tp)
    end
    text
  end

  def self.merge(old_array, new_array)
    old_array.each do |existing|
      puts "OLD ARRAY::  #{existing.inspect}"
      new_obj = new_array.find_same(existing)
      if new_obj.nil?
        existing.destroy
        old_array.delete(existing)
      else
        existing.incorporate new_obj
        new_array.delete(new_obj)
      end
    end
    new_array.each do |new|
      puts "NEW ARRAY::  #{new.inspect}"
      old = old_array.find_same(new)
      if old.nil?
        old_array << new
      end
    end
  end

end