class AcuPoint < ActiveRecord::Base
  REGEXP_ABBREV = /^(\w{1,2})[-_ ](\d{1,2})$/
  validates_presence_of :pinyin
  validates_uniqueness_of :pinyin
  validates_uniqueness_of :ordinal, :scope => :channel_id
  belongs_to :channel

  def self.search(str)
    str.strip!
    if /^\d+$/.match(str)
      find(str)
    else
      if REGEXP_ABBREV.match(str)
        self.find_by_abbrev(str)
      else
        self.find_by_canonical(str.gsub(/[\+_-]/, " ").gsub(//, " ").downcase)
      end
    end
  end

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
    abbrev.strip!
    if match = abbrev.to_s.match(REGEXP_ABBREV)
      ch = match[1].downcase
      ord = match[2]
      if Channel::ABBREVS.has_key?(ch)
        find(:first, :conditions => ["channel_id = ? AND ordinal = ?", Channel::ABBREVS[ch], ord ])
      end
    end
  end
end
