class Article < ActiveRecord::Base
  acts_as_taggable
  default_scope order("created_at DESC")
  search_on :title
  acts_as_linkable :name => :title

end

