# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def textile(str)
    RedCloth.new(str).to_html unless str.nil?
  end

  def tfwac(f, field, url)
    f.text_field_with_auto_complete field, {}, { :url => url, :method => :get, :skip_style => true,	:with => "'search='+element.value" }
  end

  def text_area_with_auto_complete(form, field, search_path, options = {})
    render(:partial => 'layouts/auto_complete',
           :locals => {:f => form,  :path => search_path, :field => field, :html_options => options})
  end

  def field_id(form, field)
    form.object_name.gsub(/\[/, "_").gsub(/\]/, "") + "_" + field.to_s.underscore
  end
end
