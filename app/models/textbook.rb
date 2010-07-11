class Textbook < ActiveRecord::Base
  belongs_to :author
  accepts_nested_attributes_for :author, :allow_destroy => false, :reject_if => proc {|a| a['name'].blank?}

  scope :textbook_search, lambda {|name|
    name.downcase!
    includes(:author).where("lower(textbooks.abbrev) like '%#{name}%'
      or lower(textbooks.title) like '%#{name}%'
      or lower(authors.name) like '%#{name}%'")
  }
  
  named_association :author, :name, :create => true
  acts_as_linkable :name=>:title, :title=>:author_name

  search_on :title, :abbrev
  
  def search_result
    "#{title} <i>(#{author.name})</i>"
  end
end

