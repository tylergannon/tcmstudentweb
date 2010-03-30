class HerbCategory < ActiveRecord::Base
	has_many :herbs
  belongs_to :parent_category, :class_name => "HerbCategory"

  def parent_category_name=(name)
  	self.parent_category = HerbCategory.find_or_create_by_name(name) unless name.blank?
  end

  def parent_category_name
  	parent_category.name if parent_category
  end
end
