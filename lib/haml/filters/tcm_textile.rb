module Haml::Filters::TcmTextile
  include Haml::Filters::Base

  # copied from Haml::Filters::Markdown

  MY_PATTERN = /"(\w):([\w\s\:]+)"/m

  def render(text)
    text = text.gsub(MY_PATTERN) {|m|
      link_text = $2
      controller = case $1
        when 'f'
          "formulas"
        when 'a'
          "acu_points"
        when 'h'
          x = Herb.search_equals(link_text)
          link_text = x.nil? ? link_text : x.pinyin
          "herbs"
        when 'p'
          "patterns"
        when 's'
          "symptoms"
      end
      "\"#{link_text}\":/#{controller}/#{$2.gsub(" ", "_").downcase}"
    }
    RedCloth.new(text).to_html

  end
end

