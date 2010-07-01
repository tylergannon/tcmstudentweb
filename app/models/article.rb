class Article < ActiveRecord::Base
  acts_as_taggable
  default_scope order("created_at DESC")
  def self.search_columns
    ["title"]
  end
  scope :search, lambda{|str|
    like_condition(str)
  }

  def name
    title
  end

end

