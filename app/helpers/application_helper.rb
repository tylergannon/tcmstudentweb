# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def menu_link(name, href, parent=false)
    options = {:remote=>true}
    options[:class] = parent if parent
    link_to href, options do
      raw "<span>#{name}</span>"
    end
  end

  def growl(title, msg, type=:info)
    "$.growl('#{title}', '#{msg}', '/images/growl/#{type}.png');"
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

  def show_box_for(obj, show="Show details", hide="Hide Details", association=nil)
    check_active_record obj
    link_to show, options={}, {
        :href     =>"#",
        :class    =>"show-element-link",
        "data-id" =>obj.element_id(:details, association),
        "data-show-text" => show,
        "data-hide-text" => hide
    }
  end

  def detail_box_for(obj, association=nil, &block)
    check_active_record obj
    raise ArgumentError, 'Missing block in showhide.detail_box_for call' unless block_given?
    concat content_tag(:div, capture(&block), :id=>obj.element_id(:details, association), :class=>'hideable-hidden')
    nil
  end

  def id_for_show_box(obj)
    obj.element_id(:detail_box)
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

