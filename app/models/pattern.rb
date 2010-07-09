class Pattern < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :diseases, :primary_patterns  
  acts_as_cited

  def save_and_next
    save
    order(:id).limit(1).where("id > #{id}")
  end
  
  def set(organ, patterns)
    tag_list << organ
    patterns.each {|p| primary_pattern_list << p}
  end

  search_on :name
  scope :search_mod, order("char_length(name)")

  has_many :pattern_treatment_principles, :dependent => :destroy
  accepts_nested_attributes_for :pattern_treatment_principles, :allow_destroy => true, \
    :reject_if => proc {|a| a['treatment_principle_name'].blank?}
  has_many :pattern_symptoms, :dependent => :destroy

  has_many :symptoms, :through => :pattern_symptoms
  def key_pattern_symptoms
    pattern_symptoms.where(:key_symptom => true)
  end

  accepts_nested_attributes_for :pattern_symptoms, :allow_destroy => true, \
    :reject_if => proc {|a| a['symptom_name'].blank?}

  has_many :point_prescriptions
  accepts_nested_attributes_for :point_prescriptions, :allow_destroy => true

  has_many :formula_patterns, :dependent => :destroy
  has_many :formulas, :through => :formula_patterns
  
  accepts_nested_attributes_for :formula_patterns, :allow_destroy => true, :reject_if => proc {|a| a['formula_pinyin'].blank?}

  belongs_to :citation, :dependent => :destroy
  accepts_nested_attributes_for :citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}

  def pattern_formulas
    formula_patterns
  end

  def pattern_formulas=(pf)
    self.formula_patterns = pf unless pf.nil?
  end

  def pattern_symptoms_text
    StringReader.new.write_items(pattern_symptoms) do |ps|
      [StringReader.decorate_symptom(ps), ps.commentary]
    end
  end

  def pattern_symptoms_text=(text)
    return if text.strip.empty?
    self.pattern_symptoms = StringReader.new.read_items(text) do |symptom, comment|
      ps = PatternSymptom.new(:commentary => comment)
      StringReader.parse_symptom(ps, symptom)
      ps
    end
  end

  def pattern_treatment_principles_text
    StringReader.new.write_items(pattern_treatment_principles) do |ps|
      [ps.treatment_principle_name, ps.commentary]
    end
  end

  def pattern_treatment_principles_text=(text)
    return if text.empty?
    self.pattern_treatment_principles = StringReader.new.read_items(text) do |tp, commentary|
      PatternTreatmentPrinciple.new(:treatment_principle_name => tp, :commentary => commentary)
    end
  end

  def key_symptoms
    self.pattern_symptoms.where(:key_symptom => true)
  end

  def key_attributes
    ["name", "id", "pattern_symptoms_text", "pattern_treatment_principles_text", "commentary"]
  end

  def link_name
    name
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

