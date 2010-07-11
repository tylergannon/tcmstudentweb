# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

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

  def tfwac(f, field, url)
    f.text_field_with_auto_complete field, {}, { :url => url, :method => :get, :skip_style => true,	:with => "'search='+element.value" }
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

