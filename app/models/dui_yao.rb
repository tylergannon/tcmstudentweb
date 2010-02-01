class DuiYao < ActiveRecord::Base
	belongs_to :herb1, :foreign_key => "herb1_id", :class_name => "Herb"
	belongs_to :herb2, :foreign_key => "herb2_id", :class_name => "Herb"
	
	has_many :formula_dui_yaos
	
	def self.with_herb(herb)
	  DuiYao.find(:first, :conditions => ["herb1_id = ? or herb2_id = ?", herb.id, herb.id])
	end
	
	def self.find_or_create_by_herbs_pinyin(herb1_pinyin, herb2_pinyin)
	  herb1 = Herb.find_or_create_by_pinyin(herb1_pinyin)
		herb2 = Herb.find_or_create_by_pinyin(herb2_pinyin)
		dui_yao = DuiYao.find(:first, :conditions => ['herb1_id = ? and herb2_id = ?', herb1.id, herb2.id])
		unless dui_yao
			dui_yao = DuiYao.new(:herb1 => herb1, :herb2 => herb2) unless dui_yao
			dui_yao.save
		end
		dui_yao
	end
end
