class Citation < ActiveRecord::Base
  belongs_to :textbook
  accepts_nested_attributes_for :textbook, :allow_destroy => false, :reject_if => proc {|a| a['title'].blank?}
  
  acts_as_linkable :name => :link_name, :title=> :link_title
  
  def link_name
    "#{textbook_title}, #{where}"
  end
  
  def link_title
    "#{textbook.author.name unless textbook.author.nil?}"
  end

  def textbook_title
    textbook.title if textbook
  end

  def textbook_title=(title)
    return if title.nil?
    title = title.strip.titleize
    self.textbook = Textbook.find_or_create_by_title(title) unless title.empty?
  end
end

