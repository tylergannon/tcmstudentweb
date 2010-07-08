class Herb < ActiveRecord::Base
  acts_as_cited
  acts_as_taggable_on :flavors, :channels, :categories
  acts_as_taggable
  scope :state_board, lambda{
    tagged_with("State Board")
  }
  
  has_many :dui_yaos, :class_name => "DuiYao", :foreign_key => "herb1_id"
  accepts_nested_attributes_for :dui_yaos, :allow_destroy => true

  has_many :his_dui_yaos, :class_name => "DuiYao", :foreign_key => "herb2_id"
  
  def all_dui_yaos
    DuiYao.with_herb(self)
  end
  
  def f
    herb_therapeutic_functions
  end

  search_on :canonical, :latin, :pinyin, :common_name
  scope :search_mod, order("char_length(canonical)")

  validates_uniqueness_of :pinyin, :canonical
  def key_attributes
    ["id", "pinyin", "english", "canonical", "herb_category_id", "commentary", "common_name", "short_name", "state_board", ]
  end

  belongs_to :herb_category

  has_many :formula_herbs
  has_many :formulas, :through => :formula_herbs

	has_many :herb_therapeutic_functions
	has_many :therapeutic_functions, :through => :herb_therapeutic_functions
	accepts_nested_attributes_for :herb_therapeutic_functions, :allow_destroy => true, :reject_if => proc {|a| a['therapeutic_function_name'].blank?}

	has_many :herb_comparisons, :foreign_key => :herb1_id
	accepts_nested_attributes_for :herb_comparisons, :allow_destroy => true, :reject_if => proc {|a| a['herb2_pinyin'].blank?}

	has_many :other_herb_comparisons, :foreign_key => :herb2_id, :class_name => "HerbComparison"

  belongs_to :citation
  accepts_nested_attributes_for :citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}

  belongs_to :source_text_citation, :class_name => "Citation"
  accepts_nested_attributes_for :source_text_citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}

  def name
    pinyin
  end
  def pinyin=(p)
    super(p)
    self.canonical = ActiveSupport::Multibyte::Chars.new(p).mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').titleize.to_s
  end
  
  def tf(str)
    unless herb_therapeutic_functions.select{|t| t.therapeutic_function_name.downcase==str.downcase}.size > 0
      herb_therapeutic_functions << HerbTherapeuticFunction.create(:therapeutic_function_name=>str)
      self.save
    end
  end

  def english=(name)
    super(name.titleize)
  end

	def display_name
	  latin ? "#{pinyin} #{latin}" : pinyin
	end

	def all_comparisons
		herb_comparisons + other_herb_comparisons
	end
	
	named_association :herb_category, HerbCategory, :name, :create

  def link_name
    pinyin
  end

  def link_title
    english
  end

end

