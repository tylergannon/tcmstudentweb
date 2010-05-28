
require 'script/scrapi_helper'
coder = HTMLEntities.new

formula_pages = ("A".."Z").map {|a| URI.parse("http://www.rootdown.us/Formulas/FormulaBrowse.aspx?Alpha=#{a}")}

formula_finder = Scraper.define do
  array :items
  process "tr[class*='resultCell']", :items => :element
  result :items
end

crack_finder = Scraper.define do
  process "td:nth-of-type(1)", :canonical => :text
  process "td:nth-of-type(1) a", :url => "@href"
  process "td:nth-of-type(2)", :chinese => :text
  process "td:nth-of-type(3)", :english => :text

  result :canonical, :chinese, :english, :url
end
formulas = []
formula_pages.each do |page|
  elements = formula_finder.scrape(page)
  if elements.nil?
    puts "Element nil for #{page.inspect}"
  else
    elements.each do |element|
      formula = crack_finder.scrape(elements[0]).to_hash
      formula[:chinese] = coder.decode(formula[:chinese])
      formulas << formula
    end
  end
end

File.open("lib/herb_data/formula_pages.yml", 'w') {|f| f.write(formulas.ya2yaml) }


#formula_pages_pages.each do |uri|
#  formulas = formula_finder.scrape(uri)
#  if formulas
#    formulas.each {|t| all_formulas << t }
#  end
#end
#File.open("formulas", 'w') {|f| f.write(all_formulas.ya2yaml) }

