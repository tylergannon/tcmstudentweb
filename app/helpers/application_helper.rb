# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def textile(str)
    RedCloth.new(str).to_html unless str.nil?
  end

  def short_citation(cit)
    if cit.nil? || cit.textbook.nil?
      nil
    else
      cit.textbook.abbrev ||= cit.textbook.title
    end
  end

  def tfwac(f, field, url)
    f.text_field_with_auto_complete field, {}, { :url => url, :method => :get, :skip_style => true,	:with => "'search='+element.value" }
  end
  def remove_child_link(name, form_builder)
    form_builder.hidden_field(:_destroy) + link_to_function(name, "remove_child(this)", :tabindex => "0")
  end

  def add_child_link(name, child, form_builder)
    # puts "||#{form_builder}||"
    fields = escape_javascript(new_child_fields(child, form_builder))
    link_to_function(name, h("add_child(this, \"#{child}\", \"#{fields}\")"))
  end

  def new_child_fields(child, form_builder)
    output = ""
    form_builder.fields_for(child.pluralize.to_sym, child.camelize.constantize.new, :child_index => 'NEW_RECORD') do |f|
      output += render(:partial => child.underscore, :locals => { :f => f })
    end
    output
  end


  def text_area_with_auto_complete(form, field, search_path, options = {})
    render(:partial => 'layouts/auto_complete',
           :locals => {:f => form,  :path => search_path, :field => field, :html_options => options})
  end

  def tag_field(form, field)
    render(:partial => 'layouts/tag_field',
           :locals => {:f => form, :field => field})
  end

  def tag_list(tl)
    tl.map{|t| link_to t, t.name}.join(", ")
  end

  def link_to_herb(herb)
    link_to herb.pinyin, herb, :title => herb.latin
  end

  def link_to_formula(formula)
    link_to formula.pinyin, formula, :title => formula.english
  end

  def link(obj)
    return unless obj
    if obj.class == Array
      obj.map{|v| link(v)}.join(", ")
    elsif obj.class == PatternSymptom
        bold(link(obj.symptom), obj.key_symptom) + (obj.commentary.blank? ? "" : " (#{obj.commentary})")
    else
      link_to obj.link_name, obj, :title => obj.link_title
    end
  end

  def show_citation(citation, short = false)
    return if citation.nil?
    if short
      "(#{citation.textbook.abbrev})"
    else
      render :partial => 'citations/show', :locals => {:citation => citation} unless citation.nil?
    end
  end

  def bold(text, bool)
    if bool
      "<b>#{text}</b>"
    else
      text
    end
  end

  def field_id(form, field)
    form.object_name.gsub(/\[/, "_").gsub(/\]/, "") + "_" + field.to_s.underscore
  end
end

