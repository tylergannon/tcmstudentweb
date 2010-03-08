class Formula < ActiveRecord::Base
  ROLES = %w[jūn chén zuǒ shǐ]
	validates_presence_of :formula_category, :pinyin, :english
  validates_uniqueness_of :pinyin, :english
	has_many :formula_contraindications
	accepts_nested_attributes_for :formula_contraindications, :allow_destroy => true, :reject_if => proc {|a| a['contraindication_name'.blank?]}

	has_many :formula_herbs
	has_many :herbs, :through => :formula_herbs
	accepts_nested_attributes_for :formula_herbs, :allow_destroy => true, :reject_if => proc {|a| a['herb_name'.blank?]}

	has_many :formula_pulse_qualities
	has_many :pulse_qualities, :through => :formula_pulse_qualities
	accepts_nested_attributes_for :formula_pulse_qualities, :allow_destroy => true, :reject_if => proc {|a| a['pulse_quality_name'.blank?]}

	has_many :formula_symptoms
	accepts_nested_attributes_for :formula_symptoms, :allow_destroy => true, :reject_if => proc {|a| a['symptom_name'.blank?]}
	has_many :symptoms, :through => :formula_symptoms

	has_many :formula_tongue_qualities
	accepts_nested_attributes_for :formula_tongue_qualities, :allow_destroy => true, :reject_if => proc {|a| a['tongue_quality_name'.blank?]}

	has_many :formula_therapeutic_functions
	accepts_nested_attributes_for :formula_therapeutic_functions, :allow_destroy => true, :reject_if => proc {|a| a['therapeutic_function_name'.blank?]}
	has_many :therapeutic_functions, :through => :formula_therapeutic_functions

	has_many :formula_patterns
	accepts_nested_attributes_for :formula_patterns, :allow_destroy => true, :reject_if => proc {|a| a['pattern_name'.blank?]}

	has_many :formula_dui_yaos
	accepts_nested_attributes_for :formula_dui_yaos, :allow_destroy => true, :reject_if => proc {|a| a['herb1_id'.blank?]}

	has_many :formula_comparisons, :foreign_key => :formula1_id
	accepts_nested_attributes_for :formula_comparisons, :allow_destroy => true, :reject_if => proc {|a| a['formula2_pinyin'.blank?]}

	has_many :other_formula_comparisons, :foreign_key => :formula2_id, :class_name => 'FormulaComparison'

	def all_comparisons
	  formula_comparisons + other_formula_comparisons
	end

	belongs_to :formula_category
	def formula_category_name=(name)
		self.formula_category = FormulaCategory.find_or_create_by_name(name) unless name.blank?
	end

	def formula_category_name
		formula_category.name if formula_category
  end

  def herbs_from(role)
    formula_herbs.select{|a| a.formula_role.pinyin == role}
  end

  def chief_herbs
    herbs_from(Formula::ROLES[0])
  end

  def non_chief_herbs
    herbs_from(Formula::ROLES[1]) + herbs_from(Formula::ROLES[2]) +  herbs_from(Formula::ROLES[3])
  end

  def symptoms
    formula_symptoms.collect{|n| n.symptom_name}
  end
end
