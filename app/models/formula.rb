class Formula < ActiveRecord::Base
	
	has_many :formula_contraindications
	accepts_nested_attributes_for :formula_contraindications, :reject_if => proc {|a| a['contraindication_name'.blank?]}
	
	has_many :formula_herbs
	has_many :herbs, :through => :formula_herbs
	accepts_nested_attributes_for :formula_herbs, :reject_if => proc {|a| a['herb_name'.blank?]}
	
	has_many :formula_pulse_qualities
	has_many :pulse_qualities, :through => :formula_pulse_qualities
	accepts_nested_attributes_for :formula_pulse_qualities, :reject_if => proc {|a| a['pulse_quality_name'.blank?]}
	
	has_many :formula_symptoms
	accepts_nested_attributes_for :formula_symptoms, :reject_if => proc {|a| a['symptom_name'.blank?]}
	has_many :symptoms, :through => :formula_symptoms
	
	has_many :formula_tongue_qualities
	accepts_nested_attributes_for :formula_tongue_qualities, :reject_if => proc {|a| a['tongue_quality_name'.blank?]}
	
	has_many :formula_therapeutic_functions
	accepts_nested_attributes_for :formula_therapeutic_functions, :reject_if => proc {|a| a['therapeutic_function_name'.blank?]}
	has_many :therapeutic_functions, :through => :formula_therapeutic_functions
	
	has_many :formula_patterns
	accepts_nested_attributes_for :formula_patterns, :reject_if => proc {|a| a['pattern_name'.blank?]}
	
	has_many :formula_dui_yaos
	accepts_nested_attributes_for :formula_dui_yaos, :reject_if => proc {|a| a['herb1_id'.blank?]}
	
	belongs_to :formula_category
	def formula_category_name=(name)
		self.formula_category = FormulaCategory.find_or_create_by_name(name) unless name.blank?
	end
	
	def formula_category_name
		formula_category.name if formula_category
	end
end
