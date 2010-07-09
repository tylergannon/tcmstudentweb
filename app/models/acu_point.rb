class AcuPoint < ActiveRecord::Base
  REGEXP_ABBREV = /^(\w{1,2})[-_ ](\d{1,2})$/
  validates_presence_of :pinyin
  validates_uniqueness_of :pinyin
  validates_uniqueness_of :ordinal, :scope => :channel_id
  acts_as_taggable

  acts_as_cited

  belongs_to :channel
  has_many :acu_point_infos
  has_many :acu_point_categories, :dependent => :destroy, :autosave => true
  has_many :categories, :through => :acu_point_categories
  has_many :point_prescription_acu_points
  has_many :point_prescriptions, :through => :point_prescription_acu_points
  
  search_on :pinyin, :canonical
  
  scope :category, lambda {|name|
    a = AcuPointCategory.named(name)
    joins(:acu_point_categories).where(:acu_point_categories => {:id => a.id})
  }


  def self.search(str)
    str.strip!
    point = nil
    if /^\d+$/.match(str)
      point = find(str)
    else
      if REGEXP_ABBREV.match(str)
        point = self.find_by_abbrev(str)
      else
        point = self.find_by_canonical(str.gsub(/[\+_-]/, " ").gsub(//, " ").downcase)
      end
    end
    puts "Unable to find point \"#{str}\"" unless point
    point
  end

  accepts_nested_attributes_for :acu_point_infos, :allow_destroy => true

  def display_name
    pinyin.empty? ? abbrev : "#{abbrev} #{pinyin}"
  end

  def pinyin=(p)
    super(p)
    self.canonical = p.normalize.titleize
  end

  def acu_point_categories_text=(text)
    puts text
    items = StringReader.new.read_items(text) do |item, comment|
      puts item
      puts comment
      AcuPointCategory.new(:commentary => comment, :category_name => item)
    end
    puts items.inspect
    self.acu_point_categories=(items)
  end

  def acu_point_categories_text
    a = StringReader.new
    a.write_items(acu_point_categories) do |cat|
      [cat.category_name, cat.commentary]
    end
  end

  def name
    display_name
  end


  def abbrev
    if channel.id == 15
      pinyin
    else
      "#{channel.abbreviation}-#{ordinal}"
    end
  end

  def self.named(str)
    str.strip!
    if str.match(REGEXP_ABBREV)
      find_by_abbrev(str)
    else
      super(str)
    end
  end

  def self.find_by_abbrev(abbrev)
    abbrev.strip!
    if match = abbrev.to_s.match(REGEXP_ABBREV)
      ch = match[1].downcase
      ord = match[2]
      if Channel::ABBREVS.has_key?(ch)
        find_by_channel_id_and_ordinal(Channel::ABBREVS[ch], ord)
      end
    end
  end
end


