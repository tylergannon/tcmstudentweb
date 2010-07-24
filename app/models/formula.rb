class Formula < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :formula_categories
  acts_as_linkable :name => :pinyin, :title=>:english
  acts_as_cited

  autocomplete_format do |f|
    {:label=>"#{f.pinyin} (#{f.english})", :value=>f.pinyin}
  end

  belongs_to :master_formula, :class_name => "Formula"
  belongs_to :source_text_citation, :class_name => "Citation", :dependent => :destroy
	belongs_to :formula_category

  has_many :variations, :class_name => "Formula", :foreign_key => "master_formula_id"
	has_many :formula_contraindications, :dependent => :destroy
	has_many :formula_dui_yaos, :dependent => :destroy
	has_many :formula_herbs, :dependent => :destroy do
    def with_role(*roles)
      select{|t| roles.include? t.formula_role_id}
    end
    def chief
      with_role(0) unless with_role.size == size
    end
    def non_chief
      self unless chief
      with_role 1,2,3 if chief
    end
  end
	has_many :herbs, :through => :formula_herbs
	has_many :formula_therapeutic_functions, :dependent => :destroy
	has_many :therapeutic_functions, :through => :formula_therapeutic_functions
	has_many :formula_comparisons, :foreign_key => :formula1_id, :dependent => :destroy
	has_many :other_formula_comparisons, :foreign_key => :formula2_id, :class_name => 'FormulaComparison', :dependent => :destroy

  has_and_belongs_to_many :dui_yaos, :autosave => :true, :uniq => true
  has_and_belongs_to_many :patterns, :autosave => :true, :uniq => true

  named_association :master_formula, :name, :class_name => "Formula"

  search_on :canonical, :pinyin
  scope :search_mod, order("char_length(canonical)")

  scope :next_from, lambda {|formula|
    where("formulas.id > #{formula.id}").order("formulas.id").limit(1)
  }

  ROLES = %w[jūn chén zuǒ shǐ]
	validates_presence_of :pinyin
  validates_uniqueness_of :pinyin, :canonical

	accepts_nested_attributes_for :formula_contraindications, :allow_destroy => true, :reject_if => proc {|a| a['contraindication_name'].blank?}
	accepts_nested_attributes_for :formula_herbs, :allow_destroy => true, :reject_if => proc {|a| a['herb_pinyin'].blank?}
  accepts_nested_attributes_for :formula_therapeutic_functions, :allow_destroy => true, :reject_if => proc {|a| a['therapeutic_function_name'].blank?}
	accepts_nested_attributes_for :dui_yaos, :allow_destroy => true
	accepts_nested_attributes_for :formula_comparisons, :allow_destroy => true, :reject_if => proc {|a| a['formula2_pinyin'].blank?}
  accepts_nested_attributes_for :source_text_citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}

  anaf_habtm :patterns, :create=>true, :find=>{:with_name=>:name, :from_text=>{:citation_attributes => :textbook_title}}

  def chiefs
    if formula_herbs.chief.size==formula_herbs.size
      []
    else
      formula_herbs.chief
    end
  end

  def all_comparisons
	  formula_comparisons + other_formula_comparisons
	end

  def pinyin=(p)
    super(p)
    self.canonical = ActiveSupport::Multibyte::Chars.new(p).mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').titleize.to_s
  end

  association_text :formula_therapeutic_functions,
    :name=>:therapeutic_function_name, :commentary=>:commentary, :scope=>:with_tf_name

end

