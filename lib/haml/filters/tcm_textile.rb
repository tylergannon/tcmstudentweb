module Haml::Filters::TcmTextile
  include Haml::Filters::Base

  # copied from Haml::Filters::Markdown

  MY_PATTERN = /"(\w):([\w\s]+)"/m

  def render(text)
    text = text.gsub(MY_PATTERN) {|m|
      controller = case $1
        when 'f'
          "formulas"
        when 'a'
          "acu_points"
        when 'h'
          "herbs"
        when 'p'
          "patterns"
      end
      "\"#{$2}\":/#{controller}/#{$2.gsub(" ", "_").downcase}"
    }
    RedCloth.new(text).to_html

  end
end