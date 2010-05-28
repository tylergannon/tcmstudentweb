class AcuPointScraper < Scraper::Base

  herb_parser = Scraper.define do
    process "td:nth-of-type(2) a", :role => "@title"
    process "td:nth-of-type(2) a b", :canonical => :text
    process "td:nth-of-type(4)", :quantity => :text
    process "td:nth-of-type(5)", :unit => :text
    result :role, :canonical, :quantity, :unit
  end

  process "#ctl00_contentBody_linkCategoryParent", :parent_category => :text
  process "#ctl00_contentBody_linkCategoryChild", :subcategory => :text
  process "#ctl00_contentBody_hTitle", :names => :text
  process "#ctl00_contentBody_rptReferenceSources_ctl00_rsPopUp_linkRefSource", \
    :source_text => :text
  array :herbs
  process "table#ctl00_contentBody_dgHerb tr[class*='resultCell']", \
    :herbs => herb_parser.scrape(:element)

  result :parent_category, :subcategory, :names, :source_text, :herbs

  def scrape_acu_points


  end
end

