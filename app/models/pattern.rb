class Pattern < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :diseases, :primary_patterns
  acts_as_cited
  acts_as_linkable :name=>:name

  def save_and_next
    save
    order(:id).limit(1).where("id > #{id}")
  end
  autocomplete_format do |pattern|
    lbl = pattern.name
    lbl += " #{pattern.citation.textbook_title}" if pattern.citation
    {:value=>pattern.name, :label=>lbl}
  end

  def set(organ, patterns)
    tag_list << organ
    patterns.each {|p| primary_pattern_list << p}
  end

  search_on :name
  scope :search_mod, order("char_length(name)")

  has_and_belongs_to_many :therapeutic_functions
  has_and_belongs_to_many :formulas, :autosave => :true, :uniq => true

  has_many :pattern_symptoms, :dependent => :destroy
  has_many :symptoms, :through => :pattern_symptoms
  has_many :point_prescriptions

  def key_pattern_symptoms
    pattern_symptoms.where(:key_symptom => true)
  end

  anaf_habtm :formulas, :find=> {:with_name => :pinyin}

  accepts_nested_attributes_for :pattern_symptoms, :allow_destroy => true, \
    :reject_if => proc {|a| a['symptom_name'].blank?}
#	accepts_nested_attributes_for :formulas, :allow_destroy => true
  accepts_nested_attributes_for :point_prescriptions, :allow_destroy => true
  accepts_nested_attributes_for :citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}

  association_text :pattern_symptoms, :name=>:symptom_name,
    :commentary => :commentary, :scope=>:with_symptom_name

  association_text :therapeutic_functions, :name=>:name, :scope=>:with_name

  def key_symptoms
    self.pattern_symptoms.where(:key_symptom => true)
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

