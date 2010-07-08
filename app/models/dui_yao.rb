class DuiYao < ActiveRecord::Base
	belongs_to :herb1, :foreign_key => "herb1_id", :class_name => "Herb"
	belongs_to :herb2, :foreign_key => "herb2_id", :class_name => "Herb"
	
	has_and_belongs_to_many :formulas, :autosave => true, :uniq => true
	
	named_association :herb1, Herb, :pinyin
	named_association :herb2, Herb, :pinyin

	scope :with_herb, lambda {|herb|
	  if herb.class == Fixnum
	    herb_id = herb
    elsif herb.class == Herb
      herb_id = herb.id
    else
      herb_id = 0
    end
	  params = {:herb1_id=>herb_id, :herb2_id=>herb_id}
    where(["herb1_id = :herb1_id or herb2_id = :herb2_id", params])
	}
	
	def other_herb(herb)
	  if herb.id == herb1_id
	    herb2
    else
      herb1
    end
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
