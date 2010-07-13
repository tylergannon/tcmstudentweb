# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def remove_child_link(name, form_builder)
    form_builder.hidden_field(:_destroy) + link_to_function(name, "remove_child(this)", :tabindex => "0")
  end

  def add_child_link(name, child, form_builder)
    # puts "||#{form_builder}||"
    new_form = new_child_fields(child, form_builder)
    content_for :templates, raw("<div id=\"#{child}_template\">#{new_form}</div>")
    link_to name, options={}, html_options={"href"=>"#", "class"=>"add-child-link", "data-class-name"=>child}
  end

  def new_child_fields(child, form_builder)
    output = ""
    form_builder.fields_for(child.pluralize.to_sym, child.camelize.constantize.new, :child_index => 'NEW_RECORD') do |f|
      output += render(:partial => child.underscore, :locals => { :f => f })
    end
    output
  end  

  def textile(str)
    Haml::Filters::TcmTextile.render(str)
  end

  def short_citation(cit)
    if cit.nil? || cit.textbook.nil?
      nil
    else
      cit.textbook.abbrev ||= cit.textbook.title
    end
  end

  def text_area_with_auto_complete(form, field, controller, options = {})
      f.text_area field, "data-auto-complete"=>true, 
        "data-auto-complete-url"=> eval("#{controller.to_s.underscore.tableize}_path(:format=>:json)")
  end

  def tag_field(form, field)
    render(:partial => 'layouts/tag_field',
           :locals => {:f => form, :field => field})
  end

  def tag_list(tl)
    tl.map{|t| link_to t, t.name}.join(", ")
  end

  def show_citation(citation, short = false)
    return if citation.nil?
    if short
      "(#{citation.textbook.abbrev})"
    else
      render :partial => 'citations/show', :locals => {:citation => citation} unless citation.nil?
    end
  end

  def field_id(form, field)
    form.object_name.gsub(/\[/, "_").gsub(/\]/, "") + "_" + field.to_s.underscore
  end
end

