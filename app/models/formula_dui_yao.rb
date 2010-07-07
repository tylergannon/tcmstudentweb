class FormulaDuiYao < ActiveRecord::Base
	belongs_to :formula
	belongs_to :herb1, :class_name => "Herb", :foreign_key => "herb1_id"
	belongs_to :herb2, :class_name => "Herb", :foreign_key => "herb2_id"
  belongs_to :dui_yao

	named_association :herb1, Herb, :pinyin
	named_association :herb2, Herb, :pinyin
end
