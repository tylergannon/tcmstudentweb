class Category < ActiveRecord::Base
  has_many :acu_point_categories, :dependent => :destroy
  has_many :acu_points, :through => :acu_point_categories
  search_on :name
  acts_as_linkable :name => :name
end

