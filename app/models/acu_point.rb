class AcuPoint < ActiveRecord::Base
  find_by_name
  REGEXP_ABBREV = /^(\w{1,2})[-_ ](\d{1,2})$/
  validates_presence_of :pinyin
  validates_uniqueness_of :pinyin
  validates_uniqueness_of :ordinal, :scope => :channel_id
  default_scope order(:ordinal)
  acts_as_taggable

  scope :tf_tagged_with, lambda {|*tags|
    tf = TherapeuticFunction.tagged_with(tags)
    joins(:acu_point_infos=>:acu_point_therapeutic_functions).
      where(:acu_point_infos=>{:acu_point_therapeutic_functions=>{:therapeutic_function_id=>tf.map_to(:id)}})
  }

  INCLUDE_ALL = [{
              :acu_point_infos=>[
                :symptoms,
                { :therapeutic_functions => :tags,
                  :acu_point_therapeutic_functions=>[
                    {:therapeutic_function=>:tags},
                    :symptoms
                    ],
                  :acu_point_symptoms=>:symptom
                }
              ]
            }]

  acts_as_cited
  acts_as_linkable :name => :display_name, :title => :chinese

  def display_name
    pinyin.empty? ? abbrev : "#{abbrev} #{pinyin}"
  end

  def english
    a = acu_point_infos.where('char_length(english) > 0').first
    a.nil? ? "" : a.english
  end

  belongs_to :channel
  has_many :acu_point_infos, :dependent => :destroy, :autosave => true
  has_many :acu_point_categories, :dependent => :destroy, :autosave => true
  has_many :categories, :through => :acu_point_categories
  has_many :point_prescription_acu_points
  has_many :point_prescriptions, :through => :point_prescription_acu_points

  accepts_nested_attributes_for :acu_point_infos, :allow_destroy => true

  anaf_habtm "point_combinations", :create=>true, :find=>{:with_name=>:name},
    :ar_options =>{ :autosave => true }

  search_on :pinyin, :canonical

  scope :category, lambda {|name|
    a = Category.named(name).try(:id)
    if a
      joins([{:acu_point_categories=>:category}]).
        where(:categories => {:id=>id})
    else
      where('1=0')
    end
  }

  has_many :points_with_similar_names, :class_name=>'AcuPoint', :readonly=>true,
    :finder_sql=>
    "with characters AS (
      select regexp_split_to_table(chinese, E'\\s*') as char
      from acu_points where id=#{id})
    select a.*
    from acu_points a
      inner join characters c
      on position(c.char in a.chinese) is not null
    where a.id <> #{id};"

#  scope :named_like, lambda{|acu_point|
#    chars = acu_point.chinese.chars.to_a
#    where = chars.map{|char| "chinese like '%#{char}%'"}.join(" or ")
#    where(where)
#  }

  scope :join_therapeutic_function, joins([{:acu_point_infos=>{:acu_point_therapeutic_functions=>:therapeutic_function}}])

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
    point
  end

  def pinyin=(p)
    super(p)
    self.canonical = p.normalize.titleize
  end

  association_text :acu_point_categories, :name=>:category_name,
          :commentary => :commentary, :scope=>:with_category_name

  def abbrev=(n)
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

  scope :with_abbrev, lambda {|abbrev|
    abbrev.strip!
    if match = abbrev.to_s.match(REGEXP_ABBREV)
      ch = match[1].downcase
      ord = match[2]
      ch_id = Channel::ABBREVS[ch]
      raise "invalid abbreviation #{abbrev}" unless ord && ch_id
    end
    joins(:channel).where(:channels=>{:id=>ch_id}).where(:ordinal=>ord).limit(1)
  }

  def self.find_by_abbrev(abbrev)
    with_abbrev(abbrev).first
  end
end

