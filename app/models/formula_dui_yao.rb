class FormulaDuiYao < ActiveRecord::Base
	belongs_to :formula
	belongs_to :herb1, :class_name => "Herb", :foreign_key => "herb1_id"
	belongs_to :herb2, :class_name => "Herb", :foreign_key => "herb2_id"
  belongs_to :dui_yao


	def herb1_pinyin=(pinyin)
		self.herb1 = Herb.search_equals(pinyin) unless pinyin.blank?
	end

	def herb1_pinyin
		herb1.pinyin if herb1
	end

  def herb2_pinyin=(pinyin)
  	self.herb2 = Herb.search_equals(pinyin) unless pinyin.blank?
  end

  def herb2_pinyin
  	herb2.pinyin if herb2
  end
end
