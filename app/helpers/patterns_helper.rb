module PatternsHelper
  def display_symptom(p_s)
    if p_s.key_symptom
      s = "<i>#{p_s.symptom_name}</i>"
    else
      s = p_s.symptom_name
      if p_s.maybe
        s = "(possibly) #{p_s.symptom_name}"
      end
    end
    unless p_s.commentary.nil? || p_s.commentary == ""
      s += " (#{p_s.commentary})"
    end
    s
  end
end
