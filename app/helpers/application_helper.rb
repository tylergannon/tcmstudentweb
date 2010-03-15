# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def textile(str)
    RedCloth.new(str).to_html unless str.nil?
  end

  def tfwac(f, field, url)
    f.text_field_with_auto_complete field, {}, { :url => url, :method => :get, :skip_style => true,	:with => "'search='+element.value" }
  end

  def text_area_with_auto_complete(form, field, values, options = {})
    id = "extra_#{field}"
    name = "extra[#{field}]"
    options.merge!({:autocomplete => 'off', :id => id, :name => name})
    text = StringObjectHasher.encode(values)
    search_path = "/#{field.tableize}.js"
    render(:partial => 'layouts/auto_complete',
           :locals => {:id => id, :path => search_path, :text => text, :html_options => options})
  end
end
