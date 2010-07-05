module FormulasHelper

  def link_to_pattern_symptoms(pattern_symptoms)
    pattern_symptoms.map{|y|
      link_to(y.symptom_name, y.symptom) + (y.commentary.blank? ? "" : " (#{y.commentary.slice(0..40)})")
    }.join(", ")
  end

  def display_formula_symptom(fs)
    if fs.key_symptom
      s = "<i>#{fs.symptom_name}</i>"
    else
      s = fs.symptom_name
      if fs.maybe
        s = "(possibly) #{fs.symptom_name}"
      end
    end
    unless fs.commentary.nil? || fs.commentary == ""
      s += " (#{fs.commentary})"
    end
    s
  end
end

