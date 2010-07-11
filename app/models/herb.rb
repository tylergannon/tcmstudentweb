class Herb < ActiveRecord::Base
  acts_as_cited
  acts_as_taggable_on :flavors, :channels, :categories
  acts_as_taggable
  acts_as_linkable :name => :pinyin, :title=>:latin
  
  search_on :canonical, :latin, :pinyin, :common_name
  scope :search_mod, order("char_length(canonical)")
  scope :state_board, lambda{
    tagged_with("State Board")
  }

  validates_uniqueness_of :pinyin, :canonical

  has_many :dui_yaos, :class_name => "DuiYao", :foreign_key => "herb1_id"
  has_many :his_dui_yaos, :class_name => "DuiYao", :foreign_key => "herb2_id"
  has_many :formula_herbs
  has_many :formulas, :through => :formula_herbs
	has_many :herb_therapeutic_functions
	has_many :therapeutic_functions, :through => :herb_therapeutic_functions
	has_many :herb_comparisons, :foreign_key => :herb1_id
	has_many :other_herb_comparisons, :foreign_key => :herb2_id, :class_name => "HerbComparison"

	named_association :herb_category, :name, :create => true

  belongs_to :source_text_citation, :class_name => "Citation"
  belongs_to :herb_category

  accepts_nested_attributes_for :source_text_citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}
	accepts_nested_attributes_for :herb_comparisons, :allow_destroy => true, :reject_if => proc {|a| a['herb2_pinyin'].blank?}
	accepts_nested_attributes_for :herb_therapeutic_functions, :allow_destroy => true, :reject_if => proc {|a| a['therapeutic_function_name'].blank?}
  accepts_nested_attributes_for :dui_yaos, :allow_destroy => true

  def pinyin=(p)
    super(p)
    self.canonical = ActiveSupport::Multibyte::Chars.new(p).mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').titleize.to_s
  end
  
  def all_dui_yaos
    DuiYao.with_herb(self)
  end
  
  def f
    herb_therapeutic_functions
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
end

