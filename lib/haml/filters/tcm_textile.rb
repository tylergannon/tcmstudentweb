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
      x = klass.search_equals(link_text)
      link_text = x.nil? ? link_text : x.name
      arg = x.nil? ? "new?name=#{link_text.gsub(' ', '%20')}" : x.id
      "\"#{link_text}\":/#{controller}/#{arg}"
    }
    RedCloth.new(text).to_html

  end
end

