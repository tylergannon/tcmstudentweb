module Haml::Filters::TcmTextile
  include Haml::Filters::Base

  # copied from Haml::Filters::Markdown

  MY_PATTERN = /"(\w):([\w\s\:\-]+)"/m

  def render(text)
    text = text.gsub(MY_PATTERN) {|m|
      link_text = $2
      klass = Formula
      controller = case $1
        when 'f'
          klass = Formula
          "formulas"
        when 'a'
          klass = AcuPoint
          "acu_points"
        when 'h'
          klass = Herb
          "herbs"
        when 'p'
          klass = Pattern
          "patterns"
        when 's'
          klass = Symptom
          "symptoms"
        when 't'
          klass = Article
          "articles"
      end
      x = klass.named(link_text)
      unless x.nil?
        link_attr = x.link_attr
        link_attr.each {|name, val| link_attr[name] = x.send(val) if val.class == Symbol}
        
        link = "\"#{link_attr[:name]}\":/#{controller}/#{x.id}"
      else
        link = "\"#{link_text}\":/#{controller}/new?name=#{link_text.titleize.gsub(' ', '%20')}"
      end
      link
    }
    RedCloth.new(text).to_html

  end
end

