class Citation < ActiveRecord::Base
  belongs_to :textbook
  accepts_nested_attributes_for :textbook, :allow_destroy => false, :reject_if => proc {|a| a['title'].blank?}


  def textbook_title
    textbook.title if textbook
  end

  def textbook_title=(title)
    return if title.nil?
    title = title.strip.titleize
    self.textbook = Textbook.find_or_create_by_title(title) unless title.empty?
  end
end

