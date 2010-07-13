class Author < ActiveRecord::Base
  has_many :textbooks
  accepts_nested_attributes_for :textbooks, :allow_destroy => false, :reject_if => proc {|a| a['textbook_name'].blank?}
  search_on :name
  autocomplete_format do |a|
    {:value=>a.name}
  end
end

