class AcuPoint < ActiveRecord::Base
  validates_presence_of :pinyin
  validates_uniqueness_of :pinyin
  validates_uniqueness_of :ordinal, :scope => :channel_id
  belongs_to :channel

  has_many :acu_point_infos
  accepts_nested_attributes_for :acu_point_infos, :allow_destroy => true

  def display_name
    "#{channel.abbreviation}-#{ordinal} #{pinyin}"
  end

  def pinyin=(p)
    super(p)
    self.canonical = p.normalize.titleize
  end

  has_many :point_prescription_acu_points
  has_many :point_prescriptions, :through => :point_prescription_acu_points

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
