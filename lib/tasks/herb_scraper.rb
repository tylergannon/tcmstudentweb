class HerbScraper < Scraper::Base
  process "#ctl00_contentBody_linkCategoryParent", :parent_category => :text
  process ".chinese", :chinese => :text
  process "#ctl00_contentBody_linkCategoryChild", :subcategory => :text
  process "#ctl00_contentBody_hTitle", :names => :text
  process "#ctl00_contentBody_lblPharmaceuticalName", :pharm => :text
  process "#ctl00_contentBody_lblBotanicalName", :botanical => :text
  process "#ctl00_contentBody_lblJapaneseName", :japanese => :text
  process "#ctl00_contentBody_lblKoreanName", :korean => :text
  process "#ctl00_contentBody_lblCommonName", :common => :text
  process "#ctl00_contentBody_lblDosage", :dosage => :text
  process "#ctl00_contentBody_lblCautions", :cautions => :text
  process "#ctl00_contentBody_pnlPreparation", :preparation => :text
  process "#ctl00_contentBody_lblQuality", :quality => :text
  process "a[href*='/Herbs/Browse.aspx?TemperatureID=']", :temperature => :text
  selector :detail_text, ".detailText"
  selector :a, "a[style*='color']"

  array :flavors
  process "a[href*='/Herbs/Browse.aspx?TasteID=']", :flavors => :text
  array :channels
  process "a[href*='/Herbs/Browse.aspx?MeridianID=']", :channels => :text


  result :names, :subcategory, :parent_category, :pharm, :botanical, :japanese, :korean, \
  :common, :flavors, :dosage, :cautions, :channels, :preparation, :quality, \
  :temperature, :chinese
end

