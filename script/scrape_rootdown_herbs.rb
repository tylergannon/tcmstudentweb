
require 'rubygems'
require 'scrapi'
require 'htmlentities'
require "lib/tasks/herb_scraper"
require 'yaml'
$KCODE = 'UTF8'
require 'ya2yaml'

cat_pages = ("A".."Z").map {|a| URI.parse("http://www.rootdown.us/Herbs/Browse.aspx?Alpha=#{a}")}

herb_finder = Scraper.define do
  array :items
  process "tr.resultCell a", :items => "@href"
  process "tr.resultCellAlt a", :items => "@href"
  result :items
end
def struct_to_hash(b)
  a = {}
  b.each_pair {|name, val| a[name]=val}
  a
end


herbs = YAML::load_file('lib/herbs')
coder = HTMLEntities.new

herbs.each do |herb|
  herb_data = struct_to_hash(HerbScraper.scrape(URI.parse("http://rootdown.us#{herb}")))
  herb_data[:chinese] = coder.decode(herb_data[:chinese])
  herb_data[:names] = coder.decode(herb_data[:names])
  herb_data[:japanese] = coder.decode(herb_data[:japanese])
  m = herb_data[:names].match("#{herb_data[:chinese]} (.*), \"")
  herb_data[:canonical] = herb_data[:names].match(/[\w ]*/).to_s
  herb_data[:pinyin] = m ? m[1] : herb_data[:canonical]
  puts herb_data[:names]
  puts herb_data.to_yaml
  File.open("lib/herb_data/#{herb_data[:canonical]}.yml", 'w') {|f| f.write(herb_data.ya2yaml) }

end

#all_herbs = []

#cat_pages.each do |uri|
#  herbs = herb_finder.scrape(uri)
#  if herbs
#    herbs.each {|t| all_herbs << t }
#  end
#end
#File.open("herbs", 'w') {|f| f.write(all_herbs.to_yaml) }

#puts all_herbs.inspect


#herb = Hash.new(HerbScraper.scrape(uri))
#herb["canonical"] = "foobar"
#puts herb.to_yaml

#puts herb_finder.scrape(uri)
#elements = herb_parser.scrape(uri)
#puts div_parser.scrape(elements[0])



#scraper = Scraper.define do
#  array :items
#  process "div.item", :items => Scraper.define {
#    process "a.prodLink", :title => :text, :link => "@href"
#    process "div.priceAvail>div>div.PriceCompare>div.BodyS", :price => :text
#    result :price, :title, :link
#  }
#  result :items
#end

#uri = URI.parse("http://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=lost+third+season&Find.x=0&Find.y=0&Find=Find")
#scraper.scrape(uri).each do |product|
#  puts product.title
#  puts product.price
#  puts product.link
#  puts
#end

