class Formula < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :formula_categories

  acts_as_cited

  belongs_to :master_formula, :class_name => "Formula"
  belongs_to :source_text_citation, :class_name => "Citation", :dependent => :destroy
	belongs_to :formula_category
  belongs_to :citation, :dependent => :destroy

  has_many :variations, :class_name => "Formula", :foreign_key => "master_formula_id"
	has_many :formula_contraindications, :dependent => :destroy
	has_many :formula_dui_yaos, :dependent => :destroy
	has_many :formula_herbs, :dependent => :destroy
	has_many :herbs, :through => :formula_herbs
	has_many :formula_therapeutic_functions, :dependent => :destroy
	has_many :therapeutic_functions, :through => :formula_therapeutic_functions
	has_many :formula_patterns, :dependent => :destroy
	has_many :patterns, :through => :formula_patterns
	has_many :formula_comparisons, :foreign_key => :formula1_id, :dependent => :destroy
	has_many :other_formula_comparisons, :foreign_key => :formula2_id, :class_name => 'FormulaComparison', :dependent => :destroy
  
  has_and_belongs_to_many :dui_yaos, :autosave => :true, :uniq => true
  
  named_association :master_formula, Formula, :name

  search_on :canonical, :english, :pinyin
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
	accepts_nested_attributes_for :formula_patterns, :allow_destroy => true
	accepts_nested_attributes_for :dui_yaos, :allow_destroy => true
	accepts_nested_attributes_for :formula_comparisons, :allow_destroy => true, :reject_if => proc {|a| a['formula2_pinyin'].blank?}
  accepts_nested_attributes_for :citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}
  accepts_nested_attributes_for :source_text_citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}


  def all_comparisons
	  formula_comparisons + other_formula_comparisons
	end

  def herbs_from(role)
    formula_herbs.select{|a| a.formula_role.pinyin == role}
  end

  def chief_herbs
    a = herbs_from(Formula::ROLES[0])
    a unless a.size == formula_herbs.size
  end

  def non_chief_herbs
    herbs_from(Formula::ROLES[1]) + herbs_from(Formula::ROLES[2]) +  herbs_from(Formula::ROLES[3])
  end

  def name
    pinyin
  end

  def pinyin=(p)
    super(p)
    self.canonical = p.normalize.titleize
  end

  def formula_therapeutic_functions_text
    FormParser.unparse_therapeutic_functions(formula_therapeutic_functions)
  end

  def formula_therapeutic_functions_text=(text)
    new_ps = FormParser.parse_therapeutic_functions(text, FormulaTherapeuticFunction)
    FormParser.merge(self.formula_therapeutic_functions, new_ps)
  end

  def formula_symptoms_text
    FormParser.unparse_symptoms(formula_symptoms)
  end

  def formula_symptoms_text=(text)
    new_ps = FormParser.parse_symptoms(text, FormulaSymptom)
    FormParser.merge(self.formula_symptoms, new_ps)
  end

  def link_name
    pinyin
  end

  def link_title
    english
  end

end


