class HerbComparison < ActiveRecord::Base
	belongs_to :herb1, :foreign_key => "herb1_id", :class_name => "Herb"
	belongs_to :herb2, :foreign_key => "herb2_id", :class_name => "Herb"
	
	def herb1_pinyin=(pinyin)
		self.herb1 = Herb.find_or_create_by_pinyin(pinyin) unless pinyin.blank?
	end
	
	def herb1_pinyin
		herb1.pinyin if herb1
	end
	
	def herb2_pinyin=(pinyin)
		self.herb2 = Herb.find_or_create_by_pinyin(pinyin) unless pinyin.blank?
	end
	
	def herb2_pinyin
		herb2.pinyin if herb2
	end
	
	def self.with_herb(herb)
	  find(:all, :conditions => ["herb1_id = ? or herb2_id = ? or herb3_id = ?", herb.id, herb.id, herb.id])
	end
end


