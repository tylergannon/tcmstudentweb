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

  def remove_child_link(name, form_builder)
    form_builder.hidden_field(:_destroy) + link_to_function(name, "remove_child(this)", :tabindex => "0")
  end

  def add_child_link(name, child, form_builder)
    fields = escape_javascript(new_child_fields(child, form_builder))
    link_to_function(name, h("add_child(this, \"#{child}\", \"#{fields}\")"))
  end

  def new_child_fields(child, form_builder)
    form_builder.fields_for(child.pluralize.to_sym, child.camelize.constantize.new, :child_index => 'NEW_RECORD') do |f|
      render(:partial => child.underscore, :locals => { :f => f })
    end
  end
  
end
