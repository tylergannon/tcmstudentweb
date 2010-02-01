class FormulaDuiYao < ActiveRecord::Base
	belongs_to :formula
	belongs_to :dui_yao
	
	attr_accessor :herb1_pinyin, :herb2_pinyin
	


end
