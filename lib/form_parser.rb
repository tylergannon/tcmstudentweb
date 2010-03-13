class FormParser
  PATTERN_SYMPTOMS_REGEXP = /([\*-])?([^\n]+)\n(?:  (.*?)\*{5}\n)?/m

  def self.scan_text(text)
    (text + "\n").gsub(/\r\n/, "\n").scan(PATTERN_SYMPTOMS_REGEXP)
  end

  def self.parse_pattern_symptoms(text)
    scan_text(text).map {|match|
      PatternSymptom.new(:symptom_name => match[1],
                         :maybe => (match[0]=="-"),
                         :key_symptom => (match[0]=="*"),
                         :commentary => match[2])
    }
  end



  def self.parse_pattern_treatment_principles(text)
    if text.empty?
      []
    else
      scan_text(text).map {|match|
        PatternTreatmentPrinciple.new(:treatment_principle_name => match[1],
                           :commentary => match[2])
      }
    end

  end

  def self.unparse_pattern_symptoms(ps)
      text = ""
      ps.each do |s|
        text += "#{s.maybe ? "-" : ""}#{s.key_symptom ? "*" : ""}#{s.symptom_name}\n"
        text += "  #{s.commentary}*****\n" unless s.commentary.blank?
      end
      text
    end
  def self.unparse_pattern_treatment_principles(ptp)
      text = ""
      ptp.each do |tp|
        text += "#{tp.symptom_name}\n"
        text += "  #{tp.commentary}*****\n" unless tp.commentary.blank?
      end
      text
    end

end