# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def textile(str)
    RedCloth.new(str).to_html unless str.nil?
  end

  def tfwac(f, field, url)
    f.text_field_with_auto_complete field, {}, { :url => url, :method => :get, :skip_style => true,	:with => "'search='+element.value" }
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
      puts render(:partial => child.underscore, :locals => { :f => f })
    end
  end


  def text_area_with_auto_complete(form, field, search_path, options = {})
    render(:partial => 'layouts/auto_complete',
           :locals => {:f => form,  :path => search_path, :field => field, :html_options => options})
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
        bold(link(obj.symptom), obj.key_symptom) + (obj.commentary.blank? ? "" : " (#{obj.commentary.slice(0..40)})")
    else
      link_to obj.link_name, obj, :title => obj.link_title
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
