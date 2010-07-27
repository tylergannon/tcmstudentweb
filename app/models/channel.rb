class Channel < ActiveRecord::Base
  find_by_name
  has_many :acu_points do
    def with_tf(tf)
      select{|ap|
        ap.acu_point_infos.select{|api|
          api.therapeutic_functions.include? tf
        }.size>0
      }.sort{|x,y| x.ordinal <=> y.ordinal}
    end
  end

  search_on :name, :abbreviation
  autocomplete_format do |channel|
    {:value=>channel.name}
  end
  acts_as_linkable :name => :name

  def each_tag(&block)
    tfs = TherapeuticFunction.by_channel(id)
    tags = tfs.tag_counts_on(:tags)
    tags.each do |tag|
      tf = tfs.tagged_with(tag.name).uniq
      block.call(tag, tf)
    end
  end

  ABBREVS = {"lu" => 1,
              "lung" => 1,
              "l" => 1,
              "li" => 2,
              "st" => 3,
              "s" => 3,
              "sp" => 4,
              "h" => 5,
              "ht" => 5,
              "he" => 5,
              "si" => 6,
              "ub" => 7,
              "bl" => 7,
              "b" => 7,
              "k" => 8,
              "ki" => 8,
              "kd" => 8,
              "p" => 9,
              "pc" => 9,
              "pe" => 9,
              "sj" => 10,
              "tw" => 10,
              "te" => 10,
              "tb" => 10,
              "gb" => 11,
              "lv" => 12,
              "du" => 13,
              "gv" => 13,
              "re" => 14,
              "cv" => 14}
end

