module Haml::Filters::TcmTextile
  include Haml::Filters::Base

  # copied from Haml::Filters::Markdown

  MY_PATTERN = /"(\w):([, -_\w\[\]]+?)"/m
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

      if link_text[0]==91 && link_text[link_text.size-1]==93
        link_text = link_text[1..link_text.length-2]
        link_strs = link_text.split(",").map{|t| t.strip}
      else
        link_strs = [link_text]
      end
      if klass==Symptom
        links = link_strs.map{|link_str|
          "\"#{link_str}\":/symptoms/#{urlitize(link_str)}"
        }
      else
        links = link_strs.map{|link_str|
          x = klass.named(link_str)
          unless x.nil?
            link_attr = x.link_attr
            link_attr.each {|name, val| link_attr[name] = x.send(val) if val.class == Symbol}

            link = "\"#{link_attr[:name]}\":/#{controller}/#{x.id}"
          else
            link = "\"#{link_text}\":/#{controller}/new?name=#{urlitize(link_str)}"
          end
          link
        }
      end
      links.to_sentence
    }
    RedCloth.new(text).to_html

  end
  def urlitize(str)
    str.titleize.gsub(' ', '%20')
  end
end

