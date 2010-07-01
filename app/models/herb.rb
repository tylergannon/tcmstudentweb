class Herb < ActiveRecord::Base
  default_scope :order => 'canonical'
  acts_as_cited
  acts_as_taggable_on :flavors, :channels, :categories

  scope :search, lambda{|str|
    like_condition(str).order("char_length(canonical)")
  }

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
    self.canonical = p.normalize.titleize unless p.nil?
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

	def herb_category_name=(name)
		self.herb_category = HerbCategory.find_or_create_by_name(name) unless name.blank?
	end

	def herb_category_name
		herb_category.name if herb_category
  end

  def link_name
    pinyin
  end

  def link_title
    english
  end

  def self.search_columns
    ["canonical", "latin", "pinyin", "common_name"]
  end
end

