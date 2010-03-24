class AcuPoint < ActiveRecord::Base
  validates_presence_of :pinyin
  validates_uniqueness_of :pinyin, :english
  validates_uniqueness_of :ordinal, :scope => :channel_id
  belongs_to :channel
  has_many :acu_point_therapeutic_functions
  accepts_nested_attributes_for :acu_point_therapeutic_functions, :allow_destroy => true, :reject_if => proc {|a| a['therapeutic_function_name'.blank?]}

  has_many :acu_point_symptoms
  accepts_nested_attributes_for :acu_point_symptoms, :allow_destroy => true, :reject_if => proc {|a| a['symptom_name'.blank?]}

  belongs_to :citation

  def display_name
    "#{channel.abbreviation}-#{ordinal} #{pinyin}"
  end

  def pinyin=(p)
    super(p)
    self.canonical = p.normalize.titleize
  end

  def acu_point_symptoms_text
    FormParser.unparse_symptoms(acu_point_symptoms)
  end

  def acu_point_symptoms_text=(text)
    new_ps = FormParser.parse_symptoms(text, AcuPointSymptom)
    FormParser.merge(self.acu_point_symptoms, new_ps)
  end

  def acu_point_therapeutic_functions_text
    FormParser.unparse_therapeutic_functions(acu_point_therapeutic_functions)
  end

  def acu_point_therapeutic_functions_text=(text)
    new_ps = FormParser.parse_therapeutic_functions(text, AcuPointTherapeuticFunction)
    FormParser.merge(self.acu_point_therapeutic_functions, new_ps)
  end

  def abbrev
    "#{channel.abbreviation}-#{ordinal}"
  end

  def self.find_by_abbrev(abbrev)
    if match = abbrev.to_s.match(/(\w{1,2})[-_ ](\d{1,2})/)
      ch = match[1].downcase
      ord = match[2]
      if Channel::ABBREVS.has_key?(ch)
        find(:first, :conditions => ["channel_id = ? AND ordinal = ?", Channel::ABBREVS[ch], ord ])
      end
    end
  end
end
