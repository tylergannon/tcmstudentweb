class FormulaHerb < ActiveRecord::Base
  belongs_to :formula
  belongs_to :herb
  belongs_to :formula_role
  belongs_to :herb_preparation, :foreign_key => :preparation_id

  def preparation_name
    self.herb_preparation.name if herb_preparation
  end

  def preparation_name=(name)
    self.herb_preparation = HerbPreparation.find_or_create_by_name(name) unless name.empty?
  end

  default_scope order("position")
	scope :with_role, lambda{|*roles|
	  where :formula_role_id=>roles
	}

	scope :chief, lambda{
	  with_role 0
	}

	scope :non_chief, lambda{
	  with_role 1..3
	}


	def herb_pinyin=(pinyin)
    return if pinyin.blank?
    a = Herb.named(pinyin)
    raise "Could not find herb #{pinyin}" unless a
    self.herb = a
	end

	def herb_pinyin
		herb.pinyin if herb
	end

	def formula_role_pinyin=(pinyin)
		self.formula_role = FormulaRole.find_or_create_by_pinyin(pinyin) unless pinyin.blank?
	end

	def formula_role_pinyin
		formula_role.pinyin if formula_role
	end
end

