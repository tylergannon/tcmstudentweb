class Pattern < ActiveRecord::Base
  acts_as_taggable
  scope :bensky, joins(:citation).where("citations.textbook_id = 2")

  has_many :pattern_treatment_principles
  accepts_nested_attributes_for :pattern_treatment_principles, :allow_destroy => true, \
    :reject_if => proc {|a| a['treatment_principle_name'].blank?}
  has_many :pattern_symptoms

  def symptoms
    pattern_symptoms.map{|t| t.symptom}
  end

  accepts_nested_attributes_for :pattern_symptoms, :allow_destroy => true, \
    :reject_if => proc {|a| a['symptom_name'].blank?}

  has_many :point_prescriptions
  accepts_nested_attributes_for :point_prescriptions, :allow_destroy => false

  has_many :formula_patterns
  def formulas
    formula_patterns.map{|t| t.formula}
  end
  accepts_nested_attributes_for :formula_patterns, :allow_destroy => true, :reject_if => proc {|a| a['formula_pinyin'].blank?}

  belongs_to :citation
  accepts_nested_attributes_for :citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}

  def pattern_formulas
    formula_patterns
  end

  def pattern_formulas=(pf)
    self.formula_patterns = pf unless pf.nil?
  end


  def pattern_symptoms_text
    FormParser.unparse_symptoms(self.pattern_symptoms)
  end

  def pattern_symptoms_text=(text)
    new_ps = FormParser.parse_symptoms(text, PatternSymptom)
    FormParser.merge(self.pattern_symptoms, new_ps)
  end

  def pattern_treatment_principles_text
    FormParser.unparse_therapeutic_functions(self.pattern_treatment_principles)
  end

  def pattern_treatment_principles_text=(text)
    new_ps = FormParser.parse_therapeutic_functions(text, PatternTreatmentPrinciple)
    FormParser.merge(self.pattern_treatment_principles, new_ps)
  end

  def key_symptoms
    self.pattern_symptoms.select{|x| x.key_symptom}
  end

  def key_attributes
    ["name", "id", "pattern_symptoms_text", "pattern_treatment_principles_text", "commentary"]
  end

  def link_name
    name
  end

  def self.search_columns
    ["name"]
  end

  def compare(him)

    mine = self.pattern_symptoms.map{|x| x.symptom.name}
    his = him.pattern_symptoms.map{|x| x.symptom.name}

    just_mine = mine.select{|x| !his.include?(x)}
    just_his = his.select{|x| !mine.include?(x)}
    shared = mine.select{|x| his.include?(x)}
    {:shared => shared, :just_his => just_his, :just_mine => just_mine}
  end
end

