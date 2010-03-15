class Textbook < ActiveRecord::Base
  belongs_to :author
  accepts_nested_attributes_for :author, :allow_destroy => false, :reject_if => proc {|a| a['name'.blank?]}


  def author_name
    self.author.name if self.author
  end

  def author_name=(name)
    self.author = Author.find_or_create_by_name(name) unless name.blank?
  end

  def search_result
    "#{title} <i>(#{author.name})</i>"
  end
end
