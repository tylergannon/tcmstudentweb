class Author < ActiveRecord::Base
  has_many :textbooks
  accepts_nested_attributes_for :textbooks, :allow_destroy => false, :reject_if => proc {|a| a['textbook_name'].blank?}
  scope :search, lambda{|str|
    like_condition(str)
  }

end
