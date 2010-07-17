# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def show_box_for(obj, name="Show details")
    check_active_record obj
    link_to(name, options={}, html_options={"href"=>"#", "class"=>"show-element-link", "data-id"=>id_for_show_box(obj)})
  end

  def js_link_to(name, html_opts={})
    html_opts[:href] = '#'
    link_to(name, options={}, html_options=html_opts)
  end

  def render_js(options={})
    "'"+escape_javascript(render(options))+"'"
  end

  def current_action(*action)
    action.map{|t| t.to_s}.include?(request.parameters[:action])
  end

  def hide_box_for(obj, name="Hide details")
    check_active_record obj
    link_to(name, options={}, html_options={"href"=>"#", "class"=>"hide-element-link", "data-id"=>id_for_show_box(obj)})
  end

  def detail_box_for(obj, &block)
    check_active_record obj
    raise ArgumentError, 'Missing block in showhide.detail_box_for call' unless block_given?
    concat content_tag(:div, capture(&block), :id=>id_for_show_box(obj), :class=>'hideable-hidden')
    nil
  end

  def id_for_show_box(obj)
    "detail_for_#{obj.class.name.underscore}#{obj.id}"
  end

  def check_active_record(obj)
    raise "I can only handle ActiveRecords" unless obj.kind_of?(ActiveRecord::Base)
  end

  def textile(str)
    Haml::Filters::TcmTextile.render(str)
  end

  def edit_citation(form, field=:citation, caption="Text:")
    render :partial => 'citations/edit_citation', :locals => {:f => form, :field => field, :caption=>caption}
  end

  def short_citation(cit)
    if cit.nil? || cit.textbook.nil?
      nil
    else
      cit.textbook.abbrev ||= cit.textbook.title
    end
  end
    def tfwac(f, field, controller, opts={})
      opts["data-auto-complete"]='tf'
      opts["data-auto-complete-url"]=eval("#{controller.to_s.underscore.tableize}_path(:format=>:json)")
      f.text_field field, opts
    end

    def text_area_with_auto_complete(f, field, controller, opts={})
      opts["data-auto-complete"]='ta'
      opts["data-auto-complete-delim"]='nl' unless opts.has_key?("data-auto-complete-delim")
      opts["data-auto-complete-url"]=eval("#{controller.to_s.underscore.tableize}_path(:format=>:json)")
      f.text_area field, opts
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

  def error_messages_for(for_object)
    if for_object.errors.any?
      render :partial => 'common/errors', :locals => {:for_object=>for_object}
    end
  end

  def field_id(form, field)
    form.object_name.gsub(/\[/, "_").gsub(/\]/, "") + "_" + field.to_s.underscore
  end
end

