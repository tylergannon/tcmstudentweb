module FormulasHelper

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

  def text_area_with_auto_complete(form, field, values, options = {})
    id = "extra_#{field}"
    name = "extra[#{field}]"
    options.merge!({:autocomplete => 'off', :id => id, :name => name})
    text = values.join("; ")
    search_path = "/#{field.tableize}.js"
    render(:partial => 'auto_complete',
           :locals => {:id => id, :path => search_path, :text => text, :html_options => options})
  end



end
