class Pattern < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :diseases, :primary_patterns
  acts_as_cited
  acts_as_linkable :name=>:name

  @scope_specs = nil

  def formulas
    logger.error "OK..."
    super
  end


  def self.scope_spec
    @scope_specs
  end
  def self.scope_spec=(scope_spect)
    @scope_specs = scope_spect
  end

  # e.g.: [{:where=>{:id=>1}},
  #        {:where=>{:citation=>{:textbook_id=>20}}},
  #        {:where=>"name like '%Liver Qi%'"}]
  #    [:equals, "id", 1, 3, 5, 6]
  #    [:like, "name", "Liver Qi", "Spleen-Qi"]
  #    [:scope, "from_text_id", 20]
  scope :filter, lambda{
    return where('1=1') if @scope_specs.nil?
    relation = self
    @scope_specs.each do |scope_def|
      scope_type, spec, args = scope_def[0].to_sym, scope_def[1], scope_def[2..scope_def.size-1]
      raise ArgumentError.new "Something's wrong" if spec.size > 50

      relation = case scope_type
        when :equals
          relation.where(spec=>args)
        when :like
          sql = args.map{|t| "\"#{self.name.tableize}\".\"#{spec}\" ilike ?"}.join(" and ")
          relation.where([sql, *args.map{|a| "%#{a}%"}])
        when :scope
          relation.scopes[spec].call(*args)
        when :order
          relation.order(args[0].to_sym)
        else raise "I can't handle this scope spec: #{scope_def.inspect}"
      end # switch
    end # scopes.each
    relation
  }


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

  has_many :pattern_symptoms, :dependent => :destroy do
    def key
      select{|t| t.key_symptom}
    end
  end
  has_many :symptoms, :through => :pattern_symptoms
  has_many :point_prescriptions

  anaf_habtm :formulas, :find=> {:with_name => :pinyin}

  accepts_nested_attributes_for :pattern_symptoms, :allow_destroy => true, \
    :reject_if => proc {|a| a['symptom_name'].blank?}
#	accepts_nested_attributes_for :formulas, :allow_destroy => true
  accepts_nested_attributes_for :point_prescriptions, :allow_destroy => true
  accepts_nested_attributes_for :citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}

  association_text :pattern_symptoms, :name=>:symptom_name,
    :commentary => :commentary, :scope=>:with_symptom_name

  association_text :therapeutic_functions, :name=>:name, :scope=>:with_name

  def next_from(pattern)
    where("id > #{pattern.id}").order(:id).limit(1).first
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

