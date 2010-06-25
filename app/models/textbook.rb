class Textbook < ActiveRecord::Base
  belongs_to :author
  accepts_nested_attributes_for :author, :allow_destroy => false, :reject_if => proc {|a| a['name'].blank?}

  scope :textbook_search, lambda {|name|
    name.downcase!
    includes(:author).where("lower(textbooks.abbrev) like '%#{name}%'
      or lower(textbooks.title) like '%#{name}%'
      or lower(authors.name) like '%#{name}%'")
  }

  def author_name
    self.author.name if self.author
  end

  def author_name=(name)
    return if name.nil?
    name = name.strip
    self.author = Author.find_or_create_by_name(name) unless name.blank?
  end

  def self.search_columns
    ["title", "abbrev"]
  end

  def search_result
    "#{title} <i>(#{author.name})</i>"
  end
end

