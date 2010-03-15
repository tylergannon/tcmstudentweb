


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

end
